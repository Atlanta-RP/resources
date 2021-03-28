fx_version "adamant"

game "gta5"

files {
    "movies/script.js",
    "movies/style.css",
    "movies/blank.png",
    "movies/movie.html",
}

ui_page "movies/movie.html"

client_script "client.lua"

dependency "utk_hackdependency"
client_script "c_gcninject.lua"
server_script "s_gcninject.lua"