;; Custom Keybinds
; Excludes binds defined in plugin setups.

;; Keybindings
(let [map vim.api.nvim_set_keymap]
  ; Telescope
  (map "n" ",f" "<cmd>lua require('telescope').extensions.file_browser.file_browser()<cr>" {})
  (map "n" ",d" "<cmd>lua require('telescope.builtin').find_files()<cr>" {})
  (map "n" ",g" "<cmd>lua require('telescope.builtin').live_grep()<cr>" {})
  (map "n" ",b" "<cmd>lua require('telescope.builtin').buffers()<cr>" {})
  (map "n" "/" "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>" {})

  ; nabla latex math
  (map "n" ",p" "<cmd>lua require('nabla').popup()<cr>" {})
  (map "n" ",l" "<cmd>lua require('nabla').toggle_virt()<cr>" {})

  ; Toggle Term
  (map "n" ",m" "<Cmd>exe v:count1 . 'ToggleTerm'<CR>" {})
  (map "i" ",m" "<Esc><Cmd>exe v:count1 . 'ToggleTerm'<CR>" {})
  (map "t" ",m" "<Cmd>exe v:count1 . 'ToggleTerm'<CR>" {}))

