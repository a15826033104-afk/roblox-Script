local runService = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer

pcall(function()
  if coreGui:FindFirstChild("NpcLockGui") then
    coreGui.NpcLockGui:Destroy()
  end
end)

local playerGui = localPlayer:FindFirstChild("PlayerGui")

if playerGui and playerGui:FindFirstChild("NpcLockGui") then
  playerGui.NpcLockGui:Destroy()
end

local npcLockGui = Instance.new("ScreenGui")
npcLockGui.Name = "NpcLockGui"
npcLockGui.ResetOnSpawn = false

pcall(function() npcLockGui.Parent = coreGui end)

if not npcLockGui.Parent then
  npcLockGui.Parent = localPlayer:WaitForChild("PlayerGui")
end

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 225)
frame.Position = UDim2.new(0.5, -110, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = npcLockGui

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 0, 25)
textLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
textLabel.Text = "固定在NPC脚底下"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextSize = 13
textLabel.Font = Enum.Font.SourceSansBold
textLabel.Parent = frame

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.9, 0, 0, 30)
textBox.Position = UDim2.new(0.05, 0, 0, 32)
textBox.PlaceholderText = "输入 NPC 名称..."
textBox.Text = ""
textBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.TextSize = 13
textBox.Font = Enum.Font.SourceSans
textBox.Parent = frame

local textBox2 = Instance.new("TextBox")
textBox2.Size = UDim2.new(0.9, 0, 0, 30)
textBox2.Position = UDim2.new(0.05, 0, 0, 68)
textBox2.PlaceholderText = "输入距离"
textBox2.Text = "10"
textBox2.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
textBox2.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox2.TextSize = 13
textBox2.Font = Enum.Font.SourceSans
textBox2.Parent = frame

local textButton = Instance.new("TextButton")
textButton.Size = UDim2.new(0.9, 0, 0, 30)
textButton.Position = UDim2.new(0.05, 0, 0, 104)
textButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
textButton.Text = "倒立: 关闭"
textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton.TextSize = 13
textButton.Font = Enum.Font.SourceSansBold
textButton.Parent = frame

local textButton2 = Instance.new("TextButton")
textButton2.Size = UDim2.new(0.9, 0, 0, 30)
textButton2.Position = UDim2.new(0.05, 0, 0, 140)
textButton2.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
textButton2.Text = "自动距离(Beta): 关闭"
textButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton2.TextSize = 13
textButton2.Font = Enum.Font.SourceSansBold
textButton2.Parent = frame

local textButton3 = Instance.new("TextButton")
textButton3.Size = UDim2.new(0.9, 0, 0, 35)
textButton3.Position = UDim2.new(0.05, 0, 0, 176)
textButton3.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
textButton3.Text = "开启"
textButton3.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton3.TextSize = 14
textButton3.Font = Enum.Font.SourceSansBold
textButton3.Parent = frame

local function f1(value)
  if not value or not value:IsA("BasePart") then
    return false
  elseif value.Name == "Handle" then
    return false
  else
    if value:FindFirstAncestorOfClass("Accessory") then
      return false
    end

    return true
  end
end

local v1 = false
local text = ""
local v2 = 10
local v3 = false
local v4 = false
local v5 = {}

local function f2(findFirstChild)
  v5 = {}

  for index, value2 in ipairs(findFirstChild:GetDescendants()) do
    if f1(value2) then
      v5[value2] = value2.CanCollide
    end
  end
end

local function f3()
  for key, value3 in pairs(v5) do
    if key and key:IsA("BasePart") then
      key.CanCollide = value3
    end
  end

  v5 = {}
end

local function f4(findFirstChild2, canCollide)
  for index2, value4 in ipairs(findFirstChild2:GetDescendants()) do
    if f1(value4) then
      value4.CanCollide = canCollide
    end
  end
end

textButton.MouseButton1Click:Connect(function()
  v3 = not v3

  if v3 then
    textButton.Text = "倒立: 开启"
    textButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
  else
    textButton.Text = "倒立: 关闭"
    textButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
  end
end)

textButton2.MouseButton1Click:Connect(function()
  v4 = not v4

  if v4 then
    textButton2.Text = "自动距离(Beta): 开启"
    textButton2.BackgroundColor3 = Color3.fromRGB(255, 165, 0)

    textBox2.Text = "自动"
    textBox2.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    textBox2.TextColor3 = Color3.fromRGB(200, 200, 200)
    textBox2.Selectable = false
    textBox2.Active = false
  else
    textButton2.Text = "自动距离(Beta): 关闭"
    textButton2.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

    textBox2.Text = "10"
    textBox2.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    textBox2.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox2.Selectable = true
    textBox2.Active = true
  end
end)

textButton3.MouseButton1Click:Connect(function()
  text = textBox.Text
  local v6 = tonumber(textBox2.Text)

  if v6 then
    v2 = v6
  end

  v1 = not v1

  if v1 then
    textButton3.Text = "关闭"
    textButton3.BackgroundColor3 = Color3.fromRGB(255, 85, 85)

    local findFirstChild3 = workspace:FindFirstChild(localPlayer.Name)

    if findFirstChild3 then
      f2(findFirstChild3)
      f4(findFirstChild3, false)
    end
  else
    textButton3.Text = "开启"
    textButton3.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    f3()
  end
end)

local function f5()
  local findFirstChild4 = workspace:FindFirstChild(localPlayer.Name)

  if findFirstChild4 and findFirstChild4:IsA("Model")
    and findFirstChild4:FindFirstChild("HumanoidRootPart") then
    return findFirstChild4
  end

  return nil
end

local function f6(p1)
  if not p1:FindFirstChild("HumanoidRootPart") then
    return 5
  else
    local huge = math.huge
    local v7 = -math.huge
    local count = 0

    for index3, value5 in ipairs(p1:GetDescendants()) do
      if value5:IsA("BasePart") and not value5:FindFirstAncestorOfClass("Accessory")
        and value5.Name ~= "Handle" then
        local v8 = value5.Size.Y / 2
        local v9 = value5.Position.Y - v8
        local v10 = value5.Position.Y + v8

        if v9 < huge then
          huge = v9
        end

        if v10 > v7 then
          v7 = v10
        end

        count = count + 1
      end
    end

    if count == 0 or huge == math.huge then
      return 5
    end

    return math.max(v7 - huge, 3)
  end
end

local function f7(text2)
  local findFirstChild5 = workspace:FindFirstChild(text2, true)

  if findFirstChild5 and findFirstChild5:IsA("Model") then
    if findFirstChild5:FindFirstChild("HumanoidRootPart")
      or findFirstChild5:FindFirstChildOfClass("Humanoid") then
      return findFirstChild5
    end

    return nil
  end

  return nil
end

local function f8(p2)
  local humanoidRootPart = p2:FindFirstChild("HumanoidRootPart") or p2.PrimaryPart

  if not humanoidRootPart then
    return p2:GetPivot().Position.Y, 5
  else
    local huge2 = math.huge
    local v11 = -math.huge

    for index4, value6 in ipairs(p2:GetDescendants()) do
      if value6:IsA("BasePart") then
        local v12 = value6.Size.Y / 2
        local v13 = value6.Position.Y - v12
        local v14 = value6.Position.Y + v12

        if v13 < huge2 then
          huge2 = v13
        end

        if v14 > v11 then
          v11 = v14
        end
      end
    end

    if huge2 == math.huge then
      return humanoidRootPart.Position.Y, 5
    end

    return humanoidRootPart.Position.Y, math.max(v11 - huge2, 3)
  end
end

local f9

local function f10(p3, p4)
  local v15

  if not p4:FindFirstChild("HumanoidRootPart") then
    return nil
  else
    local v16 = f6(p4)
    local v17, v18 = f8(p3)
    local getPivot = p3:GetPivot()
    local x = getPivot.X
    local z = getPivot.Z
    local v19 = f9(Vector3.new(x, v17, z), { p3 })

    if v19 then
      local v20 = v17 - v19
      local v21 = v20 > 0
      local v22 = v17 - v18 / 2

      if v21 and v20 < 20 then
        v15 = v19 - v16 / 2 - 1.5
      else
        v15 = v22 - v16 / 2 - 1.5 - 2
      end
    else
      v15 = v17 - v18 / 2 - v16 / 2 - 1.5 - 3
    end

    return Vector3.new(x, v15, z)
  end
end

function f9(index5, p5)
  local raycastParams = RaycastParams.new()
  raycastParams.FilterType = Enum.RaycastFilterType.Exclude

  local v23 = {}
  local findFirstChild6 = workspace:FindFirstChild(localPlayer.Name)

  if findFirstChild6 then
    table.insert(v23, findFirstChild6)
  end

  if p5 then
    for index6, value7 in ipairs(p5) do
      table.insert(v23, value7)
    end
  end

  raycastParams.FilterDescendantsInstances = v23
  local y

  for index7, value8 in ipairs({
    Vector3.new(0, 0, 0), Vector3.new(2, 0, 0), Vector3.new(-2, 0, 0), Vector3.new(0, 0, 2),
    Vector3.new(0, 0, -2),
  }) do
    local raycast = workspace:Raycast(
      index5 + value8 + Vector3.new(0, 10, 0), Vector3.new(0, -300, 0), raycastParams
    )

    if raycast then
      if not y or raycast.Position.Y > y then
        y = raycast.Position.Y
      end
    end
  end

  return y
end

runService.Heartbeat:Connect(function()
  local v24

  if not v1 then
    return
  elseif text == "" then
    return
  else
    local v25 = f5()

    if not v25 then
      return
    else
      local humanoidRootPart2 = v25:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart2 then
        return
      else
        local v26 = f7(text)

        if v26 and v26 ~= v25 then
          local humanoidRootPart3 = v26:FindFirstChild("HumanoidRootPart") or v26.PrimaryPart
            or v26:FindFirstChild("Head")

          if humanoidRootPart3 then
            local lookVector = humanoidRootPart3.CFrame.LookVector
            local v27 = math.atan2(lookVector.X, -lookVector.Z)

            if v4 then
              v24 = f10(v26, v25)

              if not v24 then
                v24 = humanoidRootPart3.Position + Vector3.new(0, -10, 0)
              end
            else
              v24 = humanoidRootPart3.Position + Vector3.new(0, -v2, 0)
            end

            humanoidRootPart2.CFrame = CFrame.new(v24) * CFrame.Angles(0, v27, 0)

            if v3 then
              humanoidRootPart2.CFrame = humanoidRootPart2.CFrame * CFrame.Angles(math.pi, 0, 0)
            end

            humanoidRootPart2.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            humanoidRootPart2.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
          end
        end

        return
      end
    end
  end
end)
