--Script By HKTD, TikTok: https://www.tiktok.com/@hktd_roblox

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- 🌌 INTRO GUI
local gui = Instance.new("ScreenGui")
gui.Name = "Intro"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Light Dark Background
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(0,0,0)
bg.BackgroundTransparency = 0.3
bg.Parent = gui

-- Logo Image
local logo = Instance.new("ImageLabel")
logo.Parent = gui
logo.AnchorPoint = Vector2.new(0.5,0.5)
logo.Position = UDim2.new(0.5,0,0.5,0)
logo.Size = UDim2.new(0,0,0,0)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://84167712411424"
logo.ImageTransparency = 1

-- Show Logo (Zoom + Fade In)
TweenService:Create(logo, TweenInfo.new(1.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
    Size = UDim2.new(0,200,0,200),
    ImageTransparency = 0
}):Play()

-- Rotate Logo
task.spawn(function()
    while logo.Parent do
        logo.Rotation = logo.Rotation + 0.5
        task.wait(0.01)
    end
end)

-- Text Below The Logo
local msg = Instance.new("TextLabel")
msg.Parent = gui
msg.AnchorPoint = Vector2.new(0.5,0)
msg.Position = UDim2.new(0.5,0,0.75,0)
msg.Size = UDim2.new(0,600,0,80)
msg.BackgroundTransparency = 1
msg.Text = "HKTD Scripts"
msg.TextColor3 = Color3.fromRGB(0,255,255)
msg.Font = Enum.Font.GothamBlack
msg.TextScaled = true
msg.TextStrokeTransparency = 0
msg.TextStrokeColor3 = Color3.fromRGB(0,0,0)
msg.TextTransparency = 1

-- The Word Fade In
TweenService:Create(msg, TweenInfo.new(1.2), {TextTransparency=0}):Play()

-- Hold Intro For 4 Seconds
task.wait(4)

-- Fade Out All
TweenService:Create(logo, TweenInfo.new(1.2), {ImageTransparency=1}):Play()
TweenService:Create(msg, TweenInfo.new(1.2), {TextTransparency=1}):Play()
TweenService:Create(bg, TweenInfo.new(1.2), {BackgroundTransparency=1}):Play()
task.wait(1.5)

gui:Destroy()

------------------------------------------------------------
-- 🎛 MAIN UI BUTTON
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local ImageButton = Instance.new("ImageButton")
ImageButton.Parent = ScreenGui
ImageButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
ImageButton.BorderSizePixel = 0
ImageButton.Position = UDim2.new(0.1,0,0.15,0)
ImageButton.Size = UDim2.new(0,40,0,40)
ImageButton.Draggable = true
ImageButton.Image = "rbxassetid://84167712411424"

local UICorner = Instance.new("UICorner")
UICorner.Parent = ImageButton
UICorner.CornerRadius = UDim.new(1,10)

ImageButton.MouseButton1Down:Connect(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.End,false,game)
end)

------------------------------------------------------------
-- 📦 LOAD FLUENT
repeat task.wait() until game:IsLoaded()
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title="HKTD Scripts Beta",
    SubTitle="By HKTD",
    TabWidth=157,
    Size=UDim2.fromOffset(450,300),
    Acrylic=true,
    Theme="Dark",
    MinimizeKey=Enum.KeyCode.End
})

-- Tabs
local Tabs = {
    Main0=Window:AddTab({Title="Info"}),
    Main1=Window:AddTab({Title="Blox Fruits"}),
    Main2=Window:AddTab({Title="Forsaken"}),
    Main3=Window:AddTab({Title="Evade"}),
    Main4=Window:AddTab({Title="Universal"})
}

-- Tab Info
Tabs.Main0:AddButton({
    Title="Blox Fruits Scripts Tổng Hợp",
    Description="Script By HKTD",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Roblox-Scripts/refs/heads/main/Blox-Fruits-Scripts.lua", true))()
    end
})
Tabs.Main0:AddButton({
    Title="My TikTok",
    Description="My Channel Is HKTD",
    Callback=function()
        setclipboard("https://tiktok.com/@hktd_roblox")
    end
})
Tabs.Main0:AddButton({
    Title="My Discord",
    Description="HKTD | COMMUNITY",
    Callback=function()
        setclipboard("https://discord.gg/RNgyh8MhxN")
    end
})

-- Tab 1: Blox Fruits
Tabs.Main1:AddButton({
    Title="HKTD Hub",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Blox-Fruits/refs/heads/main/HKTD-Hub.lua", true))()
    end
})
Tabs.Main1:AddButton({
    Title="Nagi Hub",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Blox-Fruits/refs/heads/main/Nagi-Hub.lua", true))()
    end
})
Tabs.Main1:AddButton({
    Title="TD Hub",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Blox-Fruits/refs/heads/main/TD-Hub.lua", true))()
    end
})
Tabs.Main1:AddButton({
    Title="HKTD Hub Menu Redz Beta",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Blox-Fruits/refs/heads/main/HKTD-Hub-Beta.lua", true))()
    end
})
Tabs.Main1:AddButton({
    Title="Zero Hub",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Blox-Fruits/refs/heads/main/Zero-Hub.lua", true))()
    end
})
Tabs.Main1:AddButton({
    Title="Auto Chest Beta",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Blox-Fruits/refs/heads/main/Auto-Chest-Beta.lua", true))()
    end
})

-- Tab Forsaken
Tabs.Main2:AddButton({
    Title="HKTD Hub",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Forsaken-Script/refs/heads/main/HKTD-Hub.lua", true))()
    end
})
Tabs.Main2:AddButton({
    Title="Auto Backstab V1",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Forsaken-Script/refs/heads/main/Auto-Backstab-V1.lua", true))()
    end
})
Tabs.Main2:AddButton({
    Title="Auto Backstab V2",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Forsaken-Script/refs/heads/main/Auto-Backstab-V2.lua", true))()
    end
})
Tabs.Main2:AddButton({
    Title="Auto Backstab V3",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Forsaken-Script/refs/heads/main/Auto-Backstab-V3.lua", true))()
    end
})
Tabs.Main2:AddButton({
    Title="Fake Block",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Forsaken-Script/refs/heads/main/Fake-Block.lua", true))()
    end
})
Tabs.Main2:AddButton({
    Title="Auto Block V1",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Forsaken-Script/refs/heads/main/Auto-Block-V1.lua", true))()
    end
})
Tabs.Main2:AddButton({
    Title="Auto Block V2",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Forsaken-Script/refs/heads/main/Auto-Block-V2.lua", true))()
    end
})
Tabs.Main2:AddButton({
    Title="Auto Block V3",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Forsaken-Script/refs/heads/main/Auto-Block-V3.lua", true))()
    end
})
Tabs.Main2:AddButton({
    Title="Auto Block V4",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Forsaken-Script/refs/heads/main/Auto-Block-V4.lua", true))()
    end
})
Tabs.Main2:AddButton({
    Title="Auto Slash Shedletsky",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Forsaken-Script/refs/heads/main/Auto-Slash.lua", true))()
    end
})
Tabs.Main2:AddButton({
    Title="Auto Trick Veeronica",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Forsaken-Script/refs/heads/main/Auto-Trick.lua", true))()
    end
})
Tabs.Main2:AddButton({
    Title="Chance Aimbot V1",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Forsaken-Script/refs/heads/main/Chance-Aimbot-V1.lua", true))()
    end
})
Tabs.Main2:AddButton({
    Title="Chance Aimbot V2",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Forsaken-Script/refs/heads/main/Chance-Aimbot-V2.lua", true))()
    end
})
Tabs.Main2:AddButton({
    Title="Elliot Pizza Aimbot",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Forsaken-Script/refs/heads/main/Elliot-Aimbot.lua", true))()
    end
})

-- Tab Evade
Tabs.Main4:AddButton({
    Title="Auto Event Farm",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Evade-Script/refs/heads/main/Event-Farm.lua", true))()
    end
})
Tabs.Main4:AddButton({
    Title="Auto E-Dash",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Evade-Script/refs/heads/main/Auto-E-Dash.lua", true))()
    end
})

-- Tab Universal
Tabs.Main4:AddButton({
    Title="Auto Clicker",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Universal-Script/refs/heads/main/Auto-Clicker.lua", true))()
    end
})
Tabs.Main4:AddButton({
    Title="Fly-Gui-V3",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Universal-Script/refs/heads/main/Wall-Hop-V1.lua", true))()
    end
})
Tabs.Main4:AddButton({
    Title="Fly-Gui-V4",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Universal-Script/refs/heads/main/Wall-Hop-V4.lua", true))()
    end
})
Tabs.Main4:AddButton({
    Title="Esp",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Universal-Script/refs/heads/main/Esp.lua", true))()
    end
})
Tabs.Main4:AddButton({
    Title="Wall Hop V1",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Universal-Script/refs/heads/main/Wall-Hop-V1.lua", true))()
    end
})
Tabs.Main4:AddButton({
    Title="Wall Hop V2",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Universal-Script/refs/heads/main/Wall-Hop-V2.lua", true))()
    end
})
Tabs.Main4:AddButton({
    Title="Wall Hop V3",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Universal-Script/refs/heads/main/Wall-Hop-V3.lua", true))()
    end
})
Tabs.Main4:AddButton({
    Title="Wall Hop V4",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Universal-Script/refs/heads/main/Wall-Hop-V4.lua", true))()
    end
})
Tabs.Main4:AddButton({
    Title="God Mode",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Universal-Script/refs/heads/main/God-Mode.lua", true))()
    end
})
Tabs.Main4:AddButton({
    Title="Hitbox Expander",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Universal-Script/refs/heads/main/Hitbox-Expander.lua", true))()
    end
})
Tabs.Main4:AddButton({
    Title="Infinite Jump",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Universal-Script/refs/heads/main/Infinite-Jump.lua", true))()
    end
})
Tabs.Main4:AddButton({
    Title="Noclip",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Universal-Script/refs/heads/main/Noclip.lua", true))()
    end
})
Tabs.Main4:AddButton({
    Title="Speed Hack",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Universal-Script/refs/heads/main/Speed-Hack.lua", true))()
    end
})
Tabs.Main4:AddButton({
    Title="Touch Fling",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Universal-Script/refs/heads/main/Touch-Fling.lua", true))()
    end
})
Tabs.Main4:AddButton({
    Title="FE-Sound",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Universal-Script/refs/heads/main/FE-Sound.lua", true))()
    end
})
Tabs.Main4:AddButton({
    Title="Fake Lag",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Universal-Script/refs/heads/main/Fake-Lag.lua", true))()
    end
})
Tabs.Main4:AddButton({
    Title="Teleport To Player",
    Callback=function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Universal-Script/refs/heads/main/TP-To-Player.lua", true))()
    end
})
