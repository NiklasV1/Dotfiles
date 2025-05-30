local function _getBackendFeaturePath()
	local filepath = vim.fn.expand("%")

	return string.match(filepath, ".*/packages/server/[^/]*/[^/]*/")
end

-- NOTE: Work related utility functions
return {
	-- NOTE: Gets the path of the current feature when in the backend
	getBackendFeaturePath = function()
		return _getBackendFeaturePath()
	end,

	goToFeaturePath = function()
		return "cd " .. _getBackendFeaturePath()
	end,
}
