--[[ Download and run this.
	Downloads main.lua and all dependencies
	and executes main.lua with the arguments
	it was executed with.
]]
--

local baseURI = 'https://github.com/RC-14/turtleScrips'
local filesPath = '/EndlessMining'
local librariesPath = '/libraries'

--[[
	All files in the project folder (eg. "/EndlessMining")
	except "run.lua".
]] local files = {
    'main.lua'
}
--

--[[
	All files in the libraries folder
	that are required by the program.
]] local libraries = {}
