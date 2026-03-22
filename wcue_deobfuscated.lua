-- Deobfuscated with MoonSec V3 deobfuscator by #tupsutumppu

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Size = UDim2.new(0, 300, 0, 180)
ImageLabel.Position = UDim2.new(0.7, -150, 0.3, -90)
ImageLabel.BackgroundTransparency = 1
ImageLabel.Image = "rbxassetid://77692682891668"
ImageLabel.Parent = ScreenGui
ImageLabel.ZIndex = 1000

local UICorner1 = Instance.new("UICorner")
UICorner1.CornerRadius = UDim.new(0, 25)
UICorner1.Parent = ImageLabel

ImageLabel.Active = true
ImageLabel.Draggable = true

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 220, 0, 30)
TitleLabel.Position = UDim2.new(0.5, -110, 0, 15)
TitleLabel.Text = "WCUE FUCKER! 1.0"
TitleLabel.TextColor3 = Color3.new(0, 0, 0)
TitleLabel.BackgroundTransparency = 0.2
TitleLabel.BackgroundColor3 = Color3.new(1, 1, 1)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.SourceSans
TitleLabel.BorderSizePixel = 0
TitleLabel.Parent = ImageLabel

local UICorner2 = Instance.new("UICorner")
UICorner2.CornerRadius = UDim.new(0, 15)
UICorner2.Parent = TitleLabel

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0, 280, 0, 40)
TextBox.Position = UDim2.new(0, 10, 0, 65)
TextBox.PlaceholderText = "user"
TextBox.Text = ""
TextBox.Font = Enum.Font.SourceSans
TextBox.TextScaled = true
TextBox.BackgroundTransparency = 0.7
TextBox.BackgroundColor3 = Color3.new(1, 1, 1)
TextBox.TextColor3 = Color3.new(0, 0, 0)
TextBox.BorderSizePixel = 2
TextBox.BorderColor3 = Color3.new(0, 0, 0)
TextBox.Parent = ImageLabel

local UICorner3 = Instance.new("UICorner")
UICorner3.CornerRadius = UDim.new(0, 15)
UICorner3.Parent = TextBox

local StealButton = Instance.new("TextButton")
StealButton.Size = UDim2.new(0, 280, 0, 40)
StealButton.Position = UDim2.new(0, 10, 0, 115)
StealButton.Text = "steal"
StealButton.Font = Enum.Font.SourceSans
StealButton.TextScaled = true
StealButton.BackgroundTransparency = 0.7
StealButton.BackgroundColor3 = Color3.new(100, 100, 100)
StealButton.TextColor3 = Color3.new(0, 0, 0)
StealButton.BorderSizePixel = 2
StealButton.BorderColor3 = Color3.new(0, 0, 0)
StealButton.Parent = ImageLabel

local UICorner4 = Instance.new("UICorner")
UICorner4.CornerRadius = UDim.new(0, 15)
UICorner4.Parent = StealButton

local function setupHover(element)
	element.MouseEnter:Connect(function()
		element.BackgroundTransparency = 0.5
	end)
	element.MouseLeave:Connect(function()
		element.BackgroundTransparency = 0.7
	end)
end

setupHover(TextBox)
setupHover(StealButton)

local CreditsLabel = Instance.new("TextLabel")
CreditsLabel.Size = UDim2.new(0, 200, 0, 20)
CreditsLabel.Position = UDim2.new(1, -210, 1, -25)
CreditsLabel.BackgroundTransparency = 1
CreditsLabel.Text = "by microwaveyd / nico"
CreditsLabel.TextColor3 = Color3.new(0, 0, 0)
CreditsLabel.TextScaled = false
CreditsLabel.Font = Enum.Font.SourceSans
CreditsLabel.TextSize = 13
CreditsLabel.TextXAlignment = Enum.TextXAlignment.Right
CreditsLabel.TextYAlignment = Enum.TextYAlignment.Bottom
CreditsLabel.Parent = ImageLabel

StealButton.MouseButton1Click:Connect(function()
	local targetName = TextBox.Text
	if targetName == "" then
		warn("enter player name")
		return
	end

	local editorRig = Workspace:FindFirstChild("EditorRig")
	if not editorRig then
		warn("editorrig not found")
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

	print("EditorRig updated from " .. targetName)
end)
