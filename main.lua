-- ===================== 从远程加载 UI 引擎 =====================
local UI_URL = "https://raw.githubusercontent.com/a15826033104-afk/roblox-Script/main/UI.lua"

-- 安全加载，防止网络断开导致脚本崩溃
local success, OrionLib = pcall(function()
    return loadstring(game:HttpGet(UI_URL))()
end)

if not success or not OrionLib then
    local LocalPlayer = game:GetService("Players").LocalPlayer
    warn("[加载失败] 无法从云端获取 UI，请检查网络或链接是否失效！")
    LocalPlayer:Kick("UI 加载失败，请稍后重试或检查执行器网络。")
    return
end

OrionLib:MakeNotification({ Name = "加载成功", Content = "云端 UI 引擎已就绪，0 秒启动！", Time = 5 })

-- ===================== 核心功能服务 =====================
local Players, RunService, Workspace, UserInputService, Lighting = game:GetService("Players"), game:GetService("RunService"), game:GetService("Workspace"), game:GetService("UserInputService"), game:GetService("Lighting")
local LocalPlayer, Camera, Mouse = Players.LocalPlayer, Workspace.CurrentCamera, Players.LocalPlayer:GetMouse()
Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() Camera = Workspace.CurrentCamera end)
local OrigLighting = { Brightness = Lighting.Brightness, Ambient = Lighting.Ambient, ClockTime = Lighting.ClockTime, GlobalShadows = Lighting.GlobalShadows, FogEnd = Lighting.FogEnd }
local OrigCamera = { MinZoom = LocalPlayer.CameraMinZoomDistance, MaxZoom = LocalPlayer.CameraMaxZoomDistance, Mode = LocalPlayer.CameraMode }
local initialSpeed, initialJump = 16, 50
if LocalPlayer.Character then local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid") if hum then initialSpeed, initialJump = hum.WalkSpeed, hum.UseJumpPower and hum.JumpPower or 50 end end

local State = {
    WalkSpeed = initialSpeed, JumpPower = initialJump, Noclip = false, Fly = false, FlySpeed = 60, FlyMode = "Smooth", InfiniteJump = false, ThirdPerson = false, Spin = false, AntiFling = false, Anchor = false, Invisible = false, HitboxExpand = false, HitboxSize = 10, AutoPickup = false, AutoFollow = false, AntiSlow = false, SafeEggLoop = false, SafeEggInterval = 2.0, ThreatAlert = false, ThreatDistance = 50, AntiFog = false, NightVis = false, LockBloodman = false, LockBloodmanMode = "锁定视角", LockBloodmanDistance = 9999, EggKeywords = {"egg", "event", "halloween", "portal", "gate", "altar", "unlock", "badge", "mode"}, TracerOrigin = "屏幕底部", TracerColor = Color3.fromRGB(0, 255, 100), SpeedEn = false, FOVEn = false, PlayerESP = false, ShowNames = false, ShowTracers = false, PlayerHighlight = false, MonkeyESP = false, EarGameESP = false, ScrapESP = false, CardESP = false, RecyclerESP = false, AutoGold = false, AntiSlippery = false, HideBodies = false, InfStamina = false, InstantInteract = false, FreezeSelf = false, SpinSelf = false, SpinSpeed = 1, SpinDir = 1, TargetPlayerName = "", TargetPlayerESPObj = nil,
    Fullbright = false, MonsterNotify = false, NotifyDistance = 80, ShowMonsterDistance = false, AutoEscape = false, EscapeDangerDistance = 35, AutoFarmPauseOnThreat = false,
}
LocalPlayer.CharacterAdded:Connect(function(newChar) task.wait(1) local hum = newChar:FindFirstChildOfClass("Humanoid") if hum and State.SpeedEn then hum.WalkSpeed = State.WalkSpeed end end)
RunService.RenderStepped:Connect(function()
    if State.ThirdPerson then LocalPlayer.CameraMode = Enum.CameraMode.Classic LocalPlayer.CameraMinZoomDistance = 0.5 LocalPlayer.CameraMaxZoomDistance = 128 end
    if State.NightVis then Lighting.Brightness, Lighting.Ambient, Lighting.ClockTime = 2, Color3.new(1, 1, 1), 12 end
    if State.Fullbright then
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.Brightness = 2
        Lighting.ClockTime = 12
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 100000
    end
end)

local antiSlipperyConnection = nil
local function antiSlippery()
    local char = LocalPlayer.Character if not char then return end local humanoid, rootPart = char:FindFirstChildOfClass("Humanoid"), char:FindFirstChild("HumanoidRootPart") if not humanoid or not rootPart or humanoid.Health <= 0 then return end
    local currentVel, moveDir, walkSpeed = rootPart.AssemblyLinearVelocity, humanoid.MoveDirection, humanoid.WalkSpeed if walkSpeed <= 0 or walkSpeed > 200 then return end
    if moveDir.Magnitude < 0.05 then if math.abs(currentVel.X) > 0.01 or math.abs(currentVel.Z) > 0.01 then rootPart.AssemblyLinearVelocity = Vector3.new(0, currentVel.Y, 0) end else local targetHorizontal = moveDir.Unit * walkSpeed rootPart.AssemblyLinearVelocity = Vector3.new(targetHorizontal.X, currentVel.Y, targetHorizontal.Z) end
end
local function toggleAntiSlippery(bool) State.AntiSlippery = bool if bool then if not antiSlipperyConnection then antiSlipperyConnection = RunService.Heartbeat:Connect(antiSlippery) end else if antiSlipperyConnection then antiSlipperyConnection:Disconnect() antiSlipperyConnection = nil end end end

local ActiveCards, _cachedRecycler = {}, nil
local _recyclerMissUntil = 0
local ItemPriority = { ["Screw"]=1, ["Pipe"]=1, ["Bucket"]=1, ["Baterry"]=1, ["Gear"]=1, ["Cleaner"]=1, ["Emerald"]=14, ["Diamond"]=7, ["Gold"]=2, ["Copper"]=1, ["Meat"]=3, ["Scrap"]=1 }
local function isScrapItem(v) if not v or not (v:IsA("BasePart") or v:IsA("Model")) then return false end local name = v.Name:lower() for key, _ in pairs(ItemPriority) do if name:find(key:lower(), 1, true) then return true end end return false end

local function InteractWithObject(obj)
    local prompt = obj:FindFirstChildOfClass("ProximityPrompt") or obj:FindFirstChildWhichIsA("ProximityPrompt", true)
    if prompt then
        pcall(function() fireproximityprompt(prompt) end)
    end
    local vim = game:GetService("VirtualInputManager")
    pcall(function()
        vim:SendKeyEvent(true, Enum.KeyCode.E, false, game)
        task.wait(0.05)
        vim:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    end)
end

local function IsValidGroundItem(obj) local allPlayers = Players:GetPlayers() for i = 1, #allPlayers do local p = allPlayers[i] if p.Character and obj:IsDescendantOf(p.Character) then return false end local bp = p:FindFirstChild("Backpack") if bp and obj:IsDescendantOf(bp) then return false end end if obj:IsA("BasePart") then if obj.Transparency > 0.5 or obj.Position.Y < -50 then return false end else if obj:GetPivot().Position.Y < -50 then return false end end return true end

local function GetRecycler()
    if _cachedRecycler and _cachedRecycler.Parent then return _cachedRecycler end
    if tick() < _recyclerMissUntil then return nil end
    
    _cachedRecycler = Workspace:FindFirstChild("ScrapRecycler", true)
    if _cachedRecycler then return _cachedRecycler end
    
    for _, v in ipairs(Workspace:GetDescendants()) do
        if (v:IsA("BasePart") or v:IsA("Model")) then
            local n = v.Name:lower()
            if n:find("recycler") or n:find("sell") or n:find("exchange") or n:find("scrap") then
                if v:FindFirstChildWhichIsA("ProximityPrompt", true) then 
                    _cachedRecycler = v 
                    return v 
                end
            end
        end
    end
    _recyclerMissUntil = tick() + 2
    return nil
end

local AutoGoldRuntime = {
    Running = false, Thread = nil, CachedRecycler = nil, RecyclerLastCheck = 0, RecyclerCacheDuration = 3,
    CachedItems = {}, ItemsLastScan = 0, ScanCooldown = 0.28, AttemptedItems = setmetatable({}, {__mode = "k"}),
    BagCount = 0, LastBagCheck = 0, BagCheckInterval = 0.25, Stats = { Collected = 0, Sold = 0, StartTime = 0 },
}

local function CountInventory()
    local n = 0
    local char = LocalPlayer.Character
    if char then for _, v in ipairs(char:GetChildren()) do if v:IsA("Tool") then n = n + 1 end end end
    local bp = LocalPlayer:FindFirstChild("Backpack")
    if bp then for _, v in ipairs(bp:GetChildren()) do if v:IsA("Tool") then n = n + 1 end end end
    return n
end

local function RefreshRecyclerCache(force)
    local now = tick()
    if not force and AutoGoldRuntime.CachedRecycler and AutoGoldRuntime.CachedRecycler.Parent and now - AutoGoldRuntime.RecyclerLastCheck < AutoGoldRuntime.RecyclerCacheDuration then
        return AutoGoldRuntime.CachedRecycler
    end
    AutoGoldRuntime.RecyclerLastCheck = now
    AutoGoldRuntime.CachedRecycler = GetRecycler()
    return AutoGoldRuntime.CachedRecycler
end

local function RefreshItemCache()
    local now = tick()
    if now - AutoGoldRuntime.ItemsLastScan < AutoGoldRuntime.ScanCooldown then return end
    AutoGoldRuntime.ItemsLastScan = now

    local char = LocalPlayer.Character
    if not char then AutoGoldRuntime.CachedItems = {} return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then AutoGoldRuntime.CachedItems = {} return end

    local params = OverlapParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {char}

    local cache = {}
    local ok, parts = pcall(function() return Workspace:GetPartBoundsInRadius(hrp.Position, 1000, params) end)
    if not ok or not parts then AutoGoldRuntime.CachedItems = {} return end

    local hrpPos = hrp.Position
    for _, v in ipairs(parts) do
        if isScrapItem(v) and IsValidGroundItem(v) then
            local pos = (v:IsA("BasePart") and v.CFrame.Position) or v:GetPivot().Position
            local lower = v.Name:lower()
            local priority = 0
            for key, pri in pairs(ItemPriority) do
                if lower:find(key:lower(), 1, true) and pri > priority then priority = pri end
            end
            table.insert(cache, { Obj = v, Pos = pos, Priority = priority, Dist = (pos - hrpPos).Magnitude })
        end
    end
    table.sort(cache, function(a, b)
        if a.Priority ~= b.Priority then return a.Priority > b.Priority end
        return a.Dist < b.Dist
    end)
    AutoGoldRuntime.CachedItems = cache
end

local function FastTeleport(pos, yOffset)
    local char = LocalPlayer.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    return pcall(function()
        hrp.CFrame = CFrame.new(pos + Vector3.new(0, yOffset or 3, 0))
        hrp.AssemblyLinearVelocity  = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end)
end

local function SelectNextItem(now)
    for _, item in ipairs(AutoGoldRuntime.CachedItems) do
        if item.Obj and item.Obj.Parent then
            local t = AutoGoldRuntime.AttemptedItems[item.Obj]
            if not t or now - t > 2 then return item end
        end
    end
    return nil
end

local MonsterCache = {}
local function RefreshMonsterCache()
    MonsterCache = {}
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    for _, model in ipairs(Workspace:GetDescendants()) do
        if model:IsA("Model") and model ~= char then
            local name = model.Name
            if TargetMonkeys[name] or TargetEarMonkeys[name] then
                local root = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Head") or model:FindFirstChildOfClass("BasePart")
                if root then table.insert(MonsterCache, { Model = model, Root = root, Distance = (root.Position - hrp.Position).Magnitude }) end
            end
        end
    end
end

local AutoEscapeCooldown = 0
local function TryAutoEscape()
    if not State.AutoEscape or tick() < AutoEscapeCooldown then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    RefreshMonsterCache()
    local nearestDist = math.huge
    for _, entry in ipairs(MonsterCache) do if entry.Distance < nearestDist then nearestDist = entry.Distance end end
    if nearestDist < State.EscapeDangerDistance then
        AutoEscapeCooldown = tick() + 4
        local randomOffset = Vector3.new(math.random(-100, 100), math.random(30, 80), math.random(-100, 100))
        local safePos = hrp.Position + randomOffset
        pcall(function()
            hrp.CFrame = CFrame.new(safePos)
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
        end)
        OrionLib:MakeNotification({ Name = "自动逃脱", Content = "检测到威胁，已随机传送至安全位置！", Time = 3 })
    end
end

local function IsThreatNear()
    RefreshMonsterCache()
    for _, entry in ipairs(MonsterCache) do if entry.Distance < State.EscapeDangerDistance then return true end end
    return false
end

local function AutoGoldStep()
    local char = LocalPlayer.Character
    if not char then return 0.3 end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum or hum.Health <= 0 then return 0.3 end

    if State.AutoFarmPauseOnThreat and IsThreatNear() then return 0.5 end

    local now = tick()
    if now - AutoGoldRuntime.LastBagCheck >= AutoGoldRuntime.BagCheckInterval then
        AutoGoldRuntime.LastBagCheck = now
        AutoGoldRuntime.BagCount = CountInventory()
    end

    if AutoGoldRuntime.BagCount > 0 then
        local recycler = RefreshRecyclerCache(false)
        if recycler then
            local rpos = (recycler:IsA("BasePart") and recycler.CFrame.Position) or recycler:GetPivot().Position
            if FastTeleport(rpos, 3) then
                task.wait(0.35) 
                InteractWithObject(recycler)
                task.wait(0.1)
                InteractWithObject(recycler)
                AutoGoldRuntime.LastBagCheck = 0
                AutoGoldRuntime.Stats.Sold = AutoGoldRuntime.Stats.Sold + 1
                return 0.05
            end
        end
        return 0.5
    end

    RefreshItemCache()
    local target = SelectNextItem(now)
    if target then
        local obj = target.Obj
        local pos = (obj:IsA("BasePart") and obj.CFrame.Position) or obj:GetPivot().Position
        AutoGoldRuntime.AttemptedItems[obj] = now
        if FastTeleport(pos, 2.5) then
            task.wait(0.08)
            InteractWithObject(obj)
            AutoGoldRuntime.LastBagCheck = 0
            AutoGoldRuntime.Stats.Collected = AutoGoldRuntime.Stats.Collected + 1
            return 0.05
        end
    end
    return 0.1
end

local function StartAutoGold()
    if AutoGoldRuntime.Running then return end
    AutoGoldRuntime.Running = true
    AutoGoldRuntime.Stats.StartTime = tick()
    AutoGoldRuntime.AttemptedItems = setmetatable({}, {__mode = "k"})
    AutoGoldRuntime.Thread = task.spawn(function()
        while State.AutoGold and AutoGoldRuntime.Running do
            local delay = 0.15
            pcall(function() delay = AutoGoldStep() or 0.1 end)
            task.wait(delay)
        end
        AutoGoldRuntime.Running = false
    end)
end

local function StopAutoGold()
    AutoGoldRuntime.Running = false
    State.AutoGold = false
end

task.spawn(function()
    while task.wait(1) do
        if State.AutoGold and not AutoGoldRuntime.Running then StartAutoGold() end
    end
end)

local TargetMonkeys = { ["Lurker"]=true, ["Kus"]=true, ["Dus"]=true, ["Gus"]=true, ["SandMan"]=true, ["Ashy"]=true, ["Lost"]=true, ["Scar"]=true, ["Billy"]=true, ["SangGuy"]=true, ["Meat"]=true, ["???"]=true, ["Taller"]=true, ["Slender"]=true, ["BloodMan"]=true, ["Lengthy"]=true, ["Gooba"]=true }
local TargetEarMonkeys = { ["SawRunner"]=true, ["Crawly"]=true, ["Claw"]=true, ["slender"]=true }
local ESPObjects = {}
local function CreateOutlineESP(model) if not model:FindFirstChild("Monkey_Highlight_ESP") then local hl = Instance.new("Highlight") hl.Name, hl.FillColor, hl.FillTransparency, hl.OutlineColor, hl.OutlineTransparency, hl.DepthMode, hl.Parent = "Monkey_Highlight_ESP", Color3.fromRGB(255, 60, 0), 0.5, Color3.fromRGB(255, 255, 255), 0, Enum.HighlightDepthMode.AlwaysOnTop, model end if not model:FindFirstChild("Monkey_Text_ESP") then local targetPart = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Head") or model:FindFirstChildOfClass("BasePart") if targetPart then local billboard = Instance.new("BillboardGui") billboard.Name, billboard.Size, billboard.AlwaysOnTop, billboard.ExtentsOffset, billboard.Adornee, billboard.Parent = "Monkey_Text_ESP", UDim2.new(0, 180, 0, 50), true, Vector3.new(0, 3.5, 0), targetPart, model local label = Instance.new("TextLabel") label.Size, label.BackgroundTransparency, label.Text, label.TextColor3, label.TextSize, label.Font, label.TextStrokeTransparency, label.Parent = UDim2.new(1, 0, 1, 0), 1, model.Name, Color3.fromRGB(255, 60, 0), 16, Enum.Font.SourceSansBold, 0, billboard end end end
local function CreateEarGameESP(model) if not model:FindFirstChild("EarGame_Highlight_ESP") then local hl = Instance.new("Highlight") hl.Name, hl.FillColor, hl.FillTransparency, hl.OutlineColor, hl.OutlineTransparency, hl.DepthMode, hl.Parent = "EarGame_Highlight_ESP", Color3.fromRGB(255, 0, 100), 0.4, Color3.fromRGB(255, 0, 100), 0, Enum.HighlightDepthMode.AlwaysOnTop, model end if not model:FindFirstChild("EarGame_Text_ESP") then local targetPart = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Head") or model:FindFirstChildOfClass("BasePart") if targetPart then local billboard = Instance.new("BillboardGui") billboard.Name, billboard.Size, billboard.AlwaysOnTop, billboard.ExtentsOffset, billboard.Adornee, billboard.Parent = "EarGame_Text_ESP", UDim2.new(0, 180, 0, 50), true, Vector3.new(0, 3.5, 0), targetPart, model local label = Instance.new("TextLabel") label.Size, label.BackgroundTransparency, label.Text, label.TextColor3, label.TextSize, label.Font, label.TextStrokeTransparency, label.Parent = UDim2.new(1, 0, 1, 0), 1, model.Name, Color3.fromRGB(255, 0, 100), 16, Enum.Font.SourceSansBold, 0, billboard end end end
local function CreateScrapESP(part) if not part:FindFirstChild("Scrap_Highlight_ESP") then local hl = Instance.new("Highlight") hl.Name, hl.FillColor, hl.FillTransparency, hl.OutlineColor, hl.OutlineTransparency, hl.DepthMode, hl.Parent = "Scrap_Highlight_ESP", Color3.fromRGB(0, 255, 100), 0.5, Color3.fromRGB(255, 255, 255), 0, Enum.HighlightDepthMode.AlwaysOnTop, part end if not part:FindFirstChild("Scrap_Text_ESP") then local billboard = Instance.new("BillboardGui") billboard.Name, billboard.Size, billboard.AlwaysOnTop, billboard.ExtentsOffset, billboard.Adornee, billboard.Parent = "Scrap_Text_ESP", UDim2.new(0, 150, 0, 40), true, Vector3.new(0, 2, 0), part, part local label = Instance.new("TextLabel") label.Size, label.BackgroundTransparency, label.Text, label.TextColor3, label.TextSize, label.Font, label.TextStrokeTransparency, label.Parent = UDim2.new(1, 0, 1, 0), 1, part.Name, Color3.fromRGB(0, 255, 100), 14, Enum.Font.SourceSansBold, 0, billboard end end
local function CreateRecyclerESP(obj) if not obj:FindFirstChild("Recycler_Highlight_ESP") then local hl = Instance.new("Highlight") hl.Name, hl.FillColor, hl.FillTransparency, hl.OutlineColor, hl.OutlineTransparency, hl.DepthMode, hl.Parent = "Recycler_Highlight_ESP", Color3.fromRGB(170, 85, 255), 0.4, Color3.fromRGB(255, 255, 255), 0, Enum.HighlightDepthMode.AlwaysOnTop, obj end if not obj:FindFirstChild("Recycler_Text_ESP") then local targetPart = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj if targetPart then local billboard = Instance.new("BillboardGui") billboard.Name, billboard.Size, billboard.AlwaysOnTop, billboard.ExtentsOffset, billboard.Adornee, billboard.Parent = "Recycler_Text_ESP", UDim2.new(0, 160, 0, 40), true, Vector3.new(0, 4, 0), targetPart, obj local label = Instance.new("TextLabel") label.Size, label.BackgroundTransparency, label.Text, label.TextColor3, label.TextSize, label.Font, label.TextStrokeTransparency, label.Parent = UDim2.new(1, 0, 1, 0), 1, "废品回收机", Color3.fromRGB(170, 85, 255), 15, Enum.Font.SourceSansBold, 0, billboard end end end
local function CreateCardESP(part) if not part:FindFirstChild("Card_Highlight_ESP") then local hl = Instance.new("Highlight") hl.Name, hl.FillColor, hl.FillTransparency, hl.OutlineColor, hl.OutlineTransparency, hl.DepthMode, hl.Parent = "Card_Highlight_ESP", Color3.fromRGB(0, 200, 255), 0.4, Color3.fromRGB(255, 255, 255), 0, Enum.HighlightDepthMode.AlwaysOnTop, part end if not part:FindFirstChild("Card_Text_ESP") then local billboard = Instance.new("BillboardGui") billboard.Name, billboard.Size, billboard.AlwaysOnTop, billboard.ExtentsOffset, billboard.Adornee, billboard.Parent = "Card_Text_ESP", UDim2.new(0, 150, 0, 40), true, Vector3.new(0, 2, 0), part, part local label = Instance.new("TextLabel") label.Size, label.BackgroundTransparency, label.Text, label.TextColor3, label.TextSize, label.Font, label.TextStrokeTransparency, label.Parent = UDim2.new(1, 0, 1, 0), 1, "Card", Color3.fromRGB(0, 200, 255), 15, Enum.Font.SourceSansBold, 0, billboard end end

local function ApplyObjectESP(v) if not v or not v.Parent then return end if TargetMonkeys[v.Name] and v:IsA("Model") then if State.MonkeyESP then CreateOutlineESP(v) end elseif TargetEarMonkeys[v.Name] and v:IsA("Model") then if State.EarGameESP then CreateEarGameESP(v) end elseif v.Name:lower():find("recycler") or v.Name:lower():find("sell") or v.Name:lower():find("exchange") then if v:FindFirstChildWhichIsA("ProximityPrompt", true) then if State.RecyclerESP then CreateRecyclerESP(v) end end elseif v.Name == "Card" and v:IsA("MeshPart") then if State.CardESP and IsValidGroundItem(v) then CreateCardESP(v) if not table.find(ActiveCards, v) then table.insert(ActiveCards, v) end end elseif isScrapItem(v) then if State.ScrapESP and IsValidGroundItem(v) then CreateScrapESP(v) end end end
local function ApplyScrapESPOnly(v) if State.ScrapESP and isScrapItem(v) and IsValidGroundItem(v) then CreateScrapESP(v) end end
Workspace.DescendantAdded:Connect(ApplyObjectESP)
local scrapsFolder = Workspace:FindFirstChild("Scraps") if scrapsFolder then scrapsFolder.ChildAdded:Connect(ApplyScrapESPOnly) end
local function OneTimeFullRefresh() for _, v in pairs(Workspace:GetDescendants()) do ApplyObjectESP(v) end end
task.spawn(function() while task.wait(1) do if State.CardESP then for i = #ActiveCards, 1, -1 do local v = ActiveCards[i] if v and v.Parent then if not IsValidGroundItem(v) then if v:FindFirstChild("Card_Highlight_ESP") then v.Card_Highlight_ESP:Destroy() end if v:FindFirstChild("Card_Text_ESP") then v.Card_Text_ESP:Destroy() end table.remove(ActiveCards, i) end else table.remove(ActiveCards, i) end end end end end)
local bodyConnection = nil
local function hideBody(model) if model:IsA("Model") then local name = model.Name if name == "dead" or name == "ChimpRagdoll" then task.defer(function() if model and model.Parent then model.Archivable = true model.Parent = nil end end) end end end
local function CreatePlayerESP() local drawObj = { Line = Drawing.new("Line"), Text = Drawing.new("Text") } drawObj.Line.Thickness, drawObj.Line.Transparency, drawObj.Text.Size, drawObj.Text.Center, drawObj.Text.Outline = 1, 1, 13, true, true return drawObj end
RunService.RenderStepped:Connect(function()
    if not State.PlayerESP then return end
    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then if ESPObjects[player] then ESPObjects[player].Line.Visible = false ESPObjects[player].Text.Visible = false end continue end
        if not ESPObjects[player] then ESPObjects[player] = CreatePlayerESP() end
        local obj, hrp = ESPObjects[player], player.Character.HumanoidRootPart
        local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
        local teamColor = (player.Team and player.TeamColor.Color) or Color3.fromRGB(0, 255, 0)
        if State.PlayerHighlight then if not player.Character:FindFirstChild("PlayerHighlight") then local hl = Instance.new("Highlight") hl.Name, hl.FillColor, hl.OutlineColor, hl.Parent = "PlayerHighlight", (player.Team and player.TeamColor.Color) or Color3.fromRGB(0, 255, 0), Color3.fromRGB(255, 255, 255), player.Character player:GetPropertyChangedSignal("Team"):Connect(function() if hl and hl.Parent then hl.FillColor = (player.Team and player.TeamColor.Color) or Color3.fromRGB(0, 255, 0) end end) end else if player.Character:FindFirstChild("PlayerHighlight") then player.Character.PlayerHighlight:Destroy() end end
        if onScreen then
            if State.ShowTracers then obj.Line.From, obj.Line.To, obj.Line.Color, obj.Line.Visible = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y), Vector2.new(screenPos.X, screenPos.Y), teamColor, true else obj.Line.Visible = false end
            if State.ShowNames then local head = player.Character:FindFirstChild("Head") local textTarget = head and (head.Position + Vector3.new(0, 0.8, 0)) or (hrp.Position + Vector3.new(0, 3, 0)) local textPos, textOnScreen = Camera:WorldToViewportPoint(textTarget) if textOnScreen then obj.Text.Position = Vector2.new(textPos.X, textPos.Y) else obj.Text.Position = Vector2.new(screenPos.X, screenPos.Y - 20) end obj.Text.Text, obj.Text.Color, obj.Text.Visible = player.DisplayName, teamColor, true else obj.Text.Visible = false end
        else obj.Line.Visible, obj.Text.Visible = false, false end
    end
end)
Players.PlayerRemoving:Connect(function(player) if ESPObjects[player] then ESPObjects[player].Line:Remove() ESPObjects[player].Text:Remove() ESPObjects[player] = nil end end)

local cachedHumanoidModels, cachedBloodMan = {}, nil
task.spawn(function() while true do table.clear(cachedHumanoidModels) for _, desc in pairs(Workspace:GetDescendants()) do if desc:IsA("Model") and desc:FindFirstChildOfClass("Humanoid") then table.insert(cachedHumanoidModels, desc) end end task.wait(1) end end)
task.spawn(function() while true do cachedBloodMan = nil for _, model in ipairs(cachedHumanoidModels) do if model.Name == "BloodMan" then cachedBloodMan = model break end end task.wait(0.5) end end)

RunService.RenderStepped:Connect(function()
    if not State.AutoFollow then return end
    local char = LocalPlayer.Character if not char or not char:FindFirstChild("HumanoidRootPart") then return end local hrp = char.HumanoidRootPart
    local closest, dist = nil, math.huge
    RefreshMonsterCache()
    for _, entry in ipairs(MonsterCache) do if entry.Distance < dist and entry.Distance < 500 then closest, dist = entry.Root, entry.Distance end end
    if closest then Camera.CFrame = Camera.CFrame:Lerp(CFrame.lookAt(Camera.CFrame.Position, closest.Position), 0.15) end
end)

local MonsterNotifyCooldown = {}
RunService.RenderStepped:Connect(function()
    RefreshMonsterCache()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for _, entry in ipairs(MonsterCache) do
        local model, root, dist = entry.Model, entry.Root, entry.Distance
        local billboard = model:FindFirstChild("Monkey_Text_ESP") or model:FindFirstChild("EarGame_Text_ESP")
        if billboard and billboard:FindFirstChildOfClass("TextLabel") then
            local label = billboard:FindFirstChildOfClass("TextLabel")
            if State.ShowMonsterDistance then label.Text = string.format("%s [%d]", model.Name, math.floor(dist))
            else label.Text = model.Name end
        end
        if State.MonsterNotify and dist < State.NotifyDistance then
            local lastNotify = MonsterNotifyCooldown[model] or 0
            if tick() - lastNotify > 8 then
                MonsterNotifyCooldown[model] = tick()
                OrionLib:MakeNotification({ Name = "⚠️ 怪物接近", Content = string.format("%s 距离你 %d 单位", model.Name, math.floor(dist)), Time = 4 })
            end
        end
    end
end)

RunService.Heartbeat:Connect(function() if State.AutoEscape then pcall(TryAutoEscape) end end)

local aimRaycastParams = RaycastParams.new() aimRaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
RunService.RenderStepped:Connect(function()
    if not State.LockBloodman then return end
    local char = LocalPlayer.Character if not char then return end local hrp = char:FindFirstChild("HumanoidRootPart") local humanoid = char:FindFirstChildOfClass("Humanoid") if not hrp or not humanoid then return end
    local bloodMan = cachedBloodMan
    if bloodMan and bloodMan.Parent then
        local targetPart = bloodMan:FindFirstChild("HumanoidRootPart") or bloodMan:FindFirstChild("Head") or bloodMan:FindFirstChildWhichIsA("BasePart")
        if targetPart then
            local origin, destination = hrp.Position + Vector3.new(0, 1, 0), targetPart.Position + Vector3.new(0, 1, 0) local direction, distance = (destination - origin).Unit, (destination - origin).Magnitude
            local ignoreList = {char, bloodMan}
            for i = 1, #cachedHumanoidModels do local model = cachedHumanoidModels[i] if model ~= char and model ~= bloodMan then for _, v in pairs(model:GetDescendants()) do if v:IsA("BasePart") then table.insert(ignoreList, v) end end end end
            aimRaycastParams.FilterDescendantsInstances = ignoreList
            local raycastResult = Workspace:Raycast(origin, direction * distance, aimRaycastParams)
            if not raycastResult then humanoid.AutoRotate = false if State.LockBloodmanMode == "锁定视角" then Camera.CFrame = Camera.CFrame:Lerp(CFrame.lookAt(Camera.CFrame.Position, destination), 0.2) else hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(destination.X, hrp.Position.Y, destination.Z)) end else humanoid.AutoRotate = true end
        else humanoid.AutoRotate = true end
    else humanoid.AutoRotate = true end
end)

task.spawn(function() while task.wait(0.5) do if State.InfStamina then pcall(function() if LocalPlayer.PlayerGui and LocalPlayer.PlayerGui:FindFirstChild("Stamina") then local staminaGui = LocalPlayer.PlayerGui.Stamina if staminaGui:FindFirstChild("Handler") and staminaGui.Handler:FindFirstChild("Stamina") then local s = staminaGui.Handler.Stamina if s.Value < 100 then s.Value = 100 end end end end) end end end)
local function UpdatePrompts(state) State.InstantInteract = state for _, v in pairs(Workspace:GetDescendants()) do if v:IsA("ProximityPrompt") then v.HoldDuration = state and 0 or 0.5 end end end
Workspace.DescendantAdded:Connect(function(v) if State.InstantInteract and v:IsA("ProximityPrompt") then v.HoldDuration = 0 end end)

local spinConnection = nil
local function startSpin() if spinConnection then spinConnection:Disconnect() end if not State.SpinSelf then local char = LocalPlayer.Character if char and char:FindFirstChildOfClass("Humanoid") then char.Humanoid.AutoRotate = true end return end local char = LocalPlayer.Character if char and char:FindFirstChildOfClass("Humanoid") then char.Humanoid.AutoRotate = false end spinConnection = RunService.RenderStepped:Connect(function() if not State.SpinSelf then return end local char = LocalPlayer.Character if not char or not char:FindFirstChild("HumanoidRootPart") then return end local hrp = char.HumanoidRootPart local angle = math.rad(State.SpinSpeed * State.SpinDir) hrp.CFrame = hrp.CFrame * CFrame.Angles(0, angle, 0) end) end
LocalPlayer.CharacterAdded:Connect(function() task.wait(0.5) if State.SpinSelf then startSpin() end end)

local NoclipSnapshot = {}
local function _applyNoclip() local char = LocalPlayer.Character if not char then return end for _, v in pairs(char:GetDescendants()) do if v:IsA("BasePart") then if NoclipSnapshot[v] == nil then NoclipSnapshot[v] = v.CanCollide end v.CanCollide = false end end end
local function _restoreNoclip() for part, original in pairs(NoclipSnapshot) do if part and part.Parent then part.CanCollide = original end end table.clear(NoclipSnapshot) end
local function toggleNoclip(bool) State.Noclip = bool if bool then if not State._noclipConn then _applyNoclip() State._noclipConn = RunService.Stepped:Connect(_applyNoclip) end else if State._noclipConn then State._noclipConn:Disconnect() State._noclipConn = nil end _restoreNoclip() end end

local flyConn, flyObjects = nil, {}
local function clearFlyObjects() if flyConn then flyConn:Disconnect() flyConn = nil end for _, obj in pairs(flyObjects) do if obj and obj.Destroy then obj:Destroy() end end table.clear(flyObjects) end
local function toggleFly(bool)
    State.Fly = bool
    local char, hrp, hum = LocalPlayer.Character, LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    clearFlyObjects() if not char or not hrp or not hum then return end
    if bool then
        State._origNoclip = State.Noclip if not State.Noclip then _applyNoclip() end hum.AutoRotate, hum.PlatformStand = false, false hrp.AssemblyLinearVelocity, hrp.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
        local cam = Workspace.CurrentCamera
        local function getMoveVelocity() local moveDir = hum.MoveDirection local velocity = Vector3.zero if moveDir.Magnitude > 0 then local objMove = cam.CFrame:VectorToObjectSpace(moveDir) local dir = (cam.CFrame.LookVector * -objMove.Z + cam.CFrame.RightVector * objMove.X) if dir.Magnitude > 0.01 then velocity = dir.Unit * State.FlySpeed end end if UserInputService:IsKeyDown(Enum.KeyCode.Space) or (UserInputService.TouchEnabled and hum.Jump) then velocity = velocity + Vector3.new(0, State.FlySpeed, 0) end return velocity end
        local function getTargetCFrame() local camLook = cam.CFrame.LookVector local flatLook = Vector3.new(camLook.X, 0, camLook.Z) if flatLook.Magnitude > 0.01 then return CFrame.lookAt(hrp.Position, hrp.Position + flatLook.Unit) end return hrp.CFrame end
        if State.FlyMode == "Smooth" then
            local att = Instance.new("Attachment") att.Name, att.Parent = "FlyAttachment", hrp
            local lv = Instance.new("LinearVelocity") lv.Name, lv.Attachment0, lv.MaxForce, lv.VectorVelocity, lv.Parent = "FlyLinearVelocity", att, math.huge, Vector3.zero, hrp
            local ao = Instance.new("AlignOrientation") ao.Name, ao.Attachment0, ao.MaxTorque, ao.Responsiveness, ao.Mode, ao.Parent = "FlyAlignOrientation", att, math.huge, 1000, Enum.OrientationAlignmentMode.OneAttachment, hrp
            table.insert(flyObjects, att) table.insert(flyObjects, lv) table.insert(flyObjects, ao)
            flyConn = RunService.RenderStepped:Connect(function() if not hrp.Parent or not State.Fly then return end ao.CFrame = ao.CFrame:Lerp(getTargetCFrame(), 0.4) lv.VectorVelocity = getMoveVelocity() end)
        elseif State.FlyMode == "CFrame" then
            local bf = Instance.new("BodyForce") bf.Force, bf.Parent = Vector3.new(0, Workspace.Gravity * hrp:GetMass(), 0), hrp table.insert(flyObjects, bf)
            flyConn = RunService.RenderStepped:Connect(function(dt) if not hrp.Parent or not State.Fly then return end local v3 = getMoveVelocity() local newPos = hrp.Position + (v3 * dt) hrp.CFrame = CFrame.new(newPos, newPos + getTargetCFrame().LookVector) hrp.AssemblyLinearVelocity, hrp.AssemblyAngularVelocity = Vector3.zero, Vector3.zero end)
        elseif State.FlyMode == "Classic" then
            local bv = Instance.new("BodyVelocity") bv.Name, bv.MaxForce, bv.P, bv.Velocity, bv.Parent = "FlyBodyVel", Vector3.new(math.huge, math.huge, math.huge), 12500, Vector3.zero, hrp
            local bg = Instance.new("BodyGyro") bg.Name, bg.MaxTorque, bg.D, bg.P, bg.Parent = "FlyBodyGyro", Vector3.new(math.huge, math.huge, math.huge), 50, 3000, hrp
            table.insert(flyObjects, bv) table.insert(flyObjects, bg)
            flyConn = RunService.RenderStepped:Connect(function() if not hrp.Parent or not State.Fly then return end bg.CFrame = bg.CFrame:Lerp(getTargetCFrame(), 0.4) bv.Velocity = getMoveVelocity() end)
        end
    else
        if hrp and hum then
            hum.AutoRotate, hum.PlatformStand = true, false hrp.AssemblyLinearVelocity, hrp.AssemblyAngularVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0), Vector3.zero if not State._origNoclip then _restoreNoclip() end State._origNoclip = nil
            task.spawn(function() task.wait(0.1) if hum.Parent and hum.Health > 0 and not State.Fly then pcall(function() hum:ChangeState(Enum.HumanoidStateType.Running) end) end end)
        end
    end
end

local infJumpConn
local function toggleInfJump(bool) State.InfiniteJump = bool if bool then if not infJumpConn then infJumpConn = UserInputService.JumpRequest:Connect(function() local char = LocalPlayer.Character if char then local hum = char:FindFirstChildOfClass("Humanoid") if hum and State.InfiniteJump then hum:ChangeState(Enum.HumanoidStateType.Jumping) end end end) end elseif infJumpConn then infJumpConn:Disconnect() infJumpConn = nil end end
local invisConn
local function toggleInvisibility(bool)
    State.Invisible = bool local char = LocalPlayer.Character if not char then return end
    if bool then
        if not invisConn then invisConn = RunService.Stepped:Connect(function() local c = LocalPlayer.Character if c then for _, v in pairs(c:GetDescendants()) do if v:IsA("BasePart") then v.Transparency = 1 elseif v:IsA("Decal") then v.Transparency = 1 end end end end) end
    else
        if invisConn then invisConn:Disconnect() invisConn = nil end for _, v in pairs(char:GetDescendants()) do if v:IsA("BasePart") then v.Transparency = 0 elseif v:IsA("Decal") then v.Transparency = 0 end end
    end
end

local function AutoScrapManual()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then
        OrionLib:MakeNotification({ Name = "自动兑换", Content = "角色未就绪！", Time = 4 })
        return
    end
    local hrp = char.HumanoidRootPart
    local recycler = RefreshRecyclerCache(true)
    if recycler then
        local pos = (recycler:IsA("BasePart") and recycler.CFrame.Position) or recycler:GetPivot().Position
        pcall(function()
            hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
            hrp.AssemblyLinearVelocity  = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
        end)
        task.wait(0.35) 
        InteractWithObject(recycler)
        task.wait(0.1)
        InteractWithObject(recycler)
        OrionLib:MakeNotification({ Name = "自动兑换", Content = "已自动传送到回收机并提交物品！", Time = 4 })
    else
        OrionLib:MakeNotification({ Name = "自动兑换", Content = "未找到废品回收机！", Time = 4 })
    end
end

-- ===================== UI 构建 =====================
local Window = OrionLib:MakeWindow({ 
    Name = "致命猿猴 · 终极辅助", 
    SubTitle = "by ER_47", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "LethalApeUltimate" 
})

local HomeTab = Window:MakeTab({ Name = "主页", Icon = "home" })
local H_Left, H_Right = HomeTab:AddSection({ Name = "快捷功能" }), HomeTab:AddSection({ Name = "系统状态与信息" })
H_Left:AddLabel("🌟 此项目由 AI 辅助制作，公益且开源，不要倒卖！")
H_Left:AddButton({ Name = "一键复制作者 UID", Callback = function() local ok = pcall(function() setclipboard("3493115679738813") end) if ok then OrionLib:MakeNotification({ Name = "复制成功", Content = "作者 UID 已复制！", Time = 4 }) else OrionLib:MakeNotification({ Name = "复制失败", Content = "执行器不支持剪贴板。", Time = 4 }) end end })
H_Left:AddButton({ Name = "一键重进当前服务器", Callback = function() OrionLib:MakeNotification({ Name = "服务器", Content = "正在尝试重新连接...", Time = 3 }) task.wait(1) game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer) end })
local SysText = H_Right:AddLabel("实时系统状态: 正在获取性能数据...")
local _fpsCount = 0 RunService.RenderStepped:Connect(function() _fpsCount = _fpsCount + 1 end)
task.spawn(function() while task.wait(1) do local fps = _fpsCount _fpsCount = 0 local ping = "获取中..." pcall(function() local stats = game:GetService("Stats") ping = math.floor(stats.Network.ServerStatsItem["Data Ping"]:GetValue()) .. " ms" end) if SysText and SysText.Text then pcall(function() SysText.Text = string.format("当前 FPS: %d | 延迟: %s\n服务器: %s", fps, ping, game.JobId) end) end end end)
H_Right:AddSlider({ Name = "UI 界面缩放", Min = 0.5, Max = 1.5, Default = 1.0, Increment = 0.1, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) local gui = game:GetService("CoreGui"):FindFirstChild("Orion") if not gui then return end local root = gui:FindFirstAncestorOfClass("ScreenGui") or gui local scale = root:FindFirstChild("GlobalUIScale") if not scale then scale = Instance.new("UIScale") scale.Name = "GlobalUIScale" scale.Parent = root end scale.Scale = v end })
H_Right:AddLabel("更新日志 (v1.5.4):\n1. 新增 赛博暗紫 主题切换\n2. 完美修复拖拽空气墙\n3. 修复头像乱码\n4. 修复刷钱逻辑")

local TabSurvival = Window:MakeTab({ Name = "生存与感知", Icon = "eye" })
local Surv_Left, Surv_Right = TabSurvival:AddSection({ Name = "威胁感知" }), TabSurvival:AddSection({ Name = "视觉增强" })
Surv_Left:AddToggle({ Name = "★ 怪物接近警报", Default = false, Callback = function(v) State.MonsterNotify = v if v then OrionLib:MakeNotification({ Name = "警报已开启", Content = "当怪物进入设定距离时会弹出通知。", Time = 3 }) end end })
Surv_Left:AddSlider({ Name = "警报触发距离", Min = 20, Max = 200, Default = 80, Increment = 5, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) State.NotifyDistance = v end })
Surv_Left:AddToggle({ Name = "★ 怪物ESP显示距离", Default = false, Callback = function(v) State.ShowMonsterDistance = v end })
Surv_Right:AddToggle({ Name = "★ 全局全亮 (Fullbright)", Default = false, Callback = function(v) State.Fullbright = v if not v then Lighting.Ambient = OrigLighting.Ambient Lighting.Brightness = OrigLighting.Brightness Lighting.ClockTime = OrigLighting.ClockTime Lighting.GlobalShadows = OrigLighting.GlobalShadows Lighting.FogEnd = OrigLighting.FogEnd end end })

local TabEscape = Window:MakeTab({ Name = "自动逃脱", Icon = "refresh-cw" })
local Esc_Left, Esc_Right = TabEscape:AddSection({ Name = "生存自动化" }), TabEscape:AddSection({ Name = "参数设置" })
Esc_Left:AddToggle({ Name = "★ 自动逃脱 (被追传送)", Default = false, Callback = function(v) State.AutoEscape = v if v then OrionLib:MakeNotification({ Name = "自动逃脱", Content = "检测到怪物进入危险距离时将自动传送。", Time = 4 }) end end })
Esc_Left:AddToggle({ Name = "★ 自动农场安全暂停", Default = false, Callback = function(v) State.AutoFarmPauseOnThreat = v if v then OrionLib:MakeNotification({ Name = "安全暂停", Content = "刷钱时若有怪物靠近，将自动降低循环频率。", Time = 4 }) end end })
Esc_Right:AddSlider({ Name = "危险距离阈值", Min = 15, Max = 100, Default = 35, Increment = 5, Color = Color3.fromRGB(255, 80, 80), Callback = function(v) State.EscapeDangerDistance = v end })

local Tab1 = Window:MakeTab({ Name = "视觉与ESP", Icon = "eye" }) local T1_Left, T1_Right = Tab1:AddSection({ Name = "实体高亮 ESP" }), Tab1:AddSection({ Name = "环境与屏幕" })
T1_Left:AddToggle({ Name = "开启怪物ESP", Default = false, Callback = function(v) State.MonkeyESP = v if v then OneTimeFullRefresh() else for _, o in pairs(Workspace:GetDescendants()) do if o.Name == "Monkey_Highlight_ESP" or o.Name == "Monkey_Text_ESP" then o:Destroy() end end end end })
T1_Left:AddToggle({ Name = "开启EarGame怪物ESP", Default = false, Callback = function(v) State.EarGameESP = v if v then OneTimeFullRefresh() else for _, o in pairs(Workspace:GetDescendants()) do if o.Name == "EarGame_Highlight_ESP" or o.Name == "EarGame_Text_ESP" then o:Destroy() end end end end })
T1_Left:AddToggle({ Name = "开关废品ESP", Default = false, Callback = function(v) State.ScrapESP = v if v then OneTimeFullRefresh() else for _, o in pairs(Workspace:GetDescendants()) do if o.Name == "Scrap_Highlight_ESP" or o.Name == "Scrap_Text_ESP" then o:Destroy() end end end end })
T1_Left:AddToggle({ Name = "开关卡片ESP", Default = false, Callback = function(v) State.CardESP = v if v then OneTimeFullRefresh() else for _, o in pairs(Workspace:GetDescendants()) do if o.Name == "Card_Highlight_ESP" or o.Name == "Card_Text_ESP" then o:Destroy() end end end end })
T1_Left:AddToggle({ Name = "开关回收机ESP", Default = false, Callback = function(v) State.RecyclerESP = v if v then OneTimeFullRefresh() else for _, o in pairs(Workspace:GetDescendants()) do if o.Name == "Recycler_Highlight_ESP" or o.Name == "Recycler_Text_ESP" then o:Destroy() end end end end })
T1_Left:AddToggle({ Name = "隐藏尸体", Default = false, Callback = function(v) State.HideBodies = v if v then for _, model in ipairs(Workspace:GetDescendants()) do hideBody(model) end if not bodyConnection then bodyConnection = Workspace.DescendantAdded:Connect(function(model) if State.HideBodies then hideBody(model) end end) end else if bodyConnection then bodyConnection:Disconnect() bodyConnection = nil end end end })
T1_Left:AddTextbox({ Name = "指定玩家名字 (精准查找)", Default = "", TextDisappear = false, Callback = function(t) State.TargetPlayerName = t end })
T1_Right:AddToggle({ Name = "开启玩家ESP", Default = false, Callback = function(v) State.PlayerESP = v if not v then for _, obj in pairs(ESPObjects) do obj.Line.Visible = false obj.Text.Visible = false end for _, p in pairs(Players:GetPlayers()) do if p.Character and p.Character:FindFirstChild("PlayerHighlight") then p.Character.PlayerHighlight:Destroy() end end end end })
T1_Right:AddToggle({ Name = "显示名字", Default = false, Callback = function(v) State.ShowNames = v end })
T1_Right:AddToggle({ Name = "显示射线", Default = false, Callback = function(v) State.ShowTracers = v end })
T1_Right:AddToggle({ Name = "显示高亮", Default = false, Callback = function(v) State.PlayerHighlight = v end })
T1_Right:AddToggle({ Name = "夜视模式 (BKU原生)", Default = false, Callback = function(v) State.NightVis = v if not v then Lighting.Brightness, Lighting.Ambient, Lighting.ClockTime = OrigLighting.Brightness, OrigLighting.Ambient, OrigLighting.ClockTime end end })
T1_Right:AddToggle({ Name = "第三人称强开 (自由缩放)", Default = false, Callback = function(v) State.ThirdPerson = v if not v then LocalPlayer.CameraMinZoomDistance = OrigCamera.MinZoom LocalPlayer.CameraMaxZoomDistance = OrigCamera.MaxZoom LocalPlayer.CameraMode = OrigCamera.Mode end end })
T1_Right:AddButton({ Name = "微亮模式", Callback = function() Lighting.Ambient = Color3.fromRGB(100,100,100) Lighting.Brightness = 1 end })
T1_Right:AddButton({ Name = "极亮模式", Callback = function() Lighting.Ambient = Color3.fromRGB(255,255,255) Lighting.Brightness = 2 end })
T1_Right:AddSlider({ Name = "时间调节 (0-24)", Min = 0, Max = 24, Default = 14, Increment = 1, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) Lighting.ClockTime = v end })
T1_Right:AddSlider({ Name = "相机视野 FOV", Min = 70, Max = 120, Default = 70, Increment = 5, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) if Camera then Camera.FieldOfView = v end end })

local TabFight = Window:MakeTab({ Name = "战斗与实用", Icon = "sword" }) local F_Left, F_Right = TabFight:AddSection({ Name = "战斗与刷钱" }), TabFight:AddSection({ Name = "安全彩蛋破解" })
F_Left:AddToggle({ Name = "★ 开启刷钱", Default = false, Callback = function(v) State.AutoGold = v if v then StartAutoGold() else StopAutoGold() end end })
F_Left:AddButton({ Name = "一键自动卖出 (手动兑换)", Callback = function() AutoScrapManual() end })
F_Left:AddToggle({ Name = "★ 防脚滑 (消除惯性)", Default = false, Callback = function(v) toggleAntiSlippery(v) end })
F_Left:AddToggle({ Name = "立即互动 (秒开箱子)", Default = false, Callback = function(v) UpdatePrompts(v) end })
F_Left:AddToggle({ Name = "扩大攻击判定框", Default = false, Callback = function(v) State.HitboxExpand = v end })
F_Left:AddSlider({ Name = "判定框大小", Min = 5, Max = 30, Default = 10, Increment = 1, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) State.HitboxSize = v end })
F_Left:AddToggle({ Name = "★ 视角平滑追踪 (最近怪物)", Default = false, Callback = function(v) State.AutoFollow = v end })
F_Left:AddToggle({ Name = "★ 自动朝向 BloodMan (视线)", Default = false, Callback = function(v) State.LockBloodman = v end })
F_Left:AddDropdown({ Name = "锁定模式", Default = "锁定视角", Options = {"锁定视角", "锁定身体"}, Callback = function(opt) State.LockBloodmanMode = opt end })
F_Left:AddToggle({ Name = "物理隐身 (服务器同步)", Default = false, Callback = function(v) toggleInvisibility(v) end })
F_Right:AddToggle({ Name = "循环安全破解彩蛋门槛", Default = false, Callback = function(v) State.SafeEggLoop = v if v then if not State._eggThread or coroutine.status(State._eggThread) == "dead" then State._eggThread = coroutine.create(function() while State.SafeEggLoop do local rs = game:GetService("ReplicatedStorage") for _, obj in ipairs(rs:GetDescendants()) do if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then local name = obj.Name:lower() local isTarget = false for _, kw in ipairs(State.EggKeywords) do if name:find(kw, 1, true) then isTarget = true break end end if isTarget then if obj:IsA("RemoteEvent") then pcall(function() obj:FireServer("unlock") end) pcall(function() obj:FireServer(true) end) elseif obj:IsA("RemoteFunction") then pcall(function() obj:InvokeServer("unlock") end) end end end end task.wait(State.SafeEggInterval) end end) coroutine.resume(State._eggThread) end OrionLib:MakeNotification({ Name = "安全破解", Content = "已开启，仅针对关键 Remote 发包。", Time = 3 }) end end })
F_Right:AddSlider({ Name = "破解循环间隔 (秒)", Min = 0.5, Max = 5, Default = 2.0, Increment = 0.5, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) State.SafeEggInterval = v end })
F_Right:AddTextbox({ Name = "自定义彩蛋关键词", Default = "egg,event,halloween,portal,gate,altar,unlock,badge,mode", TextDisappear = false, Callback = function(t) local new = {} for w in string.gmatch(t, "([^,]+)") do table.insert(new, string.lower(w):gsub("%s+", "")) end State.EggKeywords = new end })
F_Right:AddButton({ Name = "删除跳杀动画", Callback = function() for _, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do if v:IsA("RemoteEvent") and string.find(v.Name, "Play") and string.find(v.Name, "Anim") then v:Destroy() end end OrionLib:MakeNotification({ Name = "清理完成", Content = "已尝试删除跳杀动画包", Time = 3 }) end })

local Tab2 = Window:MakeTab({ Name = "移动与物理", Icon = "activity" }) local T2_Left, T2_Right = Tab2:AddSection({ Name = "移动与飞行" }), Tab2:AddSection({ Name = "物理与环境" })
T2_Left:AddSlider({ Name = "行走速度", Min = 16, Max = 200, Default = initialSpeed, Increment = 2, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) State.WalkSpeed = v local char = LocalPlayer.Character if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = v end end })
T2_Left:AddToggle({ Name = "开启速度修改", Default = false, Callback = function(v) State.SpeedEn = v if not v and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = initialSpeed end end })
T2_Left:AddSlider({ Name = "跳跃高度", Min = 50, Max = 300, Default = initialJump, Increment = 5, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) local char = LocalPlayer.Character if char and char:FindFirstChild("Humanoid") then char.Humanoid.JumpPower = v end end })
T2_Left:AddToggle({ Name = "穿墙 (Noclip)", Default = false, Callback = function(v) toggleNoclip(v) end })
T2_Left:AddToggle({ Name = "无限跳跃", Default = false, Callback = function(v) toggleInfJump(v) end })
T2_Left:AddDropdown({ Name = "飞行内核选择", Default = "Smooth", Options = {"Smooth", "CFrame", "Classic"}, Callback = function(opt) State.FlyMode = opt if State.Fly then toggleFly(false) task.wait(0.1) toggleFly(true) end end })
T2_Left:AddToggle({ Name = "自研无感飞行 (视线版)", Default = false, Callback = function(v) toggleFly(v) end })
T2_Left:AddSlider({ Name = "飞行速度", Min = 20, Max = 150, Default = 60, Increment = 10, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) State.FlySpeed = v end })
T2_Right:AddSlider({ Name = "全局重力调节", Min = 0, Max = 196, Default = 196, Increment = 5, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) Workspace.Gravity = v end })
T2_Right:AddToggle({ Name = "固定自己 (防拖拽)", Default = false, Callback = function(v) State.FreezeSelf = v if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.Anchored = v end end })
T2_Right:AddToggle({ Name = "锁定位置 (防拖拽)", Default = false, Callback = function(v) State.Anchor = v end })
T2_Right:AddToggle({ Name = "防甩飞 (Anti-Fling)", Default = false, Callback = function(v) State.AntiFling = v end })
T2_Right:AddToggle({ Name = "旋转重力 (螺旋)", Default = false, Callback = function(v) State.Spin = v end })

local Tab3 = Window:MakeTab({ Name = "传送与保命", Icon = "shield" }) local T3_Left, T3_Right = Tab3:AddSection({ Name = "快捷传送" }), Tab3:AddSection({ Name = "极限生存" })
T3_Left:AddButton({ Name = "传送到准星位置", Callback = function() local char = LocalPlayer.Character if char and char:FindFirstChild("HumanoidRootPart") and Mouse.Hit then char.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0)) end end })
T3_Left:AddButton({ Name = "传送到出生点", Callback = function() local sp = Workspace:FindFirstChildOfClass("SpawnLocation") local char = LocalPlayer.Character if sp and char and char:FindFirstChild("HumanoidRootPart") then char.HumanoidRootPart.CFrame = sp.CFrame + Vector3.new(0, 3, 0) end end })
T3_Right:AddToggle({ Name = "自动解除减速", Default = false, Callback = function(v) State.AntiSlow = v end })
T3_Right:AddToggle({ Name = "无限体力", Default = false, Callback = function(v) State.InfStamina = v end })
T3_Right:AddButton({ Name = "立即复活 (强制刷新)", Callback = function() local ok = pcall(function() LocalPlayer:LoadCharacter() end) if not ok then local char = LocalPlayer.Character if char and char:FindFirstChild("Humanoid") then char.Humanoid.Health = 0 end pcall(function() local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") or game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvents") if remotes then for _, obj in ipairs(remotes:GetDescendants()) do if obj:IsA("RemoteEvent") and obj.Name:lower():find("respawn") then obj:FireServer() break end end end end) OrionLib:MakeNotification({ Name = "复活", Content = "已尝试模拟数据包复活", Time = 3 }) end end })
T3_Right:AddToggle({ Name = "性能模式 (关特效)", Default = false, Callback = function(v) if v then Lighting.GlobalShadows = false for _, obj in pairs(Workspace:GetDescendants()) do if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") then obj.Enabled = false end end end end })
T3_Right:AddButton({ Name = "关闭脚本 UI", Callback = function() Workspace.Gravity = 196 if Camera then Camera.FieldOfView = 70 end if OrionLib then OrionLib:Destroy() end end })

local TabFun = Window:MakeTab({ Name = "整活/旋转", Icon = "refresh-cw" }) local Fun_Left = TabFun:AddSection({ Name = "角色旋转" })
Fun_Left:AddToggle({ Name = "开启原地自旋", Default = false, Callback = function(v) State.SpinSelf = v startSpin() end })
Fun_Left:AddSlider({ Name = "旋转速度", Min = 1, Max = 100, Default = 5, Increment = 1, Color = Color3.fromRGB(0, 150, 255), Callback = function(v) State.SpinSpeed = v end })
Fun_Left:AddDropdown({ Name = "旋转方向", Default = "顺时针", Options = { "顺时针", "逆时针" }, Callback = function(v) State.SpinDir = (v == "顺时针") and 1 or -1 end })

local TabExternal = Window:MakeTab({ Name = "外部脚本注入", Icon = "file-code" }) local Ext_Left, Ext_Right = TabExternal:AddSection({ Name = "一键注入功能" }), TabExternal:AddSection({ Name = "说明" })
local function injectExternalScript(scriptName, url) OrionLib:MakeNotification({ Name = "外部脚本", Content = "正在请求加载 " .. scriptName .. " ...", Time = 3 }) task.spawn(function() local ok, err = pcall(function() local source = game:HttpGet(url) if not source or source == "" then error("获取源码失败，为空。") end local func, compileErr = loadstring(source) if not func then error("编译失败: " .. tostring(compileErr)) end func() end) if ok then OrionLib:MakeNotification({ Name = "注入成功", Content = scriptName .. " 已成功运行！", Time = 4 }) else OrionLib:MakeNotification({ Name = "注入失败", Content = scriptName .. " 加载报错，请查看控制台。", Time = 5 }) warn("[" .. scriptName .. "] 注入失败: " .. tostring(err)) end end) end
Ext_Left:AddButton({ Name = "注入 茉莉璐 脚本", Callback = function() injectExternalScript("茉莉璐", "https://raw.githubusercontent.com/M0Li1u/GhostlyPilot--/refs/heads/main/LETHAL-APE.lua") end })
Ext_Left:AddButton({ Name = "注入 BKU 最新版", Callback = function() injectExternalScript("BKU 最新版", "https://raw.githubusercontent.com/Baloksxin/ROBLOX-BKU-SCRIPT/refs/heads/main/BKU%20SCRIPT.LUA") end })
Ext_Left:AddButton({ Name = "注入 BKU 旧版", Callback = function() injectExternalScript("BKU 旧版", "https://flowauth.net/v1/loaders/BKU-script-legacy.lua") end })
Ext_Right:AddLabel("1. 点击左侧按钮即可自动下载并注入对应的外部脚本。\n2. 你的主 UI 与本脚本功能不受影响，两者可同时运行。\n3. 如果提示注入失败，通常是对方服务器暂时抽风，稍后再试即可。")

-- ===================== 杂项 Tab =====================
local TabMisc = Window:MakeTab({ Name = "杂项", Icon = "settings" }) 
local Misc_Left, Misc_Right = TabMisc:AddSection({ Name = "实用工具" }), TabMisc:AddSection({ Name = "自定义踢出 / 退出" })

-- ★ 新增的换肤下拉框就在这里！
Misc_Left:AddDropdown({ 
    Name = "🎨 切换 UI 主题", 
    Default = "默认暗蓝", 
    Options = {"默认暗蓝", "赛博暗紫"}, 
    Callback = function(opt) 
        if opt == "赛博暗紫" then
            OrionLib:ChangeTheme("Purple")
        else
            OrionLib:ChangeTheme("Default")
        end
    end 
})

local antiAfkConn = nil
Misc_Left:AddToggle({ Name = "防挂机 (Anti-AFK)", Default = false, Callback = function(v) if v then if not antiAfkConn then antiAfkConn = LocalPlayer.Idled:Connect(function() local VirtualUser = game:GetService("VirtualUser") VirtualUser:CaptureController() VirtualUser:ClickButton2(Vector2.new()) end) end else if antiAfkConn then antiAfkConn:Disconnect() antiAfkConn = nil end end end })
Misc_Left:AddButton({ Name = "一键复制服务器 JobId", Callback = function() local ok = pcall(function() setclipboard(game.JobId) end) if ok then OrionLib:MakeNotification({ Name = "复制成功", Content = "服务器 ID 已复制！", Time = 4 }) else OrionLib:MakeNotification({ Name = "复制失败", Content = "执行器不支持剪贴板。", Time = 4 }) end end })
Misc_Left:AddButton({ Name = "清理内存垃圾 (防卡顿)", Callback = function() pcall(function() collectgarbage() end) OrionLib:MakeNotification({ Name = "清理完成", Content = "已强制回收内存垃圾。", Time = 3 }) end })
local customKickReason = "手动退出游戏"
Misc_Right:AddTextbox({ Name = "输入踢出理由 (仅 Kick 模式有效)", Default = "手动退出游戏", TextDisappear = false, Callback = function(t) if t == "" then customKickReason = "手动退出游戏" else customKickReason = t end end })
local kickMode = "Player:Kick (带理由)"
Misc_Right:AddDropdown({ Name = "选择退出方式", Default = "Player:Kick (带理由)", Options = {"Player:Kick (带理由)", "game:Shutdown (瞬间闪退)", "断网模拟 (回主界面)"}, Callback = function(opt) kickMode = opt end })
Misc_Right:AddButton({ Name = "⚠ 执行退出/踢出", Callback = function() if kickMode == "Player:Kick (带理由)" then pcall(function() LocalPlayer:Kick(customKickReason) end) elseif kickMode == "game:Shutdown (瞬间闪退)" then pcall(function() game:Shutdown() end) elseif kickMode == "断网模拟 (回主界面)" then pcall(function() game:GetService("NetworkClient"):Disconnect() end) end end })

OrionLib:Init()