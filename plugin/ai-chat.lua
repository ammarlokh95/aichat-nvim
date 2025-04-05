local map = vim.keymap
map.set("n", "ais", ":lua require('ai-chat').start_new_chat()<CR>")

map.set("n", "aip", ":lua require('ai-chat').prompt()<CR>")
