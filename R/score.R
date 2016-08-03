calculate_grantham <- function(a1, a2) {
  (grantham %>% dplyr::filter(FIRST == a1, SECOND == a2))$SCORE
}

