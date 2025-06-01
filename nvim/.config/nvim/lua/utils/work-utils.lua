local function _getBackendFeaturePath()
	local filepath = vim.fn.expand("%:p")

	return string.match(filepath, ".*/packages/server/[^/]*/[^/]*/")
end

-- NOTE: Work related utility functions
return {
	-- @return string
	-- @usage Returns the path of the current feature in the backend
	getBackendFeaturePath = function()
		return _getBackendFeaturePath()
	end,

	-- @return string
	-- @usage Returns a command to change directory to the current feature path
	goToFeaturePath = function()
		return "cd " .. _getBackendFeaturePath()
	end,
}
