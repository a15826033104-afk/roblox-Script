-- ===================== 原生加载提示框 =====================
local CoreGui = game:GetService("CoreGui")
local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "ScriptLoadingUI"
LoadingGui.ResetOnSpawn = false
LoadingGui.IgnoreGuiInset = true
LoadingGui.Parent = CoreGui

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(0, 280, 0, 45)
LoadingFrame.Position = UDim2.new(1, -300, 1, -70)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
LoadingFrame.BackgroundTransparency = 0.2
LoadingFrame.BorderSizePixel = 1
LoadingFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
LoadingFrame.Parent = LoadingGui

local LoadingText = Instance.new("TextLabel")
LoadingText.Size = UDim2.new(1, 0, 1, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingText.Font = Enum.Font.SourceSansBold
LoadingText.TextSize = 14
LoadingText.Text = "正在加载 Orion 引擎..."
LoadingText.Parent = LoadingFrame

-- ===================== 网络加速与节点加载核心 =====================
local startTime = tick()
local OrionLib = nil
local rawGithubUrl = "https://raw.githubusercontent.com/shlexware/Orion/main/source"
local proxyUrls = {
    "https://gh-proxy.com/" .. rawGithubUrl,
    "https://ghproxy.net/" .. rawGithubUrl,
    "https://github.akams.cn/" .. rawGithubUrl,
    "https://raw.gitmirror.com/shlexware/Orion/main/source",
    "https://cdn.jsdelivr.net/gh/shlexware/Orion@main/source",
    "https://fastly.jsdelivr.net/gh/shlexware/Orion@main/source"
}
local alternativeSources = {
    "https://raw.githubusercontent.com/DenDenZZZ/Orion-UI-Library/refs/heads/main/source",
    "https://raw.githubusercontent.com/Qanuir/orion-ui/refs/heads/main/source.lua"
}

local function tryLoad(url)
    local ok, res = pcall(function()
        local body = game:HttpGet(url)
        if body and #body > 500 then return loadstring(body)() end
        return nil
    end)
    if ok and res then return res end
    return nil
end

LoadingText.Text = "正在并发测速节点..."
local fastestUrl = nil
local threads = 0
local completed = false

for _, url in ipairs(proxyUrls) do
    threads = threads + 1
    task.spawn(function()
        local res = tryLoad(url)
        if res and not completed then
            OrionLib = res
            fastestUrl = url
            completed = true
        end
        threads = threads - 1
    end)
end

local waitStart = tick()
while threads > 0 and not completed and (tick() - waitStart) < 3 do task.wait(0.1) end

if not OrionLib then
    LoadingText.Text = "正在尝试备选源码..."
    for _, url in ipairs(alternativeSources) do
        task.wait(0.3)
        local res = tryLoad(url)
        if res then
            OrionLib = res
            break
        end
    end
end

if not OrionLib then
    LoadingText.Text = "所有节点与备选源均失效！\n即将自动退出游戏..."
    LoadingText.TextColor3 = Color3.fromRGB(255, 50, 50)
    task.wait(3)
    LoadingGui:Destroy()
    pcall(function() game:GetService("Players").LocalPlayer:Kick("❌ 脚本加载失败: 网络无法连接。") end)
    return
end

local endTime = tick()
LoadingText.Text = string.format("UI 加载成功！耗时 %.2f 秒", endTime - startTime)
LoadingText.TextColor3 = Color3.fromRGB(50, 255, 50)
task.delay(3, function()
    game:GetService("TweenService"):Create(LoadingFrame, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
    game:GetService("TweenService"):Create(LoadingText, TweenInfo.new(1), {TextTransparency = 1}):Play()
    task.wait(1)
    LoadingGui:Destroy()
end)

-- ===================== ★ 核心修改：劫持 Orion 的加载界面 =====================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function hijackOrionIntro()
    local targetGui = CoreGui
    if not pcall(function() return CoreGui end) then targetGui = LocalPlayer:FindFirstChildOfClass("PlayerGui") end
    
    targetGui.ChildAdded:Connect(function(child)
        if child.Name == "OrionIntro" then
            task.wait(0.1) -- 等待里面的文字和图标生成
            for _, obj in pairs(child:GetDescendants()) do
                -- 把默认的 "Orion Library" 改掉
                if obj:IsA("TextLabel") and obj.Text == "Orion Library" then
                    obj.Text = "致命猿猴 · 终极辅助"
                end
            end
            
            -- 如果你觉得默认 1.5 秒动画太磨叽，想直接秒开，把下面这句取消注释即可：
            -- child:Destroy()
        end
    end)
end
hijackOrionIntro()
-- ================================================================================

-- ===================== 基础服务 =====================
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()
local hasDrawing = pcall(function() return Drawing end) and Drawing ~= nil

Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    Camera = Workspace.CurrentCamera
end)

local initialSpeed = 16
local initialJump = 50
if LocalPlayer.Character then
    local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        initialSpeed = hum.WalkSpeed
        initialJump = hum.UseJumpPower and hum.JumpPower or 50
    end
end

-- ===================== 核心状态 =====================
local State = {
    ESP_Players = false, ESP_NPCs = false, ESP_Items = false,
    ESP_MaxDistance = 3000, ESP_Limit = 200, ESP_SortByDist = true, 
    DrawBox = true, DrawLine = true, DrawName = true, DrawHighlight = false, 
    DrawSkeleton = false, DrawHealthBar = true, 
    ESP_UpdateRate = 60, 

    CustomItems = {"gold", "copper", "diamond", "scrap", "ore", "bar", "coin", "cash", "loot"},
    MonsterKeywords = {"ape", "monster", "enemy", "mutant", "creature", "beast", "gorilla", "killer", "hunter", "predator", "nightmare", "terror", "sandman", "ashy", "kus", "gus", "dus", "scar", "bloodman", "gooba", "fearful", "flesher", "fluddy", "glitch", "lurker"},
    BlacklistKeywords = {"jumpscare", "scare", "decoy", "fake", "static", "prop", "corpse", "dead", "body", "ragdoll", "dummy", "visual", "effect", "particle", "screen", "ui", "gui", "sound", "trigger", "ambient", "decoration", "waypoint", "path", "node", "spawn", "wall"},
    WalkSpeed = initialSpeed, JumpPower = initialJump, Noclip = false, 
    Fly = false, FlySpeed = 60, FlyMode = "Smooth", InfiniteJump = false, ThirdPerson = false, 
    Spin = false, AntiFling = false, Anchor = false, Invisible = false,
    HitboxExpand = false, HitboxSize = 10, AutoPickup = false, AutoFollow = false,
    AntiSlow = false, SafeEggLoop = false, SafeEggInterval = 2.0,
    
    ThreatAlert = false, ThreatDistance = 50, AntiFog = false,
    LockBloodman = false, LockBloodmanMode = "锁定视角", LockBloodmanDistance = 150,
    EggKeywords = {"egg", "event", "halloween", "portal", "gate", "altar", "unlock", "badge", "mode"},
    TracerOrigin = "屏幕底部", TracerColor = Color3.fromRGB(0, 255, 100)
}

LocalPlayer.CharacterAdded:Connect(function(newChar)
    task.wait(1)
    local hum = newChar:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = State.WalkSpeed end
end)

-- ===================== 怪物与物品识别 =====================
local function isNPC(obj)
    if not obj:IsA("Model") then return false end
    if Players:GetPlayerFromCharacter(obj) then return false end
    local name = obj.Name:lower()
    local parentName = obj.Parent and obj.Parent.Name:lower() or ""
    for _, kw in ipairs(State.BlacklistKeywords) do
        if name:find(kw, 1, true) or parentName:find(kw, 1, true) then return false end
    end
    local parent = obj.Parent
    while parent and parent ~= Workspace do
        if parent:IsA("Model") then
            for _, kw in ipairs(State.MonsterKeywords) do
                if parent.Name:lower():find(kw, 1, true) then return false end
            end
        end
        parent = parent.Parent
    end
    local hasHumanoid = obj:FindFirstChildOfClass("Humanoid") ~= nil
    local isKeyword = false
    for _, kw in ipairs(State.MonsterKeywords) do
        if name:find(kw, 1, true) then isKeyword = true break end
    end
    if isKeyword and not hasHumanoid then
        local validSize = false
        for _, p in ipairs(obj:GetDescendants()) do
            if p:IsA("BasePart") and p.Size.Magnitude > 2 then validSize = true break end
        end
        if not validSize then return false end
    end
    return isKeyword or hasHumanoid
end

local function isLoot(part)
    if not part:IsA("BasePart") then return false end
    local n = part.Name:lower()
    local parentName = part.Parent and part.Parent.Name:lower() or ""
    for _, kw in ipairs(State.CustomItems) do
        if n:find(kw, 1, true) or parentName:find(kw, 1, true) then return true end
    end
    return false
end

-- ===================== 缓存与对象池 =====================
local ESPCache = {} 
local MonsterCache = {} 
local CachedItemTargets = {} 
local SortedTargets = {} 
local OriginalHitboxSizes = {}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Universal_ESP"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = CoreGui

local ThreatGui = Instance.new("Frame")
ThreatGui.Size = UDim2.new(1, 0, 1, 0)
ThreatGui.BackgroundTransparency = 1
ThreatGui.Parent = ScreenGui
local ThreatUIStroke = Instance.new("UIStroke")
ThreatUIStroke.Thickness = 15
ThreatUIStroke.Color = Color3.fromRGB(255, 0, 0)
ThreatUIStroke.Transparency = 1
ThreatUIStroke.Parent = ThreatGui

local Crosshair = Instance.new("Frame")
Crosshair.Size = UDim2.new(0, 4, 0, 4)
Crosshair.Position = UDim2.new(0.5, -2, 0.5, -2)
Crosshair.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
Crosshair.BorderSizePixel = 0
Crosshair.Visible = false
Crosshair.Parent = ScreenGui

local RadarGui = Instance.new("Frame")
RadarGui.Size = UDim2.new(0, 150, 0, 120)
RadarGui.Position = UDim2.new(0, 20, 0.3, 0)
RadarGui.BackgroundTransparency = 0.5
RadarGui.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
RadarGui.BorderSizePixel = 1
RadarGui.BorderColor3 = Color3.fromRGB(255, 255, 255)
RadarGui.Visible = false
RadarGui.Parent = ScreenGui

local RadarText = Instance.new("TextLabel")
RadarText.Size = UDim2.new(1, 0, 1, 0)
RadarText.BackgroundTransparency = 1
RadarText.TextColor3 = Color3.fromRGB(255, 215, 0)
RadarText.Font = Enum.Font.SourceSansBold
RadarText.TextSize = 14
RadarText.TextXAlignment = Enum.TextXAlignment.Left
RadarText.TextYAlignment = Enum.TextYAlignment.Top
RadarText.Text = "雷达加载中..."
RadarText.Parent = RadarGui

local ColorCorrection = Instance.new("ColorCorrectionEffect")
ColorCorrection.Parent = Lighting

-- ===================== 工具函数 =====================
local function getCharacter()
    local char = LocalPlayer.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return nil end
    return char, hrp, hum
end

local function getTargetRoot(target)
    if target:IsA("Model") then
        return target:FindFirstChild("HumanoidRootPart") or target:FindFirstChild("Head") or target:FindFirstChild("UpperTorso") or target:FindFirstChild("Torso") or target:FindFirstChildWhichIsA("BasePart")
    elseif target:IsA("BasePart") then
        return target
    end
    return nil
end

-- ===================== 事件驱动监听 =====================
local function addToMonsterCache(obj)
    if obj:IsA("Model") and isNPC(obj) then MonsterCache[obj] = true end
end
for _, obj in ipairs(Workspace:GetDescendants()) do addToMonsterCache(obj) end
Workspace.DescendantAdded:Connect(function(obj) task.wait(0.1) addToMonsterCache(obj) end)
Workspace.DescendantRemoving:Connect(function(obj) if MonsterCache[obj] then MonsterCache[obj] = nil end end)

task.spawn(function()
    while task.wait(1) do
        if State.ESP_Items then
            local newItems = {}
            local _, hrp = getCharacter()
            if hrp then
                local params = OverlapParams.new()
                params.FilterType = Enum.RaycastFilterType.Exclude
                params.FilterDescendantsInstances = {LocalPlayer.Character}
                local parts = Workspace:GetPartBoundsInRadius(hrp.Position, State.ESP_MaxDistance, params)
                for _, part in ipairs(parts) do
                    if isLoot(part) then table.insert(newItems, part) end
                end
            end
            CachedItemTargets = newItems
        else
            table.clear(CachedItemTargets)
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        local char, hrp = getCharacter()
        if not char or not hrp then continue end
        
        local rawTargets = {}
        if State.ESP_Players then
            for _, p in ipairs(Players:GetPlayers()) do 
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then 
                    table.insert(rawTargets, {Target = p.Character, Color = Color3.fromRGB(0, 255, 0)}) 
                end
            end
        end
        if State.ESP_NPCs then
            for obj, _ in pairs(MonsterCache) do
                if obj.Parent then table.insert(rawTargets, {Target = obj, Color = Color3.fromRGB(255, 50, 50)}) end
            end
        end
        if State.ESP_Items then
            for _, obj in ipairs(CachedItemTargets) do
                if obj and obj.Parent then table.insert(rawTargets, {Target = obj, Color = Color3.fromRGB(255, 215, 0)}) end
            end
        end
        
        for _, data in ipairs(rawTargets) do
            local root = getTargetRoot(data.Target)
            if root then data.Dist = (root.Position - hrp.Position).Magnitude else data.Dist = 9999 end
        end
        
        if State.ESP_SortByDist then
            table.sort(rawTargets, function(a,b) return a.Dist < b.Dist end)
        end
        SortedTargets = rawTargets
    end
end)

-- ===================== 穿墙逻辑 =====================
local NoclipSnapshot = {}
local function _applyNoclip()
    local char = LocalPlayer.Character
    if not char then return end
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") then
            if NoclipSnapshot[v] == nil then NoclipSnapshot[v] = v.CanCollide end
            v.CanCollide = false
        end
    end
end
local function _restoreNoclip()
    for part, original in pairs(NoclipSnapshot) do
        if part and part.Parent then part.CanCollide = original end
    end
    table.clear(NoclipSnapshot)
end
local function toggleNoclip(bool)
    State.Noclip = bool
    if bool then
        if not State._noclipConn then
            _applyNoclip()
            State._noclipConn = RunService.Stepped:Connect(_applyNoclip)
        end
    else
        if State._noclipConn then State._noclipConn:Disconnect() State._noclipConn = nil end
        _restoreNoclip()
    end
end

-- ===================== 多飞行内核系统 =====================
local flyConn = nil
local flyObjects = {} 

local function clearFlyObjects()
    if flyConn then flyConn:Disconnect() flyConn = nil end
    for _, obj in pairs(flyObjects) do
        if obj and obj.Destroy then obj:Destroy() end
    end
    table.clear(flyObjects)
end

local function toggleFly(bool)
    State.Fly = bool
    local char, hrp, hum = getCharacter()
    clearFlyObjects()
    if not char or not hrp or not hum then return end

    if bool then
        if not State.Noclip then _applyNoclip() end
        hum.AutoRotate = false
        hum.PlatformStand = false
        
        local cam = Workspace.CurrentCamera
        local function getMoveVelocity()
            local moveDir = hum.MoveDirection
            local velocity = Vector3.zero
            if moveDir.Magnitude > 0 then
                local objMove = cam.CFrame:VectorToObjectSpace(moveDir)
                local dir = (cam.CFrame.LookVector * -objMove.Z + cam.CFrame.RightVector * objMove.X)
                if dir.Magnitude > 0.01 then velocity = dir.Unit * State.FlySpeed end
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) or (UserInputService.TouchEnabled and hum.Jump) then
                velocity = velocity + Vector3.new(0, State.FlySpeed, 0)
            end
            return velocity
        end

        if State.FlyMode == "Smooth" then
            local att = Instance.new("Attachment") att.Name = "FlyAttachment" att.Parent = hrp
            local lv = Instance.new("LinearVelocity") lv.Name = "FlyLinearVelocity" lv.Attachment0 = att lv.MaxForce = math.huge 
            lv.VectorVelocity = Vector3.zero 
            lv.Parent = hrp
            local ao = Instance.new("AlignOrientation") ao.Name = "FlyAlignOrientation" ao.Attachment0 = att ao.MaxTorque = math.huge ao.Responsiveness = 100 ao.Mode = Enum.OrientationAlignmentMode.OneAttachment ao.Parent = hrp
            table.insert(flyObjects, att) table.insert(flyObjects, lv) table.insert(flyObjects, ao)
            flyConn = RunService.RenderStepped:Connect(function()
                if not hrp.Parent or not State.Fly then return end
                local flatLook = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)
                ao.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + (flatLook.Magnitude > 0.01 and flatLook.Unit or Vector3.new(0,0,1)))
                lv.VectorVelocity = getMoveVelocity()
            end)
        elseif State.FlyMode == "CFrame" then
            local bf = Instance.new("BodyForce") bf.Force = Vector3.new(0, Workspace.Gravity * hrp:GetMass(), 0) bf.Parent = hrp
            table.insert(flyObjects, bf)
            flyConn = RunService.RenderStepped:Connect(function(dt)
                if not hrp.Parent or not State.Fly then return end
                local v3 = getMoveVelocity()
                hrp.CFrame = hrp.CFrame + (v3 * dt) 
                local flatLook = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)
                if flatLook.Magnitude > 0.01 then hrp.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + flatLook.Unit) end
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.AssemblyAngularVelocity = Vector3.zero
            end)
        elseif State.FlyMode == "Classic" then
            local bv = Instance.new("BodyVelocity") bv.Name = "FlyBodyVel" bv.MaxForce = Vector3.new(1e5, 1e5, 1e5) bv.Velocity = Vector3.zero bv.Parent = hrp
            local bg = Instance.new("BodyGyro") bg.Name = "FlyBodyGyro" bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5) bg.D = 50 bg.P = 3000 bg.Parent = hrp
            table.insert(flyObjects, bv) table.insert(flyObjects, bg)
            flyConn = RunService.RenderStepped:Connect(function()
                if not hrp.Parent or not State.Fly then return end
                local flatLook = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)
                bg.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + (flatLook.Magnitude > 0.01 and flatLook.Unit or Vector3.new(0,0,1)))
                bv.Velocity = getMoveVelocity()
            end)
        end
    else
        if hrp and hum then
            hum.AutoRotate = true
            hum.PlatformStand = false
            hrp.AssemblyAngularVelocity = Vector3.zero
            hrp.AssemblyLinearVelocity = Vector3.zero
            if not State.Noclip then _restoreNoclip() end
            task.spawn(function()
                task.wait(0.1)
                if hum.Parent and hum.Health > 0 and not State.Fly then pcall(function() hum:ChangeState(Enum.HumanoidStateType.Running) end) end
            end)
        end
    end
end

-- ===================== 实用功能 =====================
local invisConn
local function toggleInvisibility(bool)
    State.Invisible = bool
    local char = LocalPlayer.Character
    if not char then return end
    if bool then
        if not invisConn then
            invisConn = RunService.Stepped:Connect(function()
                local c = LocalPlayer.Character
                if c then
                    for _, v in pairs(c:GetDescendants()) do
                        if v:IsA("BasePart") then v.LocalTransparencyModifier = 1 end
                        if v:IsA("Decal") then v.Transparency = 1 end
                    end
                end
            end)
        end
    else
        if invisConn then invisConn:Disconnect() invisConn = nil end
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then v.LocalTransparencyModifier = 0 end
            if v:IsA("Decal") then v.Transparency = 0 end
        end
    end
end

local function AutoScrap()
    local char, hrp = getCharacter()
    if not char or not hrp then return end
    local found = false
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local name = obj.Name:lower()
            if name:find("scrap") or name:find("deposit") or name:find("sell") or name:find("exchange") then
                local prompt = obj:FindFirstChildOfClass("ProximityPrompt")
                if prompt then
                    pcall(function() hrp.CFrame = obj.CFrame + Vector3.new(0, 3, 0) end)
                    task.wait(0.3)
                    pcall(function() fireproximityprompt(prompt) end)
                    found = true
                end
            end
        end
    end
    if found then OrionLib:MakeNotification({ Name = "自动兑换", Content = "已自动传送到回收机并提交物品！", Time = 4 })
    else OrionLib:MakeNotification({ Name = "自动兑换", Content = "地图中未找到回收机 (Scrapper)", Time = 4 }) end
end

-- ===================== 安全彩蛋破解逻辑 =====================
local function SafeEggUnlock()
    local rs = game:GetService("ReplicatedStorage")
    local found = false
    for _, container in ipairs({rs, game:GetService("ReplicatedFirst")}) do
        for _, obj in ipairs(container:GetDescendants()) do
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                local name = obj.Name:lower()
                local isTarget = false
                for _, kw in ipairs(State.EggKeywords) do
                    if name:find(kw, 1, true) then isTarget = true break end
                end
                if isTarget then
                    found = true
                    if obj:IsA("RemoteEvent") then
                        pcall(function() obj:FireServer("unlock") end)
                        pcall(function() obj:FireServer(true) end)
                    elseif obj:IsA("RemoteFunction") then
                        pcall(function() obj:InvokeServer("unlock") end)
                    end
                end
            end
        end
    end
    if found then OrionLib:MakeNotification({ Name = "安全破解", Content = "已向符合条件的彩蛋发送解锁请求", Time = 3 }) end
end

local function RunSafeEggLoop()
    while State.SafeEggLoop do
        SafeEggUnlock()
        task.wait(State.SafeEggInterval)
    end
end

-- ===================== 后台心跳逻辑 =====================
task.spawn(function()
    while task.wait(0.1) do
        local char, hrp, hum = getCharacter()
        if not char or not hrp then continue end
        
        if State.HitboxExpand then
            for obj, _ in pairs(MonsterCache) do
                if obj.Parent then
                    local targetPart = getTargetRoot(obj)
                    if targetPart then
                        if not OriginalHitboxSizes[targetPart] then
                            OriginalHitboxSizes[targetPart] = { Size = targetPart.Size, CanCollide = targetPart.CanCollide }
                        end
                        targetPart.Size = Vector3.new(State.HitboxSize, State.HitboxSize, State.HitboxSize)
                        targetPart.Transparency = 0.5
                        targetPart.CanCollide = false
                    end
                end
            end
        else
            for obj, data in pairs(OriginalHitboxSizes) do
                if obj and obj.Parent then
                    obj.Size = data.Size
                    obj.Transparency = 0
                    obj.CanCollide = data.CanCollide
                end
            end
            table.clear(OriginalHitboxSizes)
        end
        
        if State.AutoFollow then
            local closest, dist = nil, math.huge
            for obj, _ in pairs(MonsterCache) do
                local root = getTargetRoot(obj)
                if root then
                    local d = (root.Position - hrp.Position).Magnitude
                    if d < dist and d < 500 then closest, dist = root, d end
                end
            end
            if closest then Camera.CFrame = Camera.CFrame:Lerp(CFrame.lookAt(Camera.CFrame.Position, closest.Position), 0.15) end
        end
        
        if State.AutoPickup then
            local params = OverlapParams.new() params.FilterType = Enum.RaycastFilterType.Exclude params.FilterDescendantsInstances = {char}
            for _, part in ipairs(Workspace:GetPartBoundsInRadius(hrp.Position, 150, params)) do
                local prompt = part:FindFirstChildOfClass("ProximityPrompt") 
                if prompt and isLoot(part) then pcall(function() fireproximityprompt(prompt) end) end 
            end
        end
        if RadarGui.Visible then
            local itemList = {}
            for _, part in ipairs(Workspace:GetDescendants()) do
                if isLoot(part) and part:IsA("BasePart") then
                    local d = (part.Position - hrp.Position).Magnitude
                    if d < 500 then table.insert(itemList, {Name = part.Name, Dist = d}) end
                end
            end
            table.sort(itemList, function(a, b) return a.Dist < b.Dist end)
            local text = "【物品雷达】\n"
            for i = 1, math.min(#itemList, 5) do text = text .. string.format("%s - %dm\n", itemList[i].Name, math.floor(itemList[i].Dist)) end
            if #itemList == 0 then text = text .. "附近无物品\n" end
            RadarText.Text = text
        end
    end
end)

-- ===================== 第三人称强开 =====================
RunService.RenderStepped:Connect(function()
    if State.ThirdPerson then
        LocalPlayer.CameraMode = Enum.CameraMode.Classic
        LocalPlayer.CameraMinZoomDistance = 15 
        LocalPlayer.CameraMaxZoomDistance = 1000
        if Camera.CameraType == Enum.CameraType.Scriptable or Camera.CameraType == Enum.CameraType.Fixed then
            Camera.CameraType = Enum.CameraType.Custom
        end
    else
        if LocalPlayer.CameraMinZoomDistance > 0.5 then LocalPlayer.CameraMinZoomDistance = 0.5 end
        if LocalPlayer.CameraMaxZoomDistance < 128 then LocalPlayer.CameraMaxZoomDistance = 128 end
    end
end)

-- ===================== 纯 Drawing 极致渲染引擎 =====================
local R6Bones = { {"Head", "Torso"}, {"Torso", "Left Arm"}, {"Torso", "Right Arm"}, {"Torso", "Left Leg"}, {"Torso", "Right Leg"} }
local R15Bones = {
    {"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"}, {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"}, {"LeftLowerArm", "LeftHand"},
    {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"}, {"RightLowerArm", "RightHand"},
    {"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"}, {"LeftLowerLeg", "LeftFoot"},
    {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}, {"RightLowerLeg", "RightFoot"}
}

local function createDrawingCache(target)
    if ESPCache[target] then return ESPCache[target] end
    local cache = { Bones = {} }
    
    if hasDrawing then
        cache.Box = Drawing.new("Square")
        cache.Box.Thickness = 1
        cache.Box.Transparency = 1
        cache.Box.Filled = false
        cache.Box.Visible = false

        cache.Name = Drawing.new("Text")
        cache.Name.Size = 14
        cache.Name.Center = true
        cache.Name.Outline = true
        cache.Name.Visible = false

        cache.HealthBg = Drawing.new("Square")
        cache.HealthBg.Filled = true
        cache.HealthBg.Color = Color3.new(0,0,0)
        cache.HealthBg.Visible = false

        cache.HealthBar = Drawing.new("Square")
        cache.HealthBar.Filled = true
        cache.HealthBar.Visible = false

        cache.Tracer = Drawing.new("Line")
        cache.Tracer.Thickness = 1
        cache.Tracer.Transparency = 1
        cache.Tracer.Visible = false
        
        local hum = target:FindFirstChildOfClass("Humanoid")
        if hum then
            local bones = (hum.RigType == Enum.HumanoidRigType.R6) and R6Bones or R15Bones
            for i = 1, #bones do
                local line = Drawing.new("Line")
                line.Thickness = 1
                line.Transparency = 1
                line.Visible = false
                table.insert(cache.Bones, line)
            end
        end
    else
        cache.Billboard = Instance.new("BillboardGui")
        cache.Billboard.Size = UDim2.new(0, 100, 0, 30)
        cache.Billboard.StudsOffset = Vector3.new(0, 3, 0)
        cache.Billboard.AlwaysOnTop = true
        cache.Billboard.Enabled = false
        
        cache.Name = Instance.new("TextLabel")
        cache.Name.BackgroundTransparency = 1
        cache.Name.Size = UDim2.new(1, 0, 1, 0)
        cache.Name.Font = Enum.Font.SourceSansBold
        cache.Name.TextSize = 14
        cache.Name.TextStrokeTransparency = 0
        cache.Name.Parent = cache.Billboard
        cache.Billboard.Parent = target
    end
    
    ESPCache[target] = cache
    return cache
end

local lastRenderTime = 0
RunService.RenderStepped:Connect(function()
    local now = tick()
    if now - lastRenderTime < (1 / State.ESP_UpdateRate) then return end
    lastRenderTime = now

    local char, hrp, hum = getCharacter()
    if not char or not hrp then return end
    
    if State.LockBloodman then
        local bloodmanRoot = nil
        local closestDist = math.huge
        for obj, _ in pairs(MonsterCache) do
            if obj.Parent and obj.Name:lower():find("bloodman") then
                local root = getTargetRoot(obj)
                if root then
                    local d = (root.Position - hrp.Position).Magnitude
                    if d < closestDist and d <= State.LockBloodmanDistance then
                        closestDist = d
                        bloodmanRoot = root
                    end
                end
            end
        end
        
        if bloodmanRoot then
            if State.LockBloodmanMode == "锁定视角" then
                local newCamCFrame = CFrame.lookAt(Camera.CFrame.Position, bloodmanRoot.Position)
                Camera.CFrame = Camera.CFrame:Lerp(newCamCFrame, 0.2)
            elseif State.LockBloodmanMode == "锁定身体" then
                hum.AutoRotate = false
                local lookAtPos = Vector3.new(bloodmanRoot.Position.X, hrp.Position.Y, bloodmanRoot.Position.Z)
                local lookAt = CFrame.lookAt(hrp.Position, lookAtPos)
                local x, _, z = hrp.CFrame:ToEulerAnglesXYZ()
                local _, newY, _ = lookAt:ToEulerAnglesXYZ()
                hrp.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(x, newY, z)
            end
        else
            if State.LockBloodmanMode == "锁定身体" then hum.AutoRotate = true end
        end
    else
        if hum then hum.AutoRotate = true end
    end

    if State.ThreatAlert then
        local closestDist = math.huge
        for obj, _ in pairs(MonsterCache) do
            if obj.Parent then
                local root = getTargetRoot(obj)
                if root then
                    local d = (root.Position - hrp.Position).Magnitude
                    if d < closestDist then closestDist = d end
                end
            end
        end
        if closestDist <= State.ThreatDistance then
            local alpha = 0.5 + 0.5 * math.sin(tick() * 10)
            ThreatUIStroke.Transparency = 1 - alpha
        else
            ThreatUIStroke.Transparency = 1
        end
    else
        ThreatUIStroke.Transparency = 1
    end

    local activeTargets = {}
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
    local tracerFrom = screenCenter
    if State.TracerOrigin == "鼠标位置" then tracerFrom = UserInputService:GetMouseLocation() end
    
    for i = 1, math.min(#SortedTargets, State.ESP_Limit) do
        local data = SortedTargets[i] 
        local target = data.Target 
        local dist = data.Dist
        
        if dist <= State.ESP_MaxDistance then
            local rootPart = getTargetRoot(target)
            if rootPart then
                activeTargets[target] = true
                local cache = createDrawingCache(target)
                
                local distRatio = math.clamp(dist / 500, 0, 1)
                local finalColor = Color3.fromRGB(255, 50, 50):Lerp(Color3.fromRGB(50, 255, 50), distRatio)

                if hasDrawing then
                    local vpPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                    if onScreen and vpPos.Z > 0 then
                        local headPos = Camera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, 2.5, 0))
                        local legPos = Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 2.5, 0))
                        local height = math.abs(headPos.Y - legPos.Y) local width = math.max(height * 0.6, 20) if height < 10 then height = 40 end

                        cache.Box.Visible = State.DrawBox
                        cache.Box.Size = Vector2.new(width, height)
                        cache.Box.Position = Vector2.new(vpPos.X - width/2, vpPos.Y - height/2)
                        cache.Box.Color = finalColor
                        
                        cache.Name.Visible = State.DrawName
                        cache.Name.Text = target.Name .. string.format(" [%dm]", math.floor(dist))
                        cache.Name.Position = Vector2.new(vpPos.X, vpPos.Y - height/2 - 18)
                        cache.Name.Color = finalColor

                        local hum = target:FindFirstChildOfClass("Humanoid")
                        if State.DrawHealthBar and hum then
                            local hpRatio = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                            cache.HealthBg.Visible = true
                            cache.HealthBg.Size = Vector2.new(3, height)
                            cache.HealthBg.Position = Vector2.new(vpPos.X - width/2 - 6, vpPos.Y - height/2)
                            
                            cache.HealthBar.Visible = true
                            cache.HealthBar.Size = Vector2.new(3, height * hpRatio)
                            cache.HealthBar.Position = Vector2.new(vpPos.X - width/2 - 6, vpPos.Y - height/2 + (height * (1 - hpRatio)))
                            cache.HealthBar.Color = Color3.fromRGB(255, 50, 50):Lerp(Color3.fromRGB(50, 255, 50), hpRatio)
                        else
                            if cache.HealthBg then cache.HealthBg.Visible = false end
                            if cache.HealthBar then cache.HealthBar.Visible = false end
                        end
                        
                        cache.Tracer.Visible = State.DrawLine
                        if State.DrawLine then
                            cache.Tracer.From = tracerFrom
                            cache.Tracer.To = Vector2.new(vpPos.X, vpPos.Y)
                            cache.Tracer.Color = State.TracerColor
                        end

                        if State.DrawSkeleton and target:IsA("Model") and #cache.Bones > 0 then
                            local hum = target:FindFirstChildOfClass("Humanoid")
                            if hum then
                                local bones = (hum.RigType == Enum.HumanoidRigType.R6) and R6Bones or R15Bones
                                for bIdx, bonePair in ipairs(bones) do
                                    local p1 = target:FindFirstChild(bonePair[1]) local p2 = target:FindFirstChild(bonePair[2]) local line = cache.Bones[bIdx]
                                    if p1 and p2 then
                                        local v1, o1 = Camera:WorldToViewportPoint(p1.Position) local v2, o2 = Camera:WorldToViewportPoint(p2.Position)
                                        if o1 and o2 and v1.Z > 0 and v2.Z > 0 then
                                            line.From = Vector2.new(v1.X, v1.Y) line.To = Vector2.new(v2.X, v2.Y) line.Visible = true line.Color = finalColor
                                        else line.Visible = false end
                                    else line.Visible = false end
                                end
                            end
                        else
                            if cache.Bones then for _, line in ipairs(cache.Bones) do line.Visible = false end end
                        end
                    else
                        cache.Box.Visible = false; cache.Name.Visible = false
                        if cache.HealthBg then cache.HealthBg.Visible = false end
                        if cache.HealthBar then cache.HealthBar.Visible = false end
                        cache.Tracer.Visible = false
                        if cache.Bones then for _, line in ipairs(cache.Bones) do line.Visible = false end end
                    end
                else
                    if cache.Billboard then
                        cache.Billboard.Enabled = true
                        cache.Name.Text = target.Name .. string.format(" [%dm]", math.floor(dist))
                        cache.Name.TextColor3 = finalColor
                    end
                end
            end
        end
    end

    for target, cache in pairs(ESPCache) do
        if not activeTargets[target] then
            if hasDrawing then
                cache.Box.Visible = false
                cache.Name.Visible = false
                if cache.HealthBg then cache.HealthBg.Visible = false end
                if cache.HealthBar then cache.HealthBar.Visible = false end
                cache.Tracer.Visible = false
                if cache.Bones then for _, line in ipairs(cache.Bones) do line.Visible = false end end
            else
                if cache.Billboard then cache.Billboard.Enabled = false end
            end
            
            if not target.Parent then
                task.spawn(function()
                    task.wait(5)
                    if not target.Parent then
                        if hasDrawing then
                            pcall(function() cache.Box:Remove() cache.Name:Remove() cache.HealthBg:Remove() cache.HealthBar:Remove() cache.Tracer:Remove() end)
                            if cache.Bones then for _, line in ipairs(cache.Bones) do pcall(function() line:Remove() end) end end
                        else
                            if cache.Billboard then cache.Billboard:Destroy() end
                        end
                        ESPCache[target] = nil
                    end
                end)
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    local char, hrp, hum = getCharacter()
    if not char or not hum then return end
    if State.AntiFling and hrp.AssemblyAngularVelocity.Magnitude > 50 then hrp.AssemblyAngularVelocity = Vector3.zero end
    if State.Spin then hrp.AssemblyAngularVelocity = Vector3.new(0, 50, 0) end
    if State.Anchor then hrp.Anchored = true else hrp.Anchored = false end
    if State.AntiSlow and hum.WalkSpeed < State.WalkSpeed and not State.Fly then hum.WalkSpeed = State.WalkSpeed end
end)

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

-- ===================== 双向同步防递归 =====================
local Sync = { NPCToggle = {}, FlyToggle = {}, PickupToggle = {} }
local _syncing = false
local function syncSet(group, value, skip)
    if _syncing then return end
    _syncing = true
    for _, toggle in ipairs(group) do
        if toggle ~= skip and toggle then
            if type(toggle.Set) == "function" then pcall(function() toggle:Set(value) end) end
        end
    end
    _syncing = false
end

-- ===================== Orion Library UI 构建 =====================
local Window = OrionLib:MakeWindow({
    Name = "致命猿猴 · 终极辅助",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "LethalApeUltimate"
})

--[[ 主页 ]]
local HomeTab = Window:MakeTab({ Name = "主页", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local H_Left = HomeTab:AddSection({ Name = "快捷功能" })
local H_Right = HomeTab:AddSection({ Name = "系统状态与信息" })

H_Left:AddLabel("🌟 此项目由 AI 辅助制作，公益且开源，不要倒卖！")
H_Left:AddButton({ Name = "一键复制作者 UID", Callback = function() local ok = pcall(function() setclipboard("3493115679738813") end) if ok then OrionLib:MakeNotification({ Name = "复制成功", Content = "作者 UID 已复制！", Time = 4 }) else OrionLib:MakeNotification({ Name = "复制失败", Content = "执行器不支持剪贴板。", Time = 4 }) end end })
H_Left:AddButton({ Name = "一键重进当前服务器", Callback = function() OrionLib:MakeNotification({ Name = "服务器", Content = "正在尝试重新连接...", Time = 3 }) task.wait(1) game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer) end })

local npcHome = H_Left:AddToggle({ Name = "主页快捷：怪物透视", Default = false, Callback = function(v) State.ESP_NPCs = v syncSet(Sync.NPCToggle, v, npcHome) end })
table.insert(Sync.NPCToggle, npcHome)
local flyHome = H_Left:AddToggle({ Name = "主页快捷：平滑飞行", Default = false, Callback = function(v) toggleFly(v) syncSet(Sync.FlyToggle, v, flyHome) end })
table.insert(Sync.FlyToggle, flyHome)
local pickHome = H_Left:AddToggle({ Name = "主页快捷：自动拾取", Default = false, Callback = function(v) State.AutoPickup = v syncSet(Sync.PickupToggle, v, pickHome) end })
table.insert(Sync.PickupToggle, pickHome)

local SysText = H_Right:AddLabel("实时系统状态: 正在获取性能数据...")
local _fpsCount = 0
RunService.RenderStepped:Connect(function() _fpsCount = _fpsCount + 1 end)
task.spawn(function()
    while task.wait(1) do
        local fps = _fpsCount _fpsCount = 0
        local ping = "获取中..."
        pcall(function() local stats = game:GetService("Stats") ping = math.floor(stats.Network.ServerStatsItem["Data Ping"]:GetValue()) .. " ms" end)
        if SysText and SysText.Text then pcall(function() SysText.Text = string.format("当前 FPS: %d | 延迟: %s\n服务器: %s", fps, ping, game.JobId) end) end
    end
end)

H_Right:AddSlider({ Name = "UI 界面缩放", Min = 0.5, Max = 1.5, Default = 1.0, Increment = 0.1, Color = Color3.fromRGB(0, 150, 255), Callback = function(v)
    local gui = CoreGui:FindFirstChild("Orion") if not gui then return end local root = gui:FindFirstAncestorOfClass("ScreenGui") or gui
    local scale = root:FindFirstChild("GlobalUIScale") if not scale then scale = Instance.new("UIScale") scale.Name = "GlobalUIScale" scale.Parent = root end
    scale.Scale = v
end })

H_Right:AddLabel("更新日志 (v1.1.2):\n1. 劫持并自定义了 Orion 默认加载界面\n2. 纯 Drawing 重写 ESP，极致优化")

--[[ 视觉与ESP ]]
local Tab1 = Window:MakeTab({ Name = "视觉与ESP", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local T1_Left = Tab1:AddSection({ Name = "ESP 目标与样式" })
local T1_Right = Tab1:AddSection({ Name = "环境与屏幕" })

T1_Left:AddToggle({ Name = "玩家透视 (绿)", Default = false, Callback = function(v) State.ESP_Players = v end })
local npcTab = T1_Left:AddToggle({ Name = "怪物透视 (红)", Default = false, Callback = function(v) State.ESP_NPCs = v syncSet(Sync.NPCToggle, v, npcTab) end })
table.insert(Sync.NPCToggle, npcTab)
T1_Left:AddToggle({ Name = "物品透视 (金)", Default = false, Callback = function(v) State.ESP_Items = v end })
T1_Left:AddToggle({ Name = "绘制 2D 方框", Default = true, Callback = function(v) State.DrawBox = v end })
T1_Left:AddToggle({ Name = "★ 显示 动态血量条", Default = true, Callback = function(v) State.DrawHealthBar = v end })
T1_Left:AddToggle({ Name = "★ 绘制 骨骼透视", Default = false, Callback = function(v) State.DrawSkeleton = v end })
T1_Left:AddToggle({ Name = "显示 名字与距离", Default = true, Callback = function(v) State.DrawName = v end })
T1_Left:AddToggle({ Name = "★ 实体 3D 高亮 (可能卡顿)", Default = false, Callback = function(v) State.DrawHighlight = v end })
T1_Left:AddSlider({ Name = "最大渲染数量", Min = 10, Max = 500, Default = 200, Increment = 10, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) State.ESP_Limit = v end })
T1_Left:AddSlider({ Name = "最大渲染距离", Min = 100, Max = 5000, Default = 3000, Increment = 100, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) State.ESP_MaxDistance = v end })
T1_Left:AddDropdown({ Name = "★ ESP 帧率限制 (防卡顿)", Default = "60 FPS", Options = {"15 FPS", "30 FPS", "60 FPS"}, Callback = function(opt) 
    if opt == "15 FPS" then State.ESP_UpdateRate = 15
    elseif opt == "30 FPS" then State.ESP_UpdateRate = 30
    elseif opt == "60 FPS" then State.ESP_UpdateRate = 60 end
end })
T1_Left:AddTextbox({ Name = "物品关键词", Default = "gold,copper,diamond,scrap,ore,bar,coin,cash,loot", TextDisappear = false, Callback = function(t) local new = {} for w in string.gmatch(t, "([^,]+)") do table.insert(new, string.lower(w):gsub("%s+", "")) end State.CustomItems = new end })
T1_Left:AddTextbox({ Name = "怪物关键词", Default = "ape,monster,enemy,mutant,creature,beast,gorilla,killer,hunter,predator,nightmare,terror,sandman,ashy,kus,gus,dus,scar,bloodman,gooba,fearful,flesher,fluddy,glitch,lurker", TextDisappear = false, Callback = function(t)
    local new = {} for w in string.gmatch(t, "([^,]+)") do table.insert(new, string.lower(w):gsub("%s+", "")) end State.MonsterKeywords = new
    table.clear(MonsterCache) for _, obj in ipairs(Workspace:GetDescendants()) do if obj:IsA("Model") and isNPC(obj) then MonsterCache[obj] = true end end
    OrionLib:MakeNotification({ Name = "怪物关键词", Content = "已更新并重新扫描地图", Time = 3 })
end })

local T1_Tracer = Tab1:AddSection({ Name = "追踪线设置 (Drawing)" })
T1_Tracer:AddToggle({ Name = "绘制 追踪线", Default = true, Callback = function(v) State.DrawLine = v end })
T1_Tracer:AddDropdown({ Name = "追踪线起点", Default = "屏幕底部", Options = { "屏幕底部", "鼠标位置" }, Callback = function(opt) State.TracerOrigin = opt end })
T1_Tracer:AddSlider({ Name = "追踪线颜色 (色相)", Min = 0, Max = 360, Default = 130, Increment = 1, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) State.TracerColor = Color3.fromHSV(v / 360, 1, 1) end })

T1_Right:AddButton({ Name = "微亮模式", Callback = function() Lighting.Ambient = Color3.fromRGB(100,100,100) Lighting.Brightness = 1 end })
T1_Right:AddButton({ Name = "极亮模式", Callback = function() Lighting.Ambient = Color3.fromRGB(255,255,255) Lighting.Brightness = 2 end })
T1_Right:AddToggle({ Name = "★ 绝对视距 (去雾)", Default = false, Callback = function(v) 
    State.AntiFog = v
    if v then Lighting.FogEnd = 9e9 else Lighting.FogEnd = 100000 end 
end })
T1_Right:AddSlider({ Name = "时间调节 (0-24)", Min = 0, Max = 24, Default = 14, Increment = 1, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) Lighting.ClockTime = v end })
T1_Right:AddSlider({ Name = "相机视野 FOV", Min = 70, Max = 120, Default = 70, Increment = 5, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) if Camera then Camera.FieldOfView = v end end })
T1_Right:AddToggle({ Name = "反色滤镜 (黑白)", Default = false, Callback = function(v) State.InvertColor = v ColorCorrection.Saturation = v and -1 or 0 end })
T1_Right:AddToggle({ Name = "物品雷达列表", Default = false, Callback = function(v) RadarGui.Visible = v end })
T1_Right:AddToggle({ Name = "开启屏幕准星", Default = false, Callback = function(v) Crosshair.Visible = v end })

--[[ 战斗与实用 ]]
local TabFight = Window:MakeTab({ Name = "战斗与实用", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local F_Left = TabFight:AddSection({ Name = "战斗与快捷操作" })
local F_Right = TabFight:AddSection({ Name = "安全彩蛋破解" })

F_Left:AddToggle({ Name = "扩大攻击判定框", Default = false, Callback = function(v) State.HitboxExpand = v end })
F_Left:AddSlider({ Name = "判定框大小", Min = 5, Max = 30, Default = 10, Increment = 1, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) State.HitboxSize = v end })

F_Left:AddToggle({ Name = "视角自动追踪怪物", Default = false, Callback = function(v) State.AutoFollow = v end })

-- 死锁 BloodMan 模块
F_Left:AddToggle({ Name = "★ 自动朝向 BloodMan", Default = false, Callback = function(v) State.LockBloodman = v end })
F_Left:AddDropdown({ Name = "锁定模式", Default = "锁定视角", Options = {"锁定视角", "锁定身体"}, Callback = function(opt) State.LockBloodmanMode = opt end })
F_Left:AddSlider({ Name = "锁定检测距离", Min = 50, Max = 500, Default = 150, Increment = 10, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) State.LockBloodmanDistance = v end })

-- 危险预警默认 50 米
F_Left:AddToggle({ Name = "危险预警 (红框闪烁)", Default = false, Callback = function(v) State.ThreatAlert = v end })
F_Left:AddSlider({ Name = "预警触发距离", Min = 5, Max = 200, Default = 50, Increment = 5, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) State.ThreatDistance = v end })

local pickTab = F_Left:AddToggle({ Name = "自动拾取 (靠近触发)", Default = false, Callback = function(v) State.AutoPickup = v syncSet(Sync.PickupToggle, v, pickTab) end })
table.insert(Sync.PickupToggle, pickTab)

F_Left:AddButton({ Name = "自动兑换 (传送到回收机)", Callback = function() AutoScrap() end })
F_Left:AddToggle({ Name = "物理隐身模式 (防怪)", Default = false, Callback = function(v) toggleInvisibility(v) end })

F_Right:AddToggle({ Name = "循环安全破解彩蛋门槛", Default = false, Callback = function(v) 
    State.SafeEggLoop = v
    if v then
        if not EggThread or coroutine.status(EggThread) == "dead" then EggThread = coroutine.create(RunSafeEggLoop) coroutine.resume(EggThread) end
        OrionLib:MakeNotification({ Name = "安全破解", Content = "已开启，仅针对关键 Remote 发包。", Time = 3 })
    end
end })
F_Right:AddSlider({ Name = "破解循环间隔 (秒)", Min = 0.5, Max = 5, Default = 2.0, Increment = 0.5, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) State.SafeEggInterval = v end })
F_Right:AddTextbox({ Name = "自定义彩蛋关键词", Default = "egg,event,halloween,portal,gate,altar,unlock,badge,mode", TextDisappear = false, Callback = function(t) local new = {} for w in string.gmatch(t, "([^,]+)") do table.insert(new, string.lower(w):gsub("%s+", "")) end State.EggKeywords = new end })
F_Right:AddButton({ Name = "强制装备彩蛋物品", Callback = function()
    local char = LocalPlayer.Character if char then local backpack = LocalPlayer:FindFirstChild("Backpack") if backpack then for _, tool in ipairs(backpack:GetChildren()) do if tool:IsA("Tool") then pcall(function() tool.Parent = char end) end end end OrionLib:MakeNotification({ Name = "装备", Content = "已尝试强制装备背包内的所有物品", Time = 3 }) end
end })

--[[ 移动与物理 ]]
local Tab2 = Window:MakeTab({ Name = "移动与物理", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local T2_Left = Tab2:AddSection({ Name = "移动与飞行" })
local T2_Right = Tab2:AddSection({ Name = "物理与环境" })

T2_Left:AddSlider({ Name = "行走速度", Min = 16, Max = 200, Default = initialSpeed, Increment = 2, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) State.WalkSpeed = v local _,_,h = getCharacter() if h then h.WalkSpeed = v end end })
T2_Left:AddSlider({ Name = "跳跃高度", Min = 50, Max = 300, Default = initialJump, Increment = 5, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) local _,_,h = getCharacter() if h then h.JumpPower = v end end })
T2_Left:AddToggle({ Name = "穿墙 (Noclip)", Default = false, Callback = function(v) toggleNoclip(v) end })
T2_Left:AddToggle({ Name = "无限跳跃", Default = false, Callback = function(v) toggleInfJump(v) end })

T2_Left:AddDropdown({ Name = "飞行内核选择", Default = "Smooth", Options = {"Smooth", "CFrame", "Classic"}, Callback = function(opt) 
    State.FlyMode = opt 
    if State.Fly then toggleFly(false) task.wait(0.1) toggleFly(true) end
end })

local flyTab = T2_Left:AddToggle({ Name = "自研无感飞行 (视线版)", Default = false, Callback = function(v) toggleFly(v) syncSet(Sync.FlyToggle, v, flyTab) end })
table.insert(Sync.FlyToggle, flyTab)
T2_Left:AddSlider({ Name = "飞行速度", Min = 20, Max = 150, Default = 60, Increment = 10, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) State.FlySpeed = v end })

T2_Right:AddToggle({ Name = "第三人称强开 (强力版)", Default = false, Callback = function(v) State.ThirdPerson = v end })
T2_Right:AddSlider({ Name = "全局重力调节", Min = 0, Max = 196, Default = 196, Increment = 5, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) Workspace.Gravity = v end })
T2_Right:AddSlider({ Name = "角色体型大小", Min = 0.5, Max = 3, Default = 1, Increment = 0.1, Color = Color3.fromRGB(0, 150, 255), Callback = function(v)
    local char = LocalPlayer.Character if not char then return end local h = char:FindFirstChildOfClass("Humanoid") if not h then return end
    pcall(function()
        if h.RigType == Enum.HumanoidRigType.R15 then h.BodyHeightScale = v h.BodyWidthScale = v h.BodyDepthScale = v h.HeadScale = v
        else
            local torso = char:FindFirstChild("Torso") if not torso then return end
            local parts = {torso, char:FindFirstChild("Head"), char:FindFirstChild("Left Arm"), char:FindFirstChild("Right Arm"), char:FindFirstChild("Left Leg"), char:FindFirstChild("Right Leg")}
            if not char:FindFirstChild("R6_ScaleCache") then
                local cache = Instance.new("Folder") cache.Name = "R6_ScaleCache" cache.Parent = char
                for _, p in pairs(parts) do if p then local v3 = Instance.new("Vector3Value") v3.Name = p.Name v3.Value = p.Size v3.Parent = cache end end
                for _, m in pairs(torso:GetChildren()) do if m:IsA("Motor6D") then
                    local c0 = Instance.new("CFrameValue") c0.Name = m.Name .. "_C0" c0.Value = m.C0 c0.Parent = cache
                    local c1 = Instance.new("CFrameValue") c1.Name = m.Name .. "_C1" c1.Value = m.C1 c1.Parent = cache
                end end
                local root = char:FindFirstChild("HumanoidRootPart") if root and root:FindFirstChild("RootJoint") then
                    local rj = root.RootJoint
                    local c0 = Instance.new("CFrameValue") c0.Name = "RootJoint_C0" c0.Value = rj.C0 c0.Parent = cache
                    local c1 = Instance.new("CFrameValue") c1.Name = "RootJoint_C1" c1.Value = rj.C1 c1.Parent = cache
                end
            end
            local cache = char:FindFirstChild("R6_ScaleCache") if cache then
                for _, p in pairs(parts) do if p then local orig = cache:FindFirstChild(p.Name) if orig then p.Size = orig.Value * v end end end
                for _, m in pairs(torso:GetChildren()) do if m:IsA("Motor6D") then
                    local c0Orig = cache:FindFirstChild(m.Name .. "_C0") local c1Orig = cache:FindFirstChild(m.Name .. "_C1")
                    if c0Orig and c1Orig then local pos0 = c0Orig.Value.Position * v m.C0 = (c0Orig.Value - c0Orig.Value.Position) + pos0 local pos1 = c1Orig.Value.Position * v m.C1 = (c1Orig.Value - c1Orig.Value.Position) + pos1 end
                end end
                local root = char:FindFirstChild("HumanoidRootPart") if root and root:FindFirstChild("RootJoint") then
                    local rj = root.RootJoint local c0Orig = cache:FindFirstChild("RootJoint_C0") local c1Orig = cache:FindFirstChild("RootJoint_C1")
                    if c0Orig and c1Orig then local pos0 = c0Orig.Value.Position * v rj.C0 = (c0Orig.Value - c0Orig.Value.Position) + pos0 local pos1 = c1Orig.Value.Position * v rj.C1 = (c1Orig.Value - c1Orig.Value.Position) + pos1 end
                end
                h.HipHeight = 2 * v
            end
        end
    end)
end })

T2_Right:AddToggle({ Name = "锁定位置 (防拖拽)", Default = false, Callback = function(v) State.Anchor = v end })
T2_Right:AddToggle({ Name = "防甩飞 (Anti-Fling)", Default = false, Callback = function(v) State.AntiFling = v end })
T2_Right:AddToggle({ Name = "旋转重力 (螺旋)", Default = false, Callback = function(v) State.Spin = v end })

--[[ 传送与保命 ]]
local Tab3 = Window:MakeTab({ Name = "传送与保命", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local T3_Left = Tab3:AddSection({ Name = "快捷传送" })
local T3_Right = Tab3:AddSection({ Name = "极限生存" })

T3_Left:AddButton({ Name = "传送到准星位置", Callback = function() local _, hrp = getCharacter() if hrp and Mouse.Hit then hrp.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0)) end end })
T3_Left:AddButton({ Name = "传送到出生点", Callback = function() local sp = Workspace:FindFirstChildOfClass("SpawnLocation") local _, hrp = getCharacter() if sp and hrp then hrp.CFrame = sp.CFrame + Vector3.new(0, 3, 0) end end })
T3_Left:AddButton({ Name = "传送到最近物品", Callback = function()
    local _, hrp = getCharacter() if not hrp then return end local closest, dist = nil, math.huge
    for _, obj in ipairs(Workspace:GetDescendants()) do if isLoot(obj) then local d = (obj.Position - hrp.Position).Magnitude if d < dist then closest, dist = obj, d end end end
    if closest and hrp then hrp.CFrame = closest.CFrame + Vector3.new(0, 3, 0) end
end })

T3_Right:AddToggle({ Name = "自动解除减速", Default = false, Callback = function(v) State.AntiSlow = v end })
T3_Right:AddSlider({ Name = "全局动画速度", Min = 1, Max = 5, Default = 1, Increment = 0.5, Color = Color3.fromRGB(0, 150, 255), Callback = function(v)
    local char = LocalPlayer.Character if not char then return end local hum = char:FindFirstChildOfClass("Humanoid")
    local animator = hum and hum:FindFirstChildOfClass("Animator")
    if animator then for _, track in ipairs(animator:GetPlayingAnimationTracks()) do pcall(function() track:AdjustSpeed(v) end) end end
end })
T3_Right:AddButton({ Name = "立即复活 (秒活)", Callback = function()
    local char, _, hum = getCharacter() if char and hum then hum.Health = 0 end
    pcall(function() local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") or game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvents") if remotes then for _, obj in ipairs(remotes:GetDescendants()) do if obj:IsA("RemoteEvent") and obj.Name:lower():find("respawn") then obj:FireServer() break end end end end)
    OrionLib:MakeNotification({ Name = "复活", Content = "已触发立即复活", Time = 3 })
end })
T3_Right:AddToggle({ Name = "性能模式 (关特效)", Default = false, Callback = function(v) if v then Lighting.GlobalShadows = false for _, obj in pairs(Workspace:GetDescendants()) do if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") then obj.Enabled = false end end end end })
T3_Right:AddButton({ Name = "重置角色 (卡死自救)", Callback = function() local char = LocalPlayer.Character if char and char:FindFirstChild("Humanoid") then char.Humanoid.Health = 0 end end })
T3_Right:AddButton({ Name = "关闭脚本 UI", Callback = function()
    Workspace.Gravity = 196 if Camera then Camera.FieldOfView = 70 end if ScreenGui then ScreenGui:Destroy() end
    if OrionLib then if type(OrionLib.Destroy) == "function" then pcall(function() OrionLib:Destroy() end) end end
    local gui = CoreGui:FindFirstChild("Orion") if gui then gui:Destroy() end
end })

--[[ ==================== 外部脚本加载页 ==================== ]]
local TabExternal = Window:MakeTab({ Name = "外部脚本注入", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local Ext_Left = TabExternal:AddSection({ Name = "一键注入功能" })
local Ext_Right = TabExternal:AddSection({ Name = "说明" })

local function injectExternalScript(scriptName, url)
    OrionLib:MakeNotification({ Name = "外部脚本", Content = "正在请求加载 " .. scriptName .. " ...", Time = 3 })
    task.spawn(function()
        local ok, err = pcall(function()
            local source = game:HttpGet(url)
            if not source or source == "" then error("获取源码失败，为空。") end
            local func, compileErr = loadstring(source)
            if not func then error("编译失败: " .. tostring(compileErr)) end
            func()
        end)
        if ok then OrionLib:MakeNotification({ Name = "注入成功", Content = scriptName .. " 已成功运行！", Time = 4 })
        else OrionLib:MakeNotification({ Name = "注入失败", Content = scriptName .. " 加载报错，请查看控制台。", Time = 5 }) warn("[" .. scriptName .. "] 注入失败: " .. tostring(err)) end
    end)
end

Ext_Left:AddButton({ Name = "注入 ER 脚本 (暂未添加)", Callback = function() OrionLib:MakeNotification({ Name = "占位符", Content = "ER 脚本源码暂未加入，请等待作者更新。", Time = 3 }) end })
Ext_Left:AddButton({ Name = "注入 BKU 最新版", Callback = function() injectExternalScript("BKU 最新版", "https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/BKU%20SCRIPT.LUA") end })
Ext_Left:AddButton({ Name = "注入 BKU 旧版", Callback = function() injectExternalScript("BKU 旧版", "https://flowauth.net/v1/loaders/BKU-script-legacy.lua") end })

Ext_Right:AddLabel("1. 点击左侧按钮即可自动下载并注入对应的外部脚本。\n2. 你的主 UI 与本脚本功能不受影响，两者可同时运行。\n3. 如果提示注入失败，通常是对方服务器暂时抽风，稍后再试即可。")

--[[ ==================== 杂项 ==================== ]]
local TabMisc = Window:MakeTab({ Name = "杂项", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local Misc_Left = TabMisc:AddSection({ Name = "实用工具" })
local Misc_Right = TabMisc:AddSection({ Name = "自定义踢出 / 退出" })

local antiAfkConn = nil
Misc_Left:AddToggle({ Name = "防挂机 (Anti-AFK)", Default = false, Callback = function(v)
    if v then
        if not antiAfkConn then
            antiAfkConn = LocalPlayer.Idled:Connect(function()
                local VirtualUser = game:GetService("VirtualUser")
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
    else
        if antiAfkConn then antiAfkConn:Disconnect() antiAfkConn = nil end
    end
end })

Misc_Left:AddButton({ Name = "一键复制服务器 JobId", Callback = function()
    local ok = pcall(function() setclipboard(game.JobId) end)
    if ok then OrionLib:MakeNotification({ Name = "复制成功", Content = "服务器 ID 已复制！", Time = 4 })
    else OrionLib:MakeNotification({ Name = "复制失败", Content = "执行器不支持剪贴板。", Time = 4 }) end
end })

Misc_Left:AddButton({ Name = "清理内存垃圾 (防卡顿)", Callback = function()
    pcall(function() collectgarbage() end)
    OrionLib:MakeNotification({ Name = "清理完成", Content = "已强制回收内存垃圾。", Time = 3 })
end })

local customKickReason = "手动退出游戏"
Misc_Right:AddTextbox({
    Name = "输入踢出理由 (仅 Kick 模式有效)",
    Default = "手动退出游戏",
    TextDisappear = false,
    Callback = function(t) 
        if t == "" then customKickReason = "手动退出游戏" else customKickReason = t end
    end
})

local kickMode = "Player:Kick (带理由)"
Misc_Right:AddDropdown({
    Name = "选择退出方式",
    Default = "Player:Kick (带理由)",
    Options = {"Player:Kick (带理由)", "game:Shutdown (瞬间闪退)", "断网模拟 (回主界面)"},
    Callback = function(opt) kickMode = opt end
})

Misc_Right:AddButton({ Name = "⚠ 执行退出/踢出", Callback = function()
    if kickMode == "Player:Kick (带理由)" then
        pcall(function() LocalPlayer:Kick(customKickReason) end)
    elseif kickMode == "game:Shutdown (瞬间闪退)" then
        pcall(function() game:Shutdown() end)
    elseif kickMode == "断网模拟 (回主界面)" then
        pcall(function() game:GetService("NetworkClient"):Disconnect() end)
    end
end })

OrionLib:Init()