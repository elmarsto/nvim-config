return {
    eslint = {
      bin = "/nix/store/5jv3mnnjk5935gz6iww0m38i6nl9ml5b-node_eslint_d-10.0.4/bin/eslint_d"
    },
    cssls = {
      bin = "/nix/store/4w9f0bcawiriphgaznxiqh055zcf1xqj-node_vscode-css-languageserver-bin-1.4.0/bin/css-languageserver"
    },
    htmlls = {
      bin = "/nix/store/kfcfi6kj1l64ppm4sci4372zanzxyr65-node_vscode-html-languageserver-bin-1.4.0/bin/html-languageserver"
    },
    jsonls = {
      bin = "/nix/store/faz61vqjcpxy86pkl6rlamv02ffj6f3g-node_vscode-json-languageserver-1.3.4/bin/vscode-json-languageserver"
    },
    sqlite = {
      lib = "/nix/store/433q5vd1ag3lg6chrm7pkqc78536l7pr-sqlite-3.35.5/lib/libsqlite3.so"
    },
    sumneko = {
      root = "/nix/store/1ig8ykdqwlnaca9yiip9b0qs2q6a3q75-sumneko-lua-language-server-1.20.2",
      bin = "/nix/store/1ig8ykdqwlnaca9yiip9b0qs2q6a3q75-sumneko-lua-language-server-1.20.2/bin/lua-language-server",
      main = "/nix/store/1ig8ykdqwlnaca9yiip9b0qs2q6a3q75-sumneko-lua-language-server-1.20.2/extras/main.lua"
    },
    telescope_fzf_native = {
      run = "/nix/store/wfzdk9vxayfnw7fqy05s7mmypg5a8lyr-gnumake-4.3/bin/make"
    },
    zk = { -- not managed by nix;
      bin = "zk"
    },
}
