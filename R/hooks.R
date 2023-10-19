.onAttach <- function(libname, pkgname) {
    packageStartupMessage(paste("{tradgames} is superseded by {ppdf}",
                                '`remotes::install_github("piecepackr/ppdf")`',
                                sep = "\n"))
}
