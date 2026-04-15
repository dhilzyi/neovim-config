local function getDirectoryName()
	local cwd = vim.fn.getcwd()
	local splitted = vim.split(cwd, "/")
	if #splitted ~= 0 then
		local sliced = vim.fn.slice(splitted, #splitted - 2)
		local joined = vim.fn.join(sliced, "_")
		return joined
	else
		vim.api.nvim_echo({ { "Not exist" } }, true, {})
	end
end

local function openNote(path)
	local buf = vim.fn.bufadd(path)
	vim.fn.bufload(buf)
	vim.api.nvim_open_win(buf, true, { split = "right" })
end

local function todoDirectory()
	local dirName = getDirectoryName()
	local path = vim.fn.expand("~/notes/" .. dirName .. ".md")
	openNote(path)
end

local function todoGlobal()
	local path = vim.fn.expand("~/notes/todo.md")
	openNote(path)
end

vim.keymap.set("n", "<leader>ng", todoGlobal, { desc = "Open TODO notes." })
vim.keymap.set("n", "<leader>np", todoDirectory, { desc = "Open Project notes." })
