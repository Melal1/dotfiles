local status, comment = pcall(require, "Comment")
if not status then 
  vim.notify("Comment Pllugins is not installd !")
  return
end



comment.setup()
