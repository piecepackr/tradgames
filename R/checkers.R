#' Data frames of starting diagrams for various games
#'
#' \code{tibble} data frames of starting diagrams for various games.
#'
#' Here is some more information about the various games:
#'  \describe{
#'  \item{Breakthrough}{Two-player abstract invented by Dan Troyka in 2000
#'                      that won the 2001 8x8 Game Design Competition.
#'                      See \url{https://en.wikipedia.org/wiki/Breakthrough_(board_game)}.}
#'  \item{(American) Checkers}{A traditional board game also known as \dQuote{(English) Draughts}.
#'                  See \url{https://en.wikipedia.org/wiki/Draughts}.}
#'  \item{Crossings}{An abstract invented by Robert Abbot.
#'                   See \url{https://en.wikipedia.org/wiki/Crossings_(game)}}
#'  \item{Focus}{An asbtract designed by Sid Sackson.
#'               See \url{https://en.wikipedia.org/wiki/Focus_(board_game)}.}
#'  \item{Four Field Kono}{Traditional 2-player Korean abstract.
#'                         See \url{https://en.wikipedia.org/wiki/Four_Field_Kono}.}
#'  \item{Lines of Action}{An abstract designed by Claude Soucie.
#'                         See \url{https://en.wikipedia.org/wiki/Lines_of_Action}.}
#'  \item{Turkish Draughts}{AKA \dQuote{Dama} is a traditional checkers variant played in the Mediterranean.
#'                          See \url{https://en.wikipedia.org/wiki/Turkish_draughts}.}
#'}
#' @param cell_width Width of board cell
#' @name df_cc_games
#' @rdname df_cc_games
NULL

#' @importFrom tibble tibble
#' @importFrom dplyr %>% bind_rows mutate
#' @importFrom rlang .data

adjust_pieces <- function(df, cell_width, system) {
    df <- mutate(df, cfg = paste0(system, cell_width),
           x = cell_width * .data$x,
           y = cell_width * .data$y)
    attr(df, "scale_factor") <- cell_width
    df
}

#' @rdname df_cc_games
#' @export
df_american_checkers <- function(cell_width = 1) {
    df_board <- tibble(piece_side = "board_face", suit = 3, rank = 8,
                   x = 4.5, y = 4.5)
    df_w <- tibble(piece_side = "bit_back", suit = 6, rank = 1,
                   x = c(seq(1, 7, 2), seq(2, 8, 2), seq(1, 7, 2)),
                   y = rep(1:3, each = 4))
    df_b <- tibble(piece_side = "bit_back", suit = 1, rank = 1,
                   x = c(seq(2, 8, 2), seq(1, 7, 2), seq(2, 8, 2)),
                   y = rep(6:8, each = 4))
    bind_rows(df_board, df_w, df_b) %>%
        adjust_pieces(cell_width, "checkers")
}

#' @rdname df_cc_games
#' @export
df_breakthrough <- function(cell_width = 1) {
    df_board <- tibble(piece_side = "board_face", suit = 3, rank = 8,
                   x = 4.5, y = 4.5)
    df_w <- tibble(piece_side = "bit_back", suit = 6, rank = 1,
                   x = rep(1:8, 2), y = rep(1:2, each = 8))
    df_b <- tibble(piece_side = "bit_back", suit = 1, rank = 1,
                   x = rep(1:8, 2), y = rep(7:8, each = 8))
    bind_rows(df_board, df_w, df_b) %>%
        adjust_pieces(cell_width, "checkers")
}

#' @rdname df_cc_games
#' @export
df_crossings <- df_breakthrough

#' @rdname df_cc_games
#' @export
df_focus <- function(cell_width = 1) {
    df_board <- tibble(piece_side = "board_face", suit = 3, rank = 8,
                   x = 4.5, y = 4.5)
    df_w <- tibble(piece_side = "bit_back", suit = 6, rank = 1,
                   x = rep(c(2:7), each=3),
                   y = c(rep(c(2, 4, 6), 2), rep(c(3, 5, 7), 2), rep(c(2, 4, 6), 2)))
    df_b <- tibble(piece_side = "bit_back", suit = 1, rank = 1,
                   x = rep(c(2:7), each=3),
                   y = c(rep(c(3, 5, 7), 2), rep(c(2, 4, 6), 2), rep(c(3, 5, 7), 2)))
    bind_rows(df_board, df_w, df_b) %>%
        adjust_pieces(cell_width, "checkers")
}

#' @rdname df_cc_games
#' @export
df_four_field_kono <- function(cell_width = 1) {
    df_board <- tibble(piece_side = "board_back", suit = 2, rank = 4,
                   x = 2.5, y = 2.5)
    df_w <- tibble(piece_side = "bit_back", suit = 6, rank = 1,
                   x = rep(1:4, 2), y = rep(1:2, each = 4))
    df_b <- tibble(piece_side = "bit_back", suit = 1, rank = 1,
                   x = rep(1:4, 2), y = rep(3:4, each = 4))
    bind_rows(df_board, df_w, df_b) %>%
        adjust_pieces(cell_width, "checkers")
}

#' @rdname df_cc_games
#' @export
df_lines_of_action <- function(cell_width = 1) {
    df_board <- tibble(piece_side = "board_face", suit = 3, rank = 8,
                   x = 4.5, y = 4.5)
    df_w <- tibble(piece_side = "bit_back", suit = 6, rank = 1,
                   x = rep(c(1, 8), each=6), y = rep(2:7, 2))
    df_b <- tibble(piece_side = "bit_back", suit = 1, rank = 1,
                   x = rep(2:7, 2), y = rep(c(1, 8), each = 6))
    bind_rows(df_board, df_w, df_b) %>%
        adjust_pieces(cell_width, "checkers")
}

#' @rdname df_cc_games
#' @export
df_turkish_draughts <- function(cell_width = 1) {
    df_board <- tibble(piece_side = "board_back", suit = 2, rank = 8,
                   x = 4.5, y = 4.5)
    df_w <- tibble(piece_side = "bit_back", suit = 6, rank = 1,
                   x = rep(1:8, 2), y = rep(2:3, each = 8))
    df_b <- tibble(piece_side = "bit_back", suit = 1, rank = 1,
                   x = rep(1:8, 2), y = rep(6:7, each = 8))
    bind_rows(df_board, df_w, df_b) %>%
        adjust_pieces(cell_width, "checkers")
}
