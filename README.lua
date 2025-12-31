local player = game.Players.LocalPlayer
local tweenService = game:GetService("TweenService")

-- GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.ResetOnSpawn = false
screenGui.Name = "WaveLagGUI"

-- Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

-- Close Button
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 4)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

-- Lag Them Button
local lagBtn = Instance.new("TextButton", mainFrame)
lagBtn.Size = UDim2.new(0, 140, 0, 40)
lagBtn.Position = UDim2.new(0.5, -70, 0.5, -20)
lagBtn.AnchorPoint = Vector2.new(0.5, 0.5)
lagBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 75)
lagBtn.Text = "Lag Them"
lagBtn.TextColor3 = Color3.new(1,1,1)
lagBtn.Font = Enum.Font.Gotham
lagBtn.TextSize = 16
Instance.new("UICorner", lagBtn).CornerRadius = UDim.new(0, 6)

-- Highlight Frame
local highlight = Instance.new("Frame", lagBtn)
highlight.Size = UDim2.new(1, 0, 1, 0)
highlight.BackgroundColor3 = Color3.new(1, 1, 1)
highlight.BackgroundTransparency = 1
highlight.ZIndex = 2
Instance.new("UICorner", highlight).CornerRadius = UDim.new(0, 6)

-- Open Animation
mainFrame.Size = UDim2.new(0, 0, 0, 0)
tweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 300, 0, 200)
}):Play()

-- Close
closeBtn.MouseButton1Click:Connect(function()
    local tween = tweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0)
    })
    tween:Play()
    tween.Completed:Connect(function()
        screenGui:Destroy()
    end)
end)

-- Lag Action
lagBtn.MouseButton1Click:Connect(function()
    tweenService:Create(highlight, TweenInfo.new(0.15), {BackgroundTransparency = 0.6}):Play()
    task.delay(0.85, function()
        tweenService:Create(highlight, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    end)

    local char = player.Character or player.CharacterAdded:Wait()
    local tools = {}

    for _, tool in ipairs(player.Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            tool.Parent = char
            table.insert(tools, tool)
        end
    end

    task.wait(0.3)

    for _, tool in ipairs(tools) do
        coroutine.wrap(function()
            while tool and tool.Parent == char do
                pcall(function() tool:Activate() end)
                task.wait(0.1)
            end
        end)()
    end
end)
