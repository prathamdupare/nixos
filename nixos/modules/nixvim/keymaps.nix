{ config
, pkgs
, ...
}: {
  programs.nixvim.keymaps = [
    # Neo-tree bindings
    {
      action = "<cmd>Neotree toggle<CR>";
      key = "<leader>e";
    }
    {
      key = "<C-s>";
      action = "<cmd>w<CR><cmd>lua vim.lsp.buf.format({ async = true })<CR>";
    }

    # Window Vim like movements
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
      options = {
        desc = "Move to the left window";
      };
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
      options = {
        desc = "Move to the right window";
      };
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w>j";
      options = {
        desc = "Move to the below window";
      };
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w>k";
      options = {
        desc = "Move to the above window";
      };
    }

    # Undotree
    {
      mode = "n";
      key = "<leader>ut";
      action = "<cmd>UndotreeToggle<CR>";
      options = {
        desc = "Undotree";
      };
    }

    # Lazygit
    {
      mode = "n";
      key = "<leader>gg";
      action = "<cmd>LazyGit<CR>";
      options = {
        desc = "LazyGit (root dir)";
      };
    }

    # Commentary bindings
    {
      action = "<cmd>Commentary<CR>";
      key = "<leader>/";
    }

    # Telescope bindings

    {
      action = "<cmd>Telescope live_grep<CR>";
      key = "<leader>ff";
    }
    {
      action = "<cmd>Telescope find_files<CR>";
      key = "<leader><leader>";
    }
    {
      action = "<cmd>Telescope git_commits<CR>";
      key = "<leader>fg";
    }
    {
      action = "<cmd>Telescope oldfiles<CR>";
      key = "<leader>fh";
    }
    {
      action = "<cmd>Telescope colorscheme<CR>";
      key = "<leader>ch";
    }
    {
      action = "<cmd>Telescope man_pages<CR>";
      key = "<leader>fm";
    }

    # Notify bindings

    {
      mode = "n";
      key = "<leader>un";
      action = ''
        <cmd>lua require("notify").dismiss({ silent = true, pending = true })<cr>
      '';
      options = {
        desc = "Dismiss All Notifications";
      };
    }

    # Bufferline bindings

    {
      mode = "n";
      key = "<Tab>";
      action = "<cmd>BufferLineCycleNext<cr>";
      options = {
        desc = "Cycle to next buffer";
      };
    }

    {
      mode = "n";
      key = "<S-Tab>";
      action = "<cmd>BufferLineCyclePrev<cr>";
      options = {
        desc = "Cycle to previous buffer";
      };
    }

    {
      mode = "n";
      key = "<S-l>";
      action = "<cmd>BufferLineCycleNext<cr>";
      options = {
        desc = "Cycle to next buffer";
      };
    }

    {
      mode = "n";
      key = "<S-h>";
      action = "<cmd>BufferLineCyclePrev<cr>";
      options = {
        desc = "Cycle to previous buffer";
      };
    }

    {
      mode = "n";
      key = "<leader>bd";
      action = "<cmd>bdelete<cr>";
      options = {
        desc = "Delete buffer";
      };
    }

    # Next buffer
    {
      mode = "n";
      key = "<Right>";
      action = "<cmd>bn<CR>";
      options = {
        desc = "Next buffer";
      };
    }

    # Previous buffer
    {
      mode = "n";
      key = "<Left>";
      action = "<cmd>bp<CR>";
      options = {
        desc = "Previous buffer";
      };
    }

    # Copilot Chat

    {
      mode = "n";
      key = "<leader>ze";
      action = "<cmd>CopilotChatExplain<cr>";
      options = {
        desc = "Copilot Chat Explain";
      };
    }

    {
      mode = "n";
      key = "<leader>zr";
      action = "<cmd>CopilotChatReview<cr>";
      options = {
        desc = "Copilot Chat Explain";
      };
    }

    {
      mode = "v";
      key = "<leader>zf";
      action = "<cmd>CopilotChatFix<cr>";
      options = {
        desc = "Copilot Chat Explain";
      };
    }

    {
      mode = "n";
      key = "<leader>zo";
      action = "<cmd>CopilotChatOptimize<cr>";
      options = {
        desc = "Copilot Chat Explain";
      };
    }
  ];
}
