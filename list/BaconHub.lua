--Owner exit scammed so here's the source, most of it is skidded and written horribly 

if game.PlaceId == 2753915549 or game.PlaceId == 4442272183 or game.PlaceId == 7449423635 then

    setfpscap(1000)
    repeat wait() until game:IsLoaded()
   
    
    if _G.Team == "Pirate" then
        for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.MouseButton1Click)) do
            v.Function()
        end
    elseif _G.Team == "Marine" then
        for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.MouseButton1Click)) do
            v.Function()
        end
    else
        for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.MouseButton1Click)) do
            v.Function()
        end
    end
    
    wait(1)
    local Toggles = {
        AutoFarm = false
    }
    
    lib=loadstring(game:HttpGet"https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/UILibrary.lua")()
    local win = lib:CreateWindow("Blox Fruits", Vector2.new(492, 598), Enum.KeyCode.RightShift)
    
    
    local tab2 = win:CreateTab("AutoFarm")
    local tab3 = win:CreateTab("BuyItems")
    local tab5 = win:CreateTab("Misc")
    local tab4 = win:CreateTab("Teleports")
    local tab1 = win:CreateTab("Player")
    local tab6 = win:CreateTab("Settings")
    local sector5 = tab1:CreateSector("ESP","right")
    local sector1 = tab1:CreateSector("Universal","left")
    local sector2 = tab2:CreateSector("AutoFarm","left")
    local sector3 = tab2:CreateSector("Misc","right")
    local sector4 = tab3:CreateSector("Buy Item","left")
    local sector7 = tab5:CreateSector("Devil Fruits","left")
    local sector8 = tab5:CreateSector("Select Specfic Mob","right")
    local sector9 = tab5:CreateSector("Auto Raid","left")
    local sector11 = tab5:CreateSector("Auto Stats","right")
    local sector6 = tab4:CreateSector("Teleports","left")
    local sector10 = tab6:CreateSector("Settings","Left")
    
    
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local Mouse = LocalPlayer:GetMouse()
    local HttpService = game:GetService("HttpService")
    
    
    
        
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local Deleted = false
    local File = pcall(function()
        AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
    end)
    if not File then
        table.insert(AllIDs, actualHour)
        writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
    end
    function TPReturner()
        local Site;
        if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
        else
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
        end
        local ID = ""
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end
        local num = 0;
        for i,v in pairs(Site.data) do
            local Possible = true
            ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _,Existing in pairs(AllIDs) do
                    if num ~= 0 then
                        if ID == tostring(Existing) then
                            Possible = false
                        end
                    else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            --delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    --writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
                end
            end
        end
    end
    
    function Teleport()
        while wait() do
            pcall(function()
                TPReturner()
                if foundAnything ~= "" then
                    TPReturner()
                end
            end)
        end
    end
    
    function HopLowerServer()
        local maxplayers, gamelink, goodserver, data_table = math.huge, "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        if not _G.FailedServerID then _G.FailedServerID = {} end
        local function serversearch()
            data_table = game:GetService"HttpService":JSONDecode(game:HttpGetAsync(gamelink))
            for _, v in pairs(data_table.data) do
                pcall(function()
                    if type(v) == "table" and v.id and v.playing and tonumber(maxplayers) > tonumber(v.playing) and not table.find(_G.FailedServerID, v.id) then
                        maxplayers = v.playing
                        goodserver = v.id
                    end
                end)
            end
        end
        function getservers()
            pcall(serversearch)
            for i, v in pairs(data_table) do
                if i == "nextPageCursor" then
                    if gamelink:find"&cursor=" then
                        local a = gamelink:find"&cursor="
                        local b = gamelink:sub(a)
                        gamelink = gamelink:gsub(b, "")
                    end
                    gamelink = gamelink .. "&cursor=" .. v
                    pcall(getservers)
                end
            end
        end
        pcall(getservers)
        if goodserver == game.JobId or maxplayers == #game:GetService"Players":GetChildren() - 1 then
        end
        table.insert(_G.FailedServerID, goodserver)
        game:GetService"TeleportService":TeleportToPlaceInstance(game.PlaceId, goodserver)
    end
    
    Wapon = {}
    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do  
        if v:IsA("Tool") then
           table.insert(Wapon ,v.Name)
        end
    end
    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do  
        if v:IsA("Tool") then
           table.insert(Wapon, v.Name)
        end
    end
    
    local Boss = {}
    for i,v in pairs(game.ReplicatedStorage:GetChildren()) do
        if string.find(v.Name, "Boss") then
            if v.Name == "Ice Admiral [Lv. 700] [Boss]" then
            elseif v.Name == "rip_indra [Lv. 1500] [Boss]" then
            else
                table.insert(Boss, v.Name)
            end
        end
    end
    
    for i,v in pairs(game.workspace.Enemies:GetChildren()) do
        if string.find(v.Name, "Boss") then
            if v.Name == "Ice Admiral [Lv. 700] [Boss]" then
            elseif v.Name == "rip_indra [Lv. 1500] [Boss]" then
            else
                table.insert(Boss, v.Name)
            end
        end
    end
    spawn(function()
        pcall(function()
            while wait() do
                if _G.LightMode then
                    if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("PointLight") then
                        local a = Instance.new("PointLight")
                        a.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
                        a.Range = 16
                        a.Color = Color3.fromRGB(255, 167, 31)
                    end
                end
            end
        end)
    end)
    
    function BeautifulMode()
        _G.LightMode = true
        if game:GetService("Lighting"):FindFirstChild("BloomEffect") then
            game:GetService("Lighting"):FindFirstChild("BloomEffect"):Destroy()
        end
        if game:GetService("Lighting"):FindFirstChild("ColorCorrectionEffect") then
            game:GetService("Lighting"):FindFirstChild("ColorCorrectionEffect"):Destroy()
        end
        if game:GetService("Lighting"):FindFirstChild("DepthOfFieldEffect") then
            game:GetService("Lighting"):FindFirstChild("DepthOfFieldEffect"):Destroy()
        end
        if game:GetService("Lighting"):FindFirstChild("ColorCorrectionEffect") then
            game:GetService("Lighting"):FindFirstChild("ColorCorrectionEffect"):Destroy()
        end
        if game:GetService("Lighting"):FindFirstChild("ColorCorrectionEffect2") then
            game:GetService("Lighting"):FindFirstChild("ColorCorrectionEffect2"):Destroy()
        end
        if game:GetService("Lighting"):FindFirstChild("SunRaysEffect") then
            game:GetService("Lighting"):FindFirstChild("SunRaysEffect"):Destroy()
        end
        local a = game.Lighting
        a.Ambient = Color3.fromRGB(31, 31, 31)
        a.Brightness = 0.7
        a.ColorShift_Bottom = Color3.fromRGB(255, 255, 255)
        a.ColorShift_Top = Color3.fromRGB(255, 102, 31)
        a.EnvironmentDiffuseScale = 0.205
        a.EnvironmentSpecularScale = 0.522
        a.GlobalShadows = true
        a.OutdoorAmbient = Color3.fromRGB(67, 67, 67)
        a.ShadowSoftness = 0.5
        a.GeographicLatitude = -15.525
        a.ExposureCompensation = 0.75
        local b = Instance.new("BloomEffect", a)
        b.Name = "BloomEffect"
        b.Enabled = true
        b.Intensity = 0.04
        b.Size = 1900
        b.Threshold = 0.915
        local c = Instance.new("ColorCorrectionEffect", a)
        c.Name = "ColorCorrectionEffect"
        c.Brightness = 0.176
        c.Contrast = 0.39
        c.Enabled = true
        c.Saturation = 0.2
        c.TintColor = Color3.fromRGB(255, 227, 128)
        local d = Instance.new("DepthOfFieldEffect", a)
        d.Name = "DepthOfFieldEffect"
        d.Enabled = true
        d.FarIntensity = 0.077
        d.FocusDistance = 21.54
        d.InFocusRadius = 20.77
        d.NearIntensity = 0.277
        local e = Instance.new("ColorCorrectionEffect", a)
        e.Name = "ColorCorrectionEffect"
        e.Brightness = 0.3
        e.Contrast = -0.07
        e.Saturation = 0
        e.Enabled = true
        e.TintColor = Color3.fromRGB(255, 247, 239)
        local e2 = Instance.new("ColorCorrectionEffect", a)
        e2.Name = "ColorCorrectionEffect2"
        e2.Brightness = 0.1
        e2.Contrast = 0.45
        e2.Saturation = -0.1
        e2.Enabled = true
        e2.TintColor = Color3.fromRGB(167, 167, 167)
        local s = Instance.new("SunRaysEffect", a)
        s.Name = "SunRaysEffect"
        s.Enabled = true
        s.Intensity = 0.01
        s.Spread = 0.146
    end
    
    PlayerName = {}
    for i,v in pairs(game:GetService("Players"):GetChildren()) do
        table.insert(PlayerName ,v.Name)
    end
    
    Old_World = false
    New_World = false
    Three_World = false
    local placeId = game.PlaceId
    if placeId == 2753915549 then
        Old_World = true
    elseif placeId == 4442272183 then
        New_World = true
    elseif placeId == 7449423635 then
        Three_World = true
    end
     
    sector2:AddToggle("Auto Farm Level", _G.AutoFarmLevel, function(vu)
        _G.AutoFarm = vu
        if _G.AutoFarm and SelectToolWeapon == "" then
            print("ee")
        else
            Auto_Farm = vu
            SelectMonster = ""
            if vu == false then
                wait(1)
                TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
            end
        end
    end)
    
    
    
    sector2:AddToggle("Auto SetSpawnPoint", false, function(vu)
        AutoSetSpawn = vu
    end)
    sector2:AddDropdown("Select Weapon",Wapon,"Select Weapon",false,function(Value)
        SelectToolWeapon = Value
        SelectToolWeaponOld = Value
    end)
    
    if New_World then
        sector2:AddToggle("Auto Factory", false, function(vu)
            Factory = vu
            if vu == false then
                wait()
                TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
            end
        end)
    end
    
    if _G.Auto_Elite_Hop then
        _G.AutoElite = true
    end
    
    if Three_World then
        sector2:AddToggle("Auto Elite Hunter", _G.AutoElite, function(vu)
            EliteHunter = vu
            if vu == false then
                wait()
                TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
            end
        end)
    
        sector2:AddToggle("Auto Enma/Yama", _G.AutoYama, function(vu)
            AutoYama = vu
        end)
        
        sector2:AddToggle("Auto Rainbow Haki", false, function(vu)
            AutoRainbow = vu
            if vu == false then
                wait()
                TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
            end
        end)
    end
    
    if Old_World then
        sector2:AddToggle("Auto New World", _G.AutoNewworld, function(vu)
            Auto_Newworld = vu
            if vu == false then
                wait()
                TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
            end
        end)
    end
    
    if New_World then
        sector2:AddToggle("Auto Third Sea", _G.AutoThirdSea, function(vu)
            ReadyThirdSea = vu
            TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
            if ReadyThirdSea and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") ~= 3 then
                DiscordLib:Notification("Auto Third Sea","u must have\n Finish Bartilo Quest","Ok")
            elseif ReadyThirdSea and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress","Check") ~= 0 then
                DiscordLib:Notification("Auto Third Sea","u must have to Killed Don Swan First","Ok")
            elseif ReadyThirdSea and SelectToolWeapon == "" then
                DiscordLib:Notification("Auto Third Sea","Select Weapon First","Ok")
            else
                AutoThird = vu
            end
        end)
    end
    
    sector2:AddToggle("Auto Superhuman", _G.AutoSuperhuman, function(vu)
        Superhuman = vu
    end)
    
    sector2:AddToggle("Auto Fully Superhuman", _G.FullyAutoSuperhuman, function(vu)
        AutoFullySuperhuman = vu
    end)
    
    sector2:AddToggle("Auto Electric Claw", false, function(vu)
        AutoElectricClaw = vu
        if AutoElectricClaw then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if AutoElectricClaw then
                if game.Players.LocalPlayer.Character:FindFirstChild("Electro") and game.Players.LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 400 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
                end
                if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value >= 400 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
                end
                if (game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value <= 399) or (game.Players.LocalPlayer.Character:FindFirstChild("Electro") and game.Players.LocalPlayer.Character:FindFirstChild("Electro").Level.Value <= 399) then
                    SelectToolWeapon = "Electro"
                end
                if game.Players.LocalPlayer.Backpack:FindFirstChild("Electric Claw") or game.Players.LocalPlayer.Character:FindFirstChild("Electric Claw") then
                    SelectToolWeapon = "Electric Claw"
                end
                if (game.Players.LocalPlayer.Character:FindFirstChild("Electro") and game.Players.LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 400) or (game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value >= 400) then
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw") == "..." and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw","Start") == 4 then
                        TP(CFrame.new(-12548.998046875, 332.40396118164, -7603.1865234375))
                    elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw",true) == 4 then
                        Auto_Farm = false
                        if (CFrame.new(-10369.7725, 331.654175, -10130.3047, 0.879783928, -1.15147909e-08, 0.475373745, -1.70712194e-10, 1, 2.45385472e-08, -0.475373745, -2.16697718e-08, 0.879783928).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
                            wait(1.1)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw","Start")
                        else
                            TP(CFrame.new(-10369.7725, 331.654175, -10130.3047, 0.879783928, -1.15147909e-08, 0.475373745, -1.70712194e-10, 1, 2.45385472e-08, -0.475373745, -2.16697718e-08, 0.879783928))
                        end
                    elseif _G.AutoFarm then
                        Auto_Farm = true
                    end
                end
            end
        end
    end)
    
    sector2:AddToggle("Auto Accessories", _G.AutoAccessory, function(Value)
        AutoAccessories = Value 
    end)
    
    
    if not Old_World then
    print("balles")
    end
    
    if _G.AutoLegendary_Hop then
        _G.Auto_Legendary_Sword = true
    elseif _G.Auto_Legendary_Sword then
        _G.Auto_Legendary_Sword = true
    else
        _G.Auto_Legendary_Sword = false
    end
    
    if _G.AutoEnchancement_Hop then
        _G.AutoEnchancement = true
    elseif _G.AutoEnchancement then
        _G.AutoEnchancement = true
    else
        _G.AutoEnchancement = false
    end
    
    if New_World then
        sector2:AddToggle("Auto Buy Legendary Sword", _G.Auto_Legendary_Sword, function(Value)
            LegebdarySword = Value    
        end)
    end
    if not Old_World then
        sector2:AddToggle("Auto Buy Enchancement", _G.AutoEnchancement, function(Value)
            Enchancement = Value    
        end)
    end
    
    sector2:AddLabel("Mastery Farm")
    sector2:AddToggle("Auto Farm Mastery Devil", false, function(vu)
        AutoFarmMasteryFruit = vu
        if AutoFarmMasteryFruit and WeaponMastery == "" then
            DiscordLib:Notification("Auto Farm Mastery","SelectWeapon First","Okay")
        else
            FarmMasteryFruit = vu
            if vu == false then
                wait()
                TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
            end
        end
    end)
    
    sector2:AddToggle("Auto Farm Mastery Gun", false, function(vu)
        AutoarmMasteryGun = vu
        if AutoarmMasteryGun and WeaponMastery == "" then
            DiscordLib:Notification("Auto Farm Mastery","SelectWeapon First","Okay")
        else
            FarmMasteryGun = vu
            if vu == false then
                wait()
                TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
            end
        end
    end)
    
    
    sector2:AddSlider("Health %", 1,1,100,1, function(Value)
        HealthPersen = Value
    end)
    
    sector2:AddToggle("Auto Farm Mastery Magnet", false, function(vu)
        MasteryMagnet = vu
    end)
    
    sector2:AddDropdown("Select Weapon",Wapon,"Weapon",false,function(Value)
        WeaponMastery = Value
    end)
    
    sector2:AddLabel("Boss Farm")
    sector2:AddToggle("Auto Farm Boss", false, function(vu)
        AutoFarmBoss = vu
        if vu == false then
            wait()
            TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)
    
    sector2:AddToggle("Auto Farm Boss Quest", true, function(vu)
        BossQuest = vu
    end)
    
    sector2:AddDropdown("Select Boss", Boss,"Boss",false, function(Value)
        SelectBoss = Value
    end)
    
    sector2:AddDropdown("Select Weapon",Wapon,"Weapon",false,function(Value)
        SelectWeaponBoss = Value
    end)
    
    
    sector2:AddButton("Buy Reroll race", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Buy",1,3)
    end)
    
    sector2:AddButton("Buy Refund Stats", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Buy",1,2)
    end)
    
    sector2:AddButton("Buy Random Surprise", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
    end)
    
    sector2:AddToggle("Auto Buy Random Surprise", false, function(vu)
        AutoBuySurprise = vu
    end)
    
    sector2:AddToggle("Auto Buy EXP x2 [ Bone ]", false, function(vu)
        AutoBuyEXPBone = vu
    end)
    
    if Three_World == true then
    
        sector2:AddToggle("Auto Try Luck [gravestone]", false, function(vu)
            TryLuck = vu
        end)
    
        sector2:AddToggle("Auto Pray [gravestone]", false, function(vu)
            Pray = vu
        end)
    
        sector2:AddToggle("Auto Farm Bone", false, function(vu)
            Auto_Bone = vu
            if vu == false then
                wait(1)
                TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
            end
        end)
    end 
        
    spawn(function()
        pcall(function()
            while wait(.1) do
                if AutoBuyEXPBone then
                    if not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Level.Exp.Text, "2x") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
                    end
                end
            end
        end)
    end)
    
    spawn(function()
        while wait(.1) do
            if AutoBuySurprise then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if TryLuck then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent",1)
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if Pray then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent",2)
            end
        end
    end)
    
        
     sector2:AddDropdown("Select Weapon",Wapon,"Weapon",false,function(value)
            EventWeapon = value
     end)
    sector2:AddLabel("Observation Haki Farm")
    Sec = 40
    sector2:AddSlider("Time", 1,1,600,1,Sec, function(Value)
        Sec = Value
    end)
    
    if _G.AutoFarm_Ken then
        AutoFarmKen = true
    else
        AutoFarmKen = false
    end
    
    sector2:AddToggle("Auto Farm Observation Haki", AutoFarmKen, function(vu)
        AutoFarmObservation = vu
        TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
        if AutoFarmObservation then
           game:GetService("VirtualUser"):CaptureController()
           game:GetService("VirtualUser"):SetKeyDown('0x65')
           wait(2)
           game:GetService("VirtualUser"):SetKeyUp('0x65')
        end
    end)
    
    
    function TP(P1)
        Distance = (P1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        if Distance < 250 then
            Speed = 600
        elseif Distance < 500 then
            Speed = 400
        elseif Distance < 1000 then
            Speed = 350
        elseif Distance >= 1000 then
            Speed = 200
        end
        game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
            {CFrame = P1}
        ):Play()
    end
    
    spawn(function()
        while wait() do
            pcall(function()
                CheckLevel()
                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if Auto_Farm and MagnetActive and Magnet then
                        if v.Name == Ms and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            if v.Name == "Factory Staff [Lv. 800]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 250 then
                                    v.Head.CanCollide = false
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                end
                            elseif v.Name == Ms then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 400 then
                                    v.Head.CanCollide = false
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                end
                            end
                        end
                    elseif FarmMasteryFruit and MasteryBFMagnetActive and MasteryMagnet then
                        if v.Name == "Monkey [Lv. 14]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 250 then
                                v.Head.CanCollide = false
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                            end
                        elseif v.Name == "Factory Staff [Lv. 800]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 250 then
                                v.Head.CanCollide = false
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                            end
                        elseif v.Name == Ms then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 400 then
                                v.Head.CanCollide = false
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                            end
                        end
                    elseif FarmMasteryGun and MasteryGunMagnetActive and MasteryMagnet then
                        if v.Name == "Monkey [Lv. 14]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryGun.Position).Magnitude <= 250 then
                                v.Head.CanCollide = false
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryGun
                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                            end
                        elseif v.Name == "Factory Staff [Lv. 800]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryGun.Position).Magnitude <= 250 then
                                v.Head.CanCollide = false
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryGun
                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                            end
                        elseif v.Name == Ms then
                            if (v.HumanoidRootPart.Position - PosMonMasteryGun.Position).Magnitude <= 400 then
                                v.Head.CanCollide = false
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryGun
                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                            end
                        end
                    elseif AutoBartilo and MagnetBatilo and Magnet then
                        if v.Name == "Swan Pirate [Lv. 775]" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            v.Head.CanCollide = false
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v.HumanoidRootPart.CFrame = PosMonBartilo
                            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                        end
                    elseif AutoRengoku and RengokuMagnet and Magnet then
                        if (v.Name == "Snow Lurker [Lv. 1375]" or v.Name == "Arctic Warrior [Lv. 1350]") and (v.HumanoidRootPart.Position - PosMonRengoku.Position).Magnitude <= 350 then
                            v.Head.CanCollide = false
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v.HumanoidRootPart.CFrame = PosMonRengoku
                            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                        end
                    elseif Auto_Bone and BoneMagnet and Magnet then
                        if (v.Name == "Reborn Skeleton [Lv. 1975]" or v.Name == "Living Zombie [Lv. 2000]" or v.Name == "Demonic Soul [Lv. 2025]" or v.Name == "Posessed Mummy [Lv. 2050]") and (v.HumanoidRootPart.Position - MainMonBone.Position).Magnitude <= 300 then
                            v.Head.CanCollide = false
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v.HumanoidRootPart.CFrame = MainMonBone
                            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                        end
                    elseif AutoEcto and EctoplasMagnet and Magnet then
                        if string.find(v.Name, "Ship") and (v.HumanoidRootPart.Position - PosMonEctoplas.Position).Magnitude <= 300 then
                            v.Head.CanCollide = false
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v.HumanoidRootPart.CFrame = PosMonEctoplas
                            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                        end
                    elseif AutoEvoRace and EvoMagnet and Magnet then
                        if v.Name == "Zombie [Lv. 950]" and (v.HumanoidRootPart.Position - PosMonZombie.Position).Magnitude <= 300 then
                            v.Head.CanCollide = false
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v.HumanoidRootPart.CFrame = PosMonZombie
                            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                        end
                    elseif AutoCitizen and CitizenMagnet and Magnet then
                        if v.Name == "Forest Pirate [Lv. 1825]" and (v.HumanoidRootPart.Position - PosMonCitizen.Position).Magnitude <= 300 then
                            v.Head.CanCollide = false
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v.HumanoidRootPart.CFrame = PosMonZombie
                            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                        end
                    elseif AutoFarmSelectMonster and AutoFarmSelectMonsterMagnet and Magnet then
                        if v.Name == Ms and (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 400 then
                            v.Head.CanCollide = false
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v.HumanoidRootPart.CFrame = PosMonSelectMonster
                            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                        end
                    end
                end
            end)
        end
    end)
    
    function CheckLevel()
        local Lv = game:GetService("Players").LocalPlayer.Data.Level.Value
        if Old_World then
            if Lv == 1 or Lv <= 9 or SelectMonster == "Bandit [Lv. 5]" then -- Bandit
                Ms = "Bandit [Lv. 5]"
                NameQuest = "BanditQuest1"
                QuestLv = 1
                NameMon = "Bandit"
                CFrameQ = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875)
                CFrameMon = CFrame.new(1038.5533447266, 41.296249389648, 1576.5098876953)
            elseif Lv == 10 or Lv <= 14 or SelectMonster == "Monkey [Lv. 14]" then -- Monkey
                Ms = "Monkey [Lv. 14]"
                NameQuest = "JungleQuest"
                QuestLv = 1
                NameMon = "Monkey"
                CFrameQ = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
                CFrameMon = CFrame.new(-1448.1446533203, 50.851993560791, 63.60718536377)
            elseif Lv == 15 or Lv <= 29 or SelectMonster == "Gorilla [Lv. 20]" then -- Gorilla
                Ms = "Gorilla [Lv. 20]"
                NameQuest = "JungleQuest"
                QuestLv = 2
                NameMon = "Gorilla"
                CFrameQ = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
                CFrameMon = CFrame.new(-1142.6488037109, 40.462348937988, -515.39227294922)
            elseif Lv == 30 or Lv <= 39 or SelectMonster == "Pirate [Lv. 35]" then -- Pirate
                Ms = "Pirate [Lv. 35]"
                NameQuest = "BuggyQuest1"
                QuestLv = 1
                NameMon = "Pirate"
                CFrameQ = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
                CFrameMon = CFrame.new(-1201.0881347656, 40.628940582275, 3857.5966796875)
            elseif Lv == 40 or Lv <= 59 or SelectMonster == "Brute [Lv. 45]" then -- Brute
                Ms = "Brute [Lv. 45]"
                NameQuest = "BuggyQuest1"
                QuestLv = 2
                NameMon = "Brute"
                CFrameQ = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
                CFrameMon = CFrame.new(-1387.5324707031, 24.592035293579, 4100.9575195313)
            elseif Lv == 60 or Lv <= 74 or SelectMonster == "Desert Bandit [Lv. 60]" then -- Desert Bandit
                Ms = "Desert Bandit [Lv. 60]"
                NameQuest = "DesertQuest"
                QuestLv = 1
                NameMon = "Desert Bandit"
                CFrameQ = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
                CFrameMon = CFrame.new(984.99896240234, 16.109552383423, 4417.91015625)
            elseif Lv == 75 or Lv <= 89 or SelectMonster == "Desert Officer [Lv. 70]" then -- Desert Officer
                Ms = "Desert Officer [Lv. 70]"
                NameQuest = "DesertQuest"
                QuestLv = 2
                NameMon = "Desert Officer"
                CFrameQ = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
                CFrameMon = CFrame.new(1547.1510009766, 14.452038764954, 4381.8002929688)
            elseif Lv == 90 or Lv <= 99 or SelectMonster == "Snow Bandit [Lv. 90]" then -- Snow Bandit
                Ms = "Snow Bandit [Lv. 90]"
                NameQuest = "SnowQuest"
                QuestLv = 1
                NameMon = "Snow Bandit"
                CFrameQ = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
                CFrameMon = CFrame.new(1356.3028564453, 105.76865386963, -1328.2418212891)
            elseif Lv == 100 or Lv <= 119 or SelectMonster == "Snowman [Lv. 100]" then -- Snowman
                Ms = "Snowman [Lv. 100]"
                NameQuest = "SnowQuest"
                QuestLv = 2
                NameMon = "Snowman"
                CFrameQ = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
                CFrameMon = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
            elseif Lv == 120 or Lv <= 149 or SelectMonster == "Chief Petty Officer [Lv. 120]" then -- Chief Petty Officer
                Ms = "Chief Petty Officer [Lv. 120]"
                NameQuest = "MarineQuest2"
                QuestLv = 1
                NameMon = "Chief Petty Officer"
                CFrameQ = CFrame.new(-5035.49609375, 28.677835464478, 4324.1840820313)
                CFrameMon = CFrame.new(-4931.1552734375, 65.793113708496, 4121.8393554688)
            elseif Lv == 150 or Lv <= 174 or SelectMonster == "Sky Bandit [Lv. 150]" then -- Sky Bandit
                Ms = "Sky Bandit [Lv. 150]"
                NameQuest = "SkyQuest"
                QuestLv = 1
                NameMon = "Sky Bandit"
                CFrameQ = CFrame.new(-4842.1372070313, 717.69543457031, -2623.0483398438)
                CFrameMon = CFrame.new(-4955.6411132813, 365.46365356445, -2908.1865234375)
            elseif Lv == 175 or Lv <= 224 or SelectMonster == "Dark Master [Lv. 175]" then -- Dark Master
                Ms = "Dark Master [Lv. 175]"
                NameQuest = "SkyQuest"
                QuestLv = 2
                NameMon = "Dark Master"
                CFrameQ = CFrame.new(-4842.1372070313, 717.69543457031, -2623.0483398438)
                CFrameMon = CFrame.new(-5148.1650390625, 439.04571533203, -2332.9611816406)
            elseif Lv == 225 or Lv <= 274 or SelectMonster == "Toga Warrior [Lv. 225]" then -- Toga Warrior
                Ms = "Toga Warrior [Lv. 225]"
                NameQuest = "ColosseumQuest"
                QuestLv = 1
                NameMon = "Toga Warrior"
                CFrameQ = CFrame.new(-1577.7890625, 7.4151420593262, -2984.4838867188)
                CFrameMon = CFrame.new(-1872.5166015625, 49.080215454102, -2913.810546875)
            elseif Lv == 275 or Lv <= 299 or SelectMonster == "Gladiator [Lv. 275]" then -- Gladiator
                Ms = "Gladiator [Lv. 275]"
                NameQuest = "ColosseumQuest"
                QuestLv = 2
                NameMon = "Gladiator"
                CFrameQ = CFrame.new(-1577.7890625, 7.4151420593262, -2984.4838867188)
                CFrameMon = CFrame.new(-1521.3740234375, 81.203170776367, -3066.3139648438)
            elseif Lv == 300 or Lv <= 329 or SelectMonster == "Military Soldier [Lv. 300]" then -- Military Soldier
                Ms = "Military Soldier [Lv. 300]"
                NameQuest = "MagmaQuest"
                QuestLv = 1
                NameMon = "Military Soldier"
                CFrameQ = CFrame.new(-5316.1157226563, 12.262831687927, 8517.00390625)
                CFrameMon = CFrame.new(-5369.0004882813, 61.24352645874, 8556.4921875)
            elseif Lv == 330 or Lv <= 374 or SelectMonster == "Military Spy [Lv. 330]" then -- Military Spy
                Ms = "Military Spy [Lv. 330]"
                NameQuest = "MagmaQuest"
                QuestLv = 2
                NameMon = "Military Spy"
                CFrameQ = CFrame.new(-5316.1157226563, 12.262831687927, 8517.00390625)
                CFrameMon = CFrame.new(-5984.0532226563, 82.14656829834, 8753.326171875)
            elseif Lv == 375 or Lv <= 399 or SelectMonster == "Fishman Warrior [Lv. 375]" then -- Fishman Warrior 
                Ms = "Fishman Warrior [Lv. 375]"
                NameQuest = "FishmanQuest"
                QuestLv = 1
                NameMon = "Fishman Warrior"
                CFrameQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
                CFrameMon = CFrame.new(60844.10546875, 98.462875366211, 1298.3985595703)
                if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
                end
            elseif Lv == 400 or Lv <= 449 or SelectMonster == "Fishman Commando [Lv. 400]" then -- Fishman Commando
                Ms = "Fishman Commando [Lv. 400]"
                NameQuest = "FishmanQuest"
                QuestLv = 2
                NameMon = "Fishman Commando"
                CFrameQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
                CFrameMon = CFrame.new(61738.3984375, 64.207321166992, 1433.8375244141)
                if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
                end
            elseif Lv == 450 or Lv <= 474 or SelectMonster == "God's Guard [Lv. 450]" then -- God's Guard
                Ms = "God's Guard [Lv. 450]"
                NameQuest = "SkyExp1Quest"
                QuestLv = 1
                NameMon = "God's Guard"
                CFrameQ = CFrame.new(-4721.8603515625, 845.30297851563, -1953.8489990234)
                CFrameMon = CFrame.new(-4628.0498046875, 866.92877197266, -1931.2352294922)
                if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
                end
            elseif Lv == 475 or Lv <= 524 or SelectMonster == "Shanda [Lv. 475]" then -- Shanda
                Ms = "Shanda [Lv. 475]"
                NameQuest = "SkyExp1Quest"
                QuestLv = 2
                NameMon = "Shanda"
                CFrameQ = CFrame.new(-7863.1596679688, 5545.5190429688, -378.42266845703)
                CFrameMon = CFrame.new(-7685.1474609375, 5601.0751953125, -441.38876342773)
                if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
                end
            elseif Lv == 525 or Lv <= 549 or SelectMonster == "Royal Squad [Lv. 525]" then -- Royal Squad
                Ms = "Royal Squad [Lv. 525]"
                NameQuest = "SkyExp2Quest"
                QuestLv = 1
                NameMon = "Royal Squad"
                CFrameQ = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
                CFrameMon = CFrame.new(-7654.2514648438, 5637.1079101563, -1407.7550048828)
            elseif Lv == 550 or Lv <= 624 or SelectMonster == "Royal Soldier [Lv. 550]" then -- Royal Soldier
                Ms = "Royal Soldier [Lv. 550]"
                NameQuest = "SkyExp2Quest"
                QuestLv = 2
                NameMon = "Royal Soldier"
                CFrameQ = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
                CFrameMon = CFrame.new(-7760.4106445313, 5679.9077148438, -1884.8112792969)
            elseif Lv == 625 or Lv <= 649 or SelectMonster == "Galley Pirate [Lv. 625]" then -- Galley Pirate
                Ms = "Galley Pirate [Lv. 625]"
                NameQuest = "FountainQuest"
                QuestLv = 1
                NameMon = "Galley Pirate"
                CFrameQ = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
                CFrameMon = CFrame.new(5557.1684570313, 152.32717895508, 3998.7758789063)
            elseif Lv >= 650 or SelectMonster == "Galley Captain [Lv. 650]" then -- Galley Captain
                Ms = "Galley Captain [Lv. 650]"
                NameQuest = "FountainQuest"
                QuestLv = 2
                NameMon = "Galley Captain"
                CFrameQ = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
                CFrameMon = CFrame.new(5677.6772460938, 92.786109924316, 4966.6323242188)
            end
        end
        if New_World then
            if Lv == 700 or Lv <= 724 or SelectMonster == "Raider [Lv. 700]" then -- Raider
                Ms = "Raider [Lv. 700]"
                NameQuest = "Area1Quest"
                QuestLv = 1
                NameMon = "Raider"
                CFrameQ = CFrame.new(-427.72567749023, 72.99634552002, 1835.9426269531)
                CFrameMon = CFrame.new(68.874565124512, 93.635643005371, 2429.6752929688)
            elseif Lv == 725 or Lv <= 774 or SelectMonster == "Mercenary [Lv. 725]" then -- Mercenary
                Ms = "Mercenary [Lv. 725]"
                NameQuest = "Area1Quest"
                QuestLv = 2
                NameMon = "Mercenary"
                CFrameQ = CFrame.new(-427.72567749023, 72.99634552002, 1835.9426269531)
                CFrameMon = CFrame.new(-864.85009765625, 122.47104644775, 1453.1505126953)
            elseif Lv == 775 or Lv <= 799 or SelectMonster == "Swan Pirate [Lv. 775]" then -- Swan Pirate
                Ms = "Swan Pirate [Lv. 775]"
                NameQuest = "Area2Quest"
                QuestLv = 1
                NameMon = "Swan Pirate"
                CFrameQ = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
                CFrameMon = CFrame.new(1065.3669433594, 137.64012145996, 1324.3798828125)
            elseif Lv == 800 or Lv <= 874 or SelectMonster == "Factory Staff [Lv. 800]" then -- Factory Staff
                Ms = "Factory Staff [Lv. 800]"
                NameQuest = "Area2Quest"
                QuestLv = 2
                NameMon = "Factory Staff"
                CFrameQ = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
                CFrameMon = CFrame.new(533.22045898438, 128.46876525879, 355.62615966797)
            elseif Lv == 875 or Lv <= 899 or SelectMonster == "Marine Lieutenant [Lv. 875]" then -- Marine Lieutenant
                Ms = "Marine Lieutenant [Lv. 875]"
                NameQuest = "MarineQuest3"
                QuestLv = 1
                NameMon = "Marine Lieutenant"
                CFrameQ = CFrame.new(-2440.9934082031, 73.04190826416, -3217.7082519531)
                CFrameMon = CFrame.new(-2489.2622070313, 84.613594055176, -3151.8830566406)
            elseif Lv == 900 or Lv <= 949 or SelectMonster == "Marine Captain [Lv. 900]" then -- Marine Captain
                Ms = "Marine Captain [Lv. 900]"
                NameQuest = "MarineQuest3"
                QuestLv = 2
                NameMon = "Marine Captain"
                CFrameQ = CFrame.new(-2440.9934082031, 73.04190826416, -3217.7082519531)
                CFrameMon = CFrame.new(-2335.2026367188, 79.786659240723, -3245.8674316406)
            elseif Lv == 950 or Lv <= 974 or SelectMonster == "Zombie [Lv. 950]" then -- Zombie
                Ms = "Zombie [Lv. 950]"
                NameQuest = "ZombieQuest"
                QuestLv = 1
                NameMon = "Zombie"
                CFrameQ = CFrame.new(-5494.3413085938, 48.505931854248, -794.59094238281)
                CFrameMon = CFrame.new(-5536.4970703125, 101.08577728271, -835.59075927734)
            elseif Lv == 975 or Lv <= 999 or SelectMonster == "Vampire [Lv. 975]" then -- Vampire
                Ms = "Vampire [Lv. 975]"
                NameQuest = "ZombieQuest"
                QuestLv = 2
                NameMon = "Vampire"
                CFrameQ = CFrame.new(-5494.3413085938, 48.505931854248, -794.59094238281)
                CFrameMon = CFrame.new(-5806.1098632813, 16.722528457642, -1164.4384765625)
            elseif Lv == 1000 or Lv <= 1049 or SelectMonster == "Snow Trooper [Lv. 1000]" then -- Snow Trooper
                Ms = "Snow Trooper [Lv. 1000]"
                NameQuest = "SnowMountainQuest"
                QuestLv = 1
                NameMon = "Snow Trooper"
                CFrameQ = CFrame.new(607.05963134766, 401.44781494141, -5370.5546875)
                CFrameMon = CFrame.new(535.21051025391, 432.74209594727, -5484.9165039063)
            elseif Lv == 1050 or Lv <= 1099 or SelectMonster == "Winter Warrior [Lv. 1050]" then -- Winter Warrior
                Ms = "Winter Warrior [Lv. 1050]"
                NameQuest = "SnowMountainQuest"
                QuestLv = 2
                NameMon = "Winter Warrior"
                CFrameQ = CFrame.new(607.05963134766, 401.44781494141, -5370.5546875)
                CFrameMon = CFrame.new(1234.4449462891, 456.95419311523, -5174.130859375)
            elseif Lv == 1100 or Lv <= 1124 or SelectMonster == "Lab Subordinate [Lv. 1100]" then -- Lab Subordinate
                Ms = "Lab Subordinate [Lv. 1100]"
                NameQuest = "IceSideQuest"
                QuestLv = 1
                NameMon = "Lab Subordinate"
                CFrameQ = CFrame.new(-6061.841796875, 15.926671981812, -4902.0385742188)
                CFrameMon = CFrame.new(-5720.5576171875, 63.309471130371, -4784.6103515625)
            elseif Lv == 1125 or Lv <= 1174 or SelectMonster == "Horned Warrior [Lv. 1125]" then -- Horned Warrior
                Ms = "Horned Warrior [Lv. 1125]"
                NameQuest = "IceSideQuest"
                QuestLv = 2
                NameMon = "Horned Warrior"
                CFrameQ = CFrame.new(-6061.841796875, 15.926671981812, -4902.0385742188)
                CFrameMon = CFrame.new(-6292.751953125, 91.181983947754, -5502.6499023438)
            elseif Lv == 1175 or Lv <= 1199 or SelectMonster == "Magma Ninja [Lv. 1175]" then -- Magma Ninja
                Ms = "Magma Ninja [Lv. 1175]"
                NameQuest = "FireSideQuest"
                QuestLv = 1
                NameMon = "Magma Ninja"
                CFrameQ = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
                CFrameMon = CFrame.new(-5461.8388671875, 130.36347961426, -5836.4702148438)
            elseif Lv == 1200 or Lv <= 1249 or SelectMonster == "Lava Pirate [Lv. 1200]" then -- Lava Pirate
                Ms = "Lava Pirate [Lv. 1200]"
                NameQuest = "FireSideQuest"
                QuestLv = 2
                NameMon = "Lava Pirate"
                CFrameQ = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
                CFrameMon = CFrame.new(-5251.1889648438, 55.164535522461, -4774.4096679688)
            elseif Lv == 1250 or Lv <= 1274 or SelectMonster == "Ship Deckhand [Lv. 1250]" then -- Ship Deckhand
                Ms = "Ship Deckhand [Lv. 1250]"
                NameQuest = "ShipQuest1"
                QuestLv = 1
                NameMon = "Ship Deckhand"
                CFrameQ = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
                CFrameMon = CFrame.new(921.12365722656, 125.9839553833, 33088.328125)
                if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                end
            elseif Lv == 1275 or Lv <= 1299 or SelectMonster == "Ship Engineer [Lv. 1275]" then -- Ship Engineer
                Ms = "Ship Engineer [Lv. 1275]"
                NameQuest = "ShipQuest1"
                QuestLv = 2
                NameMon = "Ship Engineer"
                CFrameQ = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
                CFrameMon = CFrame.new(886.28179931641, 40.47790145874, 32800.83203125)
                if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                end
            elseif Lv == 1300 or Lv <= 1324 or SelectMonster == "Ship Steward [Lv. 1300]" then -- Ship Steward
                Ms = "Ship Steward [Lv. 1300]"
                NameQuest = "ShipQuest2"
                QuestLv = 1
                NameMon = "Ship Steward"
                CFrameQ = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
                CFrameMon = CFrame.new(943.85504150391, 129.58183288574, 33444.3671875)
                if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                end
            elseif Lv == 1325 or Lv <= 1349 or SelectMonster == "Ship Officer [Lv. 1325]" then -- Ship Officer
                Ms = "Ship Officer [Lv. 1325]"
                NameQuest = "ShipQuest2"
                QuestLv = 2
                NameMon = "Ship Officer"
                CFrameQ = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
                CFrameMon = CFrame.new(955.38458251953, 181.08335876465, 33331.890625)
                if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                end
            elseif Lv == 1350 or Lv <= 1374 or SelectMonster == "Arctic Warrior [Lv. 1350]" then -- Arctic Warrior
                Ms = "Arctic Warrior [Lv. 1350]"
                NameQuest = "FrostQuest"
                QuestLv = 1
                NameMon = "Arctic Warrior"
                CFrameQ = CFrame.new(5668.1372070313, 28.202531814575, -6484.6005859375)
                CFrameMon = CFrame.new(5935.4541015625, 77.26016998291, -6472.7568359375)
                if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422))
                end
            elseif Lv == 1375 or Lv <= 1424 or SelectMonster == "Snow Lurker [Lv. 1375]" then -- Snow Lurker
                Ms = "Snow Lurker [Lv. 1375]"
                NameQuest = "FrostQuest"
                QuestLv = 2
                NameMon = "Snow Lurker"
                CFrameQ = CFrame.new(5668.1372070313, 28.202531814575, -6484.6005859375)
                CFrameMon = CFrame.new(5628.482421875, 57.574996948242, -6618.3481445313)
            elseif Lv == 1425 or Lv <= 1449 or SelectMonster == "Sea Soldier [Lv. 1425]" then -- Sea Soldier
                Ms = "Sea Soldier [Lv. 1425]"
                NameQuest = "ForgottenQuest"
                QuestLv = 1
                NameMon = "Sea Soldier"
                CFrameQ = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063)
                CFrameMon = CFrame.new(-3185.0153808594, 58.789089202881, -9663.6064453125)
            elseif Lv >= 1450 or SelectMonster == "Water Fighter [Lv. 1450]" then -- Water Fighter
                Ms = "Water Fighter [Lv. 1450]"
                NameQuest = "ForgottenQuest"
                QuestLv = 2
                NameMon = "Water Fighter"
                CFrameQ = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063)
                CFrameMon = CFrame.new(-3262.9301757813, 298.69036865234, -10552.529296875)
            end
        end
        if Three_World then
            if Lv == 1500 or Lv <= 1524 or SelectMonster == "Pirate Millionaire [Lv. 1500]" then -- Pirate Millionaire
                Ms = "Pirate Millionaire [Lv. 1500]"
                NameQuest = "PiratePortQuest"
                QuestLv = 1
                NameMon = "Pirate Millionaire"
                CFrameQ = CFrame.new(-289.61752319336, 43.819011688232, 5580.0903320313)
                CFrameMon = CFrame.new(-435.68109130859, 189.69866943359, 5551.0756835938)
            elseif Lv == 1525 or Lv <= 1574 or SelectMonster == "Pistol Billionaire [Lv. 1525]" then -- Pistol Billoonaire
                Ms = "Pistol Billionaire [Lv. 1525]"
                NameQuest = "PiratePortQuest"
                QuestLv = 2
                NameMon = "Pistol Billionaire"
                CFrameQ = CFrame.new(-289.61752319336, 43.819011688232, 5580.0903320313)
                CFrameMon = CFrame.new(-236.53652954102, 217.46676635742, 6006.0883789063)
            elseif Lv == 1575 or Lv <= 1599 or SelectMonster == "Dragon Crew Warrior [Lv. 1575]" then -- Dragon Crew Warrior
                Ms = "Dragon Crew Warrior [Lv. 1575]"
                NameQuest = "AmazonQuest"
                QuestLv = 1
                NameMon = "Dragon Crew Warrior"
                CFrameQ = CFrame.new(5833.1147460938, 51.60498046875, -1103.0693359375)
                CFrameMon = CFrame.new(6301.9975585938, 104.77153015137, -1082.6075439453)
            elseif Lv == 1600 or Lv <= 1624 or SelectMonster == "Dragon Crew Archer [Lv. 1600]" then -- Dragon Crew Archer
                Ms = "Dragon Crew Archer [Lv. 1600]"
                NameQuest = "AmazonQuest"
                QuestLv = 2
                NameMon = "Dragon Crew Archer"
                CFrameQ = CFrame.new(5833.1147460938, 51.60498046875, -1103.0693359375)
                CFrameMon = CFrame.new(6831.1171875, 441.76708984375, 446.58615112305)
            elseif Lv == 1625 or Lv <= 1649 or SelectMonster == "Female Islander [Lv. 1625]" then -- Female Islander
                Ms = "Female Islander [Lv. 1625]"
                NameQuest = "AmazonQuest2"
                QuestLv = 1
                NameMon = "Female Islander"
                CFrameQ = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
                CFrameMon = CFrame.new(5792.5166015625, 848.14392089844, 1084.1818847656)
            elseif Lv == 1650 or Lv <= 1699 or SelectMonster == "Giant Islander [Lv. 1650]" then -- Giant Islander
                Ms = "Giant Islander [Lv. 1650]"
                NameQuest = "AmazonQuest2"
                QuestLv = 2
                NameMon = "Giant Islander"
                CFrameQ = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
                CFrameMon = CFrame.new(5009.5068359375, 664.11071777344, -40.960144042969)
            elseif Lv == 1700 or Lv <= 1724 or SelectMonster == "Marine Commodore [Lv. 1700]" then -- Marine Commodore
                Ms = "Marine Commodore [Lv. 1700]"
                NameQuest = "MarineTreeIsland"
                QuestLv = 1
                NameMon = "Marine Commodore"
                CFrameQ = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
                CFrameMon = CFrame.new(2198.0063476563, 128.71075439453, -7109.5043945313)
            elseif Lv == 1725 or Lv <= 1774 or SelectMonster == "Marine Rear Admiral [Lv. 1725]" then -- Marine Rear Admiral
                Ms = "Marine Rear Admiral [Lv. 1725]"
                NameQuest = "MarineTreeIsland"
                QuestLv = 2
                NameMon = "Marine Rear Admiral"
                CFrameQ = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
                CFrameMon = CFrame.new(3294.3142089844, 385.41125488281, -7048.6342773438)
            elseif Lv == 1775 or Lv <= 1799 or SelectMonster == "Fishman Raider [Lv. 1775]" then -- Fishman Raide
                Ms = "Fishman Raider [Lv. 1775]"
                NameQuest = "DeepForestIsland3"
                QuestLv = 1
                NameMon = "Fishman Raider"
                CFrameQ = CFrame.new(-10582.759765625, 331.78845214844, -8757.666015625)
                CFrameMon = CFrame.new(-10553.268554688, 521.38439941406, -8176.9458007813)
            elseif Lv == 1800 or Lv <= 1824 or SelectMonster == "Fishman Captain [Lv. 1800]" then -- Fishman Captain
                Ms = "Fishman Captain [Lv. 1800]"
                NameQuest = "DeepForestIsland3"
                QuestLv = 2
                NameMon = "Fishman Captain"
                CFrameQ = CFrame.new(-10583.099609375, 331.78845214844, -8759.4638671875)
                CFrameMon = CFrame.new(-10789.401367188, 427.18637084961, -9131.4423828125)
            elseif Lv == 1825 or Lv <= 1849 or SelectMonster == "Forest Pirate [Lv. 1825]" then -- Forest Pirate
                Ms = "Forest Pirate [Lv. 1825]"
                NameQuest = "DeepForestIsland"
                QuestLv = 1
                NameMon = "Forest Pirate"
                CFrameQ = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938)
                CFrameMon = CFrame.new(-13489.397460938, 400.30349731445, -7770.251953125)
            elseif Lv == 1850 or Lv <= 1899 or SelectMonster == "Mythological Pirate [Lv. 1850]" then -- Mythological Pirate
                Ms = "Mythological Pirate [Lv. 1850]"
                NameQuest = "DeepForestIsland"
                QuestLv = 2
                NameMon = "Mythological Pirate"
                CFrameQ = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938)
                CFrameMon = CFrame.new(-13508.616210938, 582.46228027344, -6985.3037109375)
            elseif Lv == 1900 or Lv <= 1924 or SelectMonster == "Jungle Pirate [Lv. 1900]" then -- Jungle Pirate
                Ms = "Jungle Pirate [Lv. 1900]"
                NameQuest = "DeepForestIsland2"
                QuestLv = 1
                NameMon = "Jungle Pirate"
                CFrameQ = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
                CFrameMon = CFrame.new(-12267.103515625, 459.75262451172, -10277.200195313)
            elseif Lv == 1925 or Lv <= 1974 or SelectMonster == "Musketeer Pirate [Lv. 1925]" then -- Musketeer Pirate
                Ms = "Musketeer Pirate [Lv. 1925]"
                NameQuest = "DeepForestIsland2"
                QuestLv = 2
                NameMon = "Musketeer Pirate"
                CFrameQ = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
                CFrameMon = CFrame.new(-13291.5078125, 520.47338867188, -9904.638671875)
            elseif Lv == 1975 or Lv <= 1999 or SelectMonster == "Reborn Skeleton [Lv. 1975]" then
                Ms = "Reborn Skeleton [Lv. 1975]"
                NameQuest = "HauntedQuest1"
                QuestLv = 1
                NameMon = "Reborn Skeleton"
                CFrameQ = CFrame.new(-9480.80762, 142.130661, 5566.37305, -0.00655503059, 4.52954225e-08, -0.999978542, 2.04920472e-08, 1, 4.51620679e-08, 0.999978542, -2.01955679e-08, -0.00655503059)
                CFrameMon = CFrame.new(-8761.77148, 183.431747, 6168.33301, 0.978073597, -1.3950732e-05, -0.208259016, -1.08073925e-06, 1, -7.20630269e-05, 0.208259016, 7.07080399e-05, 0.978073597)
            elseif Lv == 2000 or Lv <= 2024 or SelectMonster == "Living Zombie [Lv. 2000]" then
                Ms = "Living Zombie [Lv. 2000]"
                NameQuest = "HauntedQuest1"
                QuestLv = 2
                NameMon = "Living Zombie"
                CFrameQ = CFrame.new(-9480.80762, 142.130661, 5566.37305, -0.00655503059, 4.52954225e-08, -0.999978542, 2.04920472e-08, 1, 4.51620679e-08, 0.999978542, -2.01955679e-08, -0.00655503059)
                CFrameMon = CFrame.new(-10103.7529, 238.565979, 6179.75977, 0.999474227, 2.77547141e-08, 0.0324240364, -2.58006327e-08, 1, -6.06848474e-08, -0.0324240364, 5.98163865e-08, 0.999474227)
            elseif Lv == 2025 or Lv <= 2049 or SelectMonster == "Demonic Soul [Lv. 2025]" then
                Ms = "Demonic Soul [Lv. 2025]"
                NameQuest = "HauntedQuest2"
                QuestLv = 1
                NameMon = "Demonic Soul"
                CFrameQ = CFrame.new(-9515.39551, 172.266037, 6078.89746, 0.0121199936, -9.78649624e-08, 0.999926567, 2.30358754e-08, 1, 9.75929382e-08, -0.999926567, 2.18513581e-08, 0.0121199936)
                CFrameMon = CFrame.new(-9709.30762, 204.695892, 6044.04688, -0.845798075, -3.4587876e-07, -0.533503294, -4.46235369e-08, 1, -5.77571257e-07, 0.533503294, -4.64701827e-07, -0.845798075)
                elseif Lv == 2050 or Lv <= 2124 or SelectMonster == "Posessed Mummy [Lv. 2050]" then
                Ms = "Posessed Mummy [Lv. 2050]"
                NameQuest = "HauntedQuest2"
                QuestLv = 2
                NameMon = "Posessed Mummy"
                CFrameQ = CFrame.new(-9515.39551, 172.266037, 6078.89746, 0.0121199936, -9.78649624e-08, 0.999926567, 2.30358754e-08, 1, 9.75929382e-08, -0.999926567, 2.18513581e-08, 0.0121199936)
                CFrameMon = CFrame.new(-9554.11035, 65.6141663, 6041.73584, -0.877069294, 5.33355795e-08, -0.480364174, 2.06420765e-08, 1, 7.33423562e-08, 0.480364174, 5.44105987e-08, -0.877069294)
            elseif Lv == 2125 or Lv <= 2149  or SelectMonster == "Ice Cream Chef [Lv. 2125]" then
                Ms = "Ice Cream Chef [Lv. 2125]"
                NameQuest = "IceCreamIslandQuest"
                QuestLv = 1
                NameMon = "Ice Cream Chef"
                CFrameQ = CFrame.new(-821.03833, 65.8453293, -10966.5713, 0.761730552, 6.08681887e-08, -0.647893965, 1.27544619e-09, 1, 9.54473123e-08, 0.647893965, -7.35314885e-08, 0.761730552)
                CFrameMon = CFrame.new(-787.857178, 154.602448, -11129.002, -0.849269688, 7.99242095e-09, -0.527959228, 2.16687535e-09, 1, 1.1652717e-08, 0.527959228, 8.75227801e-09, -0.849269688)
        elseif Lv == 2149 or Lv <= 2200  or SelectMonster == "Ice Cream Commander [Lv. 2150]" then
                Ms = "Ice Cream Commander [Lv. 2150]"
                NameQuest = "IceCreamIslandQuest"
                QuestLv = 2
                NameMon = "Ice Cream Commander"
                CFrameQ = CFrame.new(-821.03833, 65.8453293, -10966.5713, 0.761730552, 6.08681887e-08, -0.647893965, 1.27544619e-09, 1, 9.54473123e-08, 0.647893965, -7.35314885e-08, 0.761730552)
                CFrameMon = CFrame.new(-787.857178, 154.602448, -11129.002, -0.849269688, 7.99242095e-09, -0.527959228, 2.16687535e-09, 1, 1.1652717e-08, 0.527959228, 8.75227801e-09, -0.849269688)
    
            end
        end
    end
    
    function TP(P1)
        Distance = (P1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        if Distance < 250 then
            Speed = 600
        elseif Distance < 500 then
            Speed = 400
        elseif Distance < 1000 then
            Speed = 350
        elseif Distance >= 1000 then
            Speed = 200
        end
        game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
            {CFrame = P1}
        ):Play()
    end
    
    function EquipWeapon(ToolSe)
        if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
            local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
            wait(.4)
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
        end
    end
    
    Type = 1
    spawn(function()
        while wait(.1) do
            if Type == 1 then
                Farm_Mode = CFrame.new(0, 18, 10)
            elseif Type == 2 then
                Farm_Mode = CFrame.new(0, 18, 10)
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            Type = 1
            wait(5)
            Type = 2
            wait(5)
        end
    end)
    
    pcall(function()
        for i,v in pairs(game:GetService("Workspace").Map.Dressrosa.Tavern:GetDescendants()) do
            if v.ClassName == "Seat" then
                v:Destroy()
            end
        end
    end)
    
    spawn(function()
        while wait() do
            if Auto_Farm then
                if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                    MagnetActive = false
                    CheckLevel()
                    TP(CFrameQ)
                    if (CFrameQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
                        wait(1.1)
                        CheckLevel()
                        if (CFrameQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                        else
                            TP(CFrameQ)
                        end
                    end
                elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                    pcall(function()
                        CheckLevel()
                        if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == Ms and v:FindFirstChild("Humanoid") then
                                    if v.Humanoid.Health > 0 then
                                        repeat game:GetService("RunService").Heartbeat:wait()
                                            if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
                                                if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                                                    EquipWeapon(SelectToolWeapon)
                                                    TP(v.HumanoidRootPart.CFrame * Farm_Mode)
                                                    v.HumanoidRootPart.CanCollide = false
                                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                                    game:GetService("VirtualUser"):CaptureController()
                                                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 670),workspace.CurrentCamera.CFrame)
                                                    PosMon = v.HumanoidRootPart.CFrame
                                                    MagnetActive = true
                                                else
                                                    MagnetActive = false    
                                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                                                end
                                            else
                                                MagnetActive = false
                                                CheckLevel()
                                                TP(CFrameMon)
                                            end
                                        until not v.Parent or v.Humanoid.Health <= 0 or Auto_Farm == false or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                                    end
                                end
                            end
                        else
                            MagnetActive = false
                            CheckLevel()
                            TP(CFrameMon)
                        end
                    end)
                end
            end
        end
    end)
    
    function Click()
        game:GetService'VirtualUser':CaptureController()
        game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
    end
    
    if SelectToolWeapon then
    else
        SelectToolWeapon = ""
    end
    
    spawn(function()
        game:GetService("RunService").Heartbeat:Connect(function()
            if SafeMode or PlayerHunt or KillPlayer or AutoRainbow or AutoCitizen or AutoFarmBoss or FarmAllBoss or Elite or AutoThird or AutoBartilo or AutoRengoku or Auto_Bone or AutoEcto or AutoFarmObservation or Auto_Farm or FarmMasteryGun or FarmMasteryFruit or _G.Auto_indra_Hop or _G.Auto_Dark_Dagger_Hop or _G.AutoDonSwan_Hop or _G.Pole_Hop or Core or noclip or AutoEvoRace or TPChest or NextIsland or RaidSuperhuman or _G.AutoRaid or AutoFarmBoss or SelectFarm or Clip or HolyTorch or AutoFarmSelectMonster or AutoLowRaid then
                if not game:GetService("Workspace"):FindFirstChild("LOL") then
                    local LOL = Instance.new("Part")
                    LOL.Name = "LOL"
                    LOL.Parent = game.Workspace
                    LOL.Anchored = true
                    LOL.Transparency = 1
                    LOL.Size = Vector3.new(30,-0.5,30)
                elseif game:GetService("Workspace"):FindFirstChild("LOL") then
                    game.Workspace["LOL"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.6, 0)
                end
            else
                if game:GetService("Workspace"):FindFirstChild("LOL") then
                    game:GetService("Workspace"):FindFirstChild("LOL"):Destroy()
                end
            end
        end)
    end)
    
    spawn(function()
        game:GetService("RunService").Stepped:Connect(function()
            if SafeMode or PlayerHunt or KillPlayer or AutoRainbow or AutoCitizen or AutoFarmBoss or FarmAllBoss or Elite or AutoThird or AutoBartilo or AutoRengoku or Auto_Bone or AutoEcto or AutoFarmObservation or Auto_Farm or FarmMasteryGun or FarmMasteryFruit or _G.Auto_indra_Hop or _G.Auto_Dark_Dagger_Hop or _G.AutoDonSwan_Hop or _G.Pole_Hop or Core or noclip or AutoEvoRace or TPChest or NextIsland or RaidSuperhuman or _G.AutoRaid or AutoFarmBoss or SelectFarm or Clip or HolyTorch or AutoFarmSelectMonster or AutoLowRaid then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end)
    
    if SelectWeaponBoss then
    else
        SelectWeaponBoss = ""
    end
    
    WeaponMastery = ""
    
    function AutoHaki()
        if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
            local args = {
                [1] = "Buso"
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        end
    end
    
    spawn(function()
        while wait() do
            if AutoYama then
                if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter","Progress") >= 30 then
                    repeat wait(.1)
                        fireclickdetector(game:GetService("Workspace").Map.Waterfall.SealedKatana.Handle.ClickDetector)
                    until game.Players.LocalPlayer.Backpack:FindFirstChild("Yama") or not AutoYama
                end
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if LevelLockClose then
                if game:GetService("Players").LocalPlayer.Data.Level >= LevelLock then
                    game:Shutdown()
                elseif game:GetService("Players").LocalPlayer.Data.Level >= LevelLockKick then
                    game.Players.LocalPlayer:kick("You Level :"..LevelLock)
                end
            end
        end
    end)
    
    Core = false
    spawn(function()
        while wait() do
            if Factory then
                if game.Workspace.Enemies:FindFirstChild("Core") then
                    Core = true
                    Auto_Farm = false
                    for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if Core and v.Name == "Core" and v.Humanoid.Health > 0 then
                            repeat game:GetService("RunService").Heartbeat:wait()
                                TP(CFrame.new(402.404296875, 182.53373718262, -414.73394775391))
                                EquipWeapon(SelectToolWeapon)
                                require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework).activeController.hitboxMagnitude = 1000
                                game:GetService'VirtualUser':CaptureController()
                                game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                            until not Core or v.Humanoid.Health <= 0  or Factory == false
                        end
                    end
                elseif game.ReplicatedStorage:FindFirstChild("Core") then
                    Core = true
                    Auto_Farm = false
                    TP(CFrame.new(402.404296875, 182.53373718262, -414.73394775391))
                elseif _G.AutoFarm and SelectToolWeapon ~= "" then
                    Auto_Farm = true
                    Core = false
                end
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if Auto_Newworld then
                local Lv = game.Players.LocalPlayer.Data.Level.Value
                if Lv >= 700 and Old_World then
                    Auto_Farm = false
                    if game.Workspace.Map.Ice.Door.CanCollide == true and game.Workspace.Map.Ice.Door.Transparency == 0 then
                        TP2(CFrame.new(4851.8720703125, 5.6514348983765, 718.47094726563))
                        wait(.5)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress","Detective")
                        EquipWeapon("Key")
                        TP2(CFrame.new(1347.7124, 37.3751602, -1325.6488))
                        wait(3)
                    elseif game.Workspace.Map.Ice.Door.CanCollide == false and game.Workspace.Map.Ice.Door.Transparency == 1 then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Ice Admiral [Lv. 700] [Boss]") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Ice Admiral [Lv. 700] [Boss]" and v.Humanoid.Health > 0 then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        pcall(function()
                                            EquipWeapon(SelectToolWeapon)
                                            TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 25, 25))
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                            v.HumanoidRootPart.Transparency = .8
                                            game:GetService("VirtualUser"):CaptureController()
                                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 870),workspace.CurrentCamera.CFrame)
                                        end)
                                    until v.Humanoid.Health <= 0 or not v.Parent
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
                                end
                            end
                        else
                            TP2(CFrame.new(1347.7124, 37.3751602, -1325.6488))
                        end
                    else
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
                    end
                end
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if AutoBartilo then
                if game.Players.LocalPlayer.Data.Level.Value >= 850 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 0 then
                    if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then 
                        if game:GetService("Workspace").Enemies:FindFirstChild("Swan Pirate [Lv. 775]") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Swan Pirate [Lv. 775]" then
                                    pcall(function()
                                        repeat wait(.1)
                                            EquipWeapon(MiscFarmWeapon)
                                            game:GetService'VirtualUser':CaptureController()
                                            game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                            TP(v.HumanoidRootPart.CFrame * CFrame.new(0,15,0))
                                            require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework).activeController.hitboxMagnitude = 1000
                                            PosMonBartilo = v.HumanoidRootPart.CFrame
                                            MagnetBatilo = true
                                        until not v.Parent or v.Humanoid.Health <= 0 or AutoBartilo == false or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                        MagnetBatilo = false
                                    end)
                                end
                            end
                        else
                            MagnetBatilo = false
                            TP(CFrame.new(1057.92761, 137.614319, 1242.08069))
                        end
                    else
                        TP2(CFrame.new(-456.28952, 73.0200958, 299.895966))
                        if (Vector3.new(-456.28952, 73.0200958, 299.895966) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                            wait(1.1)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest","BartiloQuest",1)
                        end
                    end
                elseif game.Players.LocalPlayer.Data.Level.Value >= 850 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 1 then
                    if QuestBartilo == nil then
                        TP2(CFrame.new(-456.28952, 73.0200958, 299.895966))
                    end
                    if (Vector3.new(-456.28952, 73.0200958, 299.895966) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                        wait(1.1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo")
                        QuestBartilo = 1
                    end
                    if game.Workspace.Enemies:FindFirstChild("Jeremy [Lv. 850] [Boss]") then
                        for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                            if v.Name == "Jeremy [Lv. 850] [Boss]" then
                                repeat wait(.1)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                    require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework).activeController.hitboxMagnitude = 1000
                                    EquipWeapon(MiscFarmWeapon)
                                    TP(v.HumanoidRootPart.CFrame * CFrame.new(0,15,6))
                                    game:GetService'VirtualUser':CaptureController()
                                    game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                until not v.Parent or v.Humanoid.Health <= 0 or AutoBartilo == false
                            end
                        end
                    else
                        if QuestBartilo == 1 then
                            TP(CFrame.new(1931.5931396484, 402.67391967773, 956.52215576172))
                        end
                    end
                elseif game.Players.LocalPlayer.Data.Level.Value >= 850 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 2 then
                    TP2(game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate1.CFrame)
                    wait(1)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate2.CFrame
                    wait(1)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate3.CFrame
                    wait(1)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate4.CFrame
                    wait(1)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate5.CFrame
                    wait(1)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate6.CFrame
                    wait(1)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate7.CFrame
                    wait(1)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate8.CFrame
                    wait(1)
                end
            end 
        end
    end)
    
    spawn(function()
        pcall(function()
            while wait(.1) do
                if AutoRengoku then
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Hidden Key") or game.Players.LocalPlayer.Character:FindFirstChild("Hidden Key") then
                        EquipWeapon("Hidden Key")
                        TP2(CFrame.new(6571.1201171875, 299.23028564453, -6967.841796875))
                    elseif game.Workspace.Enemies:FindFirstChild("Snow Lurker [Lv. 1375]") or game:GetService("Workspace").Enemies:FindFirstChild("Arctic Warrior [Lv. 1350]") then
                        for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                            if (v.Name == "Snow Lurker [Lv. 1375]" or v.Name == "Arctic Warrior [Lv. 1350]") and v.Humanoid.Health > 0 then
                                repeat game:GetService("RunService").Heartbeat:wait()
                                    EquipWeapon(MiscFarmWeapon)
                                    PosMonRengoku = v.HumanoidRootPart.CFrame
                                    require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework).activeController.hitboxMagnitude = 1000
                                    TP(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    game:GetService'VirtualUser':CaptureController()
                                    game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                    RengokuMagnet = true
                                until game.Players.LocalPlayer.Backpack:FindFirstChild("Hidden Key") or AutoRengoku == false or not v.Parent or v.Humanoid.Health <= 0
                                RengokuMagnet = false
                            end
                        end
                    else
                        RengokuMagnet = false
                        TP(CFrame.new(5525.7045898438, 262.90060424805, -6755.1186523438))
                    end
                end
            end
        end)
    end)
    
    spawn(function()
        pcall(function()
            while wait(.1) do
                if AutoEcto then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Ship Deckhand [Lv. 1250]") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Engineer [Lv. 1275]") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Steward [Lv. 1300]") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Officer [Lv. 1325]") then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if string.find(v.Name, "Ship") then
                                repeat game:GetService("RunService").Heartbeat:wait()
                                    EquipWeapon(MiscFarmWeapon)
                                    if string.find(v.Name, "Ship") then
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,15,15))
                                        game:GetService'VirtualUser':CaptureController()
                                        game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                        require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework).activeController.hitboxMagnitude = 1000
                                        PosMonEctoplas = v.HumanoidRootPart.CFrame
                                        EctoplasMagnet = true
                                    else
                                        EctoplasMagnet = false
                                        TP(CFrame.new(904.4072265625, 181.05767822266, 33341.38671875))
                                    end
                                until AutoEcto == false or not v.Parent or v.Humanoid.Health <= 0
                            end
                        end
                    else
                        EctoplasMagnet = false
                        local Distance = (Vector3.new(904.4072265625, 181.05767822266, 33341.38671875) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                        if Distance > 20000 then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                        end
                        TP(CFrame.new(904.4072265625, 181.05767822266, 33341.38671875))
                    end
                end
            end
        end)
    end)
    
    spawn(function()
        while wait(.1) do
            pcall(function()
                if Auto_Bone then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton [Lv. 1975]") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie [Lv. 2000]") or game:GetService("Workspace").Enemies:FindFirstChild("Domenic Soul [Lv. 2025]") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy [Lv. 2050]") then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == "Reborn Skeleton [Lv. 1975]" or v.Name == "Living Zombie [Lv. 2000]" or v.Name == "Demonic Soul [Lv. 2025]" or v.Name == "Posessed Mummy [Lv. 2050]" then
                                if v:WaitForChild("Humanoid").Health > 0 then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        EquipWeapon(EventWeapon)
                                        TP(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                        game:GetService("VirtualUser"):CaptureController()
                                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 670),workspace.CurrentCamera.CFrame)
                                        MainMonBone = v.HumanoidRootPart.CFrame
                                        BoneMagnet = true
                                    until Auto_Bone == false or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
                        end
                    else
                        BoneMagnet = false
                        TP(CFrame.new(-9501.64453, 582.052612, 6034.20117))
                    end
                end
            end)
        end
    end)
    
    spawn(function()
        pcall(function()
            while wait() do
                if AutoThird then
                    if game:GetService("Players").LocalPlayer.Data.Level.Value >= 1500 and New_World then
                        Auto_Farm = false
                        if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress","Check") == 0 then
                            TP2(CFrame.new(-1926.3221435547, 12.819851875305, 1738.3092041016))
                            if (CFrame.new(-1926.3221435547, 12.819851875305, 1738.3092041016).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                                wait(1.1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress","Begin")
                            end
                            wait(2)
                            if game:GetService("Workspace").Enemies:FindFirstChild("rip_indra [Lv. 1500] [Boss]") then
                                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if v.Name == "rip_indra [Lv. 1500] [Boss]" then
                                        repeat game:GetService("RunService").Heartbeat:wait()
                                            pcall(function()
                                                EquipWeapon(SelectToolWeapon)
                                                TP(v.HumanoidRootPart.CFrame * CFrame.new(0,25,25))
                                                require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework).activeController.hitboxMagnitude = 1000
                                                game:GetService'VirtualUser':CaptureController()
                                                game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                                FoundIndra = true
                                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
                                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                            end)
                                        until AutoThird == false or v.Humanoid.Health <= 0 or not v.Parent
                                    end
                                end
                            elseif not game:GetService("Workspace").Enemies:FindFirstChild("rip_indra [Lv. 1500] [Boss]") and (CFrame.new(-26880.93359375, 22.848554611206, 473.18951416016).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000 then
                                TP(CFrame.new(-26880.93359375, 22.848554611206, 473.18951416016))
                            end
                        end
                    end
                end
            end
        end)
    end)
    
    spawn(function()
        while wait(.1) do
            if AutoEvoRace then
                if not game:GetService("Players").LocalPlayer.Data.Race:FindFirstChild("Evolved") then
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","1") == 0 then
                        TP(CFrame.new(-2779.83521, 72.9661407, -3574.02002, -0.730484903, 6.39014104e-08, -0.68292886, 3.59963224e-08, 1, 5.50667032e-08, 0.68292886, 1.56424669e-08, -0.730484903))
                        if (Vector3.new(-2779.83521, 72.9661407, -3574.02002) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
                            wait(1.1)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","2")
                        end
                    elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","1") == 1 then
                        pcall(function()
                            if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 1") and not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flower 1") then
                                TP(game.Workspace.Flower1.CFrame)
                            elseif not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 2") and not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flower 2") then
                                TP(game.Workspace.Flower2.CFrame)
                            elseif not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 3") and not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flower 3") then
                                if game:GetService("Workspace").Enemies:FindFirstChild("Zombie [Lv. 950]") then
                                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                        if v.Name == "Zombie [Lv. 950]" then
                                            repeat game:GetService("RunService").Heartbeat:wait()
                                                EquipWeapon(MiscFarmWeapon)
                                                TP(v.HumanoidRootPart.CFrame * Farm_Mode)
                                                v.HumanoidRootPart.CanCollide = false
                                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                                game:GetService("VirtualUser"):CaptureController()
                                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                PosMonZombie = v.HumanoidRootPart.CFrame
                                                EvoMagnet = true
                                            until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 3") or not v.Parent or v.Humanoid.Health <= 0 or AutoEvoRace == false
                                            EvoMagnet = false
                                        end
                                    end
                                else
                                    EvoMagnet = false
                                    TP(CFrame.new(-5854.39014, 145.093857, -686.942017, 0.379233211, -1.41975844e-08, -0.925301135, -3.77265719e-10, 1, -1.5498367e-08, 0.925301135, 6.2265797e-09, 0.379233211))
                                end
                            end
                        end)
                    elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","1") == 2 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","3")
                    end
                end
            end
        end
    end)
    
    spawn(function()
        pcall(function()
            while wait(.1) do
                if AutoFarmSelectMonster then
                    if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible then
                        CheckLevel()
                        if (CFrameQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
                            wait(1.1)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                        else
                            TP(CFrameQ)
                        end
                    elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible then
                        CheckLevel()
                        pcall(function()
                            if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
                                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if v.Name == Ms and v:FindFirstChild("Humanoid") then
                                        if v.Humanoid.Health > 0 then
                                            repeat game:GetService("RunService").Heartbeat:wait()
                                                if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                                                    EquipWeapon(MiscFarmWeapon)
                                                    TP(v.HumanoidRootPart.CFrame * Farm_Mode)
                                                    v.HumanoidRootPart.CanCollide = false
                                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                                    game:GetService("VirtualUser"):CaptureController()
                                                    game:GetService("VirtualUser"):CaptureController()
                                                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                    PosMonSelectMonster = v.HumanoidRootPart.CFrame
                                                    AutoFarmSelectMonsterMagnet = true
                                                else
                                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                                                end
                                            until not AutoFarmSelectMonster or not v.Parent or v.Humanoid.Health <= 0 or not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible
                                        end
                                    end
                                end
                            else
                                CheckLevel()
                                AutoFarmSelectMonster = false
                                TP(CFrameMon)
                            end
                        end)
                    end
                end
            end
        end)
    end)
    
    spawn(function()
        while wait(.1) do
            if _G.Auto_Dark_Dagger_Hop then
                if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dark Dagger") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dark Dagger") then
                    game:Shutdown()
                end
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if _G.Auto_indra_Hop or _G.Auto_Dark_Dagger_Hop then
                if game:GetService("ReplicatedStorage"):FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]") then
                    TP(CFrame.new(-5415.3920898438, 505.74133300781, -2814.0166015625))
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if game:GetService("Workspace").Enemies:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]") then
                            if v.Name == "rip_indra True Form [Lv. 5000] [Raid Boss]" then
                                if v.Humanoid.Health > 0 then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        EquipWeapon(SelectToolWeapon)
                                        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 16, 7)
                                        require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework).activeController.hitboxMagnitude = 1000
                                        game:GetService'VirtualUser':CaptureController()
                                        game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                    until v.Humanoid.Health <= 0 or not v.Parent
                                end
                            end
                        else
                            TP(CFrame.new(-5415.3920898438, 505.74133300781, -2814.0166015625))
                        end
                    end
                end
                if (_G.Auto_Dark_Dagger_Hop or _G.Auto_indra_Hop) and Three_World and not game:GetService("ReplicatedStorage"):FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]") and not game:GetService("Workspace").Enemies:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]") then
                    if game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Visible == false then
                        Teleport()
                        --SafeMode = true
                        TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,10000,0))
                    elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Visible == true then
                        repeat game:GetService("RunService").Heartbeat:wait()
                            local X = math.random(1,1000)
                            local Z = math.random(1,1000)
                            local LP = game.Players.LocalPlayer.Character
                            TP(CFrame.new(X,LP.HumanoidRootPart.CFrame.Y,Z))
                        until game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Visible == false
                        Teleport()
                    end
                end
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if _G.AutoDonSwan_Hop then
                if game:GetService("ReplicatedStorage"):FindFirstChild("Don Swan [Lv. 1000] [Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Don Swan [Lv. 1000] [Boss]") then
                    TP(CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875))
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if game:GetService("Workspace").Enemies:FindFirstChild("Don Swan [Lv. 1000] [Boss]") then
                            if v.Name == "Don Swan [Lv. 1000] [Boss]" then
                                if v.Humanoid.Health > 0 then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        EquipWeapon(SelectToolWeapon)
                                        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 16, 7)
                                        require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework).activeController.hitboxMagnitude = 1000
                                        game:GetService'VirtualUser':CaptureController()
                                        game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                    until v.Humanoid.Health <= 0 or not v.Parent
                                end
                            end
                        else
                            TP(CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875))
                        end
                    end
                end
                if _G.AutoDonSwan_Hop and New_World and not game:GetService("ReplicatedStorage"):FindFirstChild("Don Swan [Lv. 1000] [Boss]") and game:GetService("Workspace").Enemies:FindFirstChild("Don Swan [Lv. 1000] [Boss]") then
                    if game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Visible == false then
                        Teleport()
                        --SafeMode = true
                        TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,10000,0))
                    elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Visible == true then
                        repeat game:GetService("RunService").Heartbeat:wait()
                            local X = math.random(1,1000)
                            local Z = math.random(1,1000)
                            local LP = game.Players.LocalPlayer.Character
                            TP(CFrame.new(X,LP.HumanoidRootPart.CFrame.Y,Z))
                        until game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Visible == false
                        Teleport()
                    end
                end
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if _G.Pole_Hop then
                if game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God [Lv. 575] [Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Thunder God [Lv. 575] [Boss]") then
                    TP(CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188))
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if game:GetService("Workspace").Enemies:FindFirstChild("Thunder God [Lv. 575] [Boss]") then
                            if v.Name == "Thunder God [Lv. 575] [Boss]" then
                                if v.Humanoid.Health > 0 then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        EquipWeapon(SelectToolWeapon)
                                        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 16, 7)
                                        require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework).activeController.hitboxMagnitude = 1000
                                        game:GetService'VirtualUser':CaptureController()
                                        game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                    until v.Humanoid.Health <= 0 or not v.Parent
                                end
                            end
                        else
                            TP(CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188))
                        end
                    end
                end
                if _G.Pole_Hop and Old_World and not game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God [Lv. 575] [Boss]") and not game:GetService("Workspace").Enemies:FindFirstChild("Thunder God [Lv. 575] [Boss]") then
                    if game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Visible == false then
                        Teleport()
                        --SafeMode = true
                        TP(game.Players.LocalPlayer.Character.HumanoidRootPart.Position,game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,10000,0))
                    elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Visible == true then
                        repeat game:GetService("RunService").Heartbeat:wait()
                            local X = math.random(1,1000)
                            local Z = math.random(1,1000)
                            local LP = game.Players.LocalPlayer.Character
                            TP(CFrame.new(X,LP.HumanoidRootPart.CFrame.Y,Z))
                        until game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Visible == false
                        Teleport()
                    end
                end
            end
        end
    end)
    
    --if game:GetService("ReplicatedStorage"):FindFirstChild("Diablo [Lv. 1750]") or game:GetService("ReplicatedStorage"):FindFirstChild("Urban [Lv. 1750]") or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre [Lv. 1750]") then
    
    spawn(function()
        pcall(function()
            while wait() do
                if EliteHunter then
                    local QuestElite = string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre")
                    local ReplicatedStorage = game:GetService("ReplicatedStorage");
                    local Enemies = game:GetService("Workspace").Enemies
                    if ReplicatedStorage:FindFirstChild("Diablo [Lv. 1750]") or Enemies:FindFirstChild("Diablo [Lv. 1750]") or ReplicatedStorage:FindFirstChild("Urban [Lv. 1750]") or Enemies:FindFirstChild("Urban [Lv. 1750]") or ReplicatedStorage:FindFirstChild("Deandre [Lv. 1750]") or Enemies:FindFirstChild("Deadre [Lv. 1750]") then
                        Elite = true
                        Auto_Farm = false
                        if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                            TP(CFrame.new(-5418.392578125, 313.74130249023, -2824.9157714844))
                            if (Vector3.new(-5418.392578125, 313.74130249023, -2824.9157714844) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                                wait(1.1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
                            end
                        elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                            if game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestReward.Title.Text == "Reward:\n$15,000\n60,000,000 Exp." then
                                for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
                                    if Elite and v.Name == "Diablo [Lv. 1750]" or v.Name == "Urban [Lv. 1750]" or v.Name == "Deandre [Lv. 1750]" then
                                        repeat game:GetService("RunService").Heartbeat:wait()
                                            if QuestElite then
                                                EquipWeapon(SelectToolWeapon)
                                                TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 4))
                                                require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework).activeController.hitboxMagnitude = 1000
                                                game:GetService'VirtualUser':CaptureController()
                                                game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                            else
                                                TP(CFrame.new(-5418.392578125, 313.74130249023, -2824.9157714844))
                                                if (Vector3.new(-5418.392578125, 313.74130249023, -2824.9157714844) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                                                    wait(1.5)
                                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
                                                end
                                            end
                                        until not Elite or v.Humanoid.Health <= 0 or not v.Parent or not EliteHunter or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                    end
                                end
                            else
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonHunter")
                            end
                        end
                    else
                        Elite = false
                    end
                    if _G.AutoFarm and Elite == false then
                        Auto_Farm = true
                    end
                    if _G.Auto_Elite_Hop and Three_World and Elite == false then
                        if game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Visible == false then
                            Teleport()
                            --SafeMode = true
                            TP(game.Players.LocalPlayer.Character.HumanoidRootPart.Position,game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,10000,0))
                        elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Visible == true then
                            repeat game:GetService("RunService").Heartbeat:wait()
                                local X = math.random(1,1000)
                                local Z = math.random(1,1000)
                                local LP = game.Players.LocalPlayer.Character
                                TP(CFrame.new(X,LP.HumanoidRootPart.CFrame.Y,Z))
                            until game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Visible == false
                            Teleport()
                        end
                    end
                end
            end
        end)
    end)
    
    spawn(function()
        while wait(.1) do
            if AutoCitizen then
                if game.Players.LocalPlayer.Data.Level.Value >= 1800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBandits == false then
                    if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Forest Pirate") and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Forest Pirate [Lv. 1825]") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Forest Pirate [Lv. 1825]" then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        pcall(function()
                                            EquipWeapon(MiscFarmWeapon)
                                            TP(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                            game:GetService'VirtualUser':CaptureController()
                                            game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                            PosMonCitizen = v.HumanoidRootPart.CFrame
                                            CitizenMagnet = true
                                        end)
                                    until AutoCitizen == false or not v.Parent or v.Humanoid.Health <= 0 or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                    CitizenMagnet = false
                                end
                            end
                        else
                            CitizenMagnet = false
                            TP(CFrame.new(-13459.065429688, 412.68927001953, -7783.1860351563))
                        end
                    else
                        TP(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))
                        if (Vector3.new(-12443.8671875, 332.40396118164, -7675.4892578125) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                            wait(1.5)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "CitizenQuest", 1)
                        end
                    end
                elseif game.Players.LocalPlayer.Data.Level.Value >= 1800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBoss == false then
                    if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") and game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Captain Elephant [Lv. 1875] [Boss]") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Captain Elephant [Lv. 1875] [Boss]" then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        pcall(function()
                                            EquipWeapon(MiscFarmWeapon)
                                            TP(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                            game:GetService("VirtualUser"):CaptureController()
                                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                        end)
                                    until AutoCitizen == false or v.Humanoid.Health <= 0 or not v.Parent or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                end
                            end
                        else
                            TP(CFrame.new(-13459.065429688, 412.68927001953, -7783.1860351563))
                        end
                    else
                        TP(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))
                        if (CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
                            wait(1.5)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen")
                        end
                    end
                elseif game.Players.LocalPlayer.Data.Level.Value >= 1800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen") == 2 then
                    TP(CFrame.new(-12512.138671875, 340.39279174805, -9872.8203125))
                end
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if AutoObservationv2 then
                if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk2","Start") == 0 then
                    local args = {
                        [1] = "KenTalk2",
                        [2] = "Buy"
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                else
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Fruit Bowl") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Fruit Bowl") then
                        local args = {
                            [1] = "KenTalk2",
                            [2] = "Start"
                        }
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                    else
                        for i,v in pairs(game:GetService("Workspace").AppleSpawner:GetChildren()) do
                            if v.Name == "Apple" then
                                v.Handle.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                            end
                        end
                        for i,v in pairs(game:GetService("Workspace").BananaSpawner:GetChildren()) do
                            if v.Name == "Banana" then
                                v.Handle.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                            end
                        end
                        for i,v in pairs(game:GetService("Workspace").PineappleSpawner:GetChildren()) do
                            if v.Name == "Pineapple" then
                                v.Handle.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                            end
                        end
                        if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Apple") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Apple")) and (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Pineapple") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Pineapple")) and (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Banana") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Banana")) then
                            local args = {
                                [1] = "CitizenQuestProgress",
                                [2] = "Citizen"
                            }
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                        end
                    end
                end
            end
        end
    end)
    
    spawn(function()
        pcall(function()
            while wait(.1) do
                if AutoRainbow then
                    if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                        TP(CFrame.new(-11892.0703125, 930.57672119141, -8760.1591796875))
                        if (Vector3.new(-11892.0703125, 930.57672119141, -8760.1591796875) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                            wait(1.5)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("HornedMan","Bet")
                        end
                    elseif game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true and string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Stone") then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Stone [Lv. 1550] [Boss]") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Stone [Lv. 1550] [Boss]" then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        EquipWeapon(SelectToolWeapon)
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 10))
                                        require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework).activeController.hitboxMagnitude = 1000
                                        game:GetService("VirtualUser"):CaptureController()
                                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                    until AutoRainbow == false or v.Humanoid.Health <= 0 or not v.Parent or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                end
                            end
                        else
                            TP(CFrame.new(-871.478455, 92.3782501, 6637.01514, -0.648528099, -2.65940674e-08, 0.761190772, -2.16472333e-08, 1, 1.64941927e-08, -0.761190772, -5.78073056e-09, -0.648528099))
                        end
                    elseif game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true and string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Island Empress") then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Island Empress [Lv. 1675] [Boss]") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Island Empress [Lv. 1675] [Boss]" then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        EquipWeapon(SelectToolWeapon)
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 10))
                                        require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework).activeController.hitboxMagnitude = 1000
                                        game:GetService("VirtualUser"):CaptureController()
                                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                    until AutoRainbow == false or v.Humanoid.Health <= 0 or not v.Parent or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                end
                            end
                        else
                            TP(CFrame.new(5541.21338, 668.239258, 198.150391, -0.00426674541, 5.33843725e-09, -0.99999088, 3.50221967e-08, 1, 5.18905363e-09, 0.99999088, -3.49997364e-08, -0.00426674541))
                        end
                    elseif string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Kilo Admiral") then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Kilo Admiral [Lv. 1750] [Boss]") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Kilo Admiral [Lv. 1750] [Boss]" then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        EquipWeapon(SelectToolWeapon)
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 10))
                                        require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework).activeController.hitboxMagnitude = 1000
                                        game:GetService("VirtualUser"):CaptureController()
                                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                    until AutoRainbow == false or v.Humanoid.Health <= 0 or not v.Parent or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                end
                            end
                        else
                            TP(CFrame.new(2832.35449, 432.43573, -7122.49121, 0.734633088, -8.93899994e-08, -0.678464592, 6.01928107e-09, 1, -1.25235772e-07, 0.678464592, 8.79184725e-08, 0.734633088))
                        end
                    elseif string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Captain Elephant [Lv. 1875] [Boss]") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Captain Elephant [Lv. 1875] [Boss]" then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        EquipWeapon(SelectToolWeapon)
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 10))
                                        require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework).activeController.hitboxMagnitude = 1000
                                        game:GetService("VirtualUser"):CaptureController()
                                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                    until AutoRainbow == false or v.Humanoid.Health <= 0 or not v.Parent or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                end
                            end
                        else
                            TP(CFrame.new(-13315.5381, 433.261169, -8078.44971, 0.998839259, 7.84328549e-08, -0.0481674224, -8.16301977e-08, 1, -6.44126743e-08, 0.0481674224, 6.82698271e-08, 0.998839259))
                        end
                    elseif string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Beautiful Pirate") then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Beautiful Pirate [Lv. 1950] [Boss]") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Beautiful Pirate [Lv. 1950] [Boss]" then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        EquipWeapon(SelectToolWeapon)
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 10))
                                        require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework).activeController.hitboxMagnitude = 1000
                                        game:GetService("VirtualUser"):CaptureController()
                                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                    until AutoRainbow == false or v.Humanoid.Health <= 0 or not v.Parent or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                end
                            end
                        else
                            TP(CFrame.new(5314.58203, 22.536438, -125.942276, 1, 6.26807051e-09, 6.631647e-16, -6.26807051e-09, 1, 9.95202925e-08, -3.93644864e-17, -9.95202925e-08, 1))
                        end
                    else
                        TP(CFrame.new(-11892.0703125, 930.57672119141, -8760.1591796875))
                        if (Vector3.new(-11892.0703125, 930.57672119141, -8760.1591796875) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                            wait(1.5)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("HornedMan","Bet")
                        end
                    end
                end
            end
        end)
    end)
    
    spawn(function()
        while wait(.1) do
            if FarmMasteryFruit then
                if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                    MasteryBFMagnetActive = false
                    CheckLevel()
                    TP(CFrameQ)
                    if (CFrameQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                        wait(1.1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                    end
                elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                    CheckLevel()
                    if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
                        pcall(function()
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == Ms then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                                            HealthMin = v.Humanoid.MaxHealth * HealthPersen/100
                                            if v.Humanoid.Health <= HealthMin then
                                                EquipWeapon(game.Players.LocalPlayer.Data.DevilFruit.Value)
                                                v.Head.CanCollide = false
                                                v.HumanoidRootPart.CanCollide = false
                                                v.HumanoidRootPart.Size = Vector3.new(2,2,1)
                                                TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                                USEBF = true
                                            else
                                                USEBF = false
                                                EquipWeapon(WeaponMastery)
                                                TP(v.HumanoidRootPart.CFrame * Farm_Mode)
                                                game:GetService("VirtualUser"):CaptureController()
                                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 670),workspace.CurrentCamera.CFrame)
                                                v.Head.CanCollide = false
                                                v.HumanoidRootPart.CanCollide = false
                                                v.HumanoidRootPart.Size = Vector3.new(40,40,40)
                                            end
                                            MasteryBFMagnetActive = true
                                            PosMonMasteryFruit = v.HumanoidRootPart.CFrame
                                        else
                                            MasteryBFMagnetActive = false
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                                        end
                                    until v.Humanoid.Health <= 0 or FarmMasteryFruit == false or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                    USEBF = false
                                end
                            end
                        end)
                    else
                        MasteryBFMagnetActive = false
                        TP(CFrameMon)
                    end 
                end
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if FarmMasteryGun then
                if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                    MasteryGunMagnetActive = false
                    CheckLevel()
                    TP(CFrameQ)
                    if (CFrameQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                        wait(1.1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                    end
                elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                    CheckLevel()
                    if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
                        pcall(function()
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == Ms then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                                            HealthMin = v.Humanoid.MaxHealth * HealthPersen/100
                                            if v.Humanoid.Health <= HealthMin then
                                                EquipWeapon(SelectToolWeaponGun)
                                                TP(v.HumanoidRootPart.CFrame * CFrame.new(0,25,0))
                                                local args = {
                                                    [1] = v.HumanoidRootPart.Position,
                                                    [2] = v.HumanoidRootPart
                                                }
                                                game:GetService("Players").LocalPlayer.Character[SelectToolWeaponGun].RemoteFunctionShoot:InvokeServer(unpack(args))
                                            else
                                                EquipWeapon(WeaponMastery)
                                                require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework).activeController.hitboxMagnitude = 1000
                                                TP(v.HumanoidRootPart.CFrame * Farm_Mode)
                                                game:GetService'VirtualUser':CaptureController()
                                                game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                            end
                                            MasteryGunMagnetActive = true 
                                            PosMonMasteryGun = v.HumanoidRootPart.CFrame
                                        else
                                            MasteryGunMagnetActive = false
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                                        end
                                    until v.Humanoid.Health <= 0 or FarmMasteryGun == false or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                    MasteryGunMagnetActive = false
                                end
                            end
                        end)
                    else
                        TP(CFrameMon)
                    end 
                end
            end
        end
    end)
    
    spawn(function()
        pcall(function()
            while wait() do
                if AutoBuyChiplawraid then
                    if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Microchip") and not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Microchip") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Microchip","1")
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Microchip","2")
                    end
                end
            end
        end)
    end)
    
    spawn(function()
        pcall(function()
            while wait(.1) do
                if AutoLowRaid then
                    if not game:GetService("Workspace").Enemies:FindFirstChild("Order [Lv. 1250] [Raid Boss]") and not game:GetService("ReplicatedStorage"):FindFirstChild("Order [Lv. 1250] [Raid Boss]") then
                        if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Microchip") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Microchip") then
                            fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
                        end
                    end
                    if game:GetService("ReplicatedStorage"):FindFirstChild("Order [Lv. 1250] [Raid Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Order [Lv. 1250] [Raid Boss]") then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Order [Lv. 1250] [Raid Boss]") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Order [Lv. 1250] [Raid Boss]" then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        EquipWeapon(SelectToolWeaponLaw)
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,50,25))
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(120, 120, 120)
                                        game:GetService'VirtualUser':CaptureController()
                                        game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                        RawFastAttack = true
                                    until not v.Parent or v.Humanoid.Health <= 0 or AutoLowRaid == false
                                    RawFastAttack = false
                                end
                            end
                        elseif game:GetService("ReplicatedStorage"):FindFirstChild("Order [Lv. 1250] [Raid Boss]") then
                            RawFastAttack = false
                            TP(CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875))
                        end
                    end
                end
            end
        end)
    end)
    
    spawn(function()
        while wait() do
            if LegebdarySword then
                local args = {
                    [1] = "LegendarySwordDealer",
                    [2] = "1"
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                local args = {
                    [1] = "LegendarySwordDealer",
                    [2] = "2"
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                local args = {
                    [1] = "LegendarySwordDealer",
                    [2] = "3"
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                if _G.AutoLegendary_Hop and New_World then
                    wait(10)
                    Teleport()
                end
            end 
        end
    end)
    spawn(function()
        while wait() do
            if Enchancement then
                local args = {
                    [1] = "ColorsDealer",
                    [2] = "2"
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                if _G.AutoEnchancement_Hop and not Old_World then
                    wait(10)
                    Teleport()
                end
            end 
        end
    end)
    
    spawn(function()
        pcall(function()
            while wait(.1) do
                if AutoAccessories or _G.AutoAccessory then
                    CheckAccessory = game:GetService("Players").LocalPlayer.Character
                    if CheckAccessory:FindFirstChild("BlackCape") or CheckAccessory:FindFirstChild("SwordsmanHat") or CheckAccessory:FindFirstChild("PinkCoat") or CheckAccessory:FindFirstChild("TomoeRing") or CheckAccessory:FindFirstChild("MarineCape") or CheckAccessory:FindFirstChild("PirateCape") or CheckAccessory:FindFirstChild("CoolShades") or CheckAccessory:FindFirstChild("UsoapHat") or CheckAccessory:FindFirstChild("MarineCap") or CheckAccessory:FindFirstChild("BlackSpikeyCoat") or CheckAccessory:FindFirstChild("Choppa") or CheckAccessory:FindFirstChild("SaboTopHat") or CheckAccessory:FindFirstChild("WarriorHelmet") or CheckAccessory:FindFirstChild("DarkCoat") or CheckAccessory:FindFirstChild("SwanGlasses") or CheckAccessory:FindFirstChild("ZebraCap") or CheckAccessory:FindFirstChild("GhoulMask") or CheckAccessory:FindFirstChild("BlueSpikeyCoat") or CheckAccessory:FindFirstChild("RedSpikeyCoat") or CheckAccessory:FindFirstChild("SantaHat") or CheckAccessory:FindFirstChild("ElfHat") or CheckAccessory:FindFirstChild("ValkyrieHelm") or CheckAccessory:FindFirstChild("Bandanna(Black)") or CheckAccessory:FindFirstChild("Bandanna(Green)") or CheckAccessory:FindFirstChild("Bandanna(Red)") or CheckAccessory:FindFirstChild("Huntercape(Black)") or CheckAccessory:FindFirstChild("Huntercape(Green)") or CheckAccessory:FindFirstChild("Huntercape(Red)") or CheckAccessory:FindFirstChild("PrettyHelmet") or CheckAccessory:FindFirstChild("JawShield") or CheckAccessory:FindFirstChild("MusketeerHat") or CheckAccessory:FindFirstChild("Pilothelmet") then
                    else
                        EquipWeapon(SelectTooAccessories)
                        wait(1)
                        game:GetService("Players").LocalPlayer.Character[SelectTooAccessories].RemoteFunction:InvokeServer()
                    end
                end
            end
        end)
    end)
    
    spawn(function()
        while wait(.1) do
            for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do  
                if v:IsA("Tool") then 
                    if v.ToolTip == "Wear" then    
                        SelectTooAccessories = v.Name
                    end
                end
            end
        end
    end)
    
    spawn(function()
        pcall(function()
            while wait(.1) do
                if Superhuman or AutoFullySuperhuman then
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Combat") or game.Players.LocalPlayer.Character:FindFirstChild("Combat") or game.Players.LocalPlayer.Backpack:FindFirstChild("Electric Claw") or game.Players.LocalPlayer.Character:FindFirstChild("Electric Claw") or game.Players.LocalPlayer.Backpack:FindFirstChild("Sharkman Karate") or game.Players.LocalPlayer.Character:FindFirstChild("Sharkman Karate") or game.Players.LocalPlayer.Backpack:FindFirstChild("Death Step") or game.Players.LocalPlayer.Character:FindFirstChild("Death Step") then
                        local args = {
                            [1] = "BuyBlackLeg"
                        }
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                    end
                    if game.Players.LocalPlayer.Character:FindFirstChild("Combat") or game.Players.LocalPlayer.Backpack:FindFirstChild("Combat") or game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") or game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") or game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") or game.Players.LocalPlayer.Character:FindFirstChild("Electro") or game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") or game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") or game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") or game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") or game.Players.LocalPlayer.Backpack:FindFirstChild("Superhuman") or game.Players.LocalPlayer.Character:FindFirstChild("Superhuman") then
                        if game.Players.LocalPlayer.Backpack:FindFirstChild("Combat") or game.Players.LocalPlayer.Character:FindFirstChild("Combat") then
                            SelectToolWeapon = "Combat"
                            SelectToolWeaponOld = "Combat"
                        end
                        if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Black Leg") then
                            SelectToolWeapon = "Black Leg"
                            SelectToolWeaponOld = "Black Leg"
                        end
                        if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro") then
                            SelectToolWeapon = "Electro"
                            SelectToolWeaponOld = "Electro"
                        end
                        if game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Fishman Karate") then
                            SelectToolWeapon = "Fishman Karate"
                            SelectToolWeaponOld = "Fishman Karate"
                        end
                        if game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Claw") then
                            SelectToolWeapon = "Dragon Claw"
                            SelectToolWeaponOld = "Dragon Claw"
                        end
                        if game.Players.LocalPlayer.Backpack:FindFirstChild("Superhuman") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Superhuman") then
                            SelectToolWeapon = "Superhuman"
                            SelectToolWeaponOld = "Superhuman"
                        end
                        if (game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 300) or (game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value >= 300) then
                            local args = {
                                [1] = "BuyElectro"
                            }
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                        end
                        if (game.Players.LocalPlayer.Character:FindFirstChild("Electro") and game.Players.LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 300) or (game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value >= 300) then
                            local args = {
                                [1] = "BuyFishmanKarate"
                            }
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                        end
                        if (game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate").Level.Value >= 300) or (game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate").Level.Value >= 300) then
                            if AutoFullySuperhuman then
                                if game.Players.LocalPlayer.Data.Level.Value >= 1100 then
                                    if game.Players.LocalPlayer.Data.Fragments.Value <= 1499 then
                                        RaidSuperhuman = true
                                        _G.SelectRaid = "Flame"
                                        Auto_Farm = false
                                    elseif game.Players.LocalPlayer.Data.Fragments.Value >= 1500 then
                                        RaidSuperhuman = false
                                        if _G.AutoFarm and RaidSuperhuman == false then
                                            Auto_Farm = true
                                        end
                                        local args = {
                                            [1] = "BlackbeardReward",
                                            [2] = "DragonClaw",
                                            [3] = "1"
                                        }
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                        local args = {
                                            [1] = "BlackbeardReward",
                                            [2] = "DragonClaw",
                                            [3] = "2"
                                        }
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                    end
                                end
                            elseif not AutoFullySuperhuman then
                                local args = {
                                    [1] = "BlackbeardReward",
                                    [2] = "DragonClaw",
                                    [3] = "1"
                                }
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                local args = {
                                    [1] = "BlackbeardReward",
                                    [2] = "DragonClaw",
                                    [3] = "2"
                                }
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                            end
                        end
                        if (game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw").Level.Value >= 300) or (game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value >= 300) then
                            local args = {
                                [1] = "BuySuperhuman"
                            }
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                        end
                    end
                end
            end
        end)
    end)
    
    spawn(function()
        while wait(.1) do
            if DeathStep then
                if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value >= 450 then
                    local args = {
                        [1] = "BuyDeathStep"
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                end
                if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 450 then
                    local args = {
                        [1] = "BuyDeathStep"
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                end
                if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value <= 449 then
                    SelectToolWeapon = "Black Leg"
                end
            end
        end
    end)
    
    function CheckBossQuest()
        if Old_World then
            if SelectBoss == "The Gorilla King [Lv. 25] [Boss]" then
                BossMon = "The Gorilla King [Lv. 25] [Boss]"
                NameQuestBoss = "JungleQuest"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$2,000\n7,000 Exp."
                CFrameQBoss = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
                CFrameBoss = CFrame.new(-1142.6488037109, 40.462348937988, -515.39227294922)
            elseif SelectBoss == "Bobby [Lv. 55] [Boss]" then
                BossMon = "Bobby [Lv. 55] [Boss]"
                NameQuestBoss = "BuggyQuest1"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$8,000\n35,000 Exp."
                CFrameQBoss = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
                CFrameBoss = CFrame.new(-1087.3760986328, 46.949409484863, 4040.1462402344)
            elseif SelectBoss == "The Saw [Lv. 100] [Boss]" then
                BossMon = "The Saw [Lv. 100] [Boss]"
                CFrameBoss = CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906)
            elseif SelectBoss == "Yeti [Lv. 110] [Boss]" then
                BossMon = "Yeti [Lv. 110] [Boss]"
                NameQuestBoss = "SnowQuest"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$10,000\n180,000 Exp."
                CFrameQBoss = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
                CFrameBoss = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
            elseif SelectBoss == "Mob Leader [Lv. 120] [Boss]" then
                BossMon = "Mob Leader [Lv. 120] [Boss]"
                CFrameBoss = CFrame.new(-2844.7307128906, 7.4180502891541, 5356.6723632813)
            elseif SelectBoss == "Vice Admiral [Lv. 130] [Boss]" then
                BossMon = "Vice Admiral [Lv. 130] [Boss]"
                NameQuestBoss = "MarineQuest2"
                QuestLvBoss = 2
                RewardBoss = "Reward:\n$10,000\n180,000 Exp."
                CFrameQBoss = CFrame.new(-5036.2465820313, 28.677835464478, 4324.56640625)
                CFrameBoss = CFrame.new(-5006.5454101563, 88.032081604004, 4353.162109375)
            elseif SelectBoss == "Warden [Lv. 175] [Boss]" then
                BossMon = "Warden [Lv. 175] [Boss]"
                NameQuestBoss = "ImpelQuest"
                QuestLvBoss = 1
                RewardBoss = "Reward:\n$6,000\n600,000 Exp."
                CFrameQBoss = CFrame.new(4853.283203125, 5.6783537864685, 745.13970947266)
                CFrameBoss = CFrame.new(5020.9438476563, 88.67887878418, 756.89392089844)
            elseif SelectBoss == "Saber Expert [Lv. 200] [Boss]" then
                BossMon = "Saber Expert [Lv. 200] [Boss]"
                CFrameBoss = CFrame.new(-1458.89502, 29.8870335, -50.633564)
            elseif SelectBoss == "Chief Warden [Lv. 200] [Boss]" then
                BossMon = "Chief Warden [Lv. 200] [Boss]"
                NameQuestBoss = "ImpelQuest"
                QuestLvBoss = 2
                RewardBoss = "Reward:\n$10,000\n700,000 Exp."
                CFrameQBoss = CFrame.new(4853.283203125, 5.6783537864685, 745.13970947266)
                CFrameBoss = CFrame.new(5020.9438476563, 88.67887878418, 756.89392089844)
            elseif SelectBoss == "Flamingo [Lv. 225] [Boss]" then
                BossMon = "Flamingo [Lv. 225] [Boss]"
                NameQuestBoss = "ImpelQuest"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$15,000\n1,300,000 Exp."
                CFrameQBoss = CFrame.new(4853.283203125, 5.6783537864685, 745.13970947266)
                CFrameBoss = CFrame.new(5020.9438476563, 88.67887878418, 756.89392089844)
            elseif SelectBoss == "Magma Admiral [Lv. 350] [Boss]" then
                BossMon = "Magma Admiral [Lv. 350] [Boss]"
                NameQuestBoss = "MagmaQuest"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$15,000\n2,800,000 Exp."
                CFrameQBoss = CFrame.new(-5314.6220703125, 12.262420654297, 8517.279296875)
                CFrameBoss = CFrame.new(-5765.8969726563, 82.92064666748, 8718.3046875)
            elseif SelectBoss == "Fishman Lord [Lv. 425] [Boss]" then
                BossMon = "Fishman Lord [Lv. 425] [Boss]"
                NameQuestBoss = "FishmanQuest"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$15,000\n4,000,000 Exp."
                CFrameQBoss = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
                CFrameBoss = CFrame.new(61260.15234375, 30.950881958008, 1193.4329833984)
            elseif SelectBoss == "Wysper [Lv. 500] [Boss]" then
                BossMon = "Wysper [Lv. 500] [Boss]"
                NameQuestBoss = "SkyExp1Quest"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$15,000\n4,800,000 Exp."
                CFrameQBoss = CFrame.new(-7861.947265625, 5545.517578125, -379.85974121094)
                CFrameBoss = CFrame.new(-7866.1333007813, 5576.4311523438, -546.74816894531)
            elseif SelectBoss == "Thunder God [Lv. 575] [Boss]" then
                BossMon = "Thunder God [Lv. 575] [Boss]"
                NameQuestBoss = "SkyExp2Quest"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$20,000\n5,800,000 Exp."
                CFrameQBoss = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
                CFrameBoss = CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188)
            elseif SelectBoss == "Cyborg [Lv. 675] [Boss]" then
                BossMon = "Cyborg [Lv. 675] [Boss]"
                NameQuestBoss = "FountainQuest"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$20,000\n7,500,000 Exp."
                CFrameQBoss = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
                CFrameBoss = CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813)
            elseif SelectBoss == "Greybeard [Lv. 750] [Raid Boss]" then
                BossMon = "Greybeard [Lv. 750] [Raid Boss]"
                CFrameBoss = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188)
            end
        end
        if New_World then
            if SelectBoss == "Diamond [Lv. 750] [Boss]" then
                BossMon = "Diamond [Lv. 750] [Boss]"
                NameQuestBoss = "Area1Quest"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$25,000\n9,000,000 Exp."
                CFrameQBoss = CFrame.new(-427.5666809082, 73.313781738281, 1835.4208984375)
                CFrameBoss = CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407)
            elseif SelectBoss == "Jeremy [Lv. 850] [Boss]" then
                BossMon = "Jeremy [Lv. 850] [Boss]"
                NameQuestBoss = "Area2Quest"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$25,000\n11,500,000 Exp."
                CFrameQBoss = CFrame.new(636.79943847656, 73.413787841797, 918.00415039063)
                CFrameBoss = CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109)
            elseif SelectBoss == "Fajita [Lv. 925] [Boss]" then
                BossMon = "Fajita [Lv. 925] [Boss]"
                NameQuestBoss = "MarineQuest3"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$25,000\n15,000,000 Exp."
                CFrameQBoss = CFrame.new(-2441.986328125, 73.359344482422, -3217.5324707031)
                CFrameBoss = CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625)
            elseif SelectBoss == "Don Swan [Lv. 1000] [Boss]" then
                BossMon = "Don Swan [Lv. 1000] [Boss]"
                CFrameBoss = CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875)
            elseif SelectBoss == "Smoke Admiral [Lv. 1150] [Boss]" then
                BossMon = "Smoke Admiral [Lv. 1150] [Boss]"
                NameQuestBoss = "IceSideQuest"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$20,000\n25,000,000 Exp."
                CFrameQBoss = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
                CFrameBoss = CFrame.new(-5275.1987304688, 20.757257461548, -5260.6669921875)
            elseif SelectBoss == "Awakened Ice Admiral [Lv. 1400] [Boss]" then
                BossMon = "Awakened Ice Admiral [Lv. 1400] [Boss]"
                NameQuestBoss = "FrostQuest"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$20,000\n36,000,000 Exp."
                CFrameQBoss = CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813)
                CFrameBoss = CFrame.new(6403.5439453125, 340.29766845703, -6894.5595703125)
            elseif SelectBoss == "Tide Keeper [Lv. 1475] [Boss]" then
                BossMon = "Tide Keeper [Lv. 1475] [Boss]"
                NameQuestBoss = "ForgottenQuest"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$12,500\n38,000,000 Exp."
                CFrameQBoss = CFrame.new(-3053.9814453125, 237.18954467773, -10145.0390625)
                CFrameBoss = CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188)
            elseif SelectBoss == "Darkbeard [Lv. 1000] [Raid Boss]" then
                BossMon = "Darkbeard [Lv. 1000] [Raid Boss]"
                CFrameMon = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531)
            elseif SelectBoss == "Cursed Captain [Lv. 1325] [Raid Boss]" then
                BossMon = "Cursed Captain [Lv. 1325] [Raid Boss]"
                CFrameBoss = CFrame.new(916.928589, 181.092773, 33422)
            elseif SelectBoss == "Order [Lv. 1250] [Raid Boss]" then
                BossMon = "Order [Lv. 1250] [Raid Boss]"
                CFrameBoss = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875)
            end
        end
        if Three_World then
            if SelectBoss == "Stone [Lv. 1550] [Boss]" then
                BossMon = "Stone [Lv. 1550] [Boss]"
                NameQuestBoss = "PiratePortQuest"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$25,000\n40,000,000 Exp."
                CFrameQBoss = CFrame.new(-289.76705932617, 43.819011688232, 5579.9384765625)
                CFrameBoss = CFrame.new(-1027.6512451172, 92.404174804688, 6578.8530273438)
            elseif SelectBoss == "Island Empress [Lv. 1675] [Boss]" then
                BossMon = "Island Empress [Lv. 1675] [Boss]"
                NameQuestBoss = "AmazonQuest2"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$30,000\n52,000,000 Exp."
                CFrameQBoss = CFrame.new(5445.9541015625, 601.62945556641, 751.43792724609)
                CFrameBoss = CFrame.new(5543.86328125, 668.97399902344, 199.0341796875)
            elseif SelectBoss == "Kilo Admiral [Lv. 1750] [Boss]" then
                BossMon = "Kilo Admiral [Lv. 1750] [Boss]"
                NameQuestBoss = "MarineTreeIsland"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$35,000\n56,000,000 Exp."
                CFrameQBoss = CFrame.new(2179.3010253906, 28.731239318848, -6739.9741210938)
                CFrameBoss = CFrame.new(2764.2233886719, 432.46154785156, -7144.4580078125)
            elseif SelectBoss == "Captain Elephant [Lv. 1875] [Boss]" then
                BossMon = "Captain Elephant [Lv. 1875] [Boss]"
                NameQuestBoss = "DeepForestIsland"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$40,000\n67,000,000 Exp."
                CFrameQBoss = CFrame.new(-13232.682617188, 332.40396118164, -7626.01171875)
                CFrameBoss = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125)
            elseif SelectBoss == "Beautiful Pirate [Lv. 1950] [Boss]" then
                BossMon = "Beautiful Pirate [Lv. 1950] [Boss]"
                NameQuestBoss = "DeepForestIsland2"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$50,000\n70,000,000 Exp."
                CFrameQBoss = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
                CFrameBoss = CFrame.new(5283.609375, 22.56223487854, -110.78285217285)
            elseif SelectBoss == "Longma [Lv. 2000] [Boss]" then
                BossMon = "Longma [Lv. 2000] [Boss]"
                CFrameBoss = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)
            elseif SelectBoss == "Soul Reaper [Lv. 2100] [Raid Boss]" then
                BossMon = "Soul Reaper [Lv. 2100] [Raid Boss]"
                CFrameBoss = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813)
            elseif SelectBoss == "rip_indra True Form [Lv. 5000] [Raid Boss]" then
                BossMon = "rip_indra True Form [Lv. 5000] [Raid Boss]"
                CFrameBoss = CFrame.new(-5415.3920898438, 505.74133300781, -2814.0166015625)
            end
        end
    end
    
    spawn(function()
        pcall(function()
            while wait(.1) do
                if AutoFarmBoss then
                    CheckBossQuest()
                    if SelectBoss == "Soul Reaper [Lv. 2100] [Raid Boss]" or SelectBoss == "Longma [Lv. 2000] [Boss]" or SelectBoss == "Don Swan [Lv. 1000] [Boss]" or SelectBoss == "Cursed Captain [Lv. 1325] [Raid Boss]" or SelectBoss == "Order [Lv. 1250] [Raid Boss]" or SelectBoss == "rip_indra True Form [Lv. 5000] [Raid Boss]" then
                        if game:GetService("Workspace").Enemies:FindFirstChild(SelectBoss) then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == BossMon then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        EquipWeapon(SelectWeaponBoss)
                                        TP(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                        game:GetService("VirtualUser"):CaptureController()
                                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                    until AutoFarmBoss == false or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
                        else
                            TP(CFrameBoss)
                        end
                    else
                        if BossQuest then
                            if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                                TP(CFrameQBoss)
                                if (CFrameQBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
                                    wait(1.1)
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuestBoss, QuestLvBoss)
                                end
                            elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                                if game:GetService("Workspace").Enemies:FindFirstChild(SelectBoss) then
                                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                        if v.Name == BossMon then
                                            repeat game:GetService("RunService").Heartbeat:wait()
                                                if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestReward.Title.Text, RewardBoss) then
                                                    EquipWeapon(SelectWeaponBoss)
                                                    TP(v.HumanoidRootPart.CFrame * Farm_Mode)
                                                    v.HumanoidRootPart.CanCollide = false
                                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                                    game:GetService("VirtualUser"):CaptureController()
                                                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                else
                                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                                                end
                                            until AutoFarmBoss == false or not v.Parent or v.Humanoid.Health <= 0
                                        end
                                    end
                                else
                                    TP(CFrameBoss)
                                end
                            end
                        else
                            if game:GetService("Workspace").Enemies:FindFirstChild(SelectBoss) then
                                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if v.Name == BossMon then
                                        repeat game:GetService("RunService").Heartbeat:wait()
                                            EquipWeapon(SelectWeaponBoss)
                                            TP(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                            game:GetService("VirtualUser"):CaptureController()
                                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                        until AutoFarmBoss == false or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                end
                            else
                                TP(CFrameBoss)
                            end
                        end
                    end
                end
            end
        end)
    end)
    
    local Plr = game:GetService("Players").LocalPlayer
    local Mouse = Plr:GetMouse()
    Mouse.Button1Down:connect(function()
        if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
            return
        end
        if not Mouse.Target then
            return
        end
        if CTRL then
            Plr.Character:MoveTo(Mouse.Hit.p)
        end
    end)
    
    if _G.AutoFarm_Ken and not game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
        wait()
        game:GetService('VirtualUser'):CaptureController()
        game:GetService('VirtualUser'):SetKeyDown('0x65')
        wait(2)
        game:GetService('VirtualUser'):SetKeyUp('0x65')
    end
    
    spawn(function()
        while wait() do
            pcall(function()
                if AutoFarmObservation then
                    if New_World then
                        if game.Workspace.Enemies:FindFirstChild("Snow Lurker [Lv. 1375]") then
                            if game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                                repeat wait(.1)
                                    TP(game.Workspace.Enemies:FindFirstChild("Snow Lurker [Lv. 1375]").HumanoidRootPart.CFrame * CFrame.new(0,0,-5))
                                until AutoFarmObservation == false or not game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
                                if _G.AutoFarm_Ken and not game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                                    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
                                end
                            else
                                repeat wait(.1)
                                    TP(game.Workspace.Enemies:FindFirstChild("Snow Lurker [Lv. 1375]").HumanoidRootPart.CFrame * CFrame.new(0,25,10))
                                until AutoFarmObservation == false or game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
                            end
                        else
                            TP(CFrame.new(5567.3129882813, 262.92590332031, -6780.9545898438))
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                        end
                    elseif Old_World then
                        if game.Workspace.Enemies:FindFirstChild("Galley Captain [Lv. 650]") then
                            if game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                                repeat wait(.1)
                                    TP(game.Workspace.Enemies:FindFirstChild("Galley Captain [Lv. 650]").HumanoidRootPart.CFrame * CFrame.new(0,0,-5))
                                until AutoFarmObservation == false or not game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
                                if _G.AutoFarm_Ken and not game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                                    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
                                end
                            else
                                repeat wait(.1)
                                    TP(game.Workspace.Enemies:FindFirstChild("Galley Captain [Lv. 650]").HumanoidRootPart.CFrame * CFrame.new(0,25,10))
                                until AutoFarmObservation == false or game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
                            end
                        else
                            TP(CFrame.new(5533.29785, 88.1079102, 4852.3916))
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                        end
                    elseif Three_World then
                        if game.Workspace.Enemies:FindFirstChild("Marine Commodore [Lv. 1700]") then
                            if game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                                repeat wait(.1)
                                    TP(game.Workspace.Enemies:FindFirstChild("Marine Commodore [Lv. 1700]").HumanoidRootPart.CFrame * CFrame.new(0,0,-5))
                                until AutoFarmObservation == false or not game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
                                if _G.AutoFarm_Ken and not game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                                    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
                                end
                            else
                                repeat wait(.1)
                                    TP(game.Workspace.Enemies:FindFirstChild("Marine Commodore [Lv. 1700]").HumanoidRootPart.CFrame * CFrame.new(0,25,10))
                                until AutoFarmObservation == false or game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
                            end
                        else
                            TP(CFrame.new(2445.59204, 273.184479, -7087.646))
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                        end
                    end
                end
            end)
        end
    end)
    
    spawn(function()
        while wait() do wait(Sec)
            pcall(function()
                if AutoFarmObservation and not game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                    game:GetService('VirtualUser'):CaptureController()
                    game:GetService('VirtualUser'):SetKeyDown('0x65')
                    wait(2)
                    game:GetService('VirtualUser'):SetKeyUp('0x65')
                end
            end)
        end
    end)
    
    spawn(function()
        while wait() do
            if AutoObservation then
                if not game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                    wait(1)
                    game:GetService('VirtualUser'):CaptureController()
                    game:GetService('VirtualUser'):SetKeyDown('0x65')
                       wait(2)
                       game:GetService('VirtualUser'):SetKeyUp('0x65')
                end
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if Auto_Haki then
                if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                end
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if Mad then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", SelectPoint)
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if Gan then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Defense", SelectPoint)
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if Dap then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Sword", SelectPoint)
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if Pun then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Gun", SelectPoint)
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if DevilFruit then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", SelectPoint)
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if _G.AutoStat then
                for i,v in pairs(_G.AutoStat) do
                    if v == "Melee" and game.Players.LocalPlayer.Data.Stats.Melee.Level.Value ~= 2200 then
                        repeat game:GetService("RunService").Heartbeat:wait()
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1)
                        until game.Players.LocalPlayer.Data.Stats.Melee.Level.Value == 2200
                    elseif v == "Defense" and game.Players.LocalPlayer.Data.Stats.Defense.Level.Value ~= 2200 then
                        repeat game:GetService("RunService").Heartbeat:wait()
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Defense", 1)
                        until game.Players.LocalPlayer.Data.Stats.Defense.Level.Value == 2200
                    elseif v == "Sword" and game.Players.LocalPlayer.Data.Stats.Sword.Level.Value ~= 2200 then
                        repeat game:GetService("RunService").Heartbeat:wait()
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Sword", 1)
                        until game.Players.LocalPlayer.Data.Stats.Sword.Level.Value == 2200
                    elseif v == "Gun" and game.Players.LocalPlayer.Data.Stats.Gun.Level.Value ~= 2200 then
                        repeat game:GetService("RunService").Heartbeat:wait()
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Gun", 1)
                        until game.Players.LocalPlayer.Data.Stats.Gun.Level.Value == 2200
                    elseif v == "DevilFruit" and game.Players.LocalPlayer.Data.Stats["Demon Fruit"].Level.Value ~= 2200 then
                        repeat game:GetService("RunService").Heartbeat:wait()
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", 1)
                        until game.Players.LocalPlayer.Data.Stats.Gun.Level.Value == 2200
                    end
                end
            end
        end
    end)
    
    spawn(function()
        pcall(function()
            while wait() do
                if _G.Redeem and game.Players.LocalPlayer.Data.Level.Value >= 850 then
                    function UseCode(Text)
                        game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(Text)
                    end
                    UseCode("UPD16")
                    UseCode("2BILLION")
                    UseCode("UPD15")
                    UseCode("FUDD10")
                    UseCode("BIGNEWS")
                    UseCode("THEGREATACE")
                    UseCode("SUB2GAMERROBOT_EXP1")
                    UseCode("StrawHatMaine")
                    UseCode("Sub2OfficialNoobie")
                    UseCode("SUB2NOOBMASTER123")
                    UseCode("Sub2Daigrock")
                    UseCode("Axiore")
                    UseCode("TantaiGaming")
                    UseCode("STRAWHATMAINE")
                end
            end
        end)
    end)
    
    if _G.BoostFPS then
        local decalsyeeted = true
        local g = game
        local w = g.Workspace
        local l = g.Lighting
        local t = w.Terrain
        t.WaterWaveSize = 0
        t.WaterWaveSpeed = 0
        t.WaterReflectance = 0
        t.WaterTransparency = 0
        l.GlobalShadows = false
        l.FogEnd = 9e9
        l.Brightness = 0
        settings().Rendering.QualityLevel = "Level01"
        for i, v in pairs(g:GetDescendants()) do
            if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then 
                v.Material = "Plastic"
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            elseif v:IsA("MeshPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
                v.TextureID = 10385902758728957
            end
        end
        for i, e in pairs(l:GetChildren()) do
            if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                e.Enabled = false
            end
        end
    end
    
    spawn(function()
        pcall(function()
            while wait(.1) do
                if AutoSetSpawn and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                end
            end
        end)
    end)
    
    spawn(function()
        while wait(.1) do
            if USEBF then
                pcall(function()
                    CheckLevel()
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Human-Human: Buddha") then
                        if SkillZ and game.Players.LocalPlayer.Character.HumanoidRootPart.Size == Vector3.new(2, 2.0199999809265, 1) then
                            local args = {
                                [1] = PosMonMasteryFruit.Position
                            }
                            game:GetService("Players").LocalPlayer.Character[game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))
                            game:GetService("VirtualInputManager"):SendKeyEvent(true,"Z",false,game)
                            wait(.3)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false,"Z",false,game)
                        end
                        if SkillX then
                            local args = {
                                [1] = PosMonMasteryFruit.Position
                            }
                            game:GetService("Players").LocalPlayer.Character[game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))
                            game:GetService("VirtualInputManager"):SendKeyEvent(true,"X",false,game)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false,"X",false,game)
                        end
                        if SkillC then
                            local args = {
                                [1] = PosMonMasteryFruit.Position
                            }
                            game:GetService("Players").LocalPlayer.Character[game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))
                            game:GetService("VirtualInputManager"):SendKeyEvent(true,"C",false,game)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false,"C",false,game)
                        end
                        if SkillV then
                            local args = {
                                [1] = PosMonMasteryFruit.Position
                            }
                            game:GetService("Players").LocalPlayer.Character[game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))
                            game:GetService("VirtualInputManager"):SendKeyEvent(true,"V",false,game)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false,"V",false,game)
                        end
                    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value) then
                        if SkillZ then
                            local args = {
                                [1] = PosMonMasteryFruit.Position
                            }
                            game:GetService("Players").LocalPlayer.Character[game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))
                            game:GetService("VirtualInputManager"):SendKeyEvent(true,"Z",false,game)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false,"Z",false,game)
                        end
                        if SkillX then
                            local args = {
                                [1] = PosMonMasteryFruit.Position
                            }
                            game:GetService("Players").LocalPlayer.Character[game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))
                            game:GetService("VirtualInputManager"):SendKeyEvent(true,"X",false,game)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false,"X",false,game)
                        end
                        if SkillC then
                            local args = {
                                [1] = PosMonMasteryFruit.Position
                            }
                            game:GetService("Players").LocalPlayer.Character[game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))
                            game:GetService("VirtualInputManager"):SendKeyEvent(true,"C",false,game)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false,"C",false,game)
                        end
                        if SkillV then
                            local args = {
                                [1] = PosMonMasteryFruit.Position
                            }
                            game:GetService("Players").LocalPlayer.Character[game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))
                            game:GetService("VirtualInputManager"):SendKeyEvent(true,"V",false,game)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false,"V",false,game)
                        end
                    end
                end)
            end
        end
    end)
    
    spawn(function()
        pcall(function()
            game:GetService("RunService").RenderStepped:Connect(function()
                if USEBF and PosMonMasteryFruit ~= nil then
                    local args = {
                        [1] = PosMonMasteryFruit.Position
                    }
                    game:GetService("Players").LocalPlayer.Character[game.Players.LocalPlayer.Data.DevilFruit.Value].RemoteEvent:FireServer(unpack(args))
                end
            end)
        end)
    end)
    
    spawn(function()
        pcall(function()
            while wait(.1) do
                if PressHomeStopTween then
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Home) then
                        TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                    end
                end
            end
        end)
    end)
    
    spawn(function()
        pcall(function()
            while wait() do
                for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do  
                    if v:IsA("Tool") then
                        if v:FindFirstChild("RemoteFunctionShoot") then 
                            SelectToolWeaponGun = v.Name
                        end
                    end
                end
            end
        end)
    end)
    
    spawn(function()
        pcall(function()
            while wait(.1) do
                for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do  
                    if v:IsA("Tool") then
                        if v.ToolTip == "Melee" then
                            SelectToolWeaponMelee = v.Name
                        end
                    end
                end
            end
        end)
    end)
    
    spawn(function()
        pcall(function()
            while wait(.1) do
                if _G.AutoRaid or NextIsland then
                    workspace.Gravity = 0
                else
                    workspace.Gravity = 196
                end
            end
        end)
    end)
    
    local LocalPlayer = game:GetService'Players'.LocalPlayer
    local originalstam = LocalPlayer.Character.Energy.Value
    function infinitestam()
        LocalPlayer.Character.Energy.Changed:connect(function()
            if InfinitsEnergy then
                LocalPlayer.Character.Energy.Value = originalstam
            end 
        end)
    end
    spawn(function()
        while wait(.1) do
            if InfinitsEnergy then
                wait(0.3)
                originalstam = LocalPlayer.Character.Energy.Value
                infinitestam()
            end
        end
    end)
    
    nododgecool = false
    function NoDodgeCool()
        if nododgecool then
            for i,v in next, getgc() do
                if game.Players.LocalPlayer.Character.Dodge then
                    if typeof(v) == "function" and getfenv(v).script == game.Players.LocalPlayer.Character.Dodge then
                        for i2,v2 in next, getupvalues(v) do
                            if tostring(v2) == "0.4" then
                                repeat wait(.1)
                                    setupvalue(v,i2,0)
                                until not nododgecool
                            end
                        end
                    end
                end
            end
        end
    end
    
    function KillPlayerfunc()
        if KillPlayer and Aimbot then
            EquipWeapon(SelectToolWeaponGun)
            if HideHit then
                game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.Transparency = 1
            else
                game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.Transparency = 0.8
            end
            game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.CanCollide = false
            game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.Size = Vector3.new(60,60,60)
            TP(game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.CFrame * CFrame.new(0,50,0))
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
            if SkillZ then
                local args = {
                    [1] = game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.Position
                }
                game:GetService("Players").LocalPlayer.Character[SelectToolWeaponGun].RemoteEvent:FireServer(unpack(args))
                local args = {
                    [1] = "Z",
                    [2] = Vector3.new(0,0,0)
                }
                game:GetService("Players").LocalPlayer.Character[SelectToolWeaponGun].RemoteFunction:InvokeServer(unpack(args))
            end
            if SkillX  then
                local args = {
                    [1] = game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.Position
                }
                game:GetService("Players").LocalPlayer.Character[SelectToolWeaponGun].RemoteEvent:FireServer(unpack(args))
                local args = {
                    [1] = "X",
                    [2] = Vector3.new(0,0,0)
                }
                game:GetService("Players").LocalPlayer.Character[SelectToolWeaponGun].RemoteFunction:InvokeServer(unpack(args))
            end
        elseif KillPlayer then
            EquipWeapon(SelectKillWeapon)
            if HideHit then
                game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.Transparency = 1
            else
                game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.Transparency = .8
            end
            game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.CanCollide = false
            game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.Size = Vector3.new(60,60,60)
            TP(game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.CFrame * CFrame.new(0,13,7))
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
            if SkillZ then
                local args = {
                    [1] = game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.Position
                }
                game:GetService("Players").LocalPlayer.Character[game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))
                local args = {
                    [1] = "Z",
                    [2] = Vector3.new(0,0,0)
                }
                game:GetService("Players").LocalPlayer.Character[game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteFunction:InvokeServer(unpack(args))
            end
            if SkillX  then
                local args = {
                    [1] = game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.Position
                }
                game:GetService("Players").LocalPlayer.Character[game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))
                local args = {
                    [1] = "X",
                    [2] = Vector3.new(0,0,0)
                }
                game:GetService("Players").LocalPlayer.Character[game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteFunction:InvokeServer(unpack(args))
            end
            if SkillV then
                local args = {
                    [1] = game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.Position
                }
                game:GetService("Players").LocalPlayer.Character[game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))
                local args = {
                    [1] = "V",
                    [2] = Vector3.new(0,0,0)
                }
                game:GetService("Players").LocalPlayer.Character[game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteFunction:InvokeServer(unpack(args))
            end
        end
    end
    
    spawn(function()
        pcall(function()
            while wait() do
                if SafeMode then
                    local X = math.random(1,100)
                    local Z = math.random(1,100)
                    TP(CFrame.new(X,game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Y,Z))
                end
            end
        end)
    end)
    
    local lp = game:GetService('Players').LocalPlayer
    local mouse = lp:GetMouse()
    mouse.Button1Down:Connect(function()
        if AimbotRange and game.Players.LocalPlayer.Character:FindFirstChild(SelectToolWeaponGun) then
            for i,v in pairs(game:GetService("Players"):GetChildren()) do
                if v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
                    if (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3 <= RangeAimGun then
                        if v.Name == game.Players.LocalPlayer.Name then
                        else
                            local args = {
                                [1] = v.Character.HumanoidRootPart.Position,
                                [2] = v.Character.HumanoidRootPart
                            }
                            game:GetService("Players").LocalPlayer.Character[SelectToolWeaponGun].RemoteFunctionShoot:InvokeServer(unpack(args))
                        end
                    end
                end
            end
        end
    end)
    
    local lp = game:GetService('Players').LocalPlayer
    local mouse = lp:GetMouse()
    mouse.Button1Down:Connect(function()
        if Aimbot and game.Players.LocalPlayer.Character:FindFirstChild(SelectToolWeaponGun) then
            local args = {
                [1] = game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.Position,
                [2] = game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart
            }
            game:GetService("Players").LocalPlayer.Character[SelectToolWeaponGun].RemoteFunctionShoot:InvokeServer(unpack(args))
        end
    end)
    
    spawn(function()
        pcall(function()
            while game:GetService("RunService").Heartbeat:wait() do
                if KillPlayer then
                    KillPlayerfunc()
                end
            end
        end)
    end)
    
    sector3:AddButton("Hop Lower Server", function()
        HopLowerServer()
    end)
    
    sector3:AddButton("Server Hop", function()
        DiscordLib:Notification("Hop Server", "Wait For Teleport", "Ok")
        Teleport()
    end)
    
    sector3:AddButton("Rejoin Server", function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").localPlayer)
    end)
    
    
    sector3:AddButton("Join Pirates Team", function()
        local args = {
            [1] = "SetTeam",
            [2] = "Pirates"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args)) 
        local args = {
            [1] = "BartiloQuestProgress"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end)
    
    sector3:AddButton("Join Marines Team",function()
        local args = {
            [1] = "SetTeam",
            [2] = "Marines"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        local args = {
            [1] = "BartiloQuestProgress"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end)
    
    
    
    sector3:AddButton("Devil Shop", function()
        local args = {
            [1] = "GetFruits"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        game.Players.localPlayer.PlayerGui.Main.FruitShop.Visible = true
    end)
    
    sector3:AddButton("Inventory", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventoryWeapons")
        game.Players.localPlayer.PlayerGui.Main.Inventory.Visible = true
    end)
    
    sector3:AddButton("Fruit Inventory", function()
        local args = {
            [1] = "getInventoryFruits"
        }
        
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventoryFruits")
        game:GetService("Players").LocalPlayer.PlayerGui.Main.FruitInventory.Visible = true
    end)
    
    sector3:AddButton("Color Haki", function()
        game.Players.localPlayer.PlayerGui.Main.Colors.Visible = true
    end)
    
    sector3:AddButton("Title Name", function()
        local args = {
            [1] = "getTitles"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        game.Players.localPlayer.PlayerGui.Main.Titles.Visible = true
    end)
    
    
    
    if New_World then
        sector3:AddButton("TP to Flower", function()
            if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flower1") or not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower1") then
                TP(game:GetService("Workspace").Flower1.CFrame)
            end
            wait(1)
            if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flower2") or not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower2") then
                TP(game:GetService("Workspace").Flower2.CFrame)
            end
        end)
    end
    
    sector3:AddToggle("No Dodge Cooldown", false, function(Value)
        nododgecool = Value
        NoDodgeCool()
    end)
    
    sector3:AddToggle("Inf Energy",false,function(value)
        InfinitsEnergy = value
        originalstam = LocalPlayer.Character.Energy.Value
    end)
    
    sector3:AddToggle("Inf Ability", false, function(vu)
        InfAbility = vu
    end)
    
    spawn(function()
        while wait() do
            if InfAbility then
                InfAb()
            end
        end
    end)
    
    function InfAb()
        if InfAbility then
            if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
                local inf = Instance.new("ParticleEmitter")
                inf.Acceleration = Vector3.new(0,0,0)
                inf.Archivable = true
                inf.Drag = 20
                inf.EmissionDirection = Enum.NormalId.Top
                inf.Enabled = true
                inf.Lifetime = NumberRange.new(0.2,0.2)
                inf.LightInfluence = 0
                inf.LockedToPart = true
                inf.Name = "Agility"
                inf.Rate = 500
                local numberKeypoints2 = {
                    NumberSequenceKeypoint.new(0, 0);  -- At t=0, size of 0
                    NumberSequenceKeypoint.new(1, 4); -- At t=1, size of 10
                }
    
                inf.Size = NumberSequence.new(numberKeypoints2)
                inf.RotSpeed = NumberRange.new(999, 9999)
                inf.Rotation = NumberRange.new(0, 0)
                inf.Speed = NumberRange.new(30, 30)
                inf.SpreadAngle = Vector2.new(360,360)
                inf.Texture = "rbxassetid://243098098"
                inf.VelocityInheritance = 0
                inf.ZOffset = 2
                inf.Transparency = NumberSequence.new(0)
                inf.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255),Color3.fromRGB(0, 255, 255))
                inf.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
            end
        else
            if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
                game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility"):Destroy()
            end
        end
    end
    
    sector3:AddToggle("Auto Click", false, function(value)
        AutoClick = value 
    end)
    
    sector3:AddToggle("Walk on Water", false, function(vu)
        _G.Water = vu
    end)
    
    spawn(function()
        pcall(function()
            while game:GetService("RunService").Heartbeat:wait() do
                if _G.Water then
                    if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Y <= 1 then
                        if not game:GetService("Workspace"):FindFirstChild("Water") then
                            local Water = Instance.new("Part", game.Workspace)
                            Water.Name = "Water"
                            Water.Size = Vector3.new(10,0.5,10)
                            Water.Transparency = 0.8
                            Water.Anchored = true
                            game:GetService("Workspace").Water.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X,game:GetService("Workspace").Camera["Water;"].CFrame.Y,game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
                        else
                            game:GetService("Workspace").Water.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X,game:GetService("Workspace").Camera["Water;"].CFrame.Y,game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
                        end
                    elseif game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Y >= 1 and game:GetService("Workspace"):FindFirstChild("Water") then
                        game:GetService("Workspace"):FindFirstChild("Water"):Destroy()
                    end
                else
                    if game:GetService("Workspace"):FindFirstChild("Water") then
                        game:GetService("Workspace"):FindFirstChild("Water"):Destroy()
                    end
                end
            end
        end)
    end)
    
    game:GetService("RunService").Heartbeat:Connect(function()
        if AutoClick then
            game:GetService'VirtualUser':Button1Down(Vector2.new(0.9,0.9))
            game:GetService'VirtualUser':Button1Up(Vector2.new(0.9,0.9))
        end
    end)
    
    if Three_World then
        sector3:AddButton("Auto Torch", function()
            if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Holy Torch") and not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Holy Torch") then
                DiscordLib:Notification("Auto Holy Torch", "You not Have Holy Torch", "Okay")
            else
                HolyTorch = true
                EquipWeapon("Holy Torch")
                TP2(CFrame.new(-10753.7842, 412.229553, -9364.7959, 0.999571264, 1.15988023e-07, 0.0292795487, -1.15145767e-07, 1, -3.0452199e-08, -0.0292795487, 2.70677276e-08, 0.999571264))
                wait(1)
                TP2(CFrame.new(-11673.8115, 331.748993, -9473.27246, 0.82297951, -1.03370638e-07, -0.568071067, 7.03514687e-08, 1, -8.00477693e-08, 0.568071067, 2.59130388e-08, 0.82297951))
                wait(1)
                TP2(CFrame.new(-12134.1895, 519.47522, -10653.8457, 0.828167021, 4.15180885e-08, -0.560481429, -3.68933151e-08, 1, 1.95622238e-08, 0.560481429, 4.47723014e-09, 0.828167021))
                wait(1)
                TP2(CFrame.new(-13336.9902, 485.547852, -6983.84131, 0.834512472, 8.29770741e-08, -0.550989032, -5.3400484e-08, 1, 6.97177356e-08, 0.550989032, -2.87572384e-08, 0.834512472))
                wait(1)
                TP2(CFrame.new(-13486.5088, 332.403931, -7925.40527, -0.974250019, 5.647113e-08, 0.225470319, 3.76493894e-08, 1, -8.7777444e-08, -0.225470319, -7.70283606e-08, -0.974250019))
                HolyTorch = false
            end
        end)
    end
    
    sector3:AddButton("Beautiful Mode", function()
        BeautifulMode()
    end)
    
    sector3:AddToggle("Body Light", false, function(vu)
        _G.LightMode = vu
    end)
    
    if _G.BeautifulMode then
        BeautifulMode()
    end
    
    MiscFarmWeapon = ""
    if Old_World then
        tableMon = {"Bandit [Lv. 5]","Monkey [Lv. 14]","Gorilla [Lv. 20]","Pirate [Lv. 35]","Brute [Lv. 45]","Desert Bandit [Lv. 60]","Desert Officer [Lv. 70]","Snow Bandit [Lv. 90]","Snowman [Lv. 100]","Chief Petty Officer [Lv. 120]","Sky Bandit [Lv. 150]","Dark Master [Lv. 175]","Toga Warrior [Lv. 225]","Gladiator [Lv. 275]","Military Soldier [Lv. 300]","Military Spy [Lv. 330]","Fishman Warrior [Lv. 375]","Fishman Commando [Lv. 400]","God's Guard [Lv. 450]","Shanda [Lv. 475]","Royal Squad [Lv. 525]","Royal Soldier [Lv. 550]","Galley Pirate [Lv. 625]","Galley Captain [Lv. 650]"}
    elseif New_World then
        tableMon = {"Raider [Lv. 700]","Mercenary [Lv. 725]","Swan Pirate [Lv. 775]","Factory Staff [Lv. 800]","Marine Lieutenant [Lv. 875]","Marine Captain [Lv. 900]","Zombie [Lv. 950]","Vampire [Lv. 975]","Snow Trooper [Lv. 1000]","Winter Warrior [Lv. 1050]","Lab Subordinate [Lv. 1100]","Horned Warrior [Lv. 1125]","Magma Ninja [Lv. 1175]","Lava Pirate [Lv. 1200]","Ship Deckhand [Lv. 1250]","Ship Engineer [Lv. 1275]","Ship Steward [Lv. 1300]","Ship Officer [Lv. 1325]","Arctic Warrior [Lv. 1350]","Snow Lurker [Lv. 1375]","Sea Soldier [Lv. 1425]","Water Fighter [Lv. 1450]"}
    elseif Three_World then
        tableMon = {"Pirate Millionaire [Lv. 1500]","Dragon Crew Warrior [Lv. 1575]","Dragon Crew Archer [Lv. 1600]","Female Islander [Lv. 1625]","Giant Islander [Lv. 1650]","Marine Commodore [Lv. 1700]","Marine Rear Admiral [Lv. 1725]","Fishman Raider [Lv. 1775]","Fishman Captain [Lv. 1800]","Forest Pirate [Lv. 1825]","Mythological Pirate [Lv. 1850]","Jungle Pirate [Lv. 1900]","Musketeer Pirate [Lv. 1925]","Reborn Skeleton [Lv. 1975]","Living Zombie [Lv. 2000]","Demonic Soul [Lv. 2025]","Posessed Mummy [Lv. 2050]","Ice Cream Chef [Lv. 2125]","Ice Cream Commander [Lv. 2150]"}
    end
    
    sector8:AddDropdown("Select Monster", tableMon,"Monster",false, function(vu)
        SelectMonster = vu
    end)
    
    sector8:AddToggle("Auto Farm Select Monster", false, function(vu)
        AutoFarmSelectMonster = vu
        if vu == false then
            wait(1)
            TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)
    
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventoryWeapons")
    if New_World then
        sector8:AddLabel("Auto Quest")
        sector8:AddToggle("Auto Quest Bartilo", false, function(vu)
            CheckBarto = vu
            if game.Players.LocalPlayer.Backpack:FindFirstChild("Warrior Helmet") then
                Success = true
            elseif game.Players.LocalPlayer.Character:FindFirstChild("Warrior Helmet") then
                Success = true
            end
            if Success and CheckBarto == true then
                DiscordLib:Notification("Auto Quest Bartilo","Successfully","Ok")
            elseif CheckBarto == true and MiscFarmWeapon == "" then
                DiscordLib:Notification("Auto Quest Bartilo","SelectWeapon First","Okay")
            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 3 and CheckBarto == true then
                DiscordLib:Notification("Auto Quest Bartilo","Successfully","Ok")
            else
                AutoBartilo = vu
                if vu == false then
                    wait(1)
                    TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                end
            end
        end)
    
        sector8:AddToggle("Auto Evo Race", false, function(vu)
            CheckEvo = vu
            if not game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 3 and CheckEvo then
                DiscordLib:Notification("Auto Evo Race","You Have To Success Bartilo Quest","Okay")
            elseif CheckEvo == true and MiscFarmWeapon == "" then
                DiscordLib:Notification("Auto Evo Race","SelectWeapon First","Okay")
            elseif game:GetService("Players").LocalPlayer.Data.Race:FindFirstChild("Evolved") and CheckEvo then
                DiscordLib:Notification("Auto Evo Race","Successfully","Ok")
            else
                AutoEvoRace = vu
                if vu == false then
                    wait(1)
                    TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                end
            end
        end)
    
        sector8:AddToggle("Auto Rengoku", false, function(vu)
            AutoRengoku = vu
            if vu == false then
                wait(1)
                TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
            end
        end)
    
        sector8:AddToggle("Auto Ectoplasm", false, function(vu)
            AutoEcto = vu
            if vu == false then
                wait(1)
                TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
            end
        end)
    end
    
    if Three_World then
        sector8:AddToggle("Auto Citizen Quest", false, function(vu)
            CheckCitizen = vu
            TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
            if game.Players.LocalPlayer.Backpack:FindFirstChild("Musketeer Hat") then
                CTCH = true
            elseif game.Players.LocalPlayer.Character:FindFirstChild("Musketeer Hat") then
                CTCH = true
            end
            if CTCH and CheckCitizen then
                DiscordLib:Notification("Auto Quest Citizen","Successfully","Ok")
            elseif CheckCitizen and MiscFarmWeapon == "" then
                DiscordLib:Notification("Auto Quest Citizen","SelectWeapon First","Okay")
            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen") == 3 and CheckCitizen then
                DiscordLib:Notification("Auto Quest Citizen","Successfully","Ok")
            else
                AutoCitizen = vu
                if vu == false then
                    wait(1)
                    TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                end
            end
        end)
    end
    
    sector8:AddDropdown("Select Weapon",Wapon,"Weapon",false,function(value)
           MiscFarmWeapon = value
    end)
    
    sector4:AddLabel("Abilities")
    sector4:AddButton("Skyjump", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Geppo")
    end)
    sector4:AddButton("Buso Haki", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Buso")
    end)
    sector4:AddButton("Soru", function()
       game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Soru")
    end)
    sector4:AddButton("Ken Haki", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk","Buy")
    end)
    
    
    sector4:AddButton("Refund Stat [2500 F]", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Refund","1")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Refund","2")
    end)
    
    sector4:AddButton("Reroll Race [3000 F]", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Reroll","1")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Reroll","2")
    end)
    
    
    
    sector4:AddLabel("Fighting Style")
    
    sector4:AddButton("Black Leg", function()
           game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
    end)
    
    sector4:AddButton("Electro", function()
           game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
    end)
    
    sector4:AddButton("Fishman Karate", function()
           game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
    end)
    
    sector4:AddButton("Dragon Claw", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","1")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
    end)
    
    sector4:AddButton("Superhuman", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
    end)
    sector4:AddButton("Death Step", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
    end)
    sector4:AddButton("Sharkman Karate", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
    end)
    sector4:AddButton("Electric Claw", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw",true)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
    end)
    
    sector4:AddButton("Dragon Talon", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon",true)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
    end)
    
    
    
    sector4:AddLabel("Sword")
    
    sector4:AddButton("Katana", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Katana")
    end)
    
    sector4:AddButton("Cutlass", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Cutlass")
    end)
    
    sector4:AddButton("Duel Katana", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Duel Katana")
    end)
    
    sector4:AddButton("Iron Mace", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Iron Mace")
    end)
    
    sector4:AddButton("Pipe", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Pipe")
    end)
    
    sector4:AddButton("Triple Katana", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Triple Katana")
    end)
    
    sector4:AddButton("Dual-Headed Blade", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Dual-Headed Blade")
    end)
    
    sector4:AddButton("Bisento", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Bisento")
    end)
    
    sector4:AddButton("Soul Cane", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Soul Cane")
    end)
    
    
    sector4:AddLabel("Gun")
    
    sector4:AddButton("Slingshot", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Slingshot")
    end)
    
    sector4:AddButton("Musket", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Musket")
    end)
    
    sector4:AddButton("Flintlock", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Flintlock")
    end)
    
    sector4:AddButton("Refined Flintlock", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Refined Flintlock")
    end)
    
    sector4:AddButton("Cannon", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Cannon")
    end)
    
    sector4:AddButton("Kabucha", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Slingshot","1")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Slingshot","2")
    end)
    
    
    sector4:AddLabel("Accessory")
    
    sector4:AddButton("Black Cape", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Black Cape")
    end)
    
    sector4:AddButton("Toemo Ring", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Tomoe Ring")
    end)
    
    sector4:AddButton("Swordsman Hat", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Swordsman Hat")
    end)
    
    sector7:AddToggle("Auto Store Fruit", false, function(vu)
        AutoStoreFruit = vu
    end)
    
    spawn(function()
        pcall(function()
            while wait(.1) do
                if AutoStoreFruit then
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Bomb Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Bomb Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Bomb-Bomb")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spike Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spike Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Spike-Spike")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Chop Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Chop Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Chop-Chop")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spring Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spring Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Spring-Spring")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Kilo Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Kilo Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Kilo-Kilo")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Smoke Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Smoke Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Smoke-Smoke")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spin Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spin Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Spin-Spin")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flame Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flame Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Flame-Flame")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Bird: Falcon Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Bird: Falcon Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Bird-Bird: Falcon")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ice Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Ice Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Ice-Ice")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Sand Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Sand Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Sand-Sand")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dark Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dark Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Dark-Dark")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Revive Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Revive Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Revive-Dark")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Diamond Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Diamond Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Diamond-Diamond")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Light Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Light Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Light-Light")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Love Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Love Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Love-Love")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Rubber Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rubber Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Rubber-Rubber")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Barrier Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Barrier Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Barrier-Barrier")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Magma Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Magma Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Magma-Magma")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Door Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Door Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Door-Door")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Quake Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Quake Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Quake-Quake")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Human-Human: Buddha Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Human-Human: Buddha Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Human-Human: Buddha")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("String Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("String Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","String-String")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Bird: Phoenix Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Bird: Phoenix Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Bird-Bird: Phoenix")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Rumble Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rumble Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Rumble-Rumble")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Paw Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Paw Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Paw-Paw")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Gravity Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Gravity Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Gravity-Gravity")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dough Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dough Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Dough-Dough")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Shadow Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Shadow Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Shadow-Shadow")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Venom Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Venom Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Venom-Venom")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Control Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Control Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Control-Control")
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Dragon-Dragon")
                    end
                end
            end
        end)
    end)
    
    sector7:AddToggle("Bring Fruit ", _G.BringFruit, function(value)
        BringFruit = value
    end)
    
    spawn(function()
        pcall(function()
            while wait(.1) do
                if BringFruit then
                    for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                        if string.find(v.Name, "Fruit") then
                            if v:IsA("Tool") then
                                v.Handle.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
                                wait(.2)
                                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Handle,0)
                            end
                        end
                    end
                end
            end
        end)
    end)
    
    sector7:AddToggle("Auto Drop Fruit", false, function(vu)
        Drop = vu
    end)
    
    spawn(function()
        while wait() do
            if Drop then
                pcall(function()
                    for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                        if string.find(v.Name, "Fruit") then
                            EquipWeapon(v.Name)
                            SelectFruit = v.Name
                            wait(.1)
                            if game:GetService("Players").LocalPlayer.PlayerGui.Main.Dialogue.Visible == true then
                                game:GetService("Players").LocalPlayer.PlayerGui.Main.Dialogue.Visible = false
                            end
                            EquipWeapon(v.Name)
                            game:GetService("Players").LocalPlayer.Character:FindFirstChild(SelectFruit).EatRemote:InvokeServer("Drop")
                        end
                    end
                    for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                        if string.find(v.Name, "Fruit") then
                            EquipWeapon(v.Name)
                            SelectFruit = v.Name
                            wait(.1)
                            if game:GetService("Players").LocalPlayer.PlayerGui.Main.Dialogue.Visible == true then
                                game:GetService("Players").LocalPlayer.PlayerGui.Main.Dialogue.Visible = false
                            end
                            EquipWeapon(v.Name)
                            game:GetService("Players").LocalPlayer.Character:FindFirstChild(SelectFruit).EatRemote:InvokeServer("Drop")
                        end
                    end
                end)
            end
        end
    end)
    
    
    
    sector7:AddButton("Buy Random Devil Fruit", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
    end)
    
    sector7:AddToggle("Auto Buy Random Fruit", false, function(v)
        DevilAutoBuy = v
    end)
    
    spawn(function()
        while wait(.1) do
            if DevilAutoBuy then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
            end
        end
    end)
    
    if New_World then
        sector9:AddButton("Teleport To Lab", function()
            TP2(CFrame.new(-6438.73535, 250.645355, -4501.50684))
        end)
    elseif Three_World then
        sector9:AddButton("Teleport To RaidLab", function()
            TP2(CFrame.new(-5057.146484375, 314.54132080078, -2934.7995605469))
        end)
    end
    
    sector9:AddToggle("Kill Aura", false, function(vu)
        Killaura = vu
    end)
    
    sector9:AddToggle("Auto Awakenr", false, function(vu)
        AutoAwakener = vu
    end)
    
    sector9:AddToggle("Auto Next Island", false, function(vu)
        NextIsland = vu
    end)
    
    
    
    sector9:AddToggle("Auto Raid", false, function(vu)
        _G.AutoRaid = vu
    end)
    
    sector9:AddDropdown("Select Raid", {"Flame","Ice","Quake","Light","Dark","String","Rumble","Magma","Human: Buddha","Sand"},"Raid",false, function(vu)
        _G.SelectRaid = vu
    end)
    
    sector9:AddToggle("Auto Buy Microchip", false, function(vu)
        AutoBuychip = vu
    end)
    
    spawn(function()
        pcall(function()
            while wait() do
                if AutoBuychip then
                    if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Special Microchip") or not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Special Microchip") then
                        if not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectRaid)
                        end
                    end
                end
            end
        end)
    end)
    
    spawn(function()
        while wait(.1) do
            if _G.AutoRaid or RaidSuperhuman then
                pcall(function()
                    if game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Timer.Visible == false then
                        if AutoFullySuperhuman then
                            if not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") and not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Special Microchip") or not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Special Microchip") then
                                for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                                    if not string.find(v.Name, "Fruit") then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
                                    end
                                end
                            end
                        end
                        if not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectRaid)
                        end
                        if game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
                            game:GetService("StarterGui"):SetCore("SendNotification",
                                {
                                    Title = "Auto Raid",
                                    Text = "Have Some People in Raid",
                                    Icon = "",
                                    Duration = 4
                                }
                            )
                            wait(4)
                        end
                        if not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") and game.Players.LocalPlayer.Backpack:FindFirstChild("Special Microchip") or  game.Players.LocalPlayer.Character:FindFirstChild("Special Microchip")  then
                            if New_World then
                                fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
                            elseif Three_World then
                                fireclickdetector(game:GetService("Workspace").Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
                            end
                        end
                    end
                end)
            end
        end
    end)
    
    spawn(function()
        pcall(function()
            while wait(.1) do
                if AutoAwakener then
                    local args = {
                        [1] = "Awakener",
                        [2] = "Check"
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                    local args = {
                        [1] = "Awakener",
                        [2] = "Awaken"
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                end
            end
        end)
    end)
    
    spawn(function()
        while wait() do
            if Killaura or _G.AutoRaid or RaidSuperhuman then
                for i,v in pairs(game.Workspace.Enemies:GetDescendants()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        pcall(function()
                            repeat wait(.1)
                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                v.Humanoid.Health = 0
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                v.HumanoidRootPart.Transparency = 0.8
                            until not Killaura or not _G.AutoRaid or not RaidSuperhuman or not v.Parent or v.Humanoid.Health <= 0
                        end)
                    end
                end
            end
        end
    end)
    
    spawn(function()
        pcall(function()
            while game:GetService("RunService").Heartbeat:wait() do
                if NextIsland or RaidSuperhuman or _G.AutoRaid then
                    if game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Timer.Visible == true and game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
                        if game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") then
                            TP(game:GetService("Workspace")["_WorldOrigin"].Locations["Island 5"].CFrame*CFrame.new(0,80,0))
                        elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") then
                            TP(game:GetService("Workspace")["_WorldOrigin"].Locations["Island 4"].CFrame*CFrame.new(0,80,0))
                        elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") then
                            TP(game:GetService("Workspace")["_WorldOrigin"].Locations["Island 3"].CFrame*CFrame.new(0,80,0))
                        elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") then
                            TP(game:GetService("Workspace")["_WorldOrigin"].Locations["Island 2"].CFrame*CFrame.new(0,80,0))
                        elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
                            TP(game:GetService("Workspace")["_WorldOrigin"].Locations["Island 1"].CFrame*CFrame.new(0,80,0))
                        end
                    elseif New_World then
                        TP(CFrame.new(-6438.73535, 250.645355, -4501.50684))
                    elseif Three_World then
                        TP(CFrame.new(-5057.146484375, 314.54132080078, -2934.7995605469))
                    end
                end
            end
        end)
    end)
    
    
    sector9:AddToggle("Auto Law Raid", false, function(vu)
        AutoLowRaid = vu
    end)
    
    sector9:AddToggle("Auto Buy Chip Law Raid", false, function(vu)
        AutoBuyChiplawraid = vu
    end)
    
    sector9:AddDropdown("Select Weapon",Wapon,"Weapon",false,function(vu)
        SelectToolWeaponLaw = vu
    end)
    
    
    sector11:AddToggle("Melee", _G.Melee, function(vu)
        Mad = vu
    end)
    
    sector11:AddToggle("Defense", _G.Defense, function(vu)
        Gan = vu
    end)
    
    sector11:AddToggle("Sword", _G.Sword, function(vu)
        Dap = vu
    end)
    
    sector11:AddToggle("Gun", _G.Gun, function(vu)
        Pun = vu
    end)
    
    sector11:AddToggle("Devil Fruit", _G.DevilFruit, function(vu)
        DevilFruit = vu
    end)
    
    SelectPoint = 1
    sector11:AddSlider("Point",1,1,300,1, function(Point)
        SelectPoint = Point
    end)
    
    
    function TP2(P1)
        Distance = (P1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        if Distance < 1000 then
            Speed = 400
        elseif Distance >= 1000 then
            Speed = 250
        end
        game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
            {CFrame = P1}
        ):Play()
        Clip = true
        wait(Distance/Speed)
        Clip = false
    end
    
    sector6:AddButton("Stop Tween", function()
        TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
    end)
    
    if Old_World then
    
        sector6:AddButton("Teleport To Second Sea", function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
        end)
    
        sector6:AddButton("Teleport To Third Sea", function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
        end)
    
    
        sector6:AddButton("Wild Mill", function()
            TP2(CFrame.new(1042.1501464844, 16.299360275269, 1444.3442382813))
        end)
    
        sector6:AddButton("Marine 1st", function()
            TP2(CFrame.new(-2599.6655273438, 6.9146227836609, 2062.2216796875))
        end)
    
        sector6:AddButton("Marine 2sd", function()
            TP2(CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188))
        end)
    
        sector6:AddButton("Midle Town", function()
            TP2(CFrame.new(-655.97088623047, 7.878026008606, 1573.7612304688))
        end)
    
        sector6:AddButton("Jungle", function()
            TP2(CFrame.new(-1499.9877929688, 22.877912521362, 353.87060546875))
        end)
    
        sector6:AddButton("Pirate Village", function()
            TP2(CFrame.new(-1163.3889160156, 44.777843475342, 3842.8276367188))
        end)
    
        sector6:AddButton("Desert", function()
            TP2(CFrame.new(954.02056884766, 6.6275520324707, 4262.611328125))
        end)
    
        sector6:AddButton("Frozen Village", function()
            TP2(CFrame.new(1144.5270996094, 7.3292083740234, -1164.7322998047))
        end)
    
        sector6:AddButton("Colosseum", function()
            TP2(CFrame.new(-1667.5869140625, 39.385631561279, -3135.5817871094))
        end)
    
        sector6:AddButton("Prison", function()
            TP2(CFrame.new(4857.6982421875, 5.6780304908752, 732.75750732422))
        end)
    
        sector6:AddButton("Mob Leader", function()
            TP2(CFrame.new(-2841.9604492188, 7.3560485839844, 5318.1040039063))
        end)
    
        sector6:AddButton("Magma Village", function()
            TP2(CFrame.new(-5328.8740234375, 8.6164798736572, 8427.3994140625))
        end)
    
        sector6:AddButton("UnderWater Gate", function()
            TP2(CFrame.new(3893.953125, 5.3989524841309, -1893.4851074219))
        end)
    
        sector6:AddButton("UnderWater City", function()
            TP2(CFrame.new(61191.12109375, 18.497436523438, 1561.8873291016))
        end)
    
        sector6:AddButton("Fountain City", function()
            TP2(CFrame.new(5244.7133789063, 38.526943206787, 4073.4987792969))
        end)
    
        sector6:AddButton("Sky 1st", function()
            TP2(CFrame.new(-4878.0415039063, 717.71246337891, -2637.7294921875))
        end)
    
        sector6:AddButton("Sky 2sd", function()
            TP2(CFrame.new(-7899.6157226563, 5545.6030273438, -422.21798706055))
        end)
    
        sector6:AddButton("Sky 3th", function()
            TP2(CFrame.new(-7868.5288085938, 5638.205078125, -1482.5548095703))
        end)
        
    elseif New_World then
            
        sector6:AddButton("Teleport To First Sea", function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
        end)
    
        sector6:AddButton("Teleport To Third Sea", function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
        end)
    
    
    
        sector6:AddButton("Dock", function()
            TP2(CFrame.new(-12.519311904907, 19.302536010742, 2827.853515625))
        end)
    
        sector6:AddButton("Mansion", function()
            TP2(CFrame.new(-390.34829711914, 321.89730834961, 869.00506591797))
        end)
    
        sector6:AddButton("Kingdom Of Rose", function()
            TP2(CFrame.new(-388.29895019531, 138.35575866699, 1132.1662597656))
        end)
    
        sector6:AddButton("Cafe", function()
            TP2(CFrame.new(-379.70889282227, 73.0458984375, 304.84692382813))
        end)
    
        sector6:AddButton("Sunflower Field", function()
            TP2(CFrame.new(-1576.7171630859, 198.61849975586, 13.725157737732))
        end)
    
        sector6:AddButton("Jeramy Mountain", function()
            TP2(CFrame.new(1986.3519287109, 448.95678710938, 796.70239257813))
        end)
    
        sector6:AddButton("Colossuem", function()
            TP2(CFrame.new(-1871.8974609375, 45.820514678955, 1359.6843261719))
        end)
    
        sector6:AddButton("Factory", function()
            TP2(CFrame.new(349.53750610352, 74.446998596191, -355.62420654297))
        end)
    
        sector6:AddButton("The Bridge", function()
            TP2(CFrame.new(-1860.6354980469, 88.384948730469, -1859.1593017578))
        end)
    
        sector6:AddButton("Green Bit", function()
            TP2(CFrame.new(-2202.3706054688, 73.097663879395, -2819.2687988281))
        end)
    
        sector6:AddButton("Graveyard", function()
            TP2(CFrame.new(-5617.5927734375, 492.22183227539, -778.3017578125))
        end)
    
        sector6:AddButton("Dark Area", function()
            TP2(CFrame.new(3464.7700195313, 13.375151634216, -3368.90234375))
        end)
    
        sector6:AddButton("Snow Mountain", function()
            TP2(CFrame.new(561.23834228516, 401.44781494141, -5297.14453125))
        end)
    
        sector6:AddButton("Hot Island", function()
            TP2(CFrame.new(-5505.9633789063, 15.977565765381, -5366.6123046875))
        end)
    
        sector6:AddButton("Cold Island", function()
            TP2(CFrame.new(-5924.716796875, 15.977565765381, -4996.427734375))
        end)
    
        sector6:AddButton("Ice Castle", function()
            TP2(CFrame.new(6111.7109375, 294.41259765625, -6716.4829101563))
        end)
    
        sector6:AddButton("Usopp's Island", function()
            TP2(CFrame.new(4760.4985351563, 8.3444719314575, 2849.2426757813))
        end)
    
        sector6:AddButton("inscription Island", function()
            TP2(CFrame.new(-5099.01171875, 98.241539001465, 2424.4035644531))
        end)
    
        sector6:AddButton("Forgotten Island", function()
            TP2(CFrame.new(-3051.9514160156, 238.87203979492, -10250.807617188))
        end)
    
        sector6:AddButton("Ghost Ship", function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
        end)
    
        sector6:AddButton("Mini Sky", function()
            TP2(CFrame.new(-262.11901855469, 49325.69140625, -35272.49609375))
        end)
    
    elseif Three_World then
    
        sector6:AddButton("Teleport to First Sea", function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
        end)
    
        sector6:AddButton("Teleport to Second Sea", function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
        end)
    
        sector6:AddButton("Port Town", function()
            TP2(CFrame.new(-275.21615600586, 43.755737304688, 5451.0659179688))
        end)
    
        sector6:AddButton("Hydra Island", function()
            TP2(CFrame.new(5541.2685546875, 668.30456542969, 195.48069763184))
        end)
        
        sector6:AddButton("Gaint Tree", function()
            TP2(CFrame.new(2276.0859375, 25.87850189209, -6493.03125))
        end)
        
        sector6:AddButton("Zou Island", function()
            TP2(CFrame.new(-10034.40234375, 331.78845214844, -8319.6923828125))
        end)
        
        sector6:AddButton("PineApple Village", function()
            TP2(CFrame.new(-11172.950195313, 331.8049621582, -10151.033203125))
        end)
        
        sector6:AddButton("Mansion", function()
            TP2(CFrame.new(-12548.998046875, 332.40396118164, -7603.1865234375))
        end)
    
        sector6:AddButton("Castle on the Sea", function()
            TP2(CFrame.new(-5498.0458984375, 313.79473876953, -2860.6022949219))
        end)
    
        sector6:AddButton("Graveyard Island", function()
            TP2(CFrame.new(-9515.07324, 142.130615, 5537.58398))
        end)
    
        sector6:AddButton("Raid Lab", function()
            TP2(CFrame.new(-5057.146484375, 314.54132080078, -2934.7995605469))
        end)
    
        sector6:AddButton("Mini Sky", function()
            TP2(CFrame.new(-263.66668701172, 49325.49609375, -35260))
        end)
            sector6:AddButton("Candy Island",function()
            TP2(CFrame.new(-787.857178, 154.602448, -11129.002, -0.849269688, 7.99242095e-09, -0.527959228, 2.16687535e-09, 1, 1.1652717e-08, 0.527959228, 8.75227801e-09, -0.849269688))
        end)
    end
    
    
    local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/ESP%20lib.lua"))()
    ESP:Toggle(true)
    
    ESP.Tracers = false
    ESP.Names = false
    ESP.Boxes = false
    
    sector5:AddToggle("Boxes",false,function(t)
        ESP.Boxes =t 
    end)
    
    sector5:AddToggle("Nametags",false,function(t)
        ESP.Names =t 
    end)
    
    sector5:AddToggle("Tracers",false,function(t)
        ESP.Tracers =t 
    end)
    
    
    
    
    SelectKillWeapon = ""
    
    Player = ""
    sector1:AddDropdown("Selected Player", PlayerName,"",false,function(vu)
        SelectedKillPlayer = vu
    end)
    
    
    
    
    sector1:AddToggle("Spectate Player", false, function(vu)
        Spectate = vu
        repeat game:GetService("RunService").Heartbeat:wait()
            game.Workspace.Camera.CameraSubject = game.Players:FindFirstChild(SelectedKillPlayer).Character.Humanoid
        until Spectate == false
        game.Workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
    end)
    
    
    sector1:AddToggle("Safe Mode", false, function(vu)
        SafeMode = vu
        TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
    end)
    
    
    sector1:AddDropdown("Select Weapon",Wapon,"",false,function(Value)
        SelectKillWeapon = Value
    end)
    
    
    sector1:AddToggle("Kill Player", false, function(vu)
        KillPlayer = vu
        TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
    end)
    
    sector1:AddToggle("Aimbot Gun", false, function(vu)
        Aimbot = vu
    end)
    
    sector1:AddToggle("Aimbot Skill Nearest", false, function(vu)
        AimSkillNearest = vu
    end)
    
    spawn(function()
        while wait(.1) do
            pcall(function()
                local MaxDistance = math.huge
                for i,v in pairs(game:GetService("Players"):GetPlayers()) do
                    if v.Name ~= game.Players.LocalPlayer.Name then
                        local Distance = v:DistanceFromCharacter(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
                        if Distance < MaxDistance then
                            MaxDistance = Distance
                            TargetPlayerAim = v.Name
                        end
                    end
                end
            end)
        end
    end)
    
    spawn(function()
        pcall(function()
            game:GetService("RunService").RenderStepped:connect(function()
                if AimSkillNearest and TargetPlayerAim ~= nil and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and game.Players.LocalPlayer.Character[game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name]:FindFirstChild("MousePos") then
                    local args = {
                        [1] = game:GetService("Players"):FindFirstChild(TargetPlayerAim).Character.HumanoidRootPart.Position
                    }
                    game:GetService("Players").LocalPlayer.Character[game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))
                end
            end)
        end)
    end)
    
    
    
        
      
        
        sector1:AddKeybind("Fly", Enum.KeyCode.R, function(newkey) 
            print(newkey)
        end, function()
        if flying == false then 
        local plr = game.Players.LocalPlayer
        local mouse = plr:GetMouse()
        localplayer = plr
        if workspace:FindFirstChild("Core") then
        workspace.Core:Destroy()
        end
        local Core = Instance.new("Part")
        Core.Name = "Core"
        Core.Size = Vector3.new(0.05, 0.05, 0.05)
        spawn(function()
        Core.Parent = workspace
        local Weld = Instance.new("Weld", Core)
        Weld.Part0 = Core
        Weld.Part1 = localplayer.Character.LowerTorso
        Weld.C0 = CFrame.new(0, 0, 0)
        end)
        workspace:WaitForChild("Core")
        local torso = workspace.Core
        flying = true
        local speed=10 
        local keys={a=false,d=false,w=false,s=false}
        local e1
        local e2
        local function start()
        local pos = Instance.new("BodyPosition",torso)
        local gyro = Instance.new("BodyGyro",torso)
        pos.Name="EPIXPOS"
        pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
        pos.position = torso.Position
        gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        gyro.cframe = torso.CFrame
        repeat
        wait()
        localplayer.Character.Humanoid.PlatformStand=true
        local new=gyro.cframe - gyro.cframe.p + pos.position
        if not keys.w and not keys.s and not keys.a and not keys.d then
        speed=5
        end
        if keys.w then
        new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
        speed=speed+0
        end
        if keys.s then
        new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
        speed=speed+0
        end
        if keys.d then
        new = new * CFrame.new(speed,0,0)
        speed=speed+0
        end
        if keys.a then
        new = new * CFrame.new(-speed,0,0)
        speed=speed+0
        end
        if speed>10 then
        speed=5
        end
        pos.position=new.p
        if keys.w then
        gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
        elseif keys.s then
        gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
        else
        gyro.cframe = workspace.CurrentCamera.CoordinateFrame
        end
        until flying == false
        if gyro then gyro:Destroy() end
        if pos then pos:Destroy() end
        flying=false
        localplayer.Character.Humanoid.PlatformStand=false
        speed=10
        end
        e1=mouse.KeyDown:connect(function(key)
        if not torso or not torso.Parent then flying=true e1:disconnect() e2:disconnect() return end
        if key=="w" then
        keys.w=true
        elseif key=="s" then
        keys.s=true
        elseif key=="a" then
        keys.a=true
        elseif key=="d" then
        keys.d=true
        end
        end)
        e2=mouse.KeyUp:connect(function(key)
        if key=="w" then
        keys.w=false
        elseif key=="s" then
        keys.s=false
        elseif key=="a" then
        keys.a=false
        elseif key=="d" then
        keys.d=false
        end
        end)
        start()
        else
        flying = false
        end
        end)
        
        sector1:AddButton("Reset",function()
        game.Players.LocalPlayer.Character["Humanoid"]:Destroy()
        end)
        
        sector1:AddButton("Rejoin",function()
        game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId,game.JobId,game:GetService"Players".LocalPlayer)
        end)
        
    sector10:AddToggle("Press Home Button Stop Tween", true, function(vu)
        PressHomeStopTween = vu
    end)
    
    if _G.FastAttack == false then
        _G.FastAttack = false
    else
        _G.FastAttack = true
    end
    
    
    sector10:AddToggle("Auto Haki", true, function(vu)
        Auto_Haki = vu
    end)
    
    sector10:AddToggle("Auto Observation Haki", false, function(vu)
        AutoObservation = vu
    end)
    
    sector10:AddLabel("Auto Farm Setting")
    
    
    if _G.LevelMax then
    else
        _G.LevelMax = 2200
    end
    sector10:AddSlider("Level Lock", 1,1,2200,1, function(value)
        LevelLock = value
    end)
    
    sector10:AddToggle("LevelLock Kick", false, function(vu)
        LevelLockKick = vu
    end)
    
    sector10:AddToggle("LevelLock CloseGame", _G.LevelLock, function(vu)
        LevelLockClose = vu
    end)
    
    --[[sector10:AddToggle("Hide HitBox", true, function(t)
        HideHit = t
    end)]]
    
    sector10:AddToggle("BringMob/Magnet", true, function(vu)
        Magnet = vu
    end)
    
    
    sector10:AddLabel("Auto Farm Mastery Setting")
    
    sector10:AddToggle("Skill Z", true, function(vu)
        SkillZ = vu
    end)
    
    sector10:AddToggle("Skill X", true, function(vu)
        SkillX = vu
    end)
    
    sector10:AddToggle("Skill C", true, function(vu)
        SkillC = vu
    end)
    
    sector10:AddToggle("Skill V", true, function(vu)
        SkillV = vu
    end)
    
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
       vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
       wait(1)
       vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
    end
    local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)


setfpscap(1000)
if game.PlaceId == 142823291 then
    
local player = game.Players.LocalPlayer
local Player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local accessories = {}
function GodModeFunc()
	if Player.Character then
		if Player.Character:FindFirstChild("Humanoid") then
			for _, accessory in pairs(Player.Character.Humanoid:GetAccessories()) do 
				table.insert(accessories, accessory:Clone())
			end
			Player.Character.Humanoid.Name = "1"
		end
		local l = Player.Character["1"]:Clone()
		l.Parent = Player.Character
		l.Name = "Humanoid"; wait(0.1)
		Player.Character["1"]:Destroy()
		workspace.CurrentCamera.CameraSubject = Player.Character.Humanoid
		for _, accessory in pairs(accessories) do 
			Player.Character.Humanoid:AddAccessory(accessory)
		end
		Player.Character.Animate.Disabled = true
		wait(0.1)
		Player.Character.Animate.Disabled = false
		--Tag:
		local Tag = Instance.new("BoolValue", Player.Character)
		Tag.Name = "GodMode"
		Tag.Value = true
		spawn(function()
			local Jumping = false
			local Died = false
			Player.Character.Humanoid.Died:connect(function()
				Died = true
			end)
			UIS.InputBegan:connect(function(i, process)
				if  not process and not Died then
					Jumping = false
					spawn(function()
						repeat
						
							game:GetService("RunService").RenderStepped:Wait()
						until not Jumping or Died
					end)
				else
					repeat
						
						game:GetService("RunService").RenderStepped:Wait()
					until not Jumping
				end
			end)
			UIS.InputEnded:connect(function(i, process)
				if  not process and not Died then
					Jumping = false
				end
			end)
		end)
	end
end

mm2 = {
    Coin = false

}
lib=loadstring(game:HttpGet"https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/UILibrary.lua")()

local win = lib:CreateWindow("Murder Mystery 2 ", Vector2.new(492, 598), Enum.KeyCode.RightShift)

local tab1 = win:CreateTab("Main")
local sector1 = tab1:CreateSector("Player","left")
local sector2 = tab1:CreateSector("AutoFarm","right")
local sector3 = tab1:CreateSector("Emotes","left")
local sector4 = tab1:CreateSector("Teleports","right")


local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/ESP%20lib.lua"))()
ESP:Toggle(true)

ESP.Tracers = false
ESP.Names = false
ESP.Boxes = false

function people(model)
if game:GetService("Players")[model.Name].Backpack:FindFirstChild("Knife") or game.Workspace[model.Name]:FindFirstChild("Knife") then return  Murder.Name end
if game:GetService("Players")[model.Name].Backpack:FindFirstChild("Gun") or game:GetService("Players")[model.Name].Backpack:FindFirstChild("Revolver") or game.Workspace[model.Name]:FindFirstChild("Revolver") or game.Workspace[model.Name]:FindFirstChild("Gun") then return CowBoy.Name end
return Color3.fromRGB(0, 255, 0)
end

ESP.Overrides.GetColor = function(model)
    if game:GetService("Players")[model.Name].Backpack:FindFirstChild("Knife") or game.Workspace[model.Name]:FindFirstChild("Knife") then return Color3.fromRGB(255,0,0) end -- yes i use it deal with it i like this method
    if game:GetService("Players")[model.Name].Backpack:FindFirstChild("Gun") or game:GetService("Players")[model.Name].Backpack:FindFirstChild("Revolver") or game.Workspace[model.Name]:FindFirstChild("Revolver") or game.Workspace[model.Name]:FindFirstChild("Gun") then return Color3.fromRGB(0,0,255) end
end 

sector1:AddToggle("Boxes",false,function(t)
    ESP.Boxes =t 
end)

sector1:AddToggle("Nametags",false,function(t)
    ESP.Names =t 
end)

sector1:AddToggle("Tracers",false,function(t)
    ESP.Tracers =t 
end)
sector1:AddSlider("Walkspeed",16,16,300,1,function(a)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = a
    end)
    
    sector1:AddSlider("Jumppower",50,50,500,1,function(a)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = a
    end)
    
    
    
    sector1:AddKeybind("Fly", Enum.KeyCode.F, function(newkey) 
        print(newkey)
    end, function()
    if flying == false then 
    local plr = game.Players.LocalPlayer
    local mouse = plr:GetMouse()
    localplayer = plr
    if workspace:FindFirstChild("Core") then
    workspace.Core:Destroy()
    end
    local Core = Instance.new("Part")
    Core.Name = "Core"
    Core.Size = Vector3.new(0.05, 0.05, 0.05)
    spawn(function()
    Core.Parent = workspace
    local Weld = Instance.new("Weld", Core)
    Weld.Part0 = Core
    Weld.Part1 = localplayer.Character.LowerTorso
    Weld.C0 = CFrame.new(0, 0, 0)
    end)
    workspace:WaitForChild("Core")
    local torso = workspace.Core
    flying = true
    local speed=10 
    local keys={a=false,d=false,w=false,s=false}
    local e1
    local e2
    local function start()
    local pos = Instance.new("BodyPosition",torso)
    local gyro = Instance.new("BodyGyro",torso)
    pos.Name="EPIXPOS"
    pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
    pos.position = torso.Position
    gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    gyro.cframe = torso.CFrame
    repeat
    wait()
    localplayer.Character.Humanoid.PlatformStand=true
    local new=gyro.cframe - gyro.cframe.p + pos.position
    if not keys.w and not keys.s and not keys.a and not keys.d then
    speed=5
    end
    if keys.w then
    new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
    speed=speed+0
    end
    if keys.s then
    new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
    speed=speed+0
    end
    if keys.d then
    new = new * CFrame.new(speed,0,0)
    speed=speed+0
    end
    if keys.a then
    new = new * CFrame.new(-speed,0,0)
    speed=speed+0
    end
    if speed>10 then
    speed=5
    end
    pos.position=new.p
    if keys.w then
    gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
    elseif keys.s then
    gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
    else
    gyro.cframe = workspace.CurrentCamera.CoordinateFrame
    end
    until flying == false
    if gyro then gyro:Destroy() end
    if pos then pos:Destroy() end
    flying=false
    localplayer.Character.Humanoid.PlatformStand=false
    speed=10
    end
    e1=mouse.KeyDown:connect(function(key)
    if not torso or not torso.Parent then flying=true e1:disconnect() e2:disconnect() return end
    if key=="w" then
    keys.w=true
    elseif key=="s" then
    keys.s=true
    elseif key=="a" then
    keys.a=true
    elseif key=="d" then
    keys.d=true
    end
    end)
    e2=mouse.KeyUp:connect(function(key)
    if key=="w" then
    keys.w=false
    elseif key=="s" then
    keys.s=false
    elseif key=="a" then
    keys.a=false
    elseif key=="d" then
    keys.d=false
    end
    end)
    start()
    else
    flying = false
    end
    end)
    
    sector1:AddButton("Reset",function()
    game.Players.LocalPlayer.Character["Humanoid"]:Destroy()
    end)
    
    sector1:AddButton("Rejoin",function()
    game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId,game.JobId,game:GetService"Players".LocalPlayer)
    end)

function tween_teleport(TargetFrame)
    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
    Move = game:GetService("TweenService"):Create(player.Character.HumanoidRootPart, TweenInfo.new(((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - TargetFrame.p).Magnitude / 70), Enum.EasingStyle.Linear, Enum.EasingDirection.In), {CFrame = TargetFrame})
    Move:Play()
    Move.Completed:wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
end

function FindMap()
    for i, v in pairs(workspace:GetChildren()) do
        if v:FindFirstChild("CoinContainer") then
            return v.CoinContainer
        elseif v:FindFirstChild("Map") then
            if pcall(function() local view = v.Map.CoinContainer end) then
                return v.Map.CoinContainer
            end
        end
    end
    return false
end

function Coin_Farm()
    while mm2["Coin"] == true do
        local Map = FindMap()
        if Map then
            local InGame = false
            pcall(function()
                if game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Game:findFirstChild("EarnedXP") and game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Game:findFirstChild("EarnedXP").Visible == true then InGame = true end
            end)
            if InGame then
                pcall(function()
                    local minimum_distant = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Map['Coin_Server'].Coin.Position).Magnitude
                    local minimum_object = Map['Coin_Server']
                    for i, v in pairs(Map:GetChildren()) do
                        if v.Name == 'Coin_Server' then
                            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Coin.Position).Magnitude < minimum_distant then
                                minimum_distant = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Coin.Position).Magnitude;
                                minimum_object = v;
                            end 
                        end
                    end
                    tween_teleport(CFrame.new(minimum_object.Coin.CFrame.p))
                    spawn(function()
                        wait(5)
                        minimum_object.Name = 'False_Coin'
                    end)
                    repeat
                        wait()
                    until(minimum_object.Name ~= 'Coin_Server')
                    wait(1)
                end)
            end
        end
        wait()
    end
end

sector2:AddToggle("CoinFarm",false,function(enabled)
    if enabled == true then
        mm2["Coin"] = true
        spawn(Coin_Farm)
    elseif enabled == false then
       mm2["Coin"] = false
    end
end)

sector2:AddToggle("GodMode",false,function(bacon)
     getgenv().GodMode = bacon
     spawn(function()
     while GodMode do wait()
         pcall(function()
	if  mm2["Coin"]==true  and Player.PlayerGui.MainGUI.Game.CashBag.Visible and not Player.PlayerGui.MainGUI.Game.CashBag.Full.Visible and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
				if getgenv().GodMode and not Player.Character:FindFirstChild("GodMode") then
					GodModeFunc()
				end
end end) end end) end)

sector2:AddToggle("Tp Coin Bag Full",false,function(a)
    getgenv().Tp = a 
    spawn(function()
while Tp do wait()
    pcall(function()
                if  getgenv().Tp and Player.PlayerGui.MainGUI.Game.CashBag.Full.Visible then 
                	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-95.3000259, 135.550064, 21.8999672, 0, 0, -1, 0, 1, 0, 1, 0, 0) 
end end) end end) end)

sector2:AddToggle("Auto Grab Gun",false,function(a)
    getgenv().GrabGun = a 
    spawn(function()
    while wait (1) do
        pcall(function()
            if getgenv().GrabGun then
	local currentX = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X
			local currentY = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Y
			local currentZ = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z	
			
			if workspace:FindFirstChild("GunDrop") ~= nil then
			
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace:FindFirstChild("GunDrop").CFrame	
			wait(0.3)	
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(currentX, currentY, currentZ)
end end end) end end) end)
sector2:AddToggle("KillAlll",false,function(a)
    getgenv().KillAll = a 
end)
    spawn(function()
    while wait () do
        pcall(function()
            if getgenv().KillAll then
  elseif game.Players.LocalPlayer.Backpack["Knife"] then
  for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.name == "Knife" then
            v.Parent = game.Players.LocalPlayer.Character
        end
  end
  
for i ,v in pairs(game.Players:GetPlayers()) do 
    v.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end 

local args = {
    [1] = "Slash"
}

game:GetService("Players").LocalPlayer.Character.Knife.Stab:FireServer(unpack(args))
end end) end end)

 sector3:AddButton("Floss", function()
game:GetService("ReplicatedStorage").PlayEmote:Fire("floss")
end)

 sector3:AddButton("Zen", function()
game:GetService("ReplicatedStorage").PlayEmote:Fire("zen")
end)

sector3:AddButton("Sit", function()
game:GetService("ReplicatedStorage").PlayEmote:Fire("sit")
end)

 sector3:AddButton("Dab", function()
game:GetService("ReplicatedStorage").PlayEmote:Fire("dab")
end)

	sector4:AddButton("Lobby",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-95.3000259, 135.550064, 21.8999672, 0, 0, -1, 0, 1, 0, 1, 0, 0) 
end)

	sector4:AddButton("To Sheriff",function()
    local Players = game:GetService("Players")			
			for i, player in pairs(Players:GetPlayers()) do
				
			    local bp = player.Backpack:GetChildren()
			    for i, tool in pairs(bp) do
			        if tool.Name == "Gun" then
													
				    	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[tool.Parent.Parent.Name].Character.HumanoidRootPart.CFrame
			        end end end end)

	sector4:AddButton("To Murderer",function()
    			local Players = game:GetService("Players")			
			for i, player in pairs(Players:GetPlayers()) do
				
			    local bp = player.Backpack:GetChildren()
			    for i, tool in pairs(bp) do
			        if tool.Name == "Knife" then
													
				    	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[tool.Parent.Parent.Name].Character.HumanoidRootPart.CFrame 
			        end end end end)
			        


local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
end



  if game.PlaceId == 189707 then


local Toggles = {
    AutoFarmForever = false
}
lib=loadstring(game:HttpGet"https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/UILibrary.lua")()

local win = lib:CreateWindow("Bacon hub | Natural Disaster Surivial", Vector2.new(492, 598), Enum.KeyCode.RightShift)

local tab3 = win:CreateTab("Main")
local tab2 = win:CreateTab("Misc")
local sector5 = tab2:CreateSector("ESP","right")
local sector1 = tab2:CreateSector("Universals","left")
local sector2 = tab3:CreateSector("AutoFarm","left")
local sector3 = tab3:CreateSector("Teleports","right")




local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/ESP%20lib.lua"))()
ESP:Toggle(true)

ESP.Tracers = false
ESP.Names = false
ESP.Boxes = false


sector5:AddToggle("Boxes",false,function(t)
    ESP.Boxes =t 
end)

sector5:AddToggle("Nametags",false,function(t)
    ESP.Names =t 
end)

sector5:AddToggle("Tracers",false,function(t)
    ESP.Tracers =t 
end)

sector1:AddSlider("Walkspeed",16,16,300,1,function(a)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = a
    end)
    
    sector1:AddSlider("Jumppower",50,50,500,1,function(a)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = a
    end)
    
    sector1:AddKeybind("No Clip", Enum.KeyCode.R, function(newkey) 
        print(newkey)
    end, function()
    if noclip == false then
    noclip = false
    game:GetService('RunService').Stepped:connect(function()
    if noclip then
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
    end
    end)
    plr = game.Players.LocalPlayer
    mouse = plr:GetMouse()
    noclip = not noclip
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
    else
    noclip = false
    end
    end)
    
    sector1:AddKeybind("Fly", Enum.KeyCode.F, function(newkey) 
        print(newkey)
    end, function()
    if flying == false then 
    local plr = game.Players.LocalPlayer
    local mouse = plr:GetMouse()
    localplayer = plr
    if workspace:FindFirstChild("Core") then
    workspace.Core:Destroy()
    end
    local Core = Instance.new("Part")
    Core.Name = "Core"
    Core.Size = Vector3.new(0.05, 0.05, 0.05)
    spawn(function()
    Core.Parent = workspace
    local Weld = Instance.new("Weld", Core)
    Weld.Part0 = Core
    Weld.Part1 = localplayer.Character.LowerTorso
    Weld.C0 = CFrame.new(0, 0, 0)
    end)
    workspace:WaitForChild("Core")
    local torso = workspace.Core
    flying = true
    local speed=10 
    local keys={a=false,d=false,w=false,s=false}
    local e1
    local e2
    local function start()
    local pos = Instance.new("BodyPosition",torso)
    local gyro = Instance.new("BodyGyro",torso)
    pos.Name="EPIXPOS"
    pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
    pos.position = torso.Position
    gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    gyro.cframe = torso.CFrame
    repeat
    wait()
    localplayer.Character.Humanoid.PlatformStand=true
    local new=gyro.cframe - gyro.cframe.p + pos.position
    if not keys.w and not keys.s and not keys.a and not keys.d then
    speed=5
    end
    if keys.w then
    new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
    speed=speed+0
    end
    if keys.s then
    new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
    speed=speed+0
    end
    if keys.d then
    new = new * CFrame.new(speed,0,0)
    speed=speed+0
    end
    if keys.a then
    new = new * CFrame.new(-speed,0,0)
    speed=speed+0
    end
    if speed>10 then
    speed=5
    end
    pos.position=new.p
    if keys.w then
    gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
    elseif keys.s then
    gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
    else
    gyro.cframe = workspace.CurrentCamera.CoordinateFrame
    end
    until flying == false
    if gyro then gyro:Destroy() end
    if pos then pos:Destroy() end
    flying=false
    localplayer.Character.Humanoid.PlatformStand=false
    speed=10
    end
    e1=mouse.KeyDown:connect(function(key)
    if not torso or not torso.Parent then flying=true e1:disconnect() e2:disconnect() return end
    if key=="w" then
    keys.w=true
    elseif key=="s" then
    keys.s=true
    elseif key=="a" then
    keys.a=true
    elseif key=="d" then
    keys.d=true
    end
    end)
    e2=mouse.KeyUp:connect(function(key)
    if key=="w" then
    keys.w=false
    elseif key=="s" then
    keys.s=false
    elseif key=="a" then
    keys.a=false
    elseif key=="d" then
    keys.d=false
    end
    end)
    start()
    else
    flying = false
    end
    end)
    
    sector1:AddButton("Reset",function()
    game.Players.LocalPlayer.Character["Humanoid"]:Destroy()
    end)
    
    sector1:AddButton("Rejoin",function()
    game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId,game.JobId,game:GetService"Players".LocalPlayer)
    end)

    sector2:AddToggle("AutoFarm Forever",false,function(a)
        Toggles.AutoFarmForever = a
    end)
        spawn(function()
            while wait (0.4) do
        pcall(function()
       if Toggles.AutoFarmForever == true then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-241.711945, 179.598007, 299.103973)
        end end) end end)
        
        sector2:AddButton("AutoChat Next Diaster",function()
        local Character = game:GetService("Players").LocalPlayer.Character
        local Tag = Character:FindFirstChild("SurvivalTag")
        if Tag then
           local args = {
               [1] = "WARNING! The Disaster is: " .. Tag.Value,
               [2] = "All"
           }
           game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
        end
        local function Repeat(R)
           R.ChildAdded:connect(
               function(Find)
                   if Find.Name == "SurvivalTag" then
                       local args = {
                           [1] = "WARNING! The Disaster is: " .. Find.Value,
                           [2] = "All"
                       }
                       game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
                   end
               end
           )
        end
        Repeat(Character)
        game:GetService("Players").LocalPlayer.CharacterAdded:connect(
           function(R)
               Repeat(R) end) end)
           sector2:AddButton("No Fall Damage",function()
              spawn(function()
                  while wait () do
               game.Players.LocalPlayer.Character.FallDamageScript:Destroy()
           end end) end)
           
           sector2:AddButton("Enable Vote Gui",function()
           votemenu = game.Players.LocalPlayer.PlayerGui.MainGui.MapVotePage
        
        votemenu.Visible=true
        end)
        
        sector2:AddButton("Disable Vote Gui",function()
           votemenu = game.Players.LocalPlayer.PlayerGui.MainGui.MapVotePage
        
        votemenu.Visible=false
        end) 

        sector3:AddButton("Lobby",function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-241.711945, 179.598007, 299.103973)
            end)
            sector3:AddButton("Main Map",function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-132.340561, 47.3980064, 1.86407304)
            end)
            
            sector3:AddButton("Join Discord",function()
    setclipboard("https://discord.gg/4KVsXpGjHn")
end)
            
            local vu = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:connect(function()
               vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
               wait(1)
               vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            end)
  end 
        if game.PlaceId == 566399244 or game.PlaceId == 2569625809 then
            
local Toggles = {
AutoFarm = false,
AutoShard = false,
AutoDiamonds = false
}

lib=loadstring(game:HttpGet"https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/UILibrary.lua")()
local win = lib:CreateWindow("Bacon Hub | Elemental BattleGrounds", Vector2.new(492, 598), Enum.KeyCode.RightShift)



local tab2 = win:CreateTab("Auto Farm")
local tab1 = win:CreateTab('Misc')
local sector2 = tab2:CreateSector("Main Functions","left")
local sector1 = tab1:CreateSector("Universal","left")
local Utils = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
firsttime = true








sector1:AddSlider("Walkspeed",16,16,300,1,function(a)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = a
end)

sector1:AddSlider("Jumppower",50,50,500,1,function(a)
game.Players.LocalPlayer.Character.Humanoid.JumpPower = a
end)

sector1:AddKeybind("No Clip", Enum.KeyCode.R, function(newkey) 
    print(newkey)
end, function()
if noclip == false then
noclip = false
game:GetService('RunService').Stepped:connect(function()
if noclip then
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
end
end)
plr = game.Players.LocalPlayer
mouse = plr:GetMouse()
noclip = not noclip
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
else
noclip = false
end
end)


sector1:AddKeybind("Fly", Enum.KeyCode.F, function(newkey) 
    print(newkey)
end, function()
if flying == false then 
local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
localplayer = plr
if workspace:FindFirstChild("Core") then
workspace.Core:Destroy()
end
local Core = Instance.new("Part")
Core.Name = "Core"
Core.Size = Vector3.new(0.05, 0.05, 0.05)
spawn(function()
Core.Parent = workspace
local Weld = Instance.new("Weld", Core)
Weld.Part0 = Core
Weld.Part1 = localplayer.Character.LowerTorso
Weld.C0 = CFrame.new(0, 0, 0)
end)
workspace:WaitForChild("Core")
local torso = workspace.Core
flying = true
local speed=10 
local keys={a=false,d=false,w=false,s=false}
local e1
local e2
local function start()
local pos = Instance.new("BodyPosition",torso)
local gyro = Instance.new("BodyGyro",torso)
pos.Name="EPIXPOS"
pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
pos.position = torso.Position
gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
gyro.cframe = torso.CFrame
repeat
wait()
localplayer.Character.Humanoid.PlatformStand=true
local new=gyro.cframe - gyro.cframe.p + pos.position
if not keys.w and not keys.s and not keys.a and not keys.d then
speed=5
end
if keys.w then
new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
speed=speed+0
end
if keys.s then
new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
speed=speed+0
end
if keys.d then
new = new * CFrame.new(speed,0,0)
speed=speed+0
end
if keys.a then
new = new * CFrame.new(-speed,0,0)
speed=speed+0
end
if speed>10 then
speed=5
end
pos.position=new.p
if keys.w then
gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
elseif keys.s then
gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
else
gyro.cframe = workspace.CurrentCamera.CoordinateFrame
end
until flying == false
if gyro then gyro:Destroy() end
if pos then pos:Destroy() end
flying=false
localplayer.Character.Humanoid.PlatformStand=false
speed=10
end
e1=mouse.KeyDown:connect(function(key)
if not torso or not torso.Parent then flying=true e1:disconnect() e2:disconnect() return end
if key=="w" then
keys.w=true
elseif key=="s" then
keys.s=true
elseif key=="a" then
keys.a=true
elseif key=="d" then
keys.d=true
end
end)
e2=mouse.KeyUp:connect(function(key)
if key=="w" then
keys.w=false
elseif key=="s" then
keys.s=false
elseif key=="a" then
keys.a=false
elseif key=="d" then
keys.d=false
end
end)
start()
else
flying = false
end
end)

sector1:AddButton("Reset",function()
game.Players.LocalPlayer.Character["Humanoid"]:Destroy()
end)

sector1:AddButton("Rejoin",function()
game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId,game.JobId,game:GetService"Players".LocalPlayer)
end)

sector2:AddToggle("AutoFarm",false,function(a)
Toggles.AutoFarm = a
end)
spawn(function()
    while wait () do
    pcall(function()
    if Toggles.AutoFarm == true then
game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(11)
end end) end end)
wait(1)
local _speed=3000
function tp(...)
   local plr=game.Players.LocalPlayer
   local args={...}
   if typeof(args[1])=="number"and args[2]and args[3]then
      args=Vector3.new(args[1],args[2],args[3])
   elseif typeof(args[1])=="Vector3" then
       args=args[1]    
   elseif typeof(args[1])=="CFrame" then
       args=args[1].Position
   end
   local dist=(plr.Character.HumanoidRootPart.Position-args).Magnitude
   game:GetService("TweenService"):Create(
       plr.Character.HumanoidRootPart,
       TweenInfo.new(dist/_speed,Enum.EasingStyle.Linear),
       {CFrame=CFrame.new(args)}
   ):Play()
end
tp(-638.353638, -58.3049469, 757.653931, -0.709312856, -2.77422252e-11, 0.704893827, 6.66586893e-15, 1, 3.93633112e-11, -0.704893827, 2.79256011e-11, -0.709312856)
wait(0.3)
local baseplate = Instance.new("Part")
baseplate.Parent = workspace
baseplate.Size = Vector3.new(80,1,80)
baseplate.Anchored = true
baseplate.Name = "Baseplate"
baseplate.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0,-2,0)
wait(1.5)
spawn(function()
while wait () do
        pcall(function()
        if Toggles.AutoFarm == true then 
game:GetService("ReplicatedStorage").Remotes.DoClientMagic:FireServer("Fire","Consecutive Fire Bullets")
game:GetService("ReplicatedStorage").Remotes.DoMagic:InvokeServer("Fire","Consecutive Fire Bullets")
game:GetService("ReplicatedStorage").Remotes.DoClientMagic:FireServer("Fire","Great Fire Blast")
game:GetService("ReplicatedStorage").Remotes.DoMagic:InvokeServer("Fire","Great Fire Blast")
end end) end end)
spawn(function() 
while wait (5) do
        pcall(function()
        if Toggles.AutoFarm == true then
local _speed=3000
function tp(...)
   local plr=game.Players.LocalPlayer
   local args={...}
   if typeof(args[1])=="number"and args[2]and args[3]then
      args=Vector3.new(args[1],args[2],args[3])
   elseif typeof(args[1])=="Vector3" then
       args=args[1]    
   elseif typeof(args[1])=="CFrame" then
       args=args[1].Position
   end
   local dist=(plr.Character.HumanoidRootPart.Position-args).Magnitude
   game:GetService("TweenService"):Create(
       plr.Character.HumanoidRootPart,
       TweenInfo.new(dist/_speed,Enum.EasingStyle.Linear),
       {CFrame=CFrame.new(args)}
   ):Play()
end

tp(-638.353638, -58.3049469, 757.653931, -0.709312856, -2.77422252e-11, 0.704893827, 6.66586893e-15, 1, 3.93633112e-11, -0.704893827, 2.79256011e-11, -0.709312856)
end end) end end)

sector2:AddToggle("AutoShard",false,function(a)
Toggles.AutoShard = a 
end)
spawn(function()
while wait () do
        pcall(function()
        if Toggles.AutoShard == true then
        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = game:GetService("Workspace")[".Ignore"][".ServerEffects"]:WaitForChild("Shard").CFrame
        end end) end end)
sector2:AddToggle("AutoDiamonds",false,function(a)
Toggles.AutoDiamonds = a 
end)
spawn(function()
while wait () do
        pcall(function()
        if Toggles.AutoDiamonds == true then
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = game:GetService("Workspace")[".Ignore"][".ServerEffects"]:WaitForChild("Diamond").CFrame
        end end) end end)
        
            sector2:AddButton("Join Discord",function()
    setclipboard("https://discord.gg/4KVsXpGjHn")
end)
end 
if game.PlaceId == 137885680 or game.PlaceId == 4301323950 then
    
local Toggles = {
    AutoFarm = false
 }
lib=loadstring(game:HttpGet"https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/UILibrary.lua")()
local win = lib:CreateWindow("Bacon hub | Zombie Rush", Vector2.new(492, 598), Enum.KeyCode.RightShift)


local tab1 = win:CreateTab("Main")
local sector2 = tab1:CreateSector("AutoFarming","left")
local sector5 = tab1:CreateSector("ESP","right")
local sector1 = tab1:CreateSector("Universal","left")

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/ESP%20lib.lua"))()
ESP:Toggle(true)

ESP.Tracers = false
ESP.Names = false
ESP.Boxes = false




sector5:AddToggle("Boxes",false,function(t)
    ESP.Boxes =t 
end)

sector5:AddToggle("Nametags",false,function(t)
    ESP.Names =t 
end)

sector5:AddToggle("Tracers",false,function(t)
    ESP.Tracers =t 
end)
sector1:AddSlider("Walkspeed",16,16,300,1,function(a)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = a
    end)
    
    sector1:AddSlider("Jumppower",50,50,500,1,function(a)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = a
    end)
    
    sector1:AddKeybind("No Clip", Enum.KeyCode.R, function(newkey) 
        print(newkey)
    end, function()
    if noclip == false then
    noclip = false
    game:GetService('RunService').Stepped:connect(function()
    if noclip then
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
    end
    end)
    plr = game.Players.LocalPlayer
    mouse = plr:GetMouse()
    noclip = not noclip
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
    else
    noclip = false
    end
    end)
    
    sector1:AddKeybind("Fly", Enum.KeyCode.F, function(newkey) 
        print(newkey)
    end, function()
    if flying == false then 
    local plr = game.Players.LocalPlayer
    local mouse = plr:GetMouse()
    localplayer = plr
    if workspace:FindFirstChild("Core") then
    workspace.Core:Destroy()
    end
    local Core = Instance.new("Part")
    Core.Name = "Core"
    Core.Size = Vector3.new(0.05, 0.05, 0.05)
    spawn(function()
    Core.Parent = workspace
    local Weld = Instance.new("Weld", Core)
    Weld.Part0 = Core
    Weld.Part1 = localplayer.Character.LowerTorso
    Weld.C0 = CFrame.new(0, 0, 0)
    end)
    workspace:WaitForChild("Core")
    local torso = workspace.Core
    flying = true
    local speed=10 
    local keys={a=false,d=false,w=false,s=false}
    local e1
    local e2
    local function start()
    local pos = Instance.new("BodyPosition",torso)
    local gyro = Instance.new("BodyGyro",torso)
    pos.Name="EPIXPOS"
    pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
    pos.position = torso.Position
    gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    gyro.cframe = torso.CFrame
    repeat
    wait()
    localplayer.Character.Humanoid.PlatformStand=true
    local new=gyro.cframe - gyro.cframe.p + pos.position
    if not keys.w and not keys.s and not keys.a and not keys.d then
    speed=5
    end
    if keys.w then
    new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
    speed=speed+0
    end
    if keys.s then
    new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
    speed=speed+0
    end
    if keys.d then
    new = new * CFrame.new(speed,0,0)
    speed=speed+0
    end
    if keys.a then
    new = new * CFrame.new(-speed,0,0)
    speed=speed+0
    end
    if speed>10 then
    speed=5
    end
    pos.position=new.p
    if keys.w then
    gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
    elseif keys.s then
    gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
    else
    gyro.cframe = workspace.CurrentCamera.CoordinateFrame
    end
    until flying == false
    if gyro then gyro:Destroy() end
    if pos then pos:Destroy() end
    flying=false
    localplayer.Character.Humanoid.PlatformStand=false
    speed=10
    end
    e1=mouse.KeyDown:connect(function(key)
    if not torso or not torso.Parent then flying=true e1:disconnect() e2:disconnect() return end
    if key=="w" then
    keys.w=true
    elseif key=="s" then
    keys.s=true
    elseif key=="a" then
    keys.a=true
    elseif key=="d" then
    keys.d=true
    end
    end)
    e2=mouse.KeyUp:connect(function(key)
    if key=="w" then
    keys.w=false
    elseif key=="s" then
    keys.s=false
    elseif key=="a" then
    keys.a=false
    elseif key=="d" then
    keys.d=false
    end
    end)
    start()
    else
    flying = false
    end
    end)
    
    sector1:AddButton("Reset",function()
    game.Players.LocalPlayer.Character["Humanoid"]:Destroy()
    end)
    
    sector1:AddButton("Rejoin",function()
    game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId,game.JobId,game:GetService"Players".LocalPlayer)
    end)
sector2:AddToggle("AutoFarm",false,function(a)
    Toggles.AutoFarm = a 
end)
game:GetService("RunService").Stepped:connect(function()
        if Toggles.AutoFarm == true then
game.workspace.Gravity = 0
        end end)
            sector2:AddButton("Join Discord",function()
    setclipboard("https://discord.gg/4KVsXpGjHn")
end)
spawn(function()
 while wait (1) do
pcall(function()
if Toggles.AutoFarm == true then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-153.47319, 52.5, -4828.72021, -0.998862445, 4.47831461e-08, 0.0476949513, 4.73453277e-08, 1, 5.25903197e-08, -0.0476949513, 5.47886252e-08, -0.998862445) 
end end) end end)
spawn(function()
 while wait () do
pcall(function()
if Toggles.AutoFarm == true then
for i, v in pairs(workspace["Zombie Storage"]:GetChildren()) do wait()
if v:FindFirstChild("Head") then
local args = {
    [1] = {
        ["LaserProperties"] = {
            [1] = {
                [1] = "Neon",
                [2] = BrickColor.new(1003),
                [3] = Vector3.new(0, 0, 0),
                [4] = CFrame.new(Vector3.new(121, 200, 4869), Vector3.new(-0, -0, -1)),
                [5] = Vector3.new(150.73249816895, 24.428089141846, 114.7022857666),
                [6] = 9000000000,
                [7] = true,
                [8] = Vector3.new(0, 0, 0)
            }
        },
       ["RealTool"] = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool"),
       ["Tool"] = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool"),
        ["HumanoidTables"] = {
            [1] = {
                ["HeadHits"] = 10,
                ["THumanoid"] = v.Humanoid,
                ["BodyHits"] = 0
            }
        }
    }
}

game:GetService("ReplicatedStorage").Remotes.WeaponEvent:FireServer(unpack(args))
   for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        if v.ClassName == "Tool" and v:FindFirstChild("GunController") then
                            v.Parent = game.Players.LocalPlayer.Character
                        end
                    end
end end end end) end end)
end 




if game.PlaceId == 920587237 then
            
for Name, Remote in pairs(debug.getupvalue(require(game:service'ReplicatedStorage'.Fsys).load("RouterClient").init, 4)) do
    Remote.Name = Name
end

local Toggles = {
    BabyAutoFarm = false,
    AutoPayCheck =false,
    HealOthers = false,
    InstantTradeBadge = false
}

lib=loadstring(game:HttpGet"https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/UILibrary.lua")()
local win = lib:CreateWindow("Bacon hub | Adopt Me!", Vector2.new(492, 598), Enum.KeyCode.RightShift)



local tab2 = win:CreateTab("Auto Farm")
local tab3 = win:CreateTab("Teleports")
local tab1 = win:CreateTab('Misc')
local sector2 = tab2:CreateSector("Main Functions","left")
local sector3 = tab2:CreateSector("Buy Eggs","right")
local sector4 = tab3:CreateSector("Misc","left")
local sector5 = tab3:CreateSector("Teleport","right")
local sector1 = tab1:CreateSector("Universal","left")
local Utils = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
firsttime = true







sector1:AddSlider("Walkspeed",16,16,300,1,function(a)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = a
end)

sector1:AddSlider("Jumppower",50,50,500,1,function(a)
game.Players.LocalPlayer.Character.Humanoid.JumpPower = a
end)

sector1:AddKeybind("No Clip", Enum.KeyCode.R, function(newkey) 
    print(newkey)
end, function()
if noclip == false then
noclip = false
game:GetService('RunService').Stepped:connect(function()
if noclip then
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
end
end)
plr = game.Players.LocalPlayer
mouse = plr:GetMouse()
noclip = not noclip
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
else
noclip = false
end
end)

sector1:AddKeybind("Fly", Enum.KeyCode.F, function(newkey) 
    print(newkey)
end, function()
if flying == false then 
local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
localplayer = plr
if workspace:FindFirstChild("Core") then
workspace.Core:Destroy()
end
local Core = Instance.new("Part")
Core.Name = "Core"
Core.Size = Vector3.new(0.05, 0.05, 0.05)
spawn(function()
Core.Parent = workspace
local Weld = Instance.new("Weld", Core)
Weld.Part0 = Core
Weld.Part1 = localplayer.Character.LowerTorso
Weld.C0 = CFrame.new(0, 0, 0)
end)
workspace:WaitForChild("Core")
local torso = workspace.Core
flying = true
local speed=10 
local keys={a=false,d=false,w=false,s=false}
local e1
local e2
local function start()
local pos = Instance.new("BodyPosition",torso)
local gyro = Instance.new("BodyGyro",torso)
pos.Name="EPIXPOS"
pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
pos.position = torso.Position
gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
gyro.cframe = torso.CFrame
repeat
wait()
localplayer.Character.Humanoid.PlatformStand=true
local new=gyro.cframe - gyro.cframe.p + pos.position
if not keys.w and not keys.s and not keys.a and not keys.d then
speed=5
end
if keys.w then
new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
speed=speed+0
end
if keys.s then
new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
speed=speed+0
end
if keys.d then
new = new * CFrame.new(speed,0,0)
speed=speed+0
end
if keys.a then
new = new * CFrame.new(-speed,0,0)
speed=speed+0
end
if speed>10 then
speed=5
end
pos.position=new.p
if keys.w then
gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
elseif keys.s then
gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
else
gyro.cframe = workspace.CurrentCamera.CoordinateFrame
end
until flying == false
if gyro then gyro:Destroy() end
if pos then pos:Destroy() end
flying=false
localplayer.Character.Humanoid.PlatformStand=false
speed=10
end
e1=mouse.KeyDown:connect(function(key)
if not torso or not torso.Parent then flying=true e1:disconnect() e2:disconnect() return end
if key=="w" then
keys.w=true
elseif key=="s" then
keys.s=true
elseif key=="a" then
keys.a=true
elseif key=="d" then
keys.d=true
end
end)
e2=mouse.KeyUp:connect(function(key)
if key=="w" then
keys.w=false
elseif key=="s" then
keys.s=false
elseif key=="a" then
keys.a=false
elseif key=="d" then
keys.d=false
end
end)
start()
else
flying = false
end
end)

sector1:AddButton("Reset",function()
game.Players.LocalPlayer.Character["Humanoid"]:Destroy()
end)

sector1:AddButton("Rejoin",function()
game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId,game.JobId,game:GetService"Players".LocalPlayer)
end)

sector2:AddLabel("Must Be Baby")
sector2:AddToggle("BabyAutoFarm",false,function(a)
    Toggles.BabyAutoFarm = a
end)
spawn(function()
    while wait (0.3) do
        pcall(function()
            if Toggles.BabyAutoFarm == true then
local args = {
    [1] = "sleepy",
    [2] = 1
}

game:GetService("ReplicatedStorage").API:FindFirstChild("MonitorAPI/AddAdditive"):FireServer(unpack(args))

local args = {
    [1] = "dirty",
    [2] = 1
}

game:GetService("ReplicatedStorage").API:FindFirstChild("MonitorAPI/AddAdditive"):FireServer(unpack(args))


local args = {
    [1] = "thirsty",
    [2] = 1
}

game:GetService("ReplicatedStorage").API:FindFirstChild("MonitorAPI/AddAdditive"):FireServer(unpack(args))

local args = {
    [1] = "bored",
    [2] = 1
}

game:GetService("ReplicatedStorage").API:FindFirstChild("MonitorAPI/AddAdditive"):FireServer(unpack(args))


local args = {
    [1] = "camping",
    [2] = 1
}

game:GetService("ReplicatedStorage").API:FindFirstChild("MonitorAPI/AddAdditive"):FireServer(unpack(args))

local args = {
    [1] = "hungry",
    [2] = 1
}

game:GetService("ReplicatedStorage").API:FindFirstChild("MonitorAPI/AddAdditive"):FireServer(unpack(args))

local args = {
    [1] = "sick",
    [2] = 1
}

game:GetService("ReplicatedStorage").API:FindFirstChild("MonitorAPI/AddAdditive"):FireServer(unpack(args))

local args = {
    [1] = "school",
    [2] = 1
}

game:GetService("ReplicatedStorage").API:FindFirstChild("MonitorAPI/AddAdditive"):FireServer(unpack(args))

local args = {
    [1] = "hot_spring",
    [2] = 1
}

game:GetService("ReplicatedStorage").API:FindFirstChild("MonitorAPI/AddAdditive"):FireServer(unpack(args))

end end) end end)


sector2:AddToggle("AutoPayCheck",false,function(a)
    Toggles.AutoPayCheck = a
end)
spawn(function()
    while wait (3) do
        pcall(function()
            if Toggles.AutoPayCheck == true then
game:GetService("ReplicatedStorage").API:FindFirstChild("PayAPI/CashOut"):InvokeServer()
end end) end end)

sector2:AddToggle("HealOthers",false,function(a)
    Toggles.HealOthers = a
end)
spawn(function()
    while wait (3) do
    pcall(function()
        if Toggles.HealOthers == true then
game:GetService("ReplicatedStorage").API:FindFirstChild("MonitorAPI/HealWithDoctor"):FireServer()
end end) end end)

sector2:AddButton("Become Baby",function()
     local args = {
    [1] = "Babies",
    [2] = true
}
 
game:GetService("ReplicatedStorage").API["TeamAPI/ChooseTeam"]:InvokeServer(unpack(args))
end)
sector2:AddButton("Free PopCorn",function()
local args = {
    [1] = "food",
    [2] = "popcorn_vip",
    [3] = {}
}

game:GetService("ReplicatedStorage").API:FindFirstChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
end)

sector2:AddButton("Free MilkShake",function()
local args = {
    [1] = "food",
    [2] = "chocolate_milk_vip",
    [3] = {}
}

game:GetService("ReplicatedStorage").API:FindFirstChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
end)

sector3:AddButton("Buy Mythic Egg",function()
    local args = {
   [1] = "pets",
   [2] = "Mythic_egg",
   [3] = {}
}
game:GetService("ReplicatedStorage").API["ShopAPI/BuyItem"]:InvokeServer(unpack(args))
end)

sector3:AddButton("Buy Cracked Egg",function()
    local args = {
   [1] = "pets",
   [2] = "cracked_egg",
   [3] = {}
}
game:GetService("ReplicatedStorage").API["ShopAPI/BuyItem"]:InvokeServer(unpack(args))
end)

sector3:AddButton("Buy Normal Egg",function()
    local args = {
   [1] = "pets",
   [2] = "regular_pet_egg",
   [3] = {}
}
game:GetService("ReplicatedStorage").API["ShopAPI/BuyItem"]:InvokeServer(unpack(args))
end)

sector3:AddButton("Buy Royal Egg",function()
    local args = {
   [1] = "pets",
   [2] = "royal_egg",
   [3] = {}
}
game:GetService("ReplicatedStorage").API["ShopAPI/BuyItem"]:InvokeServer(unpack(args))
end)

sector4:AddButton("Get Badges",function()
    local args = {
    [1] = "miniworld"
}
game:GetService("ReplicatedStorage").API["MinigameAPI/FinishObby"]:FireServer(unpack(args))
wait(0.5)
local args = {
    [1] = "coastal_climb"
}
game:GetService("ReplicatedStorage").API["MinigameAPI/FinishObby"]:FireServer(unpack(args))
wait(0.5)
local args = {
    [1] = "shipwreck_bay"
}
game:GetService("ReplicatedStorage").API["MinigameAPI/FinishObby"]:FireServer(unpack(args))
wait(0.5)
local args = {
    [1] = "ancient_ruins"
}
game:GetService("ReplicatedStorage").API["MinigameAPI/FinishObby"]:FireServer(unpack(args))
wait(0.5)
local args = {
    [1] = "lonelypeak"
}
game:GetService("ReplicatedStorage").API["MinigameAPI/FinishObby"]:FireServer(unpack(args))
wait(0.5)
local args = {
    [1] = "pyramid"
}
game:GetService("ReplicatedStorage").API["MinigameAPI/FinishObby"]:FireServer(unpack(args))
wait(0.5)
local args = {
    [1] = "tinyisles"
}
game:GetService("ReplicatedStorage").API["MinigameAPI/FinishObby"]:FireServer(unpack(args)) 
end)


sector4:AddToggle("InstantTradeBadge",false,function(a)
    Toggles.InstantTradeBadge = a 
end)
    spawn(function()
    while wait(0.5) do
        pcall(function()
            if Toggles.InstantTradeBadge == true then
    local args = {
        [1] = "has_talked_to_trade_quest_npc",
        [2] = true
    }
    
    game:GetService("ReplicatedStorage").API["SettingsAPI/SetBooleanFlag"]:FireServer(unpack(args))  
    local ags = {
        [1] = "TradeLicenseZone"
    }
    
    game:GetService("ReplicatedStorage").API["LocationAPI/SetLocation"]:FireServer(unpack(args)) 
    game:GetService("ReplicatedStorage").API["TradeAPI/BeginQuiz"]:FireServer() 
    
    local args = {
        [1] = "not safe"
    }
    
    game:GetService("ReplicatedStorage").API["TradeAPI/AnswerQuizQuestion"]:FireServer(unpack(args)) 
        local args = {
        [1] = "safe"
    }
    
    game:GetService("ReplicatedStorage").API["TradeAPI/AnswerQuizQuestion"]:FireServer(unpack(args))  
    local args = {
        [1] = "not safe"
    }
    
    game:GetService("ReplicatedStorage").API["TradeAPI/AnswerQuizQuestion"]:FireServer(unpack(args)) 
    game:GetService("ReplicatedStorage").API["TradeAPI/EndQuiz"]:FireServer() 
    end end) end end)

            sector4:AddButton("Join Discord",function()
    setclipboard("https://discord.gg/4KVsXpGjHn")
end)

local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
firsttime = false
end

if game.PlaceId == 2788229376 then
                --Da Hood

local Toggles = {
    MoneyAutoFarm = false,
   HospitalFarm = false,
   AutoStomp = false
}

lib=loadstring(game:HttpGet"https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/UILibrary.lua")()
local win = lib:CreateWindow("Bacon hub | Da Hood", Vector2.new(492, 598), Enum.KeyCode.RightShift)



local tab2 = win:CreateTab("Main")
local tab5 = win:CreateTab("AutoBuy")
local tab1 = win:CreateTab('Misc')
local sector2 = tab2:CreateSector("AutoFarm","left")
local sector1 = tab1:CreateSector("Universal","left")
local sector4 = tab2:CreateSector("Combat","left")
local sector5 = tab1:CreateSector("ESP","right")
local sector6 = tab5:CreateSector("Buy Shop Items","left")
local sector7 = tab5:CreateSector("Buy Guns","right")
local sector8 = tab5:CreateSector("Buy Ammo","left")
local Utils = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/ESP%20lib.lua"))()
ESP:Toggle(true)

ESP.Tracers = false
ESP.Names = false
ESP.Boxes = false

firsttime = true 



sector1:AddKeybind("No Clip", Enum.KeyCode.U, function(newkey) 
    print(newkey)
end, function()
if noclip == false then
noclip = false
game:GetService('RunService').Stepped:connect(function()
if noclip then
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
end
end)
plr = game.Players.LocalPlayer
mouse = plr:GetMouse()
noclip = not noclip
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
else
noclip = false
end
end)

sector1:AddKeybind("Fly", Enum.KeyCode.Y, function(newkey) 
    print(newkey)
end, function()
if flying == false then 
local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
localplayer = plr
if workspace:FindFirstChild("Core") then
workspace.Core:Destroy()
end
local Core = Instance.new("Part")
Core.Name = "Core"
Core.Size = Vector3.new(0.05, 0.05, 0.05)
spawn(function()
Core.Parent = workspace
local Weld = Instance.new("Weld", Core)
Weld.Part0 = Core
Weld.Part1 = localplayer.Character.LowerTorso
Weld.C0 = CFrame.new(0, 0, 0)
end)
workspace:WaitForChild("Core")
local torso = workspace.Core
flying = true
local speed=10 
local keys={a=false,d=false,w=false,s=false}
local e1
local e2
local function start()
local pos = Instance.new("BodyPosition",torso)
local gyro = Instance.new("BodyGyro",torso)
pos.Name="EPIXPOS"
pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
pos.position = torso.Position
gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
gyro.cframe = torso.CFrame
repeat
wait()
localplayer.Character.Humanoid.PlatformStand=true
local new=gyro.cframe - gyro.cframe.p + pos.position
if not keys.w and not keys.s and not keys.a and not keys.d then
speed=5
end
if keys.w then
new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
speed=speed+0
end
if keys.s then
new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
speed=speed+0
end
if keys.d then
new = new * CFrame.new(speed,0,0)
speed=speed+0
end
if keys.a then
new = new * CFrame.new(-speed,0,0)
speed=speed+0
end
if speed>10 then
speed=5
end
pos.position=new.p
if keys.w then
gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
elseif keys.s then
gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
else
gyro.cframe = workspace.CurrentCamera.CoordinateFrame
end
until flying == false
if gyro then gyro:Destroy() end
if pos then pos:Destroy() end
flying=false
localplayer.Character.Humanoid.PlatformStand=false
speed=10
end
e1=mouse.KeyDown:connect(function(key)
if not torso or not torso.Parent then flying=true e1:disconnect() e2:disconnect() return end
if key=="w" then
keys.w=true
elseif key=="s" then
keys.s=true
elseif key=="a" then
keys.a=true
elseif key=="d" then
keys.d=true
end
end)
e2=mouse.KeyUp:connect(function(key)
if key=="w" then
keys.w=false
elseif key=="s" then
keys.s=false
elseif key=="a" then
keys.a=false
elseif key=="d" then
keys.d=false
end
end)
start()
else
flying = false
end
end)

sector1:AddButton("Reset",function()
game.Players.LocalPlayer.Character["Humanoid"]:Destroy()
end)

sector1:AddButton("ServerHop",function()
 local HttpService, TPService = game:GetService("HttpService"), game:GetService("TeleportService")
        local ServersToTP = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        for _, s in pairs(ServersToTP.data) do
          if s.playing ~= s.maxPlayers then
              TPService:TeleportToPlaceInstance(game.PlaceId, s.id)
          end end end)
          
sector1:AddButton("Rejoin",function()
game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId,game.JobId,game:GetService"Players".LocalPlayer)
end)

sector2:AddToggle("MoneyAutoFarm",false,function(a)
    Toggles.MoneyAutoFarm = a
end)
local gm = getrawmetatable(game)
setreadonly(gm, false)
local namecall = gm.__namecall
gm.__namecall =
    newcclosure(
    function(self, ...)
        local args = {...}
        if not checkcaller() and getnamecallmethod() == "FireServer" and tostring(self) == "MainEvent" then
            if tostring(getcallingscript()) ~= "Framework" then
                return
            end
        end
        if not checkcaller() and getnamecallmethod() == "Kick" then
            return
        end
        return namecall(self, unpack(args))
    end
)

local LocalPlayer = game:GetService("Players").LocalPlayer

function gettarget()
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    local maxdistance = math.huge
    local target
    for i, v in pairs(game:GetService("Workspace").Cashiers:GetChildren()) do
        if v:FindFirstChild("Head") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            local distance = (HumanoidRootPart.Position - v.Head.Position).magnitude
            if distance < maxdistance then
                target = v
                maxdistance = distance
            end
        end
    end
    return target
end

for i, v in pairs(workspace:GetDescendants()) do
    if v:IsA("Seat") then
        v:Destroy()
    end
end
spawn(function()
    while wait () do
        pcall(function()
            if Toggles.MoneyAutoFarm == true then
    wait()
    local Target = gettarget()
    repeat
        wait()
        pcall(
            function()
                local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait()
                local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                local Combat = LocalPlayer.Backpack:FindFirstChild("Combat") or Character:FindFirstChild("Combat")
                if not Combat then
                    Character:FindFirstChild("Humanoid").Health = 0
                    return
                end
                HumanoidRootPart.CFrame = Target.Head.CFrame * CFrame.new(0, -2.5, 3)
                Combat.Parent = Character
                Combat:Activate()
            end
        )
    until not Target or Target.Humanoid.Health < 0
    for i, v in pairs(game:GetService("Workspace").Ignored.Drop:GetDescendants()) do
        if v:IsA("ClickDetector") and v.Parent and v.Parent.Name:find("Money") then
            local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait()
            local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
            if (v.Parent.Position - HumanoidRootPart.Position).magnitude <= 18 then
                repeat
                    wait()
                    fireclickdetector(v)
                until not v or not v.Parent.Parent
            end
        end
    end
    wait(1)
end end) end end)

sector2:AddToggle("HospitalFarm",false,function(a)
    Toggles.HospitalFarm= a
end)
game:getService("RunService"):BindToRenderStep(
    "",
    0,
    function()
        if not game.Players.LocalPlayer.Character:findFirstChildOfClass("Humanoid") then
            return
        end
        while wait() do
            if Toggles.HospitalFarm == true then
                game.Players.LocalPlayer.Character:findFirstChildOfClass("Humanoid"):ChangeState(11)
            end
        end
    end
)
spawn(function()
while wait(1) do
    if Toggles.HospitalFarm == true then
        pcall(
            function()
                for i, v in pairs(game:GetService("Workspace").Ignored.HospitalJob:GetChildren()) do
                    if v:IsA("Model") then
                        _G.patient = v.Name
                        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame =
                            game.Workspace.Ignored.HospitalJob[v.Name].HumanoidRootPart.CFrame *
                            CFrame.new(Vector3.new(0, -6.5, 0), Vector3.new(0, 100, 0))
                    end
                end
                for i, v in pairs(game.Workspace.Ignored.HospitalJob:GetChildren()) do
                    if v.Name == "Can I get the Red bottle" then
                        local clickdetector = game.Workspace.Ignored.HospitalJob.Red.ClickDetector
                        fireclickdetector(clickdetector)
                    elseif v.Name == "Can I get the Blue bottle" then
                        local clickdetector = game.Workspace.Ignored.HospitalJob.Blue.ClickDetector
                        fireclickdetector(clickdetector)
                    elseif v.Name == "Can I get the Green bottle" then
                        local clickdetector = game.Workspace.Ignored.HospitalJob.Green.ClickDetector
                        fireclickdetector(clickdetector)
                    end
                end
                local clickdetector2 = game:GetService("Workspace").Ignored.HospitalJob[_G.patient].ClickDetector
                fireclickdetector(clickdetector2)
            end) end end end)


sector4:AddToggle("AutoStomp",false,function(a)
    Toggles.AutoStomp = a
end)
spawn(function()
while wait (0.2) do
    pcall(function()
        if Toggles.AutoStomp == true then
local args = {
    [1] = "Stomp"
}

game:GetService("ReplicatedStorage").MainEvent:FireServer(unpack(args))
end end) end end)


sector4:AddLabel("Rexecute When You Respawn")
sector4:AddButton("Fists Reach",function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/BaconLords/shit-with-sugar/main/Da%20Hood%20Reach'),true))()
end)

sector4:AddButton("Infinite Stamina",function()
local Players = game:GetService"Players";
local Client = Players.LocalPlayer

function InfiniteStamina()
   local BodyEffects = Client.Character:WaitForChild"BodyEffects";
   local Defense, Movement, Reload = BodyEffects:WaitForChild"Defense", BodyEffects:WaitForChild"Movement", BodyEffects:WaitForChild"Reload"
   
   while wait() do
       Reload.Value = false
       Defense.Value = 9e9
       
       for _, v in next, Movement:GetChildren() do
           if v then
               v:Destroy()
           end
       end
   end
end
InfiniteStamina()
end)

            sector4:AddButton("Join Discord",function()
    setclipboard("https://discord.gg/4KVsXpGjHn")
end)
sector5:AddToggle("Boxes",false,function(t)
    ESP.Boxes =t 
end)

sector5:AddToggle("Nametags",false,function(t)
    ESP.Names =t 
end)

sector5:AddToggle("Tracers",false,function(t)
    ESP.Tracers =t 
end)


sector6:AddButton("Buy Ninja Mask",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[Ninja Mask] - $60"].Head.CFrame
wait(0.3)
for i,v in pairs(game:GetService("Workspace").Ignored.Shop["[Ninja Mask] - $60"]:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v)
        end end end)
        
        sector6:AddButton("Buy Surgeon Mask",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[Surgeon Mask] - $25"].Head.CFrame
wait(0.3)
for i,v in pairs(game:GetService("Workspace").Ignored.Shop["[Surgeon Mask] - $25"]:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v)
        end end end)
        
        sector6:AddButton("Buy PepperSpray",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[PepperSpray] - $150"].Head.CFrame
wait(0.3)
for i,v in pairs(game:GetService("Workspace").Ignored.Shop["[PepperSpray] - $150"]:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v)
        end end end)
        
        sector6:AddButton("Buy LockPicker",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[LockPicker] - $100"].Head.CFrame
wait(0.3)
for i,v in pairs(game:GetService("Workspace").Ignored.Shop["[LockPicker] - $100"]:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v)
        end end end)

sector6:AddButton("Buy PaintBall Mask",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[PaintBall Mask] - $60"].Head.CFrame
wait(0.3)
for i,v in pairs(game:GetService("Workspace").Ignored.Shop["[PaintBall Mask] - $60"]:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v)
        end end end)
        
        sector6:AddButton("Buy Hockey Mask",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[Hockey Mask] - $60"].Head.CFrame
wait(0.3)
for i,v in pairs(game:GetService("Workspace").Ignored.Shop["[Hockey Mask] - $60"]:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v)
        end end end)
        

        
sector7:AddButton("Buy Glock",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[Glock] - $500"].Head.CFrame
wait(0.3)
for i,v in pairs(game:GetService("Workspace").Ignored.Shop["[Glock] - $500"]:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v)
        end end end)
        
        sector7:AddButton("Buy Silencer",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[Silencer] - $550"].Head.CFrame
wait(0.3)
for i,v in pairs(game:GetService("Workspace").Ignored.Shop["[Silencer] - $550"]:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v)
        end end end)
        
        sector7:AddButton("Buy TacticalShotgun",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[TacticalShotgun] - $1750"].Head.CFrame
wait(0.3)
for i,v in pairs(game:GetService("Workspace").Ignored.Shop["[TacticalShotgun] - $1750"]:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v)
        end end end)
        
        sector7:AddButton("Buy SilencerAR",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[SilencerAR] - $1250"].Head.CFrame
wait(0.3)
for i,v in pairs(game:GetService("Workspace").Ignored.Shop["[SilencerAR] - $1250"]:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v)
        end end end)
        
        
        sector7:AddButton("Buy P90",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[P90] - $1000"].Head.CFrame
wait(0.3)
for i,v in pairs(game:GetService("Workspace").Ignored.Shop["[P90] - $1000"]:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v)
        end end end)
        
        
        sector8:AddButton("Glock Ammo",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["25 [Glock Ammo] - $60"].Head.CFrame
wait(0.3)
for i,v in pairs(game:GetService("Workspace").Ignored.Shop["25 [Glock Ammo] - $60"]:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v)
        end end end)
        
        
            sector8:AddButton("Silencer Ammo",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["25 [Silencer Ammo] - $50"].Head.CFrame
wait(0.3)
for i,v in pairs(game:GetService("Workspace").Ignored.Shop["25 [Silencer Ammo] - $50"]:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v)
        end end end)
        
                sector8:AddButton("SilencerAR Ammo",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["120 [SilencerAR Ammo] - $75"].Head.CFrame
wait(0.3)
for i,v in pairs(game:GetService("Workspace").Ignored.Shop["120 [SilencerAR Ammo] - $75"]:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v)
        end end end)
        
                sector8:AddButton("TacticalShotgun Ammo",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["20 [TacticalShotgun Ammo] - $60"].Head.CFrame
wait(0.3)
for i,v in pairs(game:GetService("Workspace").Ignored.Shop["20 [TacticalShotgun Ammo] - $60"]:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v)
        end end end)

        sector8:AddButton("P90 Ammo",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["120 [P90 Ammo] - $60"].Head.CFrame
wait(0.3)
for i,v in pairs(game:GetService("Workspace").Ignored.Shop["120 [P90 Ammo] - $60"]:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v)
        end end end)


local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

 

print("Bypassed Anti Cheat")



firsttime = false
end
if game.PlaceId == 3956818381 then
                

local Toggles = {
    AutoEquipSword = false,
	AutoSwing = false,
	AutoSell = false,
	AutoHoops = false,
	AutoBuySwords = false,
	AutoBuyBelts = false,
	AutoRanks = false,
	AutoSkills = false,
	AutoShuriken = false,
	AutoChi = false,
	AutoCoin = false,
	FarmRobotBoss = false,
	FarmEthernalBoss = false,
	FarmAncientMagmaBoss = false,
	FastSheriken = false,
	Invisible = false,
	AutoEvolve = false,
    AutoEternalize = false,
    AutoImortalize = false,
    AutoLegend = false,
    AutoElementalize = false,
    SellBasics = false,
    SellAdvanced = false,
    SellRares = false,
    SellEpics = false,
    SellUniques = false,
    SellOmegas = false,
    SellInfinitys = false
}
lib=loadstring(game:HttpGet"https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/UILibrary.lua")()
local win = lib:CreateWindow("Bacon hub | ⚡ Ninja Legends", Vector2.new(492, 598), Enum.KeyCode.RightShift)




 local tab2 = win:CreateTab("AutoFarm")
 local tab3 = win:CreateTab("AutoBuy")
 local tab4 = win:CreateTab("Pet Stuff")
 local tab7 = win:CreateTab("Teleport")
 local tab6 = win:CreateTab("Misc")
local sector2 = tab2:CreateSector("Main Functions","left")
local sector3 = tab2:CreateSector("BossFarms","right")
local sector4 = tab2:CreateSector("AutoChi/Coin","left")
local sector5 = tab3:CreateSector("Purchaseable Items","left")
local sector6 = tab3:CreateSector("Get Elements","right")
local sector7 = tab4:CreateSector("Auto Buy Pets","left")
local sector8 = tab4:CreateSector("Auto Evolve","right")
local sector9 = tab4:CreateSector("Auto Sell Pets","left")
local sector13 = tab6:CreateSector("Misc","right")
local sector10 = tab7:CreateSector("Training Areas","left")
local sector11 = tab7:CreateSector("Alters","left")
local sector12 = tab7:CreateSector("Islands","right")
local sector1 = tab6:CreateSector("Universal","left")
local Utils = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer






sector1:AddSlider("Walkspeed",16,16,300,1,function(a)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = a
end)

sector1:AddSlider("Jumppower",50,50,500,1,function(a)
game.Players.LocalPlayer.Character.Humanoid.JumpPower = a
end)

sector1:AddKeybind("No Clip", Enum.KeyCode.R, function(newkey) 
    print(newkey)
end, function()
if noclip == false then
noclip = false
game:GetService('RunService').Stepped:connect(function()
if noclip then
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
end
end)
plr = game.Players.LocalPlayer
mouse = plr:GetMouse()
noclip = not noclip
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
else
noclip = false
end
end)

sector1:AddKeybind("Fly", Enum.KeyCode.F, function(newkey) 
    print(newkey)
end, function()
if flying == false then 
local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
localplayer = plr
if workspace:FindFirstChild("Core") then
workspace.Core:Destroy()
end
local Core = Instance.new("Part")
Core.Name = "Core"
Core.Size = Vector3.new(0.05, 0.05, 0.05)
spawn(function()
Core.Parent = workspace
local Weld = Instance.new("Weld", Core)
Weld.Part0 = Core
Weld.Part1 = localplayer.Character.LowerTorso
Weld.C0 = CFrame.new(0, 0, 0)
end)
workspace:WaitForChild("Core")
local torso = workspace.Core
flying = true
local speed=10 
local keys={a=false,d=false,w=false,s=false}
local e1
local e2
local function start()
local pos = Instance.new("BodyPosition",torso)
local gyro = Instance.new("BodyGyro",torso)
pos.Name="EPIXPOS"
pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
pos.position = torso.Position
gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
gyro.cframe = torso.CFrame
repeat
wait()
localplayer.Character.Humanoid.PlatformStand=true
local new=gyro.cframe - gyro.cframe.p + pos.position
if not keys.w and not keys.s and not keys.a and not keys.d then
speed=5
end
if keys.w then
new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
speed=speed+0
end
if keys.s then
new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
speed=speed+0
end
if keys.d then
new = new * CFrame.new(speed,0,0)
speed=speed+0
end
if keys.a then
new = new * CFrame.new(-speed,0,0)
speed=speed+0
end
if speed>10 then
speed=5
end
pos.position=new.p
if keys.w then
gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
elseif keys.s then
gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
else
gyro.cframe = workspace.CurrentCamera.CoordinateFrame
end
until flying == false
if gyro then gyro:Destroy() end
if pos then pos:Destroy() end
flying=false
localplayer.Character.Humanoid.PlatformStand=false
speed=10
end
e1=mouse.KeyDown:connect(function(key)
if not torso or not torso.Parent then flying=true e1:disconnect() e2:disconnect() return end
if key=="w" then
keys.w=true
elseif key=="s" then
keys.s=true
elseif key=="a" then
keys.a=true
elseif key=="d" then
keys.d=true
end
end)
e2=mouse.KeyUp:connect(function(key)
if key=="w" then
keys.w=false
elseif key=="s" then
keys.s=false
elseif key=="a" then
keys.a=false
elseif key=="d" then
keys.d=false
end
end)
start()
else
flying = false
end
end)

sector1:AddButton("Reset",function()
game.Players.LocalPlayer.Character["Humanoid"]:Destroy()
end)

sector1:AddButton("Rejoin",function()
game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId,game.JobId,game:GetService"Players".LocalPlayer)
end)

            sector1:AddButton("Join Discord",function()
    setclipboard("https://discord.gg/4KVsXpGjHn")
end)

sector2:AddLabel("Must Equip Sword")
Gods = true 

sector2:AddToggle("AutoEquipSword",false,function(ty)
    Toggles.AutoEquipSword = ty
end)
spawn(function()
    while wait (2) do
        pcall(function()
            if Toggles.AutoEquipSword == true then
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
if v.ClassName == "Tool" and v:FindFirstChild("attackKatanaScript") then
  game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)                            
end end end end) end end)

firsttime = true 



sector2:AddToggle('AutoSwing',false,function(t)
	Toggles.AutoSwing = t 
end) 

spawn(function()
while wait (0.1) do
    pcall(function()
        if Toggles.AutoSwing == true then
local args = {
    [1] = "swingKatana"
}
game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(unpack(args))
end end) end end)

firstime = true

sector2:AddToggle("AutoSell",false,function(e)
    Toggles.AutoSell = e
  end)
  spawn(function()
  while wait (0.8) do
      pcall(function()
          if Toggles.AutoSell == true then
  for _,v in pairs(game:GetService("Workspace").sellAreaCircles.sellAreaCircle16:GetDescendants()) do
  if v:IsA("TouchTransmitter") then
  firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0) 
  wait()
  firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1) 
  end end end end) end end)
sup = true

sector5:AddToggle("AutoBuySwords",false,function(a)
Toggles.AutoBuySwords = a
end)

spawn(function()
while wait (1) do
    pcall(function()
        if Toggles.AutoBuySwords == true then
wait(0.6)

local bacon = "buyAllSwords"
local lord = {"Ground", "Astral Island", "Space Island", "Tundra Island", "Eternal Island", "Sandstorm", "Thunderstorm Island", "Ancient Inferno Island", "Midnight Shadow Island", "Mythical Souls Island", "Winter Wonder Island", "Golden Master Island", "Dragon Legend Island", "Cybernetic Legends Island", "Skystorm Ultraus Island", "Chaos Legends Island", "Soul Fusion Island", "Dark Elements Island", "Inner Peace Island"}
for i = 1, #lord do
    game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(bacon, lord[i])
end end end) end end)


hey = true


sector5:AddToggle("AutoBuyBelts",false,function(q)
Toggles.AutoBuyBelts = q
end)

spawn(function()
while wait (1) do
pcall(function()
    if Toggles.AutoBuyBelts == true then
wait(0.5)

local gay = "buyAllBelts"
local gay2 = {"Ground", "Astral Island", "Space Island", "Tundra Island", "Eternal Island", "Sandstorm", "Thunderstorm Island", "Ancient Inferno Island", "Midnight Shadow Island", "Mythical Souls Island", "Winter Wonder Island", "Golden Master Island", "Dragon Legend Island", "Cybernetic Legends Island", "Skystorm Ultraus Island", "Chaos Legends Island", "Soul Fusion Island", "Dark Elements Island", "Inner Peace Island"}
for i = 1, #gay2 do
    game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(gay, gay2[i])
end
end end) end end)



yourmom = true

sector5:AddToggle("AutoRanks",false,function(v)
Toggles.AutoRanks = v
end)

spawn(function()
while wait (1) do
pcall(function()
    if Toggles.AutoRanks == true then
wait(1.1)

local dum = "buyRank"
local dum2 = {"Rookie", "Grasshopper", "Apprentice", "Samurai", "Assassin", "Shadow", "Ninja", "Master Ninja", "Sensei", "Master Sensei", "Ninja Legend", "Master Of Shadows", "Immortal Assassin", "Eternity Hunter", "Shadow Legend", "Dragon Warrior", "Dragon Master", "Chaos Sensei", "Chaos Legend", "Master Of Elements"
    , "Elemental Legend", "Ancient Battle Master", "Ancient Battle Legend", "Legendary Shadow Duelist", "Master Legend Assassin", "Mythic Shadowmaster", "Legendary Shadowmaster", "Awakened Scythemaster", "Awakened Scythe Legend", "Master Legend Zephyr", "Golden Sun Shuriken Master", "Golden Sun Shuriken Legend", "Dark Sun Samurai Legend", "Dragon Evolution Form I", "Dragon Evolution Form II", "Dragon Evolution Form III", "Dragon Evolution Form IV",
 "Dragon Evolution Form V", "Cybernetic Electro Master", "Cybernetic Electro Legend", "Shadow Chaos Assassin", "Shadow Chaos Legend", "Infinity Sensei", "Infinity Legend", "Aether Genesis Master Ninja", "Master Legend Sensei Hunter", "Skystorm Series Samurai Legend", "Master Elemental Hero", "Eclipse Series Soul Master",
 "Starstrike Master Sensei", "Evolved Series Master Ninja", "Dark Elements Guardian", "Elite Series Master Legend", "Infinity Shadows Master", "Lightning Storm Sensei", "Dark Elements Blademaster", "Rising Shadow Eternal Ninja", "Skyblade Ninja Master", "Shadow Storm Sensei", }

for i = 1, #dum2 do
game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(dum, dum2[i])
end end end) end end)




Allah = true

sector5:AddToggle("AutoSkills",false,function(k)
Toggles.AutoSkills = k
end)
spawn(function()
while wait (1) do
    pcall(function()
        if Toggles.AutoSkills == true then
if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
local oh1 = "buyAllSkills"
local oh2 = {"Ground", "Astral Island", "Space Island", "Tundra Island", "Eternal Island", "Sandstorm", "Thunderstorm Island", "Ancient Inferno Island", "Midnight Shadow Island", "Mythical Souls Island", "Winter Wonder Island", "Golden Master Island", "Dragon Legend Island", "Cybernetic Legends Island", "Skystorm Ultraus Island", "Chaos Legends Island", "Soul Fusion Island", "Dark Elements Island", "Inner Peace Island"}
for i = 1,#oh2 do
game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(oh1, oh2[i])
end end end end) end end)



Allahme = true

sector5:AddToggle("AutoShuriken",false,function(b)
Toggles.AutoShuriken = b
end)
spawn(function()
while wait(0.5) do
    pcall(function()
        if Toggles.AutoShuriken ==  true then
if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
local oh1 = "buyAllShurikens"
local oh2 = {"Ground", "Astral Island", "Space Island", "Tundra Island", "Eternal Island", "Sandstorm", "Thunderstorm Island", "Ancient Inferno Island", "Midnight Shadow Island", "Mythical Souls Island", "Winter Wonder Island", "Golden Master Island", "Dragon Legend Island", "Cybernetic Legends Island", "Skystorm Ultraus Island", "Chaos Legends Island", "Soul Fusion Island", "Dark Elements Island", "Inner Peace Island"}
for i = 1,#oh2 do
game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(oh1, oh2[i])
end end end end) end end)







pro = true


sector4:AddToggle("AutoChi",false,function(o)
Toggles.AutoChi = o
end)

spawn(function()
while wait () do
    pcall(function()
        if Toggles.AutoChi == true then
for i,v in pairs(game.Workspace.spawnedCoins.Valley:GetChildren()) do
if v.Name == "Blue Chi Crate" then 
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
wait(.17)
end end end end) end end)


daddye = true

sector4:AddToggle("AutoCoin",false,function(fa)
Toggles.AutoCoin = fa
end)

spawn(function()
while wait () do
    pcall(function()
        if Toggles.AutoCoin == true then
for i,v in pairs(game.Workspace.spawnedCoins.Valley:GetChildren()) do
if v.Name == "Pink Coin" then 
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
wait(.17)
end end end end) end end)

dance = true

sector3:AddToggle("FarmRobotBoss",false,function(u)
    Toggles.FarmRobotBoss = u
end)

spawn(function()
while wait () do
    pcall(function()
        if Toggles.FarmRobotBoss == true then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.bossFolder.RobotBoss.HumanoidRootPart.CFrame
local args = {
    [1] = "swingKatana"
}
game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(unpack(args))
end end) end end)






mum = true

sector3:AddToggle("FarmEthernalBoss",false,function(k)
    Toggles.FarmEthernalBoss = k
end)

spawn(function()
while wait () do
    pcall(function()
        if Toggles.FarmEthernalBoss == true then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.bossFolder.EternalBoss.HumanoidRootPart.CFrame
local args = {
    [1] = "swingKatana"
}
game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(unpack(args))
end end) end end)



wow = true

sector3:AddToggle("FarmAncientMagmaBoss",false,function(j)
    Toggles.FarmAncientMagmaBoss = j
end)

spawn(function()
while wait () do
    pcall(function()
        if Toggles.FarmAncientMagmaBoss == true then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.bossFolder.AncientMagmaBoss.HumanoidRootPart.CFrame
local args = {
    [1] = "swingKatana"
}
game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(unpack(args))
end end) end end)





nuts = true

sector13:AddToggle("Invisible",false,function(r)
Toggles.Invisible = r
end)

spawn(function()
    while wait (1.2) do
        pcall(function()
            if Toggles.Invisible == true then
local args = {
    [1] = "goInvisible"
}

game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(unpack(args))
end end) end end)




Jesus = true


sector13:AddToggle("FastSheriken",false,function(i)
    Toggles.FastSheriken = i 
end)
spawn(function() 
while wait(.001) do 
    pcall(function()
        if Toggles.FastSheriken == true then
if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
local plr = game.Players.LocalPlayer
local Mouse = plr:GetMouse()
local velocity = 1000
for _,p in pairs(game.Workspace.shurikensFolder:GetChildren()) do
if p.Name == "Handle" then
if p:FindFirstChild("BodyVelocity") then
local bv = p:FindFirstChildOfClass("BodyVelocity")
bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
bv.Velocity = Mouse.Hit.lookVector * velocity
end end end end end end) end end)











sector6:AddButton("Get All Elements",function()
game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Masterful Wrath")
game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Frost")
game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Electral Chaos")
game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Lightning")
game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Inferno")
game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Shadow Charge")
game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Shadowfire")
game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Eternity Storm")
end)



sector13:AddButton("Unlock All Islands",function()
for _,v in pairs(game:GetService("Workspace").islandUnlockParts:GetDescendants()) do
if v:IsA("TouchTransmitter") then
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0) --0 is touch
wait()
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1) -- 1 is untouch
end end end)





sector13:AddButton("Collect Chests",function()
local omg = {"Magma Chest", "Enchanted Chest", "Golden Chest", "Mythical Chest", "Legends Chest",
    "Daily Chest", "Eternal Chest", "Sahara Chest", "Thunder Chest",
    "Ancient Chest", "Midnight Shadow Chest", "Wonder Chest", "Golden Zen Chest", "Ultra Ninjitsu Chest",
    "Skystorm Masters Chest", "Chaos Legends Chest", "Soul Fusion Chest",}
for i = 1, #omg do
    wait(1)
    game:GetService("ReplicatedStorage").rEvents.checkChestRemote:InvokeServer(omg[i])
end
end)

Dang = true

sector8:AddToggle("AutoEvolve",false,function(f)
Toggles.AutoEvolve = f
end)
spawn(function()
while wait(3) do
pcall(function()
    if Toggles.AutoEvolve == true then
if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
for i,v in pairs(game:GetService("Players").LocalPlayer.petsFolder:GetChildren()) do
for i,x in pairs(v:GetChildren()) do
local oh1 = "evolvePet"
local oh2 = x.Name
game:GetService("ReplicatedStorage").rEvents.petEvolveEvent:FireServer(oh1, oh2)
end end end end end) end end)


Fuck = true

sector8:AddToggle("AutoEteranlize",false,function(te)
  Toggles.AutoEternalize = te
end)
    spawn(function()
        while wait(3) do
        pcall(function()
            if Toggles.AutoEternalize == true then
        if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
        for i,v in pairs(game:GetService("Players").LocalPlayer.petsFolder:GetChildren()) do
        for i,x in pairs(v:GetChildren()) do
        local oh1 = "eternalizePet"
        local oh2 = x.Name
        game:GetService("ReplicatedStorage").rEvents.petEternalizeEvent:FireServer(oh1, oh2)
        end end end end end) end end)


FuckU = true

sector8:AddToggle("AutoImortalize",false,function (qd)
Toggles.AutoImortalize = qd
end)
spawn(function()
    while wait(3) do
    pcall(function()
  if Toggles.AutoImortalize == true then
    if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
    for i,v in pairs(game:GetService("Players").LocalPlayer.petsFolder:GetChildren()) do
    for i,x in pairs(v:GetChildren()) do
    local oh1 = "immortalizePet"
    local oh2 = x.Name
    game:GetService("ReplicatedStorage").rEvents.petImmortalizeEvent:FireServer(oh1, oh2)
    end end end end end) end end)


Ass = true

sector8:AddToggle("AutoLegend",false,function(iu)
    Toggles.AutoLegend = iu
    end)
    spawn(function()
        while wait(1) do
            pcall(function()
    if Toggles.AutoLegend == true then
        if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
        for i,v in pairs(game:GetService("Players").LocalPlayer.petsFolder:GetChildren()) do
        for i,x in pairs(v:GetChildren()) do
        local oh1 = "legendizePet"
        local oh2 = x.Name
        game:GetService("ReplicatedStorage").rEvents.petLegendEvent:FireServer(oh1, oh2)
        end end end end end) end end)
     


butt = true

sector8:AddToggle("AutoElementalize",false,function(qc)
   Toggles.AutoElementalize = qc
end)
    spawn(function()
    while wait(1) do
        pcall(function()
if Toggles.AutoElementalize == true then
    if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
    for i,v in pairs(game:GetService("Players").LocalPlayer.petsFolder:GetChildren()) do
    for i,x in pairs(v:GetChildren()) do
    local oh1 = "elementalizePet"
    local oh2 = x.Name
    game:GetService("ReplicatedStorage").rEvents.petLegendEvent:FireServer(oh1, oh2)
    end end end end end) end end)
     


sector7:AddDropdown('Select Location',{"Blue Crystal";" Enchanted Crystal"; "Astral Crystal"; "Golden Crystal"; "Inferno Crystal"; "Space Crystal"; "Eternal Crystal"; "Thunder Crystal"; "Secret Blades Crystal",},"Crystal",false,function(name)
   local args = {
    [1] = "openCrystal",
    [2] = name
}
game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer(unpack(args))
end)



big = true 

sector9:AddToggle("SellBasics",false,function(fg)
Toggles.SellBasics = fg
end)
spawn(function() 
    while wait(1) do 
    pcall(function()
        if Toggles.SellBasics == true then
    if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
    for i,v in pairs(game.Players.LocalPlayer.petsFolder.Basic:GetChildren()) do
    game.ReplicatedStorage.rEvents.sellPetEvent:FireServer("sellPet", v)
    end end end end) end end)


 bigd = true   

sector9:AddToggle("SellAdvanced",false,function(gf)
Toggles.SellAdvanced = gf
end)
spawn(function() 
    while wait(1) do 
 pcall(function()
    if Toggles.SellAdvanced == true then
    if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
    for i,v in pairs(game.Players.LocalPlayer.petsFolder.Advanced:GetChildren()) do
    game.ReplicatedStorage.rEvents.sellPetEvent:FireServer("sellPet", v)
    end end end end) end end)




  bigg = true 


  sector9:AddToggle("SellRares",false,function(hj)
    Toggles.SellRares = hj
  end) 
  spawn(function() 
    while wait(1) do 
    pcall(function()
        if Toggles.SellRares == true then
    if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
    for i,v in pairs(game.Players.LocalPlayer.petsFolder.Rare:GetChildren()) do
    game.ReplicatedStorage.rEvents.sellPetEvent:FireServer("sellPet", v)
    end end end end) end end)



    bige = true 


sector9:AddToggle("SellEpics",false,function(aa)
        Toggles.SellEpics = aa
      end) 
      spawn(function() 
        while wait(1) do
            pcall(function()
                if Toggles.SellEpics == true then 
        if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
        for i,v in pairs(game.Players.LocalPlayer.petsFolder.Epic:GetChildren()) do
        game.ReplicatedStorage.rEvents.sellPetEvent:FireServer("sellPet", v)
        end end end end) end end)

bong = true 
sector9:AddToggle("SellUniques",false,function(aae)
    Toggles.SellEpics = aae
  end) 
  spawn(function() 
    while wait(1) do   
        pcall(function()
    if Toggles.SellUniques == true then
    if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
    for i,v in pairs(game.Players.LocalPlayer.petsFolder.Unique:GetChildren()) do
    game.ReplicatedStorage.rEvents.sellPetEvent:FireServer("sellPet", v)
    end end end end) end end)

weed = true 
sector9:AddToggle("SellOmegas",false,function(aaed)
    Toggles.SellEpics = aaed
  end) 
  spawn(function() 
    while wait(1) do 
    pcall(function()
        if Toggles.Omegas == true then
                if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
                for i,v in pairs(game.Players.LocalPlayer.petsFolder.Omega:GetChildren()) do
                game.ReplicatedStorage.rEvents.sellPetEvent:FireServer("sellPet", v)
    end end end end) end end)

    coc = true 
    sector9:AddToggle("SellElites",false,function(aaedd)
        Toggles.SellElites = aaedd
      end) 
      spawn(function() 
        while wait(1) do 
       pcall(function()
        if Toggles.SellElites == true then
        if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
        for i,v in pairs(game.Players.LocalPlayer.petsFolder.Elite:GetChildren()) do
        game.ReplicatedStorage.rEvents.sellPetEvent:FireServer("sellPet", v)
        end end end end) end end)

        coca = true 
     sector9:AddToggle("SellInfinitys",false,function(aaeddd)
            Toggles.SellInfinitys = aaeddd
          end) 
          spawn(function() 
            while wait(1) do 
           pcall(function()
            if Toggles.SellInfinitys == true then
            if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
            for i,v in pairs(game.Players.LocalPlayer.petsFolder.Infinity:GetChildren()) do
            game.ReplicatedStorage.rEvents.sellPetEvent:FireServer("sellPet", v)
            end end end end) end end)

            


sector10:AddLabel("Training Areas")
sector10:AddButton("Mythical Waters",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(344, 8824, 125)
end)

sector10:AddButton("Lava Pit",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-128, 12952, 274)
end)

sector10:AddButton("Toronado",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(320, 16872, -17)
end)

sector10:AddButton("Sword Of Legends",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1831, 38, -140)
end)

sector10:AddButton("Sword Of Ancient",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(613, 38, 2411)
end)

sector10:AddButton("Elemental Toronado",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(323, 30383, -10)
end)

sector10:AddButton("Fallen Infinity Blade",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1859, 38, -6788)
end)

sector10:AddButton("Zen Masters Blade",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5019, 38, 1614)
end)

sector11:AddLabel("Teleport To Alters")
sector11:AddButton("Infinity Stats Dojo",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-4109.91553, 122.94751, -5908.6845)
end)

sector11:AddButton("Altar Of Elements",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(732.294434, 122.947517, -5908.3461)
end)

sector11:AddButton("Pet Cloning Altar",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4520.91943, 122.947517, 1401.6312)
end)

sector11:AddButton("King Of The Hill",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(227.120529, 89.8075867, -285.06219)
end)

sector11:AddLabel("Teleport to a Player")
sector11:AddTextbox("Player Name", "Player Name", function(Argument3)
function Utils.GetPlayer(PlayerName)
local Player;
local PlayersT = Players:GetPlayers()
for i = 1, #PlayersT do
if string.lower(string.sub(PlayersT[i].Name, 1, string.len(PlayerName))) == string.lower(PlayerName) then
Player = PlayersT[i]
break
end
end
return Player
end
local char=game.Players.LocalPlayer.Character
local Player = Utils.GetPlayer(Argument3)
wait(0.1)
if Player ~= nil and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players:FindFirstChild(Player.Name) and game.Players:FindFirstChild(Player.Name).Character:FindFirstChild("HumanoidRootPart") then
char.HumanoidRootPart.CFrame = CFrame.new(game.Players:FindFirstChild(Player.Name).Character:FindFirstChild("HumanoidRootPart").Position)
end
end)




sector12:AddLabel("Islands")
sector12:AddButton("Soul Fusion Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(193, 79746, 18)
end)

sector12:AddButton("Chaos Legends Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(119, 74442, 52)
end)

sector12:AddButton("Skystorm Ultraus Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(197, 70270, 8)
end)

sector12:AddButton("Cybernetic Legends Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(226, 66669, 15)
end)

sector12:AddButton("Thunder Storm Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(108, 24069, 84)
end)

sector12:AddButton("Eternal Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(139, 13680, 74)
end)

sector12:AddButton("Ancient Inferno Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(171, 28255, 39)
end)

sector12:AddButton("Sand Storm Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135, 17686, 61)
end)

sector12:AddButton("Tundra Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(189, 9284, 31)
end)

sector12:AddButton("Space Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(186, 5656, 76)
end)

sector12:AddButton("Mythical Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(165, 4047, 51)
end)

sector12:AddButton("Astral Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(233, 2013, 331)
end)

sector12:AddButton("Midnight Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(180, 33206, 28)
end)

sector12:AddButton("Golden Master Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(166, 52607, 34)
end)

sector12:AddButton("Dragon Legend Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(188, 59594, 24)
end)

sector12:AddButton("Winter Wonder Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(183, 46010, 36)
end)

sector12:AddButton("Mythical Souls Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-128, 39439, 173)
end)

sector12:AddButton("Enchanted Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(80, 766, -188)
end)

sector12:AddButton("Inner Peace Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(141.202896, 87050.8438, 66.417511, 0.870402813, 1.82041191e-08, 0.492340267, 2.57000714e-08, 1, -8.24095352e-08, -0.492340267, 8.43826768e-08, 0.870402813)
end)

sector12:AddButton("Dark Elements Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(140.101013, 83198.7578, 65.9104843, 0.953749359, -9.02977746e-08, 0.300603032, 7.0098622e-08, 1, 7.79807863e-08, -0.300603032, -5.33022657e-08, 0.953749359)
end)















local vu = game:GetService("VirtualUser")---------------------ANTI AFK
game:GetService("Players").LocalPlayer.Idled:connect(function()
  vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
  wait(1)
  vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)


firstime = false
firsttime = false
first = false
sup = false
hey = false
yourmum = false
pro = false
nuts = false
dance = false
mum = false
wow = false
Allah = false
Allahme = false
Jesus = false
Dang = false
Fuck = false
FuckU = false
Ass = false
butt = false
big = false
bigd = false
bige = false
bong = false 
weed = false
coc = false
coca = false
Gods = false
daddye = false
end 
if game.PlaceId == 155615604 then
        


local Toggles = {
	KillAura = false,
	ArrestAura = false

}


lib=loadstring(game:HttpGet"https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/UILibrary.lua")()
local win = lib:CreateWindow("Bacon hub | Prison Life", Vector2.new(492, 598), Enum.KeyCode.RightShift)
local tab2 = win:CreateTab('Main')
local tab4 = win:CreateTab("Teleports")
local tab3 = win:CreateTab("Misc")
local sector1 = tab3:CreateSector("Universal","left")
local sector2 = tab2:CreateSector("Combats","left")
local sector3 = tab2:CreateSector("Guns","right")
local sector4 = tab3:CreateSector("Other","right")
local sector5 = tab4:CreateSector("Teleports","left")
local sector6 = tab3:CreateSector("Team Change","right ")
local Utils = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
noclip = false
firsttime = true 


sector1:AddSlider("Walkspeed",16,16,300,1,function(a)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = a
end)

sector1:AddSlider("Jumppower",50,50,500,1,function(a)
game.Players.LocalPlayer.Character.Humanoid.JumpPower = a
end)

sector1:AddKeybind("No Clip", Enum.KeyCode.R, function(newkey) 
        print(newkey)
    end, function()
    if noclip == false then
    noclip = false
    game:GetService('RunService').Stepped:connect(function()
    if noclip then
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
    end
    end)
    plr = game.Players.LocalPlayer
    mouse = plr:GetMouse()
    noclip = not noclip
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
    else
    noclip = false
    end
    end)

sector1:AddButton("Reset",function()
game.Players.LocalPlayer.Character["Humanoid"]:Destroy()
end)

sector1:AddButton("Rejoin",function()
game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId,game.JobId,game:GetService"Players".LocalPlayer)
end)

sector1:AddLabel("Teleport to a Player")
sector1:AddTextbox("Player Name", "Player Name", function(Argument3)
function Utils.GetPlayer(PlayerName)
local Player;
local PlayersT = Players:GetPlayers()
for i = 1, #PlayersT do
if string.lower(string.sub(PlayersT[i].Name, 1, string.len(PlayerName))) == string.lower(PlayerName) then
Player = PlayersT[i]
break
end
end
return Player
end
local char=game.Players.LocalPlayer.Character
local Player = Utils.GetPlayer(Argument3)
wait(0.1)
if Player ~= nil and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players:FindFirstChild(Player.Name) and game.Players:FindFirstChild(Player.Name).Character:FindFirstChild("HumanoidRootPart") then
char.HumanoidRootPart.CFrame = CFrame.new(game.Players:FindFirstChild(Player.Name).Character:FindFirstChild("HumanoidRootPart").Position)
end
end)
            sector2:AddButton("Join Discord",function()
    setclipboard("https://discord.gg/4KVsXpGjHn")
end)
sector2:AddButton("Aimbot", function()
local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local GetPlayers = Players.GetPlayers
local Camera = workspace.CurrentCamera
local WTSP = Camera.WorldToScreenPoint
local FindFirstChild = game.FindFirstChild
local Vector2_new = Vector2.new
local Mouse = LocalPlayer.GetMouse(LocalPlayer)
local function ClosestChar()
    local Max, Close = math.huge
    for I,V in pairs(GetPlayers(Players)) do
        if V ~= LocalPlayer and V.Team ~= LocalPlayer.Team and V.Character then
            local Head = FindFirstChild(V.Character, "Head")
            if Head then
                local Pos, OnScreen = WTSP(Camera, Head.Position)
                if OnScreen then
                    local Dist = (Vector2_new(Pos.X, Pos.Y) - Vector2_new(Mouse.X, Mouse.Y)).Magnitude
                    if Dist < Max then
                        Max = Dist
                        Close = V.Character
                    end
                end
            end
        end
    end
    return Close
end

local MT = getrawmetatable(game)
local __namecall = MT.__namecall
setreadonly(MT, false)
MT.__namecall = newcclosure(function(self, ...)
    local Method = getnamecallmethod()
    if Method == "FindPartOnRay" and not checkcaller() and tostring(getfenv(0).script) == "GunInterface" then
        local Character = ClosestChar()
        if Character then
            return Character.Head, Character.Head.Position
        end
    end

    return __namecall(self, ...)
end)
setreadonly(MT, true)

end)
sector2:AddToggle("InstantRespawn",false,function(a)
    Toggles.InstantRespawn = a 
end)
spawn(function()
    while task.wait() do 
        pcall(function()
            if Toggles.InstantRespawn == true then 
                 if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then 
   local A_1 = "\66\114\111\121\111\117\98\97\100\100"
                local Event = game:GetService("Workspace").Remote.loadchar
                Event:InvokeServer(A_1)
end end end) end end)

sector2:AddToggle("KillAura",false,function(e)
Toggles.KillAura = e
end)
    spawn(function()
            while wait(0.02) do
                pcall(function()
                    if Toggles.KillAura == true then
                    for i, v in pairs(game.Players:GetChildren()) do
                        if v ~= game.Players.LocalPlayer then
                            local meleeEvent = game:GetService("ReplicatedStorage").meleeEvent
                            meleeEvent:FireServer(
                                v
                            )
                        end end end end) 
                end
    end) 
        
        sector2:AddToggle("ArrestAura",false,function(e)
                    Toggles.ArrestAura = e
                    end)
                    spawn(function()
            while wait() do
                pcall(function()
                    if Toggles.ArrestAura == true then
                    for i, v in pairs(game.Players:GetChildren()) do
                        if v ~= Player then
                                local arrest = workspace.Remote.arrest
                                arrest:InvokeServer(
                                    v.Character.HumanoidRootPart
                                )
                        end end end end) end end)
                        
sector2:AddButton("Arrest Criminals",function()
        local Player = game.Players.LocalPlayer
        local cpos = Player.Character.HumanoidRootPart.CFrame
        for i,v in pairs(game.Teams.Criminals:GetPlayers()) do
            if v.Name ~= Player.Name then
                local i = 10
                repeat
                wait(0.5)
                i = i-1
                game.Workspace.Remote.arrest:InvokeServer(v.Character.HumanoidRootPart)
                Player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
            until i == 0
            end
        end
    Player.Character.HumanoidRootPart.CFrame = cpos
end)

sector2:AddToggle("KillAll",false,function(a)
    Toggles.KillAll = a 
end)
spawn(function()
     while task.wait(0.3) do 
         pcall(function()
             if Toggles.KillAll == true then 
        local Player = game.Players.LocalPlayer
        local cpos = Player.Character.HumanoidRootPart.CFrame
        for i,v in pairs(game.Players:GetPlayers()) do
            if v.Name ~= Player.Name then
                local i = 6
                repeat
                wait(0.3)
                i = i-1
                     for i, v in pairs(game.Players:GetChildren()) do
                        if v ~= game.Players.LocalPlayer then
                            local meleeEvent = game:GetService("ReplicatedStorage").meleeEvent
                            meleeEvent:FireServer(
                                v
                            )
                        end end 
                Player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
            until i == 0 or game.Players[v.Name].Character.Humanoid.Health == 0 
            end
        end
    Player.Character.HumanoidRootPart.CFrame = cpos
end  end) end end)

sector3:AddButton("Get Shotgun",function()
    local args = {
    [1] = workspace.Prison_ITEMS.giver:FindFirstChild("Remington 870").ITEMPICKUP
}

workspace.Remote.ItemHandler:InvokeServer(unpack(args))
end)

sector3:AddButton("Get AK47",function()
            local ItemHandler = workspace.Remote.ItemHandler
            ItemHandler:InvokeServer(
                workspace.Prison_ITEMS.giver["AK-47"].ITEMPICKUP
            )
        end)
sector3:AddButton("Get Hammer",function()
         game.workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.single.Hammer.ITEMPICKUP)
    end)

sector3:AddButton("Get Knife",function()
       game.workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.single["Crude Knife"].ITEMPICKUP)
    end)

sector3:AddButton("Get M9",function()
           game.workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver.M9.ITEMPICKUP)
end)

sector4:AddButton("Destroy All Doors",function()
           game:GetService("Workspace").Doors:Destroy()
    end)

sector4:AddButton("Escape",function()
   game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(497.262573, 198.039948, 2212.94336)
end)

    sector5:AddButton("Tp To Car",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Workspace").CarContainer.Sedan.Body.Seat.Position)
    end)
    
    sector5:AddButton("TP to Criminal Base", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-920.510803, 92.2271957, 2138.27002, 0, 0, -1, 0, 1, 0, 1, 0, 0)
    end)

    sector5:AddButton("TP to CourtYard", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(798.999756, 95.1383057, 2540.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    end)

    sector5:AddButton('TP to Cafeteria', function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(875.049805, 96.9333496, 2271.5498, 0, 0, -1, 0, 1, 0, 1, 0, 0)
    end)

    sector5:AddButton('TP to Prison', function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(590.699524, 98.0399399, 2269.83911)
    end)

    sector5:AddButton('TP to Sewers', function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(917.092468, 78.6991119, 2437.32397)
    end)

    sector5:AddButton('TP to Prison Cells', function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(917.500366, 99.9899902, 2458.89307)
    end)

    sector5:AddButton('TP to Prison Roof', function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(820.341248, 118.990005, 2378.33838)
    end)

    sector5:AddButton('TP to Police Base', function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(835.926208, 99.9900055, 2267.71191)
    end)

    sector5:AddButton('TP to Gate Button', function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(504.488312, 102.039917, 2242.48389)
    end)

    sector5:AddButton('TP to Neutral Spawn', function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(879.38031, 27.7899876, 2349.28955)
    end)

sector6:AddButton("Become Guard",function()
    game.workspace.Remote.TeamEvent:FireServer("Bright blue")
end)

sector6:AddButton("Become Inmate",function()
     game.workspace.Remote.TeamEvent:FireServer("Bright orange")
end)

sector6:AddButton("Become Neutral",function()
     Workspace.Remote.TeamEvent:FireServer("Medium stone grey")
end)

sector6:AddButton("Become Criminal",function()
          local location = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-920.510803, 92.2271957, 2138.27002, 0, 0, -1, 0, 1, 0, 1, 0, 0)
        wait(0.1)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(location)
    end)

firsttime = false
end  

if game.PlaceId == 318978013 then 
    
   local Toggles = {
    AutoGoal = false,
    AutoBringBall = false,
    BreakBall = false
}
lib=loadstring(game:HttpGet"https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/UILibrary.lua")()
local win = lib:CreateWindow("Bacon Hub | Kick Off", Vector2.new(492, 598), Enum.KeyCode.RightShift)


local tab1 = win:CreateTab("Universal")
local tab2 = win:CreateTab("AutoFarm")
local sector5 = tab1:CreateSector("ESP","right")
local sector1 = tab1:CreateSector("Universal","left")
local sector2 = tab2:CreateSector("Main","left")

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/ESP%20lib.lua"))()
ESP:Toggle(true)

ESP.Tracers = false
ESP.Names = false
ESP.Boxes = false

sector5:AddToggle("Boxes",false,function(t)
    ESP.Boxes =t 
end)

sector5:AddToggle("Nametags",false,function(t)
    ESP.Names =t 
end)

sector5:AddToggle("Tracers",false,function(t)
    ESP.Tracers =t 
end)
sector1:AddSlider("Walkspeed",16,16,300,1,function(a)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = a
    end)
    
    sector1:AddSlider("Jumppower",50,50,500,1,function(a)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = a
    end)
    
    sector1:AddKeybind("No Clip", Enum.KeyCode.R, function(newkey) 
        print(newkey)
    end, function()
    if noclip == false then
    noclip = false
    game:GetService('RunService').Stepped:connect(function()
    if noclip then
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
    end
    end)
    plr = game.Players.LocalPlayer
    mouse = plr:GetMouse()
    noclip = not noclip
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
    else
    noclip = false
    end
    end)
    
    sector1:AddKeybind("Fly", Enum.KeyCode.F, function(newkey) 
        print(newkey)
    end, function()
    if flying == false then 
    local plr = game.Players.LocalPlayer
    local mouse = plr:GetMouse()
    localplayer = plr
    if workspace:FindFirstChild("Core") then
    workspace.Core:Destroy()
    end
    local Core = Instance.new("Part")
    Core.Name = "Core"
    Core.Size = Vector3.new(0.05, 0.05, 0.05)
    spawn(function()
    Core.Parent = workspace
    local Weld = Instance.new("Weld", Core)
    Weld.Part0 = Core
    Weld.Part1 = localplayer.Character.LowerTorso
    Weld.C0 = CFrame.new(0, 0, 0)
    end)
    workspace:WaitForChild("Core")
    local torso = workspace.Core
    flying = true
    local speed=10 
    local keys={a=false,d=false,w=false,s=false}
    local e1
    local e2
    local function start()
    local pos = Instance.new("BodyPosition",torso)
    local gyro = Instance.new("BodyGyro",torso)
    pos.Name="EPIXPOS"
    pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
    pos.position = torso.Position
    gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    gyro.cframe = torso.CFrame
    repeat
    wait()
    localplayer.Character.Humanoid.PlatformStand=true
    local new=gyro.cframe - gyro.cframe.p + pos.position
    if not keys.w and not keys.s and not keys.a and not keys.d then
    speed=5
    end
    if keys.w then
    new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
    speed=speed+0
    end
    if keys.s then
    new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
    speed=speed+0
    end
    if keys.d then
    new = new * CFrame.new(speed,0,0)
    speed=speed+0
    end
    if keys.a then
    new = new * CFrame.new(-speed,0,0)
    speed=speed+0
    end
    if speed>10 then
    speed=5
    end
    pos.position=new.p
    if keys.w then
    gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
    elseif keys.s then
    gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
    else
    gyro.cframe = workspace.CurrentCamera.CoordinateFrame
    end
    until flying == false
    if gyro then gyro:Destroy() end
    if pos then pos:Destroy() end
    flying=false
    localplayer.Character.Humanoid.PlatformStand=false
    speed=10
    end
    e1=mouse.KeyDown:connect(function(key)
    if not torso or not torso.Parent then flying=true e1:disconnect() e2:disconnect() return end
    if key=="w" then
    keys.w=true
    elseif key=="s" then
    keys.s=true
    elseif key=="a" then
    keys.a=true
    elseif key=="d" then
    keys.d=true
    end
    end)
    e2=mouse.KeyUp:connect(function(key)
    if key=="w" then
    keys.w=false
    elseif key=="s" then
    keys.s=false
    elseif key=="a" then
    keys.a=false
    elseif key=="d" then
    keys.d=false
    end
    end)
    start()
    else
    flying = false
    end
    end)
    
    sector1:AddButton("Reset",function()
    game.Players.LocalPlayer.Character["Humanoid"]:Destroy()
    end)
    
    sector1:AddButton("Rejoin",function()
    game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId,game.JobId,game:GetService"Players".LocalPlayer)
    end)
    

    sector2:AddToggle("AutoGoal",false,function(Bacon)
Toggles.AutoGoal = Bacon 
end)
local virtualUser = game:GetService('VirtualUser')
virtualUser:CaptureController()
spawn(function()
while task.wait() do 
    pcall(function()
        if Toggles.AutoGoal == true then
if game.Players.LocalPlayer.Team.Name == "Brazil" then 
virtualUser:SetKeyDown('0x77')
wait(0.001)
virtualUser:SetKeyUp('0x77')
wait(0.001)
virtualUser:SetKeyDown('0x73')
wait(0.001)
virtualUser:SetKeyUp('0x73')
for i,v in pairs(game:GetService("Workspace").MapHolder:GetDescendants()) do
  if v:IsA("Part") and v.Name == "BlueGoal" then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
  end end



 for _,v in pairs(game.Workspace.SoccerBall:GetChildren()) do
    if v:IsA("TouchTransmitter") then 
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)    wait(0.1)
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
    end end end 
    

if game.Players.LocalPlayer.Team.Name == "USA" then 
virtualUser:SetKeyDown('0x77')
wait(0.001)
virtualUser:SetKeyUp('0x77')
wait(0.001)
virtualUser:SetKeyDown('0x73')
wait(0.001)
virtualUser:SetKeyUp('0x73')
   for i,v in pairs(game:GetService("Workspace").MapHolder:GetDescendants()) do
  if v:IsA("Part") and v.Name == "RedGoal" then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
  end end
  


     for _,v in pairs(game.Workspace.SoccerBall:GetChildren()) do
    if v:IsA("TouchTransmitter") then 
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)    wait(0.1)
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
    end end end end end) end end)
    
 sector2:AddToggle("AutoBringBall",false,function(Bacon)
Toggles.AutoBringBall = Bacon 
end)
spawn(function()
    while task.wait() do 
        pcall(function()
            if Toggles.AutoBringBall == true then 
     for _,v in pairs(game.Workspace.SoccerBall:GetChildren()) do
    if v:IsA("TouchTransmitter") then 
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)    wait(0.1)
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
end end end end) end end)

 sector2:AddToggle("BreakBall",false,function(Bacon)
Toggles.BreakBall = Bacon 
end)
spawn(function()
    while task.wait(0.4) do 
        pcall(function()
            if Toggles.BreakBall== true then 
    -- Script generated by SimpleSpy - credits to exx#9394

local args = {
    [1] = "Kick",
    [2] = "Trickshot",
    [3] = workspace.SoccerBall,
    [4] = 22.629504394531,
    [5] = Vector3.new(45.103404998779, 82.799995422363, -54.574016571045),
    [6] = Vector3.new(149.20053100586, -74.250137329102, -421.7565612793),
    [7] = Vector3.new(181.78007507324, -107.2501373291, -461.1770324707)
}

game:GetService("ReplicatedStorage").MasterKey:FireServer(unpack(args))
end end) end end)
end

if game.PlaceId == 2534724415 then 
    
local Toggles = {
    AutoFarmPayChecks = false
}

lib=loadstring(game:HttpGet"https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/UILibrary.lua")()
local win = lib:CreateWindow("Bacon Hub | ER:LC", Vector2.new(492, 598), Enum.KeyCode.RightShift)


local tab1 = win:CreateTab("Universal")
local tab2 = win:CreateTab("AutoFarm")
local sector5 = tab1:CreateSector("ESP","right")
local sector1 = tab1:CreateSector("Universal","left")
local sector2 = tab2:CreateSector("Main","left")
local sector3 = tab2:CreateSector("Teleports","right")
local sector6 = tab2:CreateSector("Combat","left")
local sector7 = tab2:CreateSector("Buy Weapons","left")
game.StarterGui:SetCore(
    "SendNotification",
    {
        Title = "Credits for help",
        Text = "Bussines Man "
    }
)
PlayerName = {}
for i,v in pairs(game:GetService("Players"):GetChildren()) do
      if v.Team.Name == "Sheriff" or v.Team.Name == "Police" then 
    table.insert(PlayerName ,v.Name)
    end 
end 

function TweenTo(pos)
    local args = {
        [1] = workspace[game.Players.LocalPlayer.Name].Head
    }
    game:GetService("ReplicatedStorage").FE.VehicleExit:FireServer(unpack(args))
    game.Players.LocalPlayer.Character:MoveTo(pos)
end 



local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/ESP%20lib.lua"))()
ESP:Toggle(true)

ESP.Tracers = false
ESP.Names = false
ESP.Boxes = false

sector5:AddToggle("Boxes",false,function(t)
    ESP.Boxes =t 
end)

sector5:AddToggle("Nametags",false,function(t)
    ESP.Names =t 
end)

sector5:AddToggle("Tracers",false,function(t)
    ESP.Tracers =t 
end)

    
    sector1:AddButton("Reset",function()
    game.Players.LocalPlayer.Character["Humanoid"]:Destroy()
    end)
    
    sector1:AddButton("Rejoin",function()
    game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId,game.JobId,game:GetService"Players".LocalPlayer)
    end)
    
    sector2:AddToggle("AutoFarmPayChecks",false,function(a)
        Toggles.AutoFarmPayChecks = a 
    end)
    spawn(function()
        while task.wait(0.1) do 
            pcall(function()
                if Toggles.AutoFarmPayChecks == true then
local args = {
    [1] = BrickColor.new(102),
    [2] = "1231"
}

game:GetService("ReplicatedStorage").FE.TeamChange:FireServer(unpack(args))

TweenTo(Vector3.new(5,30,5),3.2)
wait(0.6)
TweenTo(Vector3.new(100,30,5),3.2)
wait(0.6)
TweenTo(Vector3.new(250,30,20),3.2)
wait(0.6)
TweenTo(Vector3.new(700,30,70),3.2)
wait(0.8)
TweenTo(Vector3.new(1000,30,50),3.2)
wait(0.7)
TweenTo(Vector3.new(-434,27,100),3.2)
wait(0.8)
end end) end end)

sector3:AddButton("To Tool Shop",function()
    TweenTo(Vector3.new(-434.349396, 23.7480431, -714.446899, -0.797502756, -2.84444539e-08, -0.603315294, -5.15843404e-08, 1, 2.10407389e-08, 0.603315294, 4.79016684e-08, -0.797502756),4)
end)

sector3:AddButton("ATM 1 ",function()
    TweenTo(Vector3.new(812.426208, 4.00052261, 377.247864, -0.943853259, 0.330364853, 0, 0.330364853, 0.943853319, 0, 0, 0, -1),6)
end)
sector3:AddButton("ATM 2 ",function()
    TweenTo(Vector3.new(999.859802, 4.00046158, -21.785614, -4.8160553e-05, 8.1807375e-06, 1, 0.330366194, 0.943852842, 8.1807375e-06, -0.943852901, 0.330366194, -4.8160553e-05),6)
end)
sector3:AddButton("ATM 3 ",function()
    TweenTo(Vector3.new(-368.652863, 26.7002048, 152.446075, 0, -1, -0, -1, 0, -0, 0, 0, -1),6)
end)
sector3:AddButton("ATM 4",function()
    TweenTo(Vector3.new(-1018.9718, 26.833231, 447.773254, 0.00190246105, 8.46982002e-05, 0.999998212, -0.999996364, -0.00190234184, 0.00190258026, 0.00190258026, -0.999998212, 8.10623169e-05),6)
end)
sector3:AddButton("Police Station",function()
    TweenTo(Vector3.new(703.846375, 17.5796318, -90.1037598, -0.994518042, 4.51932874e-06, -0.104565002, -4.51932874e-06, 1, 8.6203625e-05, 0.104565002, 8.6203625e-05, -0.994518042),6)
end)
sector3:AddButton("Sheriff Station",function()
    TweenTo(Vector3.new(-780.035645, 23.1856575, -769.959229, 0.819155693, 0, 0.573571265, 0, 1, 0, -0.573571265, 0, 0.819155693),6)
end)
sector3:AddButton("Car Spawn",function()
    TweenTo(Vector3.new(1077.88977, 0.85005188, 166.373444, 1, 0, 0, 0, 1, 0, 0, 0, 1),6)
end)
sector3:AddButton("Fire Station",function()
    TweenTo(Vector3.new(-1046.17786, 20.8771553, 34.9316864, -0.104543328, 0, 0.994520426, 0, 1, 0, -0.994520426, 0, -0.104543328),6)
end)
sector3:AddButton("Hospital",function()
    TweenTo(Vector3.new(-207.100037, 100, -464.049805, 1, 0, 0, 0, 1, 0, 0, 0, 1),6)
end)

sector3:AddButton("Gun Shop",function()
        TweenTo(Vector3.new(-1220.60681, 25.5379372, -186.548431, 1, 0, 0, 0, 1, 0, 0, 0, 1), 3.2)
end)
            sector3:AddButton("Join Discord",function()
    setclipboard("https://discord.gg/4KVsXpGjHn")
end)


sector6:AddLabel("Get Gun In Inv ")
sector6:AddLabel("execute inf ammo")
sector6:AddLabel("Equip gun then unequip gun ")
sector6:AddLabel("then press E")
sector6:AddLabel("Then unequip/requip gun done")
sector6:AddButton("Infinite Ammo", function()
function shared.GetGun() -- don't want upvalue error again wasted 4 hours fixing it 😐
    local Gun = 'error'
    local lPlr = game:GetService("Players").LocalPlayer
    local bkpk = lPlr.Backpack
    for _,x in pairs(bkpk:GetChildren()) do
        if (x:FindFirstChild("Core") ~= nil) then -- for some reason leaving out ' ~= nil' gave me errors
            if (x['Core']:FindFirstChild("Combat") ~= nil) then
                Gun = x.Name
            end
        end
    end
    return Gun
end

local mt = getrawmetatable(game)
setreadonly(mt, false)
local namecall = mt.__namecall

mt.__namecall = function(self,...)
    local args = {...}
    local method = getnamecallmethod()
    if tostring(self) == "UpdateGunData" and tostring(method) == "FireServer" then
        args[1] = shared.GetGun()
        args[2] = 999999
        args[3] = 999999
        return self.FireServer(self, unpack(args))
    end
    return namecall(self,...)
end end) 

_G.stopKilling = false
_G.okyoustop = false


function TpTo(pos)
    local args = {
        [1] = workspace[game.Players.LocalPlayer.Name].Head
    }
    game:GetService("ReplicatedStorage").FE.VehicleExit:FireServer(unpack(args))
    game.Players.LocalPlayer.Character:MoveTo(pos)
end
function TpToCFrame(pos)
    local args = {
        [1] = workspace[game.Players.LocalPlayer.Name].Head
    }
    game:GetService("ReplicatedStorage").FE.VehicleExit:FireServer(unpack(args))
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
end
function FindCar()
    return game.ReplicatedStorage['VehicleOwners'][game.Players.LocalPlayer.Name].Value
end
function TpToCar()
    if (FindCar() ~= nil) then
        game:GetService("ReplicatedStorage").FE.VehicleExit:FireServer(unpack({
            [1] = FindCar().DriverSeat
        }))
    end
end
function GetLocation()
    local char = game.Players.LocalPlayer.Character
    local hrp = char.HumanoidRootPart.Position
    setclipboard(tostring(hrp))
end
function Swing()
    game:GetService("VirtualUser"):ClickButton1(Vector2.new(0.4,0.4))
end
function TpBehind(retard)
    _G.okyoustop = false
    coroutine.resume(coroutine.create(function()
        repeat
            local c = game.Players[retard].Character.HumanoidRootPart
            TpToCFrame(c.CFrame + c.CFrame.LookVector * -1.5)
            wait()
        until _G.okyoustop == true
    end))
    wait(1.05)
    _G.okyoustop = true
end
function SafeSpot()
    TpTo(Vector3.new(-68.44271087646484, 83.25736236572266, -433.7838439941406))
end
function Kill(retard)
    if (game.Players.LocalPlayer.Backpack:FindFirstChild"Knife") then
        game.Players.LocalPlayer.Backpack:FindFirstChild"Knife".Parent = game.Players.LocalPlayer.Character
    end
    repeat
        SafeSpot()
        TpBehind(retard)
        wait(.04)
        Swing()
        wait(0.6)
        SafeSpot()
        wait(0.5)
    until game.Players[retard].Character:FindFirstChildOfClass"Humanoid".Sit == true or IsDriving(game.ReplicatedStorage['VehicleOwners'][retard].Value) or game.Players[retard].Character:FindFirstChild("HumanoidRootPart").Anchored == true or game.Players[retard].Character:FindFirstChildOfClass("Humanoid").Health == 0 
end
function IsDriving(car)
    if (car.DriverSeat:FindFirstChild("Rev")) then
        return true
    else
        return false
    end
end
function StopKilling()
    _G.stopKilling = true
    wait(3)
    _G.stopKilling = false
end
sector6:AddButton("Get Tools",function()
    local function getools() -- Check tools function
    local args = {
        [1] = workspace[game.Players.LocalPlayer.Name].Head
    }
    game:GetService("ReplicatedStorage").FE.VehicleExit:FireServer(unpack(args))
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-431.529846, 25.4500179, -706.822632, -0.866007447, 0, -0.500031412, 0, 1, 0, 0.500031412, 0, -0.866007447))
wait(0.2)
if not game.Players.LocalPlayer.Backpack:FindFirstChild"Lockpick" then 
local args = {
    [1] = "Lockpick"
}

game:GetService("ReplicatedStorage").FE.BuyGear:InvokeServer(unpack(args))
end 
if not  game.Players.LocalPlayer.Backpack:FindFirstChild"Drill" then 
wait(0.2)
local args = {
    [1] = "Drill"
}

game:GetService("ReplicatedStorage").FE.BuyGear:InvokeServer(unpack(args))
end 
if not game.Players.LocalPlayer.Backpack:FindFirstChild"RFID Disruptor" then 

local args = {
    [1] = "RFID Disruptor"
}

game:GetService("ReplicatedStorage").FE.BuyGear:InvokeServer(unpack(args))
end 
if not game.Players.LocalPlayer.Backpack:FindFirstChild"Knife" then 

local args = {
    [1] = "Knife"
}

game:GetService("ReplicatedStorage").FE.BuyGear:InvokeServer(unpack(args))
end 
end 
if  game.Players.LocalPlayer.Backpack:FindFirstChild"Drill" and  game.Players.LocalPlayer.Backpack:FindFirstChild"RFID Disruptor" and game.Players.LocalPlayer.Backpack:FindFirstChild"Lockpick" and game.Players.LocalPlayer.Backpack:FindFirstChild"Knife" then  
print("Already got tools")
else 
getools()
end 
end)

sector6:AddDropdown("Kill Player (Knife)",PlayerName,"",false,function(plr)
Kill(plr)
end) 

sector7:AddButton("Buy AK47",function()
    -- Script generated by SimpleSpy - credits to exx#9394

local args = {
    [1] = "AK47"
}

game:GetService("ReplicatedStorage").FE.BuyGun:InvokeServer(unpack(args))
TweenTo(Vector3.new(-1221.71472, 24.7248363, -192.380905, -0.0357225761, -1.59595626e-08, -0.999361753, -1.00776205e-07, 1, -1.23674706e-08, 0.999361753, 1.00270086e-07, -0.0357225761))
end)

sector7:AddButton("Buy M14",function()
    -- Script generated by SimpleSpy - credits to exx#9394

local args = {
    [1] = "M14"
}

game:GetService("ReplicatedStorage").FE.BuyGun:InvokeServer(unpack(args))
TweenTo(Vector3.new(-1221.71472, 24.7248363, -192.380905, -0.0357225761, -1.59595626e-08, -0.999361753, -1.00776205e-07, 1, -1.23674706e-08, 0.999361753, 1.00270086e-07, -0.0357225761))
end)

sector7:AddButton("Buy Beretta M9",function()
    -- Script generated by SimpleSpy - credits to exx#9394

local args = {
    [1] = "Beretta M9"
}

game:GetService("ReplicatedStorage").FE.BuyGun:InvokeServer(unpack(args))
TweenTo(Vector3.new(-1221.71472, 24.7248363, -192.380905, -0.0357225761, -1.59595626e-08, -0.999361753, -1.00776205e-07, 1, -1.23674706e-08, 0.999361753, 1.00270086e-07, -0.0357225761))
end)
end
if game.PlaceId == 1224212277 then

local Toggles = {
AutoRob = false,
AutoXp =  false,
RainBowCar =  false,
KillAura = false,
KillAllGun =  false,
AutoArrest = false,
KillAll = false,
playername =""

}
lib=loadstring(game:HttpGet"https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/UILibrary.lua")()
local win = lib:CreateWindow("Mad City", Vector2.new(492, 598), Enum.KeyCode.RightShift)


local tab1 = win:CreateTab("Universal")
local tab2 = win:CreateTab("Main")
local tab3 = win:CreateTab("Teleports")
local sector5 = tab1:CreateSector("ESP","right")
local sector1 = tab1:CreateSector("Universal","left")
local sector2 = tab2:CreateSector("AutoFarm","left")
local sector8 = tab2:CreateSector("Vehicle","right")
local sector3 = tab2:CreateSector("Combat","right")
local sector4 = tab2:CreateSector("Change Team","left")
local sector9 = tab2:CreateSector("Trolling","left")
local sector7 = tab2:CreateSector("One Time Rob","right")
local sector6 = tab3:CreateSector("Teleport","left")
local Utils = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
flying = false


local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/ESP%20lib.lua"))()
ESP:Toggle(true)

ESP.Tracers = false
ESP.Names = false
ESP.Boxes = false

sector5:AddToggle("Boxes",false,function(t)
ESP.Boxes =t 
end)

sector5:AddToggle("Nametags",false,function(t)
ESP.Names =t 
end)

sector5:AddToggle("Tracers",false,function(t)
ESP.Tracers =t 
end)
sector1:AddSlider("Walkspeed",16,16,300,1,function(a)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = a
end)

sector1:AddSlider("Jumppower",50,50,500,1,function(a)
game.Players.LocalPlayer.Character.Humanoid.JumpPower = a
end)

sector1:AddKeybind("Fly", Enum.KeyCode.F, function(newkey) 
print(newkey)
end, function()
if flying == false then 
local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
localplayer = plr
if workspace:FindFirstChild("Core") then
workspace.Core:Destroy()
end
local Core = Instance.new("Part")
Core.Name = "Core"
Core.Size = Vector3.new(0.05, 0.05, 0.05)
spawn(function()
Core.Parent = workspace
local Weld = Instance.new("Weld", Core)
Weld.Part0 = Core
Weld.Part1 = localplayer.Character.LowerTorso
Weld.C0 = CFrame.new(0, 0, 0)
end)
workspace:WaitForChild("Core")
local torso = workspace.Core
flying = true
local speed=16
local keys={a=false,d=false,w=false,s=false}
local e1
local e2
local function start()
local pos = Instance.new("BodyPosition",torso)
local gyro = Instance.new("BodyGyro",torso)
pos.Name="EPIXPOS"
pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
pos.position = torso.Position
gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
gyro.cframe = torso.CFrame
repeat
wait()
localplayer.Character.Humanoid.PlatformStand=true
local new=gyro.cframe - gyro.cframe.p + pos.position
if not keys.w and not keys.s and not keys.a and not keys.d then
speed=5
end
if keys.w then
new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
speed=speed+0
end
if keys.s then
new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
speed=speed+0
end
if keys.d then
new = new * CFrame.new(speed,0,0)
speed=speed+0
end
if keys.a then
new = new * CFrame.new(-speed,0,0)
speed=speed+0
end
if speed>10 then
speed=5
end
pos.position=new.p
if keys.w then
gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
elseif keys.s then
gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
else
gyro.cframe = workspace.CurrentCamera.CoordinateFrame
end
until flying == false
if gyro then gyro:Destroy() end
if pos then pos:Destroy() end
flying=false
localplayer.Character.Humanoid.PlatformStand=false
speed=10
end
e1=mouse.KeyDown:connect(function(key)
if not torso or not torso.Parent then flying=true e1:disconnect() e2:disconnect() return end
if key=="w" then
keys.w=true
elseif key=="s" then
keys.s=true
elseif key=="a" then
keys.a=true
elseif key=="d" then
keys.d=true
end
end)
e2=mouse.KeyUp:connect(function(key)
if key=="w" then
keys.w=false
elseif key=="s" then
keys.s=false
elseif key=="a" then
keys.a=false
elseif key=="d" then
keys.d=false
end
end)
start()
else
flying = false
end
end)

sector1:AddButton("Reset",function()
game.Players.LocalPlayer.Character["Humanoid"]:Destroy()
end)

sector1:AddButton("Rejoin",function()
game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService"Players".LocalPlayer)
end)

sector1:AddButton("ServerHop",function()
local HttpService, TPService = game:GetService("HttpService"), game:GetService("TeleportService")
    local ServersToTP = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    for _, s in pairs(ServersToTP.data) do
      if s.playing ~= s.maxPlayers then
          TPService:TeleportToPlaceInstance(game.PlaceId, s.id)
      end end end)

sector2:AddLabel("Must Use AutRob Not hesit")
sector2:AddLabel("When AutoArrest Off Reset")
sector2:AddLabel("After Using AutoArrest")
sector2:AddButton("Bypass Tp(AutoRob)",function()
local Human = game.Players.LocalPlayer.Character.HumanoidRootPart
Human.Parent = nil
Human.Parent = game.Players.LocalPlayer.Character
end)

sector2:AddToggle("AutoRob",false,function(a)
    Toggles.AutoRob = a 
end)
spawn(function()
while task.wait(0.1) do 
pcall(function()
    if Toggles.AutoRob ==  true then 
         game.Players.LocalPlayer:ClearCharacterAppearance()
                     if game.Players.LocalPlayer.Character:findFirstChild("NameTag") then
game.Players.LocalPlayer.Character.NameTag:Destroy()
          for _,v in pairs(game:GetService("Workspace").ObjectSelection:GetDescendants()) do 
if v:IsA("Part") and v.Name == "SmashCash" then 
        v.SmashCash.Event:FireServer()
wait()
    elseif v:IsA("MeshPart") and v.Name == "Cash" then 
        v.Cash.Event:FireServer()
wait()
    elseif v:IsA("Part") and v.Name == "StealTV" then 
        v.StealTV.Event:FireServer()
wait()
    elseif v:IsA("Part") and v.Name == "ATM" then 
        v.ATM.Event:FireServer()
    end 
end 
workspace.ObjectSelection.DiamondBox.Nope.SmashCash.Event:FireServer()
wait()
workspace.ObjectSelection.Luggage.Nope.SmashCash.Event:FireServer()
wait()
workspace.ObjectSelection.CashRegister.Nope.SmashCash.Event:FireServer()
wait()
workspace.ObjectSelection.Laptop.Nope.Steal.Event:FireServer()
wait()
workspace.ObjectSelection.Phone.Nope.Steal.Event:FireServer()

game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("DataFetch")

game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("DataFetch")
for i = 1, 5 do
   wait(0.1)
            game.workspace.Heists.JewelryStore.EssentialParts.JewelryBoxes.JewelryManager.Event:FireServer(i)
end end end end) end end)

   spawn(function()
while task.wait(0.01) do 
pcall(function()
    if Toggles.AutoRob ==  true then 
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2104.79102,26.7301254,421.229431)
end end) end end)


sector2:AddToggle("AutoXp",false,function(a)
Toggles.AutoXp = a 
end)     
spawn(function()
while task.wait() do 
pcall(function()
if Toggles.AutoXp == true then
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("SetTeam", "Police")
end end) end end)
   spawn(function()
while task.wait() do 
pcall(function()
        if Toggles.AutoXp == true then 
             for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
       if v.Name == "Handcuffs" then v.Parent = game:GetService("Players").LocalPlayer.Character
end end 
   for i= 1, 3 do
               game:GetService("ReplicatedStorage").Event:FireServer("Eject", game.Players.LocalPlayer)

end end end) end end)

sector2:AddToggle("AutoArrest",false,function(a)
    Toggles.AutoArrest = a 
end)
spawn(function()
while task.wait(0.1) do 
pcall(function()
    if Toggles.AutoArrest ==  true then 
         game.Players.LocalPlayer:ClearCharacterAppearance()
                 game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("SetTeam", "Police")
                     if game.Players.LocalPlayer.Character:findFirstChild("NameTag") then
game.Players.LocalPlayer.Character.NameTag:Destroy()
end end end) end end)
spawn(function()
while task.wait(0.1) do 
pcall(function()
    if Toggles.AutoArrest ==  true then 
    for i,v in pairs(game.Players:GetPlayers()) do
   if v.Name == game.Players.LocalPlayer.Name then
       else
local args = {
[1] = "VR",
[2] = game:GetService("Players")[v.Name].Character.Head
}

game:GetService("ReplicatedStorage").Event:FireServer(unpack(args))
end end end end) end end)

           spawn(function()
       while task.wait (0.1) do 
           pcall(function()
               if Toggles.AutoArrest == true then

local Player = game.Players.LocalPlayer
    local cpos = Player.Character.HumanoidRootPart.CFrame
            for i,v in pairs(game.Teams.Criminals:GetPlayers()) do
        if v.Name ~= Player.Name then
            local i = 3
            repeat
            wait(0.5)
            i = i-1
local CFrameEnd = CFrame.new(v.Character.HumanoidRootPart.position)
local Time = 7
local tween =  game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Time), {CFrame = CFrameEnd})
tween:Play()
tween.Completed:Wait(E) 
until i == 0 
  end    end end end) end end)
         
                spawn(function()
       while task.wait (0.1) do 
           pcall(function()
               if Toggles.AutoArrest == true then 

game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack["Pistol-S"])
end  end) end end)

sector8:AddSlider("Car Height",3,1,30,1,function(d)
local aa = require(game.Workspace.ObjectSelection[game.Players.LocalPlayer.Name.."'s Vehicle"].Settings)
aa.Height = d
end)

sector8:AddSlider("Car Speed",16,1,600,1,function(d)
local aa = require(game.Workspace.ObjectSelection[game.Players.LocalPlayer.Name.."'s Vehicle"].Settings)
aa.MaxSpeed = d
end)

sector8:AddSlider("Car Break",16,1,200,1,function(d)
local aa = require(game.Workspace.ObjectSelection[game.Players.LocalPlayer.Name.."'s Vehicle"].Settings)
aa.BrakeForce = d
end)

sector8:AddToggle("RainBowCar",false,function(a)
    Toggles.RainBowCar = a 
    end)      
    spawn(function()
    while task.wait(0.01) do 
    pcall(function()
    if Toggles.RainBowCar == true then
    
    local args = {
    [1] = "EquipItem",
    [2] = "S12"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    -- Script generated by SimpleSpy - credits to exx#9394
    wait(0.1)
    local args = {
    [1] = "EquipItem",
    [2] = "S13"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    -- Script generated by SimpleSpy - credits to exx#9394
    wait(0.1)

    local args = {
    [1] = "EquipItem",
    [2] = "S14"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    -- Script generated by SimpleSpy - credits to exx#9394
    wait(0.1)

    local args = {
    [1] = "EquipItem",
    [2] = "S15"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    wait(0.1)

    local args = {
    [1] = "EquipItem",
    [2] = "S16"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    wait(0.1)

    local args = {
    [1] = "EquipItem",
    [2] = "S17"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    wait(0.1)

    local args = {
    [1] = "BuyItem",
    [2] = "S12"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    -- Script generated by SimpleSpy - credits to exx#9394
    
    local args = {
    [1] = "BuyItem",
    [2] = "S13"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    -- Script generated by SimpleSpy - credits to exx#9394
    local args = {
    [1] = "BuyItem",
    [2] = "S16"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))local args = {
    [1] = "BuyItem",
    [2] = "S17"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    local args = {
    [1] = "BuyItem",
    [2] = "S14"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    -- Script generated by SimpleSpy - credits to exx#9394
    
    local args = {
    [1] = "BuyItem",
    [2] = "S15"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))-- Script generated by SimpleSpy - credits to exx#9394
    
    local args = {
    [1] = "BuyItem",
    [2] = "S16"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    
    
    local args = {
    [1] = "EquipItem",
    [2] = "WC3"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    local args = {
    [1] = "EquipItem",
    [2] = "WC4"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    local args = {
    [1] = "EquipItem",
    [2] = "WC5"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    local args = {
    [1] = "EquipItem",
    [2] = "WC6"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    local args = {
    [1] = "EquipItem",
    [2] = "WC7"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    local args = {
    [1] = "EquipItem",
    [2] = "WC8"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    local args = {
    [1] = "EquipItem",
    [2] = "WC9"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    local args = {
    [1] = "BuyItem",
    [2] = "WC3"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    local args = {
    [1] = "BuyItem",
    [2] = "WC4"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    local args = {
    [1] = "BuyItem",
    [2] = "WC5"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    local args = {
    [1] = "BuyItem",
    [2] = "WC6"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    local args = {
    [1] = "BuyItem",
    [2] = "WC7"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    local args = {
    [1] = "BuyItem",
    [2] = "WC8"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    local args = {
    [1] = "BuyItem",
    [2] = "WC9"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    local args = {
    [1] = "BuyItem",
    [2] = "WC10"
    }
    
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
    end end) end end)

sector3:AddLabel("Dont Use Bypass Tp With")
sector3:AddLabel("Kill All/Aura Will Glitch")
sector3:AddLabel("You need gun for Kill All")
sector3:AddToggle("KillAll",false,function(a)
    Toggles.KillAll = a 
end)
 spawn(function()
while wait () do
  pcall(function()
      if Toggles.KillAll == true then
      for Index, Value in next, game.Players:GetPlayers() do
   if (Value ~= game.Players.LocalPlayer and Value.Character and Value.Character:FindFirstChild("HumanoidRootPart")) then
local args = {
  [1] = "BM",
  [2] = Value.Character.HumanoidRootPart.Position
}

game:GetService("ReplicatedStorage").Event:FireServer(unpack(args))

game:GetService("Workspace").ObjectSelection.Buzzard.DriveSeat.Disabled = false
end end end  end) end end)

 spawn(function()
while wait () do
  pcall(function()
      if Toggles.KillAll == true then
 local _speed=1750
function tp(...)
local plr=game.Players.LocalPlayer
local args={...}
if typeof(args[1])=="number"and args[2]and args[3]then
  args=Vector3.new(args[1],args[2],args[3])
elseif typeof(args[1])=="Vector3" then
   args=args[1]    
elseif typeof(args[1])=="CFrame" then
   args=args[1].Position
end
local dist=(plr.Character.HumanoidRootPart.Position-args).Magnitude
game:GetService("TweenService"):Create(
   plr.Character.HumanoidRootPart,
   TweenInfo.new(dist/_speed,Enum.EasingStyle.Quad),
   {CFrame=CFrame.new(args)}
):Play()
end
tp(-2414.25757, 26.986187, -1341.31177, -0.999656737, 2.06214263e-08, -0.0262002125, 1.99478887e-08, 1, 2.59687223e-08, 0.0262002125, 2.5437167e-08, -0.999656737)
wait(2)
tp(game.Workspace.ObjectSelection.Buzzard.DriveSeat.CFrame)
end end) end end)
sector3:AddToggle("KillAllGun",false,function(a)
Toggles.KillAllGun = a 
end)
spawn(function()
while task.wait(0.1) do 
    pcall(function()
        if Toggles.KillAllGun == true then 
            for i,v in pairs(game.Players:GetPlayers()) do
   if v.Name == game.Players.LocalPlayer.Name then
       else
local args = {
[1] = "VR",
[2] = game:GetService("Players")[v.Name].Character.Head
}

game:GetService("ReplicatedStorage").Event:FireServer(unpack(args))
end end end end) end end)

sector3:AddToggle("KillAura",false,function(a)
Toggles.KillAura = a
end)
spawn(function()
while task.wait(0.1) do 
pcall(function()
        if Toggles.KillAura == true then 
for i,v in pairs(game.Players:GetPlayers()) do
   if v.Name == game.Players.LocalPlayer.Name then
       else
local args = {
[1] = "Punch",
[2] = game:GetService("Players")[v.Name].Character.Humanoid
}

game:GetService("ReplicatedStorage").Event:FireServer(unpack(args))
-- Script generated by SimpleSpy - credits to exx#9394

local args = {
[1] = "PlaySound",
[2] = 649585965,
[3] = game:GetService("Players")[v.Name].Character.HumanoidRootPart
}

game:GetService("ReplicatedStorage").Event:FireServer(unpack(args))
end end end end) end end)



sector4:AddButton("Switch to Heroes",function()
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("SetTeam", "Heroes")  
end)

sector4:AddButton("Switch to Prisoner",function()
game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("SetTeam", "Prisoners")  
end)

sector4:AddButton("Switch To Police",function()
        game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("SetTeam", "Police")
end)

sector9:AddButton("Destroy Lasers",function()
    for i,v in pairs(workspace:GetDescendants()) do 
    if v:IsA "Part" and v.Material==Enum.Material.Neon then
       v:Destroy()
    end end end)
    
sector9:AddButton("Get Guns",function()
game:GetService("Workspace").ObjectSelection.Pistol.Pistol.Pistol.Event:FireServer()
game:GetService("Workspace").ObjectSelection.Shotgun.Shotgun.Shotgun.Event:FireServer()
game:GetService("Workspace").ObjectSelection.Grenade.Grenade.Grenade.Event:FireServer()
game:GetService("Workspace").ObjectSelection.Machete.Machete.Machete.Event:FireServer()
game:GetService("Workspace").ObjectSelection.AK47.AK47.AK47.Event:FireServer()
end)

sector9:AddButton("Give All Glider",function()
for i,v in pairs(game.Players:GetChildren()) do
local args = {
[1] = "Glider",
[2] = v.Character.Parachute.Handle,
[3] = -math.huge
}
game:GetService("ReplicatedStorage").Event:FireServer(unpack(args))
end
end)
sector9:AddButton("Remove Gilder",function()
for i,v in pairs(game.Players:GetChildren()) do
local args = {
[1] = "Glider",
[2] = v.Character.Parachute.Handle,
[3] = math.huge
}

game:GetService("ReplicatedStorage").Event:FireServer(unpack(args))
end
end)

sector9:AddButton("Give KeyCard",function()
   for i = 1,30 do
for i,v in pairs(game.Players:GetChildren()) do
local args = {
[1] = "Pickpocket",
[2] = v
}

game:GetService("ReplicatedStorage").Event:FireServer(unpack(args))
end
end
end)

sector9:AddLabel("Teleport to a Player")
sector9:AddTextbox("Player Name", "Player Name", function(Argument3)
  local _speed=1400
function tp(...)
local plr=game.Players.LocalPlayer
local args={...}
if typeof(args[1])=="number"and args[2]and args[3]then
  args=Vector3.new(args[1],args[2],args[3])
elseif typeof(args[1])=="Vector3" then
   args=args[1]    
elseif typeof(args[1])=="CFrame" then
   args=args[1].Position
end
local dist=(plr.Character.HumanoidRootPart.Position-args).Magnitude
game:GetService("TweenService"):Create(
   plr.Character.HumanoidRootPart,
   TweenInfo.new(dist/_speed,Enum.EasingStyle.Quad),
   {CFrame=CFrame.new(args)}
):Play()
end



function Utils.GetPlayer(PlayerName)
local Player;
local PlayersT = Players:GetPlayers()
for i = 1, #PlayersT do
if string.lower(string.sub(PlayersT[i].Name, 1, string.len(PlayerName))) == string.lower(PlayerName) then
Player = PlayersT[i]
break
end
end
return Player
end
local char=game.Players.LocalPlayer.Character
local Player = Utils.GetPlayer(Argument3)
wait(0.1)
if Player ~= nil and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players:FindFirstChild(Player.Name) and game.Players:FindFirstChild(Player.Name).Character:FindFirstChild("HumanoidRootPart") then
    tp(game.Players[Player.Name].Character.HumanoidRootPart.CFrame)
end
end)



sector7:AddButton("Rob Bank",function()
 if game.ReplicatedStorage.HeistStatus.Bank.Locked.Value == true then
             game:GetService("StarterGui"):SetCore("SendNotification",{     
Title = "Wait",     
Text = "Wait for Bank Open",
Duration = 15, })
else
local function Banks()
          local _speed=1400
function tp(...)
local plr=game.Players.LocalPlayer
local args={...}
if typeof(args[1])=="number"and args[2]and args[3]then
  args=Vector3.new(args[1],args[2],args[3])
elseif typeof(args[1])=="Vector3" then
   args=args[1]    
elseif typeof(args[1])=="CFrame" then
   args=args[1].Position
end
local dist=(plr.Character.HumanoidRootPart.Position-args).Magnitude
game:GetService("TweenService"):Create(
   plr.Character.HumanoidRootPart,
   TweenInfo.new(dist/_speed,Enum.EasingStyle.Quad),
   {CFrame=CFrame.new(args)}
):Play()
end

tp(653, 52, 477)
wait(3)
tp(660, 52, 487)
wait(1)
tp(732, 52, 540)
wait(1)
tp(678, 52, 599)
wait(1)
tp(710, 54, 639)
wait(1)
tp(722, 60, 636)
wait(1)
tp(744, 71, 627)
wait(1)
tp(657, 110, 617)
wait(1)
tp(705, 110, 544)
wait(10)
tp(724, 110, 534)
wait(40)
tp(653, 52, 477)
wait(1)
tp(758, 77, 622)
wait(2)
tp(2075, 26, 397) -- criminal base 
end
Banks()
end
end)

sector7:AddButton("Rob Plane",function()
  if game.Workspace.CargoPlane.Plane == nil then
    game:GetService("StarterGui"):SetCore("SendNotification",{     
Title = "Wait",     
Text = "Wait For Plane",
Duration = 15, })
else
local _speed=1400
function tp(...)
local plr=game.Players.LocalPlayer
local args={...}
if typeof(args[1])=="number"and args[2]and args[3]then
  args=Vector3.new(args[1],args[2],args[3])
elseif typeof(args[1])=="Vector3" then
   args=args[1]    
elseif typeof(args[1])=="CFrame" then
   args=args[1].Position
end
local dist=(plr.Character.HumanoidRootPart.Position-args).Magnitude
game:GetService("TweenService"):Create(
   plr.Character.HumanoidRootPart,
   TweenInfo.new(dist/_speed,Enum.EasingStyle.Quad),
   {CFrame=CFrame.new(args)}
):Play()
end
tp(game.Workspace.CargoPlane.Plane.Tele1.Position)
wait(1)
tp(game.Workspace.CargoPlane.Plane.Tele1.Position)

for i, v in pairs(workspace.ObjectSelection:GetChildren()) do
      if v.Name == "PlaneCrate" then
      local part = v:FindFirstChildOfClass("Part")
      local pos = v.PlaneCrate.Position
                      for i = 0,2 do
                          wait(.1)
                          game.Players.LocalPlayer.Character.HumanoidRootPart.Position = pos
                      end
          wait(0.3)
          v.PlaneCrate.PlaneCrate.Event:FireServer()
                        repeat
             wait()
           until game.Players.LocalPlayer.PlayerGui.MainGUI.StatsHUD.CashBagHUD.Cash.Amount.Text == "4"
          wait(2)
          wait(2)
          end
      end
          wait(1)
          game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(232, 51061, 598)
          wait(1)
          game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(227, 51074, 695)
          wait(1)
          game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(236, 51091, 536)
         wait(1)

for i, v in pairs(workspace.ObjectSelection:GetChildren()) do
      if v.Name == "HackKeypad" then
      local part = v:FindFirstChildOfClass("Part")
      if part.Name ~= "Nope" then
      local pos = v.HackKeypad.Position
                      for i = 1,2 do
                          wait(.1)
                          game.Players.LocalPlayer.Character.HumanoidRootPart.Position = pos
                      end
          wait(0.3)
          v.HackKeypad.HackKeypad.Event:FireServer()
          wait(2)
      end
      end
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(232.338531, 51095.75, 513.972473, 1, 0, 0, 0, 1, 0, 0, 0, 1)
wait(1)
workspace.ObjectSelection.PlaneButton.PlaneButton.PlaneButton.Event:FireServer()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(231.832428, 51067.2266, 489.710938, 1, 0, 0, 0, 1, 0, 0, 0, 1)
wait(2)
tp(2062, 26, 429)
wait(2)
tp(2101, 27, 426)
end
end)





sector7:AddButton("Rob Pyramid",function()
if game.ReplicatedStorage.HeistStatus.Pyramid.Locked.Value == true then
        game:GetService("StarterGui"):SetCore("SendNotification",{     
Title = "Wait",     
Text = "Wait For Pyramid To Open",
Duration = 10, })
else
local _speed=1400
function tp(...)
local plr=game.Players.LocalPlayer
local args={...}
if typeof(args[1])=="number"and args[2]and args[3]then
  args=Vector3.new(args[1],args[2],args[3])
elseif typeof(args[1])=="Vector3" then
   args=args[1]    
elseif typeof(args[1])=="CFrame" then
   args=args[1].Position
end
local dist=(plr.Character.HumanoidRootPart.Position-args).Magnitude
game:GetService("TweenService"):Create(
   plr.Character.HumanoidRootPart,
   TweenInfo.new(dist/_speed,Enum.EasingStyle.Quad),
   {CFrame=CFrame.new(args)}
):Play()
end


tp(-1047.58899, 18.2789993, -479.790009, 1, 0, 0, 0, 1, 0, 0, 0, 1)
wait(3)
tp(1233, 51046, 428)
wait(1)
tp(1234, 51054, 444)
wait(.50)
tp(1209, 51053, 500)
wait(1)
tp(1180, 51059, 455)
wait(1)
tp(995, 51077, 499)
wait(1)
tp(997, 51073, 547)
for i, v in pairs(workspace.ObjectSelection:GetChildren()) do
      if v.Name == "TreasurePyramid" then
      local part = v:FindFirstChildOfClass("Part")
      local pos = v.TreasurePyramid.Position
                      for i = 1, math.random(3,10) do
                          wait(.1)
                          game.Players.LocalPlayer.Character.HumanoidRootPart.Position = pos
                      end
          wait(0.3)
          v.TreasurePyramid.TreasurePyramid.Event:FireServer()
      end
      
end
end
tp(-1053, 18, -508)
wait(2)
tp(-84, 27, 794)
wait(1)
tp(1230, 51052, 438)
wait(2)
tp(1231.14185, 51051.2344, 381.096191, -1, 0, 0, 0, 1, 0, 0, 0, -1)
wait(2)
tp(-1012, 21, -519)
wait(5)
tp(1997, 26, 420)
wait(2)
tp(2065, 26, 428)
wait(2)
tp(2086, 27, 435)
wait(1)
tp(2059, 26, 433)
wait(1)
tp(2059, 26, 433)
wait(1)
tp(2059, 26, 433)
end)



sector7:AddButton("Rob Ship",function()
if game.Workspace.Ship.Boat.Vault == nil then
            game:GetService("StarterGui"):SetCore("SendNotification",{     
Title = "Wait",     
Text = "Wait For Ship",
Duration = 10, })
else
             local _speed=1400
function tp(...)
local plr=game.Players.LocalPlayer
local args={...}
if typeof(args[1])=="number"and args[2]and args[3]then
  args=Vector3.new(args[1],args[2],args[3])
elseif typeof(args[1])=="Vector3" then
   args=args[1]    
elseif typeof(args[1])=="CFrame" then
   args=args[1].Position
end
local dist=(plr.Character.HumanoidRootPart.Position-args).Magnitude
game:GetService("TweenService"):Create(
   plr.Character.HumanoidRootPart,
   TweenInfo.new(dist/_speed,Enum.EasingStyle.Quad),
   {CFrame=CFrame.new(args)}
):Play()
end


tp(2471, 42, 267)
wait(2)
tp(2488, 51, 205)   
wait(2)
tp(2502, 67, 256)
wait(1)
tp(2510, 81, 326)
wait(10)
tp(2510, 82, 340)
wait(1)
tp(2517, 81, 333)
wait(25)
tp(2327, 26, 298)
wait(2)
tp(1976, 26, 345)
wait(2)
tp(2065, 27, 427)
wait(2)
tp(2076, 26, 427)
end
end)

sector6:AddButton("Prison",function()
local _speed=1400
function tp(...)
local plr=game.Players.LocalPlayer
local args={...}
if typeof(args[1])=="number"and args[2]and args[3]then
  args=Vector3.new(args[1],args[2],args[3])
elseif typeof(args[1])=="Vector3" then
   args=args[1]    
elseif typeof(args[1])=="CFrame" then
   args=args[1].Position
end
local dist=(plr.Character.HumanoidRootPart.Position-args).Magnitude
game:GetService("TweenService"):Create(
   plr.Character.HumanoidRootPart,
   TweenInfo.new(dist/_speed,Enum.EasingStyle.Quad),
   {CFrame=CFrame.new(args)}
):Play()
end


tp(-945, 119, -2979)
end)

sector6:AddButton("Gun Shop",function()
local _speed=1400
function tp(...)
local plr=game.Players.LocalPlayer
local args={...}
if typeof(args[1])=="number"and args[2]and args[3]then
  args=Vector3.new(args[1],args[2],args[3])
elseif typeof(args[1])=="Vector3" then
   args=args[1]    
elseif typeof(args[1])=="CFrame" then
   args=args[1].Position
end
local dist=(plr.Character.HumanoidRootPart.Position-args).Magnitude
game:GetService("TweenService"):Create(
   plr.Character.HumanoidRootPart,
   TweenInfo.new(dist/_speed,Enum.EasingStyle.Quad),
   {CFrame=CFrame.new(args)}
):Play()
end


tp(-1658, 43, 707)
end)

sector6:AddButton("Criminal Base",function()
local _speed=1400
function tp(...)
local plr=game.Players.LocalPlayer
local args={...}
if typeof(args[1])=="number"and args[2]and args[3]then
  args=Vector3.new(args[1],args[2],args[3])
elseif typeof(args[1])=="Vector3" then
   args=args[1]    
elseif typeof(args[1])=="CFrame" then
   args=args[1].Position
end
local dist=(plr.Character.HumanoidRootPart.Position-args).Magnitude
game:GetService("TweenService"):Create(
   plr.Character.HumanoidRootPart,
   TweenInfo.new(dist/_speed,Enum.EasingStyle.Quad),
   {CFrame=CFrame.new(args)}
):Play()
end

tp(2101, 27, 426)
end)



sector6:AddButton("Ship",function()
local _speed=1400
function tp(...)
local plr=game.Players.LocalPlayer
local args={...}
if typeof(args[1])=="number"and args[2]and args[3]then
  args=Vector3.new(args[1],args[2],args[3])
elseif typeof(args[1])=="Vector3" then
   args=args[1]    
elseif typeof(args[1])=="CFrame" then
   args=args[1].Position
end
local dist=(plr.Character.HumanoidRootPart.Position-args).Magnitude
game:GetService("TweenService"):Create(
   plr.Character.HumanoidRootPart,
   TweenInfo.new(dist/_speed,Enum.EasingStyle.Quad),
   {CFrame=CFrame.new(args)}
):Play()
end


tp(2517, 81, 335)
end)

sector6:AddButton("Airport",function()

local _speed=1400
function tp(...)
local plr=game.Players.LocalPlayer
local args={...}
if typeof(args[1])=="number"and args[2]and args[3]then
  args=Vector3.new(args[1],args[2],args[3])
elseif typeof(args[1])=="Vector3" then
   args=args[1]    
elseif typeof(args[1])=="CFrame" then
   args=args[1].Position
end
local dist=(plr.Character.HumanoidRootPart.Position-args).Magnitude
game:GetService("TweenService"):Create(
   plr.Character.HumanoidRootPart,
   TweenInfo.new(dist/_speed,Enum.EasingStyle.Quad),
   {CFrame=CFrame.new(args)}
):Play()
end


tp(-2146, 28, -1421)
end)
sector6:AddButton("Jewelry Store",function()
local _speed=1400
function tp(...)
local plr=game.Players.LocalPlayer
local args={...}
if typeof(args[1])=="number"and args[2]and args[3]then
  args=Vector3.new(args[1],args[2],args[3])
elseif typeof(args[1])=="Vector3" then
   args=args[1]    
elseif typeof(args[1])=="CFrame" then
   args=args[1].Position
end
local dist=(plr.Character.HumanoidRootPart.Position-args).Magnitude
game:GetService("TweenService"):Create(
   plr.Character.HumanoidRootPart,
   TweenInfo.new(dist/_speed,Enum.EasingStyle.Quad),
   {CFrame=CFrame.new(args)}
):Play()
end


tp(-109, 96, 746)
end)



sector6:AddButton("Club",function()
local _speed=1400
function tp(...)
local plr=game.Players.LocalPlayer
local args={...}
if typeof(args[1])=="number"and args[2]and args[3]then
  args=Vector3.new(args[1],args[2],args[3])
elseif typeof(args[1])=="Vector3" then
   args=args[1]    
elseif typeof(args[1])=="CFrame" then
   args=args[1].Position
end
local dist=(plr.Character.HumanoidRootPart.Position-args).Magnitude
game:GetService("TweenService"):Create(
   plr.Character.HumanoidRootPart,
   TweenInfo.new(dist/_speed,Enum.EasingStyle.Quad),
   {CFrame=CFrame.new(args)}
):Play()
end


tp(1093, 54, 169)
end)



sector6:AddButton("Bank",function()
local _speed=1400
function tp(...)
local plr=game.Players.LocalPlayer
local args={...}
if typeof(args[1])=="number"and args[2]and args[3]then
  args=Vector3.new(args[1],args[2],args[3])
elseif typeof(args[1])=="Vector3" then
   args=args[1]    
elseif typeof(args[1])=="CFrame" then
   args=args[1].Position
end
local dist=(plr.Character.HumanoidRootPart.Position-args).Magnitude
game:GetService("TweenService"):Create(
   plr.Character.HumanoidRootPart,
   TweenInfo.new(dist/_speed,Enum.EasingStyle.Quad),
   {CFrame=CFrame.new(args)}
):Play()
end
tp(637, 51, 465)

end)

sector6:AddButton("Pyramid",function()
local _speed=1400
function tp(...)
local plr=game.Players.LocalPlayer
local args={...}
if typeof(args[1])=="number"and args[2]and args[3]then
  args=Vector3.new(args[1],args[2],args[3])
elseif typeof(args[1])=="Vector3" then
   args=args[1]    
elseif typeof(args[1])=="CFrame" then
   args=args[1].Position
end
local dist=(plr.Character.HumanoidRootPart.Position-args).Magnitude
game:GetService("TweenService"):Create(
   plr.Character.HumanoidRootPart,
   TweenInfo.new(dist/_speed,Enum.EasingStyle.Quad),
   {CFrame=CFrame.new(args)}
):Play()
end


tp(-1046, 18, -499)
end)


sector6:AddButton("Casino",function()
local _speed=1400
function tp(...)
local plr=game.Players.LocalPlayer
local args={...}
if typeof(args[1])=="number"and args[2]and args[3]then
  args=Vector3.new(args[1],args[2],args[3])
elseif typeof(args[1])=="Vector3" then
   args=args[1]    
elseif typeof(args[1])=="CFrame" then
   args=args[1].Position
end
local dist=(plr.Character.HumanoidRootPart.Position-args).Magnitude
game:GetService("TweenService"):Create(
   plr.Character.HumanoidRootPart,
   TweenInfo.new(dist/_speed,Enum.EasingStyle.Quad),
   {CFrame=CFrame.new(args)}
):Play()
end


tp(1697, 38, 739)
end)

sector6:AddButton("Train",function()
if game.Workspace.Train ~= nil then
local _speed=1400
function tp(...)
local plr=game.Players.LocalPlayer
local args={...}
if typeof(args[1])=="number"and args[2]and args[3]then
  args=Vector3.new(args[1],args[2],args[3])
elseif typeof(args[1])=="Vector3" then
   args=args[1]    
elseif typeof(args[1])=="CFrame" then
   args=args[1].Position
end
local dist=(plr.Character.HumanoidRootPart.Position-args).Magnitude
game:GetService("TweenService"):Create(
   plr.Character.HumanoidRootPart,
   TweenInfo.new(dist/_speed,Enum.EasingStyle.Quad),
   {CFrame=CFrame.new(args)}
):Play()
end
tp(game.Workspace.Train.Mid1.Yeet.Position)
end
end)

game:GetService("Players").LocalPlayer.Idled:connect(function()
local vu = game:GetService("VirtualUser")
vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
wait(1)
vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
end 

if game.PlaceId == 621129760 then
    
 local Toggles = {
        AutoFarm = false
    }
lib=loadstring(game:HttpGet"https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/UILibrary.lua")()
local win = lib:CreateWindow("Bacon hub | KAT", Vector2.new(492, 598), Enum.KeyCode.RightShift)



local tab4 = win:CreateTab("Main")
local sector5 = tab4:CreateSector("ESP","left")
local sector6 = tab4:CreateSector("Silent Aim","right")

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/ESP%20lib.lua"))()
ESP:Toggle(true)

ESP.Tracers = false
ESP.Names = false
ESP.Boxes = false


sector5:AddToggle("Boxes",false,function(t)
    ESP.Boxes =t 
end)

sector5:AddToggle("Nametags",false,function(t)
    ESP.Names =t 
end)

sector5:AddToggle("Tracers",false,function(t)
    ESP.Tracers =t 
end)

sector6:AddButton("Slient Aim",function()
local localPlayer = game:GetService("Players").LocalPlayer
local currentCamera = game:GetService("Workspace").CurrentCamera
local mouse = localPlayer:GetMouse()

local function getClosestPlayerToCursor(x, y)
    local closestPlayer = nil
    local shortestDistance = math.huge

    for i, v in pairs(game:GetService("Players"):GetPlayers()) do
        if v ~= localPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Torso") then
            local pos = currentCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(x, y)).magnitude

            if magnitude < shortestDistance then
                closestPlayer = v
                shortestDistance = magnitude
            end
		end
    end

    return closestPlayer
end

local mt = getrawmetatable(game)
local oldIndex = mt.__index
if setreadonly then setreadonly(mt, false) else make_writeable(mt, true) end
local newClose = newcclosure or function(f) return f end

mt.__index = newClose(function(t, k)
    if not checkcaller() and t == mouse and tostring(k) == "X" and string.find(getfenv(2).script.Name, "Client") and getClosestPlayerToCursor() then
    	local closest = getClosestPlayerToCursor(oldIndex(t, k), oldIndex(t, "Y")).Character.Head
    	local pos = currentCamera:WorldToScreenPoint(closest.Position)
    	return pos.X
    end
    if not checkcaller() and t == mouse and tostring(k) == "Y" and string.find(getfenv(2).script.Name, "Client") and getClosestPlayerToCursor() then
    	local closest = getClosestPlayerToCursor(oldIndex(t, "X"), oldIndex(t, k)).Character.Head
    	local pos = currentCamera:WorldToScreenPoint(closest.Position)
    	return pos.Y
    end
    if t == mouse and tostring(k) == "Hit" and string.find(getfenv(2).script.Name, "Client") and getClosestPlayerToCursor() then
        return getClosestPlayerToCursor(mouse.X, mouse.Y).Character.Head.CFrame
    end

    return oldIndex(t, k)
end)

if setreadonly then setreadonly(mt, true) else make_writeable(mt, false) 
end end)
sector6:AddToggle("AutoFarm",false,function(a)
    Toggles.AutoFarm = a 
end)

    spawn(function()
while wait() do 
    pcall(function()
        if Toggles.AutoFarm == true then
for i,v in pairs(game.Players:GetChildren()) do
v.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-2)
end  end end) end end)


    spawn(function()
while wait() do 
    pcall(function()
        if Toggles.AutoFarm == true then
       for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.name == "Knife" then
            v.Parent = game.Players.LocalPlayer.Character
        end
       end
 game:GetService'VirtualUser':Button1Down(Vector2.new(0.9,0.9))
       game:GetService'VirtualUser':Button1Up(Vector2.new(0.9,0.9))
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = (CFrame.new(4001,1003,144))  end end) end end)

            sector6:AddButton("Join Discord",function()
    setclipboard("https://discord.gg/4KVsXpGjHn")
end)
end 

if game.PlaceId == 286090429 then 
    
local Toggles = {
    KillAura = false,
    KillAll = false
}
lib=loadstring(game:HttpGet"https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/UILibrary.lua")()
local win = lib:CreateWindow("Bacon Hub| Arsenal", Vector2.new(492, 598), Enum.KeyCode.RightShift)


local tab1 = win:CreateTab("Universal")
local tab2 = win:CreateTab("Combat")
local sector5 = tab1:CreateSector("ESP","right")
local sector1 = tab1:CreateSector("Universal","left")
local sector2 = tab2:CreateSector("Silent Aim","left")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera
local Debris = game:GetService("Debris")
local UserInputService = game:GetService("UserInputService")
local target = false
local RunService = game:GetService("RunService")


getfenv().lock = _G.AimPartDogeBox
_G.aimbotEnabled = false
_G.isFovCircle = false

local st = tonumber(tick());

fov = 350;
function createcircle()
	local a=Drawing.new('Circle');a.Transparency=1;a.Thickness=1.5;a.Visible=false;a.Color=Color3.fromRGB(0,255,149);a.Filled=false;a.Radius=fov;
	return a;
end;  
local fovc = createcircle();
spawn(function()
	RunService:BindToRenderStep("FovCircle",1,function()
	    fovc.Position = Vector2.new(mouse.X,mouse.Y)
	end);
end);
coroutine.resume(coroutine.create(function()
    game:GetService("RunService").RenderStepped:connect(function()
        if _G.isFovCircle then
            fovc.Visible = true
        else
            fovc.Visible = false
        end
    end)
end))

function isFfa()
	local am = #Players:GetChildren();
	local amm = 0;
	for i , v in pairs(Players:GetChildren()) do
		if v.Team == LocalPlayer.Team then
			amm = amm + 1;
		end;
	end;
	return am == amm;
end;
function getnearest()
	local nearestmagnitude = math.huge
	local nearestenemy = nil
	local vector = nil
	local ffa = isFfa();
	for i,v in next, Players:GetChildren() do
		if ffa == false and v.Team ~= LocalPlayer.Team or ffa == true then
			if v.Character and  v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
				local vector, onScreen = Camera:WorldToScreenPoint(v.Character["HumanoidRootPart"].Position)
				if onScreen then
					local ray = Ray.new(
					Camera.CFrame.p,
					(v.Character["Head"].Position-Camera.CFrame.p).unit*500
					)
					local ignore = {
					LocalPlayer.Character,
					}
					local hit,position,normal=workspace:FindPartOnRayWithIgnoreList(ray,ignore)
					if hit and hit:FindFirstAncestorOfClass("Model") and Players:FindFirstChild(hit:FindFirstAncestorOfClass("Model").Name)then
						local magnitude = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(vector.X, vector.Y)).magnitude
						if magnitude < nearestmagnitude and magnitude <= fov then
							nearestenemy = v
							nearestmagnitude = magnitude
						end
					end
				end
			end
		end
	end
	return nearestenemy
end


local meta = getrawmetatable(game)
setreadonly(meta, false)
local oldNamecall = meta.__namecall
meta.__namecall = newcclosure(function(...)
    
	local method = getnamecallmethod()
	local args = {...}
	if string.find(method,'Ray') then
		if target then
		    if args[1].Name ~= "Workspace" then
   		        print(args[1])
   		    end;
			args[2] = Ray.new(workspace.CurrentCamera.CFrame.Position, (target.Position + Vector3.new(0,(workspace.CurrentCamera.CFrame.Position-target.Position).Magnitude/500,0) - workspace.CurrentCamera.CFrame.Position).unit * 5000)
		end
	end
	return oldNamecall(unpack(args))
end)

RunService:BindToRenderStep("SilentAim",1,function()
    if _G.aimbotEnabled then
    	if UserInputService:IsMouseButtonPressed(0) and Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("Humanoid") and Players.LocalPlayer.Character.Humanoid.Health > 0 then
    		local enemy = getnearest()
    		if enemy and enemy.Character and enemy.Character:FindFirstChild("Humanoid") and enemy.Character.Humanoid.Health > 0 then                
    			local vector, onScreen = Camera:WorldToScreenPoint(enemy.Character["Head"].Position)
    			local head = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(vector.X, vector.Y)).magnitude
    			local vector, onScreen = Camera:WorldToScreenPoint(enemy.Character["HumanoidRootPart"].Position)
    			local hitbox = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(vector.X, vector.Y)).magnitude
    			if head <= hitbox then
    				magnitude = head
    			else
    				magnitude = hitbox;
    			end;
    			if getfenv().lock == "Head" then
    				target = workspace[enemy.Name]["Head"]
    			else
    				if getfenv().lock == "Random" then
    					if magnitude == hitbox then
    						target = workspace[enemy.Name]["HumanoidRootPart"];
    					else
    						target = workspace[enemy.Name]["Head"]
    					end;
    				else
    					target = workspace[enemy.Name]["HumanoidRootPart"];
    				end;
    
    			end;
    		else
    			target = nil
    		end
    	end
	end
end)
coroutine.resume(coroutine.create(function()
    _G.WallbangLO = false
    local mt = getrawmetatable(game)
    local nc = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local Method = getnamecallmethod()
        local Arguments = {...}
        if Method == 'FindPartOnRayWithIgnoreList' and _G.WallbangLO then
            table.insert(Arguments[2], game.GetService(game, 'Workspace').Map)
            return nc(self, unpack(Arguments))
        end
        return nc(self,...)
    end)
end))

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/ESP%20lib.lua"))()
ESP:Toggle(true)

ESP.Tracers = false
ESP.Names = false
ESP.Boxes = false

sector5:AddToggle("Boxes",false,function(t)
    ESP.Boxes = t 
end)

sector5:AddToggle("Nametags",false,function(t)
    ESP.Names = t 
end)

sector5:AddToggle("Tracers",false,function(t)
    ESP.Tracers = t 
end)

sector2:AddToggle("Silent Aim", false, function(t)
    _G.aimbotEnabled = t
end)

sector2:AddToggle("Fov Circle", false, function(t)
    _G.isFovCircle = t
end)

sector2:AddToggle("Wallbang", false, function(t)
    _G.wallbangLO = t
end)

sector2:AddToggle("KillAura",false,function(a)
    Toggles.KillAura = a 
end)
spawn(function()
    while task.wait(0.1) do 
        pcall(function()
            if Toggles.KillAura == true then 
for i,v in pairs(game.Players:GetPlayers()) do
       if v.Name == game.Players.LocalPlayer.Name then
           else

local ohNumber1 = 80
local ohInstance2 = workspace[v.Name].Hitbox

game:GetService("ReplicatedStorage").Events.FallDamage:FireServer(ohNumber1, ohInstance2)

end end end end) end end)
sector2:AddToggle("AutoFarm",false,function(a)
    Toggles.KillAll = a 
end)
spawn(function()
    while task.wait(0.1) do 
        pcall(function()
            if Toggles.KillAll == true then 
local args = {
    [1] = "TBC"
}

game:GetService("ReplicatedStorage").Events.JoinTeam:FireServer(unpack(args))
function getClosest()
           local closestdistance = 210
           local ClosetPlayer = nil
           for i,v in pairs(game.Players:GetChildren()) do
               if v ~= game.Players.LocalPlayer and v.Team ~= game.Players.LocalPlayer.Team then
                   local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
                   if distance < closestdistance then
                       closestdistance = distance
                       ClosetPlayer = v
                   end
               end
           end
           return ClosetPlayer
           end 
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = getClosest().Character.HumanoidRootPart.CFrame * CFrame.new(0, 4, 8)
      for i,v in pairs(game.Players:GetPlayers()) do
       if v.Name == game.Players.LocalPlayer.Name then
           else
wait()
local ohNumber1 = 60
local ohInstance2 = workspace[v.Name].Hitbox

game:GetService("ReplicatedStorage").Events.FallDamage:FireServer(ohNumber1, ohInstance2)
end end end end) end end)

sector1:AddButton("Reset",function()
    game.Players.LocalPlayer.Character["Humanoid"]:Destroy()
end)
    
sector1:AddButton("Rejoin",function()
    game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId,game.JobId,game:GetService"Players".LocalPlayer)
end)
end 

if game.PlaceId == 301549746 then 
    
lib=loadstring(game:HttpGet"https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/UILibrary.lua")()
local win = lib:CreateWindow("Bacon hub | Counter Blox", Vector2.new(492, 598), Enum.KeyCode.RightShift)




local tab2 = win:CreateTab("Main")
local sector1 = tab2:CreateSector("Misc","left") 

sector1:AddButton("Inf Money",function()
    val = true

if val == true then
	game.Players.LocalPlayer.Cash.Value = 16000
	CashHook = game.Players.LocalPlayer.Cash:GetPropertyChangedSignal("Value"):connect(function()
		game.Players.LocalPlayer.Cash.Value = 16000
	end)
elseif val == false and CashHook then
	CashHook:Disconnect()
end
end)

sector1:AddButton("Kill All",function()
    local function IsAlive(plr)
	if plr and plr.Character and plr.Character.FindFirstChild(plr.Character, "Humanoid") and plr.Character.Humanoid.Health > 0 then
		return true
	end

	return false
end


pcall(function()
for i,v in pairs(game.Players:GetChildren()) do
	if v ~= game.Players.LocalPlayer and IsAlive(v) and IsAlive(game.Players.LocalPlayer) and v.Team ~= game.Players.LocalPlayer.Team then
		local Arguments = {
			[1] = v.Character.Head,
			[2] = v.Character.Head.Position,
			[3] = "Banana",
			[4] = 100,
			[5] = game.Players.LocalPlayer.Character.Gun,
			[8] = 100,
			[9] = false,
			[10] = false,
			[11] = Vector3.new(),
			[12] = 100,
			[13] = Vector3.new()
		}
		game.ReplicatedStorage.Events.HitPart:FireServer(unpack(Arguments))
	end
end
end)
end)

sector1:AddButton("Godmode",function()
    pcall(function()
	game.ReplicatedStorage.Events.FallDamage:FireServer(0/0)
	game.Players.LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
		game.Players.LocalPlayer.Character.Humanoid.Health = 100
	end)
end) 
end)

sector1:AddButton("No Recoil",function()
    local cbClient = getsenv(game.Players.LocalPlayer.PlayerGui:WaitForChild("Client"))
val = true

if val == true then
	game:GetService("RunService"):BindToRenderStep("NoRecoil", 100, function()
		cbClient.resetaccuracy()
		cbClient.RecoilX = 0
		cbClient.RecoilY = 0
	end)
elseif val == false then
	game:GetService("RunService"):UnbindFromRenderStep("NoRecoil")
end
end)

sector1:AddButton("Inf Stamina",function()
    val = true
	if val == true then
		game:GetService("RunService"):BindToRenderStep("Stamina", 100, function()
			if cbClient.crouchcooldown ~= 0 then
				cbClient.crouchcooldown = 0
			end
		end)
	elseif val == false then
		game:GetService("RunService"):UnbindFromRenderStep("Stamina")
	end
end)

sector1:AddButton("Plant C4",function()
    LocalPlayer = game.Players.LocalPlayer

local function IsAlive(plr)
	if plr and plr.Character and plr.Character.FindFirstChild(plr.Character, "Humanoid") and plr.Character.Humanoid.Health > 0 then
		return true
	end

	return false
end

local function GetSite()
	if (LocalPlayer.Character.HumanoidRootPart.Position - workspace.Map.SpawnPoints.C4Plant.Position).magnitude > (LocalPlayer.Character.HumanoidRootPart.Position - workspace.Map.SpawnPoints.C4Plant2.Position).magnitude then
		return "A"
	else
		return "B"
	end
end



pcall(function()
if IsAlive(LocalPlayer) and workspace.Map.Gamemode.Value == "defusal" and workspace.Status.Preparation.Value == false and not planting then 
	planting = true
	local pos = LocalPlayer.Character.HumanoidRootPart.CFrame 
	workspace.CurrentCamera.CameraType = "Fixed"
	LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.SpawnPoints.C4Plant.CFrame
	wait(0.2)
	game.ReplicatedStorage.Events.PlantC4:FireServer((pos + Vector3.new(0, -2.75, 0)) * CFrame.Angles(math.rad(90), 0, math.rad(180)), GetSite())
	wait(0.2)
	LocalPlayer.Character.HumanoidRootPart.CFrame = pos
	LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
	game.Workspace.CurrentCamera.CameraType = "Custom"
	planting = false
end
end)
end)

sector1:AddButton("Inf Jump",function()
    val = true

if val == true then
	JumpHook = game:GetService("UserInputService").JumpRequest:connect(function()
		game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") 
	end)
elseif val == false and JumpHook then
	JumpHook:Disconnect()
end
end)

sector1:AddButton("Defuse C4",function()
    LocalPlayer = game.Players.LocalPlayer

local function IsAlive(plr)
	if plr and plr.Character and plr.Character.FindFirstChild(plr.Character, "Humanoid") and plr.Character.Humanoid.Health > 0 then
		return true
	end

	return false
end

local function GetSite()
	if (LocalPlayer.Character.HumanoidRootPart.Position - workspace.Map.SpawnPoints.C4Plant.Position).magnitude > (LocalPlayer.Character.HumanoidRootPart.Position - workspace.Map.SpawnPoints.C4Plant2.Position).magnitude then
		return "A"
	else
		return "B"
	end
end



pcall(function()
if IsAlive(LocalPlayer) and workspace.Map.Gamemode.Value == "defusal" and not defusing and workspace:FindFirstChild("C4") then 
	defusing = true
	LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
	local pos = LocalPlayer.Character.HumanoidRootPart.CFrame 
	workspace.CurrentCamera.CameraType = "Fixed"
	LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.C4.Handle.CFrame + Vector3.new(0, 2, 0)
	LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
	wait(0.1)
	LocalPlayer.Backpack.PressDefuse:FireServer(workspace.C4)
	LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
	wait(0.25)
	if IsAlive(LocalPlayer) and workspace:FindFirstChild("C4") and workspace.C4:FindFirstChild("Defusing") and workspace.C4.Defusing.Value == LocalPlayer then
		LocalPlayer.Backpack.Defuse:FireServer(workspace.C4)
	end
	LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
	wait(0.2)
	LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
	LocalPlayer.Character.HumanoidRootPart.CFrame = pos
	LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
	game.Workspace.CurrentCamera.CameraType = "Custom"
	defusing = false
end
end)
end)
end 

if game.PlaceId == 2377868063 then 
    
    game:GetService("ReplicatedStorage").Network.Remotes.Deploy:InvokeServer()
wait(2)
    lib=loadstring(game:HttpGet"https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/UILibrary.lua")()
local win = lib:CreateWindow("Bacon Hub| Strucid", Vector2.new(492, 598), Enum.KeyCode.RightShift)


local tab1 = win:CreateTab("Main")
local sector5 = tab1:CreateSector("ESP","right")
local sector1 = tab1:CreateSector("Universal","left")
local sector2 = tab1:CreateSector("Combat","left")

-- Script generated by SimpleSpy - credits to exx#9394


local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/ESP%20lib.lua"))()
ESP:Toggle(true)

ESP.Tracers = false
ESP.Names = false
ESP.Boxes = false

sector5:AddToggle("Boxes",false,function(t)
    ESP.Boxes =t 
end)

sector5:AddToggle("Nametags",false,function(t)
    ESP.Names =t 
end)

sector5:AddToggle("Tracers",false,function(t)
    ESP.Tracers =t 
end)

    sector1:AddSlider("Jumppower",50,50,500,1,function(a)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = a
    end)
    
    
    
    sector1:AddKeybind("Fly", Enum.KeyCode.F, function(newkey) 
        print(newkey)
    end, function()
    if flying == false then 
    local plr = game.Players.LocalPlayer
    local mouse = plr:GetMouse()
    localplayer = plr
    if workspace:FindFirstChild("Core") then
    workspace.Core:Destroy()
    end
    local Core = Instance.new("Part")
    Core.Name = "Core"
    Core.Size = Vector3.new(0.05, 0.05, 0.05)
    spawn(function()
    Core.Parent = workspace
    local Weld = Instance.new("Weld", Core)
    Weld.Part0 = Core
    Weld.Part1 = localplayer.Character.LowerTorso
    Weld.C0 = CFrame.new(0, 0, 0)
    end)
    workspace:WaitForChild("Core")
    local torso = workspace.Core
    flying = true
    local speed=10 
    local keys={a=false,d=false,w=false,s=false}
    local e1
    local e2
    local function start()
    local pos = Instance.new("BodyPosition",torso)
    local gyro = Instance.new("BodyGyro",torso)
    pos.Name="EPIXPOS"
    pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
    pos.position = torso.Position
    gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    gyro.cframe = torso.CFrame
    repeat
    wait()
    localplayer.Character.Humanoid.PlatformStand=true
    local new=gyro.cframe - gyro.cframe.p + pos.position
    if not keys.w and not keys.s and not keys.a and not keys.d then
    speed=5
    end
    if keys.w then
    new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
    speed=speed+0
    end
    if keys.s then
    new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
    speed=speed+0
    end
    if keys.d then
    new = new * CFrame.new(speed,0,0)
    speed=speed+0
    end
    if keys.a then
    new = new * CFrame.new(-speed,0,0)
    speed=speed+0
    end
    if speed>10 then
    speed=5
    end
    pos.position=new.p
    if keys.w then
    gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
    elseif keys.s then
    gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
    else
    gyro.cframe = workspace.CurrentCamera.CoordinateFrame
    end
    until flying == false
    if gyro then gyro:Destroy() end
    if pos then pos:Destroy() end
    flying=false
    localplayer.Character.Humanoid.PlatformStand=false
    speed=10
    end
    e1=mouse.KeyDown:connect(function(key)
    if not torso or not torso.Parent then flying=true e1:disconnect() e2:disconnect() return end
    if key=="w" then
    keys.w=true
    elseif key=="s" then
    keys.s=true
    elseif key=="a" then
    keys.a=true
    elseif key=="d" then
    keys.d=true
    end
    end)
    e2=mouse.KeyUp:connect(function(key)
    if key=="w" then
    keys.w=false
    elseif key=="s" then
    keys.s=false
    elseif key=="a" then
    keys.a=false
    elseif key=="d" then
    keys.d=false
    end
    end)
    start()
    else
    flying = false
    end
    end)
    
    sector1:AddButton("Reset",function()
    game.Players.LocalPlayer.Character["Humanoid"]:Destroy()
    end)
    
    sector1:AddButton("Rejoin",function()
    game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId,game.JobId,game:GetService"Players".LocalPlayer)
    end)
    
sector2:AddToggle("Silent Aim (reactivate on death)", false, function(active)
    print(active)
    -- vars
local Players       = game:GetService("Players");
local Player        = Players.LocalPlayer;
local Mouse         = Player:GetMouse();
local Workspace     = game:GetService("Workspace");
local CurrentCam    = Workspace.CurrentCamera;
local require       = require;

-- player func
function getClosestPlayer()
    local closestPlayer;
    local shortestDistance = math.huge;
    
    for i, v in next, game.Players:GetPlayers() do
        if (v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head")) then
            local pos       = v.Character.Head.Position
            local lpos = game.Players.LocalPlayer.Character.Head.Position
            local magnitude = (Vector3.new(pos.X, pos.Y, pos.Z) - Vector3.new(lpos.X, lpos.Y, lpos.Z)).Magnitude
            
            if (magnitude < shortestDistance) then
                closestPlayer       = v;
                shortestDistance    = magnitude;
            end;
        end;
    end;
    
    return closestPlayer;
end;

-- main func
local function run()
    task.wait(); -- task lib winning

    local gunModule = require(Player.PlayerGui:WaitForChild("MainGui").NewLocal.Tools.Tool.Gun);
    local oldFunc   = gunModule.ConeOfFire;
    local old = gunModule.ConeOfFire
    print(old)
    gunModule.ConeOfFire = function(...)
        
        if (getfenv(2).script.Name == "Extra") then
            local closePlayer = getClosestPlayer();
            
            if (closePlayer and closePlayer.Character) then
                if active == true then
                    return closePlayer.Character.Head.CFrame * CFrame.new(math.random(0.1, 0.25), math.random(0.1, 0.25), math.random(0.1, 0.25)).p;
                else
                    return oldFunc(...)
                end            
            end;
        end;
        
        return oldFunc(...)
    end;
end;

run();

Player.CharacterAdded:Connect(run);
end)
end 

if game.PlaceId == 1067560271 or game.PlaceId == 735030788 or game.PlaceId == 1765700510 or game.PlaceId == 1187101243 then 
        
lib=loadstring(game:HttpGet"https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/UILibrary.lua")()
local win = lib:CreateWindow("Bacon Hub| Royale High", Vector2.new(492, 598), Enum.KeyCode.RightShift)


local tab1 = win:CreateTab("Main")
local sector2 = tab1:CreateSector("AutoFarm","left")
local sector5 = tab1:CreateSector("ESP","right")
local sector1 = tab1:CreateSector("Universal","left")

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/ESP%20lib.lua"))()
ESP:Toggle(true)

ESP.Tracers = false
ESP.Names = false
ESP.Boxes = false

sector5:AddToggle("Boxes",false,function(t)
    ESP.Boxes =t 
end)

sector5:AddToggle("Nametags",false,function(t)
    ESP.Names =t 
end)

sector5:AddToggle("Tracers",false,function(t)
    ESP.Tracers =t 
end)
sector1:AddSlider("Walkspeed",16,16,300,1,function(a)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = a
    end)
    
    sector1:AddSlider("Jumppower",50,50,500,1,function(a)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = a
    end)
    
    
    
    sector1:AddKeybind("Fly", Enum.KeyCode.F, function(newkey) 
        print(newkey)
    end, function()
    if flying == false then 
    local plr = game.Players.LocalPlayer
    local mouse = plr:GetMouse()
    localplayer = plr
    if workspace:FindFirstChild("Core") then
    workspace.Core:Destroy()
    end
    local Core = Instance.new("Part")
    Core.Name = "Core"
    Core.Size = Vector3.new(0.05, 0.05, 0.05)
    spawn(function()
    Core.Parent = workspace
    local Weld = Instance.new("Weld", Core)
    Weld.Part0 = Core
    Weld.Part1 = localplayer.Character.LowerTorso
    Weld.C0 = CFrame.new(0, 0, 0)
    end)
    workspace:WaitForChild("Core")
    local torso = workspace.Core
    flying = true
    local speed=10 
    local keys={a=false,d=false,w=false,s=false}
    local e1
    local e2
    local function start()
    local pos = Instance.new("BodyPosition",torso)
    local gyro = Instance.new("BodyGyro",torso)
    pos.Name="EPIXPOS"
    pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
    pos.position = torso.Position
    gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    gyro.cframe = torso.CFrame
    repeat
    wait()
    localplayer.Character.Humanoid.PlatformStand=true
    local new=gyro.cframe - gyro.cframe.p + pos.position
    if not keys.w and not keys.s and not keys.a and not keys.d then
    speed=5
    end
    if keys.w then
    new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
    speed=speed+0
    end
    if keys.s then
    new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
    speed=speed+0
    end
    if keys.d then
    new = new * CFrame.new(speed,0,0)
    speed=speed+0
    end
    if keys.a then
    new = new * CFrame.new(-speed,0,0)
    speed=speed+0
    end
    if speed>10 then
    speed=5
    end
    pos.position=new.p
    if keys.w then
    gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
    elseif keys.s then
    gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
    else
    gyro.cframe = workspace.CurrentCamera.CoordinateFrame
    end
    until flying == false
    if gyro then gyro:Destroy() end
    if pos then pos:Destroy() end
    flying=false
    localplayer.Character.Humanoid.PlatformStand=false
    speed=10
    end
    e1=mouse.KeyDown:connect(function(key)
    if not torso or not torso.Parent then flying=true e1:disconnect() e2:disconnect() return end
    if key=="w" then
    keys.w=true
    elseif key=="s" then
    keys.s=true
    elseif key=="a" then
    keys.a=true
    elseif key=="d" then
    keys.d=true
    end
    end)
    e2=mouse.KeyUp:connect(function(key)
    if key=="w" then
    keys.w=false
    elseif key=="s" then
    keys.s=false
    elseif key=="a" then
    keys.a=false
    elseif key=="d" then
    keys.d=false
    end
    end)
    start()
    else
    flying = false
    end
    end)
    
    sector1:AddButton("Reset",function()
    game.Players.LocalPlayer.Character["Humanoid"]:Destroy()
    end)
    
    sector1:AddButton("Rejoin",function()
    game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId,game.JobId,game:GetService"Players".LocalPlayer)
    end)



sector2:AddToggle("DiamondFarm",false,function(Farm)
    getgenv().DiamondFarm = Farm
     for i,v in pairs(game.Workspace:GetDescendants()) do 
    if v.Name == "Seat" or v.Name == "zebra couch seat" or v.Name == "VehicleSeat" then
    v:Destroy()
    end end 
spawn(function()
while task.wait(1) do 
if getgenv().DiamondFarm == false then 
game.Workspace.Gravity = 196
end 
end end)

spawn(function()
while DiamondFarm do wait(0.3)
    pcall(function()
 for i, v in pairs(game:GetService("Workspace").CollectibleDiamonds:GetChildren()) do
         if v:IsA("Part") and v.Transparency == 0 then
         tp(v.CFrame)
         game.Workspace.Gravity = 0 
         end end end) end end) end)

sector2:AddSlider("TweenSpeed",1,1,350,1,function(a)
    getgenv().TweenSpeed = a
local _speed=TweenSpeed
function tp(...)
local plr=game.Players.LocalPlayer
local args={...}
if typeof(args[1])=="number"and args[2]and args[3]then
  args=Vector3.new(args[1],args[2],args[3])
elseif typeof(args[1])=="Vector3" then
   args=args[1]    
elseif typeof(args[1])=="CFrame" then
   args=args[1].Position
end
local dist=(plr.Character.HumanoidRootPart.Position-args).Magnitude
game:GetService("TweenService"):Create(
   plr.Character.HumanoidRootPart,
   TweenInfo.new(dist/_speed,Enum.EasingStyle.Quad),
   {CFrame=CFrame.new(args)}
):Play()
end
end)
end 
if game.PlaceId== 537413528 then
function dad()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-51.1823959, 80.6168747, -536.437805)
    tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new(30, Enum.EasingStyle.Linear)
    tween =
        tweenService:Create(
        game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart,
        tweenInfo,
        {CFrame = CFrame.new(-60.5737877, 53.9498825, 8666.35059)}
    )
    tween:Play()
    wait(30)
    tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new(0, Enum.EasingStyle.Linear)
    tween =
        tweenService:Create(
        game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart,
        tweenInfo,
        {CFrame = CFrame.new(-55.5486526, -360.063782, 9489.0498)}
    )
    tween:Play()
end
local function bodyvel(Part, Speed, Destination, Extra, waittime)
    local Speed = Speed or 1
    local Part = Part or nil
    local Destination = Destination
    local waittime = waittime or 0
    local NewBodyVel = Instance.new("BodyVelocity")
    NewBodyVel.Parent = Part
    if typeof(Destination) == "Instance" then
        NewBodyVel.Velocity = (Destination.position - Part.position).Unit * Speed
        if Extra then
            NewBodyVel.MaxForce = Vector3.new(Extra, Extra, Extra)
            NewBodyVel.P = Extra
        end
        repeat
            wait()
            NewBodyVel.Velocity = (Destination.position - Part.position).Unit * Speed
        until (Destination.position - Part.position).Magnitude < 5
        NewBodyVel.Velocity = Vector3.new(0, 0, 0)
        wait(waittime)
        NewBodyVel:Destroy()
    else
        NewBodyVel.Velocity = (Destination - Part.position).Unit * Speed
        if Extra then
            NewBodyVel.MaxForce = Vector3.new(Extra, Extra, Extra)
            NewBodyVel.P = Extra
        end
        repeat
            wait()
            NewBodyVel.Velocity = (Destination - Part.position).Unit * Speed
        until (Destination - Part.position).Magnitude < 5
        NewBodyVel.Velocity = Vector3.new(0, 0, 0)
        wait(waittime)
        NewBodyVel:Destroy()
    end
end

local Toggles = {
    v2 = false

}



lib=loadstring(game:HttpGet"https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/UILibrary.lua")()
local win = lib:CreateWindow("Bacon Hub | Build A Boat", Vector2.new(492, 598), Enum.KeyCode.RightShift)

local tab2 = win:CreateTab("Main")
local tab3 = win:CreateTab("Teleports")
local tab1 = win:CreateTab("Misc")
local sector1 = tab1:CreateSector("Universals","left")
local sector2 = tab2:CreateSector("AutoFarms","left")
local sector3 = tab2:CreateSector("Buy Chests","right")
local sector4 = tab3:CreateSector("Teleport","left")
local sector5 = tab3:CreateSector("Get All Codes","right")
local sector6 = tab1:CreateSector("Morph","right")
local sector7 = tab1:CreateSector("ESP","right")


local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/ESP%20lib.lua"))()
ESP:Toggle(true)

ESP.Tracers = false
ESP.Names = false
ESP.Boxes = false


sector7:AddToggle("Boxes",false,function(t)
    ESP.Boxes =t 
end)

sector7:AddToggle("Nametags",false,function(t)
    ESP.Names =t 
end)

sector7:AddToggle("Tracers",false,function(t)
    ESP.Tracers =t 
end)

sector1:AddSlider("Walkspeed",16,16,300,1,function(a)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = a
    end)
    
    sector1:AddSlider("Jumppower",50,50,500,1,function(a)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = a
    end)
    
    sector1:AddKeybind("No Clip", Enum.KeyCode.R, function(newkey) 
        print(newkey)
    end, function()
    if noclip == false then
    noclip = false
    game:GetService('RunService').Stepped:connect(function()
    if noclip then
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
    end
    end)
    plr = game.Players.LocalPlayer
    mouse = plr:GetMouse()
    noclip = not noclip
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
    else
    noclip = false
    end
    end)
    
    sector1:AddKeybind("Fly", Enum.KeyCode.F, function(newkey) 
        print(newkey)
    end, function()
    if flying == false then 
    local plr = game.Players.LocalPlayer
    local mouse = plr:GetMouse()
    localplayer = plr
    if workspace:FindFirstChild("Core") then
    workspace.Core:Destroy()
    end
    local Core = Instance.new("Part")
    Core.Name = "Core"
    Core.Size = Vector3.new(0.05, 0.05, 0.05)
    spawn(function()
    Core.Parent = workspace
    local Weld = Instance.new("Weld", Core)
    Weld.Part0 = Core
    Weld.Part1 = localplayer.Character.LowerTorso
    Weld.C0 = CFrame.new(0, 0, 0)
    end)
    workspace:WaitForChild("Core")
    local torso = workspace.Core
    flying = true
    local speed=10 
    local keys={a=false,d=false,w=false,s=false}
    local e1
    local e2
    local function start()
    local pos = Instance.new("BodyPosition",torso)
    local gyro = Instance.new("BodyGyro",torso)
    pos.Name="EPIXPOS"
    pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
    pos.position = torso.Position
    gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    gyro.cframe = torso.CFrame
    repeat
    wait()
    localplayer.Character.Humanoid.PlatformStand=true
    local new=gyro.cframe - gyro.cframe.p + pos.position
    if not keys.w and not keys.s and not keys.a and not keys.d then
    speed=5
    end
    if keys.w then
    new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
    speed=speed+0
    end
    if keys.s then
    new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
    speed=speed+0
    end
    if keys.d then
    new = new * CFrame.new(speed,0,0)
    speed=speed+0
    end
    if keys.a then
    new = new * CFrame.new(-speed,0,0)
    speed=speed+0
    end
    if speed>10 then
    speed=5
    end
    pos.position=new.p
    if keys.w then
    gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
    elseif keys.s then
    gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
    else
    gyro.cframe = workspace.CurrentCamera.CoordinateFrame
    end
    until flying == false
    if gyro then gyro:Destroy() end
    if pos then pos:Destroy() end
    flying=false
    localplayer.Character.Humanoid.PlatformStand=false
    speed=10
    end
    e1=mouse.KeyDown:connect(function(key)
    if not torso or not torso.Parent then flying=true e1:disconnect() e2:disconnect() return end
    if key=="w" then
    keys.w=true
    elseif key=="s" then
    keys.s=true
    elseif key=="a" then
    keys.a=true
    elseif key=="d" then
    keys.d=true
    end
    end)
    e2=mouse.KeyUp:connect(function(key)
    if key=="w" then
    keys.w=false
    elseif key=="s" then
    keys.s=false
    elseif key=="a" then
    keys.a=false
    elseif key=="d" then
    keys.d=false
    end
    end)
    start()
    else
    flying = false
    end
    end)
    
    sector1:AddButton("Reset",function()
    game.Players.LocalPlayer.Character["Humanoid"]:Destroy()
    end)
    
    sector1:AddButton("Rejoin",function()
    game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId,game.JobId,game:GetService"Players".LocalPlayer)
    end)

sector2:AddToggle("AutoFarm",false,function(State)
   build = State
spawn(function()
                ff = Instance.new("ForceField", game.Players.LocalPlayer.Character)
                ff.Visible = true
                game:GetService("RunService").Stepped:connect(
                    function()
                        if build then
game.workspace.Gravity = 0 
game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
                        end
                    end)
            end)

        spawn(function()
                if build then
                    dad()
                end
            end
        )

        spawn(
            function()
                if not build then
                    game.Players.LocalPlayer.Character.Head:Destroy()
                end
            end
        )
        spawn(
            function()
                game.Players.LocalPlayer.CharacterAdded:Connect(
                    function()
                        pcall(
                            function()
                                wait(3)
                                if build then
                                    dad()
end end) end) end) end)
sector2:AddButton("Autofarm Once",function()
    wait(3)
game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-142.677292, 109.114311, 736.056458))
wait(1)
local CFrameEnd = CFrame.new(-52.9965401, 79.506752, 8646.33984)
local Time = 33
local tween =  game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Time), {CFrame = CFrameEnd})
tween:Play()
tween.Completed:Wait()
game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-48.2867279, -358.622314, 8826.5))
local CFrameEnd = CFrame.new(-55.4865074, -360.404236, 9488.46973) 
local Time = 2 
local tween =  game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Time), {CFrame = CFrameEnd})
tween:Play()
tween.Completed:Wait() 
game.workspace.Gravity = 196
end)

sector5:AddButton("Get All Codes",function()
local args = {
    [1] = "=D"
}
workspace.CheckCodeFunction:InvokeServer(unpack(args))
wait(1)
local args = {
    [1] = "=p"
}
workspace.CheckCodeFunction:InvokeServer(unpack(args))
wait(1)
local args = {
    [1] = "hi"
}
workspace.CheckCodeFunction:InvokeServer(unpack(args))
wait(1)
local args = {
    [1] = "squid army"
}
workspace.CheckCodeFunction:InvokeServer(unpack(args))
wait(1)
local args = {
    [1] = "chillthrill709 was here"
}
workspace.CheckCodeFunction:InvokeServer(unpack(args))
wait(1)
local args = {
    [1] = "Fuzzy Friend?"
}
workspace.CheckCodeFunction:InvokeServer(unpack(args))
wait(1)
local args = {
    [1] = "Lurking Legend"
}
workspace.CheckCodeFunction:InvokeServer(unpack(args))
wait(1)
local args = {
    [1] = "Be a Big F00t Print"
}
workspace.CheckCodeFunction:InvokeServer(unpack(args))
end)







sector3:AddButton("Buy All Tools",function()
    local args = {
    [1] = "Painting Tool",
    [2] = 1
}
workspace.ItemBoughtFromShop:InvokeServer(unpack(args))
local args = {
    [1] = "Binding Tool",
    [2] = 1
}
workspace.ItemBoughtFromShop:InvokeServer(unpack(args))
local args = {
    [1] = "Property Tool",
    [2] = 1
}
workspace.ItemBoughtFromShop:InvokeServer(unpack(args))
local args = {
    [1] = "Scaling Tool",
    [2] = 1
}
workspace.ItemBoughtFromShop:InvokeServer(unpack(args))
end)

sector3:AddButton("Buy common Chest",function()
local args = {
    [1] = "Common Chest",
    [2] = 1
}
workspace.ItemBoughtFromShop:InvokeServer(unpack(args))
end)

sector3:AddButton("Buy Uncommon Chest",function()
local args = {
    [1] = "Uncommon Chest",
    [2] = 1
}
workspace.ItemBoughtFromShop:InvokeServer(unpack(args))
end)

sector3:AddButton("Buy Rare Chest",function()
local args = {
    [1] = "Rare Chest",
    [2] = 1
}
workspace.ItemBoughtFromShop:InvokeServer(unpack(args)) end)

sector3:AddButton("Buy Epic Chest",function()
local args = {
    [1] = "Rare Chest",
    [2] = 1
}
workspace.ItemBoughtFromShop:InvokeServer(unpack(args)) end)

sector3:AddButton("Buy Legendary Chest",function()
local args = {
    [1] = "Legendary Chest",
    [2] = 1
}
workspace.ItemBoughtFromShop:InvokeServer(unpack(args))
end)

sector6:AddButton("Fox",function()
  local args = {
    [1] = "FoxCharacter"
}
 
workspace.ChangeCharacter:FireServer(unpack(args)) end)

sector6:AddButton("Penguin",function()
  local args = {
    [1] = "PenguinCharacter"
}
 
workspace.ChangeCharacter:FireServer(unpack(args)) end)

sector6:AddButton("Chicken",function()
  local args = {
    [1] = "ChickenCharacter"
}
 
workspace.ChangeCharacter:FireServer(unpack(args)) end)


sector4:AddButton("White Team",function()
game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-48.5306664, -9.90198898, -470.319336))
end)

sector4:AddButton("Red Team",function()
game.Players.LocalPlayer.Character:MoveTo(Vector3.new(200.766083, -9.90198898, -64.5269012))
end)

sector4:AddButton("Black Team",function()
game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-468.962006, -9.90198898, -69.5107346))
end)

sector4:AddButton("Blue Team",function()
game.Players.LocalPlayer.Character:MoveTo(Vector3.new(334.28476, -9.90198898, 300.911285))
end)

sector4:AddButton("Green Team",function()
game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-469.260254, -9.91308308, 292.97879))
end)

sector4:AddButton("Purple Team",function()
game.Players.LocalPlayer.Character:MoveTo(Vector3.new(364.005463, -9.90198898, 647.096863))
end)

sector4:AddButton("Yellow Team",function()
game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-465.625946, -9.90198898, 640.451233))
end)

sector4:AddButtonButton("End",function()
game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-50.8009567, -360.406219, 9392.05957))
end)

local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
end 

if game.PlaceId == 2768379856 then 
lib=loadstring(game:HttpGet"https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/UILibrary.lua")()
local win = lib:CreateWindow("SCP 3008", Vector2.new(492, 598), Enum.KeyCode.RightShift)


local tab1 = win:CreateTab("Universal")
local sector5 = tab1:CreateSector("ESP","right")
local sector1 = tab1:CreateSector("Universal","left")
local sector2 = tab1:CreateSector("Main","left")

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/antiskids-xyz/Misc/load/BaconHub/ESP%20lib.lua"))()
ESP:Toggle(true)

ESP.Tracers = false
ESP.Names = false
ESP.Boxes = false

sector5:AddToggle("Boxes",false,function(t)
    ESP.Boxes =t 
end)

sector5:AddToggle("Nametags",false,function(t)
    ESP.Names =t 
end)

sector5:AddToggle("Tracers",false,function(t)
    ESP.Tracers =t 
end)

    sector1:AddSlider("Jumppower",50,50,500,1,function(a)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = a
    end)
    

    
    sector1:AddButton("Reset",function()
    game.Players.LocalPlayer.Character["Humanoid"]:Destroy()
    end)
    
    sector1:AddButton("Rejoin",function()
    game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId,game.JobId,game:GetService"Players".LocalPlayer)
    end)
    
sector2:AddButton("Inf Energy",function()
    game.Players.LocalPlayer.Character.Energy:Destroy()
end)

sector2:AddButton("SafeZone",function()
    local CFrameEnd = CFrame.new(1372.09058, 104.500351, 2396.96533, 0.548607588, 2.68093565e-08, 0.836079955, -1.46482257e-08, 1, -2.24538663e-08, -0.836079955, 7.12734663e-11, 0.548607588) 
local Time = 1
local tween =  game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Time), {CFrame = CFrameEnd})
tween:Play()
tween.Completed:Wait(E)
wait()
local baseplate = Instance.new("Part")
baseplate.Parent = workspace
baseplate.Size = Vector3.new(30,1,30)
baseplate.Anchored = true
baseplate.Name = "Baseplate"
baseplate.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0,-2,0)
end)

sector2:AddButton("Full Brightness",function()
game:GetService("Lighting").Brightness = 2
game:GetService("Lighting").ClockTime = 14
game:GetService("Lighting").FogEnd = 100000
game:GetService("Lighting").GlobalShadows = false
game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
end)
end
