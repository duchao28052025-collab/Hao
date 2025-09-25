-- LocalScript (dán vào StarterGui)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Thay bằng asset id của logo/phượng hoàng nếu muốn
local DRAGON_IMAGE = "rbxassetid://DRAGON_IMAGE_ID"
local PHOENIX1_IMAGE = "rbxassetid://PHOENIX1_ID"
local PHOENIX2_IMAGE = "rbxassetid://PHOENIX2_ID"

-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DragonMenuGui_Loadstring"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main frame
local container = Instance.new("Frame")
container.Size = UDim2.new(0, 460, 0, 260)
container.AnchorPoint = Vector2.new(0.5, 0.5)
container.Position = UDim2.new(0.5, 0.32, 0, 0)
container.BackgroundTransparency = 1
container.Parent = screenGui

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.Position = UDim2.new(0, 0, 0, 0)
bg.BackgroundColor3 = Color3.fromRGB(18,18,20)
bg.BorderSizePixel = 0
bg.Parent = container
bg.ClipsDescendants = true

-- Logo as button
local logoSize = 120
local logo = Instance.new("ImageButton")
logo.Name = "DragonLogo"
logo.Size = UDim2.new(0, logoSize, 0, logoSize)
logo.Position = UDim2.new(0.06, 0, 0.18, 0)
logo.BackgroundTransparency = 1
logo.Image = DRAGON_IMAGE
logo.Parent = bg

-- Phoenix images orbiting
local phoenix1 = Instance.new("ImageLabel")
phoenix1.Size = UDim2.new(0, 48, 0, 48)
phoenix1.AnchorPoint = Vector2.new(0.5,0.5)
phoenix1.Position = logo.Position
phoenix1.Image = PHOENIX1_IMAGE
phoenix1.BackgroundTransparency = 1
phoenix1.Parent = bg

local phoenix2 = phoenix1:Clone()
phoenix2.Image = PHOENIX2_IMAGE
phoenix2.Parent = bg

-- Panel nhập / load script (ẩn ban đầu)
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 340, 0, 240)
panel.Position = UDim2.new(0.35, 0, 0.15, 0)
panel.BackgroundColor3 = Color3.fromRGB(30,30,30)
panel.BorderSizePixel = 0
panel.Visible = false
panel.Parent = bg

local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, 0, 0, 34)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(40,40,40)
header.TextColor3 = Color3.fromRGB(240,240,240)
header.Font = Enum.Font.GothamBold
header.TextSize = 16
header.Text = "Script Runner (loadstring)"
header.Parent = panel

-- Tabs
local tabHolder = Instance.new("Frame")
tabHolder.Size = UDim2.new(1, 0, 0, 36)
tabHolder.Position = UDim2.new(0, 0, 0, 36)
tabHolder.BackgroundTransparency = 1
tabHolder.Parent = panel

local pasteTab = Instance.new("TextButton")
pasteTab.Size = UDim2.new(0.5, -2, 1, 0)
pasteTab.Position = UDim2.new(0, 0, 0, 0)
pasteTab.Text = "Paste"
pasteTab.Font = Enum.Font.Gotham
pasteTab.TextSize = 14
pasteTab.BackgroundColor3 = Color3.fromRGB(55,55,55)
pasteTab.TextColor3 = Color3.fromRGB(230,230,230)
pasteTab.Parent = tabHolder

local loadTab = pasteTab:Clone()
loadTab.Position = UDim2.new(0.5, 4, 0, 0)
loadTab.Text = "Load"
loadTab.Parent = tabHolder

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -16, 1, -106)
content.Position = UDim2.new(0, 8, 0, 78)
content.BackgroundTransparency = 1
content.Parent = panel

-- Paste box
local pasteBox = Instance.new("TextBox")
pasteBox.Size = UDim2.new(1, 0, 1, 0)
pasteBox.Position = UDim2.new(0, 0, 0, 0)
pasteBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
pasteBox.TextColor3 = Color3.fromRGB(200,200,200)
pasteBox.ClearTextOnFocus = false
pasteBox.MultiLine = true
pasteBox.Font = Enum.Font.Code
pasteBox.TextSize = 14
pasteBox.Text = "-- Paste Lua code here (loadstring will run it)"
pasteBox.Parent = content

-- Load area
local loadArea = Instance.new("Frame")
loadArea.Size = UDim2.new(1, 0, 1, 0)
loadArea.BackgroundTransparency = 1
loadArea.Visible = false
loadArea.Parent = content

local loadLabel = Instance.new("TextLabel")
loadLabel.Size = UDim2.new(1, 0, 0, 20)
loadLabel.Position = UDim2.new(0, 0, 0, 0)
loadLabel.BackgroundTransparency = 1
loadLabel.TextColor3 = Color3.fromRGB(220,220,220)
loadLabel.Font = Enum.Font.Gotham
loadLabel.TextSize = 14
loadLabel.Text = "ModuleScript name (ReplicatedStorage/ServerStorage) or URL"
loadLabel.Parent = loadArea

local loadInput = Instance.new("TextBox")
loadInput.Size = UDim2.new(1, 0, 0, 28)
loadInput.Position = UDim2.new(0, 0, 0, 26)
loadInput.BackgroundColor3 = Color3.fromRGB(42,42,42)
loadInput.TextColor3 = Color3.fromRGB(230,230,230)
loadInput.ClearTextOnFocus = false
loadInput.Font = Enum.Font.Code
loadInput.TextSize = 14
loadInput.PlaceholderText = "e.g. MyModuleScript  or  https://example.com/script.lua"
loadInput.Parent = loadArea

-- Buttons
local runButton = Instance.new("TextButton")
runButton.Size = UDim2.new(0, 86, 0, 34)
runButton.Position = UDim2.new(0.02, 0, 1, -42)
runButton.Text = "Run (loadstring)"
runButton.Font = Enum.Font.GothamBold
runButton.TextSize = 14
runButton.BackgroundColor3 = Color3.fromRGB(80,80,80)
runButton.TextColor3 = Color3.fromRGB(240,240,240)
runButton.Parent = panel

local loadButton = runButton:Clone()
loadButton.Position = UDim2.new(0.31, 0, 1, -42)
loadButton.Text = "Load"
loadButton.Parent = panel

local closeButton = runButton:Clone()
closeButton.Position = UDim2.new(0.7, 0, 1, -42)
closeButton.Text = "Close"
closeButton.Parent = panel

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 18)
status.Position = UDim2.new(0, 10, 1, -18)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.fromRGB(200,200,200)
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.Text = ""
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = panel

-- Tab logic
local function setTab(which)
    if which == "paste" then
        pasteBox.Visible = true
        loadArea.Visible = false
        pasteTab.BackgroundColor3 = Color3.fromRGB(55,55,55)
        loadTab.BackgroundColor3 = Color3.fromRGB(45,45,45)
    else
        pasteBox.Visible = false
        loadArea.Visible = true
        pasteTab.BackgroundColor3 = Color3.fromRGB(45,45,45)
        loadTab.BackgroundColor3 = Color3.fromRGB(55,55,55)
    end
end
setTab("paste")
pasteTab.MouseButton1Click:Connect(function() setTab("paste") end)
loadTab.MouseButton1Click:Connect(function() setTab("load") end)

-- Toggle panel by clicking logo
local panelOpen = false
logo.MouseButton1Click:Connect(function()
    panelOpen = not panelOpen
    panel.Visible = panelOpen
    status.Text = ""
end)
closeButton.MouseButton1Click:Connect(function()
    panel.Visible = false
    panelOpen = false
end)

-- Helper: find module
local function findModuleByName(name)
    if not name or name == "" then return nil end
    local function tryContainer(container)
        if not container then return nil end
        local v = container:FindFirstChild(name)
        if v and v:IsA("ModuleScript") then return v end
        return nil
    end
    return tryContainer(ReplicatedStorage) or tryContainer(ServerStorage)
end

-- Safety & loadstring execution
local MAX_CODE_LENGTH = 15000

local function isStudio()
    return RunService:IsStudio()
end

local function executeWithLoadstring(code)
    if not code or code == "" then
        status.Text = "No code provided."
        return
    end
    if #code > MAX_CODE_LENGTH then
        status.Text = "Code quá dài (> "..tostring(MAX_CODE_LENGTH).." kí tự)."
        return
    end

    if type(loadstring) ~= "function" then
        status.Text = "loadstring không khả dụng ở môi trường này."
        return
    end

    -- Thực thi an toàn bằng pcall
    local fn, compileErr = loadstring(code)
    if not fn then
        status.Text = "Lỗi biên dịch: "..tostring(compileErr)
        return
    end

    -- Tùy chọn: đặt môi trường riêng (nếu setfenv khả dụng)
    -- Cẩn trọng: setfenv có thể là nil trong môi trường hiện đại của Roblox.
    if type(setfenv) == "function" then
        -- Tạo sandbox môi trường nhẹ (chỉ cho ví dụ)
        local sandbox = {}
        -- Cho phép một số API an toàn nếu anh muốn (ví dụ math, string)
        sandbox.math = math
        sandbox.string = string
        sandbox.pairs = pairs
        sandbox.ipairs = ipairs
        sandbox.print = print
        -- Nếu muốn truy cập game/players thì thêm: sandbox.game = game (nhưng đó là quyền rộng)
        -- Gán environment
        pcall(function() setfenv(fn, sandbox) end)
    end

    local ok, result = pcall(fn)
    if not ok then
        status.Text = "Lỗi khi chạy: "..tostring(result)
    else
        status.Text = "Chạy thành công."
    end
end

-- Run button (paste tab) => dùng loadstring
runButton.MouseButton1Click:Connect(function()
    status.Text = ""
    if not panelOpen then
        status.Text = "Mở panel trước."
        return
    end
    if not pasteBox.Visible then
        status.Text = "Chuyển sang tab Paste để chạy code dán tay."
        return
    end

    local code = pasteBox.Text or ""
    executeWithLoadstring(code)
end)

-- Load button (module name or URL)
loadButton.MouseButton1Click:Connect(function()
    status.Text = ""
    if not panelOpen then
        status.Text = "Mở panel trước."
        return
    end

    local target = loadInput.Text or ""
    target = target:match("^%s*(.-)%s*$") or ""

    if target == "" then
        status.Text = "Nhập tên ModuleScript hoặc URL."
        return
    end

    if target:match("^https?://") then
        if not isStudio() then
            status.Text = "Tải từ URL chỉ cho phép trong Roblox Studio."
            return
        end
        -- Tải nội dung
        local ok, body = pcall(function()
            return HttpService:GetAsync(target, true)
        end)
        if not ok then
            status.Text = "Lỗi khi tải URL: "..tostring(body)
            return
        end
        if #body > MAX_CODE_LENGTH then
            status.Text = "File tải về quá lớn."
            return
        end
        executeWithLoadstring(body)
        return
    end

    -- Nếu là ModuleScript thì require như trước (an toàn hơn)
    local module = findModuleByName(target)
    if module then
        local ok, res = pcall(function() return require(module) end)
        if not ok then
            status.Text = "Lỗi require ModuleScript: "..tostring(res)
            return
        end
        -- Nếu muốn, nếu module trả về string -> treat as code và chạy bằng loadstring
        if type(res) == "string" then
            executeWithLoadstring(res)
            return
        end
        if type(res) == "function" then
            local ok2, r2 = pcall(res)
            if not ok2 then
                status.Text = "Lỗi khi chạy function từ Module: "..tostring(r2)
            else
                status.Text = "Module function chạy thành công."
            end
            return
        end
        if type(res) == "table" and type(res.run) == "function" then
            local ok3, r3 = pcall(res.run)
            if not ok3 then
                status.Text = "Lỗi khi gọi run(): "..tostring(r3)
            else
                status.Text = "Module.run() chạy thành công."
            end
            return
        end
        status.Text = "Module trả về giá trị không thể chạy (function/table.run/string)."
        return
    else
        status.Text = "Không tìm thấy ModuleScript tên '"..target.."'."
        return
    end
end)

-- Orbit logic cho phượng hoàng
local startTime = tick()
RunService.RenderStepped:Connect(function()
    local t = tick() - startTime
    local orbitCenter = Vector2.new(logo.AbsolutePosition.X + logo.AbsoluteSize.X/2, logo.AbsolutePosition.Y + logo.AbsoluteSize.Y/2)
    local r1 = 70
    local speed1 = 1.0
    local angle1 = t * speed1 * math.pi * 2
    local x1 = orbitCenter.X + math.cos(angle1) * r1
    local y1 = orbitCenter.Y + math.sin(angle1) * (r1 * 0.7)
    phoenix1.Position = UDim2.new(0, x1 - bg.AbsolutePosition.X, 0, y1 - bg.AbsolutePosition.Y)
    phoenix1.Rotation = (angle1 * 180/math.pi) % 360

    local r2 = 48
    local speed2 = 0.8
    local angle2 = -t * speed2 * math.pi * 2 + math.pi/4
    local x2 = orbitCenter.X + math.cos(angle2) * r2
    local y2 = orbitCenter.Y + math.sin(angle2) * (r2 * 0.9)
    phoenix2.Position = UDim2.new(0, x2 - bg.AbsolutePosition.X, 0, y2 - bg.AbsolutePosition.Y)
    phoenix2.Rotation = (angle2 * 180/math.pi) % 360
end)

-- Hint
local hint = Instance.new("TextLabel")
hint.Size = UDim2.new(0, 420, 0, 18)
hint.Position = UDim2.new(0, 20, 1, -24)
hint.BackgroundTransparency = 1
hint.Text = "Chú ý: loadstring chỉ dùng được trong Studio; ModuleScript được khuyến nghị."
hint.TextColor3 = Color3.fromRGB(160,160,160)
hint.Font = Enum.Font.Gotham
hint.TextSize = 12
hint.TextXAlignment = Enum.TextXAlignment.Left
hint.Parent = bg

-- Kết thúc
