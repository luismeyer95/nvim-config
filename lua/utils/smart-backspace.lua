local escape_code = vim.api.nvim_replace_termcodes(
  "<Esc>",
  false, false, true
)
local backspace_code = vim.api.nvim_replace_termcodes(
  "<BS>",
  false, false, true
)

local function viml_backspace()
  -- expression from a deleted reddit user
  vim.cmd([[
        let g:exprvalue =
        \ (&indentexpr isnot '' ? &indentkeys : &cinkeys) =~? '!\^F' &&
        \ &backspace =~? '.*eol\&.*start\&.*indent\&' &&
        \ !search('\S','nbW',line('.')) ? (col('.') != 1 ? "\<C-U>" : "") .
        \ "\<bs>" . (getline(line('.')-1) =~ '\S' ? "" : "\<C-F>") : "\<bs>"
        ]])
  return vim.g.exprvalue
end

local function backspace()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local before_cursor_is_whitespace = vim.api.nvim_get_current_line()
      :sub(0, col)
      :match("^%s*$")

  if not before_cursor_is_whitespace then
    return require('nvim-autopairs').autopairs_bs()
  end
  if line == 1 then
    return viml_backspace()
  end
  local correct_indent = require("nvim-treesitter.indent").get_indent(line)
  local current_indent = vim.fn.indent(line)
  local previous_line_is_whitespace = vim.api.nvim_buf_get_lines(
    0, line - 2, line - 1, false
  )[1]:match("^%s*$")
  if current_indent == correct_indent then
    if previous_line_is_whitespace then
      return viml_backspace()
    end
    return backspace_code
  elseif current_indent > correct_indent then
    return escape_code .. "==0wi"
  end
  return backspace_code
end

return backspace
