local monitor = peripheral.find("monitor")

-- Functie om de items van de chest te printen op de monitor
function print_items(chest, monitor)
    local items = chest.list()
    local monitorWidth, monitorHeight = monitor.getSize()
    local y = 2
    for i, item in pairs(items) do
        local name = string.gsub(item.name, "minecraft:", "")
        name = string.gsub(name, "_", " ")
        name = name:gsub("^%l", string.upper)
        local x = math.max((monitorWidth - #name) / 2, 0)
        monitor.setCursorPos(x, y)
        monitor.setTextColor(colors.white)
        monitor.write(name)
        y = y + 2
    end
end

-- Functie om de hoeveelheid van de items van de chest te printen op de monitor
function print_counts(chest, monitor)
    local items = chest.list()
    local monitorWidth, monitorHeight = monitor.getSize()
    local y = 3
    for i, item in pairs(items) do
        local count = item.count .. "x"
        local x = math.max((monitorWidth - #count) / 2, 0)
        monitor.setCursorPos(x, y)
        monitor.setTextColor(colors.lightGray)
        monitor.write(count)
        y = y + 2
    end
end

-- Functie om de items en hoeveelheden van de chest te printen op de monitor
function print_inventory_on_monitor(chest, monitor)
    monitor.clear()
    print_items(chest, monitor)
    print_counts(chest, monitor)
end



-- De while loop om elke 10 seconden de monitor te updaten
-- *Haal de comment bij de while loop weg als je in-game test*

while true do
    local monitor = peripheral.find("monitor")
    local chest = peripheral.find("chest")

    if monitor and chest then
        print_inventory_on_monitor(chest, monitor)
    else
        if not monitor then
            print("Monitor not found")
        end
        if not chest then
            print("Chest not found")
        end
    end

    sleep(10)
end