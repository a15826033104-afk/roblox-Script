local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

local State = {
    ESP_Players = false, ESP_NPCs = false, ESP_Items = false,
    ESP_Limit = 50, ESP_SortByDist = true,
    DrawBox = true, DrawLine = true, DrawName = true, DrawHealth = true, DrawDistance = true,
    WalkSpeed = 16, Noclip = false,
    Fly = false, FlySpeed = 80,
    AntiJumpscare = false, Anchor = false,
    CustomItems = {"gold", "copper", "diamond", "scrap"}
}

local OriginalEnv = {
    Gravity = Workspace.Gravity, FOV = Camera.FieldOfView,
    Ambient = Lighting.Ambient, OutdoorAmbient = Lighting.OutdoorAmbient,
    Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime,
    GlobalShadows = Lighting.GlobalShadows,
    CameraMode = LocalPlayer.CameraMode, MaxZoom = Camera.MaxZoomDistance,
    WalkSpeed = nil
}

local ESPCache = {}
local DrawingCache = {}
local Connections = {}
local SafePosition = nil
local IsCleaned = false
local ActiveUI = nil 

local function getCharacter()
    local char = LocalPlayer.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return nil end
    if OriginalEnv.WalkSpeed == nil then OriginalEnv.WalkSpeed = hum.WalkSpeed end
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

local function DestroyCurrentUI()
    if ActiveUI then 
        pcall(function() 
            if type(ActiveUI) == "table" and ActiveUI.Destroy then ActiveUI:Destroy() 
            else ActiveUI:Destroy() end 
        end) 
        ActiveUI = nil
    end
    pcall(function() 
        local w = CoreGui:FindFirstChild("WindUI") if w then w:Destroy() end
        local f = CoreGui:FindFirstChild("Fluent") if f then f:Destroy() end
        local c = CoreGui:FindFirstChild("CustomUI_Plus") if c then c:Destroy() end
    end)
end

local flying = false
local flyConnection = nil
local activeConstraints = {}
local noclipConn = nil

local function updateNoclipConnection()
    local shouldNoclip = State.Noclip or flying
    if shouldNoclip and not noclipConn then
        noclipConn = RunService.Stepped:Connect(function()
            if IsCleaned then return end
            local char = LocalPlayer.Character
            if not char then return end
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
            end
        end)
    elseif not shouldNoclip and noclipConn then
        noclipConn:Disconnect()
        noclipConn = nil
    end
end

local function toggleNoclip(bool)
    State.Noclip = bool
    updateNoclipConnection()
end

local function getMoveVector(cam)
    local move = Vector3.zero
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
    local right = cam.CFrame.RightVector
    local flatRight = Vector3.new(right.X, 0, right.Z)
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += flatRight.Unit end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= flatRight.Unit end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) or UserInputService:IsKeyDown(Enum.KeyCode.ButtonR2) then move += Vector3.yAxis end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.ButtonL2) then move -= Vector3.yAxis end
    return move
end

local function stopFly()
    if not flying then return end
    flying = false
    State.Fly = false
    if flyConnection then flyConnection:Disconnect(); flyConnection = nil end
    for _, obj in ipairs(activeConstraints) do if obj and obj.Parent then obj:Destroy() end end
    activeConstraints = {}
    local _, _, hum = getCharacter()
    if hum then hum.PlatformStand = false hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
    updateNoclipConnection()
end

local function startFly()
    if flying then return end
    local _, hrp, hum = getCharacter()
    if not (hum and hrp) then return end
    flying = true State.Fly = true
    hrp.Anchored = false
    updateNoclipConnection()
    hum.PlatformStand = true
    hum:ChangeState(Enum.HumanoidStateType.Physics)

    local attachment = Instance.new("Attachment")
    attachment.Name = "FlyAttachment" attachment.Parent = hrp
    table.insert(activeConstraints, attachment)

    local alignPos = Instance.new("AlignPosition")
    alignPos.Mode = Enum.PositionAlignmentMode.OneAttachment alignPos.Attachment0 = attachment
    alignPos.ApplyAtCenterOfMass = true alignPos.Position = hrp.Position
    alignPos.MaxForce = math.huge alignPos.Responsiveness = 200 alignPos.Parent = hrp
    table.insert(activeConstraints, alignPos)

    local alignOri = Instance.new("AlignOrientation")
    alignOri.Mode = Enum.OrientationAlignmentMode.OneAttachment alignOri.Attachment0 = attachment
    alignOri.CFrame = Camera.CFrame
    alignOri.MaxTorque = math.huge alignOri.Responsiveness = 1000
    alignOri.Parent = hrp
    table.insert(activeConstraints, alignOri)

    local targetPosition = hrp.Position
    flyConnection = RunService.RenderStepped:Connect(function(dt)
        if not flying or IsCleaned then return end
        local cam = Workspace.CurrentCamera
        if not cam then return end
        local moveVec = getMoveVector(cam)
        if moveVec.Magnitude > 0 then targetPosition = targetPosition + moveVec.Unit * State.FlySpeed * dt end
        alignPos.Position = targetPosition
        alignOri.CFrame = cam.CFrame 
    end)
end

local function toggleFly(bool) if bool then startFly() else stopFly() end end
table.insert(Connections, LocalPlayer.CharacterAdded:Connect(function() if flying then stopFly() end end))

local function Cleanup()
    if IsCleaned then return end
    IsCleaned = true
    stopFly() State.Fly = false
    DestroyCurrentUI()
    pcall(function() local s = CoreGui:FindFirstChild("UISelector") if s then s:Destroy() end end)
    for _, conn in pairs(Connections) do pcall(function() conn:Disconnect() end) end
    if noclipConn then noclipConn:Disconnect() noclipConn = nil end
    for _, cache in pairs(ESPCache) do pcall(function() cache.HL:Destroy() cache.BB:Destroy() end) end
    for _, ui in pairs(DrawingCache) do pcall(function() ui.Box:Destroy() ui.Line:Destroy() end) end
    local char, hrp, hum = getCharacter()
    if char and hum then
        hum.WalkSpeed = OriginalEnv.WalkSpeed or 16
        hum.PlatformStand = false
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        for _, v in pairs(char:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = true end end
        if hrp then hrp.Anchored = false end
    end
    Workspace.Gravity = OriginalEnv.Gravity Camera.FieldOfView = OriginalEnv.FOV
    Lighting.Ambient = OriginalEnv.Ambient Lighting.OutdoorAmbient = OriginalEnv.OutdoorAmbient
    Lighting.Brightness = OriginalEnv.Brightness Lighting.ClockTime = OriginalEnv.ClockTime
    Lighting.GlobalShadows = OriginalEnv.GlobalShadows
    LocalPlayer.CameraMode = OriginalEnv.CameraMode Camera.MaxZoomDistance = OriginalEnv.MaxZoom
    for k in pairs(State) do if type(State[k]) == "boolean" then State[k] = false end end
    updateNoclipConnection()
end

UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightShift then Cleanup() end
end)

table.insert(Connections, RunService.Heartbeat:Connect(function()
    if IsCleaned then return end
    local char, hrp, hum = getCharacter()
    if not char or not hum then return end
    if not flying and not State.Anchor and hum.Health > 0 then
        if hum:GetState() ~= Enum.HumanoidStateType.Physics and hum.FloorMaterial ~= Enum.Material.Air then SafePosition = hrp.CFrame end
    end
    if State.AntiJumpscare and not flying then
        local grabbed = false
        for _, t in ipairs(hum:GetPlayingAnimationTracks()) do
            local n = t.Animation.Name:lower()
            if n:find("kill") or n:find("scare") or n:find("grab") or n:find("attack") then grabbed = true break end
        end
        if grabbed or (hum:GetState() == Enum.HumanoidStateType.Physics and hrp.AssemblyLinearVelocity.Magnitude > 100) then
            for _, t in ipairs(hum:GetPlayingAnimationTracks()) do t:Stop() end
            hum.PlatformStand = false
            if SafePosition then hrp.CFrame = SafePosition end
        end
    end
    if not flying then hrp.Anchored = State.Anchor end
end))

table.insert(Connections, RunService.RenderStepped:Connect(function()
    if IsCleaned then return end
    local char, hrp = getCharacter()
    if not char or not hrp then return end
    local active, list = {}, {}
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
    if State.ESP_Players then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                table.insert(list, {T = p.Character, C = Color3.fromRGB(0, 255, 0)})
            end
        end
    end
    if State.ESP_NPCs then
        for _, o in ipairs(Workspace:GetChildren()) do
            if o:IsA("Model") and isNPC(o) then table.insert(list, {T = o, C = Color3.fromRGB(255, 50, 50)}) end
        end
    end
    if State.ESP_Items then
        local p = OverlapParams.new() p.FilterType = Enum.RaycastFilterType.Exclude p.FilterDescendantsInstances = {char}
        for _, part in ipairs(Workspace:GetPartBoundsInRadius(hrp.Position, 1000, p)) do
            if isLoot(part) then table.insert(list, {T = part, C = Color3.fromRGB(255, 215, 0)}) end
        end
    end
    local function getDist(t)
        local p = t.T:IsA("Model") and t.T:FindFirstChild("HumanoidRootPart") or t.T
        return p and (p.Position - hrp.Position).Magnitude or 9999
    end
    if State.ESP_SortByDist then table.sort(list, function(a, b) return getDist(a) < getDist(b) end) end
    for i = 1, math.min(#list, State.ESP_Limit) do
        local data = list[i] local target = data.T local color = data.C
        local root = target:IsA("Model") and target:FindFirstChild("HumanoidRootPart") or target
        if root and root.Parent then
            local dist = (root.Position - hrp.Position).Magnitude
            active[target] = true
            if not ESPCache[target] then
                local hl = Instance.new("Highlight"); hl.Adornee = target; hl.FillColor = color
                hl.FillTransparency = 0.5; hl.OutlineColor = Color3.new(1,1,1)
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; hl.Parent = target
                local bb = Instance.new("BillboardGui"); bb.Adornee = target; bb.Size = UDim2.new(0,200,0,60)
                bb.StudsOffset = Vector3.new(0,3,0); bb.AlwaysOnTop = true
                local name = Instance.new("TextLabel"); name.BackgroundTransparency = 1
                name.Size = UDim2.new(1,0,0.4,0); name.Font = Enum.Font.SourceSansBold
                name.TextSize = 16; name.TextStrokeTransparency = 0; name.TextColor3 = color; name.Parent = bb
                local hb = Instance.new("Frame"); hb.Size = UDim2.new(0.8,0,0.1,0)
                hb.Position = UDim2.new(0.1,0,0.5,0); hb.BackgroundColor3 = Color3.fromRGB(30,30,30); hb.BorderSizePixel = 0; hb.Parent = bb
                local hf = Instance.new("Frame"); hf.Size = UDim2.new(1,0,1,0); hf.BackgroundColor3 = Color3.fromRGB(0,255,0); hf.BorderSizePixel = 0; hf.Parent = hb
                bb.Parent = target
                ESPCache[target] = {HL = hl, BB = bb, Name = name, HPBack = hb, HPBar = hf}
            end
            local c = ESPCache[target]
            if c then
                c.Name.Text = State.DrawName and (target.Name .. (State.DrawDistance and string.format(" [%dm]", math.floor(dist)) or "")) or ""
                local hum = target:IsA("Model") and target:FindFirstChildOfClass("Humanoid")
                if hum and State.DrawHealth then
                    c.HPBack.Visible = true
                    local pct = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                    c.HPBar.Size = UDim2.new(pct, 0, 1, 0)
                    c.HPBar.BackgroundColor3 = Color3.fromRGB(255 - pct * 255, pct * 255, 0)
                else c.HPBack.Visible = false end
            end
            if State.DrawBox or State.DrawLine then
                if not DrawingCache[target] then
                    local box = Instance.new("Frame"); box.BackgroundTransparency = 1; box.Visible = false
                    for _, d in ipairs({"Top","Bottom","Left","Right"}) do
                        local e = Instance.new("Frame"); e.BackgroundColor3 = Color3.new(1,1,1); e.BorderSizePixel = 0; e.Parent = box
                        if d == "Top" then e.Size = UDim2.new(1,0,0,1); e.Position = UDim2.new(0,0,0,0)
                        elseif d == "Bottom" then e.Size = UDim2.new(1,0,0,1); e.Position = UDim2.new(0,0,1,0)
                        elseif d == "Left" then e.Size = UDim2.new(0,1,1,0); e.Position = UDim2.new(0,0,0,0)
                        else e.Size = UDim2.new(0,1,1,0); e.Position = UDim2.new(1,0,0,0) end
                    end
                    local line = Instance.new("Frame"); line.BackgroundColor3 = Color3.new(1,1,1); line.BorderSizePixel = 0; line.Visible = false
                    box.Parent = CoreGui; line.Parent = CoreGui
                    DrawingCache[target] = {Box = box, Line = line}
                end
                local ui = DrawingCache[target]
                ui.Box.BorderColor3 = color; ui.Line.BackgroundColor3 = color
                local vp, on = Camera:WorldToViewportPoint(root.Position)
                if on and vp.Z > 0 then
                    local h = math.abs(Camera:WorldToViewportPoint(root.Position + Vector3.new(0,2.5,0)).Y - Camera:WorldToViewportPoint(root.Position - Vector3.new(0,2.5,0)).Y)
                    local w = h * 0.6
                    if State.DrawBox then
                        ui.Box.Visible = true
                        ui.Box.Position = UDim2.new(0, vp.X - w/2, 0, vp.Y - h/2)
                        ui.Box.Size = UDim2.new(0, w, 0, h)
                        for _, e in pairs(ui.Box:GetChildren()) do if e:IsA("Frame") then e.BackgroundColor3 = color end end
                    else ui.Box.Visible = false end
                    if State.DrawLine then
                        ui.Line.Visible = true
                        local l = (screenCenter - Vector2.new(vp.X, vp.Y)).Magnitude
                        ui.Line.Position = screenCenter
                        ui.Line.Size = UDim2.new(0, 1, 0, l)
                        ui.Line.Rotation = math.deg(math.atan2(vp.Y - screenCenter.Y, vp.X - screenCenter.X)) + 90
                    else ui.Line.Visible = false end
                else ui.Box.Visible = false; ui.Line.Visible = false end
            end
        end
    end
    for t in pairs(ESPCache) do
        if not active[t] or not t.Parent then
            pcall(function() ESPCache[t].HL:Destroy(); ESPCache[t].BB:Destroy() end)
            ESPCache[t] = nil
        end
    end
    for t, ui in pairs(DrawingCache) do
        if not active[t] or not t.Parent then
            if not State.DrawBox and not State.DrawLine then
                pcall(function() ui.Box:Destroy(); ui.Line:Destroy() end)
                DrawingCache[t] = nil
            else
                if ui.Box then ui.Box.Visible = false end
                if ui.Line then ui.Line.Visible = false end
            end
        end
    end
end))
local function buildFluentUI()
    local Fluent = loadstring(game:HttpGet("https://ghproxy.com/https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    local Window = Fluent:CreateWindow({ Title = "致命猿猴 · Fluent UI", SubTitle = "全角度3D飞行", TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = true, Theme = "Dark" })
    ActiveUI = Window
    local Tabs = {
        Home = Window:AddTab({ Title = "主页", Icon = "home" }),
        ESP = Window:AddTab({ Title = "视觉与ESP", Icon = "eye" }),
        Phys = Window:AddTab({ Title = "移动与物理", Icon = "activity" }),
        Misc = Window:AddTab({ Title = "传送与保命", Icon = "shield" }),
        UI = Window:AddTab({ Title = "UI", Icon = "monitor" })
    }
    Tabs.Home:AddButton({ Title = "一键复制作者 UID", Callback = function() pcall(function() setclipboard("3493115679738813") end) Fluent:Notify({ Title = "复制成功", Content = "作者 UID 已复制！", Duration = 3 }) end })
    Tabs.Home:AddParagraph({ Title = "版本信息", Content = "当前版本：0.0.8 (全角度飞行)\n按右Shift键可一键还原并退出。" })
    Tabs.ESP:AddToggle("ESP_Players", { Title = "玩家透视", Default = false, Callback = function(v) State.ESP_Players = v end })
    Tabs.ESP:AddToggle("ESP_NPCs", { Title = "怪物透视", Default = false, Callback = function(v) State.ESP_NPCs = v end })
    Tabs.ESP:AddToggle("ESP_Items", { Title = "物品透视", Default = false, Callback = function(v) State.ESP_Items = v end })
    Tabs.ESP:AddToggle("DrawBox", { Title = "绘制 2D 方框", Default = true, Callback = function(v) State.DrawBox = v end })
    Tabs.ESP:AddToggle("DrawLine", { Title = "绘制 屏幕追踪线", Default = true, Callback = function(v) State.DrawLine = v end })
    Tabs.ESP:AddSlider("ESP_Limit", { Title = "最大渲染数量", Default = 50, Min = 10, Max = 200, Rounding = 0, Callback = function(v) State.ESP_Limit = v end })
    Tabs.Phys:AddSlider("WalkSpeed", { Title = "行走速度", Default = 16, Min = 16, Max = 200, Rounding = 0, Callback = function(v) State.WalkSpeed = v local _,_,h = getCharacter() if h then h.WalkSpeed = v end end })
    Tabs.Phys:AddToggle("Noclip", { Title = "穿墙", Default = false, Callback = toggleNoclip })
    Tabs.Phys:AddToggle("Fly", { Title = "3D全角度飞行", Default = false, Callback = toggleFly })
    Tabs.Phys:AddSlider("FlySpeed", { Title = "飞行速度", Default = 80, Min = 20, Max = 200, Rounding = 0, Callback = function(v) State.FlySpeed = v end })
    Tabs.Phys:AddToggle("Anchor", { Title = "锚定角色", Default = false, Callback = function(v) State.Anchor = v end })
    Tabs.Phys:AddToggle("AntiJumpscare", { Title = "强制防跳杀", Default = false, Callback = function(v) State.AntiJumpscare = v end })
    Tabs.Phys:AddSlider("Gravity", { Title = "全局重力调节", Default = 196, Min = 0, Max = 196, Rounding = 0, Callback = function(v) Workspace.Gravity = v end })
    Tabs.Misc:AddButton({ Title = "传送到准星位置", Callback = function() 
        local _, hrp = getCharacter() 
        if hrp then 
            if UserInputService.TouchEnabled then hrp.CFrame = CFrame.new((Camera.CFrame * CFrame.new(0, 0, -50)).Position) 
            elseif Mouse.Hit then hrp.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0)) end
        end 
    end })
    Tabs.Misc:AddButton({ Title = "传送到出生点", Callback = function() local sp = Workspace:FindFirstChildOfClass("SpawnLocation") local _, hrp = getCharacter() if sp and hrp then hrp.CFrame = sp.CFrame + Vector3.new(0, 3, 0) end end })
    Tabs.Misc:AddButton({ Title = "重置角色", Callback = function() local char = LocalPlayer.Character if char and char:FindFirstChild("Humanoid") then char.Humanoid.Health = 0 end end })
    Tabs.Misc:AddButton({ Title = "还原所有修改并关闭", Callback = Cleanup })
    Tabs.UI:AddButton({ Title = "切换 UI 界面", Description = "重新弹出选择器", Callback = function() OpenUISelector(false) end })
end

local function buildWindUI()
    local WindUI = loadstring(game:HttpGet("https://cdn.jsdelivr.net/gh/Footagesus/WindUI@latest/dist/main.lua"))()
    pcall(function() WindUI:SetLanguage("zh-CN") end)
    local Window = WindUI:CreateWindow({ Title = "致命猿猴 · WindUI", Icon = "monkey", Author = "Assistant", Folder = "LethalApeUltimate", Size = UDim2.fromOffset(620, 440), Theme = "Dark", Transparent = true })
    ActiveUI = Window
    local T1 = Window:Tab({ Title = "主页", Icon = "home" })
    local H = T1:Section({ Title = "关于作者", Opened = true })
    H:Button({ Title = "一键复制作者 UID", Callback = function() pcall(function() setclipboard("3493115679738813") end) WindUI:Notify({ Title = "复制成功", Content = "作者 UID 已复制！", Duration = 4 }) end })
    T1:Paragraph({ Title = "版本信息", Content = "当前版本：0.0.8 (全角度飞行)\n按右Shift键可一键还原并退出。" })
    local T2 = Window:Tab({ Title = "视觉与ESP", Icon = "eye" })
    local T2L = T2:Section({ Title = "ESP 目标", Opened = true })
    T2L:Toggle({ Title = "玩家透视 (绿)", Value = false, Callback = function(v) State.ESP_Players = v end })
    T2L:Toggle({ Title = "怪物透视 (红)", Value = false, Callback = function(v) State.ESP_NPCs = v end })
    T2L:Toggle({ Title = "物品透视 (金)", Value = false, Callback = function(v) State.ESP_Items = v end })
    T2L:Toggle({ Title = "绘制 2D 方框", Value = true, Callback = function(v) State.DrawBox = v end })
    T2L:Toggle({ Title = "绘制 屏幕追踪线", Value = true, Callback = function(v) State.DrawLine = v end })
    T2L:Slider({ Title = "最大渲染数量", Value = { Min = 10, Max = 200, Default = 50 }, Step = 10, Callback = function(v) State.ESP_Limit = v end })
    local T3 = Window:Tab({ Title = "移动与物理", Icon = "activity" })
    local T3L = T3:Section({ Title = "移动与飞行", Opened = true })
    T3L:Slider({ Title = "行走速度", Value = { Min = 16, Max = 200, Default = 16 }, Step = 2, Callback = function(v) State.WalkSpeed = v local _,_,h = getCharacter() if h then h.WalkSpeed = v end end })
    T3L:Toggle({ Title = "穿墙 (Noclip)", Value = false, Callback = toggleNoclip })
    T3L:Toggle({ Title = "3D全角度飞行", Value = false, Callback = toggleFly })
    T3L:Slider({ Title = "飞行速度", Value = { Min = 20, Max = 200, Default = 80 }, Step = 10, Callback = function(v) State.FlySpeed = v end })
    local T4 = Window:Tab({ Title = "传送与保命", Icon = "shield" })
    local T4L = T4:Section({ Title = "快捷传送", Opened = true })
    T4L:Button({ Title = "传送到准星位置", Callback = function() 
        local _, hrp = getCharacter() 
        if hrp then 
            if UserInputService.TouchEnabled then hrp.CFrame = CFrame.new((Camera.CFrame * CFrame.new(0, 0, -50)).Position) 
            elseif Mouse.Hit then hrp.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0)) end
        end 
    end })
    T4L:Button({ Title = "传送到出生点", Callback = function() local sp = Workspace:FindFirstChildOfClass("SpawnLocation") local _, hrp = getCharacter() if sp and hrp then hrp.CFrame = sp.CFrame + Vector3.new(0, 3, 0) end end })
    T4L:Button({ Title = "还原所有修改并关闭", Callback = Cleanup })
    local T5 = Window:Tab({ Title = "UI", Icon = "layout" })
    local T5S = T5:Section({ Title = "系统", Opened = true })
    T5S:Button({ Title = "切换 UI 界面", Callback = function() OpenUISelector(false) end })
end

local function buildCustomUIPlus()
    local CustomGui = Instance.new("ScreenGui")
    CustomGui.Name = "CustomUI_Plus"
    CustomGui.ResetOnSpawn = false
    CustomGui.Parent = CoreGui
    ActiveUI = CustomGui
    local win = Instance.new("Frame")
    win.Size = UDim2.new(0, 580, 0, 420)
    win.Position = UDim2.new(0.5, -290, 0.5, -210)
    win.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    win.BackgroundTransparency = 0.05
    win.Parent = CustomGui
    Instance.new("UICorner", win).CornerRadius = UDim.new(0, 12)
    local stroke = Instance.new("UIStroke", win) stroke.Color = Color3.fromRGB(60, 60, 70) stroke.Thickness = 1.5
    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 40)
    topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    topBar.Parent = win
    Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 12)
    local fixCorner = Instance.new("Frame") fixCorner.Size = UDim2.new(1, 0, 0, 15) fixCorner.Position = UDim2.new(0, 0, 1, -15) fixCorner.BackgroundColor3 = Color3.fromRGB(30, 30, 35) fixCorner.BorderSizePixel = 0 fixCorner.Parent = topBar
    local titleLabel = Instance.new("TextLabel") titleLabel.Size = UDim2.new(1, -80, 1, 0) titleLabel.Position = UDim2.new(0, 15, 0, 0) titleLabel.BackgroundTransparency = 1 titleLabel.Text = "致命猿猴 · 自制 UI (Plus)" titleLabel.TextColor3 = Color3.fromRGB(220, 220, 220) titleLabel.Font = Enum.Font.GothamBold titleLabel.TextSize = 15 titleLabel.TextXAlignment = Enum.TextXAlignment.Left titleLabel.Parent = topBar
    local closeBtn = Instance.new("TextButton") closeBtn.Size = UDim2.new(0, 26, 0, 26) closeBtn.Position = UDim2.new(1, -35, 0, 7) closeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80) closeBtn.Text = "X" closeBtn.TextColor3 = Color3.new(1,1,1) closeBtn.Font = Enum.Font.GothamBold closeBtn.Parent = topBar Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6) closeBtn.MouseButton1Click:Connect(Cleanup)
    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 130, 1, -50)
    sidebar.Position = UDim2.new(0, 5, 0, 45)
    sidebar.BackgroundTransparency = 1
    sidebar.Parent = win
    local sideLayout = Instance.new("UIListLayout") sideLayout.Padding = UDim.new(0, 8) sideLayout.Parent = sidebar
    local searchBox = Instance.new("TextBox")
    searchBox.Size = UDim2.new(1, 0, 0, 32)
    searchBox.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    searchBox.PlaceholderText = "🔍 搜索功能..."
    searchBox.Text = ""
    searchBox.TextColor3 = Color3.new(1,1,1)
    searchBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
    searchBox.Font = Enum.Font.Gotham
    searchBox.TextSize = 12
    searchBox.Parent = sidebar
    Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0, 8)
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -145, 1, -50)
    content.Position = UDim2.new(0, 140, 0, 45)
    content.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    content.Parent = win
    Instance.new("UICorner", content).CornerRadius = UDim.new(0, 8)
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -10, 1, -10)
    scroll.Position = UDim2.new(0, 5, 0, 5)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 4
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.Parent = content
    local scrollLayout = Instance.new("UIListLayout") scrollLayout.Padding = UDim.new(0, 8) scrollLayout.Parent = scroll
local function createToggle(text, default, callback)
        local f = Instance.new("Frame") f.Size = UDim2.new(1, 0, 0, 38) f.BackgroundColor3 = Color3.fromRGB(35, 35, 42) f.Parent = scroll Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
        local lbl = Instance.new("TextLabel") lbl.Size = UDim2.new(1, -60, 1, 0) lbl.Position = UDim2.new(0, 12, 0, 0) lbl.BackgroundTransparency = 1 lbl.Text = text lbl.TextColor3 = Color3.fromRGB(220,220,220) lbl.Font = Enum.Font.Gotham lbl.TextSize = 13 lbl.TextXAlignment = Enum.TextXAlignment.Left lbl.Parent = f
        local bg = Instance.new("Frame") bg.Size = UDim2.new(0, 42, 0, 22) bg.Position = UDim2.new(1, -54, 0.5, -11) bg.BackgroundColor3 = default and Color3.fromRGB(50, 150, 255) or Color3.fromRGB(50, 50, 60) bg.Parent = f Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)
        local circle = Instance.new("Frame") circle.Size = UDim2.new(0, 18, 0, 18) circle.Position = default and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9) circle.BackgroundColor3 = Color3.new(1,1,1) circle.Parent = bg Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)
        local click = Instance.new("TextButton") click.Size = UDim2.new(1, 0, 1, 0) click.BackgroundTransparency = 1 click.Text = "" click.Parent = f
        local isOn = default
        click.MouseButton1Click:Connect(function()
            isOn = not isOn callback(isOn)
            TweenService:Create(bg, TweenInfo.new(0.2), {BackgroundColor3 = isOn and Color3.fromRGB(50,150,255) or Color3.fromRGB(50,50,60)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = isOn and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)}):Play()
        end)
        click.MouseEnter:Connect(function() TweenService:Create(f, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(45,45,55)}):Play() end)
        click.MouseLeave:Connect(function() TweenService:Create(f, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(35,35,42)}):Play() end)
        return f
    end

    local function createButton(text, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 38)
        btn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
        btn.Text = text
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 13
        btn.Parent = scroll
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        btn.MouseButton1Click:Connect(callback)
        btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(70, 170, 255)}):Play() end)
        btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(50, 150, 255)}):Play() end)
        return btn
    end
    local function createSlider(text, min, max, default, callback)
        local f = Instance.new("Frame") f.Size = UDim2.new(1, 0, 0, 48) f.BackgroundColor3 = Color3.fromRGB(35, 35, 42) f.Parent = scroll Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
        local lbl = Instance.new("TextLabel") lbl.Size = UDim2.new(1, -20, 0, 20) lbl.Position = UDim2.new(0, 10, 0, 5) lbl.BackgroundTransparency = 1 lbl.Text = text .. ": " .. default lbl.TextColor3 = Color3.fromRGB(220,220,220) lbl.Font = Enum.Font.Gotham lbl.TextSize = 13 lbl.TextXAlignment = Enum.TextXAlignment.Left lbl.Parent = f
        local barBg = Instance.new("Frame") barBg.Size = UDim2.new(1, -20, 0, 6) barBg.Position = UDim2.new(0, 10, 0, 32) barBg.BackgroundColor3 = Color3.fromRGB(50, 50, 60) barBg.Parent = f Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)
        local fill = Instance.new("Frame") fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0) fill.BackgroundColor3 = Color3.fromRGB(50, 150, 255) fill.Parent = barBg Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
        local knob = Instance.new("Frame") knob.Size = UDim2.new(0, 14, 0, 14) knob.Position = UDim2.new((default - min) / (max - min), 0, 0.5, -7) knob.BackgroundColor3 = Color3.new(1,1,1) knob.Parent = barBg Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
        local input = Instance.new("TextButton") input.Size = UDim2.new(1, 0, 1, 0) input.BackgroundTransparency = 1 input.Text = "" input.Parent = f
        local dragging = false
        input.MouseButton1Down:Connect(function() dragging = true end)
        UserInputService.InputEnded:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
        UserInputService.InputChanged:Connect(function(inp)
            if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
                local pct = math.clamp((inp.Position.X - barBg.AbsolutePosition.X) / barBg.AbsoluteSize.X, 0, 1)
                local val = math.floor(min + (max - min) * pct)
                fill.Size = UDim2.new(pct, 0, 1, 0) knob.Position = UDim2.new(pct, -7, 0.5, -7) lbl.Text = text .. ": " .. val callback(val)
            end
        end)
        return f
    end

    local Features = {
        {Name="玩家透视", Page="ESP", Type="Toggle", Default=State.ESP_Players, Callback=function(v) State.ESP_Players = v end},
        {Name="怪物透视", Page="ESP", Type="Toggle", Default=State.ESP_NPCs, Callback=function(v) State.ESP_NPCs = v end},
        {Name="物品透视", Page="ESP", Type="Toggle", Default=State.ESP_Items, Callback=function(v) State.ESP_Items = v end},
        {Name="绘制方框", Page="ESP", Type="Toggle", Default=State.DrawBox, Callback=function(v) State.DrawBox = v end},
        {Name="绘制追踪线", Page="ESP", Type="Toggle", Default=State.DrawLine, Callback=function(v) State.DrawLine = v end},
        {Name="最大渲染数量", Page="ESP", Type="Slider", Min=10, Max=200, Default=State.ESP_Limit, Callback=function(v) State.ESP_Limit = v end},
        {Name="行走速度", Page="Phys", Type="Slider", Min=16, Max=200, Default=State.WalkSpeed, Callback=function(v) State.WalkSpeed = v local _,_,h = getCharacter() if h then h.WalkSpeed = v end end},
        {Name="穿墙", Page="Phys", Type="Toggle", Default=State.Noclip, Callback=function(v) toggleNoclip(v) end},
        {Name="3D全角度飞行", Page="Phys", Type="Toggle", Default=State.Fly, Callback=function(v) toggleFly(v) end},
        {Name="飞行速度", Page="Phys", Type="Slider", Min=20, Max=200, Default=State.FlySpeed, Callback=function(v) State.FlySpeed = v end},
        {Name="防跳杀", Page="Phys", Type="Toggle", Default=State.AntiJumpscare, Callback=function(v) State.AntiJumpscare = v end},
        {Name="传送到准星", Page="Misc", Type="Button", Callback=function() 
            local _, hrp = getCharacter() 
            if hrp then 
                if UserInputService.TouchEnabled then hrp.CFrame = CFrame.new((Camera.CFrame * CFrame.new(0, 0, -50)).Position) 
                elseif Mouse.Hit then hrp.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0)) end
            end 
        end},
        {Name="传送到出生点", Page="Misc", Type="Button", Callback=function() local sp = Workspace:FindFirstChildOfClass("SpawnLocation") local _, hrp = getCharacter() if sp and hrp then hrp.CFrame = sp.CFrame + Vector3.new(0, 3, 0) end end},
        {Name="重置角色", Page="Misc", Type="Button", Callback=function() local char = LocalPlayer.Character if char and char:FindFirstChild("Humanoid") then char.Humanoid.Health = 0 end end},
        {Name="一键复制作者 UID", Page="Home", Type="Button", Callback=function() pcall(function() setclipboard("3493115679738813") end) end},
        {Name="还原并退出", Page="Home", Type="Button", Callback=Cleanup},
        {Name="切换 UI 界面", Page="UI", Type="Button", Callback=function() OpenUISelector(false) end}
    }

    local currentPage = "Home"
    local function renderContent(pageFilter, searchKeyword)
        for _, child in ipairs(scroll:GetChildren()) do if child:IsA("Frame") or child:IsA("TextButton") then child:Destroy() end end
        local renderedCount = 0
        for _, item in ipairs(Features) do
            local match = false
            if searchKeyword and searchKeyword ~= "" then if string.find(string.lower(item.Name), string.lower(searchKeyword)) then match = true end
            else if item.Page == pageFilter then match = true end end
            if match then
                renderedCount = renderedCount + 1
                if item.Type == "Toggle" then createToggle(item.Name, item.Default, item.Callback)
                elseif item.Type == "Button" then createButton(item.Name, item.Callback)
                elseif item.Type == "Slider" then createSlider(item.Name, item.Min, item.Max, item.Default, item.Callback) end
            end
        end
        if renderedCount == 0 then createButton("未找到相关功能", function() end) end
        scrollLayout:ApplyLayout() scroll.CanvasSize = UDim2.new(0, 0, 0, scrollLayout.AbsoluteContentSize.Y + 10)
    end

    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local txt = searchBox.Text
        if txt ~= "" then renderContent(nil, txt) else renderContent(currentPage, "") end
    end)

    local tabs = {"Home", "ESP", "Phys", "Misc", "UI"}
    local tabButtons = {}
    for _, tabName in ipairs(tabs) do
        local btn = Instance.new("TextButton") btn.Size = UDim2.new(1, 0, 0, 36) btn.BackgroundColor3 = Color3.fromRGB(35, 35, 42) btn.Text = tabName btn.TextColor3 = Color3.fromRGB(200, 200, 200) btn.Font = Enum.Font.GothamBold btn.TextSize = 13 btn.Parent = sidebar Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        btn.MouseButton1Click:Connect(function()
            currentPage = tabName searchBox.Text = ""
            for _, c in ipairs(sidebar:GetChildren()) do if c:IsA("TextButton") then c.BackgroundColor3 = Color3.fromRGB(35,35,42) c.TextColor3 = Color3.fromRGB(200,200,200) end end
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50,150,255)}):Play() btn.TextColor3 = Color3.new(1,1,1) renderContent(tabName, "")
        end)
        table.insert(tabButtons, btn)
    end
    tabButtons[1].BackgroundColor3 = Color3.fromRGB(50,150,255) tabButtons[1].TextColor3 = Color3.new(1,1,1) renderContent("Home", "")
end

function OpenUISelector(isFirstTime)
    local oldSelector = CoreGui:FindFirstChild("UISelector") if oldSelector then oldSelector:Destroy() end
    local selectorGui = Instance.new("ScreenGui") selectorGui.Name = "UISelector" selectorGui.ResetOnSpawn = false selectorGui.Parent = CoreGui
    local bg = Instance.new("Frame") bg.Size = UDim2.new(1, 0, 1, 0) bg.BackgroundColor3 = Color3.new(0, 0, 0) bg.BackgroundTransparency = 0.5 bg.Parent = selectorGui
    local main = Instance.new("Frame") main.Size = UDim2.new(0, 420, 0, 170) main.Position = UDim2.new(0.5, -210, 0.5, -85) main.BackgroundColor3 = Color3.fromRGB(25, 25, 30) main.Parent = bg Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
    local title = Instance.new("TextLabel") title.Size = UDim2.new(1, 0, 0, 45) title.BackgroundTransparency = 1 title.Text = "请选择 UI 界面" title.TextColor3 = Color3.new(1, 1, 1) title.Font = Enum.Font.GothamBold title.TextSize = 16 title.Parent = main
    local closeSelectBtn = Instance.new("TextButton") closeSelectBtn.Size = UDim2.new(0, 26, 0, 26) closeSelectBtn.Position = UDim2.new(1, -33, 0, 8) closeSelectBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80) closeSelectBtn.Text = "X" closeSelectBtn.TextColor3 = Color3.new(1,1,1) closeSelectBtn.Font = Enum.Font.GothamBold closeSelectBtn.Parent = main Instance.new("UICorner", closeSelectBtn).CornerRadius = UDim.new(0, 6)
    closeSelectBtn.MouseButton1Click:Connect(function() selectorGui:Destroy() if isFirstTime then Cleanup() end end)
    local btnLayout = Instance.new("UIListLayout") btnLayout.FillDirection = Enum.FillDirection.Horizontal btnLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center btnLayout.VerticalAlignment = Enum.VerticalAlignment.Center btnLayout.Padding = UDim.new(0, 15) btnLayout.Parent = main
    local function createSelectBtn(text, color, callback)
        local b = Instance.new("TextButton") b.Size = UDim2.new(0, 115, 0, 50) b.BackgroundColor3 = color b.Text = text b.TextColor3 = Color3.new(1,1,1) b.Font = Enum.Font.GothamBold b.TextSize = 13 b.Parent = main Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
        b.MouseButton1Click:Connect(function() selectorGui:Destroy() DestroyCurrentUI() callback() end)
        b.MouseEnter:Connect(function() TweenService:Create(b, TweenInfo.new(0.1), {Size = UDim2.new(0, 120, 0, 52)}):Play() end)
        b.MouseLeave:Connect(function() TweenService:Create(b, TweenInfo.new(0.1), {Size = UDim2.new(0, 115, 0, 50)}):Play() end)
        return b
    end
    createSelectBtn("Fluent UI", Color3.fromRGB(50, 150, 255), function() buildFluentUI() end)
    createSelectBtn("WindUI", Color3.fromRGB(60, 60, 70), function() buildWindUI() end)
    createSelectBtn("自制 UI (Plus)", Color3.fromRGB(147, 51, 234), function() buildCustomUIPlus() end)
end

OpenUISelector(true)