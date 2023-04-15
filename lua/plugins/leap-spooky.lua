return {
  "ggandor/leap-spooky.nvim",
  lazy = false,
  dependencies = { "ggandor/leap.nvim" },
  opts = {
    affixes = {
      -- These will generate mappings for all native text objects, like:
      -- (ir|ar|iR|aR|im|am|iM|aM){obj}.
      -- Special line objects will also be added, by repeating the affixes.
      -- E.g. `yrr<leap>` and `ymm<leap>` will yank a line in the current
      -- window.
      -- You can also use 'rest' & 'move' as mnemonics.
      remote   = { cross_window = 'r' },
      magnetic = { cross_window = 'm' },
    },
    -- If this option is set to true, the yanked text will automatically be pasted
    -- at the cursor position if the unnamed register is in use.
    paste_on_remote_yank = false,
  }
}
