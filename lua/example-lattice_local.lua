return {
  bashls = {
    bin = "bash-language-server"
  },
  ccls = {
    bin = "ccls"
  },
  cmake = {
    bin = "cmake-language-server"
  },
  cssls = {
    bin = "vscode-css-language-server.cmd"
  },
  dotls = {
    bin = ""
  },
  eslint = {
    bin = "eslint_d"
  },
  gopls = {
    bin = "gopls"
  },
  graphql = {
    bin = "graphql-language-server"
  },
  haskellls = {
    bin = "haskell-language-server-wrapper"
  },
  htmlls = {
    bin = "vscode-html-language-server.cmd"
  },
  javals = {
    bin = "java-language-server"
  },
  jsonls = {
    -- aboslute paths only, no expansion of ~, no expansion of $HOME
    bin = "vscode-json-language-server.cmd"
  },
  powershell_es = {
    bundle = ""
  },
  prettier = {
    bin = "prettier"
  },
  pyls = {
    bin = "pyright-langserver"
  },
  rnix = {
    bin = "rnix-lsp"
  },
  shell = {
    bin = "pwsh",
    cmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    redir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    pipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    quote = "",
    xquote = ""
  },
  sqlite = {
    lib = "C:/Users/1atti/sqlite/sqlite3.dll"
  },
  sqls = {
    bin = ""
  },
  sumneko = {
    -- aboslute paths only, no expansion of ~, no expansion of $HOME
    bin = "C:/Users/1atti/lua-language-server/bin/Windows/lua-language-server.exe",
    main = "C:/Users/1atti/lua-language-server/main.lua"
  },
  sveltels = {
    bin = "svelteserver"
  },
  stylelint_lsp = {
    bin = "stylelint"
  },
  taplo = {
    cmd = "taplo-lsp"
  },
  telescope_fzf_native = {
    run = "make" -- 'gmake' on e.g. openbsd
  },
  terraformls = {
    cmd = "terraform-ls"
  },
  texlab = {
    bin = "texlab"
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
  zeta_note = {
    bin = "zeta-note"
  },
  zk = {
    bin = "zk" -- 'gmake' on e.g. openbsd
  }
}
