#' checks if file is a midi file
#'
#' @description
#' Check if file is a midi file
#' @param file path of the midi file to be played
#' @return logical
#' @name is_midi_file
#'
NULL

#' @export
#' @rdname is_midi_file
is_midi_file <- function(file){
  if(!is.character(file)) stop(paste(file,"is not a file path"))
  if(!file.exists(file)) stop(paste(file,"does not exist"))
  first_bytes <- readBin(file,"integer",10,size=1,signed=FALSE)
  all(first_bytes[1:4] == c(77,84,104,100)) &
    (first_bytes[10] %in% 0:2)
}

