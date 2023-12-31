\name{matrixStats-methods}

\alias{matrixStats-methods}
\alias{matrixStats_methods}

\alias{colAnyNAs}
\alias{colAnyNAs,SVT_SparseArray-method}
\alias{rowAnyNAs}
\alias{rowAnyNAs,SVT_SparseArray-method}

\alias{colAnys}
\alias{colAnys,SVT_SparseArray-method}
\alias{rowAnys}
\alias{rowAnys,SVT_SparseArray-method}

\alias{colAlls}
\alias{colAlls,SVT_SparseArray-method}
\alias{rowAlls}
\alias{rowAlls,SVT_SparseArray-method}

\alias{colMins}
\alias{colMins,SVT_SparseArray-method}
\alias{rowMins}
\alias{rowMins,SVT_SparseArray-method}

\alias{colMaxs}
\alias{colMaxs,SVT_SparseArray-method}
\alias{rowMaxs}
\alias{rowMaxs,SVT_SparseArray-method}

\alias{colRanges}
\alias{colRanges,SVT_SparseArray-method}
\alias{rowRanges}
\alias{rowRanges,SVT_SparseArray-method}

\alias{colSums}
\alias{colSums,SVT_SparseArray-method}
\alias{rowSums}
\alias{rowSums,SVT_SparseArray-method}

\alias{colProds}
\alias{colProds,SVT_SparseArray-method}
\alias{rowProds}
\alias{rowProds,SVT_SparseArray-method}

\alias{colMeans}
\alias{colMeans,SVT_SparseArray-method}
\alias{rowMeans}
\alias{rowMeans,SVT_SparseArray-method}

\alias{colVars}
\alias{colVars,SVT_SparseArray-method}
\alias{rowVars}
\alias{rowVars,SVT_SparseArray-method}

\alias{colSds}
\alias{colSds,SVT_SparseArray-method}
\alias{rowSds}
\alias{rowSds,SVT_SparseArray-method}

\alias{colMedians}
\alias{colMedians,SVT_SparseArray-method}
\alias{rowMedians}
\alias{rowMedians,SVT_SparseArray-method}

\title{SparseArray col/row summarization methods}

\description{
  The \pkg{SparseArray} package provides memory-efficient col/row
  summarization methods for \link{SparseArray} objects, like
  \code{colSums()}, \code{rowSums()}, \code{colMedians()}, \code{rowMedians()},
  \code{colVars()}, \code{rowVars()}, etc...

  Note that these are \emph{S4 generic functions} defined in the
  \pkg{MatrixGenerics} package, with methods for ordinary matrices
  defined in the \pkg{matrixStats} package. This man page documents
  the methods defined for \link{SVT_SparseArray} objects.
}

\usage{
## N.B.: Showing ONLY the col*() methods (usage of row*() methods is
## the same):

\S4method{colAnyNAs}{SVT_SparseArray}(x, rows=NULL, cols=NULL, dims=1, ..., useNames=NA)

\S4method{colAnys}{SVT_SparseArray}(x, rows=NULL, cols=NULL, na.rm=FALSE, dims=1, ..., useNames=NA)

\S4method{colAlls}{SVT_SparseArray}(x, rows=NULL, cols=NULL, na.rm=FALSE, dims=1, ..., useNames=NA)

\S4method{colMins}{SVT_SparseArray}(x, rows=NULL, cols=NULL, na.rm=FALSE, dims=1, ..., useNames=NA)

\S4method{colMaxs}{SVT_SparseArray}(x, rows=NULL, cols=NULL, na.rm=FALSE, dims=1, ..., useNames=NA)

\S4method{colRanges}{SVT_SparseArray}(x, rows=NULL, cols=NULL, na.rm=FALSE, dims=1, ..., useNames=NA)

\S4method{colSums}{SVT_SparseArray}(x, na.rm=FALSE, dims=1)

\S4method{colProds}{SVT_SparseArray}(x, rows=NULL, cols=NULL, na.rm=FALSE, dims=1, ..., useNames=NA)

\S4method{colMeans}{SVT_SparseArray}(x, na.rm=FALSE, dims=1)

\S4method{colVars}{SVT_SparseArray}(x, rows=NULL, cols=NULL, na.rm=FALSE, center=NULL, dims=1,
           ..., useNames=NA)

\S4method{colSds}{SVT_SparseArray}(x, rows=NULL, cols=NULL, na.rm=FALSE, center=NULL, dims=1,
          ..., useNames=NA)

\S4method{colMedians}{SVT_SparseArray}(x, rows=NULL, cols=NULL, na.rm=FALSE, ..., useNames=NA)
}

\arguments{
  \item{x}{
    An \link{SVT_SparseMatrix} or \link{SVT_SparseArray} object.

    Note that the \code{colMedians()} and \code{rowMedians()} methods
    only support 2D objects (i.e. \link{SVT_SparseMatrix} objects) at
    the moment.
  }
  \item{rows, cols, ...}{
    Not supported.
  }
  \item{na.rm, useNames, center}{
    See man pages for the corresponding generics in the \pkg{MatrixGenerics}
    package (e.g. \code{?MatrixGenerics::\link[MatrixGenerics]{rowVars}})
    for a description of these arguments.

    Note that, unlike the methods for ordinary matrices defined in
    the \pkg{matrixStats} package, the \code{center} argument of the
    \code{colVars()}, \code{rowVars()}, \code{colSds()}, and \code{rowSds()}
    methods for \link{SVT_SparseArray} objects can only be a
    \emph{single value} (or a \code{NULL}). In particular, if \code{x}
    has more than one column, then \code{center} cannot be a vector
    with one value per column in \code{x}.
  }
  \item{dims}{
    See \code{?base::\link[base]{colSums}} for a description of this
    argument. Note that all the methods above support it, except
    \code{colMedians()} and \code{rowMedians()}.
  }
}

\details{
  All these methods operate \emph{natively} on the \link{SVT_SparseArray}
  representation, for maximum efficiency.

  Note that more col/row summarization methods might be added in the future.
}

\value{
  See man pages for the corresponding generics in the \pkg{MatrixGenerics}
  package (e.g. \code{?MatrixGenerics::\link[MatrixGenerics]{colRanges}})
  for the value returned by these methods.
}

\seealso{
  \itemize{
    \item \link{SVT_SparseArray} objects.

    \item The man pages for the various generic functions defined
          in the \pkg{MatrixGenerics} package e.g.
          \code{MatrixGenerics::\link[MatrixGenerics]{colVars}} etc...
  }
}

\examples{
## ---------------------------------------------------------------------
## 2D CASE
## ---------------------------------------------------------------------
m0 <- matrix(0L, nrow=6, ncol=4, dimnames=list(letters[1:6], LETTERS[1:4]))
m0[c(1:2, 8, 10, 15:17, 24)] <- (1:8)*10L
m0["e", "B"] <- NA
svt0 <- SparseArray(m0)
svt0

colSums(svt0)
colSums(svt0, na.rm=TRUE)

rowSums(svt0)
rowSums(svt0, na.rm=TRUE)

colMeans(svt0)
colMeans(svt0, na.rm=TRUE)

colRanges(svt0)
colRanges(svt0, useNames=FALSE)
colRanges(svt0, na.rm=TRUE)
colRanges(svt0, na.rm=TRUE, useNames=FALSE)

colVars(svt0)
colVars(svt0, useNames=FALSE)

## Sanity checks:
stopifnot(
  identical(colSums(svt0), colSums(m0)),
  identical(colSums(svt0, na.rm=TRUE), colSums(m0, na.rm=TRUE)),
  identical(rowSums(svt0), rowSums(m0)),
  identical(rowSums(svt0, na.rm=TRUE), rowSums(m0, na.rm=TRUE)),
  identical(colMeans(svt0), colMeans(m0)),
  identical(colMeans(svt0, na.rm=TRUE), colMeans(m0, na.rm=TRUE)),
  identical(colRanges(svt0), colRanges(m0, useNames=TRUE)),
  identical(colRanges(svt0, useNames=FALSE), colRanges(m0, useNames=FALSE)),
  identical(colRanges(svt0, na.rm=TRUE),
            colRanges(m0, na.rm=TRUE, useNames=TRUE)),
  identical(colVars(svt0), colVars(m0, useNames=TRUE)),
  identical(colVars(svt0, na.rm=TRUE),
            colVars(m0, na.rm=TRUE, useNames=TRUE))
)

## ---------------------------------------------------------------------
## 3D CASE (AND ARBITRARY NUMBER OF DIMENSIONS)
## ---------------------------------------------------------------------
set.seed(2009)
svt <- 6L * (poissonSparseArray(5:3, density=0.35) -
             poissonSparseArray(5:3, density=0.35))
dimnames(svt) <- list(NULL, letters[1:4], LETTERS[1:3])

cs1 <- colSums(svt)
cs1  # cs1[j , k] is equal to sum(svt[ , j, k])

cs2 <- colSums(svt, dims=2)
cs2  # cv2[k] is equal to sum(svt[ , , k])

cv1 <- colVars(svt)
cv1  # cv1[j , k] is equal to var(svt[ , j, k])

cv2 <- colVars(svt, dims=2) 
cv2  # cv2[k] is equal to var(svt[ , , k])

## Sanity checks:
k_idx <- setNames(seq_len(dim(svt)[3]), dimnames(svt)[[3]])
j_idx <- setNames(seq_len(dim(svt)[2]), dimnames(svt)[[2]])
cv1b <- sapply(k_idx, function(k)
                      sapply(j_idx, function(j) var(svt[ , j, k, drop=FALSE])))
cv2b <- sapply(k_idx, function(k) var(svt[ , , k]))
stopifnot(
  identical(colSums(svt), colSums(as.array(svt))),
  identical(colSums(svt, dims=2), colSums(as.array(svt), dims=2)),
  identical(cv1, cv1b),
  identical(cv2, cv2b)
)
}
\keyword{array}
\keyword{methods}
\keyword{algebra}
\keyword{arith}
