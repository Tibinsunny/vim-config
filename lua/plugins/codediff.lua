return {
  "esmuellert/codediff.nvim",
  cmd = { "CodeDiff" },
  keys = {
    { "<leader>cv", "<cmd>CodeDiff<cr>", desc = "CodeDiff Explorer" },
    { "<leader>ch", "<cmd>CodeDiff history<cr>", desc = "CodeDiff History" },
  },
  opts = {
    diff = {
      layout = "side-by-side",
      compute_moves = true,
      -- This controls how many unchanged lines are left visible around changes.
      -- Keeping it low forces the plugin to collapse the large unchanged sections.
      compact_context_lines = 3,
      compact_sync_folds = true, -- Keeps the collapsed sections synchronized between left/right panes
    },
    explorer = {
      width = 35,
      view_mode="tree"
    },
  },
  config = function(_, opts)
    require("codediff").setup(opts)
  end,
}
