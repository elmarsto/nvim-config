return {
    sumneko = { -- aboslute paths only, no expansion of ~, no expansion of $HOME
      root = "FIXME for whatever machine you're on";
      bin = "lua-language-server",
      main = "../main.lua"
    },
    jsonls = { -- aboslute paths only, no expansion of ~, no expansion of $HOME
      bin = "vscode-json-language-server",
    }
}
