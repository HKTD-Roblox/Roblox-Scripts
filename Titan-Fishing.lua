local Player = game.Players.LocalPlayer
local function ForceRename()
    local char = Player.Character or Player.CharacterAdded:Wait()
    local head = char:WaitForChild("Head")
    local hum = char:WaitForChild("Humanoid")       
    Player.DisplayName = "HKTD HUB PREMIUM"
    hum.DisplayName = "HKTD HUB PREMIUM"        
    task.spawn(function()
        while char and char.Parent do
            local color = Color3.fromHSV(tick() % 5 / 5, 1, 1)                                    
            hum.DisplayName = "HKTD HUB PREMIUM"                                  
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("TextLabel") and (v.Text == Player.Name or v.Text == Player.DisplayName or v.Text:find(Player.Name)) then
                    v.Text = "HKTD HUB PREMIUM"
                    v.TextColor3 = color
                end
            end
            task.wait(0.1)
        end
    end)
end
ForceRename()
Player.CharacterAdded:Connect(function()
    task.wait(1)
    ForceRename()
end)

if game.CoreGui:FindFirstChild("HKTD_SUPREME_V65") then
    game.CoreGui:FindFirstChild("HKTD_SUPREME_V65"):Destroy()
end

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local VIM = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

_G.X_Offset = 45; _G.Y_Offset = 46
_G.LemonAutoFarm = false
_G.AutoSellTime = 300
_G.EnableAutoSell = false
_G.SelectedIsland = "Đảo 1"
_G.TeleTarget = "Đảo 1"

_G.P_Points = {
    CAST = Vector2.new(600, 270), 
    Z = Vector2.new(720, 140),
    X = Vector2.new(720, 185), 
    C = Vector2.new(720, 225), 
    V = Vector2.new(720, 265)
}

local IslandData = {
    ["Đảo 1"] = {cf = CFrame.new(485.9, 21.0, -184.6), rot = -60, sell = CFrame.new(170.1, 22.9, 72.1)},
    ["Đảo 2"] = {cf = CFrame.new(1772.2, 21.0, -373.8), rot = 180, sell = CFrame.new(1751.8, 24.7, -397.6)},
    ["Đảo 3"] = {cf = CFrame.new(603.5, 21.0, 1328.9), rot = 90, sell = CFrame.new(1139.4, 70.4, 1474.2)},
    ["Đảo 4"] = {cf = CFrame.new(917.7, 21.0, -1088.4), rot = 180, sell = CFrame.new(491.0, 33.0, -1130.3)},
    ["Đảo 5"] = {cf = CFrame.new(-394.1, 21.0, 991.4), rot = 180, sell = CFrame.new(-533.6, 27.6, 1160.1)},
    ["Đảo 6"] = {cf = CFrame.new(-723.4, 23.4, -275.2), rot = 0, sell = CFrame.new(-844.22, 27.71, -222.05)},
    ["Đảo 7"] = {cf = CFrame.new(-703.3, 21.3, -1375.3), rot = 120, sell = CFrame.new(-514.1, 63.2, -1269.0)},
    ["Đảo 8"] = {cf = CFrame.new(1977.6, 21.0, -1651.5), rot = 0, sell = CFrame.new(1614.7, 45.5, -1296.8)},
    ["Đảo 9"] = {cf = CFrame.new(2290.8, 20.8, 927.0), rot = 90, sell = CFrame.new(2248.4, 33.7, 865.4)}
}

local function ApplyMaxFixLag()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 150
    Lighting.Brightness = 1
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Color = Color3.fromRGB(163, 162, 165)
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        end
    end
end

local function ServerHop()
    local x = {}
    for _, v in ipairs(HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
        if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
            x[#x + 1] = v.id
        end
    end
    if #x > 0 then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
    else
        Fluent:Notify({Title = "HKTD HUB", Content = "Không tìm thấy server khác!", Duration = 3})
    end
end

local function SmoothMove(targetCF, finalRot)
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = Player.Character.HumanoidRootPart
    local bv = Instance.new("BodyVelocity", hrp); bv.Velocity = Vector3.zero; bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    local tween = TweenService:Create(hrp, TweenInfo.new((hrp.Position - targetCF.Position).Magnitude / 140, Enum.EasingStyle.Linear), {CFrame = targetCF})
    tween:Play(); tween.Completed:Wait(); bv:Destroy()
    if finalRot then hrp.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(0, math.rad(finalRot), 0) end
end

local function V8_SpamSell()
    for _, v in pairs(Player.PlayerGui:GetDescendants()) do
        if (v:IsA("TextButton") or v:IsA("ImageButton")) and v.Visible then
            local name = string.lower(v:IsA("TextButton") and v.Text or v.Name)
            if (name:find("sell") or name:find("all") or name:find("bán")) then
                for i = 1, 30 do pcall(function() for _, ev in pairs({"MouseButton1Click", "Activated"}) do for _, con in pairs(getconnections(v[ev])) do con:Fire() end end end) task.wait(0.01) end
            end
        end
    end
end

local function RunSellSequence()
    local data = IslandData[_G.SelectedIsland]
    if not data or not data.sell then return end
    local oldFarm = _G.LemonAutoFarm; _G.LemonAutoFarm = false
    SmoothMove(data.sell)
    task.wait(0.5)
    for i=1,2 do VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game); task.wait(0.1); VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game); task.wait(0.3) end
    VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game); task.wait(0.8); VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    task.wait(1.2); V8_SpamSell(); task.wait(0.5)
    SmoothMove(data.cf, data.rot)
    _G.LemonAutoFarm = oldFarm
end

local SG = Instance.new("ScreenGui", game.CoreGui); SG.Name = "HKTD_SUPREME_V65"
local MainBtn = Instance.new("TextButton", SG)
MainBtn.Size = UDim2.fromOffset(260, 50); MainBtn.Position = UDim2.new(0.5, -130, 0.05, 0); MainBtn.BackgroundColor3 = Color3.fromRGB(15,15,15); MainBtn.Text = "HKTD HUB PREMIUM"; MainBtn.TextColor3 = Color3.new(1,1,1); MainBtn.Font = "GothamBold"; MainBtn.TextSize = 18; MainBtn.Visible = false; MainBtn.Draggable = true
Instance.new("UICorner", MainBtn).CornerRadius = UDim.new(0, 12); local ms = Instance.new("UIStroke", MainBtn); ms.Thickness = 3
task.spawn(function() while task.wait() do ms.Color = Color3.fromHSV(tick()%3/3, 1, 1) end end)

local function StartScript()
    local Window = Fluent:CreateWindow({ Title = "HKTD HUB PREMIUM", SubTitle = "Make By HKTD", TabWidth = 140, Size = UDim2.fromOffset(580, 520), Theme = "Dark", MinimizeKey = Enum.KeyCode.RightControl })
        local Tabs = {
        Status = Window:AddTab({ Title = "Thông báo", Icon = "info" }),
        Farm = Window:AddTab({ Title = "Auto farm", Icon = "skull" }),
        Gacha = Window:AddTab({ Title = "Random", Icon = "star" }),
        Tele = Window:AddTab({ Title = "Tele", Icon = "map" }),
        Config = Window:AddTab({ Title = "CONFIG", Icon = "settings" }),
        Lag = Window:AddTab({ Title = "FIX LAG", Icon = "zap" })
    }
    local AllIslands = {"Đảo 1","Đảo 2","Đảo 3","Đảo 4","Đảo 5","Đảo 6","Đảo 7","Đảo 8","Đảo 9"}
    -- STATUS     
    Tabs.Status:AddParagraph({ Title = "THÔNG TIN", Content = "Đã thêm Đảo 8, 9 và Tab Fix Lag Xi Măng.\nBản Mobile tối giản 1 nút CAST." })
    Tabs.Status:AddButton({ Title = "SERVER HOP", Callback = function() ServerHop() end })
    Tabs.Status:AddButton({ Title = "REJOIN SERVER", Callback = function() TeleportService:Teleport(game.PlaceId, Player) end })
    -- AUTO FARM
    Tabs.Farm:AddDropdown("Island", { Title = "CHỌN ĐẢO FARM", Values = AllIslands, Default = "Đảo 1", Callback = function(v) _G.SelectedIsland = v end })
    Tabs.Farm:AddToggle("Farm", {Title = "BẬT AUTO FARM", Default = false}):OnChanged(function(v) 
        _G.LemonAutoFarm = v 
        if v then task.spawn(function() SmoothMove(IslandData[_G.SelectedIsland].cf, IslandData[_G.SelectedIsland].rot) end) end
    end)
    Tabs.Farm:AddSection("BÁN CÁ")
    Tabs.Farm:AddToggle("AS", {Title = "Tự bán cá", Default = false}):OnChanged(function(v) _G.EnableAutoSell = v end)
    Tabs.Farm:AddSlider("TimeSell", { Title = "THỜI GIAN CHỜ BÁN", Default = 300, Min = 30, Max = 1200, Rounding = 0, Callback = function(v) _G.AutoSellTime = v end })
    Tabs.Farm:AddButton({Title = "BÁN CÁ NGAY", Callback = function() task.spawn(RunSellSequence) end})
    -- GACHA     
    Tabs.Gacha:AddButton({ Title = "🔥 QUAY random skill", Callback = function()
        for _, r in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
            if r:IsA("RemoteEvent") and (#r.Name <= 3 or r.Name:lower():find("gacha")) then pcall(function() r:FireServer() r:FireServer("Roll") end) end
        end
    end })
    Tabs.Tele:AddDropdown("ITele", { Title = "CHỌN ĐẢO CẦN ĐẾN", Values = AllIslands, Default = "Đảo 1", Callback = function(v) _G.TeleTarget = v end })
    Tabs.Tele:AddButton({ Title = "BẮT ĐẦU BAY", Callback = function() SmoothMove(IslandData[_G.TeleTarget].cf, IslandData[_G.TeleTarget].rot) end })
    Tabs.Config:AddInput("X", {Title = "X OFFSET", Default = "45", Callback = function(v) _G.X_Offset = tonumber(v) or 45 end})
    Tabs.Config:AddInput("Y", {Title = "Y OFFSET", Default = "46", Callback = function(v) _G.Y_Offset = tonumber(v) or 46 end})
    -- FIX LAG
    Tabs.Lag:AddToggle("FixLagXiMang", {Title = "FIX LAG XI MĂNG", Default = false}):OnChanged(function(v)
        if v then ApplyMaxFixLag() end
    end)
    MainBtn.MouseButton1Click:Connect(function() VIM:SendKeyEvent(true, Enum.KeyCode.RightControl, false, game); task.wait(0.05); VIM:SendKeyEvent(false, Enum.KeyCode.RightControl, false, game) end)
    MainBtn.Visible = true
end

-- --- INTRO (GIỮ NGUYÊN GỐC) ---
task.spawn(function()
    local Blur = Instance.new("BlurEffect", Lighting); Blur.Size = 0; Blur.Parent = Lighting
    local IntroLabel = Instance.new("TextLabel", SG)
    IntroLabel.Size = UDim2.fromScale(1, 1); IntroLabel.BackgroundTransparency = 1; IntroLabel.Font = "GothamBold"; IntroLabel.TextSize = 85; IntroLabel.TextColor3 = Color3.new(1, 1, 1); IntroLabel.Text = ""; IntroLabel.ZIndex = 100
    local UIStroke = Instance.new("UIStroke", IntroLabel); UIStroke.Thickness = 5; task.spawn(function() while IntroLabel.Parent do UIStroke.Color = Color3.fromHSV(tick()%3/3, 1, 1); task.wait() end end)
    TweenService:Create(Blur, TweenInfo.new(1), {Size = 60}):Play(); task.wait(1)
    local txt = "Huỳnh Phước Trọng"
    for i = 1, #txt do IntroLabel.Text = txt:sub(1, i); task.wait(0.08) end
    task.wait(1.5); TweenService:Create(Blur, TweenInfo.new(1), {Size = 0}):Play(); TweenService:Create(IntroLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    task.wait(0.8); IntroLabel:Destroy(); Blur:Destroy(); StartScript()
end)

-- --- HIỆN NÚT CAST (VÀ ẨN Z,X,C,V) ---
for name, pos in pairs(_G.P_Points) do
    local psg = Instance.new("ScreenGui", game.CoreGui); psg.Name = "HKTD_GUI_"..name
    local f = Instance.new("Frame", psg); f.Size = UDim2.fromOffset(45,45); f.Position = UDim2.fromOffset(pos.X-22, pos.Y-22); f.Active, f.Draggable = true, true; f.BackgroundColor3 = Color3.fromHSV(tick()%1, 1, 1); f.BackgroundTransparency = 0.4; Instance.new("UICorner", f).CornerRadius = UDim.new(1,0)
    local t = Instance.new("TextLabel", f); t.Size = UDim2.fromScale(1,1); t.Text = name; t.BackgroundTransparency = 1; t.Font = "GothamBold"; t.TextSize = 10; t.TextColor3 = Color3.new(1,1,1)
    
    f:GetPropertyChangedSignal("Position"):Connect(function() _G.P_Points[name] = f.AbsolutePosition + Vector2.new(22,22) end)
    
    -- ĐOẠN QUAN TRỌNG: CHỈ CHO NÚT CAST HIỆN LÊN
    RunService.RenderStepped:Connect(function() 
        if name == "CAST" then
            psg.Enabled = (not _G.LemonAutoFarm) and MainBtn.Visible 
        else
            psg.Enabled = false -- ẨN CÁC NÚT Z, X, C, V
        end
    end)
end

-- --- LOGIC AUTO FARM (BẤM PHÍM NGẦM CHO Z,X,C,V) ---
task.spawn(function()
    while task.wait(0.6) do
        if _G.LemonAutoFarm then pcall(function()
            if not Player.Character:FindFirstChildOfClass("Tool") then VIM:SendKeyEvent(true, Enum.KeyCode.One, false, game); task.wait(0.1); VIM:SendKeyEvent(false, Enum.KeyCode.One, false, game) end
            
            -- Danh sách phím cần thực hiện
            local keys = {
                {k="MOUSE", p=_G.P_Points.CAST},
                {k=Enum.KeyCode.Z, p=_G.P_Points.Z},
                {k=Enum.KeyCode.X, p=_G.P_Points.X},
                {k=Enum.KeyCode.C, p=_G.P_Points.C},
                {k=Enum.KeyCode.V, p=_G.P_Points.V}
            }
            
            for _, s in ipairs(keys) do
                if not _G.LemonAutoFarm then break end
                local tx, ty = s.p.X + _G.X_Offset, s.p.Y + _G.Y_Offset
                
                if s.k == "MOUSE" then 
                    
                    VIM:SendMouseButtonEvent(tx, ty, 0, true, game, 1); task.wait(0.05); VIM:SendMouseButtonEvent(tx, ty, 0, false, game, 1)
                else 
                   
                    VIM:SendKeyEvent(true, s.k, false, game); 
                    VIM:SendMouseButtonEvent(tx, ty, 0, true, game, 1); 
                    task.wait(0.05); 
                    VIM:SendKeyEvent(false, s.k, false, game); 
                    VIM:SendMouseButtonEvent(tx, ty, 0, false, game, 1) 
                end
                task.wait(0.1)
            end
        end) end
    end
end)

task.spawn(function()
    local lastSell = tick()
    while task.wait(1) do if _G.EnableAutoSell and (tick() - lastSell) >= _G.AutoSellTime then RunSellSequence(); lastSell = tick() end end
end)
