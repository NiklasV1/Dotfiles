local function is_backend_dir(filename)
	if string.match(filename, "snapaddy%-backend") then
		return true
	end

	return false
end

return {
	is_backend_dir = is_backend_dir,
}
