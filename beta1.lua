shell.run("clear")
print("Welcome to KVERO OS!")
location = "" -- to be used later
inmain = 0

if installer then
    installer = 0
else
    installer = 1
end

local success, result = pcall(function()
    local installerScript = loadfile("installer.lua")
    if installerScript then
        installerScript()
    else
        error("Failed to load installer.lua")
    end
end)

if not success then
    installer = 1
end

if installer == 1 then
    print("Try or install KVERO t/i")
    while true do
        res = io.read()
        if res == "i" or res == "t" then
            break
        end
    end
    if res == "i" then
        local file = io.open("installer.lua", "w")
        file:write("installer = 0")
        file:close()
        installer = 0
        io.open("startup.lua")
        shell.run("cp /disk/* /startup.lua")
    end
end

while true do
    io.write(location .. " > ")
    user = io.read()
    if inmain == 0 then
        if user == "mainshell" then
            inmain = 1
        else
            if user == "driver mod" then
                print("KVERO driver mod")
                if drivers then
                    io.write("drivers exist, create new driver? y/n: ")
                    res = io.read()
                    if res == "yes" or res == "y" then
                        io.write("driver name: ")
                        res = io.read()
                        io.write("driver file path: ")
                        res1 = io.read()
                        drivers[res] = res1
                    end
                else
                    io.write("create new driver system? y/n: ")
                    res = io.read()
                    if res == "yes" or res == "y" then
                        io.write("driver name: ")
                        res = io.read()
                        io.write("driver file path: ")
                        res1 = io.read()
                        drivers = {}
                        drivers[res] = res1
                    end
                end
            end
        end
    else
        if user == "exit mainshell" then
            inmain = 0
        else
            shell.run(user)
        end
    end
end
