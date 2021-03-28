client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version "adamant"

game "gta5"

files {
    "movies/script.js",
    "movies/style.css",
    "movies/intro.gif",
    "movies/success.gif",
    "movies/fail.gif",
    "movies/blank.png",
    "movies/movie.html",
}

ui_page "movies/movie.html"

client_script "client.lua"

dependency "utk_hackdependency"              