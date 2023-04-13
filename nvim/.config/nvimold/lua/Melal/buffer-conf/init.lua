require"bufferline".setup{
    options = {
            mappings = true,
            buffer_close_icon= "",
            modified_icon = "●",
            close_icon = "",
            left_trunc_marker = "",
            right_trunc_marker = "",
            max_name_length = 18,
            max_prefix_length = 15, -- prefix used when a buffer is deduplicated
            tab_size = 18,
        }

}

vim.keymap.set("n", "<silent><S-TAB>", vim.cmd [[:BufferLineCyclePrev]])
