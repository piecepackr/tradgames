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
#'  \item{Grasshopper}{Two-player Halma variant playable on a draughts board.
#'                     See \url{http://www.cyningstan.com/game/71/grasshopper}.}
#'  \item{Jul-Gono}{Traditional 2-player Korean abstract.
#'                  See \url{https://en.wikipedia.org/wiki/Jul-Gonu}.}
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

# function that converts piecepack game to checkers
to_checkers <- function(df, cell_width = 1, board_face = TRUE, n_players = 2) {
    dft <- dplyr::filter(df, grepl("tile", .data$piece_side))
    width <- max(dft$x) - min(dft$x) + 2
    if (board_face) {
        df_board <- tibble(piece_side = "board_face", suit = 3, rank = width,
                           x = 0.5 * (width + 1), y = 0.5 * (width + 1))
    } else {
        df_board <- tibble(piece_side = "board_back", suit = 2, rank = width,
                           x = 0.5 * (width + 1), y = 0.5 * (width + 1))
    }
    df_pieces <- dplyr::filter(df, !grepl("tile", .data$piece_side))
    df_pieces$piece_side <- "bit_back"
    df_pieces$angle <- NULL
    df_pieces$rank <- 1
    if (n_players == 2 && length(unique(df_pieces$suit)) == 4) {
        if (length(unique(df_pieces$suit)) == 4) {
            df_pieces$suit <- ifelse(df_pieces$suit == 2, 1, df_pieces$suit)
            df_pieces$suit <- ifelse(df_pieces$suit == 3, 6, df_pieces$suit)
            df_pieces$suit <- ifelse(df_pieces$suit == 4, 6, df_pieces$suit)
        } else if (length(unique(df_pieces$suit)) == 2) {
            df_pieces$suit <- ifelse(df_pieces$suit == 2, 6, df_pieces$suit)
        }
    }
    bind_rows(df_board, df_pieces) %>%
        adjust_pieces(cell_width, "checkers")
}

#' @rdname df_cc_games
#' @export
df_american_checkers <- function(cell_width = 1)
    to_checkers(ppgames::df_american_checkers(), cell_width = cell_width)

#' @rdname df_cc_games
#' @export
df_breakthrough <- function(cell_width = 1)
    to_checkers(ppgames::df_breakthrough(), cell_width = cell_width)

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
df_four_field_kono <- function(cell_width = 1)
    to_checkers(ppgames::df_four_field_kono(), cell_width = cell_width, board_face = FALSE)

#' @rdname df_cc_games
#' @export
df_grasshopper <- function(cell_width = 1)
    to_checkers(ppgames::df_grasshopper(), cell_width = cell_width)

#' @rdname df_cc_games
#' @export
df_jul_gono <- function(cell_width = 1)
    to_checkers(ppgames::df_jul_gono(), cell_width = cell_width, board_face = FALSE)

#' @rdname df_cc_games
#' @export
df_lines_of_action <- function(cell_width = 1)
    to_checkers(ppgames::df_lines_of_action(), cell_width = cell_width)

#' @rdname df_cc_games
#' @export
df_turkish_draughts <- function(cell_width = 1)
    to_checkers(ppgames::df_turkish_draughts(), cell_width = cell_width, board_face = FALSE)
