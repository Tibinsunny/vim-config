return {
    "sindrets/diffview.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    cmd = {
        "DiffviewOpen",
        "DiffviewClose",
        "DiffviewToggleFiles",
        "DiffviewFocusFiles",
        "DiffviewRefresh",
        "DiffviewFileHistory",
    },
    keys = {
        { "<leader>do", "<cmd>DiffviewOpen<CR>", desc = "Open Diffview" },
        { "<leader>dc", "<cmd>DiffviewClose<CR>", desc = "Close Diffview" },
        { "<leader>dh", "<cmd>DiffviewFileHistory %<CR>", desc = "File History" },
        { "<leader>dH", "<cmd>DiffviewFileHistory<CR>", desc = "Repo History" },
    },
    opts = {},
}
