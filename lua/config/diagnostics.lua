local M = {}

function M.setup()
  vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    severity_sort = true,
    update_in_insert = false,
    float = {
      border = "rounded",
      source = "always",
    },
  })

  -- manual floating window
  vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)

  -- faster hover responsiveness
  vim.o.updatetime = 250

  -- auto popup on cursor hold
  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
      vim.diagnostic.open_float(nil, { focus = false })
    end,
  })
end

return M
