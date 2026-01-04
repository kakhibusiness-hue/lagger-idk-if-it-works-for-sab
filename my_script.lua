local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 600, 0, 400)
Frame.Position = UDim2.new(0.5, -300, 0.5, -200)
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.BorderSizePixel = 0

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "Wave Executor - Secure Console"
Title.TextColor3 = Color3.fromRGB(0, 255, 0)
Title.Font = Enum.Font.Code
Title.TextSize = 28

local NameBox = Instance.new("TextBox", Frame)
NameBox.Position = UDim2.new(0, 10, 0, 60)
NameBox.Size = UDim2.new(1, -20, 0, 40)
NameBox.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
NameBox.TextColor3 = Color3.fromRGB(0, 255, 0)
NameBox.PlaceholderText = "Enter Player Username..."
NameBox.Font = Enum.Font.Code
NameBox.TextSize = 18
NameBox.ClearTextOnFocus = false

local Button = Instance.new("TextButton", Frame)
Button.Position = UDim2.new(0, 10, 0, 110)
Button.Size = UDim2.new(1, -20, 0, 40)
Button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
Button.Text = "DDOS THEM"
Button.Font = Enum.Font.Code
Button.TextSize = 20
Button.TextColor3 = Color3.fromRGB(0, 0, 0)

local function blackout(username)
	local blackScreen = Instance.new("Frame", ScreenGui)
	blackScreen.BackgroundColor3 = Color3.new(0, 0, 0)
	blackScreen.Size = UDim2.new(1, 0, 1, 0)
	blackScreen.Position = UDim2.new(0, 0, 0, 0)
	blackScreen.ZIndex = 10

	local msg = Instance.new("TextLabel", blackScreen)
	msg.Size = UDim2.new(1, 0, 1, 0)
	msg.BackgroundTransparency = 1
	msg.Text = "ddosing " .. username .. ".\nF SOCIETY IS WITH U"
	msg.TextColor3 = Color3.new(0, 1, 0)
	msg.Font = Enum.Font.Code
	msg.TextSize = 36
	msg.TextWrapped = true
	msg.ZIndex = 11

	wait(2)

	msg.Text = "F SOCIETY IS WITH YOU"
	msg.TextSize = 48

	for i = 1, 100 do
		msg.TextTransparency = i / 100
		wait(0.02)
	end

	blackScreen:Destroy()
end

local function flingPlayer(plr)
	local char = plr.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	local root = char:FindFirstChild("HumanoidRootPart")

	local origPos = root.CFrame
	root.Velocity = Vector3.new(0, 200, 0)
	wait(0.3)
	root.CFrame = origPos
end

Button.MouseButton1Click:Connect(function()
	local target = NameBox.Text
	local plr = Players:FindFirstChild(target)
	if plr and plr ~= LocalPlayer then
		blackout(target)
		flingPlayer(plr)
	end
end)
