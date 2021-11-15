return {
  cssls = {
    bin = "vscode-css-language-server"
  },
  eslint = {
    bin = "eslint_d"
  },
  htmlls = {
    bin = "vscode-html-language-server"
  },
  jsonls = {
    -- aboslute paths only, no expansion of ~, no expansion of $HOME
    bin = "vscode-json-language-server"
  },
  prettier = {
    bin = "prettier"
  },
  shell = {
    bin = "pwsh"
  },
  sqlite = {
    lib = "C:/Users/1atti/sqlite/sqlite3.dll"
  },
  sumneko = {
    -- aboslute paths only, no expansion of ~, no expansion of $HOME
    bin = "C:/Users/1atti/lua-language-server/bin/Windows/lua-language-server.exe",
    main = "C:/Users/1atti/lua-language-server/main.lua"
  },
  telescope_fzf_native = {
    run = "make" -- 'gmake' on e.g. openbsd
  },
  tsls = {
    bin = "typescript-language-server.cmd"
  },
  zk = {
    bin = "zk" -- 'gmake' on e.g. openbsd
  }
}
