-- 加载 Fluent UI (如果卡顿，可以尝试加代理: https://ghproxy.com/https://raw.githubusercontent.com/...)
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Init.lua"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- ===================== 核心状态 =====================
local State = {
    MaxDistance = 500, ESP_Players = false, ESP_NPCs = false, ESP_Items = false,
    DrawBox = true, DrawLine = true, DrawName = true, DrawHealth = true, DrawDistance = true,
    WalkSpeed = 16, JumpPower = 50, Noclip = false, 
    Fly = false, FlySpeed = 60, InfiniteJump = false, GodMode = false,
    CustomItems = {"gold", "copper", "diamond", "scrap"},
    FPSBoost = false, AnimSpeed = 1
}

-- ===================== 缓存池 =====================
local ESPCache = {}
local DrawingCache = {}
local CoreGui = game:GetService("CoreGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Universal_ESP"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = CoreGui

-- 十字准星
local Crosshair = Instance.new("Frame")
Crosshair.Size = UDim2.new(0, 4, 0, 4)
Crosshair.Position = UDim2.new(0.5, -2, 0.5, -2)
Crosshair.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
Crosshair.BorderSizePixel = 0
Crosshair.Visible = false
Crosshair.Parent = ScreenGui

local function getCharacter()
    local char = LocalPlayer.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return nil end
    return char, hrp, hum
end

local function isLoot(part)
    if not part:IsA("BasePart") then return false end
    local n = part.Name:lower()
    for _, kw in ipairs(State.CustomItems) do
        if n:find(kw, 1, true) then return true end
    end
    return false
end

local function isNPC(obj)
    if not obj:IsA("Model") or Players:GetPlayerFromCharacter(obj) then return false end
    return obj:FindFirstChildOfClass("Humanoid") ~= nil
end

-- ===================== 3D & 2D ESP 渲染 =====================
local function create3DESP(target, color)
    if ESPCache[target] then return end
    local hl = Instance.new("Highlight")
    hl.Adornee = target
    hl.FillColor = color
    hl.FillTransparency = 0.5
    hl.OutlineColor = Color3.new(1, 1, 1)
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = target

    local bb = Instance.new("BillboardGui")
    bb.Adornee = target
    bb.Size = UDim2.new(0, 200, 0, 60)
    bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true

    local nameLabel = Instance.new("TextLabel")
    nameLabel.BackgroundTransparency = 1
    nameLabel.Size = UDim2.new(1, 0, 0.4, 0)
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextSize = 16
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextColor3 = color
    nameLabel.Parent = bb

    local hpBack = Instance.new("Frame")
    hpBack.Size = UDim2.new(0.8, 0, 0.1, 0)
    hpBack.Position = UDim2.new(0.1, 0, 0.5, 0)
    hpBack.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    hpBack.BorderSizePixel = 0
    hpBack.Parent = bb

    local hpBar = Instance.new("Frame")
    hpBar.Size = UDim2.new(1, 0, 1, 0)
    hpBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    hpBar.BorderSizePixel = 0
    hpBar.Parent = hpBack

    bb.Parent = target
    ESPCache[target] = { HL = hl, BB = bb, Name = nameLabel, HPBack = hpBack, HPBar = hpBar }
end

local function remove3DESP(target)
    if ESPCache[target] then
        if ESPCache[target].HL then ESPCache[target].HL:Destroy() end
        if ESPCache[target].BB then ESPCache[target].BB:Destroy() end
        ESPCache[target] = nil
    end
end

local function get2DUI(target)
    if not DrawingCache[target] then
        local box = Instance.new("Frame")
        box.BackgroundTransparency = 1
        box.Visible = false
        for _, dir in ipairs({"Top", "Bottom", "Left", "Right"}) do
            local edge = Instance.new("Frame")
            edge.BackgroundColor3 = Color3.new(1, 1, 1)
            edge.BorderSizePixel = 0
            edge.Parent = box
            if dir == "Top" then edge.Size = UDim2.new(1,0,0,1) edge.Position = UDim2.new(0,0,0,0)
            elseif dir == "Bottom" then edge.Size = UDim2.new(1,0,0,1) edge.Position = UDim2.new(0,0,1,0)
            elseif dir == "Left" then edge.Size = UDim2.new(0,1,1,0) edge.Position = UDim2.new(0,0,0,0)
            elseif dir == "Right" then edge.Size = UDim2.new(0,1,1,0) edge.Position = UDim2.new(1,0,0,0) end
        end
        local line = Instance.new("Frame")
        line.BackgroundColor3 = Color3.new(1, 1, 1)
        line.BorderSizePixel = 0
        line.Visible = false
        box.Parent = ScreenGui
        line.Parent = ScreenGui
        DrawingCache[target] = { Box = box, Line = line }
    end
    return DrawingCache[target]
end

-- ===================== 主渲染循环 =====================
local lootCount = 0

RunService.RenderStepped:Connect(function()
    local char, hrp = getCharacter()
    if not char or not hrp then
        for _, ui in pairs(DrawingCache) do ui.Box.Visible = false ui.Line.Visible = false end
        return
    end

    local activeTargets = {}
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
    lootCount = 0

    local function processTarget(target, color)
        if not target or not target.Parent then return end
        local rootPart = target:IsA("Model") and target:FindFirstChild("HumanoidRootPart") or target
        if not rootPart then return end
        local dist = (rootPart.Position - hrp.Position).Magnitude
        if dist > State.MaxDistance or target == char then return end
        activeTargets[target] = true

        create3DESP(target, color)
        local data = ESPCache[target]
        if data then
            data.Name.Text = State.DrawName and (target.Name .. (State.DrawDistance and string.format(" [%dm]", math.floor(dist)) or "")) or ""
            local hum = target:IsA("Model") and target:FindFirstChildOfClass("Humanoid")
            if hum and State.DrawHealth then
                data.HPBack.Visible = true
                local hpPct = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                data.HPBar.Size = UDim2.new(hpPct, 0, 1, 0)
                data.HPBar.BackgroundColor3 = Color3.fromRGB(255 - (hpPct * 255), hpPct * 255, 0)
            else data.HPBack.Visible = false end
        end

        if State.DrawBox or State.DrawLine then
            local ui = get2DUI(target)
            ui.Box.BorderColor3 = color
            ui.Line.BackgroundColor3 = color
            local vpPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
            if onScreen then
                local headPos = Camera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, 2.5, 0))
                local legPos = Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 2.5, 0))
                local height = math.abs(headPos.Y - legPos.Y)
                local width = height * 0.6
                if State.DrawBox then
                    ui.Box.Visible = true
                    ui.Box.Position = UDim2.new(0, vpPos.X - width/2, 0, headPos.Y)
                    ui.Box.Size = UDim2.new(0, width, 0, height)
                    for _, edge in pairs(ui.Box:GetChildren()) do if edge:IsA("Frame") then edge.BackgroundColor3 = color end end
                else ui.Box.Visible = false end
                if State.DrawLine then
                    ui.Line.Visible = true
                    local lineLength = (screenCenter - Vector2.new(vpPos.X, vpPos.Y)).Magnitude
                    local lineAngle = math.deg(math.atan2(vpPos.Y - screenCenter.Y, vpPos.X - screenCenter.X)) + 90
                    ui.Line.Position = screenCenter
                    ui.Line.Size = UDim2.new(0, 1, 0, lineLength)
                    ui.Line.Rotation = lineAngle
                else ui.Line.Visible = false end
            else ui.Box.Visible = false ui.Line.Visible = false end
        end
    end

    if State.ESP_Players then
        for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then processTarget(p.Character, Color3.fromRGB(0, 255, 0)) end end
    end
    if State.ESP_NPCs then
        for _, obj in ipairs(Workspace:GetChildren()) do
            if obj:IsA("Model") and isNPC(obj) then processTarget(obj, Color3.fromRGB(255, 50, 50)) end
        end
    end
    if State.ESP_Items then
        local params = OverlapParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = {char}
        for _, part in ipairs(Workspace:GetPartBoundsInRadius(hrp.Position, State.MaxDistance, params)) do
            if isLoot(part) then 
                processTarget(part, Color3.fromRGB(255, 215, 0))
                lootCount = lootCount + 1 
            end
        end
    end

    for target, _ in pairs(ESPCache) do
        if not activeTargets[target] or not target.Parent then remove3DESP(target) end
    end
    for target, ui in pairs(DrawingCache) do
        if not activeTargets[target] or not target.Parent then 
            if not State.DrawBox and not State.DrawLine then ui.Box:Destroy() ui.Line:Destroy() DrawingCache[target] = nil
            else ui.Box.Visible = false ui.Line.Visible = false end
        end
    end
end)

-- ===================== 功能实现 =====================
local noclipConn
local function toggleNoclip(bool)
    State.Noclip = bool
    if bool then
        if not noclipConn then
            noclipConn = RunService.Stepped:Connect(function()
                local char = LocalPlayer.Character
                if char then for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
                end end
            end)
        end
    else
        if noclipConn then noclipConn:Disconnect() noclipConn = nil end
    end
end

local flyBV, flyBG, flyConn
local function toggleFly(bool)
    State.Fly = bool
    local char, hrp, hum = getCharacter()
    if not char or not hrp then return end
    if bool then
        if flyConn then flyConn:Disconnect() end
        if hrp:FindFirstChild("FlyBV") then hrp.FlyBV:Destroy() end
        if hrp:FindFirstChild("FlyBG") then hrp.FlyBG:Destroy() end
        toggleNoclip(true)

        flyBV = Instance.new("BodyVelocity") flyBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge) flyBV.Velocity = Vector3.zero flyBV.Parent = hrp
        flyBG = Instance.new("BodyGyro") flyBG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge) flyBG.P = 10000 flyBG.D = 500 flyBG.Parent = hrp
        
        flyConn = RunService.RenderStepped:Connect(function()
            if not hrp or not hrp.Parent then return end
            local cam = Workspace.CurrentCamera
            flyBG.CFrame = cam.CFrame
            local moveDir = hum.MoveDirection
            if moveDir.Magnitude > 0 then
                local camLook, camRight = cam.CFrame.LookVector, cam.CFrame.RightVector
                flyBV.Velocity = (camRight * moveDir:Dot(camRight) + camLook * moveDir:Dot(camLook)).Unit * State.FlySpeed
            else
                flyBV.Velocity = Vector3.zero
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) or (UserInputService.TouchEnabled and hum.Jump) then
                    flyBV.Velocity = Vector3.new(0, State.FlySpeed, 0)
                end
            end
        end)
    else
        if flyConn then flyConn:Disconnect() end
        if hrp then
            if hrp:FindFirstChild("FlyBV") then hrp.FlyBV:Destroy() end
            if hrp:FindFirstChild("FlyBG") then hrp.FlyBG:Destroy() end
        end
        toggleNoclip(false)
    end
end

-- 亮度调节
local originalLighting = {
    Ambient = Lighting.Ambient, OutdoorAmbient = Lighting.OutdoorAmbient,
    Brightness = Lighting.Brightness, FogEnd = Lighting.FogEnd,
    GlobalShadows = Lighting.GlobalShadows, ClockTime = Lighting.ClockTime
}
local function applyBrightness(level)
    if level == 1 then -- 微亮
        Lighting.Ambient = Color3.fromRGB(100, 100, 100)
        Lighting.Brightness = 1
        Lighting.GlobalShadows = true
        Lighting.FogEnd = 1000
    elseif level == 2 then -- 中亮
        Lighting.Ambient = Color3.fromRGB(180, 180, 180)
        Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
        Lighting.Brightness = 1.5
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 5000
    elseif level == 3 then -- 极亮
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        Lighting.Brightness = 2
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 100000
        Lighting.ClockTime = 12
    elseif level == 0 then -- 还原
        Lighting.Ambient = originalLighting.Ambient
        Lighting.OutdoorAmbient = originalLighting.OutdoorAmbient
        Lighting.Brightness = originalLighting.Brightness
        Lighting.FogEnd = originalLighting.FogEnd
        Lighting.GlobalShadows = originalLighting.GlobalShadows
        Lighting.ClockTime = originalLighting.ClockTime
    end
end

-- 无限跳跃
local infJumpConn
local function toggleInfJump(bool)
    State.InfiniteJump = bool
    if bool then
        if not infJumpConn then
            infJumpConn = UserInputService.JumpRequest:Connect(function()
                local _, _, hum = getCharacter()
                if hum and State.InfiniteJump then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
            end)
        end
    elseif infJumpConn then infJumpConn:Disconnect() infJumpConn = nil end
end

-- 无敌
local godModeConn
local function toggleGodMode(bool)
    State.GodMode = bool
    if bool then
        if not godModeConn then
            godModeConn = RunService.Heartbeat:Connect(function()
                local _, _, hum = getCharacter()
                if hum and State.GodMode then hum.MaxHealth = math.huge hum.Health = math.huge end
            end)
        end
    else
        if godModeConn then godModeConn:Disconnect() godModeConn = nil end
        local _, _, hum = getCharacter() if hum then hum.MaxHealth = 100 hum.Health = 100 end
    end
end

-- 动画加速
local animSpeedConn
local function toggleAnimSpeed(speed)
    State.AnimSpeed = speed
    local char = LocalPlayer.Character
    if char then
        for _, track in ipairs(char:GetDescendants()) do
            if track:IsA("AnimationTrack") then track:AdjustSpeed(speed) end
        end
    end
    if not animSpeedConn then
        animSpeedConn = LocalPlayer.CharacterAdded:Connect(function(newChar)
            newChar.DescendantAdded:Connect(function(desc)
                if desc:IsA("AnimationTrack") and State.AnimSpeed ~= 1 then desc:AdjustSpeed(State.AnimSpeed) end
            end)
        end)
    end
end

-- ===================== Fluent UI 构建 =====================
local Window = Fluent:CreateWindow({
    Title = "致命猿猴 · 终极辅助",
    SubTitle = "Fluent UI Edition",
    TabWidth = 160,
    Size = UDim2.fromOffset(520, 360),
    Acrylic = true, -- 开启毛玻璃特效，非常现代
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Visual = Window:AddTab({ Title = "视觉透视", Icon = "eye" }),
    Movement = Window:AddTab({ Title = "移动与生存", Icon = "activity" }),
    Settings = Window:AddTab({ Title = "杂项设置", Icon = "settings" })
}

-- Tab 1: 视觉透视
local VisualGroup = Tabs.Visual:AddLeftGroupbox("透视目标")
VisualGroup:AddToggle("ESP_Players", { Title = "玩家透视 (绿色)", Default = false, Callback = function(v) State.ESP_Players = v end })
VisualGroup:AddToggle("ESP_NPCs", { Title = "怪物透视 (红色)", Default = false, Callback = function(v) State.ESP_NPCs = v end })
VisualGroup:AddToggle("ESP_Items", { Title = "物品透视 (金色)", Default = false, Callback = function(v) State.ESP_Items = v end })

local VisualStyle = Tabs.Visual:AddRightGroupbox("视觉样式")
VisualStyle:AddToggle("DrawBox", { Title = "绘制 2D 方框", Default = true, Callback = function(v) State.DrawBox = v end })
VisualStyle:AddToggle("DrawLine", { Title = "绘制 屏幕追踪线", Default = true, Callback = function(v) State.DrawLine = v end })
VisualStyle:AddToggle("DrawName", { Title = "显示 名字", Default = true, Callback = function(v) State.DrawName = v end })
VisualStyle:AddToggle("DrawDistance", { Title = "显示 距离", Default = true, Callback = function(v) State.DrawDistance = v end })
VisualStyle:AddToggle("DrawHealth", { Title = "显示 血量条", Default = true, Callback = function(v) State.DrawHealth = v end })
VisualStyle:AddSlider("MaxDist", { Title = "最大渲染距离", Default = 500, Min = 100, Max = 2000, Rounding = 0, Callback = function(v) State.MaxDistance = v end })

local EnvGroup = Tabs.Visual:AddLeftGroupbox("环境与屏幕")
EnvGroup:AddButton("微亮模式", function() applyBrightness(1) end)
EnvGroup:AddButton("中亮模式", function() applyBrightness(2) end)
EnvGroup:AddButton("极亮模式", function() applyBrightness(3) end)
EnvGroup:AddButton("还原默认亮度", function() applyBrightness(0) end)
EnvGroup:AddToggle("Crosshair", { Title = "开启屏幕准星", Default = false, Callback = function(v) Crosshair.Visible = v end })

-- Tab 2: 移动与生存
local MoveGroup = Tabs.Movement:AddLeftGroupbox("移动能力")
MoveGroup:AddSlider("Speed", { Title = "行走速度", Default = 16, Min = 16, Max = 200, Rounding = 0, Callback = function(v) local _,_,h = getCharacter() if h then h.WalkSpeed = v end end })
MoveGroup:AddSlider("Jump", { Title = "跳跃高度", Default = 50, Min = 50, Max = 300, Rounding = 0, Callback = function(v) local _,_,h = getCharacter() if h then h.JumpPower = v end end })
MoveGroup:AddToggle("Noclip", { Title = "穿墙 (Noclip)", Default = false, Callback = toggleNoclip })
MoveGroup:AddToggle("InfJump", { Title = "无限跳跃", Default = false, Callback = toggleInfJump })
MoveGroup:AddToggle("Fly", { Title = "相机飞行 (抬头即飞)", Default = false, Callback = toggleFly })
MoveGroup:AddSlider("FlySpeed", { Title = "飞行速度", Default = 60, Min = 20, Max = 200, Rounding = 0, Callback = function(v) State.FlySpeed = v end })

local SurvGroup = Tabs.Movement:AddRightGroupbox("生存辅助")
SurvGroup:AddToggle("GodMode", { Title = "无敌模式 (防秒杀)", Default = false, Callback = toggleGodMode })

-- Tab 3: 杂项设置
local MiscGroup = Tabs.Settings:AddLeftGroupbox("游戏微调")
MiscGroup:AddSlider("AnimSpeed", { Title = "全局动画速度", Default = 1, Min = 1, Max = 5, Rounding = 1, Callback = toggleAnimSpeed })
MiscGroup:AddToggle("FPSBoost", { Title = "性能模式 (关闭特效)", Default = false, Callback = function(v)
    State.FPSBoost = v
    if v then
        Lighting.GlobalShadows = false
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") then obj.Enabled = false end
        end
    end
end })

local DangerGroup = Tabs.Settings:AddRightGroupbox("角色与脚本")
DangerGroup:AddButton("重置角色 (解除卡死)", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then char.Humanoid.Health = 0 end
end)
DangerGroup:AddButton("关闭脚本 UI", function() 
    ScreenGui:Destroy()
    Window:Destroy() 
end)

-- 初始化通知
Fluent:Notify({
    Title = "致命猿猴 · 辅助已加载",
    Content = "Fluent UI 风格已启用，受击飞天已移除。",
    Duration = 5
})