;;          __
;;         ( o`-
;;         /  \
;;         |  |
;;          ^^ BP
;;
;; Fennel Config for NVIM
;;    by Jalen Moore
;;
;; Why Fennel? Well... why not!
;;

;; Import external config.
(require :keybinds)
; (require :lsp)

;; General Settings.
(let [o vim.o]
  (set o.cursorline true)
  (set o.tabstop 4)
  (set o.shiftwidth 4)
  (set o.softtabstop 4)
  (set o.autoindent true)
  (set o.number true)
  (set o.wrap true)
  (set o.scrolloff 3)
  (set o.wildmenu true)
  (set o.wrap true)
  (set o.autoread true)
  ;(set o.dir "~/tmp")
  (set o.hidden true)
  (set o.cc 125))

;; Git
(let [gitsigns (require :gitsigns)]
  (gitsigns.setup {}))

;; Telescope
(let [telescope (require :telescope)]
  (let [actions (require "telescope.actions")]
    (telescope.setup 
      {:defaults 
	   {:mappings 
        {:i 
         {"<esc>" actions.close}}}}))
  (telescope.load_extension "file_browser"))

;; Indent Blankline
(let [indent (require :ibl)]
  (indent.setup))

;; Aesthetics
; lualine
(let [lualine (require :lualine)]
  (lualine.setup 
    {:options
     {"icons_enabled" 1
      "theme" :auto}
     :sections 
     {"lualine_a" [:mode]
      "lualine_b" [:branch :diff]
      "lualine_c" [:filename]
      "lualine_x" [:filetype]
      "lualine_y" [:progress]
      "lualine_z" [:location]}}))

; incline (file name at top right)
; (let [incline (require :incline)]
;  (incline.setup {}))

; oxocarbon theme
(set vim.opt.background :dark)
(vim.cmd "colorscheme oxocarbon")

; Toggle Term
(let [toggleterm (require :toggleterm)]
  (toggleterm.setup {}))

; Tree-sitter
(let [treesitter (require "nvim-treesitter.configs")]
  (treesitter.setup 
    ;{"ensure_installed" [:c :cpp :vue :javascript :html :css 
    ;                     :vim :lua :fennel :glsl :diff :commonlisp 
    ;                     :latex :typescript :markdown]
    ; "sync_install" false
	{"auto_install" false
     "highlight" {:enable 1}}))

; glow 
(let [glow (require "glow")]
  (glow.setup))
