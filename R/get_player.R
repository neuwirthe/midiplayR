get_player <- function(){
  if (Sys.info()["sysname"] == "Darwin")
    return(get_player_mac_linux())
  if (Sys.info()["sysname"] == "Linux")
    return(get_player_mac_linux())
  if (Sys.info()["sysname"] == "Windows")
    check_win_mediaplayer()
  if(!((Sys.info()["sysname"]) %in% c("Darwin", "Windows", "Linux")))
    print(paste("OS", Sys.info()["sysname"],"not supported"))
}


get_player_mac_linux <- function(){
  midiplayer <- Sys.getenv("R_MIDIPLAYER")
  if(nchar(midiplayer)==0) {
    cat(
      paste("No midiplayer is configured.",
            "If you have installed a command line program which can play midi files",
            "set the R environment variable 'R_MIDIPLAYER' to the path to this program.",
            "You need to add the line",
            "'R_MIDIPLAYER=/path/do/playerprogram'",
            "to the file '.Renviron' in your home folder.",
            "If this file does not exist, you must create it.",
            "You can create and edit `.Renviron` with the R command 'usethis::edit_r_environ()'.",
            "Vignette 'installing-midiplayer' explains how to install midiplayer software.",
            "After you have done that, restart R.",
            sep="\n"
      )
    )
    utils::vignette("installing-midiplayer",package="midiplayR")
    return("")
  } else {
    return(midiplayer)
  }
}




check_win_mediaplayer <- function(){
  res <-
      (file.path(Sys.getenv("PROGRAMFILES"),
            "Windows Media Player",
            "wmplayer.exe") |> file.exists()) |
        (file.path(Sys.getenv("PROGRAMFILES(X86)"),
              "Windows Media Player",
              "wmplayer.exe") |> file.exists())
  if(!res){
    stop("Windows Media Player is not accessible.\n")
  }
  return(res)
}

is_midi_file <- function(file){
  first_bytes <- readBin(file,"integer",10,size=1,signed=FALSE)
  all(first_bytes[1:4] == c(77,84,104,100)) &
    (first_bytes[10] %in% 0:2)
}


