{ config
, pkgs
, ...
}: {
   programs.nixvim.globalOpts = {
    relativenumber = true;
    breakindent = true;
    completeopt = "menu,menuone,noselect";
    cursorline = true;
    expandtab = true;
    fillchars = {
      eob = " ";
      fold = " ";
      foldclose = "";
      foldopen = "";
      foldsep = " ";
    };
    foldcolumn = "1";
    foldenable = true;
    foldlevel = 99;
    foldlevelstart = 99;
    ignorecase = true;
    inccommand = "split";
    laststatus = 3;
    linebreak = true;
    list = true;
    listchars = {
      nbsp = "␣";
      tab = "» ";
      trail = "·";
    };
    mouse = "a";
    pumblend = 10;
    pumheight = 10;
    ruler = false;
    scrolloff = 4;
    shiftwidth = 2;
    showmode = false;
    sidescrolloff = 8;
    signcolumn = "yes";
    smartcase = true;
    smartindent = true;
    softtabstop = 2;
    splitbelow = true;
    splitkeep = "screen";
    splitright = true;
    swapfile = false;
    tabstop = 2;
    termguicolors = true;
    timeoutlen = 300;
    title = true;
    titlestring = "%m %{expand('%:p') == '' || expand('%:p') == expand('%:p:h') . '/' ? '' : fnamemodify(expand('%'), ':~:.') . ' - '} %{stridx(expand('%:p'), getcwd()) == 0 ? fnamemodify(getcwd(), ':t') . ' - ' : ''} %{mode() == 'n' ? 'NORMAL' : mode() == 'i' ? 'INSERT' : mode() == 'v' ? 'VISUAL' : mode() == 'V' ? 'VISUAL LINE' : mode() == 'R' ? 'REPLACE' : mode() == 's' ? 'SELECT' : mode() == 't' ? 'TERMINAL' : mode() == 'c' ? 'COMMAND' : mode()} | Neovim";
    undofile = true;
    undolevels = 10000;
    updatetime = 200;
    wrap = false;
  };
}
