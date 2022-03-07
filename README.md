# Better Digraphs
Digraphs are incredibly useful, but oftentimes hard to remember. The `h digraph-table` and `h digaph-table-mbyte` entries are helpful, but cumbersome and their usage tends to interrupt the natural flow that every nvim user aspires to. Enter better-digraphs, a plugin that improves the digraph experience in nvim by adding the contents of the `digraph-table-mbyte` to a telescope finder.

# Example
https://user-images.githubusercontent.com/3252946/155826375-69ec4a47-645a-4fe6-8724-162479973e65.mov

# Installation
Using vim plug
```vim
Plug 'nvim-telescope/telescope.nvim'
Plug 'protex/better-digraphs'
```





# Usage
The recommended mappings for this plugin are the following:
```vim
inoremap <C-k><C-k> <Cmd>lua require'betterdigraphs'.digraphs("i")<CR>
nnoremap r<C-k><C-k> <Cmd>lua require'betterdigraphs'.digraphs("r")<CR>
vnoremap r<C-k><C-k> <ESC><Cmd>lua require'betterdigraphs'.digraphs("gvr")<CR>
```

This will allow the usage of the normal `<C-k>` in insert mode, single character replace, and multiple character replace, but allows you to quickly pull up the search if you can't remember the digraph you're looking for. The search will allow you to fuzzy search by either digraph shortcut (OK for ✓) or official name ("CHECK MARK" for ✓).
