--[[ Download and run this.
	Downloads main.lua and all dependencies
	and executes main.lua with the arguments
	it was executed with.
]]
local repoURL = 'https://github.com/RC-14/turtleScrips'
local filesPath = '/EndlessMining'
local librariesPath = '/libraries'

--[[
	All files in the project folder (eg. "/EndlessMining")
	except "run.lua".
]] local files = {
    'main.lua'
}

--[[
	All files in the libraries folder
	that are required by the program.
]] local libraries = {}

local function download(url, path)
    local response = http.get(url)
    local status = response.getResponseCode()

    if not (status == 0 or (status >= 200 and status < 400)) then
        return false, 'http', status -- request was not successfull
    end

    local file = fs.open(path, 'w')

    if file == nil then
        return false, 'file', 'read only' -- can't write to that location
    end

    local contents = response.readAll()

    file.write(contents)
    file.close()

    file = fs.open(path, 'r')
    if file == nil then
        return false, 'file', "can't read" -- can't read from that location
    end

    if file.readAll() ~= contents then
        return false, 'file', 'faulty write' -- contents of the file aren't what they should be
    end

    file.close()

    return true, url, path -- downloaded the file successfully
end
