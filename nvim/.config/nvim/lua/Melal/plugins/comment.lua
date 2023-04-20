local status, comment = pcall(require, "Comment")
if not status then
	vim.notify("Comment Plugin is not installd !")
else
	comment.setup()
end
