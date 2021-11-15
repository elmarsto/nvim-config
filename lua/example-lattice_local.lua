return {
    cssls = {
      bin = "/nix/store/4w9f0bcawiriphgaznxiqh055zcf1xqj-node_vscode-css-languageserver-bin-1.4.0/bin/css-languageserver"
    },
    eslint = {
      bin = "/nix/store/5jv3mnnjk5935gz6iww0m38i6nl9ml5b-node_eslint_d-10.0.4/bin/eslint_d"
    },
    htmlls = {
      bin = "/nix/store/kfcfi6kj1l64ppm4sci4372zanzxyr65-node_vscode-html-languageserver-bin-1.4.0/bin/html-languageserver"
    },
    shell = {
      bin = "/nix/store/wv35g5lff84rray15zlzarcqi9fxzz84-bash-4.4-p23/bin/bash" -- TODO: parameterize
    },
    jsonls = {
      bin = "/nix/store/faz61vqjcpxy86pkl6rlamv02ffj6f3g-node_vscode-json-languageserver-1.3.4/bin/vscode-json-languageserver"
    },
    prettier = {
      bin = "/nix/store/8h4bm8qd2642vgxbzpmsa76i70vjjxck-node_prettier-2.2.1/bin/prettier"
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
    tsls = {
      bin = "/nix/store/fyph347wg28ckyxjrcvnsxl1sw9lrrsk-node_typescript-language-server-0.5.1/bin/typescript-language-server"
    },
    zk = { -- not managed by nix;
      bin = "zk"
    },
}
