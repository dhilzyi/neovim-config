-- lua/custom/floaterm.lua
local M = {} -- Create a module table

-- 1. State
_G.float_state = _G.float_state or {
	win = -1,
	tabs = {},
	active_idx = 1,
}

-- 2. Local Functions (Hidden from the rest of Neovim)
local function get_float_dims()
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)
	return { width = width, height = height, row = row, col = col }
end

local function update_title()
	local state = _G.float_state
	if vim.api.nvim_win_is_valid(state.win) then
		local title = string.format(" Tab %d / %d ", state.active_idx, #state.tabs)
		vim.api.nvim_win_set_config(state.win, { title = title, title_pos = "center" })
	end
end

local function create_new_buffer()
	local buf = vim.api.nvim_create_buf(false, false)
	vim.api.nvim_set_option_value("bufhidden", "hide", { buf = buf })
	return buf
end

local function save_current_tab_state()
	local state = _G.float_state
	if not vim.api.nvim_win_is_valid(state.win) then
		return
	end

	local current_buf = vim.api.nvim_win_get_buf(state.win)
	local current_mode = vim.fn.mode()

	if state.tabs[state.active_idx] then
		state.tabs[state.active_idx].buf_id = current_buf
		state.tabs[state.active_idx].mode = current_mode
	end
end

local function switch_to_tab()
	local state = _G.float_state
	if not vim.api.nvim_win_is_valid(state.win) then
		return
	end

	local tab = state.tabs[state.active_idx]

	if not vim.api.nvim_buf_is_valid(tab.buf_id) then
		tab.buf_id = create_new_buffer()
		tab.mode = "n"
	end

	vim.api.nvim_win_set_buf(state.win, tab.buf_id)
	update_title()

	local buf_name = vim.api.nvim_buf_get_name(tab.buf_id)
	local is_empty = vim.api.nvim_buf_line_count(tab.buf_id) <= 1
	local is_normal = vim.bo[tab.buf_id].buftype == ""

	if is_normal and is_empty and buf_name == "" then
		vim.cmd("terminal")
		tab.mode = "t"
	end

	if tab.mode == "t" or tab.mode == "i" then
		vim.cmd("startinsert")
	else
		vim.cmd("stopinsert")
	end
end

local function new_tab()
	save_current_tab_state()
	local state = _G.float_state
	local new_buf = create_new_buffer()

	table.insert(state.tabs, { buf_id = new_buf, mode = "t" })
	state.active_idx = #state.tabs

	if vim.api.nvim_win_is_valid(state.win) then
		switch_to_tab()
	end
end

local function close_tab()
	local state = _G.float_state
	if #state.tabs == 0 then
		return
	end

	local buf_to_kill = state.tabs[state.active_idx].buf_id
	table.remove(state.tabs, state.active_idx)

	if state.active_idx > #state.tabs then
		state.active_idx = #state.tabs
	end

	if #state.tabs == 0 then
		local new_buf = create_new_buffer()
		table.insert(state.tabs, { buf_id = new_buf, mode = "t" })
		state.active_idx = 1
	end

	if vim.api.nvim_win_is_valid(state.win) then
		switch_to_tab()
	end

	if vim.api.nvim_buf_is_valid(buf_to_kill) then
		vim.api.nvim_buf_delete(buf_to_kill, { force = true })
	end
end

local function cycle_tab(direction)
	save_current_tab_state()
	local state = _G.float_state
	if #state.tabs < 2 then
		return
	end

	state.active_idx = state.active_idx + direction
	if state.active_idx > #state.tabs then
		state.active_idx = 1
	end
	if state.active_idx < 1 then
		state.active_idx = #state.tabs
	end

	switch_to_tab()
end

local function toggle_float()
	local state = _G.float_state
	local dims = get_float_dims()

	if vim.api.nvim_win_is_valid(state.win) then
		save_current_tab_state()
		vim.api.nvim_win_hide(state.win)
	else
		if #state.tabs == 0 then
			local first_buf = create_new_buffer()
			table.insert(state.tabs, { buf_id = first_buf, mode = "t" })
		end

		local target_tab = state.tabs[state.active_idx]
		if not vim.api.nvim_buf_is_valid(target_tab.buf_id) then
			target_tab.buf_id = create_new_buffer()
			target_tab.mode = "t"
		end

		state.win = vim.api.nvim_open_win(state.tabs[state.active_idx].buf_id, true, {
			relative = "editor",
			width = dims.width,
			height = dims.height,
			row = dims.row,
			col = dims.col,
			style = "minimal",
			border = "rounded",
		})
		vim.api.nvim_set_hl(0, "MyFloatBorder", { fg = "#f3ebf5" })
		vim.api.nvim_set_option_value("winhl", "Normal:Normal,FloatBorder:MyFloatBorder", { win = state.win })

		switch_to_tab()
	end
end

-- 3. Public Setup Function
function M.setup()
	-- KEYBINDINGS
	vim.keymap.set({ "n", "t" }, "<C-\\>", toggle_float, { desc = "Toggle Float" })
	vim.keymap.set({ "n", "t" }, "<M-n>", new_tab, { desc = "New Float Tab" })
	vim.keymap.set({ "n", "t" }, "<M-x>", close_tab, { desc = "Close Float Tab" })
	vim.keymap.set({ "n", "t" }, "<M-]>", function()
		cycle_tab(1)
	end, { desc = "Next Float Tab" })
	vim.keymap.set({ "n", "t" }, "<M-[>", function()
		cycle_tab(-1)
	end, { desc = "Prev Float Tab" })
end

return M -- Return the module
