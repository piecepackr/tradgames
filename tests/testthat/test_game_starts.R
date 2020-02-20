library("piecepackr")
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
    # verify_output("../text_diagrams/alice_chess", cat_piece(df_alice_chess())) # nolint
})
