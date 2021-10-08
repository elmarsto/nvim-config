return {
    sumneko = { -- sumneko is picky. aboslute paths only, no expansion of ~, no expansion of $HOME
      root = "FIXME for whatever machine you're on";
      bin = "lua-language-server",
      main = "../main.lua"
    },
    jsonls = {
      bin = "vscode-json-language-server",
    },
    sqlite = {
      lib = "libsqlite3.so", -- under windows, an abs path to an sqlite .dll works here (grab from sqlite repo)
    }
}
