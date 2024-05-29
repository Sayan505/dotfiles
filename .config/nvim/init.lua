vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.cmd("aunmenu PopUp.How-to\\ disable\\ mouse")
vim.cmd("aunmenu PopUp.-1-")


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)




vim.opt.number        = true
vim.opt.swapfile      = false
vim.opt.backup        = false
vim.opt.wrap          = false
vim.opt.tabstop       = 4
vim.opt.expandtab     = true
vim.opt.softtabstop   = 4
vim.opt.shiftwidth    = 4
vim.opt.guicursor     = "n:hor20,i:ver25,c:ver25,a:blinkon1"
vim.opt.termguicolors = true

plugins = {
  {
    "neovim/nvim-lspconfig"
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "query",
          "gitignore",
          "dockerfile",
          "cmake",
          "meson",
          "bash",
          "c",
          "cpp",
          "asm",
          "linkerscript",
          "make",
          "python",
          "rust",
          "java",
          "kotlin",
          "c_sharp",
          "sql",
          "javascript",
          "typescript",
          "json",
          "html",
          "css",
          "markdown",
          "yaml",
          "toml",
          "xml",
          "ini",
          "properties"
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },
  {
    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "nvim-lua/plenary.nvim"
    },
    config = function ()
        require"alpha".setup(require"alpha.themes.dashboard".config)
        
        local alpha = require"alpha"
        local dashboard = require"alpha.themes.dashboard"
        dashboard.section.buttons.val = { dashboard.button("f", "Open File Browser" , ":Telescope file_browser <CR>") }
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup(require("lualine").setup{
        options = {
          icons_enabled = true,
          theme = "gruvbox",
          component_separators = { left = " ", right = " "},
          section_separators = { left = " ", right = " "},
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {"mode"},
          lualine_b = {"branch", "diff"},
          lualine_c = {"filename"},
          lualine_x = {"encoding", { "fileformat", symbols = { unix = "LF", dos = "CRLF" } }, { "filetype", icons_enabled = false }},
          lualine_y = {},
          lualine_z = {"location"}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {"filename"},
          lualine_x = {"location"},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      })
    end
  },
  {
    "nvim-telescope/telescope.nvim", tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    config = function()
      require("telescope").load_extension("fzf")
    end
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup{
        extensions = {
          file_browser = {
            hijack_netrw = false,
          }
        }
      }
      require("telescope").load_extension("file_browser")
    end
  },
  {
    "junegunn/fzf", build = "./install --all"
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 25,
        },
        renderer = {
          group_empty = false,
        },
        filters = {
          dotfiles = true,
        },
      })
      --vim.cmd("NvimTreeOpen")
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  },
  {
    "akinsho/bufferline.nvim", version = "4.6.1",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup{
        options = {
          --mode = "tabs",
          diagnostics = false
        }
      }
    end
  }, {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
  },
  {
    --"slugbyte/lackluster.nvim",
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      require("gruvbox").setup({
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true,
        contrast = "hard",
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = true,
      })
      vim.cmd.colorscheme("gruvbox")

      -- make bg transparent:
      --vim.cmd("hi Normal      guibg=NONE ctermbg=NONE")
      --vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")
      --vim.cmd("hi LineNr      guibg=NONE ctermbg=NONE")
      --vim.cmd("hi SignColumn  guibg=NONE ctermbg=NONE")
      --vim.cmd("hi Terminal    guibg=NONE ctermbg=NONE")
    end
  }
}
require("lazy").setup(plugins, opts)




require"lspconfig".clangd.setup{}
-- TODO: add language servers (require"lspconfig".*.setup{}) for all my favorite langs
