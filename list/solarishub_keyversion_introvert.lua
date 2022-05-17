--// dependencies for crack

local crackVariables = {
    timeCheckpoint = 1652753542,
    validKeyResponse = syn.crypt.base64.decode("MTAxRQMHAwUDBAMHAwcDBwMFAwgDBAMJAwkDBwMFAwIDBAMHAwYDCAMCAgEDCQMCAwkDBAMGAwkDAgIBAwMDBAMGAwkCAQMGAwYDCQMJAwkDBgMGAwcDCAMJAwICAQMGAwkDBQMBAwMDCQMJAwkDBQMGAwcDCAMJAwIDCAMEAwQDBgMBAwcDAgMHAwYDBwMHAwUDBwMFAwcDAwMGAwQDAwMGAwUDBAMJAwIDBQMBAwcDAwMIAwcDCAMEAwkDCQMHAwgDAwMIAwEDBQMCAwI1MDUzNzczMDU1MDI1MDE0OTgzNjk1NjIzMDk2MjY2MjU1MDMyNjExMzEyNjU0NTEzOTM1MTUxMzE2NzU4MzEzMTU4NTI1OTM5MTU3OTEzNTY3MTk1MjU5Mzg5NTc5NjUzODczOTA1Nzk1Nzg1NzkzODYzODc0NTY1MTU1NzcxMzE2OTM4NzU3OTM3NDExNTI0MTYzMDYyNjYzMjM3MDQzNjUwMjU2NDYzMzE3OTU2NjMwNjMwOTQzNzExMjQ5ODE4MTQ5NjQzMzQ5ODUwMDM3MDQ5OTM3NTUwMjI0MTQzMzMwOTI0NDQzNjM2ODMwNTYzMjE4MTM2OTExOTUwNDI0NTU2NjQ5NzU2MTMwNTYyODYyNzUwMzU2MDI0MjU2NDEyMDM2OTE3NjE4Mg=="),
    validWhitelistResponse = syn.crypt.base64.decode("NDZFAwgDBwMFAwkDBAMHAwgDBAMHAwYDAgMHAwQDBAMDAgECAQMDAwMDAgMEAwkDBQMHAwYDAwMHAwMDBgMJAwcDBgMCAwYDCQMEAwMDBwMIAwIDAwMDAwMDCQMEAwg1NjE0OTczNzM2MzAzMTM0OTk1NjAzMDQ1MDA0MzYxODU1MDIzMjUyNTkxOTg2NzcxMTk1MjAxMTMxMjYzNTc5MzI0NDUxMzg3MjQ0NTA1MjQ0NDM2NjI2NTAxNDM3MTgxNDMzNjI4MzA2MjQzNDk5NTY1MTgzMjQxMjQ3MjQ4NjI1MzA1NTY3")
}

--// request hook

local oldSynRequest
oldSynRequest = replaceclosure(syn.request, function(payload)
    if payload.Url == "https://key.solarishub.net/check" then
        return {Body = crackVariables.validKeyResponse}
    elseif payload.Url == "https://wl.solarishub.net/" then
        return {Body = crackVariables.validWhitelistResponse}
    end

    warn("unhandled syn request")
end)

--// backups

local oldHttpGet
oldHttpGet = replaceclosure(game.HttpGet, function(self, url, cache)
    if url == "https://solarishub.net/UI.lua" then
        return oldHttpGet(self, "https://raw.githubusercontent.com/antiskids-xyz/Misc/load/SolarisHub/UILibrary.lua", cache)
    elseif url:find("Mlemix") then
        return oldHttpGet(self, url:gsub("Mlemix", "Introvert1337"), cache)
    end
    
    warn("unhandled http request")
end)

--// connections for when the key gui is added

local coreGuiAddedConnection
coreGuiAddedConnection = game:GetService("CoreGui").ChildAdded:Connect(function(child)
    if child.Name == "ScreenGui" then
        coreGuiAddedConnection:Disconnect()
        
        local libraryAddedConnection
        libraryAddedConnection = child.DescendantAdded:Connect(function(child)
            if child.ClassName == "TextButton" then
                task.wait()
                
                if child.Text == "Submit" then
                    --// hook os.time here since this runs after their shitty anti hooks
                    
                    local oldOsTime
                    oldOsTime = replaceclosure(os.time, function(timeData)
                        if checkcaller() then
                            return crackVariables.timeCheckpoint
                        end
                        
                        return oldOsTime(timeData)
                    end)
                    
                    --// press the submit button (scuffed)
                    
                    libraryAddedConnection:Disconnect()
        
                    while select(2, pcall(function() getconnections(child.MouseButton1Click)[1].Function() end)) do -- scuffed but errors for like 2s and firesignal doesnt work
                        task.wait(0.1)
                    end
                end
            end
        end)
    end
end)

--// load script

local scriptUrls = {
    baseUrl = "https://raw.githubusercontent.com/antiskids-xyz/Misc/load/SolarisHub/Games/%s.lua",
    universalUrl = "https://raw.githubusercontent.com/antiskids-xyz/Misc/load/SolarisHub/Games/Universal.lua"
}

local response = select(2, pcall(function()
    return loadstring(game:HttpGet(scriptUrls.baseUrl:format(game.PlaceId))) or loadstring(game:HttpGet(scriptUrls.baseUrl:format(game.GameId)))
end))

if type(response) ~= "function" then
    return loadstring(game:HttpGet(scriptUrls.universalUrl))()
end

response()
