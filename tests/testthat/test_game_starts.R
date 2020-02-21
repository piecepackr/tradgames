library("piecepackr")
library("ppgames")
library("vdiffr")

context("test game diagrams")
test_that("game diagrams work as expected", {
    expect_doppelganger("american_checkers", function() {
        df <- df_american_checkers()
        pmap_piece(df, default.units = "in")
    })
    expect_doppelganger("turkish_draughts", function() {
        df <- df_turkish_draughts()
        pmap_piece(df, default.units = "in")
    })
    verify_output("../text_diagrams/crossings.txt", cat_piece(df_crossings()))
    verify_output("../text_diagrams/focus.txt", cat_piece(df_focus()))
    verify_output("../text_diagrams/four_field_kono.txt", cat_piece(df_four_field_kono()))
    verify_output("../text_diagrams/lines_of_action.txt", cat_piece(df_lines_of_action()))
})
