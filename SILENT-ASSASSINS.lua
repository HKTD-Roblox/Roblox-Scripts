local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/liebertsx/Tora-Library/main/src/librarynew", true))()
local window = library:CreateWindow("HKTD")

local Settings = {
    WalkSpeed = 16,
    JumpPower = 50,
    AutoEquip = true,
    KillAura = false,
    AuraRange = 20,
    ESP = false,
    BoxColor = Color3.fromRGB(0, 255, 0),
    TracerColor = Color3.fromRGB(255, 0, 0)
}

local lastSliderTime = 0
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local function Notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Icon = "rbxassetid://4483345998",
        Duration = 2
    })
    
    local s = Instance.new("Sound", game:GetService("SoundService"))
    s.SoundId = "rbxassetid://4590662766"
    s.Volume = 0.5
    s:Play()
    
    game:GetService("Debris"):AddItem(s, 2)
end

local function KillTarget(target, dist)
    local char = LocalPlayer.Character
    local tool = char and char:FindFirstChildOfClass("Tool")
    
    if not tool or not target:FindFirstChild("HumanoidRootPart") then 
        return 
    end
    
    local args = {
        [1] = "AttemptWeaponHit",
        [2] = {
            ["attackCycleData"] = {["knockbackMul"] = 1, ["slowMult"] = 0.2, ["slowTime"] = 1.5, ["lungeMul"] = 1, ["attackTime"] = 0.65},
            ["knockback"] = 50,
            ["shouldLock"] = true,
            ["slowTime"] = 1.5,
            ["shouldLunge"] = true,
            ["isCritical"] = true,
            ["weaponDefinition"] = {
                ["attackCycle"] = {
                    ["1"] = {["knockbackMul"] = 1, ["slowMult"] = 0.2, ["slowTime"] = 1.5, ["lungeMul"] = 1, ["attackTime"] = 0.65},
                    ["2"] = {["lungeMul"] = 1, ["slowMult"] = 0.2, ["slowTime"] = 1.5, ["knockbackMul"] = 1, ["attackTime"] = 0.65},
                    ["3"] = {["lungeMul"] = 0.75, ["slowMult"] = 0.2, ["slowTime"] = 1.5, ["knockbackMul"] = 1.5, ["attackTime"] = 0.716},
                    ["4"] = {["lungeMul"] = 2.25, ["slowTime"] = 1.5, ["slowMult"] = 0.2, ["knockbackMul"] = 2.25, ["attackTime"] = 0.983}
                },
                ["attackOrder"] = {"1", "2", "3", "4"}
            },
            ["attackCooldown"] = 0.01,
            ["shouldSlow"] = true,
            ["lungeKnockback"] = 55,
            ["hitboxSize"] = Vector3.new(120, 120, 120),
            ["slowMult"] = 0.01,
            ["cycleIndex"] = 1,
            ["hitboxOffset"] = Vector3.new(0, 0, 0),
            ["tool"] = tool,
            ["damage"] = 1000
        },
        [3] = {
            [1] = {
                ["direction"] = (target.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Unit,
                ["isClosestEnemy"] = true,
                ["origin"] = char.HumanoidRootPart.Position,
                ["enemyModel"] = target,
                ["distance"] = dist,
                ["knockback"] = 0
            }
        }
    }
    
    task.spawn(function()
        ReplicatedStorage.Events.GameRemoteFunction:InvokeServer(unpack(args))
    end)
end

local function createESP(player)
    local box = Drawing.new("Square")
    local tracer = Drawing.new("Line")
    local nameTag = Drawing.new("Text")

    box.Visible = false
    box.Thickness = 1.5
    box.Transparency = 1
    box.Filled = false

    tracer.Visible = false
    tracer.Thickness = 1
    tracer.Transparency = 1

    nameTag.Visible = false
    nameTag.Size = 16
    nameTag.Center = true
    nameTag.Outline = true

    local function updateColors()
        if player.TeamColor then
            nameTag.Color = player.TeamColor.Color
            box.Color = player.TeamColor.Color
            tracer.Color = player.TeamColor.Color
        else
            nameTag.Color = Color3.fromRGB(255, 255, 255)
            box.Color = Settings.BoxColor
            tracer.Color = Settings.TracerColor
        end
    end

    updateColors()
    player:GetPropertyChangedSignal("Team"):Connect(updateColors)

    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not player or player.Parent == nil then
            box:Remove()
            tracer:Remove()
            nameTag:Remove()
            connection:Disconnect()
            return
        end

        local character = player.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        local humanoid = character and character:FindFirstChild("Humanoid")

        if Settings.ESP and rootPart and humanoid and humanoid.Health > 0 and player ~= LocalPlayer then
            local pos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
            
            if onScreen then
                local size = Vector2.new(2000 / pos.Z, 2500 / pos.Z)
                
                box.Size = size
                box.Position = Vector2.new(pos.X - size.X / 2, pos.Y - size.Y / 2)
                box.Visible = true

                tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                tracer.To = Vector2.new(pos.X, pos.Y + (size.Y / 2))
                tracer.Visible = true

                nameTag.Position = Vector2.new(pos.X, pos.Y - (size.Y / 2) - 20)
                nameTag.Text = player.Name
                nameTag.Visible = true
            else
                box.Visible = false
                tracer.Visible = false
                nameTag.Visible = false
            end
        else
            box.Visible = false
            tracer.Visible = false
            nameTag.Visible = false
        end
    end)
end

for _, p in pairs(Players:GetPlayers()) do
    createESP(p)
end

Players.PlayerAdded:Connect(createESP)

task.spawn(function()
    while true do
        if Settings.KillAura then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                for _, v in pairs(Players:GetPlayers()) do
                    if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                        local dist = (char.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                        if dist < Settings.AuraRange then
                            KillTarget(v.Character, dist)
                        end
                    end
                end
            end
        end
        task.wait(0.01)
    end
end)

RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
        char.Humanoid.WalkSpeed = Settings.WalkSpeed
        char.Humanoid.JumpPower = Settings.JumpPower
        
        if Settings.AutoEquip then
            local bp = LocalPlayer:FindFirstChild("Backpack")
            if bp then
                local tool = bp:FindFirstChildOfClass("Tool")
                if tool then 
                    tool.Parent = char 
                end
            end
        end
    end
end)

local mTab = window:AddFolder("Movement & Combat")

mTab:AddToggle({
    text = "Auto Equip Sword", 
    state = true, 
    callback = function(v) 
        Settings.AutoEquip = v 
        Notify("COMBAT", "Auto Equip: " .. (v and "ON" or "OFF"))
    end
})

mTab:AddToggle({
    text = "ESP", 
    state = false, 
    callback = function(v) 
        Settings.ESP = v 
        Notify("VISUAL", "ESP: " .. (v and "ON" or "OFF")) 
    end
})

mTab:AddSlider({
    text = "Walk Speed", 
    min = 16, 
    max = 200, 
    callback = function(v) 
        Settings.WalkSpeed = v 
        local t = tick() 
        lastSliderTime = t
        task.delay(0.3, function() 
            if lastSliderTime == t then 
                Notify("MOVEMENT", "Speed: " .. math.floor(v)) 
            end 
        end)
    end
})

mTab:AddSlider({
    text = "Jump Power", 
    min = 50, 
    max = 300, 
    callback = function(v) 
        Settings.JumpPower = v 
        local t = tick() 
        lastSliderTime = t
        task.delay(0.3, function() 
            if lastSliderTime == t then 
                Notify("MOVEMENT", "Jump: " .. math.floor(v)) 
            end 
        end)
    end
})

local fTab = window:AddFolder("Farm")

fTab:AddToggle({
    text = "KillAura", 
    state = false, 
    callback = function(v) 
        Settings.KillAura = v 
        Notify("COMBAT", "Aura: " .. (v and "ON" or "OFF")) 
    end
})

fTab:AddSlider({
    text = "Aura Range", 
    min = 10, 
    max = 10000, 
    callback = function(v) 
        Settings.AuraRange = v 
        local t = tick() 
        lastSliderTime = t
        task.delay(0.3, function() 
            if lastSliderTime == t then 
                Notify("COMBAT", "Range: " .. math.floor(v)) 
            end 
        end)
    end
})

local iTab = window:AddFolder("Credit & Info")

iTab:AddLabel({text = "Make By HKTD"})

iTab:AddButton({
    text = "Copy Link TikTok", 
    callback = function() 
        setclipboard("https://www.tiktok.com/@hktd_roblox") 
        Notify("DISCORD", "Link Copied to Clipboard!") 
    end

iTab:AddButton({
    text = "Copy Link Discord", 
    callback = function() 
        setclipboard("https://discord.gg/RNgyh8MhxN") 
        Notify("TIKTOK", "Link Copied to Clipboard!") 
    end
})

library:Init()
