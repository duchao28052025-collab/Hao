-- Auto Jump Script với GUI
local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoJumpGui"
screenGui.Parent = CoreGui

-- Tạo nút bấm
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 120, 0, 40)
button.Position = UDim2.new(0.05, 0, 0.1, 0)
button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Text = "Auto Jump: OFF"
button.Parent = screenGui
button.Font = Enum.Font.SourceSansBold
button.TextSize = 18
button.AutoButtonColor = true
button.BackgroundTransparency = 0.2
button.BorderSizePixel = 2
button.BorderColor3 = Color3.fromRGB(200, 200, 200)

-- Trạng thái auto jump
local autoJump = false

-- Sự kiện click nút
button.MouseButton1Click:Connect(function()
    autoJump = not autoJump
    if autoJump then
        button.Text = "Auto Jump: ON"
        button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        button.Text = "Auto Jump: OFF"
        button.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    end
end)

-- Loop nhảy
task.spawn(function()
    while true do
        if autoJump and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
        task.wait(0.2) -- tốc độ spam nhảy
    end
end)
