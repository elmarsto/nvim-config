return {
  sumneko = {
    root = "${sumneko}",
    bin = "${sumneko}/bin/lua-language-server",
    main = "${sumneko}/extras/main.lua"
  },
  jsonls = {
    bin = "${jsonls}/bin/vscode-json-languageserver"
  },
  htmlls = {
    bin = "${htmlls}/bin/html-languageserver"
  },
  cssls = {
    bin = "${cssls}/bin/css-languageserver"
  },
  sqlite = {
    lib = "${sqLite.out}/lib/libsqlite3.so"
  },
  telescope_fzf_native = {
    run = "make" -- 'gmake' on e.g. openbsd
  },
  zk = {
    bin = "zk"
  }
}
