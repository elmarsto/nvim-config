return {
  cssls = {
    bin = "vscode-css-language-server.cmd"
  },
  eslint = {
    bin = "eslint_d"
  },
  htmlls = {
    bin = "vscode-html-language-server.cmd"
  },
  jsonls = {
    -- aboslute paths only, no expansion of ~, no expansion of $HOME
    bin = "vscode-json-language-server.cmd"
  },
  prettier = {
    bin = "prettier"
  },
  shell = {
    bin = "pwsh",
    cmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    redir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    pipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    quote = "",
    xquote = "",
  },
  sqlite = {
    lib = "C:/Users/1atti/sqlite/sqlite3.dll"
  },
  sumneko = {
    -- aboslute paths only, no expansion of ~, no expansion of $HOME
    bin = "C:/Users/1atti/lua-language-server/bin/Windows/lua-language-server.exe",
    main = "C:/Users/1atti/lua-language-server/main.lua"
  },
  sveltels = {
    bin = "svelteserver"
  },
  telescope_fzf_native = {
    run = "make" -- 'gmake' on e.g. openbsd
  },
  tsls = {
    bin = "typescript-language-server.cmd"
  },
  vimls = {
    bin = "vim-language-server.cmd"
  },
  yamlls = {
    bin = "yaml-language-server"
  },
  zk = {
    bin = "zk" -- 'gmake' on e.g. openbsd
  }
}
