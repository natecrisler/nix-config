{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = indent-blankline-nvim;
      config =
        "lua require('indent_blankline').setup{char_highlight_list={'IndentBlankLine'}}";
    }
    {
      plugin = nvim-web-devicons;
      config = "lua require('nvim-web-devicons').setup{}";
    }
    {
      plugin = gitsigns-nvim;
      config = "lua require('gitsigns').setup()";
    }
    {
      plugin = nvim-colorizer-lua;
      config = ''
        set termguicolors
        lua require('colorizer').setup()
      '';
    }

    {
      plugin = barbar-nvim;
      config = ''
        let bufferline = get(g:, 'bufferline', {})
        let bufferline.animation = v:true
        nmap <C-h> :BufferPrevious<CR>
        nmap <C-l> :BufferNext<CR>
        nmap <C-q> :BufferClose<CR>
        nmap <C-a> :BufferPick<CR>
      '';
    }

    {
      plugin = nvim-tree-lua;
      config = ''
        lua require('nvim-tree').setup{}
        nmap <C-p> :NvimTreeToggle<CR>
      '';
    }
  ];
}