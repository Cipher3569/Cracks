--// get correct key on decode

local correctKey -- as of release it is GasFloor
    
local oldJsonDecode
oldJsonDecode = replaceclosure(game:GetService("HttpService").JSONDecode, function(self, string)
    local response = oldJsonDecode(self, string)
    
    correctKey = response.Pizza -- change .Pizza to whatever it is for the scriptmaka script ur cracking
    
    return response
end)

--// backup stuff

local urlReplacements = {
    ["https://raw.githubusercontent.com/big-balla-script-maka/free-scripts/main/NumberSpinner"] = game:HttpGet("https://raw.githubusercontent.com/antiskids-xyz/Misc/load/ScriptMakaPizza/NumberSpinner.lua"),
    ["https://raw.githubusercontent.com/xHeptc/forumsLib/main/source.lua"] = game:HttpGet("https://raw.githubusercontent.com/antiskids-xyz/Misc/load/ScriptMakaPizza/UILibrary.lua")
}

local oldHttpGet
oldHttpGet = replaceclosure(game.HttpGet, function(self, url, cache)
    if urlReplacements[url] then
        return urlReplacements[url]
    end
    
    return oldHttpGet(self, url, cache)
end)

--// auto fill out gui

local coreGuiAddedConnection
coreGuiAddedConnection = game:GetService("CoreGui").ChildAdded:Connect(function(child)
    if child.Name == "ScreenGui" then
        coreGuiAddedConnection:Disconnect()
        
        local textBox = child:WaitForChild("Frame"):WaitForChild("TextBox")
        
        textBox.Text = correctKey
        firesignal(textBox.FocusLost)
    end
end)

--// load script

loadstring(game:HttpGet("https://raw.githubusercontent.com/antiskids-xyz/Misc/load/ScriptMakaPizza/ScriptBackup.lua"))()
