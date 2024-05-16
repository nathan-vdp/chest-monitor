-- Please don't run this script on your own computer. It is meant to be run on a ComputerCraft computer.

local github_url = "https://raw.githubusercontent.com/nathan-vdp/chest-monitor/main/chest_monitor.lua"
local startup_path = "/startup.lua"
local chest_monitor_path = "/chest_monitor.lua"

-- Function to download a file from a URL
local function downloadFile(url, path)
    local response = http.get(url)
    if response then
        local status = response.getResponseCode()
        if status == 200 then
            local content = response.readAll()
            local file = fs.open(path, "w")
            if file then
                file.write(content)
                file.close()
                print("File " .. path .. " successfully downloaded.")
            else
                print("Could not open file " .. path .. " for writing.")
            end
        else
            print("Failed to download " .. path .. ". HTTP response code: " .. status)
        end
    else
        print("Failed to connect to " .. url)
    end
end

-- Download chest_monitor.lua from GitHub
downloadFile(github_url, chest_monitor_path)

-- Create startup.lua that runs chest_monitor.lua on startup
local startup_script = [[
shell.run("]] .. chest_monitor_path .. [[")
]]
local startup_file = fs.open(startup_path, "w")
if startup_file then
    startup_file.write(startup_script)
    startup_file.close()
    print("startup.lua successfully created.")
else
    print("Could not open " .. startup_path .. " for writing.")
end

-- Reboot the computer to automatically start the chest monitor
os.reboot()
