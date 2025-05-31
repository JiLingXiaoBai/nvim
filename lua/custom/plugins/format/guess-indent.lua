-- Detect tabstop and shiftwidth automatically
return {
  'NMAC427/guess-indent.nvim',
  event = "BufReadPre",
  opts = {
    auto_cmd = true,
    override_editorconfig = true
  },
}
