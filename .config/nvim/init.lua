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
    "--branch=stable",
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
vim.opt.cursorline    = true
vim.opt.guicursor     = "n:hor20,i:ver25,c:ver25,a:blinkon1"
vim.opt.termguicolors = true
vim.opt.clipboard:append { 'unnamedplus' }


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
          "properties",
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        update_focused_file = { enabled = true }
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    }
  },
  {
    "kylechui/nvim-surround", version = "*",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects"
    },
    config = function()
      require("nvim-surround").setup({})
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
            "NvimTree"
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000
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
            hijack_netrw = false
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
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive"
        },
        view = {
          width = 25
        },
        renderer = {
          group_empty = false
        },
        filters = {
          dotfiles = false
        }
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
    "hiphish/rainbow-delimiters.nvim",
    lazy = false,
    config = function()
      require("rainbow-delimiters.setup").setup {
        highlight = {
          'RainbowDelimiterBlue',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterYellow',
          'RainbowDelimiterOrange',
          'RainbowDelimiterRed',
          'RainbowDelimiterCyan'
        }
      }
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim", main = "ibl",
    config = function()
      require("ibl").setup()
    end
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify"
    },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true
          },
        },
        presets = {
          bottom_search = true,
          command_palette = false,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = true
        },
        cmdline = {
          enabled = true,
          view = "cmdline",
        }
      })
      require('notify').setup ({
        background_colour = "#000000"
      })
    end
  },
  {
    'akinsho/toggleterm.nvim', version = "*", config = true
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
          folds = true
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
        transparent_mode = true
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
require"lspconfig".pyright.setup{}
-- TODO: add language servers (require"lspconfig".*.setup{}) for all my favorite langs
-- ref: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- ref: https://microsoft.github.io/language-server-protocol/implementors/servers/




vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>",  { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>",   { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<esc><esc>", "<cmd>nohlsearch<CR>",             { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><space>", "<cmd>Telescope<CR>",         { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>b", "<cmd>Telescope file_browser<CR>",  { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>s", "<cmd>Telescope fd<CR>",            { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>Telescope live_grep<CR>",     { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>ToggleTerm size=7 dir=.<CR>", { noremap = true, silent = true })


--------------------
----  CONTROLS  ----
--------------------

-- <leader>: \
--    open :Telescope: <leader><space>
--    open :Telescope file_browser: <leader>b
--    open :Telescope fd (find file): <leader>s
--    open :Telescope live_grep (ripgrep): <leader>f
--    ToggleTerm in current dir (terminal): <leader>t
--    switch out of terminal pane: <C-w><up>
--    go to normal mode in terminal: <C-\><C-n>

-- LSP:
--    lsp goto decl: gD
--    lsp goto def: gd
--    lsp hover: K
--    lsp hover scroll: KK

-- surround.nvim:
--    highlight the text in visual mode, then
--    S" or any symbol like '`<({[ etc

--  nvim-tree:
--    navigate: <up> <down>
--    cd: <C-]>
--    open: <CR>
--    open in system: s
--    preview: <tab>
--    back: <backspace>
--    goto parent dir: P
--    collapse all: W
--    expand all: E
--    toggle hidden: H
--    toggle gitignored: I
--    refresh: R
--    rename: r
--    rename basename: e
--    rename mv (abs move): u
--    create: a
--    copy: c
--    cut: x
--    paste: p
--    move to trash: D
--    delete permanently: d
--    copy relative path: Y
--    copy abs path: gy
--    copy name: y

-- modesetting:
--    normal mode (default): <esc>
--    insert (edit) mode: i
--    command mode (while outside insert mode): :
--    visual mode: v
--    visual block mode: <C-V>

-- find: :/<searchterm>
-- find next: n
-- find prev: N
-- find and replace (all instances): :%s/<searchterm>/<replacewith>/g
-- clear searches: <esc><esc>
-- find next occurence of the word on cursor: *
-- find prev occurence of the word on cursor: #

-- undo: u
-- redo: <C-r>

-- visual mode (v):
--    select word: iw
--    select from cur till end (end): $ OR <end>
--    select from start to cur (home) : ^ OR <home>
--    toggle uppercase-lowercase: <S-`>

-- copy (yank):
--    copy current line: yy
--    copy from cur till end: y$
--    copy from start to cur: y^
--    copy current symbol: yiw
--    copy selected from visual mode: y
--    copy selected char: yl OR vy

--  cut (delete):
--    cut current line: dd
--    cut from cur till end: d$
--    cut from start to cur: d^
--    cut current symbol: diw
--    cut selected from visual mode: d
--    cut selected char: dl OR vd OR x
--    backspace key (cut): X
--    delete key (cut): x

-- paste (put):
--    paste before cur: P
--    paste after cur: p

-- save: :w
-- save and quit: :wq OR :x
-- quit: :q
-- quit all: :qa
-- discard and quit: :q!
-- discard and quit all: :qa!

-- buffers (as tabs):
--    next buffer: :bn
--    prev buffer: :bp

-- goto:
--    line N: Ngg OR NG OR :N
--    next instance of the current word: *
--    prev instance of the current word: #
--    pane N: N<C-w><C-w>
--    pane up: <C-w><up>
--    pane down: <C-w><down>
--    pane left: <C-w><left>
--    pane right: <C-w><right>
--    end of file: <C-end>
--    end of line: <end>
--    start of file: <C-home>
--    start of line: <home>

