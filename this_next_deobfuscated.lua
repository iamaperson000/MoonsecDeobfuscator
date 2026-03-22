-- Deobfuscated with MoonSec V3 deobfuscator by #tupsutumppu

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local Colors = {
    DeepBlue = Color3.fromHex("373E40"),
    Blue     = Color3.fromHex("77878B"),
    Olive    = Color3.fromHex("305252"),
    Yellow   = Color3.fromHex("488286"),
    Red      = Color3.fromHex("B7D5D4"),
    White    = Color3.fromRGB(255, 255, 255),
}

-- Utility: get HumanoidRootPart from a character
local function getHRP(character)
    if not character then return nil end
    return character:FindFirstChild("HumanoidRootPart")
end

-- Utility: recursively remove borders from all GuiObjects
local function removeBorders(element)
    if element:IsA("GuiObject") then
        element.BorderSizePixel = 0
    end
    for _, child in ipairs(element:GetChildren()) do
        removeBorders(child)
    end
end

-- Utility: hover colour effect (restores original colour on leave)
local function setupHover(element, hoverColor)
    local originalColor = element.BackgroundColor3
    element.MouseEnter:Connect(function()
        element.BackgroundColor3 = hoverColor
    end)
    element.MouseLeave:Connect(function()
        element.BackgroundColor3 = originalColor
    end)
end

-- Opens a secondary morph-steal overlay GUI
local function openStealGui()
    local StealGui = Instance.new("ScreenGui")
    StealGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    StealGui.ResetOnSpawn = false
    StealGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    StealGui.DisplayOrder = 999

    local StealFrame = Instance.new("Frame")
    StealFrame.Size = UDim2.new(0, 300, 0, 180)
    StealFrame.Position = UDim2.new(0.7, -150, 0.3, -90)
    StealFrame.BackgroundColor3 = Colors.DeepBlue
    StealFrame.BorderSizePixel = 0
    StealFrame.ZIndex = 1000
    StealFrame.Active = true
    StealFrame.Draggable = true
    StealFrame.Parent = StealGui

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0, 220, 0, 30)
    TitleLabel.Position = UDim2.new(0.5, -110, 0, 15)
    TitleLabel.Text = "morph stealer 1.0"
    TitleLabel.TextColor3 = Colors.White
    TitleLabel.BackgroundTransparency = 0
    TitleLabel.BackgroundColor3 = Colors.Blue
    TitleLabel.TextScaled = true
    TitleLabel.Font = Enum.Font.SourceSans
    TitleLabel.BorderSizePixel = 0
    TitleLabel.Parent = StealFrame

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 25, 0, 25)
    CloseBtn.Position = UDim2.new(1, -30, 0, 5)
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.SourceSansBold
    CloseBtn.TextScaled = true
    CloseBtn.BackgroundColor3 = Colors.Red
    CloseBtn.TextColor3 = Colors.White
    CloseBtn.BorderSizePixel = 0
    CloseBtn.ZIndex = 1001
    CloseBtn.Parent = StealFrame
    CloseBtn.MouseButton1Click:Connect(function()
        StealGui:Destroy()
    end)
    setupHover(CloseBtn, Colors.Yellow)

    local NameBox = Instance.new("TextBox")
    NameBox.Size = UDim2.new(0, 280, 0, 40)
    NameBox.Position = UDim2.new(0, 10, 0, 65)
    NameBox.PlaceholderText = "user"
    NameBox.Text = ""
    NameBox.Font = Enum.Font.SourceSans
    NameBox.TextScaled = true
    NameBox.BackgroundTransparency = 0
    NameBox.BackgroundColor3 = Colors.Olive
    NameBox.TextColor3 = Colors.White
    NameBox.BorderSizePixel = 0
    NameBox.Parent = StealFrame
    setupHover(NameBox, Colors.Red)

    local StealBtn = Instance.new("TextButton")
    StealBtn.Size = UDim2.new(0, 280, 0, 40)
    StealBtn.Position = UDim2.new(0, 10, 0, 115)
    StealBtn.Text = "steal"
    StealBtn.Font = Enum.Font.SourceSans
    StealBtn.TextScaled = true
    StealBtn.BackgroundTransparency = 0
    StealBtn.BackgroundColor3 = Colors.Yellow
    StealBtn.TextColor3 = Colors.White
    StealBtn.BorderSizePixel = 0
    StealBtn.Parent = StealFrame
    setupHover(StealBtn, Colors.Blue)

    local CreditsLabel = Instance.new("TextLabel")
    CreditsLabel.Size = UDim2.new(0, 200, 0, 20)
    CreditsLabel.Position = UDim2.new(1, -210, 1, -25)
    CreditsLabel.BackgroundTransparency = 1
    CreditsLabel.Text = "TUTORIAL ON DISCORD!"
    CreditsLabel.TextColor3 = Colors.White
    CreditsLabel.TextScaled = false
    CreditsLabel.Font = Enum.Font.SourceSans
    CreditsLabel.TextSize = 13
    CreditsLabel.TextXAlignment = Enum.TextXAlignment.Right
    CreditsLabel.TextYAlignment = Enum.TextYAlignment.Bottom
    CreditsLabel.Parent = StealFrame

    StealBtn.MouseButton1Click:Connect(function()
        local targetName = NameBox.Text
        if targetName == "" then
            warn("enter player name")
            return
        end
        local editorRig = Workspace:FindFirstChild("EditorRig")
        if not editorRig then
            warn("editorrig not found...")
            return
        end
        local target = Workspace:FindFirstChild(targetName)
        if not target then
            warn("target not found")
            return
        end
        for _, child in ipairs(editorRig:GetChildren()) do
            child:Destroy()
        end
        for _, child in ipairs(target:GetChildren()) do
            child:Clone().Parent = editorRig
        end
        print("rig stolen from " .. targetName)
    end)
end

-- ── Main GUI ──────────────────────────────────────────────────────────────────

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CommandGui"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 240)
MainFrame.Position = UDim2.new(1, -340, 0.25, 0)
MainFrame.BackgroundColor3 = Colors.DeepBlue
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 12)
UICornerMain.Parent = MainFrame

-- Topbar ─────────────────────────────────────────────────────────────────────
local Topbar = Instance.new("Frame")
Topbar.Name = "Topbar"
Topbar.Size = UDim2.new(1, 0, 0, 36)
Topbar.BackgroundColor3 = Colors.Blue
Topbar.BorderSizePixel = 0
Topbar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -80, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "wcue fucker :3"
TitleLabel.TextColor3 = Colors.White
TitleLabel.TextSize = 20
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = Topbar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0.5, -15)
CloseButton.BackgroundColor3 = Colors.Red
CloseButton.Text = "X"
CloseButton.TextColor3 = Colors.White
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = Topbar
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0.5, -15)
MinimizeButton.BackgroundColor3 = Colors.Yellow
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Colors.White
MinimizeButton.TextSize = 24
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Parent = Topbar

-- Tab scroll bar ──────────────────────────────────────────────────────────────
local TabScroll = Instance.new("ScrollingFrame")
TabScroll.Name = "TabScroll"
TabScroll.Size = UDim2.new(1, 0, 0, 40)
TabScroll.Position = UDim2.new(0, 0, 0, 36)
TabScroll.BackgroundColor3 = Colors.DeepBlue
TabScroll.BorderSizePixel = 0
TabScroll.ScrollBarThickness = 0
TabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
TabScroll.AutomaticCanvasSize = Enum.AutomaticSize.X
TabScroll.ScrollingDirection = Enum.ScrollingDirection.X
TabScroll.Parent = MainFrame

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 4)
TabLayout.Parent = TabScroll

-- Content frame ───────────────────────────────────────────────────────────────
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 1, -76)
ContentFrame.Position = UDim2.new(0, 0, 0, 76)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

local UICornerContent = Instance.new("UICorner")
UICornerContent.CornerRadius = UDim.new(0, 10)
UICornerContent.Parent = ContentFrame

-- Tab system ──────────────────────────────────────────────────────────────────
local tabs = {}

local function createTab(name, color)
    local Button = Instance.new("TextButton")
    Button.Name = name .. "Tab"
    Button.Size = UDim2.new(0, 100, 1, -6)
    Button.BackgroundColor3 = color
    Button.Text = name
    Button.TextColor3 = Colors.White
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 16
    Button.Parent = TabScroll

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = Button

    local Frame = Instance.new("Frame")
    Frame.Name = name .. "Frame"
    Frame.Size = UDim2.new(1, 0, 1, 0)
    Frame.BackgroundTransparency = 1
    Frame.Visible = false
    Frame.Parent = ContentFrame

    tabs[name] = { Button = Button, Frame = Frame }

    Button.MouseButton1Click:Connect(function()
        for _, tab in pairs(tabs) do
            tab.Frame.Visible = false
        end
        Frame.Visible = true
    end)
end

createTab("Welcome",    Colors.DeepBlue)
createTab("Steal",      Colors.Olive)
createTab("Teleports",  Colors.Yellow)
createTab("Animations", Colors.Red)

-- Show Welcome tab by default
tabs["Welcome"].Frame.Visible = true

-- Welcome tab ─────────────────────────────────────────────────────────────────
local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Size = UDim2.new(1, -20, 1, -20)
WelcomeLabel.Position = UDim2.new(0, 10, 0, 10)
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.TextColor3 = Colors.White
WelcomeLabel.Text = "Welcome"
WelcomeLabel.TextSize = 24
WelcomeLabel.Font = Enum.Font.GothamBold
WelcomeLabel.TextWrapped = true
WelcomeLabel.Parent = tabs["Welcome"].Frame

-- Steal tab ───────────────────────────────────────────────────────────────────
local StealMorphBtn = Instance.new("TextButton")
StealMorphBtn.Size = UDim2.new(0, 180, 0, 40)
StealMorphBtn.Position = UDim2.new(0, 20, 0, 20)
StealMorphBtn.BackgroundColor3 = Colors.Olive
StealMorphBtn.Text = "Steal Morph"
StealMorphBtn.TextColor3 = Colors.White
StealMorphBtn.Font = Enum.Font.GothamBold
StealMorphBtn.TextSize = 16
StealMorphBtn.Parent = tabs["Steal"].Frame
StealMorphBtn.MouseButton1Click:Connect(openStealGui)

-- Teleports tab ───────────────────────────────────────────────────────────────
local function teleportTo(x, y, z)
    local hrp = getHRP(LocalPlayer.Character)
    if hrp then
        hrp.CFrame = CFrame.new(x, y, z)
    end
end

local EditorBtn = Instance.new("TextButton")
EditorBtn.Size = UDim2.new(0, 180, 0, 40)
EditorBtn.Position = UDim2.new(0, 20, 0, 20)
EditorBtn.BackgroundColor3 = Colors.Yellow
EditorBtn.Text = "Editor"
EditorBtn.TextColor3 = Colors.White
EditorBtn.Font = Enum.Font.GothamBold
EditorBtn.TextSize = 16
EditorBtn.Parent = tabs["Teleports"].Frame
EditorBtn.MouseButton1Click:Connect(function()
    teleportTo(-334, -388.45, -103)
end)

local BlackboxBtn = Instance.new("TextButton")
BlackboxBtn.Size = UDim2.new(0, 180, 0, 40)
BlackboxBtn.Position = UDim2.new(0, 20, 0, 70)
BlackboxBtn.BackgroundColor3 = Colors.Yellow
BlackboxBtn.Text = "Blackbox"
BlackboxBtn.TextColor3 = Colors.White
BlackboxBtn.Font = Enum.Font.GothamBold
BlackboxBtn.TextSize = 16
BlackboxBtn.Parent = tabs["Teleports"].Frame
BlackboxBtn.MouseButton1Click:Connect(function()
    teleportTo(-1412, 71.63, -330)
end)

local ShedBtn = Instance.new("TextButton")
ShedBtn.Size = UDim2.new(0, 180, 0, 40)
ShedBtn.Position = UDim2.new(0, 20, 0, 120)
ShedBtn.BackgroundColor3 = Colors.Yellow
ShedBtn.Text = "Shed"
ShedBtn.TextColor3 = Colors.White
ShedBtn.Font = Enum.Font.GothamBold
ShedBtn.TextSize = 16
ShedBtn.Parent = tabs["Teleports"].Frame
ShedBtn.MouseButton1Click:Connect(function()
    teleportTo(2396.011, 1417.638, 1575.984)
end)

-- Animations tab ──────────────────────────────────────────────────────────────
local PounceBtn = Instance.new("TextButton")
PounceBtn.Size = UDim2.new(0, 180, 0, 40)
PounceBtn.Position = UDim2.new(0, 20, 0, 20)
PounceBtn.BackgroundColor3 = Colors.Red
PounceBtn.Text = "Pounce"
PounceBtn.TextColor3 = Colors.White
PounceBtn.Font = Enum.Font.GothamBold
PounceBtn.TextSize = 16
PounceBtn.Parent = tabs["Animations"].Frame
PounceBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChildWhichIsA("Humanoid")
    if not humanoid then return end
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://12913965838"
    local track = humanoid:LoadAnimation(anim)
    track.Priority = Enum.AnimationPriority.Movement
    track:Play()
end)

-- Minimize toggle ─────────────────────────────────────────────────────────────
local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    TabScroll.Visible = not minimized
    ContentFrame.Visible = not minimized
    if minimized then
        MainFrame.Size = UDim2.new(0, 320, 0, 36)
    else
        MainFrame.Size = UDim2.new(0, 320, 0, 240)
    end
end)

-- Credits label ───────────────────────────────────────────────────────────────
local CreditsLabel = Instance.new("TextLabel")
CreditsLabel.Size = UDim2.new(1, -20, 0, 20)
CreditsLabel.Position = UDim2.new(0, 10, 1, -25)
CreditsLabel.BackgroundTransparency = 1
CreditsLabel.Text = "by microwaveyd / nico"
CreditsLabel.TextColor3 = Colors.White
CreditsLabel.TextScaled = false
CreditsLabel.Font = Enum.Font.Gotham
CreditsLabel.TextSize = 12
CreditsLabel.TextXAlignment = Enum.TextXAlignment.Right
CreditsLabel.Parent = MainFrame

-- Strip all borders from the GUI
removeBorders(ScreenGui)
