local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
  vim.cmd "packadd packer.nvim"
end
local packer = require "packer"
require "packer.luarocks".install_commands()
packer.startup {
  function(use)
    use "nvim-lua/plenary.nvim"
    use "neomake/neomake"
    use "tpope/vim-abolish"
    use "tpope/vim-surround"
    use "wbthomason/packer.nvim" -- self-control
  end
}
