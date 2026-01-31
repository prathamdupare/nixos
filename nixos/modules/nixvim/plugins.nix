{ config, pkgs, ... }:

{
  programs.nixvim.plugins = {

    # ── Core ─────────────────────────────────────────────
    treesitter.enable = true;
    lualine.enable = true;
    which-key.enable = true;
    gitsigns.enable = true;
    web-devicons.enable = true;
    dashboard.enable = true;

    # ── Navigation / UI ──────────────────────────────────
    telescope.enable = true;
    neo-tree = {
      enable = true;

      settings = {
        enable_git_status = true;
        enable_diagnostics = true;
        enable_modified_markers = true;
        enable_refresh_on_write = true;
        close_if_last_window = true;
        popup_border_style = "rounded";

        window.mappings."<space>" = "none";

        buffers = {
          bind_to_cwd = false;

          follow_current_file = {
            enabled = true;
          };
        };
      };
    };

    # ── Editing helpers ──────────────────────────────────
    nvim-autopairs = {
      enable = true;
      settings.disable_filetype = [
        "TelescopePrompt"
        "vim"
      ];
    };

    flash.enable = true;
    vim-be-good.enable = true;
    commentary.enable = true;
    snacks.enable = true;

    render-markdown.enable = true;
    emmet.enable = true;

    # ── Completion ───────────────────────────────────────
    cmp = {
      enable = true;
      autoEnableSources = true;

      settings = {
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "buffer"; }
          { name = "path"; }
        ];

        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Down>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i','s'})";
          "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i','s'})";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i','s'})";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
        };
      };
    };

    # ── Formatting ───────────────────────────────────────
    conform-nvim.settings.formatters_by_ft = {
      javascript = [ "prettier" ];
      javascriptreact = [ "prettier" ];
    };

    # ── LSP ──────────────────────────────────────────────
    lsp = {
      enable = true;
      onAttach = ''
        vim.diagnostic.config({
            virtual_text = true,    -- show inline messages
            signs = true,           -- gutter signs
            underline = true,       -- underline code
            update_in_insert = false,
            severity_sort = true
            })
      '';
      servers = {
        ts_ls.enable = true;
        eslint.enable = true;
        biome.enable = true;

        html.enable = true;
        cssls.enable = true;
        tailwindcss.enable = true;
        emmet_ls.enable = true;
        astro.enable = true;

        gopls.enable = true;
        phpactor.enable = true;
        pyright.enable = true;
        marksman.enable = true;
        nil_ls.enable = true;
        bashls.enable = true;

        svelte.enable = false;
      };
    };

    # ── Language specific ────────────────────────────────
    rustaceanvim.enable = true;

    # ── Git / Tools ──────────────────────────────────────
    lazygit.enable = true;
    leetcode.enable = true;
  };
}
