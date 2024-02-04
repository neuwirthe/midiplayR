play_midi_file <- function(file) {
#'
#' play MIDI file
#' @description
#' `play_midi_file` takes a midi file and plays it
#' through the default system audio output.
#'
#' On Mac and Lixux, a command line program playing MIDI files
#' need to be installed and the path set in the envorinment
#' variable `R_MIDIPLAYER`
#'
#' @param file path of the midi file to be played
#'
#' @examples
#' \dontrun{
#' play_midi_file(system.file("midifiles/Nokia_Tune.mid",package="midiplayR"))
#' }
#' @export
#'
if (!file.exists(file)) stop(paste(file, "does not exist."))
  if (!is_midi_file(file)) stop(paste(file, " is not a valid midi file."))
  OS <- Sys.info()["sysname"]
  if (!OS %in% c("Darwin", "Windows", "Linux")) {
    stop(paste(OS, " is currently not supported."))
  }
  if (OS %in% c("Darwin", "Linux")) {
    midiplayer <- get_player_mac_linux()
    if (nchar(midiplayer) == 0) {
    } else {
      command <- paste(get_player_mac_linux(), file)
      system(command, ignore.stderr = TRUE)
    }
  }
  if (OS == "Windows") {
    check_win_mediaplayer()
    shell.exec(file)
  }
}
