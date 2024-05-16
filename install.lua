-- Github URL van het script dat geïnstalleerd moet worden
url = "https://github.com/nathan-vdp/chest-monitor/blob/main/chest_monitor.lua"

-- Function to download a file from a URL
local function downloadFile(url, path)
    local response = http.get(url)
    if response and response.getResponseCode() == 200 then
        local content = response.readAll()
        local file = fs.open(path, "w")
        file.write(content)
        file.close()
        print("File " .. path .. " downloaded successfully.")
    else
        print("Failed to download " .. path)
    end
end

-- Controleer de status van de response
if status == 200 then
    -- Als de status 200 is, sla de response op als een bestand
    local file = fs.open("chest_monitor.lua", "w")
    file.write(response)
    file.close()

    -- Maak een startup.lua bestand dat het chest_monitor.lua script uitvoert
    local startup = fs.open("startup.lua", "w")
    startup.write("os.run({}, \"chest_monitor.lua\")")
    startup.close()
else
    -- Als de status niet 200 is, print een foutbericht
    print("HTTP request failed with status: " .. status)
end
