-- ==============================================================
-- 魔改版 Orion UI 引擎 (BKU特供)
-- 修复：空气墙拖拽、头像乱码、标签图标丢失
-- 新增：内置紫罗兰主题、动态换肤 API
-- ==============================================================
local CoreGui = game:GetService("CoreGui")
local OrionLib = (function()
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local Mouse = LocalPlayer:GetMouse()
    local HttpService = game:GetService("HttpService")
    
    local OrionLib = { 
        Elements = {}, ThemeObjects = {}, Connections = {}, Flags = {}, 
        Themes = { 
            Default = { 
                Main = Color3.fromRGB(20, 30, 45), 
                Second = Color3.fromRGB(30, 50, 70), 
                Stroke = Color3.fromRGB(100, 180, 230), 
                Divider = Color3.fromRGB(50, 80, 110), 
                Text = Color3.fromRGB(230, 245, 255), 
                TextDark = Color3.fromRGB(150, 190, 220) 
            },
            Purple = {
                Main = Color3.fromRGB(25, 15, 35),
                Second = Color3.fromRGB(40, 25, 55),
                Stroke = Color3.fromRGB(180, 100, 255),
                Divider = Color3.fromRGB(70, 40, 90),
                Text = Color3.fromRGB(245, 235, 255),
                TextDark = Color3.fromRGB(200, 170, 220)
            }
        }, 
        SelectedTheme = "Default", Folder = nil, SaveCfg = false, LastDragEnd = 0 
    }
    
    function OrionLib:Toggle()
        if tick() - self.LastDragEnd < 0.2 then return end
        local UI = game:GetService("CoreGui"):FindFirstChild("Orion") or (gethui and gethui():FindFirstChild("Orion"))
        if UI then
            local MainWindow, OpenToggleBtn = UI:FindFirstChild("Main"), UI:FindFirstChild("OrionOpenToggle")
            if MainWindow and OpenToggleBtn then
                local Visible = not MainWindow.Visible
                MainWindow.Visible, OpenToggleBtn.Visible = Visible, not Visible
            end
        end
    end

    -- ===================== 图标加载与强力兜底 =====================
    local Icons = {}
    local Success, Response = pcall(function() Icons = HttpService:JSONDecode(game:HttpGetAsync("https://raw.githubusercontent.com/evoincorp/lucideblox/master/src/modules/util/icons.json")).icons end)
    
    local FallbackIcons = {
        home           = "rbxassetid://7733955511",
        eye            = "rbxassetid://7733960981",
        sword          = "rbxassetid://7734068321",
        activity       = "rbxassetid://7733770149",
        shield         = "rbxassetid://7734068361",
        ["refresh-cw"] = "rbxassetid://7734090142",
        ["file-code"]  = "rbxassetid://7733977987",
        settings       = "rbxassetid://7734053426",
        user           = "rbxassetid://7734053494",
        users          = "rbxassetid://7734053515",
        star           = "rbxassetid://7734068322",
        info           = "rbxassetid://7734049806",
        lock           = "rbxassetid://7734049839",
        heart          = "rbxassetid://7734030156",
        zap            = "rbxassetid://7734090142",
        map            = "rbxassetid://7734049781",
        trash          = "rbxassetid://7734078494",
        key            = "rbxassetid://7734049757",
        skull          = "rbxassetid://7734068338"
    }

    local function GetIcon(IconName)
        if type(IconName) ~= "string" then return "" end
        if Icons[IconName] ~= nil then return Icons[IconName] end
        if FallbackIcons[IconName] ~= nil then return FallbackIcons[IconName] end
        if IconName:find("rbxassetid://") or IconName:find("rbxthumb://") or IconName:find("http") then 
            return IconName 
        end
        return "rbxassetid://7734053426"
    end

    local Orion = Instance.new("ScreenGui") 
    Orion.Name = "Orion"
    if syn then syn.protect_gui(Orion) Orion.Parent = game.CoreGui else Orion.Parent = gethui() or game.CoreGui end
    if gethui then for _, Interface in ipairs(gethui():GetChildren()) do if Interface.Name == Orion.Name and Interface ~= Orion then Interface:Destroy() end end else for _, Interface in ipairs(game.CoreGui:GetChildren()) do if Interface.Name == Orion.Name and Interface ~= Orion then Interface:Destroy() end end end
    
    function OrionLib:IsRunning() 
        if gethui then return Orion.Parent == gethui() else return Orion.Parent == game:GetService("CoreGui") end 
    end
    
    local function AddConnection(Signal, Function) 
        if not OrionLib:IsRunning() then return end 
        local SignalConnect = Signal:Connect(Function) 
        table.insert(OrionLib.Connections, SignalConnect) 
        return SignalConnect 
    end
    
    task.spawn(function() 
        while OrionLib:IsRunning() do wait() end 
        for _, Connection in next, OrionLib.Connections do Connection:Disconnect() end 
    end)
    
    local LastDragEnd = 0
    
    -- 极度自由的拖拽函数（无空气墙）
    local function MakeDraggable(DragPoint, Main)
        pcall(function()
            local Dragging, MousePos, FramePos = false, nil, nil
            AddConnection(DragPoint.InputBegan, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Dragging, MousePos, FramePos = true, Input.Position, Main.Position
                    Input.Changed:Connect(function() 
                        if Input.UserInputState == Enum.UserInputState.End then 
                            Dragging = false 
                            LastDragEnd = tick() 
                        end 
                    end)
                end
            end)
            AddConnection(UserInputService.InputChanged, function(Input)
                if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
                    local Delta = Input.Position - MousePos
                    local ViewportSize = workspace.CurrentCamera.ViewportSize
                    local RawX = FramePos.X.Scale * ViewportSize.X + FramePos.X.Offset + Delta.X
                    local RawY = FramePos.Y.Scale * ViewportSize.Y + FramePos.Y.Offset + Delta.Y
                    
                    local Size = Main.AbsoluteSize
                    
                    local MinX = -(Size.X - 50)
                    local MaxX = ViewportSize.X - 50
                    local MinY = -(Size.Y - 20)
                    local MaxY = ViewportSize.Y - 20
                    
                    if MinX > 0 then MinX = 0 end
                    if MaxX < ViewportSize.X then MaxX = ViewportSize.X end
                    if MinY > 0 then MinY = 0 end
                    if MaxY < ViewportSize.Y then MaxY = ViewportSize.Y end
                    if MinX > MaxX then local t = MinX; MinX = MaxX; MaxX = t end
                    if MinY > MaxY then local t = MinY; MinY = MaxY; MaxY = t end

                    Main.Position = UDim2.new(0, math.clamp(RawX, MinX, MaxX), 0, math.clamp(RawY, MinY, MaxY))
                end
            end)
        end)
    end
    
    local function Create(Name, Properties, Children) 
        local Object = Instance.new(Name) 
        for i, v in next, Properties or {} do Object[i] = v end 
        for i, v in next, Children or {} do v.Parent = Object end 
        return Object 
    end
    
    local function CreateElement(ElementName, ElementFunction) 
        OrionLib.Elements[ElementName] = function(...) return ElementFunction(...) end 
    end
    
    local function MakeElement(ElementName, ...) return OrionLib.Elements[ElementName](...) end
    local function SetProps(Element, Props) for Property, Value in pairs(Props or {}) do Element[Property] = Value end return Element end
    local function SetChildren(Element, Children) for _, Child in pairs(Children or {}) do Child.Parent = Element end return Element end
    local function Round(Number, Factor) local Result = math.floor(Number / Factor + (math.sign(Number) * 0.5)) * Factor if Result < 0 then Result = Result + Factor end return Result end
    
    local function ReturnProperty(Object)
        if Object:IsA("Frame") or Object:IsA("TextButton") then return "BackgroundColor3" end
        if Object:IsA("ScrollingFrame") then return "ScrollBarImageColor3" end
        if Object:IsA("UIStroke") then return "Color" end
        if Object:IsA("TextLabel") or Object:IsA("TextBox") then return "TextColor3" end
        if Object:IsA("ImageLabel") or Object:IsA("ImageButton") then return "ImageColor3" end
    end
    
    local function AddThemeObject(Object, Type) 
        if not OrionLib.ThemeObjects[Type] then OrionLib.ThemeObjects[Type] = {} end 
        table.insert(OrionLib.ThemeObjects[Type], Object) 
        Object[ReturnProperty(Object)] = OrionLib.Themes[OrionLib.SelectedTheme][Type] 
        if Type == "Main" then Object.BackgroundTransparency = 0.15 elseif Type == "Second" then Object.BackgroundTransparency = 0.25 end 
        return Object 
    end

    -- ★ 动态切换主题 API
    function OrionLib:ChangeTheme(ThemeName)
        if not self.Themes[ThemeName] then return end
        self.SelectedTheme = ThemeName
        local Theme = self.Themes[ThemeName]
        
        for Type, Objects in pairs(self.ThemeObjects) do
            for _, Object in pairs(Objects) do
                if Object and Object.Parent then
                    local Prop = ReturnProperty(Object)
                    if Prop and Theme[Type] then
                        TweenService:Create(Object, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { [Prop] = Theme[Type] }):Play()
                    end
                    if Type == "Main" then
                        TweenService:Create(Object, TweenInfo.new(0.3), { BackgroundTransparency = 0.15 }):Play()
                    elseif Type == "Second" then
                        TweenService:Create(Object, TweenInfo.new(0.3), { BackgroundTransparency = 0.25 }):Play()
                    end
                end
            end
        end
    end
    
    local function PackColor(Color) return { R = Color.R * 255, G = Color.G * 255, B = Color.B * 255 } end
    local function UnpackColor(Color) return Color3.fromRGB(Color.R, Color.G, Color.B) end
    
    local function LoadCfg(Config) 
        local Data = HttpService:JSONDecode(Config) 
        for a, b in pairs(Data) do 
            if OrionLib.Flags[a] then 
                spawn(function() if OrionLib.Flags[a].Type == "Colorpicker" then OrionLib.Flags[a]:Set(UnpackColor(b)) else OrionLib.Flags[a]:Set(b) end end) 
            end 
        end 
    end
    
    local function SaveCfg(Name) 
        if not OrionLib.SaveCfg then return end 
        local Data = {} 
        for i, v in pairs(OrionLib.Flags) do 
            if v.Save then 
                if v.Type == "Colorpicker" then Data[i] = PackColor(v.Value) else Data[i] = v.Value end 
            end 
        end 
        pcall(function() writefile(OrionLib.Folder .. "/" .. Name .. ".lua", tostring(HttpService:JSONEncode(Data))) end)
    end
    
    CreateElement("Corner", function(Scale, Offset) return Create("UICorner", { CornerRadius = UDim.new(Scale or 0, Offset or 10) }) end)
    CreateElement("Stroke", function(Color, Thickness) return Create("UIStroke", { Color = Color or Color3.fromRGB(255, 255, 255), Thickness = Thickness or 1 }) end)
    CreateElement("List", function(Scale, Offset) return Create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(Scale or 0, Offset or 0) }) end)
    CreateElement("Padding", function(Bottom, Left, Right, Top) return Create("UIPadding", { PaddingBottom = UDim.new(0, Bottom or 4), PaddingLeft = UDim.new(0, Left or 4), PaddingRight = UDim.new(0, Right or 4), PaddingTop = UDim.new(0, Top or 4) }) end)
    CreateElement("TFrame", function() return Create("Frame", { BackgroundTransparency = 1 }) end)
    CreateElement("Frame", function(Color) return Create("Frame", { BackgroundColor3 = Color or Color3.fromRGB(255, 255, 255), BorderSizePixel = 0 }) end)
    CreateElement("RoundFrame", function(Color, Scale, Offset) return Create("Frame", { BackgroundColor3 = Color or Color3.fromRGB(255, 255, 255), BorderSizePixel = 0 }, { Create("UICorner", { CornerRadius = UDim.new(Scale, Offset) }) }) end)
    CreateElement("Button", function() return Create("TextButton", { Text = "", AutoButtonColor = false, BackgroundTransparency = 1, BorderSizePixel = 0 }) end)
    CreateElement("ScrollFrame", function(Color, Width) return Create("ScrollingFrame", { BackgroundTransparency = 1, MidImage = "rbxassetid://7445543667", BottomImage = "rbxassetid://7445543667", TopImage = "rbxassetid://7445543667", ScrollBarImageColor3 = Color, BorderSizePixel = 0, ScrollBarThickness = Width, CanvasSize = UDim2.new(0, 0, 0, 0) }) end)
    CreateElement("Image", function(ImageID) return Create("ImageLabel", { Image = GetIcon(ImageID), BackgroundTransparency = 1 }) end)
    CreateElement("Label", function(Text, TextSize, Transparency) return Create("TextLabel", { Text = Text or "", TextColor3 = Color3.fromRGB(240, 240, 240), TextTransparency = Transparency or 0, TextSize = TextSize or 15, Font = Enum.Font.Gotham, RichText = true, BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left }) end)
    
    local NotificationHolder = SetProps(SetChildren(MakeElement("TFrame"), { SetProps(MakeElement("List"), { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Top, Padding = UDim.new(0, 5) }) }), { Position = UDim2.new(0.5, 0, 0, 25), Size = UDim2.new(0, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.XY, AnchorPoint = Vector2.new(0.5, 0), Parent = Orion })
    
    function OrionLib:MakeNotification(NotificationConfig)
        spawn(function()
            NotificationConfig.Name = NotificationConfig.Name or "Notification" 
            NotificationConfig.Content = NotificationConfig.Content or "Test" 
            NotificationConfig.Image = NotificationConfig.Image or "rbxassetid://4384403532" 
            NotificationConfig.Time = NotificationConfig.Time or 15
            local ScreenSize, NotifWidth = Orion.AbsoluteSize, math.min(400, Orion.AbsoluteSize.X * 0.35)
            local NotificationParent = SetProps(MakeElement("TFrame"), { Size = UDim2.new(0, NotifWidth, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = NotificationHolder })
            local NotificationFrame = SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(20, 30, 45), 0, 10), { Parent = NotificationParent, Size = UDim2.new(1, 0, 0, 0), Position = UDim2.new(0, 0, 0, -ScreenSize.Y * 0.3), BackgroundTransparency = 0, AutomaticSize = Enum.AutomaticSize.Y }), { MakeElement("Stroke", Color3.fromRGB(100, 180, 230), 1.2), MakeElement("Padding", 12, 12, 12, 12), SetProps(MakeElement("Image", NotificationConfig.Image), { Size = UDim2.new(0, 20, 0, 20), ImageColor3 = Color3.fromRGB(240, 240, 255), Name = "Icon" }), SetProps(MakeElement("Label", NotificationConfig.Name, 15), { Size = UDim2.new(1, -30, 0, 20), Position = UDim2.new(0, 30, 0, 0), Font = Enum.Font.GothamBold, Name = "Title" }), SetProps(MakeElement("Label", NotificationConfig.Content, 14), { Size = UDim2.new(1, 0, 0, 0), Position = UDim2.new(0, 0, 0, 25), Font = Enum.Font.GothamSemibold, Name = "Content", AutomaticSize = Enum.AutomaticSize.Y, TextColor3 = Color3.fromRGB(150, 190, 220), TextWrapped = true }) })
            TweenService:Create(NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { Position = UDim2.new(0, 0, 0, 0) }):Play() wait(NotificationConfig.Time - 0.88)
            TweenService:Create(NotificationFrame.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint), { ImageTransparency = 1 }):Play() TweenService:Create(NotificationFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quint), { BackgroundTransparency = 0.6 }):Play() wait(0.3)
            TweenService:Create(NotificationFrame.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { Transparency = 0.9 }):Play() TweenService:Create(NotificationFrame.Title, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { TextTransparency = 0.4 }):Play() TweenService:Create(NotificationFrame.Content, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { TextTransparency = 0.5 }):Play() wait(0.05)
            TweenService:Create(NotificationFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quint), { Position = UDim2.new(0, 0, 0, -ScreenSize.Y * 0.5) }):Play() wait(1.0) NotificationFrame:Destroy()
        end)
    end
    
    function OrionLib:Init() 
        if OrionLib.SaveCfg then pcall(function() if isfile(OrionLib.Folder .. "/" .. game.GameId .. ".lua") then LoadCfg(readfile(OrionLib.Folder .. "/" .. game.GameId .. ".lua")) OrionLib:MakeNotification({ Name = "配置", Content = "自动载入游戏配置" .. game.GameId .. ".", Time = 5 }) end end) end 
    end
    
    function OrionLib:MakeWindow(WindowConfig)
        local FirstTab, Minimized, UIHidden = true, false, false
        WindowConfig = WindowConfig or {} 
        WindowConfig.Name = WindowConfig.Name or "Orion Library" 
        WindowConfig.ConfigFolder = WindowConfig.ConfigFolder or WindowConfig.Name 
        WindowConfig.SaveConfig = WindowConfig.SaveConfig or false 
        WindowConfig.HidePremium = WindowConfig.HidePremium or false
        if WindowConfig.IntroEnabled == nil then WindowConfig.IntroEnabled = true end
        WindowConfig.IntroText = WindowConfig.IntroText or "Orion Library" 
        WindowConfig.CloseCallback = WindowConfig.CloseCallback or function() end 
        WindowConfig.ShowIcon = WindowConfig.ShowIcon or false 
        WindowConfig.Icon = WindowConfig.Icon or "rbxassetid://8834748103" 
        WindowConfig.IntroIcon = WindowConfig.IntroIcon or "rbxassetid://8834748103"
        OrionLib.Folder, OrionLib.SaveCfg = WindowConfig.ConfigFolder, WindowConfig.SaveConfig
        if WindowConfig.SaveConfig then if not isfolder(WindowConfig.ConfigFolder) then makefolder(WindowConfig.ConfigFolder) end end
        
        local DragPoint = SetProps(MakeElement("TFrame"), { Size = UDim2.new(1, 0, 0, 50), Position = UDim2.new(0, 0, 0, 0), ZIndex = 2 })
        
        local TabHolder = AddThemeObject(SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 4), { Size = UDim2.new(1, 0, 1, -50) }), { MakeElement("List"), MakeElement("Padding", 8, 0, 0, 8) }), "Divider")
        AddConnection(TabHolder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function() TabHolder.CanvasSize = UDim2.new(0, 0, 0, TabHolder.UIListLayout.AbsoluteContentSize.Y + 16) end)
        local CloseBtn = SetChildren(SetProps(MakeElement("Button"), { Size = UDim2.new(0.5, 0, 1, 0), Position = UDim2.new(0.5, 0, 0, 0), BackgroundTransparency = 1, ZIndex = 3 }), { AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072725342"), { Position = UDim2.new(0, 9, 0, 6), Size = UDim2.new(0, 18, 0, 18) }), "Text") })
        local MinimizeBtn = SetChildren(SetProps(MakeElement("Button"), { Size = UDim2.new(0.5, 0, 1, 0), BackgroundTransparency = 1, ZIndex = 3 }), { AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072719338"), { Position = UDim2.new(0, 9, 0, 6), Size = UDim2.new(0, 18, 0, 18), Name = "Ico" }), "Text") })
        
        local WindowStuff = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 10), { Size = UDim2.new(0, 150, 1, -50), Position = UDim2.new(0, 0, 0, 50) }), { AddThemeObject(SetProps(MakeElement("Frame"), { Size = UDim2.new(1, 0, 0, 10), Position = UDim2.new(0, 0, 0, 0) }), "Second"), AddThemeObject(SetProps(MakeElement("Frame"), { Size = UDim2.new(0, 10, 1, 0), Position = UDim2.new(1, -10, 0, 0) }), "Second"), AddThemeObject(SetProps(MakeElement("Frame"), { Size = UDim2.new(0, 1, 1, 0), Position = UDim2.new(1, -1, 0, 0) }), "Stroke"), TabHolder, SetChildren(SetProps(MakeElement("TFrame"), { Size = UDim2.new(1, 0, 0, 50), Position = UDim2.new(0, 0, 1, -50) }), { AddThemeObject(SetProps(MakeElement("Frame"), { Size = UDim2.new(1, 0, 0, 1) }), "Stroke"), 
            AddThemeObject(SetChildren(SetProps(MakeElement("Frame"), { AnchorPoint = Vector2.new(0, 0.5), Size = UDim2.new(0, 32, 0, 32), Position = UDim2.new(0, 10, 0.5, 0) }), { 
                SetProps(MakeElement("Image", "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"), { Size = UDim2.new(1, 0, 1, 0) }), 
                AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://4031889928"), { Size = UDim2.new(1, 0, 1, 0) }), "Second"), 
                MakeElement("Corner", 1) 
            }), "Divider"), 
            SetChildren(SetProps(MakeElement("TFrame"), { AnchorPoint = Vector2.new(0, 0.5), Size = UDim2.new(0, 32, 0, 32), Position = UDim2.new(0, 10, 0.5, 0) }), { AddThemeObject(MakeElement("Stroke"), "Stroke"), MakeElement("Corner", 1) }), AddThemeObject(SetProps(MakeElement("Label", LocalPlayer.DisplayName, WindowConfig.HidePremium and 14 or 13), { Size = UDim2.new(1, -60, 0, 13), Position = WindowConfig.HidePremium and UDim2.new(0, 50, 0, 19) or UDim2.new(0, 50, 0, 12), Font = Enum.Font.GothamBold, ClipsDescendants = true }), "Text"), AddThemeObject(SetProps(MakeElement("Label", "", 12), { Size = UDim2.new(1, -60, 0, 12), Position = UDim2.new(0, 50, 1, -25), Visible = not WindowConfig.HidePremium }), "TextDark") }) }), "Second")
        
        local WindowName = AddThemeObject(SetProps(MakeElement("Label", WindowConfig.Name, 14), { Size = UDim2.new(1, -120, 0, 22), Position = UDim2.new(0, 25, 0, 4), Font = Enum.Font.GothamBlack, TextSize = 18 }), "Text")
        local WindowSubTitle = nil 
        if WindowConfig.SubTitle and WindowConfig.SubTitle ~= "" then 
            WindowSubTitle = SetProps(MakeElement("Label", WindowConfig.SubTitle, 12), { Size = UDim2.new(1, -120, 0, 14), Position = UDim2.new(0, 25, 0, 26), Font = Enum.Font.Gotham, TextSize = 11, TextColor3 = Color3.fromRGB(160, 190, 210), TextXAlignment = Enum.TextXAlignment.Left }) 
        end
        
        local WindowTopBarLine = AddThemeObject(SetProps(MakeElement("Frame"), { Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 1, -1) }), "Stroke")
        
        local MainWindow = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 10), { Parent = Orion, Position = UDim2.new(0.5, -307, 0, 50), Size = UDim2.new(0, 615, 0, 344), ClipsDescendants = true, Active = true, Draggable = false }), { SetChildren(SetProps(MakeElement("TFrame"), { Size = UDim2.new(1, 0, 0, 50), Name = "TopBar" }), { WindowName, WindowSubTitle, WindowTopBarLine, AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 7), { Size = UDim2.new(0, 70, 0, 30), Position = UDim2.new(1, -90, 0, 10) }), { AddThemeObject(MakeElement("Stroke"), "Stroke"), AddThemeObject(SetProps(MakeElement("Frame"), { Size = UDim2.new(0, 1, 1, 0), Position = UDim2.new(0.5, 0, 0, 0) }), "Stroke"), CloseBtn, MinimizeBtn }), "Second") }), DragPoint, WindowStuff }), "Main")
        
        if WindowConfig.ShowIcon then WindowName.Position = UDim2.new(0, 50, 0, -24) local WindowIcon = SetProps(MakeElement("Image", WindowConfig.Icon), { Size = UDim2.new(0, 20, 0, 20), Position = UDim2.new(0, 25, 0, 15) }) WindowIcon.Parent = MainWindow.TopBar end
        
        MakeDraggable(DragPoint, MainWindow)
        
        local OpenToggleBtn = Create("TextButton", { Name = "OrionOpenToggle", Size = UDim2.new(0, 50, 0, 50), Position = UDim2.new(0, 20, 0.5, -25), BackgroundColor3 = Color3.fromRGB(20, 35, 50), Text = "UI", TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.GothamBold, TextSize = 14, Visible = false, Active = true, Parent = Orion })
        Instance.new("UICorner", OpenToggleBtn).CornerRadius = UDim.new(0, 12)
        local Gradient = Instance.new("UIGradient", OpenToggleBtn) Gradient.Color = ColorSequence.new(Color3.fromRGB(100, 180, 230), Color3.fromRGB(40, 80, 120)) Gradient.Rotation = 45
        local Stroke = Instance.new("UIStroke", OpenToggleBtn) Stroke.Color = Color3.fromRGB(255, 255, 255) Stroke.Transparency = 0.5 Stroke.Thickness = 1.5
        OpenToggleBtn.MouseEnter:Connect(function() TweenService:Create(OpenToggleBtn, TweenInfo.new(0.3), { Size = UDim2.new(0, 55, 0, 55) }):Play() end) OpenToggleBtn.MouseLeave:Connect(function() TweenService:Create(OpenToggleBtn, TweenInfo.new(0.3), { Size = UDim2.new(0, 50, 0, 50) }):Play() end) OpenToggleBtn.MouseButton1Click:Connect(function() OrionLib:Toggle() end)
        MakeDraggable(OpenToggleBtn, OpenToggleBtn)
        
        local function SetUIVisibility(visible) MainWindow.Visible = visible UIHidden = not visible OpenToggleBtn.Visible = not visible end
        AddConnection(CloseBtn.MouseButton1Up, function() SetUIVisibility(false) OrionLib:MakeNotification({ Name = "界面隐藏", Content = "点击左侧开关或右Shift重新打开界面", Time = 5 }) local Sound = Instance.new("Sound") Sound.SoundId = "rbxassetid://4590662766" Sound.Parent = game:GetService("SoundService") Sound.Volume = 5 Sound:Play() spawn(function() Sound.Ended:Wait() Sound:Destroy() end) WindowConfig.CloseCallback() end)
        AddConnection(OpenToggleBtn.MouseButton1Click, function() SetUIVisibility(true) end) 
        AddConnection(UserInputService.InputBegan, function(Input) if Input.KeyCode == Enum.KeyCode.RightShift and UIHidden then SetUIVisibility(true) end end)
        AddConnection(MinimizeBtn.MouseButton1Up, function() if Minimized then TweenService:Create(MainWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(0, 615, 0, 344) }):Play() MinimizeBtn.Ico.Image = "rbxassetid://7072719338" wait(0.02) MainWindow.ClipsDescendants = false WindowStuff.Visible = true WindowTopBarLine.Visible = true else MainWindow.ClipsDescendants = true WindowTopBarLine.Visible = false MinimizeBtn.Ico.Image = "rbxassetid://7072720870" TweenService:Create(MainWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(0, WindowName.TextBounds.X + 140, 0, 50) }):Play() wait(0.1) WindowStuff.Visible = false end Minimized = not Minimized end)
        
        local function LoadSequence() MainWindow.Visible = false local LoadSequenceLogo = SetProps(MakeElement("Image", WindowConfig.IntroIcon), { Parent = Orion, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.4, 0), Size = UDim2.new(0, 28, 0, 28), ImageColor3 = Color3.fromRGB(255, 255, 255), ImageTransparency = 1 }) local LoadSequenceText = SetProps(MakeElement("Label", WindowConfig.IntroText, 14), { Parent = Orion, Size = UDim2.new(1, 0, 1, 0), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 19, 0.5, 0), TextXAlignment = Enum.TextXAlignment.Center, Font = Enum.Font.GothamBold, TextTransparency = 1 }) TweenService:Create(LoadSequenceLogo, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { ImageTransparency = 0, Position = UDim2.new(0.5, 0, 0.5, 0) }):Play() wait(0.8) TweenService:Create(LoadSequenceLogo, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = UDim2.new(0.5, -(LoadSequenceText.TextBounds.X / 2), 0.5, 0) }):Play() wait(0.3) TweenService:Create(LoadSequenceText, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play() wait(2) TweenService:Create(LoadSequenceText, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { TextTransparency = 1 }):Play() MainWindow.Visible = true LoadSequenceLogo:Destroy() LoadSequenceText:Destroy() end
        if WindowConfig.IntroEnabled then LoadSequence() end
        
        local TabFunction = {}
        function TabFunction:MakeTab(TabConfig)
            TabConfig = TabConfig or {} TabConfig.Name = TabConfig.Name or "Tab" TabConfig.Icon = TabConfig.Icon or "" TabConfig.PremiumOnly = TabConfig.PremiumOnly or false
            local TabFrame = SetChildren(SetProps(MakeElement("Button"), { Size = UDim2.new(1, 0, 0, 30), Parent = TabHolder }), { AddThemeObject(SetProps(MakeElement("Image", TabConfig.Icon), { AnchorPoint = Vector2.new(0, 0.5), Size = UDim2.new(0, 18, 0, 18), Position = UDim2.new(0, 10, 0.5, 0), ImageTransparency = 0.4, Name = "Ico" }), "Text"), AddThemeObject(SetProps(MakeElement("Label", TabConfig.Name, 14), { Size = UDim2.new(1, -35, 1, 0), Position = UDim2.new(0, 35, 0, 0), Font = Enum.Font.GothamSemibold, TextTransparency = 0.4, Name = "Title" }), "Text") })
            local Container = AddThemeObject(SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 5), { Size = UDim2.new(1, -150, 1, -50), Position = UDim2.new(0, 150, 0, 50), Parent = MainWindow, Visible = false, Name = "ItemContainer" }), { MakeElement("List", 0, 6), MakeElement("Padding", 15, 10, 10, 15) }), "Divider")
            AddConnection(Container.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function() Container.CanvasSize = UDim2.new(0, 0, 0, Container.UIListLayout.AbsoluteContentSize.Y + 30) end)
            if FirstTab then FirstTab = false TabFrame.Ico.ImageTransparency = 0 TabFrame.Title.TextTransparency = 0 TabFrame.Title.Font = Enum.Font.GothamBlack Container.Visible = true end
            AddConnection(TabFrame.MouseButton1Click, function() for _, Tab in next, TabHolder:GetChildren() do if Tab:IsA("TextButton") then Tab.Title.Font = Enum.Font.GothamSemibold TweenService:Create(Tab.Ico, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { ImageTransparency = 0.4 }):Play() TweenService:Create(Tab.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { TextTransparency = 0.4 }):Play() end end for _, ItemContainer in next, MainWindow:GetChildren() do if ItemContainer.Name == "ItemContainer" then ItemContainer.Visible = false end end TweenService:Create(TabFrame.Ico, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { ImageTransparency = 0 }):Play() TweenService:Create(TabFrame.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play() TabFrame.Title.Font = Enum.Font.GothamBlack Container.Visible = true end)
            local function GetElements(ItemParent)
                local ElementFunction = {}
                function ElementFunction:AddLabel(Text) local LabelFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), { Size = UDim2.new(1, 0, 0, 30), BackgroundTransparency = 0.7, Parent = ItemParent }), { AddThemeObject(SetProps(MakeElement("Label", Text, 15), { Size = UDim2.new(1, -12, 1, 0), Position = UDim2.new(0, 12, 0, 0), Font = Enum.Font.GothamBold, Name = "Content" }), "Text"), AddThemeObject(MakeElement("Stroke"), "Stroke") }), "Second") local LabelFunction = {} function LabelFunction:Set(ToChange) LabelFrame.Content.Text = ToChange end return LabelFunction end
                function ElementFunction:AddButton(ButtonConfig) ButtonConfig = ButtonConfig or {} ButtonConfig.Name = ButtonConfig.Name or "Button" ButtonConfig.Callback = ButtonConfig.Callback or function() end ButtonConfig.Icon = ButtonConfig.Icon or "rbxassetid://3944703587" local Button = {} local Click = SetProps(MakeElement("Button"), { Size = UDim2.new(1, 0, 1, 0) }) local ButtonFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), { Size = UDim2.new(1, 0, 0, 33), Parent = ItemParent }), { AddThemeObject(SetProps(MakeElement("Label", ButtonConfig.Name, 15), { Size = UDim2.new(1, -12, 1, 0), Position = UDim2.new(0, 12, 0, 0), Font = Enum.Font.GothamBold, Name = "Content" }), "Text"), AddThemeObject(SetProps(MakeElement("Image", ButtonConfig.Icon), { Size = UDim2.new(0, 20, 0, 20), Position = UDim2.new(1, -30, 0, 7) }), "TextDark"), AddThemeObject(MakeElement("Stroke"), "Stroke"), Click }), "Second") AddConnection(Click.MouseButton1Up, function() TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3) }):Play() spawn(function() ButtonConfig.Callback() end) end) function Button:Set(ButtonText) ButtonFrame.Content.Text = ButtonText end return Button end
                function ElementFunction:AddToggle(ToggleConfig) ToggleConfig = ToggleConfig or {} ToggleConfig.Name = ToggleConfig.Name or "Toggle" ToggleConfig.Default = ToggleConfig.Default or false ToggleConfig.Callback = ToggleConfig.Callback or function() end ToggleConfig.Color = ToggleConfig.Color or Color3.fromRGB(9, 99, 195) ToggleConfig.Flag = ToggleConfig.Flag or nil ToggleConfig.Save = ToggleConfig.Save or false local Toggle = { Value = ToggleConfig.Default, Save = ToggleConfig.Save } local Click = SetProps(MakeElement("Button"), { Size = UDim2.new(1, 0, 1, 0) }) local ToggleBox = SetChildren(SetProps(MakeElement("RoundFrame", ToggleConfig.Color, 0, 4), { Size = UDim2.new(0, 24, 0, 24), Position = UDim2.new(1, -24, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5) }), { SetProps(MakeElement("Stroke"), { Color = ToggleConfig.Color, Name = "Stroke", Transparency = 0.5 }), SetProps(MakeElement("Image", "rbxassetid://3944680095"), { Size = UDim2.new(0, 20, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), ImageColor3 = Color3.fromRGB(255, 255, 255), Name = "Ico" }) }) local ToggleFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), { Size = UDim2.new(1, 0, 0, 38), Parent = ItemParent }), { AddThemeObject(SetProps(MakeElement("Label", ToggleConfig.Name, 15), { Size = UDim2.new(1, -12, 1, 0), Position = UDim2.new(0, 12, 0, 0), Font = Enum.Font.GothamBold, Name = "Content" }), "Text"), AddThemeObject(MakeElement("Stroke"), "Stroke"), ToggleBox, Click }), "Second") function Toggle:Set(Value) Toggle.Value = Value TweenService:Create(ToggleBox, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { BackgroundColor3 = Toggle.Value and ToggleConfig.Color or OrionLib.Themes[OrionLib.SelectedTheme].Divider }):Play() TweenService:Create(ToggleBox.Stroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Color = Toggle.Value and ToggleConfig.Color or OrionLib.Themes[OrionLib.SelectedTheme].Stroke }):Play() TweenService:Create(ToggleBox.Ico, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { ImageTransparency = Toggle.Value and 0 or 1, Size = Toggle.Value and UDim2.new(0, 20, 0, 20) or UDim2.new(0, 8, 0, 8) }):Play() ToggleConfig.Callback(Toggle.Value) end Toggle:Set(Toggle.Value) AddConnection(Click.MouseButton1Up, function() TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3) }):Play() SaveCfg(game.GameId) Toggle:Set(not Toggle.Value) end) if ToggleConfig.Flag then OrionLib.Flags[ToggleConfig.Flag] = Toggle end return Toggle end
                function ElementFunction:AddSlider(SliderConfig) SliderConfig = SliderConfig or {} SliderConfig.Name = SliderConfig.Name or "Slider" SliderConfig.Min = SliderConfig.Min or 0 SliderConfig.Max = SliderConfig.Max or 100 SliderConfig.Increment = SliderConfig.Increment or 1 SliderConfig.Default = SliderConfig.Default or 50 SliderConfig.Callback = SliderConfig.Callback or function() end SliderConfig.ValueName = SliderConfig.ValueName or "" SliderConfig.Color = SliderConfig.Color or Color3.fromRGB(9, 149, 98) SliderConfig.Flag = SliderConfig.Flag or nil SliderConfig.Save = SliderConfig.Save or false local Slider = { Value = SliderConfig.Default, Save = SliderConfig.Save } local Dragging = false local SliderDrag = SetChildren(SetProps(MakeElement("RoundFrame", SliderConfig.Color, 0, 5), { Size = UDim2.new(0, 0, 1, 0), BackgroundTransparency = 0.3, ClipsDescendants = true }), { AddThemeObject(SetProps(MakeElement("Label", "value", 13), { Size = UDim2.new(1, -12, 0, 14), Position = UDim2.new(0, 12, 0, 6), Font = Enum.Font.GothamBold, Name = "Value", TextTransparency = 0 }), "Text") }) local SliderBar = SetChildren(SetProps(MakeElement("RoundFrame", SliderConfig.Color, 0, 5), { Size = UDim2.new(1, -24, 0, 26), Position = UDim2.new(0, 12, 0, 30), BackgroundTransparency = 0.9 }), { SetProps(MakeElement("Stroke"), { Color = SliderConfig.Color }), AddThemeObject(SetProps(MakeElement("Label", "value", 13), { Size = UDim2.new(1, -12, 0, 14), Position = UDim2.new(0, 12, 0, 6), Font = Enum.Font.GothamBold, Name = "Value", TextTransparency = 0.8 }), "Text"), SliderDrag }) local SliderFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), { Size = UDim2.new(1, 0, 0, 65), Parent = ItemParent }), { AddThemeObject(SetProps(MakeElement("Label", SliderConfig.Name, 15), { Size = UDim2.new(1, -12, 0, 14), Position = UDim2.new(0, 12, 0, 10), Font = Enum.Font.GothamBold, Name = "Content" }), "Text"), AddThemeObject(MakeElement("Stroke"), "Stroke"), SliderBar }), "Second") SliderBar.InputBegan:Connect(function(Input) if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then Dragging = true local SizeScale = math.clamp((Input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1) Slider:Set(SliderConfig.Min + ((SliderConfig.Max - SliderConfig.Min) * SizeScale)) SaveCfg(game.GameId) end end) SliderBar.InputEnded:Connect(function(Input) if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then Dragging = false end end) UserInputService.InputChanged:Connect(function(Input) if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then local SizeScale = math.clamp((Input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1) Slider:Set(SliderConfig.Min + ((SliderConfig.Max - SliderConfig.Min) * SizeScale)) SaveCfg(game.GameId) end end) function Slider:Set(Value) self.Value = math.clamp(Round(Value, SliderConfig.Increment), SliderConfig.Min, SliderConfig.Max) TweenService:Create(SliderDrag, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = UDim2.fromScale((self.Value - SliderConfig.Min) / (SliderConfig.Max - SliderConfig.Min), 1) }):Play() SliderBar.Value.Text = tostring(self.Value) .. " " .. SliderConfig.ValueName SliderDrag.Value.Text = tostring(self.Value) .. " " .. SliderConfig.ValueName SliderConfig.Callback(self.Value) end Slider:Set(Slider.Value) if SliderConfig.Flag then OrionLib.Flags[SliderConfig.Flag] = Slider end return Slider end
                function ElementFunction:AddTextbox(TextboxConfig) TextboxConfig = TextboxConfig or {} TextboxConfig.Name = TextboxConfig.Name or "Textbox" TextboxConfig.Default = TextboxConfig.Default or "" TextboxConfig.TextDisappear = TextboxConfig.TextDisappear or false TextboxConfig.Callback = TextboxConfig.Callback or function() end local Click = SetProps(MakeElement("Button"), { Size = UDim2.new(1, 0, 1, 0) }) local TextboxActual = AddThemeObject(Create("TextBox", { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), PlaceholderColor3 = Color3.fromRGB(210, 210, 210), PlaceholderText = "点击输入", Font = Enum.Font.GothamSemibold, TextXAlignment = Enum.TextXAlignment.Center, TextSize = 14, ClearTextOnFocus = false }), "Text") local TextContainer = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), { Size = UDim2.new(0, 24, 0, 24), Position = UDim2.new(1, -12, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5) }), { AddThemeObject(MakeElement("Stroke"), "Stroke"), TextboxActual }), "Main") local TextboxFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), { Size = UDim2.new(1, 0, 0, 38), Parent = ItemParent }), { AddThemeObject(SetProps(MakeElement("Label", TextboxConfig.Name, 15), { Size = UDim2.new(1, -12, 1, 0), Position = UDim2.new(0, 12, 0, 0), Font = Enum.Font.GothamBold, Name = "Content" }), "Text"), AddThemeObject(MakeElement("Stroke"), "Stroke"), TextContainer, Click }), "Second") AddConnection(TextboxActual:GetPropertyChangedSignal("Text"), function() TweenService:Create(TextContainer, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(0, TextboxActual.TextBounds.X + 16, 0, 24) }):Play() end) AddConnection(TextboxActual.FocusLost, function() TextboxConfig.Callback(TextboxActual.Text) if TextboxConfig.TextDisappear then TextboxActual.Text = "" end end) TextboxActual.Text = TextboxConfig.Default AddConnection(Click.MouseButton1Up, function() TextboxActual:CaptureFocus() end) end
                function ElementFunction:AddDropdown(DropdownConfig) DropdownConfig = DropdownConfig or {} DropdownConfig.Name = DropdownConfig.Name or "Dropdown" DropdownConfig.Options = DropdownConfig.Options or {} DropdownConfig.Default = DropdownConfig.Default or "" DropdownConfig.Callback = DropdownConfig.Callback or function() end local Dropdown = { Value = DropdownConfig.Default, Options = DropdownConfig.Options, Buttons = {}, Toggled = false, Type = "Dropdown", Save = DropdownConfig.Save } local MaxElements = 5 if not table.find(Dropdown.Options, Dropdown.Value) then Dropdown.Value = "..." end local DropdownList = MakeElement("List") local DropdownContainer = AddThemeObject(SetProps(SetChildren(MakeElement("ScrollFrame", Color3.fromRGB(40, 40, 40), 4), { DropdownList }), { Parent = ItemParent, Position = UDim2.new(0, 0, 0, 38), Size = UDim2.new(1, 0, 1, -38), ClipsDescendants = true }), "Divider") local Click = SetProps(MakeElement("Button"), { Size = UDim2.new(1, 0, 1, 0) }) local DropdownFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), { Size = UDim2.new(1, 0, 0, 38), Parent = ItemParent, ClipsDescendants = true }), { DropdownContainer, SetProps(SetChildren(MakeElement("TFrame"), { AddThemeObject(SetProps(MakeElement("Label", DropdownConfig.Name, 15), { Size = UDim2.new(1, -12, 1, 0), Position = UDim2.new(0, 12, 0, 0), Font = Enum.Font.GothamBold, Name = "Content" }), "Text"), AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072706796"), { Size = UDim2.new(0, 20, 0, 20), AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(1, -30, 0.5, 0), ImageColor3 = Color3.fromRGB(240, 240, 240), Name = "Ico" }), "TextDark"), AddThemeObject(SetProps(MakeElement("Label", "Selected", 13), { Size = UDim2.new(1, -40, 1, 0), Font = Enum.Font.Gotham, Name = "Selected", TextXAlignment = Enum.TextXAlignment.Right }), "TextDark"), AddThemeObject(SetProps(MakeElement("Frame"), { Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 1, -1), Name = "Line", Visible = false }), "Stroke"), Click }), { Size = UDim2.new(1, 0, 0, 38), ClipsDescendants = true, Name = "F" }), AddThemeObject(MakeElement("Stroke"), "Stroke"), MakeElement("Corner") }), "Second") AddConnection(DropdownList:GetPropertyChangedSignal("AbsoluteContentSize"), function() DropdownContainer.CanvasSize = UDim2.new(0, 0, 0, DropdownList.AbsoluteContentSize.Y) end) local function AddOptions(Options) for _, Option in pairs(Options) do local OptionBtn = AddThemeObject(SetProps(SetChildren(MakeElement("Button", Color3.fromRGB(40, 40, 40)), { MakeElement("Corner", 0, 6), AddThemeObject(SetProps(MakeElement("Label", Option, 13, 0.4), { Position = UDim2.new(0, 8, 0, 0), Size = UDim2.new(1, -8, 1, 0), Name = "Title" }), "Text") }), { Parent = DropdownContainer, Size = UDim2.new(1, 0, 0, 28), BackgroundTransparency = 1, ClipsDescendants = true }), "Divider") AddConnection(OptionBtn.MouseButton1Click, function() Dropdown:Set(Option) SaveCfg(game.GameId) end) Dropdown.Buttons[Option] = OptionBtn end end function Dropdown:Refresh(Options, Delete) if Delete then for _, v in pairs(Dropdown.Buttons) do v:Destroy() end table.clear(Dropdown.Options) table.clear(Dropdown.Buttons) end Dropdown.Options = Options AddOptions(Dropdown.Options) end function Dropdown:Set(Value) if not table.find(Dropdown.Options, Value) then Dropdown.Value = "..." DropdownFrame.F.Selected.Text = Dropdown.Value for _, v in pairs(Dropdown.Buttons) do TweenService:Create(v, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play() TweenService:Create(v.Title, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { TextTransparency = 0.4 }):Play() end return end Dropdown.Value = Value DropdownFrame.F.Selected.Text = Dropdown.Value for _, v in pairs(Dropdown.Buttons) do TweenService:Create(v, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play() TweenService:Create(v.Title, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { TextTransparency = 0.4 }):Play() end TweenService:Create(Dropdown.Buttons[Value], TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 0 }):Play() TweenService:Create(Dropdown.Buttons[Value].Title, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play() return DropdownConfig.Callback(Dropdown.Value) end AddConnection(Click.MouseButton1Click, function() Dropdown.Toggled = not Dropdown.Toggled DropdownFrame.F.Line.Visible = Dropdown.Toggled TweenService:Create(DropdownFrame.F.Ico, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Rotation = Dropdown.Toggled and 180 or 0 }):Play() if #Dropdown.Options > MaxElements then TweenService:Create(DropdownFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = Dropdown.Toggled and UDim2.new(1, 0, 0, 38 + (MaxElements * 28)) or UDim2.new(1, 0, 0, 38) }):Play() else TweenService:Create(DropdownFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = Dropdown.Toggled and UDim2.new(1, 0, 0, DropdownList.AbsoluteContentSize.Y + 38) or UDim2.new(1, 0, 0, 38) }):Play() end end) Dropdown:Refresh(Dropdown.Options, false) Dropdown:Set(Dropdown.Value) if DropdownConfig.Flag then OrionLib.Flags[DropdownConfig.Flag] = Dropdown end return Dropdown end
                return ElementFunction
            end
            local ElementFunction = {}
            function ElementFunction:AddSection(SectionConfig) SectionConfig.Name = SectionConfig.Name or "Section" local SectionFrame = SetChildren(SetProps(MakeElement("TFrame"), { Size = UDim2.new(1, 0, 0, 26), Parent = Container }), { AddThemeObject(SetProps(MakeElement("Label", SectionConfig.Name, 14), { Size = UDim2.new(1, -12, 0, 16), Position = UDim2.new(0, 0, 0, 3), Font = Enum.Font.GothamSemibold }), "TextDark"), SetChildren(SetProps(MakeElement("TFrame"), { AnchorPoint = Vector2.new(0, 0), Size = UDim2.new(1, 0, 1, -24), Position = UDim2.new(0, 0, 0, 23), Name = "Holder" }), { MakeElement("List", 0, 6) }) }) AddConnection(SectionFrame.Holder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function() SectionFrame.Size = UDim2.new(1, 0, 0, SectionFrame.Holder.UIListLayout.AbsoluteContentSize.Y + 31) SectionFrame.Holder.Size = UDim2.new(1, 0, 0, SectionFrame.Holder.UIListLayout.AbsoluteContentSize.Y) end) local SectionFunction = {} for i, v in next, GetElements(SectionFrame.Holder) do SectionFunction[i] = v end return SectionFunction end
            for i, v in next, GetElements(Container) do ElementFunction[i] = v end
            if TabConfig.PremiumOnly then for i, v in next, ElementFunction do ElementFunction[i] = function() end end Container:FindFirstChild("UIListLayout"):Destroy() Container:FindFirstChild("UIPadding"):Destroy() end
            return ElementFunction
        end
        return TabFunction
    end
    function OrionLib:Destroy() Orion:Destroy() end
    return OrionLib
end)()

return OrionLib