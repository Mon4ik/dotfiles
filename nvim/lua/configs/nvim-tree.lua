return {
    view = {
        width = 32,
    },
    renderer = {
        root_folder_label = false,
        highlight_git = true,
        indent_markers = { enable = true },
        icons = {
            git_placement = "signcolumn",
            glyphs = {
                default = "󰈚",
                folder = {
                    default = "",
                    empty = "",
                    empty_open = "",
                    open = "",
                    symlink = "",
                },
                git = {
                    unstaged = "•",
                    staged = "+",
                    unmerged = "",
                    renamed = "",
                    untracked = "*",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
}
