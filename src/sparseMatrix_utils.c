/****************************************************************************
 *             Some summarization methods for dgCMatrix objects             *
 ****************************************************************************/
#include "sparseMatrix_utils.h"


/****************************************************************************
 * colMins(), colMaxs(), colRanges()
 */

typedef double (*Extremum_FUNType)(const double *x, int x_len, int narm,
				   int start_on_zero);

static double min_double(const double *x, int x_len, int narm,
			 int start_on_zero)
{
	double min, x_elt;
	int min_is_NaN, i;

	min = start_on_zero ? 0.0 : R_PosInf;
	min_is_NaN = 0;
	for (i = 0; i < x_len; i++) {
		x_elt = x[i];
		if (R_IsNA(x_elt)) {
			if (narm)
				continue;
			return NA_REAL;
		}
		if (min_is_NaN)
			continue;
		if (R_IsNaN(x_elt)) {
			if (narm)
				continue;
			min = x_elt;
			min_is_NaN = 1;
			continue;
		}
		if (x_elt < min)
			min = x_elt;
	}
	return min;
}

static double max_double(const double *x, int x_len, int narm,
			 int start_on_zero)
{
	double max, x_elt;
	int max_is_NaN, i;

	max = start_on_zero ? 0.0 : R_NegInf;
	max_is_NaN = 0;
	for (i = 0; i < x_len; i++) {
		x_elt = x[i];
		if (R_IsNA(x_elt)) {
			if (narm)
				continue;
			return NA_REAL;
		}
		if (max_is_NaN)
			continue;
		if (R_IsNaN(x_elt)) {
			if (narm)
				continue;
			max = x_elt;
			max_is_NaN = 1;
			continue;
		}
		if (x_elt > max)
			max = x_elt;
	}
	return max;
}

static void minmax_double(const double *x, int x_len, int narm,
			  int start_on_zero, double *min, double *max)
{
	double tmp_min, tmp_max, x_elt;
	int minmax_is_NaN, i;

	if (start_on_zero) {
		tmp_min = tmp_max = 0.0;
	} else {
		tmp_min = R_PosInf;
		tmp_max = R_NegInf;
	}
	minmax_is_NaN = 0;
	for (i = 0; i < x_len; i++) {
		x_elt = x[i];
		if (R_IsNA(x_elt)) {
			if (narm)
				continue;
			*min = *max = NA_REAL;
			return;
		}
		if (minmax_is_NaN)
			continue;
		if (R_IsNaN(x_elt)) {
			if (narm)
				continue;
			tmp_min = tmp_max = x_elt;
			minmax_is_NaN = 1;
			continue;
		}
		if (x_elt < tmp_min)
			tmp_min = x_elt;
		if (x_elt > tmp_max)
			tmp_max = x_elt;
	}
	*min = tmp_min;
	*max = tmp_max;
	return;
}

static SEXP C_colExtrema_dgCMatrix(Extremum_FUNType extremum_FUN,
		SEXP x, SEXP na_rm)
{
	SEXP x_Dim, x_x, x_p, ans;
	int x_nrow, x_ncol, narm, j, offset, count;

	x_Dim = GET_SLOT(x, install("Dim"));
	x_nrow = INTEGER(x_Dim)[0];
	x_ncol = INTEGER(x_Dim)[1];
	x_x = GET_SLOT(x, install("x"));
	x_p = GET_SLOT(x, install("p"));
	narm = LOGICAL(na_rm)[0];

	ans = PROTECT(NEW_NUMERIC(x_ncol));
	for (j = 0; j < x_ncol; j++) {
		offset = INTEGER(x_p)[j];
		count = INTEGER(x_p)[j + 1] - offset;
		REAL(ans)[j] = extremum_FUN(REAL(x_x) + offset, count, narm,
					    count < x_nrow);
	}
	UNPROTECT(1);
	return ans;
}

/* --- .Call ENTRY POINT --- */
SEXP C_colMins_dgCMatrix(SEXP x, SEXP na_rm)
{
	return C_colExtrema_dgCMatrix(min_double, x, na_rm);
}

/* --- .Call ENTRY POINT --- */
SEXP C_colMaxs_dgCMatrix(SEXP x, SEXP na_rm)
{
	return C_colExtrema_dgCMatrix(max_double, x, na_rm);
}

/* --- .Call ENTRY POINT --- */
SEXP C_colRanges_dgCMatrix(SEXP x, SEXP na_rm)
{
	SEXP x_Dim, x_x, x_p, ans;
	int x_nrow, x_ncol, narm, j, offset, count;

	x_Dim = GET_SLOT(x, install("Dim"));
	x_nrow = INTEGER(x_Dim)[0];
	x_ncol = INTEGER(x_Dim)[1];
	x_x = GET_SLOT(x, install("x"));
	x_p = GET_SLOT(x, install("p"));
	narm = LOGICAL(na_rm)[0];

	ans = PROTECT(allocMatrix(REALSXP, x_ncol, 2));
	for (j = 0; j < x_ncol; j++) {
		offset = INTEGER(x_p)[j];
		count = INTEGER(x_p)[j + 1] - offset;
		minmax_double(REAL(x_x) + offset, count, narm,
			      count < x_nrow,
			      REAL(ans) + j, REAL(ans) + x_ncol + j);
	}
	UNPROTECT(1);
	return ans;
}


/****************************************************************************
 * colVars()
 */

static double col_sum(const double *x, int x_len, int nrow, int narm,
		      int *sample_size)
{
	double xi, sum;
	int i;

	*sample_size = nrow;
	sum = 0.0;
	for (i = 0; i < x_len; i++) {
		xi = x[i];
		/* ISNAN(): True for *both* NA and NaN. See <R_ext/Arith.h> */
		if (narm && ISNAN(xi)) {
			(*sample_size)--;
			continue;
		}
		sum += xi;
	}
	return sum;
}

static double col_var(const double *x, int x_len, int nrow, int narm)
{
	double xi, sum, mean, sigma, delta;
	int sample_size, i;

	sum = col_sum(x, x_len, nrow, narm, &sample_size);
	mean = sum / (double) sample_size;
	sigma = mean * mean * (nrow - x_len);
	for (i = 0; i < x_len; i++) {
		xi = x[i];
		if (narm && ISNAN(xi))
			continue;
		delta = xi - mean;
		sigma += delta * delta;
	}
	return sigma / (sample_size - 1.0);
}

/* --- .Call ENTRY POINT --- */
SEXP C_colVars_dgCMatrix(SEXP x, SEXP na_rm)
{
	SEXP x_Dim, x_x, x_p, ans;
	int x_nrow, x_ncol, narm, j, offset, count;

	x_Dim = GET_SLOT(x, install("Dim"));
	x_nrow = INTEGER(x_Dim)[0];
	x_ncol = INTEGER(x_Dim)[1];
	x_x = GET_SLOT(x, install("x"));
	x_p = GET_SLOT(x, install("p"));
	narm = LOGICAL(na_rm)[0];

	ans = PROTECT(NEW_NUMERIC(x_ncol));
	for (j = 0; j < x_ncol; j++) {
		offset = INTEGER(x_p)[j];
		count = INTEGER(x_p)[j + 1] - offset;
		REAL(ans)[j] = col_var(REAL(x_x) + offset, count, x_nrow, narm);
	}
	UNPROTECT(1);
	return ans;
}

