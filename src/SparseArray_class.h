#ifndef _SPARSEARRAY_CLASS_H_
#define _SPARSEARRAY_CLASS_H_

#include <Rdefines.h>

int _coercion_can_introduce_zeros(
	SEXPTYPE from_Rtype,
	SEXPTYPE to_Rtype
);

SEXP C_coercion_can_introduce_zeros(
	SEXP from_type,
	SEXP to_type
);

#endif  /* _SPARSEARRAY_CLASS_H_ */

