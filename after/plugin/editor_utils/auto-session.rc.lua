local status, auto_session = pcall(require, "auto-session")
if not status then
  return
end

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-- check docs: https://github.com/rmagatti/auto-session
auto_session.setup({
  log_level = "info",
  auto_session_enable_last_session = false,
  auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
  auto_session_enabled = false, -- not working with neo-tree
  auto_save_enabled = false,
  auto_restore_enabled = nil,
  auto_session_suppress_dirs = nil,
  auto_session_use_git_branch = false,
  -- the configs below are lua only
})
