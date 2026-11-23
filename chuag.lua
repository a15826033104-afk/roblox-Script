--[[
================================================================
 窗脚本 v4.2.0 · 主线（FluentPlus 底座）
----------------------------------------------------------------
 底座      FluentPlus  Beta.lua（discoart/FluentPlus，明文 11,095 行）
           启动时读缓存 ChickenBeachChickenTech_Data/fp_cache.luau，
           缓存校验（ResizeStartSize / 300,2048 / 确定要关闭界面吗？）
           三项不全则从官方 raw + gh-proxy + ghfast 三镜像重下并打补丁。
 库补丁    10 处（纯文本，各命中 1 次）
           1-5  右下角缩放手柄 36×36、ResizeStartSize 去滚雪球、
                下限 300×240、InputEnded 不再误触重置
           6    取色器弹窗按 ViewportSize 夹紧
           7-10 关闭弹窗汉化（确定要关闭界面吗？/ 关闭 / 是 / 否）
 适配层    Window:Tab → AddTab；wrapTab 把 Toggle/Slider/Dropdown/Input/
           Button/Paragraph/Section 映射到 Add*，130 个控件零改动
 本版新增  滑块创建修复（库要求 Rounding，缺失即断言失败，24 个滑块全挂）
           标题栏两排（14px 粗标题 + 11px 淡署名），按结构重排而非字符串补丁
           标题栏去图标、搜索框占位汉化为「搜索…」
 保留      v3.0.7 的四项工程收益：fitWindow 手机适配、ui_cfg 尺寸记忆、
           主题体系、速度守护；自有胶囊（Corner=UDim.new(1,0)）
 自托管    FP_PRIMARY 填自己仓库里 UI.lua 的 raw 链接即可（优先于镜像，
           已是补丁版的源不会重复打补丁）；留空则走官方镜像。
 上一版    主线 v3.0.7（Fluent Renewed 底座）→ 已移至 分支/ 存档
================================================================
]]

-- 探针 ①：注入后控制台应打印这一行。看不到 = 脚本根本没执行（多半是编译/加载失败）
pcall(function()
	warn("[窗] v4.2.0 开始执行")
end)

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LP = Players.LocalPlayer

--============================ UI 配置记忆（只记 UI：尺寸 / 位置 / 主题） ============================--

local UI_DIR = "ChickenBeachChickenTech_Data"
local UI_CFG_PATH = UI_DIR .. "/ui_cfg.txt"
local THEME_PATH = UI_DIR .. "/theme.txt"

local UICfg = {}
local BOOT_DARK = false
local BOOT_THEME = "Light"

-- 浅色系主题（用来决定启动卡底色、胶囊配色）
local LIGHT_THEMES = {
	["Light"] = true,
	["Quiet Light"] = true,
	["Yaru"] = true,
	["Solarized Light"] = true,
	["Balloon"] = true,
	["SoftCream"] = true,
	["Cloud"] = true,
}

-- 老记忆里存的 Renewed 主题名，换成 FluentPlus 里最接近的一套
local FP_THEME_ALIAS = {
	["Quiet Light"] = "Light",
	["Yaru"] = "SoftCream",
	["Solarized Light"] = "Light",
	["Abyss"] = "Midnight",
	["Arc Dark"] = "Dark",
	["Tomorrow Night Blue"] = "Ocean",
	["Monokai"] = "Dark",
	["Amethyst Dark"] = "Amethyst",
}

local function cfgNumber(v)
	local n = tonumber(v)
	return n and math.floor(n) or nil
end

pcall(function()
	if type(isfile) == "function" and type(readfile) == "function" then
		if isfile(UI_CFG_PATH) then
			for k, v in string.gmatch(readfile(UI_CFG_PATH), "([%w_]+)%s*=%s*([%-%d%.]+)") do
				UICfg[k] = cfgNumber(v)
			end
		end
		if isfile(THEME_PATH) then
			local t = readfile(THEME_PATH)
			if type(t) == "string" then
				local name = t:match("^%s*(.-)%s*$")
				if name == "light" then
					name = "Light"
				elseif name == "dark" then
					name = "Dark"
				end
				if name ~= "" then
					BOOT_THEME = name
					BOOT_DARK = not LIGHT_THEMES[name]
				end
			end
		end
	end
end)

local function saveUICfg()
	pcall(function()
		if type(writefile) ~= "function" then
			return
		end
		if type(isfolder) == "function" and type(makefolder) == "function" and not isfolder(UI_DIR) then
			makefolder(UI_DIR)
		end
		local parts = {}
		for k, v in pairs(UICfg) do
			if type(v) == "number" then
				parts[#parts + 1] = string.format("%s=%d", k, math.floor(v))
			end
		end
		table.sort(parts)
		writefile(UI_CFG_PATH, table.concat(parts, ","))
	end)
end

-- 用户拖右下角改过大小就记下来；只认 UI 尺寸，别的都不落盘
local function rememberSize(w, h)
	w, h = math.floor(w or 0), math.floor(h or 0)
	if w < 200 or h < 150 then
		return
	end
	if math.abs((UICfg.w or 0) - w) <= 1 and math.abs((UICfg.h or 0) - h) <= 1 then
		return
	end
	UICfg.w, UICfg.h = w, h
	saveUICfg()
end

--============================ ⓪ 原生提示框（不依赖 Fluent） ============================--

local bootStart = os.clock()
local BootPanel = {done = false}

-- 探针 ②：执行到这里说明前面的配置读取全过了，接下来建启动卡
pcall(function()
	warn("[窗] 进入启动卡")
end)

do
	local parent = LP:FindFirstChild("PlayerGui")
	if not parent then
		pcall(function()
			parent = LP:WaitForChild("PlayerGui", 5)
		end)
	end
	if not parent then
		pcall(function()
			parent = game:GetService("CoreGui")
		end)
	end

	local gui = Instance.new("ScreenGui")
	gui.Name = "ChuangBoot"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.DisplayOrder = 99999999
	pcall(function()
		gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	end)
	BootPanel.Gui = gui

	local vp0 = (workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize) or Vector2.new(1280, 720)
	local cardW = math.clamp(math.floor(vp0.X * 0.64), 236, 392)
	local cardH = math.clamp(math.floor(cardW * 0.40), 88, 122)

	local CARD_BG = BOOT_DARK and Color3.fromRGB(26, 27, 33) or Color3.fromRGB(250, 250, 252)
	local CARD_STROKE = BOOT_DARK and Color3.fromRGB(60, 64, 78) or Color3.fromRGB(206, 210, 222)
	local CARD_TITLE = BOOT_DARK and Color3.fromRGB(242, 243, 248) or Color3.fromRGB(26, 27, 33)
	local CARD_SUB = BOOT_DARK and Color3.fromRGB(150, 156, 172) or Color3.fromRGB(110, 116, 132)
	local CARD_TRACK = BOOT_DARK and Color3.fromRGB(44, 46, 56) or Color3.fromRGB(226, 229, 238)

	local card = Instance.new("Frame")
	card.Name = "Card"
	card.AnchorPoint = Vector2.new(0.5, 0.5)
	card.Position = UDim2.fromScale(0.5, 0.42)
	card.Size = UDim2.fromOffset(cardW, cardH)
	card.BackgroundColor3 = CARD_BG
	card.BorderSizePixel = 0
	card.Parent = gui

	local cardCorner = Instance.new("UICorner")
	cardCorner.CornerRadius = UDim.new(0, 14)
	cardCorner.Parent = card

	local cardStroke = Instance.new("UIStroke")
	cardStroke.Thickness = 1
	cardStroke.Color = CARD_STROKE
	cardStroke.Transparency = 0.4
	cardStroke.Parent = card

	local dot = Instance.new("Frame")
	dot.Name = "Dot"
	dot.Size = UDim2.fromOffset(8, 8)
	dot.Position = UDim2.fromOffset(16, 18)
	dot.BackgroundColor3 = Color3.fromRGB(76, 194, 255)
	dot.BorderSizePixel = 0
	dot.Parent = card
	local dotCorner = Instance.new("UICorner")
	dotCorner.CornerRadius = UDim.new(1, 0)
	dotCorner.Parent = dot

	local title = Instance.new("TextLabel")
	title.Name = "Title"
	title.Size = UDim2.new(1, -40, 0, 18)
	title.Position = UDim2.fromOffset(30, 14)
	title.BackgroundTransparency = 1
	title.Text = "制作脚本(窗)"
	title.TextColor3 = CARD_TITLE
	title.TextSize = 15
	title.Font = Enum.Font.GothamBold
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = card

	local status = Instance.new("TextLabel")
	status.Name = "Status"
	status.Size = UDim2.new(1, -32, 0, 16)
	status.Position = UDim2.fromOffset(16, 36)
	status.BackgroundTransparency = 1
	status.Text = "正在启动"
	status.TextColor3 = CARD_SUB
	status.TextSize = 12
	status.Font = Enum.Font.Gotham
	status.TextXAlignment = Enum.TextXAlignment.Left
	status.Parent = card

	local track = Instance.new("Frame")
	track.Name = "Track"
	track.Size = UDim2.new(1, -32, 0, 4)
	track.Position = UDim2.new(0, 16, 1, -26)
	track.BackgroundColor3 = CARD_TRACK
	track.BorderSizePixel = 0
	track.Parent = card
	local trackCorner = Instance.new("UICorner")
	trackCorner.CornerRadius = UDim.new(1, 0)
	trackCorner.Parent = track

	local fill = Instance.new("Frame")
	fill.Name = "Fill"
	fill.Size = UDim2.new(0.05, 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(76, 194, 255)
	fill.BorderSizePixel = 0
	fill.Parent = track
	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(1, 0)
	fillCorner.Parent = fill

	local baseText = "正在启动"

	function BootPanel.Set(text, pct)
		baseText = tostring(text or "")
		status.Text = baseText
		if pct then
			fill.Size = UDim2.new(math.clamp(pct, 0, 1), 0, 1, 0)
		end
	end

	function BootPanel.Finish()
		if BootPanel.done then
			return
		end
		BootPanel.done = true
		status.Text = "界面就绪"
		fill.Size = UDim2.new(1, 0, 1, 0)
		task.delay(0.25, function()
			pcall(function()
				gui:Destroy()
			end)
		end)
	end

	task.spawn(function()
		local n = 0
		while gui.Parent and not BootPanel.done do
			n = (n + 1) % 4
			status.Text = baseText .. string.rep("·", n)
			task.wait(0.3)
		end
	end)

	pcall(function()
		gui.Parent = parent
	end)
end

task.delay(8, function()
	if not BootPanel.done then
		pcall(function()
			BootPanel.Set("仍在加载，网络可能较慢…", 0.55)
		end)
	end
end)

--============================ ① 加载 FluentPlus（分支 v4.1） ============================--
-- 分支策略：库固定在本地缓存里，下载只发生一次；补丁命中不足就报警。
-- 主线仍用 Fluent Renewed，这个文件只用于三页迁移验证。

local FP_DIR = "ChickenBeachChickenTech_Data"
local FP_CACHE = FP_DIR .. "/fp_cache.luau"
local FP_PIN = {
	Tag = "Beta@2026-11-22",
	Bytes = 289640,
	Marker = "FluentPlus",
}

-- 自托管优先：把已打好 10 处补丁的 UI.lua 放进你自己的仓库，
-- 这里填 raw 链接即可彻底摆脱上游文案变动（留空则只用下面的官方镜像）
local FP_PRIMARY = ""

local FP_MIRRORS = {
	"https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/Beta.lua",
	"https://gh-proxy.com/https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/Beta.lua",
	"https://ghfast.top/https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/Beta.lua",
}

local FP_SOURCES = {}
if FP_PRIMARY ~= "" then
	table.insert(FP_SOURCES, FP_PRIMARY)
end
for _, u in ipairs(FP_MIRRORS) do
	table.insert(FP_SOURCES, u)
end

if type(isfolder) == "function" and type(makefolder) == "function" then
	pcall(function()
		if not isfolder(FP_DIR) then
			makefolder(FP_DIR)
		end
	end)
end

-- 10 处：缩放 5 项 + 取色器弹窗尺寸 + 关闭弹窗汉化 4 句
local function fpPatch(src)
	local hits = 0

	local function sub(a, b)
		local i = string.find(src, a, 1, true)
		if i then
			src = string.sub(src, 1, i - 1) .. b .. string.sub(src, i + #a)
			hits = hits + 1
		end
	end

	sub("local Resizing, ResizePos = false", "local Resizing, ResizePos, ResizeStartSize = false, nil, nil")
	sub(
		"\t\t\t\tResizing = true\n\t\t\t\tResizePos = Input.Position",
		"\t\t\t\tResizing = true\n\t\t\t\tResizePos = Input.Position\n\t\t\t\tResizeStartSize = Window.Size"
	)
	sub("local StartSize = Window.Size", "local StartSize = ResizeStartSize or Window.Size")
	sub(
		"math.clamp(TargetSize.X, 470, 2048), math.clamp(TargetSize.Y, 380, 2048)",
		"math.clamp(TargetSize.X, 300, 2048), math.clamp(TargetSize.Y, 240, 2048)"
	)
	sub("if Resizing == true or Input.UserInputType == Enum.UserInputType.Touch then", "if Resizing == true then")
	sub(
		"Dialog.Root.Size = UDim2.fromOffset(430, 330)",
		"local _vp = Camera.ViewportSize\n\t\t\t\tlocal _dw = math.min(430, _vp.X - 16)\n\t\t\t\tlocal _dh = math.min(330, _vp.Y - 110)\n\t\t\t\tDialog.Root.Size = UDim2.fromOffset(_dw, _dh)\n\t\t\t\tif _dw < 430 or _dh < 330 then\n\t\t\t\t\tlocal _sc = Instance.new(\"UIScale\")\n\t\t\t\t\t_sc.Scale = math.min(_dw / 430, _dh / 330)\n\t\t\t\t\t_sc.Parent = Dialog.Root\n\t\t\t\tend"
	)

	-- 7) 右上角叉的确认弹窗：默认是英文 Close / Are you sure... / Yes / No
	sub("Are you sure you want to unload the interface?", "确定要关闭界面吗？")
	sub("Title = \"Close\"", "Title = \"关闭\"")
	sub("Title = \"Yes\"", "Title = \"是\"")
	sub("Title = \"No\"", "Title = \"否\"")

	return src, hits
end

local function fpCacheOk(src)
	if type(src) ~= "string" or #src < 200000 then
		return false
	end
	if not string.find(src, "ResizeStartSize", 1, true) then
		return false
	end
	if not string.find(src, "math.clamp(TargetSize.X, 300, 2048)", 1, true) then
		return false
	end
	if not string.find(src, "确定要关闭界面吗？", 1, true) then
		return false
	end
	return true
end

local Fluent
local fpFrom

-- 1) 先吃缓存（补丁已打进去，不再依赖上游变不变）
if type(isfile) == "function" and type(readfile) == "function" then
	local ok, cached = pcall(function()
		if isfile(FP_CACHE) then
			return readfile(FP_CACHE)
		end
	end)
	if ok and fpCacheOk(cached) then
		local ok2, lib = pcall(function()
			return loadstring(cached)()
		end)
		if ok2 and lib then
			Fluent = lib
			fpFrom = "本地缓存"
		end
	end
end

-- 2) 缓存不可用才下载
if not Fluent then
	local log = {}
	for _, url in ipairs(FP_SOURCES) do
		local ok, body = pcall(function()
			return game:HttpGet(url, true)
		end)
		if ok and type(body) == "string" and #body > 200000 then
			-- 源文件如果本来就是补丁版（自托管的情况），不再重复打补丁
			local patched, hits = body, 10
			if not fpCacheOk(body) then
				patched, hits = fpPatch(body)
			end
			if hits < 10 then
				log[#log + 1] = "补丁命中 " .. tostring(hits) .. "/6"
			end
			if fpCacheOk(patched) then
				local ok2, lib = pcall(function()
					return loadstring(patched)()
				end)
				if ok2 and lib then
					Fluent = lib
					fpFrom = url:match("^https?://([^/]+)") or "镜像"
					pcall(function()
						if type(writefile) == "function" then
							writefile(FP_CACHE, patched)
						end
					end)
					break
				end
				log[#log + 1] = "loadstring 失败"
			else
				log[#log + 1] = "补丁后校验失败"
			end
		else
			log[#log + 1] = "取不到 " .. (url:match("^https?://([^/]+)") or url)
		end
	end
	if not Fluent then
		error("FluentPlus 加载失败：" .. table.concat(log, "；"), 0)
	end
end

pcall(function()
	BootPanel.Set("FluentPlus 已就绪", 0.32)
end)

print("[分支] FluentPlus 加载成功 ← " .. tostring(fpFrom))

--============================ ①-2 启动清理（1 秒内完成） ============================--

local cleanupStart = os.clock()

pcall(function()
	BootPanel.Set("清理上一轮残留", 0.4)
end)

do
	local CoreGui = game:GetService("CoreGui")
	local PlayerGui = LP:WaitForChild("PlayerGui")

	-- 1) 掐掉上一轮留下的线程
	local oldThreads = getgenv().ChuangThreads
	if type(oldThreads) == "table" then
		for i = #oldThreads, 1, -1 do
			pcall(task.cancel, oldThreads[i])
			oldThreads[i] = nil
		end
	end

	-- 2) 把上一轮还在跑的循环全部按掉
	local oldState = getgenv().ChuangState
	if type(oldState) == "table" then
		for k, v in pairs(oldState) do
			if type(v) == "boolean" then
				oldState[k] = false
			end
		end
	end
	local oldApi = getgenv().Chuang
	if type(oldApi) == "table" then
		pcall(function()
			oldApi.Shutdown()
		end)
	end

	-- 3) 清掉上一轮的界面残留
	for _, parent in ipairs({CoreGui, PlayerGui}) do
		for _, obj in ipairs(parent:GetChildren()) do
			if
				obj:IsA("ScreenGui")
				and obj ~= BootPanel.Gui
				and (
					obj.Name:find("Fluent", 1, true)
					or obj.Name:find("Chuang", 1, true)
					or obj.Name:find("窗", 1, true)
				)
			then
				obj:Destroy()
			end
		end
	end
	pcall(function()
		local Lighting = game:GetService("Lighting")
		local blur = Lighting:FindFirstChild("ChuangAcrylicBlur")
		if blur then
			blur:Destroy()
		end
	end)
	pcall(function()
	end)

	-- 4) 清掉角色身上自己注入的东西
	local ch = LP.Character
	if ch then
		for _, d in ipairs(ch:GetDescendants()) do
			if
				(d.Name == "ChuangTrail" and d:IsA("Trail"))
				or d.Name == "ChuangFlyAtt"
				or d.Name == "ChuangFlyVel"
				or d.Name == "ChuangFlyOrient"
				or d.Name == "ChuangFlyForce"
				or d.Name == "EpixVel"
			then
				pcall(function()
					d:Destroy()
				end)
			end
		end
	end

	-- 5) 回收内存
	pcall(function()
		collectgarbage()
		collectgarbage()
	end)

	-- 6) 重置角色：先把穿墙留下的无碰撞、速度全复原，再触发重生
	-- 之前直接 Health = 0，角色变成 ragdoll 后因为 CanCollide 全是 false，直接掉进虚空
	if ch then
		local hum = ch:FindFirstChildOfClass("Humanoid")

		for _, part in ipairs(ch:GetDescendants()) do
			if part:IsA("BasePart") then
				if part.Name ~= "HumanoidRootPart" then
					pcall(function()
						part.CanCollide = true
					end)
				end
				pcall(function()
					part.AssemblyLinearVelocity = Vector3.zero
					part.AssemblyAngularVelocity = Vector3.zero
				end)
			end
		end

		pcall(function()
			for _, obj in ipairs(ch:GetChildren()) do
				if
					obj:IsA("BodyVelocity")
					or obj:IsA("BodyGyro")
					or obj:IsA("LinearVelocity")
					or obj:IsA("AlignOrientation")
					or obj:IsA("VectorForce")
				then
					obj:Destroy()
				end
			end
		end)

		if hum then
			pcall(function()
				hum.WalkSpeed = getgenv().ChuangBaseSpeed or hum.WalkSpeed
				if hum.Health > 0 then
					hum.Health = hum.MaxHealth
				end
			end)
		end

		task.delay(0.35, function()
			pcall(function()
				if LP.Character ~= ch then
					return
				end
				local h = ch:FindFirstChildOfClass("Humanoid")
				if not h then
					return
				end
				-- 碰撞已复原，这时候死亡才是正常 ragdoll，不会掉进虚空
				h.Health = 0
				task.wait(0.15)
				if h.Parent and h.Health > 0 then
					ch:BreakJoints()
				end
			end)
		end)
	end
end

if os.clock() - cleanupStart > 1 then
	warn(string.format("[窗] 启动清理耗时 %.2fs（超过 1 秒）", os.clock() - cleanupStart))
else
	BootPanel.Set("清理完成，正在建界面", 0.55)
	print(string.format("[窗] 启动清理完成 %.3fs", os.clock() - cleanupStart))
end

--============================ ② 手机端补丁 ============================--

local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

-- 线程登记：下次重载时可一次性清掉上一轮所有循环
local trackedThreads = {}
getgenv().ChuangThreads = trackedThreads

local function spawnTracked(fn)
	local thread
	thread = task.spawn(function()
		local self = coroutine.running()
		table.insert(trackedThreads, self)
		fn()
	end)
	return thread
end

local Patch = {}
Patch.Version = "4.2.0"
Patch.Config = {
	PillText = "打开界面",
	PillWidth = 196,
	PillHeight = 46,
	PillTopMargin = 6,
	PillStyle = "light",
	PillDraggable = true,
	KeepWindowPos = true,
	HideOriginalButton = true,
	PillReact = true,        -- 划过胶囊周围会弹动
	PillReactRange = 96,     -- 周围感应范围（额外像素）
	ButtonPress = true,
	ScrollBarThickness = 6,
	KeyboardAvoid = true,
	PillBreathe = true,
	PillSpring = true,
	TranslateThrottle = 2,
	-- 原生外观：开=完全不碰几何与字号（圆角/滚动条/标题栏两排/搜索图标位置全跳过），
	-- 用于随时验证「我们没把设计焊死」。改完重开界面生效。
	NativeLook = (tonumber(UICfg.native) or 0) == 1,
	-- 窗口外柔光阴影（2.9 的设计，FluentPlus 原生没有），默认开
	WindowShadow = (tonumber(UICfg.winshadow) or 1) == 1,
	-- 极限模式：抹掉窗口/胶囊阴影 + 停掉胶囊全部循环补间，最省帧
	Lite = (tonumber(UICfg.lite) or 0) == 1,
}

-- 极限模式存过盘就开机直接生效，不然要等用户再点一次开关
if Patch.Config.Lite then
	Patch.Config.PillBreathe = false
	Patch.Config.PillSpring = false
end

local attached = {}
local lastWindow
local pillApis = {}
local pillShadowOf = setmetatable({}, {__mode = "k"})

--============================ 小工具 ============================--

local function viewport()
	local cam = workspace.CurrentCamera
	return cam and cam.ViewportSize or Vector2.new(1280, 720)
end

local function getTopInset()
	local inset = 0
	pcall(function()
		inset = GuiService:GetGuiInset().Y
	end)
	return inset
end

local function isMobile()
	if UIS.TouchEnabled then
		return true
	end
	local vp = viewport()
	return vp.X <= 900 and vp.Y <= 600
end

local function notifyState(text)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = "界面",
			Text = text,
			Duration = 2,
		})
	end)
end

local avatarCache

local function getAvatar()
	if avatarCache then
		return avatarCache
	end
	local ok, url = pcall(function()
		return Players:GetUserThumbnailAsync(LP.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
	end)
	if ok then
		avatarCache = url
		return url
	end
	return nil
end

--============================ 动画系统 ============================--

local function ensureUIScale(frame)
	local s = frame:FindFirstChildOfClass("UIScale")
	if not s then
		s = Instance.new("UIScale")
		s.Scale = 1
		s.Parent = frame
	end
	return s
end

local function tween(inst, props, dur, style, dir, repeats, reverses)
	if not inst then
		return nil
	end
	local info = TweenInfo.new(
		dur or 0.25,
		style or Enum.EasingStyle.Quad,
		dir or Enum.EasingDirection.Out,
		repeats or 0,
		reverses or false
	)
	local t = TweenService:Create(inst, info, props)
	t:Play()
	return t
end

-- 胶囊底色透明度（浅色更实一点，避免后面影子透出来发黑）
local function pillBgTransparency()
	if Patch.Config.PillStyle == "light" then
		return 0.02
	end
	return 0.10
end

local breatheTweens = {}

local function stopBreathe(pill)
	local pack = breatheTweens[pill]
	if not pack then
		return
	end
	for _, t in ipairs(pack) do
		if t then
			pcall(function()
				t:Cancel()
			end)
		end
	end
	breatheTweens[pill] = nil
end

local function startBreathe(pill)
	if not (pill and pill.Parent) or not pill.Visible then
		return
	end
	stopBreathe(pill)

	if Patch.Config.PillBreathe == false then
		return
	end

	local info = TweenInfo.new(1.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
	local list = {}

	local stroke = pill:FindFirstChildOfClass("UIStroke")
	if stroke then
		stroke.Transparency = 0.28
		local t = TweenService:Create(stroke, info, {Transparency = 0.62})
		t:Play()
		list[#list + 1] = t
	end

	local shadow = pillShadowOf[pill]
	if shadow then
		local base = shadow:GetAttribute("BaseTransparency") or shadow.ImageTransparency
		local t = TweenService:Create(
			shadow,
			info,
			{ImageTransparency = math.clamp(base + 0.12, 0, 1)}
		)
		t:Play()
		list[#list + 1] = t
	end

	breatheTweens[pill] = list
end

local function animatePillHide(pill)
	if not pill or not pill.Parent then
		return
	end
	stopBreathe(pill)

	local scale = ensureUIScale(pill)
	pill.Visible = true
	tween(pill, {BackgroundTransparency = 1}, 0.16)
	tween(scale, {Scale = 0.86}, 0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

	for _, d in ipairs(pill:GetDescendants()) do
		if d:IsA("TextLabel") then
			tween(d, {TextTransparency = 1}, 0.14)
		elseif d:IsA("ImageLabel") then
			tween(d, {ImageTransparency = 1}, 0.14)
		end
	end

	local shadow = pillShadowOf[pill]
	if shadow then
		tween(shadow, {ImageTransparency = 1}, 0.15)
	end

	task.delay(0.17, function()
		if pill and pill.Parent then
			pill.Visible = false
			pill.BackgroundTransparency = 1
			pill.Rotation = 0
			scale.Scale = 1
			for _, d in ipairs(pill:GetDescendants()) do
				if d:IsA("TextLabel") then
					d.TextTransparency = 0
				elseif d:IsA("ImageLabel") then
					d.ImageTransparency = 0
				end
			end
			if shadow then
				local base = shadow:GetAttribute("BaseTransparency") or 0.8
				shadow.ImageTransparency = base
				shadow.Visible = false
			end
		end
	end)
end

local function animatePillShow(pill)
	if not pill or not pill.Parent then
		return
	end
	pill.Visible = true
	pill.BackgroundTransparency = 1

	local shadow = pillShadowOf[pill]
	if shadow then
		local api = pillApis[pill]
		shadow.Visible = true
		shadow.ImageTransparency = 1
		if api then
			api.apply()
		end
	end

	local scale = ensureUIScale(pill)
	scale.Scale = 0.62

	for _, d in ipairs(pill:GetDescendants()) do
		if d:IsA("TextLabel") then
			d.TextTransparency = 1
		end
		if d:IsA("ImageLabel") then
			d.ImageTransparency = 1
		end
	end

	tween(scale, {Scale = 1}, 0.42, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	tween(pill, {BackgroundTransparency = pillBgTransparency()}, 0.26, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	if shadow then
		local base = shadow:GetAttribute("BaseTransparency") or 0.8
		tween(shadow, {ImageTransparency = base}, 0.3)
	end

	for _, d in ipairs(pill:GetDescendants()) do
		if d:IsA("TextLabel") then
			tween(d, {TextTransparency = 0}, 0.26)
		elseif d:IsA("ImageLabel") then
			tween(d, {ImageTransparency = 0}, 0.26)
		end
	end

	task.delay(0.45, function()
		if pill and pill.Parent and pill.Visible then
			startBreathe(pill)
		end
	end)
end

local function windowPosGuard()
	Patch.PosGuard = (Patch.PosGuard or 0) + 1
	task.defer(function()
		Patch.PosGuard = math.max(0, (Patch.PosGuard or 1) - 1)
	end)
end

local function windowSetPos(window, x, y)
	if not window or not window.Root then
		return
	end
	windowPosGuard()
	window.Root.Position = UDim2.fromOffset(math.floor(x), math.floor(y))
	pcall(function()
		window.Position = window.Root.Position
	end)
end

local function rememberWindowPos(window, x, y)
	if not window or not window.Root then
		return
	end
	if Patch.Config.KeepWindowPos == false then
		return
	end
	Patch.WindowPos = { X = math.floor(x), Y = math.floor(y) }
end

local function animateWindowShow(window)
	if not window or not window.Root then
		return
	end
	local root = window.Root
	local scale = ensureUIScale(root)
	local target = root.Position
	scale.Scale = 0.86
	root.Visible = true
	window.Minimized = false
	root.Position = UDim2.fromOffset(target.X.Offset, target.Y.Offset + 16)

	windowPosGuard()
	task.delay(0.36, function()
		Patch.PosGuard = math.max(0, (Patch.PosGuard or 1) - 1)
	end)
	tween(scale, {Scale = 1}, 0.34, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	tween(root, {Position = target}, 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
end

local function animateWindowHide(window)
	if not window or not window.Root then
		return
	end
	local root = window.Root
	local scale = ensureUIScale(root)
	local target = root.Position

	windowPosGuard()
	task.delay(0.24, function()
		Patch.PosGuard = math.max(0, (Patch.PosGuard or 1) - 1)
	end)
	tween(scale, {Scale = 0.84}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	tween(root, {Position = UDim2.fromOffset(target.X.Offset, target.Y.Offset + 14)}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

	task.delay(0.21, function()
		if root and root.Parent then
			root.Visible = false
			root.Position = target
			window.Position = target
			window.Minimized = true
			scale.Scale = 1
		end
	end)
end

-- 通用按键按压反馈
local function addPressAnimations(container)
	if not container or not Patch.Config.ButtonPress then
		return
	end
	local function insideSlider(obj)
		local node = obj
		for _ = 1, 8 do
			node = node.Parent
			if not node then
				return false
			end
			local okAttr, flag = pcall(function()
				return node:GetAttribute("ChuangNoPress")
			end)
			if okAttr and flag then
				return true
			end
		end
		return false
	end

	for _, obj in ipairs(container:GetDescendants()) do
		if
			(obj:IsA("TextButton") or obj:IsA("ImageButton"))
			and not obj:GetAttribute("ChuangPress")
			and not insideSlider(obj)
			and (obj:FindFirstChildOfClass("TextLabel") ~= nil)
		then
			obj:SetAttribute("ChuangPress", true)
			local s = obj:FindFirstChildOfClass("UIScale")
			if not s then
				s = Instance.new("UIScale")
				s.Scale = 1
				s.Parent = obj
			end
			local baseScale = s.Scale

			obj.InputBegan:Connect(function(input)
				if
					Patch.Config.ButtonPress
					and obj.AbsoluteSize.Y >= 14
					and (
						input.UserInputType == Enum.UserInputType.MouseButton1
						or input.UserInputType == Enum.UserInputType.Touch
					)
				then
					tween(s, {Scale = baseScale * 0.94}, 0.11, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				end
			end)

			obj.InputEnded:Connect(function(input)
				if
					Patch.Config.ButtonPress
					and (
						input.UserInputType == Enum.UserInputType.MouseButton1
						or input.UserInputType == Enum.UserInputType.Touch
					)
				then
					tween(s, {Scale = baseScale}, 0.26, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
				end
			end)
		end
	end
end

--============================ 胶囊配色 ============================--

local function pillColors()
	if Patch.Config.PillStyle == "light" then
		return Color3.fromRGB(250, 250, 252), Color3.fromRGB(196, 199, 212), Color3.fromRGB(26, 26, 32)
	end
	return Color3.fromRGB(26, 27, 33), Color3.fromRGB(70, 72, 86), Color3.fromRGB(242, 242, 248)
end

-- 关键修复：浅色模式不再用纯黑影子，改成浅灰蓝的柔光，避免"浅色却有黑块"
local function pillShadowColors()
	if Patch.Config.PillStyle == "light" then
		return Color3.fromRGB(168, 178, 200), 0.9
	end
	return Color3.fromRGB(0, 0, 0), 0.52
end

local function pillRippleColor()
	if Patch.Config.PillStyle == "light" then
		return Color3.fromRGB(120, 135, 170)
	end
	return Color3.fromRGB(200, 205, 225)
end

--============================ 胶囊 ============================--

local pillGui

local function ensurePillGui(fallbackParent)
	if pillGui and pillGui.Parent then
		return pillGui
	end
	pillGui = Instance.new("ScreenGui")
	pillGui.Name = "FluentMobilePillGui"
	pillGui.ResetOnSpawn = false
	pillGui.IgnoreGuiInset = true
	pillGui.DisplayOrder = 999999
	pcall(function()
		pillGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	end)

	pcall(function()
		pillGui.Parent = fallbackParent
	end)
	if not pillGui.Parent then
		pcall(function()
			pillGui.Parent = game:GetService("CoreGui")
		end)
	end
	if not pillGui.Parent then
		pcall(function()
			pillGui.Parent = LP:WaitForChild("PlayerGui")
		end)
	end
	return pillGui
end

local function buildPill(parent, onTap)
	local bg, stroke, fg = pillColors()
	local w, h = Patch.Config.PillWidth, Patch.Config.PillHeight

	local pill = Instance.new("Frame")
	pill.Name = "FluentMobilePill"
	pill.AnchorPoint = Vector2.new(0, 0)
	pill.Size = UDim2.fromOffset(w, h)
	local vp = viewport()
	local topInset = getTopInset()

	local baseX = math.floor(vp.X / 2 - w / 2)
	local baseY = math.floor(topInset + Patch.Config.PillTopMargin)
	if Patch.Config.PillX and Patch.Config.PillY then
		baseX, baseY = Patch.Config.PillX, Patch.Config.PillY
	end

	pill.Position = UDim2.fromOffset(baseX, baseY)
	pill.BackgroundColor3 = bg
	pill.BackgroundTransparency = 1
	pill.BorderSizePixel = 0
	pill.Visible = false
	pill.ZIndex = 40
	pill.ClipsDescendants = false
	pill.Parent = ensurePillGui(parent)

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(1, 0)
	corner.Parent = pill

	local outline = Instance.new("UIStroke")
	outline.Name = "PillStroke"
	outline.Thickness = 1
	outline.Color = stroke
	outline.Transparency = 0.28
	outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	outline.Parent = pill

	local scale = Instance.new("UIScale")
	scale.Name = "PillScale"
	scale.Scale = 1
	scale.Parent = pill

	-- 影子：必须是胶囊的“兄弟”，不能是子对象
	-- 之前把影子当子对象挂在胶囊上，ZIndex 再低也会画在胶囊底色上面，
	-- 浅色胶囊就被这层黑色图片糊黑了，这就是那个"浅色却发黑"的根因。
	local shadowColor, shadowTrans = pillShadowColors()
	local shadow = Instance.new("ImageLabel")
	shadow.Name = "FluentMobilePillShadow"
	shadow.BackgroundTransparency = 1
	shadow.Image = "rbxassetid://6014261993"
	shadow.ImageColor3 = shadowColor
	shadow.ImageTransparency = 1
	shadow.ScaleType = Enum.ScaleType.Slice
	shadow.SliceCenter = Rect.new(49, 49, 450, 450)
	shadow.Size = UDim2.fromOffset(w + 14, h + 14)
	shadow.Position = UDim2.fromOffset(baseX - 7, baseY - 6)
	shadow.Visible = false
	shadow.ZIndex = 37
	shadow.Parent = pill.Parent
	shadow:SetAttribute("BaseTransparency", shadowTrans)

	local shadowScale = Instance.new("UIScale")
	shadowScale.Name = "ShadowScale"
	shadowScale.Scale = 1
	shadowScale.Parent = shadow

	pillShadowOf[pill] = shadow

	local pad = Instance.new("UIPadding")
	pad.PaddingLeft = UDim.new(0, 6)
	pad.PaddingRight = UDim.new(0, 14)
	pad.PaddingTop = UDim.new(0, 6)
	pad.PaddingBottom = UDim.new(0, 6)
	pad.Parent = pill

	-- 点击涟漪（单独用一个裁切容器，避免把影子一起裁掉）
	local rippleClip = Instance.new("Frame")
	rippleClip.Name = "PillRippleClip"
	rippleClip.Size = UDim2.fromScale(1, 1)
	rippleClip.BackgroundTransparency = 1
	rippleClip.BorderSizePixel = 0
	rippleClip.ClipsDescendants = true
	rippleClip.ZIndex = 41
	rippleClip.Parent = pill

	local clipCorner = Instance.new("UICorner")
	clipCorner.CornerRadius = UDim.new(1, 0)
	clipCorner.Parent = rippleClip

	local ripple = Instance.new("Frame")
	ripple.Name = "PillRipple"
	ripple.AnchorPoint = Vector2.new(0.5, 0.5)
	ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
	ripple.Size = UDim2.fromOffset(h, h)
	ripple.BackgroundColor3 = pillRippleColor()
	ripple.BackgroundTransparency = 1
	ripple.BorderSizePixel = 0
	ripple.ZIndex = 41
	ripple.Parent = rippleClip

	local rippleCorner = Instance.new("UICorner")
	rippleCorner.CornerRadius = UDim.new(1, 0)
	rippleCorner.Parent = ripple

	local function playRipple()
		if Patch.Config.Lite then
			return
		end
		ripple.Size = UDim2.fromOffset(math.floor(h * 0.85), math.floor(h * 0.85))
		ripple.BackgroundTransparency = 0.72
		tween(ripple, {Size = UDim2.fromOffset(math.floor(w * 1.15), math.floor(h * 2.1))}, 0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		tween(ripple, {BackgroundTransparency = 1}, 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	end

	local avatarHolder = Instance.new("Frame")
	avatarHolder.Name = "Avatar"
	avatarHolder.Size = UDim2.fromOffset(h - 12, h - 12)
	avatarHolder.BackgroundColor3 = bg
	avatarHolder.BorderSizePixel = 1
	avatarHolder.BorderColor3 = stroke
	avatarHolder.ZIndex = 42
	avatarHolder.Parent = pill

	local avatarCorner = Instance.new("UICorner")
	avatarCorner.CornerRadius = UDim.new(1, 0)
	avatarCorner.Parent = avatarHolder

	local avatar = Instance.new("ImageLabel")
	avatar.Name = "Image"
	avatar.Size = UDim2.fromScale(1, 1)
	avatar.BackgroundTransparency = 1
	avatar.ScaleType = Enum.ScaleType.Crop
	avatar.ZIndex = 42
	avatar.Parent = avatarHolder
	local imgCorner = Instance.new("UICorner")
	imgCorner.CornerRadius = UDim.new(1, 0)
	imgCorner.Parent = avatar

	local headshot = avatarCache
	if headshot then
		avatar.Image = headshot
	else
		task.spawn(function()
			local url = getAvatar()
			if url and avatar.Parent then
				avatar.Image = url
			end
		end)
	end

	local ring = Instance.new("UIStroke")
	ring.Thickness = 1.5
	ring.Color = Color3.fromRGB(76, 194, 255)
	ring.Transparency = 0.35
	ring.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	ring.Parent = avatarHolder

	local label = Instance.new("TextLabel")
	label.Name = "Text"
	label.Size = UDim2.new(1, -(h - 4), 1, 0)
	label.Position = UDim2.fromOffset(h - 4, 0)
	label.BackgroundTransparency = 1
	label.Text = Patch.Config.PillText
	label.TextColor3 = fg
	label.TextSize = 17
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Font = Enum.Font.GothamBold
	label.ZIndex = 43
	label.Parent = pill

	pill.Active = true

	-- 弹簧位移状态：base 是真实位置，ox/oy 是临时偏移
	local reactive = {
		baseX = baseX,
		baseY = baseY,
		ox = 0,
		oy = 0,
		vx = 0,
		vy = 0,
		tx = 0,
		ty = 0,
		lastTouch = 0,
		dragging = false,
	}

	local dragging, activeInput, dragStart, startPos, moved = false, nil, nil, nil, 0
	local scaleHold = 0

	local function pillSize()
		local vpSize = viewport()
		local w2 = math.max(pill.AbsoluteSize.X, Patch.Config.PillWidth)
		local h2 = math.max(pill.AbsoluteSize.Y, Patch.Config.PillHeight)
		return vpSize, w2, h2
	end

	local function applyPosition()
		local vpSize, w2, h2 = pillSize()
		local fx = math.clamp(reactive.baseX + reactive.ox, 0, math.max(0, vpSize.X - w2))
		local fy = math.clamp(reactive.baseY + reactive.oy, 0, math.max(0, vpSize.Y - h2 - 6))
		local px, py = math.floor(fx), math.floor(fy)
		pill.Position = UDim2.fromOffset(px, py)
		if shadow and shadow.Parent then
			shadow.Position = UDim2.fromOffset(px - 7, py - 6)
			shadow.Size = UDim2.fromOffset(math.floor(pill.AbsoluteSize.X) + 14, math.floor(pill.AbsoluteSize.Y) + 14)
			shadow.Visible = pill.Visible and not Patch.Config.Lite
		end
	end

	local function setBase(x, y)
		local vpSize, w2, h2 = pillSize()
		reactive.baseX = math.clamp(x, 0, math.max(0, vpSize.X - w2))
		reactive.baseY = math.clamp(y, 0, math.max(0, vpSize.Y - h2 - 6))
		Patch.Config.PillX = math.floor(reactive.baseX)
		Patch.Config.PillY = math.floor(reactive.baseY)
		applyPosition()
	end

	-- 划过周围：朝反方向弹一下，再弹簧回位
	local function reactToPoint(point)
		if not Patch.Config.PillReact or dragging or not pill.Visible then
			return
		end
		local center = pill.AbsolutePosition + pill.AbsoluteSize * 0.5
		local inset = getTopInset()
		local d1 = (point - center).Magnitude
		local d2 = ((point + Vector2.new(0, inset)) - center).Magnitude
		local dist = math.min(d1, d2)

		local radius = math.max(pill.AbsoluteSize.X, pill.AbsoluteSize.Y) * 0.85 + Patch.Config.PillReactRange
		if dist > radius then
			return
		end

		local away = center - point
		if away.Magnitude < 2 then
			away = Vector2.new(0, -1)
		end
		away = away.Unit

		local strength = 1 - math.clamp(dist / radius, 0, 1)
		local push = 6 + strength * 22

		reactive.tx = away.X * push
		reactive.ty = away.Y * push
		reactive.vx = reactive.vx + away.X * strength * 170
		reactive.vy = reactive.vy + away.Y * strength * 170
		reactive.lastTouch = os.clock()
	end

	-- 弹簧渲染循环
	RunService.RenderStepped:Connect(function(dt)
		if not pill.Parent or not pill.Visible or Patch.Config.PillSpring == false then
			return
		end
		dt = math.min(dt, 0.05)
		if math.abs(reactive.tx) < 0.01 and math.abs(reactive.ty) < 0.01 then
			reactive.tx, reactive.ty = 0, 0
		end
		if os.clock() - reactive.lastTouch > 0.12 then
			local decay = math.exp(-dt * 9)
			reactive.tx = reactive.tx * decay
			reactive.ty = reactive.ty * decay
		end

		local k, damp = 118, 11.5
		reactive.vx = reactive.vx + ((reactive.tx - reactive.ox) * k - reactive.vx * damp) * dt
		reactive.vy = reactive.vy + ((reactive.ty - reactive.oy) * k - reactive.vy * damp) * dt
		reactive.ox = reactive.ox + reactive.vx * dt
		reactive.oy = reactive.oy + reactive.vy * dt

		if math.abs(reactive.ox) < 0.05 and math.abs(reactive.vx) < 0.05 then
			reactive.ox, reactive.vx = 0, 0
		end
		if math.abs(reactive.oy) < 0.05 and math.abs(reactive.vy) < 0.05 then
			reactive.oy, reactive.vy = 0, 0
		end

		local offsetMag = math.sqrt(reactive.ox * reactive.ox + reactive.oy * reactive.oy)
		local speed = math.abs(reactive.vx) + math.abs(reactive.vy)
		local squash = 1 + math.clamp(offsetMag / 26, 0, 1) * 0.05 + math.clamp(speed / 900, 0, 1) * 0.035

		if not dragging and os.clock() > scaleHold then
			if math.abs(scale.Scale - squash) > 0.004 then
				scale.Scale = squash
			end
			pill.Rotation = math.clamp(reactive.ox * 0.2, -6, 6)
		end

		applyPosition()
	end)

	local function applyDrag(input)
		if not dragging or not activeInput or input ~= activeInput then
			return
		end
		local delta = input.Position - dragStart
		moved = math.max(moved, math.abs(delta.X) + math.abs(delta.Y))
		if not Patch.Config.PillDraggable then
			return
		end
		setBase(startPos.X + delta.X, startPos.Y + delta.Y)
	end

	local function finishDrag(input)
		if not dragging then
			return
		end
		if input and activeInput and input ~= activeInput then
			return
		end
		dragging = false
		reactive.dragging = false
		activeInput = nil
		scaleHold = os.clock() + 0.34
		tween(scale, {Scale = 1}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

		if moved < 10 then
			onTap()
		else
			setBase(reactive.baseX, reactive.baseY)
			pcall(Patch.SavePillPosition)
			startBreathe(pill)
		end
	end

	pill.InputBegan:Connect(function(input)
		if
			input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch
		then
			dragging = true
			reactive.dragging = true
			activeInput = input
			dragStart = input.Position
			startPos = Vector2.new(reactive.baseX, reactive.baseY)
			moved = 0
			reactive.ox, reactive.oy = 0, 0
			reactive.vx, reactive.vy = 0, 0
			reactive.tx, reactive.ty = 0, 0
			stopBreathe(pill)
			scaleHold = os.clock() + 0.4
			tween(scale, {Scale = 1.06}, 0.16, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
			playRipple()
		end
	end)

	pill.InputChanged:Connect(function(input)
		applyDrag(input)
	end)

	UIS.InputChanged:Connect(function(input)
		if
			input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch
		then
			applyDrag(input)
			reactToPoint(input.Position)
		end
	end)

	pill.InputEnded:Connect(function(input)
		finishDrag(input)
	end)

	UIS.InputEnded:Connect(function(input)
		if
			input.UserInputType == Enum.UserInputType.Touch
			or input.UserInputType == Enum.UserInputType.MouseButton1
		then
			finishDrag(input)
		end
	end)

	UIS.InputBegan:Connect(function(input)
		if
			input.UserInputType == Enum.UserInputType.Touch
			or input.UserInputType == Enum.UserInputType.MouseButton1
		then
			reactToPoint(input.Position)
		end
	end)

	-- 供外部同步用
	pillApis[pill] = {
		setBase = setBase,
		apply = applyPosition,
		reactive = reactive,
		playRipple = playRipple,
		startBreathe = function()
			startBreathe(pill)
		end,
		stopBreathe = function()
			stopBreathe(pill)
		end,
	}

	return pill
end

--============================ 手机尺寸适配 ============================--
-- 本次 UI 重编第一步：只解决尺寸。竖屏占满可用宽度，横屏按比例收窄，
-- 不管颜色、不动 Fluent 内部排版，外观全部还给 Fluent 原生。

local fitW, fitH = 0, 0
local WinRef

-- 默认按屏幕算一个合适的初始尺寸；用户拖过右下角就用记忆值覆盖
local function defaultSize(vp, availW, availH)
	local w, h
	if isMobileUI then
		if vp.X < vp.Y then
			w = math.floor(math.min(availW, 560))
			h = math.floor(availH * 0.96)
		else
			w = math.floor(math.min(availW * 0.8, 680))
			h = math.floor(availH * 0.96)
		end
	else
		w = math.floor(math.min(availW, 780))
		h = math.floor(math.min(availH, 640))
	end
	-- 只有横竖屏切换等极端情况才放不开，这里兜一下最小值
	if w > availW then
		w = availW
	end
	if h > availH then
		h = availH
	end
	return math.max(w, 280), math.max(h, 230)
end

local function clampSaved(w, h, availW, availH)
	local sw, sh = UICfg.w, UICfg.h
	if sw and sh and sw >= 260 and sh >= 220 then
		w = math.clamp(sw, 280, math.max(280, availW))
		h = math.clamp(sh, 230, math.max(230, availH))
	end
	return w, h
end -- 窗口建好后回填；早于 local Window 写下的函数靠它拿窗口

local function guiInsetTop()
	local ok, inset = pcall(function()
		return game:GetService("GuiService"):GetGuiInset()
	end)
	if ok and typeof(inset) == "Vector2" then
		return math.max(0, math.floor(inset.Y))
	end
	return 0
end

local function fitWindow(window)
	window = window or WinRef
	local root = window and window.Root
	if not root then
		return
	end
	local vp = camera.ViewportSize
	if vp.X < 200 or vp.Y < 200 then
		return
	end

	local topInset = guiInsetTop() + 8
	local bottomInset = 16
	local margin = 8
	local availW = math.max(260, vp.X - margin * 2)
	local availH = math.max(220, vp.Y - topInset - bottomInset)

	local w, h = defaultSize(vp, availW, availH)
	w, h = clampSaved(w, h, availW, availH)

	window.Size = UDim2.fromOffset(w, h)
	if root.Size.X.Offset ~= w or root.Size.Y.Offset ~= h then
		root.Size = UDim2.fromOffset(w, h)
	end
	pcall(function()
		window.MinSize = Vector2.new(math.min(280, w), math.min(230, h))
	end)

	local keep = Patch.WindowPos
	if not keep and UICfg.x and UICfg.y then
		keep = {X = UICfg.x, Y = UICfg.y}
	end
	local x, y
	if keep and Patch.Config.KeepWindowPos ~= false then
		x = math.clamp(keep.X, 0, math.max(0, vp.X - w))
		y = math.clamp(keep.Y, 0, math.max(0, vp.Y - h))
	else
		x = math.floor((vp.X - w) / 2)
		y = math.floor(topInset + (availH - h) / 2)
	end
	windowSetPos(window, x, y)
	rememberWindowPos(window, x, y)
	fitW, fitH = w, h
	if UICfg.w == nil or UICfg.h == nil then
		rememberSize(w, h)
	end
	return w, h
end

-- 顶栏伸缩、开键盘都会连着改 ViewportSize，防抖一下，别让窗口跟着抽
local fitPending = false

local function scheduleFit(delay)
	if fitPending then
		return
	end
	fitPending = true
	task.delay(delay or 0.25, function()
		fitPending = false
		pcall(fitWindow, WinRef)
	end)
end

local function clampWindow(window)
	local vp = viewport()
	local size = window.Root.AbsoluteSize
	if size.X <= 0 or size.Y <= 0 then
		return
	end

	local px = window.Root.Position.X.Offset
	local py = window.Root.Position.Y.Offset
	local x = math.clamp(px, 4 - size.X + 80, math.max(4, vp.X - 80))
	local y = math.clamp(py, 0, math.max(0, vp.Y - 48))
	windowSetPos(window, x, y)
	rememberWindowPos(window, x, y)
end

--============================ 接管最小化 ============================--

local function attachWindow(window)
	if not window or not window.Root then
		return nil
	end
	if attached[window.Root] then
		return attached[window.Root]
	end

	local guiParent = window.Root.Parent
	if not guiParent then
		return nil
	end

	lastWindow = window

	if Patch.Config.HideOriginalButton and window.HideButton then
		window.HideButton.Visible = false
	end

	local pill = buildPill(guiParent, function()
		animateWindowShow(window)
		task.delay(0.32, function()
			clampWindow(window)
			notifyState("界面已恢复")
		end)
	end)

	local px, py

	local function sync()
		local minimized = not window.Root.Visible
		window.Minimized = minimized
		if not pill.Parent then
			return
		end

		if minimized then
			local vp = viewport()
			if Patch.Config.PillX and Patch.Config.PillY then
				px, py = Patch.Config.PillX, Patch.Config.PillY
			else
				px = math.floor(vp.X / 2 - pill.AbsoluteSize.X / 2)
				py = getTopInset() + Patch.Config.PillTopMargin
			end
			local api = pillApis[pill]
			if api then
				api.reactive.ox, api.reactive.oy = 0, 0
				api.reactive.vx, api.reactive.vy = 0, 0
				api.reactive.tx, api.reactive.ty = 0, 0
				api.setBase(px, py)
			else
				pill.Position = UDim2.fromOffset(px, py)
			end
			animatePillShow(pill)
		else
			animatePillHide(pill)
		end
	end

	-- 局部变量已在上面声明

	window.Root:GetPropertyChangedSignal("Visible"):Connect(sync)
	if window.OnMinimized and typeof(window.OnMinimized.Connect) == "function" then
		pcall(function()
			window.OnMinimized:Connect(sync)
		end)
	end
	if window.PostMinimized and typeof(window.PostMinimized.Connect) == "function" then
		pcall(function()
			window.PostMinimized:Connect(sync)
		end)
	end

	if isMobile() then
		fitWindow(window)
	end

	if Patch.Config.KeyboardAvoid then
		local baseY
		UIS.TextBoxFocused:Connect(function(box)
			if not window.Root.Visible then
				return
			end
			baseY = window.Root.Position.Y.Offset
			local vp = viewport()
			local boxY = box.AbsolutePosition.Y
			local targetY = math.max(38, math.min(baseY, vp.Y * 0.42 - 40))
			if boxY > vp.Y * 0.45 then
				tween(window.Root, {Position = UDim2.fromOffset(window.Root.Position.X.Offset, targetY)}, 0.22)
			end
		end)
		UIS.TextBoxFocusReleased:Connect(function()
			if baseY then
				local keepY = baseY
				if Patch.WindowPos then
					keepY = Patch.WindowPos.Y
				end
				windowPosGuard()
				tween(window.Root, {Position = UDim2.fromOffset(window.Root.Position.X.Offset, keepY)}, 0.22)
				baseY = nil
			end
		end)
	end

	UIS.InputEnded:Connect(function(input)
		if
			input.UserInputType == Enum.UserInputType.Touch
			or input.UserInputType == Enum.UserInputType.MouseButton1
		then
			if window.Root.Visible then
				clampWindow(window)
			end
		end
	end)

	local cam = workspace.CurrentCamera
	if cam then
		cam:GetPropertyChangedSignal("ViewportSize"):Connect(function()
			-- 窗口大小统一交给全局 scheduleFit 防抖处理，这里只管胶囊
			if pill.Visible then
				local vp = viewport()
				local api = pillApis[pill]
				if api then
					api.setBase(
						math.clamp(api.reactive.baseX, 0, math.max(0, vp.X - pill.AbsoluteSize.X)),
						math.clamp(api.reactive.baseY, 0, math.max(0, vp.Y - pill.AbsoluteSize.Y - 6))
					)
				else
					pill.Position = UDim2.fromOffset(
						math.clamp(pill.Position.X.Offset, 0, math.max(0, vp.X - pill.AbsoluteSize.X)),
						math.clamp(pill.Position.Y.Offset, 0, math.max(0, vp.Y - pill.AbsoluteSize.Y - 6))
					)
				end
			end
		end)
	end

	attached[window.Root] = {Window = window, Pill = pill}
	return attached[window.Root]
end

--============================ 从实例反推窗口 ============================--

local function windowFromRoot(root)
	local tabDisplay, holder, canvas
	for _, c in ipairs(root:GetChildren()) do
		if c:IsA("TextLabel") and c.TextSize >= 22 then
			tabDisplay = c
		elseif c:IsA("Frame") then
			local sf = c:FindFirstChildWhichIsA("ScrollingFrame")
			if sf and not holder then
				holder = sf
			elseif c:FindFirstChildWhichIsA("CanvasGroup") then
				canvas = c
			end
		end
	end

	if not (tabDisplay and holder) then
		return nil
	end

	return {
		Root = root,
		TabHolder = holder,
		TabDisplay = tabDisplay,
		ContainerCanvas = canvas,
		Size = root.Size,
		Position = root.Position,
		Minimized = not root.Visible,
	}
end

--============================ 对外接口 ============================--

function Patch.Attach(window)
	return attachWindow(window)
end

function Patch.GetGui()
	if lastWindow and lastWindow.Root and lastWindow.Root.Parent then
		return lastWindow.Root.Parent
	end
	for _, obj in ipairs(game:GetService("CoreGui"):GetChildren()) do
		if obj:IsA("ScreenGui") and obj.Name:find("Fluent", 1, true) then
			return obj
		end
	end
	for _, obj in ipairs(LP:WaitForChild("PlayerGui"):GetChildren()) do
		if obj:IsA("ScreenGui") and obj.Name:find("Fluent", 1, true) then
			return obj
		end
	end
	return nil
end

function Patch.AttachAll()
	if lastWindow and lastWindow.Root then
		return 1
	end
	local gui = Patch.GetGui()
	if not gui then
		return 0
	end
	for _, obj in ipairs(gui:GetChildren()) do
		if obj:IsA("Frame") and obj.AbsoluteSize.X > 300 then
			local window = windowFromRoot(obj)
			if window then
				attachWindow(window)
				return 1
			end
		end
	end
	return 0
end

function Patch.Minimize()
	if lastWindow then
		animateWindowHide(lastWindow)
	end
end

function Patch.Restore()
	if lastWindow then
		animateWindowShow(lastWindow)
		task.delay(0.3, function()
			clampWindow(lastWindow)
		end)
	end
end

function Patch.SetPillStyle(style)
	Patch.Config.PillStyle = tostring(style)
	if not (pillGui and pillGui.Parent) then
		return false
	end
	local pill = pillGui:FindFirstChild("FluentMobilePill")
	if not pill then
		return false
	end

	local bg, stroke, fg = pillColors()
	pill.BackgroundColor3 = bg
	-- 关键：浅色下底色更实，影子换成浅灰蓝，彻底去掉黑块
	pill.BackgroundTransparency = pill.Visible and pillBgTransparency() or 1

	local outline = pill:FindFirstChild("PillStroke") or pill:FindFirstChildOfClass("UIStroke")
	if outline then
		outline.Color = stroke
	end

	local shadow = pillShadowOf[pill]
	if shadow then
		local sc, st = pillShadowColors()
		shadow.ImageColor3 = sc
		shadow.ImageTransparency = st
		shadow:SetAttribute("BaseTransparency", st)
	end

	local label = pill:FindFirstChild("Text")
	if label then
		label.TextColor3 = fg
	end

	local rippleClip = pill:FindFirstChild("PillRippleClip")
	local ripple = rippleClip and rippleClip:FindFirstChild("PillRipple")
	if ripple then
		ripple.BackgroundColor3 = pillRippleColor()
	end

	local avatarHolder = pill:FindFirstChild("Avatar")
	if avatarHolder and avatarHolder:IsA("Frame") then
		avatarHolder.BackgroundColor3 = bg
		avatarHolder.BorderColor3 = stroke
	end

	if pill.Visible then
		stopBreathe(pill)
		startBreathe(pill)
	end

	return true
end

function Patch.SetPillText(text)
	Patch.Config.PillText = tostring(text)
	local entry = lastWindow and attached[lastWindow.Root]
	if entry and entry.Pill then
		local label = entry.Pill:FindFirstChild("Text")
		if label then
			label.Text = tostring(text)
		end
	end
end

function Patch.ResetPillPosition()
	local entry = lastWindow and attached[lastWindow.Root]
	if entry and entry.Pill then
		local api = pillApis[entry.Pill]
		local vp = viewport()
		local x = math.floor(vp.X / 2 - entry.Pill.AbsoluteSize.X / 2)
		local y = math.floor(getTopInset() + Patch.Config.PillTopMargin)
		Patch.Config.PillX, Patch.Config.PillY = x, y
		if api then
			api.setBase(x, y)
		else
			entry.Pill.Position = UDim2.fromOffset(x, y)
		end
		pcall(Patch.SavePillPosition)
		return true
	end
	return false
end

getgenv().FluentMobile = Patch

--============================ ③ 功能后端 ============================--

local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = workspace

local API = {}
getgenv().Chuang = API

local state = {
	walkSpeed = 16,
	jumpPower = 50,
	useJumpPower = false,
	noclip = false,
	infJump = false,
	fly = false,
	flySpeed = 100,
	frozen = false,
	god = false,
	spin = false,
	spinSpeed = 10,
	antivoid = false,
	autoAttack = false,
	orbit = false,
	translation = false,
	grabBackpack = false,
}

getgenv().ChuangState = state

-- 记录游戏原本的速度 / 跳跃，关闭功能时按这个还原
state.speedOn = false
state.jumpOn = false
state.baseSpeed = nil
state.baseJumpPower = nil
state.baseJumpHeight = nil
state.baseUseJumpPower = nil

local function captureBaseStats(hum)
	if not hum then
		return
	end
	state.baseSpeed = hum.WalkSpeed
	state.baseJumpPower = hum.JumpPower
	state.baseJumpHeight = hum.JumpHeight
	state.baseUseJumpPower = hum.UseJumpPower
	getgenv().ChuangBaseSpeed = hum.WalkSpeed
end

local function applyJumpValue(hum, value, usePower)
	if not hum then
		return
	end
	if usePower then
		hum.UseJumpPower = true
		hum.JumpPower = value
	else
		hum.UseJumpPower = false
		hum.JumpHeight = value
	end
end

local function getChar()
	return LP.Character or LP.CharacterAdded:Wait()
end

local function getHum()
	local ch = LP.Character
	return ch and ch:FindFirstChildOfClass("Humanoid")
end

local function getRoot()
	local ch = LP.Character
	return ch and ch:FindFirstChild("HumanoidRootPart")
end

local function notify(title, content, dur)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = tostring(title or "窗"),
			Text = tostring(content or ""),
			Icon = "rbxassetid://71024334944141",
			Duration = dur or 3,
		})
	end)
end

API.Notify = notify

function API.Help()
	local list = {}
	for k in pairs(API) do
		table.insert(list, k)
	end
	table.sort(list)
	print("[窗] 可用方法:\n  " .. table.concat(list, "\n  "))
	return list
end

function API.Kick267(reason)
	notify("即将断开连接（267）", "", 2)
	task.wait(1)
	pcall(function()
		LP:Kick("\n\n[制作脚本(窗)] " .. tostring(reason or "手动断开") .. "\n\n错误代码: 267")
	end)
	task.wait(1)
	pcall(function()
		game:Shutdown()
	end)
end

function API.Kick(reason)
	pcall(function()
		LP:Kick(tostring(reason or "你已退出游戏"))
	end)
end

LP.Idled:Connect(function()
	pcall(function()
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new(0, 0))
	end)
end)

LP.CharacterAdded:Connect(function(char)
	task.wait(0.5)
	local hum = (char and char:FindFirstChildOfClass("Humanoid")) or getHum()
	if not hum then
		return
	end

	captureBaseStats(hum)

	local ui = API.UI
	if state.speedOn then
		hum.WalkSpeed = state.walkSpeed
	else
		state.walkSpeed = hum.WalkSpeed
		if ui and ui.Controls and ui.Controls.SpeedSlider then
			pcall(function()
				ui.Controls.SpeedSlider:SetValue(hum.WalkSpeed)
			end)
		end
	end
	if state.jumpOn then
		applyJumpValue(hum, state.jumpValue or hum.JumpHeight, hum.UseJumpPower)
	end
	end)

pcall(function()
	local hum = getHum()
	if hum then
		captureBaseStats(hum)
	end
end)

local speedGuardOn = false

-- 有些游戏/反作弊会把 WalkSpeed 悄悄拉回原值，表现为"调了没反应、要重开"
-- 这里只做保守回补：设定值高于游戏基础速度、而当前被拉回基础值附近时才补
local function startSpeedGuard()
	if speedGuardOn then
		return
	end
	speedGuardOn = true
	spawnTracked(function()
		while speedGuardOn do
			task.wait(0.2)
			if not state.speedOn or state.frozen then
				continue
			end
			local hum = getHum()
			local want = tonumber(state.walkSpeed) or 0
			local base = tonumber(state.baseSpeed) or 16
			if hum and want > base + 0.5 then
				local cur = hum.WalkSpeed
				if cur < want - 0.5 and cur <= base + 2 then
					hum.WalkSpeed = want
				end
			end
			if not (Gui.Window and Gui.Window.Root and Gui.Window.Root.Parent) then
				break
			end
		end
		speedGuardOn = false
	end)
end

function API.SetSpeed(v)
	local n = math.clamp(tonumber(v) or state.baseSpeed or 16, 0, 1000)
	state.walkSpeed = n
	local hum = getHum()
	if hum then
		hum.WalkSpeed = n
	end
	if state.speedOn then
		startSpeedGuard()
	end
	return n
end

function API.SetJumpHeight(v)
	local n = math.clamp(tonumber(v) or 50, 0, 2000)
	state.jumpValue = n
	local hum = getHum()
	if hum then
		if hum.UseJumpPower then
			hum.JumpPower = n
		else
			hum.JumpHeight = n
		end
	end
	return n
end

function API.SetGravity(v)
	Workspace.Gravity = tonumber(v) or 196.2
	return Workspace.Gravity
end

function API.SetFOV(v)
	local cam = Workspace.CurrentCamera
	local n = math.clamp(tonumber(v) or 70, 1, 120)
	if cam then
		cam.FieldOfView = n
	end
	return n
end

function API.Noclip(on)
	state.noclip = on and true or false
	if state.noclip then
		spawnTracked(function()
			while state.noclip do
				task.wait(0.1)
				local ch = LP.Character
				if ch then
					for _, p in ipairs(ch:GetDescendants()) do
						if p:IsA("BasePart") then
							p.CanCollide = false
						end
					end
				end
			end
		end)
	else
		local ch = LP.Character
		if ch then
			for _, p in ipairs(ch:GetDescendants()) do
				if p:IsA("BasePart") then
					p.CanCollide = true
				end
			end
		end
	end
	return state.noclip
end

function API.InfiniteJump(on)
	state.infJump = on and true or false
	if state.infJump then
		spawnTracked(function()
			while state.infJump do
				task.wait(0.05)
				if UIS:IsKeyDown(Enum.KeyCode.Space) then
					local hum = getHum()
					if hum then
						hum:ChangeState(Enum.HumanoidStateType.Jumping)
					end
				end
			end
		end)
	end
	return state.infJump
end

function API.Freeze(on)
	state.frozen = on and true or false
	if state.frozen then
		spawnTracked(function()
			while state.frozen do
				task.wait(0.1)
				local hum = getHum()
				if hum then
					hum.WalkSpeed = 0
					hum.JumpPower = 0
				end
			end
		end)
	else
		local hum = getHum()
		if hum then
			hum.WalkSpeed = state.walkSpeed
			hum.JumpPower = state.jumpPower
		end
	end
	return state.frozen
end

--============================ 飞行 ============================--
-- 内核：LinearVelocity + AlignOrientation + VectorForce（现代约束）
-- 旧的 BodyVelocity / BodyGyro 已整段移除，原因：
--   BodyMover 是遗留件，属性会复制到服务端，带速度检测的游戏更容易判定；
--   BodyGyro 锁 R15 朝向有抖动，且 P 值要手工调。
-- 现在三件套各管一件事：
--   LinearVelocity   管速度（World 空间，每帧改写 VectorVelocity）
--   AlignOrientation 管朝向（单附件 + RigidityEnabled，瞬间对齐不抖）
--   VectorForce      抵消重力（按 AssemblyMass × Gravity 算，悬停不垂头）
-- 仍然要每帧把 Humanoid 打进 Physics 状态，否则它自己的落地位移会抢控制权。

local flyLV, flyAO, flyVF, flyAtt

local FLY_DESCEND_CAP = 20

local function flyCleanup()
	-- 先夹下落速度再拆约束：直接 Destroy 会把当前的高速垂直速度留在身上，
	-- 自然灾害类游戏会把它判成高速摔落，关飞行的那一下照样掉血。
	local rootNow = getRoot()
	if rootNow then
		-- 两步走：先把下落分量夹到 20，再整体清零并保持 0.24 秒。
		-- 只夹不零还是会以 20 的速度撞地（有些游戏的判定阈值比 20 还低）；
		-- 清零后保持一小段时间，落地那一下碰撞速度接近 0，摔伤判定拿不到数。
		pcall(function()
			local v = rootNow.AssemblyLinearVelocity
			rootNow.AssemblyLinearVelocity = Vector3.new(v.X, math.min(v.Y, FLY_DESCEND_CAP), v.Z)
		end)
		pcall(function()
			if rootNow.Parent then
				for _ = 1, 8 do
					rootNow.AssemblyLinearVelocity = Vector3.zero
					rootNow.AssemblyAngularVelocity = Vector3.zero
					task.wait(0.03)
				end
			end
		end)
	end

	for _, obj in ipairs({ flyLV, flyAO, flyVF, flyAtt }) do
		if obj then
			pcall(function()
				obj:Destroy()
			end)
		end
	end
	flyLV, flyAO, flyVF, flyAtt = nil, nil, nil, nil

	local root = getRoot()
	if root then
		pcall(function()
			for _, d in ipairs(root:GetChildren()) do
				if
					d.Name == "ChuangFlyAtt"
					or d.Name == "ChuangFlyVel"
					or d.Name == "ChuangFlyOrient"
					or d.Name == "ChuangFlyForce"
				then
					d:Destroy()
				end
			end
		end)
	end
end

function API.SetFlySpeed(v)
	state.flySpeed = math.clamp(tonumber(v) or 100, 5, 1000)
	return state.flySpeed
end

function API.Fly(on)
	on = on and true or false
	if on == state.fly then
		return state.fly
	end

	if not on then
		state.fly = false
		flyCleanup()
		return false
	end

	local ch = getChar()
	local root = ch:WaitForChild("HumanoidRootPart")
	local hum = ch:WaitForChild("Humanoid")

	flyAtt = Instance.new("Attachment")
	flyAtt.Name = "ChuangFlyAtt"
	flyAtt.Parent = root

	flyLV = Instance.new("LinearVelocity")
	flyLV.Name = "ChuangFlyVel"
	flyLV.Attachment0 = flyAtt
	flyLV.RelativeTo = Enum.ActuatorRelativeTo.World
	flyLV.ForceLimitMode = Enum.ForceLimitMode.PerAxis
	flyLV.MaxAxesForce = Vector3.new(1e6, 1e6, 1e6)
	flyLV.VectorVelocity = Vector3.zero
	flyLV.Parent = root

	flyAO = Instance.new("AlignOrientation")
	flyAO.Name = "ChuangFlyOrient"
	flyAO.Mode = Enum.OrientationAlignmentMode.OneAttachment
	flyAO.Attachment0 = flyAtt
	flyAO.RigidityEnabled = true
	flyAO.MaxTorque = 1e6
	flyAO.Parent = root

	flyVF = Instance.new("VectorForce")
	flyVF.Name = "ChuangFlyForce"
	flyVF.Attachment0 = flyAtt
	flyVF.RelativeTo = Enum.ActuatorRelativeTo.World
	flyVF.ApplyAtCenterOfMass = true
	flyVF.Parent = root

	local controls
	pcall(function()
		controls = require(LP.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
	end)

	state.fly = true

	-- 护血：有些游戏按“位移速度”扣血，飞过去也会被算成摔伤/撞击。
	-- 这里只记录飞行期间的基线，血量被扣就补回基线，不碰 MaxHealth。
	local flyHealth = hum.Health

	spawnTracked(function()
		while state.fly and root.Parent do
			if hum.Health < flyHealth then
				pcall(function()
					hum.Health = flyHealth
				end)
			else
				flyHealth = hum.Health
			end

			local cam = Workspace.CurrentCamera
			local move = controls and controls:GetMoveVector() or Vector3.zero
			local dir = cam.CFrame.LookVector * -move.Z + cam.CFrame.RightVector * move.X

			-- 重力抵消：AssemblyMass 是整个装配体的质量，不是单个部件的
			local mass = 0
			pcall(function()
				mass = root.AssemblyMass
			end)
			flyVF.Force = Vector3.new(0, mass * Workspace.Gravity, 0)

			if move.Magnitude > 0 then
				flyLV.VectorVelocity = dir.Unit * state.flySpeed
				flyAO.CFrame = CFrame.lookAt(Vector3.zero, dir)
			else
				flyLV.VectorVelocity = Vector3.new(0, 0.1, 0)
				local flat = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)
				if flat.Magnitude < 0.001 then
					flat = Vector3.new(0, 0, -1)
				end
				flyAO.CFrame = CFrame.lookAt(Vector3.zero, flat)
			end

			hum:ChangeState(Enum.HumanoidStateType.Physics)
			RunService.RenderStepped:Wait()
		end

		flyCleanup()
	end)

	return state.fly
end

--============================ 传送 ============================--

function API.TeleportTo(name, forward, side, up)
	local plr = Players:FindFirstChild(tostring(name))
	local root = getRoot()
	local target = plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

	if not (root and target) then
		notify("传送失败", "目标玩家不存在或角色未加载", 3)
		return false
	end

	root.CFrame = target.CFrame * CFrame.new(side or 0, up or 0, -(forward or 0))
	return true
end

function API.BringTo(name, up)
	local plr = Players:FindFirstChild(tostring(name))
	local root = getRoot()
	local target = plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

	if not (root and target) then
		notify("传送失败", "目标玩家不存在或角色未加载", 3)
		return false
	end

	target.CFrame = root.CFrame * CFrame.new(0, up or 3, 0)
	return true
end

--============================ 血量 / 状态 ============================--

function API.SetHealth(v)
	local hum = getHum()
	if hum then
		hum.Health = math.clamp(tonumber(v) or hum.Health, 0, hum.MaxHealth)
	end
end

function API.SetMaxHealth(v)
	local hum = getHum()
	if hum then
		local n = math.clamp(tonumber(v) or 100, 1, 100000)
		hum.MaxHealth = n
		hum.Health = n
	end
end

function API.GodMode(on)
	state.god = on and true or false
	if state.god then
		spawnTracked(function()
			while state.god do
				task.wait()
				local hum = getHum()
				if hum then
					hum.Health = hum.MaxHealth
				end
			end
		end)
	end
	return state.god
end

function API.SetSpin(on, speed)
	if speed then
		state.spinSpeed = tonumber(speed) or state.spinSpeed
	end
	state.spin = on and true or false
	if state.spin then
		spawnTracked(function()
			while state.spin do
				task.wait()
				local root = getRoot()
				if root then
					root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(state.spinSpeed), 0)
				end
			end
		end)
	end
	return state.spin
end

function API.Invisible(on)
	local ch = LP.Character
	if not ch then
		return false
	end
	for _, d in ipairs(ch:GetDescendants()) do
		if d:IsA("BasePart") then
			d.Transparency = on and 1 or 0
		elseif d:IsA("Decal") then
			d.Transparency = on and 1 or 0
		end
	end
	return on and true or false
end

function API.Korblox(on)
	local ch = LP.Character
	local hum = getHum()
	if not (ch and hum) then
		return false
	end

	if hum.RigType == Enum.HumanoidRigType.R15 then
		local upper = ch:FindFirstChild("RightUpperLeg")
		local lower = ch:FindFirstChild("RightLowerLeg")
		local foot = ch:FindFirstChild("RightFoot")
		if upper and lower and foot then
			lower.Transparency = on and 1 or 0
			foot.Transparency = on and 1 or 0
			upper.MeshId = on and "http://www.roblox.com/asset/?id=902942096" or ""
			upper.TextureID = on and "http://roblox.com/asset/?id=902843398" or ""
		end
	else
		local leg = ch:FindFirstChild("Right Leg")
		if leg then
			local mesh = leg:FindFirstChildOfClass("SpecialMesh")
			if on then
				if not mesh then
					mesh = Instance.new("SpecialMesh")
					mesh.Parent = leg
				end
				leg.Color = Color3.fromRGB(64, 64, 64)
				mesh.MeshType = Enum.MeshType.FileMesh
				mesh.MeshId = "rbxassetid://101851696"
				mesh.TextureId = "rbxassetid://101851254"
				mesh.Scale = Vector3.new(1, 1, 1)
			elseif mesh then
				mesh:Destroy()
			end
		end
	end

	return on and true or false
end

function API.Headless(on)
	local ch = LP.Character
	local head = ch and ch:FindFirstChild("Head")
	if not head then
		return false
	end
	head.Transparency = on and 1 or 0
	for _, d in ipairs(head:GetChildren()) do
		if d:IsA("Decal") or d:IsA("Texture") then
			d.Transparency = on and 1 or 0
		end
	end
	return on and true or false
end

function API.NightVision(on)
	if on then
		Lighting.Brightness = 2
		Lighting.ClockTime = 14
		Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
	else
		Lighting.Brightness = 1
		Lighting.ClockTime = 14
		Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
	end
	return on and true or false
end

--============================ 甩飞 ============================--

-- 甩飞改成「原版培根头那套」：在目标身上绕圈砸，用巨大速度把自己甩出去撞他
-- 原版几个比旧版高级的点，这里全保留了：
-- 1) 挑部位：头和腰差 5 格以上就围着「头」转，否则围着腰，没腰就退到饰品 Handle
-- 2) 分两种模式：目标站着不动 → 四个方位轮流砸；目标在跑 → 用他自己速度和朝向放大冲击
-- 3) 位移和旋转分开给：位置 9e7、角速度 9e8，关节才真的被拧散
-- 4) 自己身上挂 EpixVel（9e8），不是挂目标，撞上去那一下更狠
-- 5) 收尾「一直拉回到离原位 25 格以内」，比一次性传送更不容易留在半空摔死
local flinging = false

local function pickFlingPart(vChar)
	local vRoot = vChar:FindFirstChild("HumanoidRootPart")
	local vHead = vChar:FindFirstChild("Head")

	-- 头和腰离得开（R6 常见）就用头，贴着就用腰
	if vRoot and vHead and (vRoot.Position - vHead.Position).Magnitude > 5 then
		return vHead
	end
	if vRoot then
		return vRoot
	end
	if vHead then
		return vHead
	end
	local acc = vChar:FindFirstChildOfClass("Accessory")
	if acc then
		return acc:FindFirstChild("Handle")
	end
	return nil
end

local function flingOne(player)
	local myChar = LP.Character
	local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
	local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
	local vChar = player.Character
	if not (myChar and myHum and myRoot and vChar) then
		return false
	end

	local part = pickFlingPart(vChar)
	if not part then
		return false
	end

	local oldPos = myRoot.CFrame
	local oldFPDH = Workspace.FallenPartsDestroyHeight

	pcall(function()
		-- 原版这里传的是 0/0（NaN），有的执行器直接拒收，这里换成合法的大负数
		Workspace.FallenPartsDestroyHeight = -100000
	end)
	pcall(function()
		myHum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
		myHum:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
	end)

	local bv = Instance.new("BodyVelocity")
	bv.Name = "EpixVel"
	bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	bv.Velocity = Vector3.new(9e8, 9e8, 9e8)
	pcall(function()
		bv.Parent = myRoot
	end)

	-- 每一砸都取目标的实时位置，他被打飞之后能跟得住
	local function hit(offset, spin)
		local base = part.Position
		local cf = CFrame.new(base + offset) * CFrame.Angles(spin, 0, 0)
		pcall(function()
			myRoot.CFrame = cf
			myChar:SetPrimaryPartCFrame(cf)
			myRoot.AssemblyLinearVelocity = Vector3.new(9e7, 9e7, 9e7)
			myRoot.AssemblyAngularVelocity = Vector3.new(9e8, 9e8, 9e8)
		end)
		task.wait()
	end

	local alive = function()
		return part.Parent ~= nil and player.Character == vChar
	end

	if part.AssemblyLinearVelocity.Magnitude >= 50 then
		-- 目标在跑：跟着他的速度和朝向砸，不然他跑掉就打空
		local vVel = math.max(part.AssemblyLinearVelocity.Magnitude, 1)
		-- 原版这块用的是「目标」的 WalkSpeed，不是自己的，别写错
		local vHum = vChar:FindFirstChildOfClass("Humanoid")
		local walk = math.max((vHum and vHum.WalkSpeed) or 16, 1)
		for _ = 1, 4 do
			hit(Vector3.new(0, 1.5, walk), 5156.62)
			hit(Vector3.new(0, -1.5, -walk), 0)
			hit(Vector3.new(0, 1.5, walk), 5156.62)
			hit(Vector3.new(0, 1.5, vVel / 1.25), 5156.62)
			hit(Vector3.new(0, -1.5, -vVel / 1.25), 0)
			hit(Vector3.new(0, 1.5, vVel / 1.25), 5156.62)
			hit(Vector3.new(0, -1.5, 0), 5156.62)
			hit(Vector3.new(0, -1.5, 0), 0)
			hit(Vector3.new(0, -1.5, 0), -5156.62)
			hit(Vector3.new(0, -1.5, 0), 0)
			if not alive() then
				break
			end
		end
	else
		-- 目标站着不动：四个方位轮流砸，每轮再加 100° 翻滚
		for i = 1, 6 do
			local r = math.rad(i * 100)
			hit(Vector3.new(0, 1.5, 0), r)
			hit(Vector3.new(0, -1.5, 0), r)
			hit(Vector3.new(2.25, 1.5, -2.25), r)
			hit(Vector3.new(-2.25, -1.5, 2.25), r)
			if not alive() then
				break
			end
		end
	end

	pcall(function()
		if bv then
			bv:Destroy()
		end
	end)
	pcall(function()
		myHum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
		pcall(function()
			myHum:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
		end)
	end)

	-- 收尾：拉回原位，反复拉到 25 格以内（原版就是这么退出来的，最多 3 秒）
	local deadline = os.clock() + 3
	while os.clock() < deadline do
		local r = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
		if not r then
			break
		end
		if (r.Position - oldPos.Position).Magnitude < 25 then
			break
		end
		pcall(function()
			local keep = oldPos * CFrame.new(0, 0.5, 0)
			r.CFrame = keep
			if LP.Character then
				pcall(function()
					LP.Character:SetPrimaryPartCFrame(keep)
				end)
			end
		end)
		local ch = LP.Character
		if ch then
			for _, p in ipairs(ch:GetDescendants()) do
				if p:IsA("BasePart") then
					pcall(function()
						p.AssemblyLinearVelocity = Vector3.zero
						p.AssemblyAngularVelocity = Vector3.zero
					end)
				end
			end
		end
		local h = getHum()
		if h then
			pcall(function()
				h:ChangeState(Enum.HumanoidStateType.GettingUp)
			end)
		end
		task.wait()
	end

	pcall(function()
		Workspace.FallenPartsDestroyHeight = oldFPDH
	end)
	return true
end

function API.Fling(target)
	if flinging then
		notify("甩飞", "上一次还在收尾，等一下", 2)
		return 0
	end

	local raw = tostring(target or "")
	local key = raw:lower()
	local targets = {}

	if key == "all" or key == "others" then
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LP then
				table.insert(targets, p)
			end
		end
	elseif key == "random" then
		local pool = {}
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LP then
				table.insert(pool, p)
			end
		end
		if #pool > 0 then
			table.insert(targets, pool[math.random(#pool)])
		end
	else
		-- 原版的选人：先按完整名字找，再按名字/显示名的前缀匹配
		local exact = Players:FindFirstChild(raw)
		if exact and exact ~= LP then
			table.insert(targets, exact)
		elseif #key > 0 then
			for _, p in ipairs(Players:GetPlayers()) do
				if p ~= LP then
					if p.Name:lower():sub(1, #key) == key or p.DisplayName:lower():sub(1, #key) == key then
						table.insert(targets, p)
						break
					end
				end
			end
		end
	end

	if #targets == 0 then
		notify("甩飞", "找不到玩家: " .. raw, 3)
		return 0
	end

	if not (getRoot() and getHum()) then
		notify("甩飞", "你自己角色还没加载完", 3)
		return 0
	end

	flinging = true
	local count = 0
	for _, p in ipairs(targets) do
		local ok = pcall(flingOne, p)
		if ok then
			count = count + 1
		end
		task.wait(0.25)
	end
	flinging = false

	notify("甩飞", "已处理 " .. count .. " 个目标（自己也会被摔，属正常）", 3)
	return count
end
function API.FlingAll()
	return API.Fling("all")
end

--============================ 甩飞碰到就炸 ============================--

local touchFling = false

function API.TouchFling(on)
	touchFling = on and true or false
	if touchFling then
		spawnTracked(function()
			while touchFling do
				RunService.Heartbeat:Wait()
				local root = getRoot()
				if root then
					local v = root.Velocity
					root.Velocity = v + Vector3.new(0, 5000, 0)
					RunService.RenderStepped:Wait()
					root.Velocity = v
					RunService.Stepped:Wait()
					root.Velocity = v + Vector3.new(0, 0.1, 0)
				end
			end
		end)
	end
	return touchFling
end

--============================ 伪装 ============================--

function API.CopyAppearance(name)
	local plr = Players:FindFirstChild(tostring(name))
	local myChar = LP.Character
	local myHum = getHum()

	if not (plr and plr.Character and myChar and myHum) then
		notify("伪装失败", "目标或自己角色未加载", 3)
		return false
	end

	local targetHum = plr.Character:FindFirstChildOfClass("Humanoid")
	if not targetHum then
		notify("伪装失败", "目标没有 Humanoid", 3)
		return false
	end

	local ok, err = pcall(function()
		myHum:ApplyDescription(targetHum:GetAppliedDescription())
	end)

	if ok then
		notify("伪装完成", "已复制 " .. plr.Name .. " 的外观", 3)
		return true
	end

	notify("伪装失败", tostring(err), 4)
	return false
end

function API.RestoreAppearance()
	pcall(function()
		LP:LoadCharacter()
	end)
end

--============================ 尾迹 ============================--

local trailObj

local TrailColors = {
	["蓝色"] = Color3.fromRGB(0, 100, 255),
	["绿色"] = Color3.fromRGB(0, 255, 100),
	["红色"] = Color3.fromRGB(255, 0, 0),
	["青色"] = Color3.fromRGB(0, 255, 255),
	["黄色"] = Color3.fromRGB(255, 255, 0),
	["橙色"] = Color3.fromRGB(255, 150, 0),
	["紫色"] = Color3.fromRGB(150, 0, 255),
	["粉色"] = Color3.fromRGB(255, 105, 180),
	["黑色"] = Color3.fromRGB(0, 0, 0),
	["白色"] = Color3.fromRGB(255, 255, 255),
}

local rainbow = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
	ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 165, 0)),
	ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),
	ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 100, 255)),
	ColorSequenceKeypoint.new(0.83, Color3.fromRGB(75, 0, 130)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(238, 130, 238)),
})

local function colorSequenceOf(name)
	if name == "彩虹" then
		return rainbow
	end
	return ColorSequence.new(TrailColors[name] or Color3.fromRGB(0, 255, 255))
end

function API.Trail(on, color)
	local root = getRoot()
	if not root then
		return false
	end

	if trailObj then
		trailObj:Destroy()
		trailObj = nil
	end
	for _, n in ipairs({"ChuangTrailA0", "ChuangTrailA1"}) do
		local old = root:FindFirstChild(n)
		if old then
			old:Destroy()
		end
	end

	if not on then
		return false
	end

	local a0 = Instance.new("Attachment")
	a0.Name = "ChuangTrailA0"
	a0.Position = Vector3.new(0, 0.5, 0)
	a0.Parent = root

	local a1 = Instance.new("Attachment")
	a1.Name = "ChuangTrailA1"
	a1.Position = Vector3.new(0, -0.5, 0)
	a1.Parent = root

	trailObj = Instance.new("Trail")
	trailObj.Name = "ChuangTrail"
	trailObj.Attachment0 = a0
	trailObj.Attachment1 = a1
	trailObj.Lifetime = 0.8
	trailObj.MinLength = 0
	trailObj.MaxLength = 0
	trailObj.LightEmission = 1
	trailObj.LightInfluence = 0
	trailObj.FaceCamera = true
	trailObj.WidthScale = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0)})
	trailObj.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(0.7, 0.3),
		NumberSequenceKeypoint.new(1, 1),
	})
	trailObj.Color = colorSequenceOf(color)
	trailObj.Parent = root

	return true
end

function API.SetTrailColor(color)
	if trailObj then
		trailObj.Color = colorSequenceOf(tostring(color))
	end
	return true
end

--============================ 动画包 ============================--

local AnimPacks = {
	["吸血鬼"] = {idle1 = "rbxassetid://1083445855", idle2 = "rbxassetid://1083450166", walk = "rbxassetid://1083473930", run = "rbxassetid://1083462077", jump = "rbxassetid://1083455352", climb = "rbxassetid://1083439238", fall = "rbxassetid://1083443587"},
	["英雄"] = {idle1 = "rbxassetid://616111295", idle2 = "rbxassetid://616113536", walk = "rbxassetid://616122287", run = "rbxassetid://616117076", jump = "rbxassetid://616115533", climb = "rbxassetid://616104706", fall = "rbxassetid://616108001"},
	["经典僵尸"] = {idle1 = "rbxassetid://616158929", idle2 = "rbxassetid://616160636", walk = "rbxassetid://616168032", run = "rbxassetid://616163682", jump = "rbxassetid://616161997", climb = "rbxassetid://616156119", fall = "rbxassetid://616157476"},
	["法师"] = {idle1 = "rbxassetid://707742142", idle2 = "rbxassetid://707855907", walk = "rbxassetid://707897309", run = "rbxassetid://707861613", jump = "rbxassetid://707853694", climb = "rbxassetid://707826056", fall = "rbxassetid://707829716"},
	["幽灵"] = {idle1 = "rbxassetid://616006778", idle2 = "rbxassetid://616008087", walk = "rbxassetid://616010382", run = "rbxassetid://616013216", jump = "rbxassetid://616008936", climb = "rbxassetid://616003713", fall = "rbxassetid://616005863"},
	["长者"] = {idle1 = "rbxassetid://845397899", idle2 = "rbxassetid://845400520", walk = "rbxassetid://845403856", run = "rbxassetid://845386501", jump = "rbxassetid://845398858", climb = "rbxassetid://845392038", fall = "rbxassetid://845396048"},
	["悬浮"] = {idle1 = "rbxassetid://616006778", idle2 = "rbxassetid://616008087", walk = "rbxassetid://616013216", run = "rbxassetid://616010382", jump = "rbxassetid://616008936", climb = "rbxassetid://616003713", fall = "rbxassetid://616005863"},
	["宇航员"] = {idle1 = "rbxassetid://891621366", idle2 = "rbxassetid://891633237", walk = "rbxassetid://891667138", run = "rbxassetid://891636393", jump = "rbxassetid://891627522", climb = "rbxassetid://891609353", fall = "rbxassetid://891617961"},
	["忍者"] = {idle1 = "rbxassetid://656117400", idle2 = "rbxassetid://656118341", walk = "rbxassetid://656121766", run = "rbxassetid://656118852", jump = "rbxassetid://656117878", climb = "rbxassetid://656114359", fall = "rbxassetid://656115606"},
	["狼人"] = {idle1 = "rbxassetid://1083195517", idle2 = "rbxassetid://1083214717", walk = "rbxassetid://1083178339", run = "rbxassetid://1083216690", jump = "rbxassetid://1083218792", climb = "rbxassetid://1083182000", fall = "rbxassetid://1083189019"},
	["卡通"] = {idle1 = "rbxassetid://742637544", idle2 = "rbxassetid://742638445", walk = "rbxassetid://742640026", run = "rbxassetid://742638842", jump = "rbxassetid://742637942", climb = "rbxassetid://742636889", fall = "rbxassetid://742637151"},
	["海盗"] = {idle1 = "rbxassetid://750781874", idle2 = "rbxassetid://750782770", walk = "rbxassetid://750785693", run = "rbxassetid://750783738", jump = "rbxassetid://750782230", climb = "rbxassetid://750779899", fall = "rbxassetid://750780242"},
	["潜行"] = {idle1 = "rbxassetid://1132473842", idle2 = "rbxassetid://1132477671", walk = "rbxassetid://1132510133", run = "rbxassetid://1132494274", jump = "rbxassetid://1132489853", climb = "rbxassetid://1132461372", fall = "rbxassetid://1132469004"},
	["玩具"] = {idle1 = "rbxassetid://782841498", idle2 = "rbxassetid://782845736", walk = "rbxassetid://782843345", run = "rbxassetid://782842708", jump = "rbxassetid://782847020", climb = "rbxassetid://782843869", fall = "rbxassetid://782846423"},
	["骑士"] = {idle1 = "rbxassetid://657595757", idle2 = "rbxassetid://657568135", walk = "rbxassetid://657552124", run = "rbxassetid://657564596", jump = "rbxassetid://658409194", climb = "rbxassetid://658360781", fall = "rbxassetid://657600338"},
	["自信"] = {idle1 = "rbxassetid://1069977950", idle2 = "rbxassetid://1069987858", walk = "rbxassetid://1070017263", run = "rbxassetid://1070001516", jump = "rbxassetid://1069984524", climb = "rbxassetid://1069946257", fall = "rbxassetid://1069973677"},
	["流行明星"] = {idle1 = "rbxassetid://1212900985", idle2 = "rbxassetid://1212900985", walk = "rbxassetid://1212980338", run = "rbxassetid://1212980348", jump = "rbxassetid://1212954642", climb = "rbxassetid://1213044953", fall = "rbxassetid://1212900995"},
	["公主"] = {idle1 = "rbxassetid://941003647", idle2 = "rbxassetid://941013098", walk = "rbxassetid://941028902", run = "rbxassetid://941015281", jump = "rbxassetid://941008832", climb = "rbxassetid://940996062", fall = "rbxassetid://941000007"},
	["牛仔"] = {idle1 = "rbxassetid://1014390418", idle2 = "rbxassetid://1014398616", walk = "rbxassetid://1014421541", run = "rbxassetid://1014401683", jump = "rbxassetid://1014394726", climb = "rbxassetid://1014380606", fall = "rbxassetid://1014384571"},
	["巡逻"] = {idle1 = "rbxassetid://1149612882", idle2 = "rbxassetid://1150842221", walk = "rbxassetid://1151231493", run = "rbxassetid://1150967949", jump = "rbxassetid://1150944216", climb = "rbxassetid://1148811837", fall = "rbxassetid://1148863382"},
}

function API.ListAnimations()
	local list = {}
	for k in pairs(AnimPacks) do
		table.insert(list, k)
	end
	table.sort(list)
	return list
end

function API.ApplyAnimation(name)
	local pack = AnimPacks[tostring(name)]
	if not pack then
		notify("应用失败", "没有这个动画包: " .. tostring(name), 3)
		return false
	end

	local ch = LP.Character
	if not ch then
		return false
	end
	local anim = ch:FindFirstChild("Animate")
	if not anim then
		notify("应用失败", "找不到 Animate，角色未加载完", 3)
		return false
	end

	local hum = ch:FindFirstChildOfClass("Humanoid")
	anim.Disabled = true

	local animator = hum and hum:FindFirstChildOfClass("Animator")
	if animator then
		for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
			track:Stop()
		end
	end

	local ok = pcall(function()
		anim.idle.Animation1.AnimationId = pack.idle1
		anim.idle.Animation2.AnimationId = pack.idle2
		anim.walk.WalkAnim.AnimationId = pack.walk
		anim.run.RunAnim.AnimationId = pack.run
		anim.jump.JumpAnim.AnimationId = pack.jump
		anim.climb.ClimbAnim.AnimationId = pack.climb
		anim.fall.FallAnim.AnimationId = pack.fall
	end)

	if hum then
		hum:ChangeState(Enum.HumanoidStateType.Jumping)
	end
	task.wait(0.1)
	anim.Disabled = false

	if ok then
		notify("动画已应用", tostring(name), 3)
	end
	return ok
end

--============================ 环绕 ============================--

function API.Orbit(name, on, radius, height, speed)
	if not on then
		state.orbit = false
		return false
	end

	local plr = Players:FindFirstChild(tostring(name))
	if not plr then
		notify("环绕", "目标玩家不存在", 3)
		return false
	end

	state.orbit = true
	local angle = 0
	local r = tonumber(radius) or 10
	local h = tonumber(height) or 0
	local sp = tonumber(speed) or 0.5

	spawnTracked(function()
		while state.orbit do
			task.wait()
			local root = getRoot()
			local tr = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
			if not (root and tr) then
				break
			end
			angle = angle + sp
			local pos = tr.Position + Vector3.new(math.cos(angle) * r, h, math.sin(angle) * r)
			root.CFrame = CFrame.lookAt(pos, Vector3.new(tr.Position.X, pos.Y, tr.Position.Z))
		end
		state.orbit = false
	end)

	return true
end

--============================ 自动攻击 ============================--

function API.AutoAttack(on)
	state.autoAttack = on and true or false
	if not state.autoAttack then
		return false
	end

	local boxSize = Vector3.new(10, 10, 10)

	spawnTracked(function()
		while state.autoAttack do
			RunService.Heartbeat:Wait()

			local ch = LP.Character
			local hum = ch and ch:FindFirstChildOfClass("Humanoid")
			if not (ch and hum) or hum.Health <= 0 then
				continue
			end

			local tool = ch:FindFirstChildWhichIsA("Tool")
			local handle = tool and tool:FindFirstChild("Handle")
			if not handle then
				continue
			end

			local chars = {}
			for _, p in ipairs(Players:GetPlayers()) do
				if p ~= LP and p.Character then
					table.insert(chars, p.Character)
				end
			end

			local overlap = OverlapParams.new()
			overlap.FilterType = Enum.RaycastFilterType.Include
			overlap.FilterDescendantsInstances = chars

			local parts = Workspace:GetPartBoundsInBox(handle.CFrame, handle.Size + boxSize, overlap)
			for _, part in ipairs(parts) do
				local model = part:FindFirstAncestorWhichIsA("Model")
				local targetHum = model and model:FindFirstChildWhichIsA("Humanoid")
				if targetHum and targetHum.Health > 0 then
					tool:Activate()
					pcall(function()
						firetouchinterest(handle, part, 1)
						firetouchinterest(handle, part, 0)
					end)
				end
			end
		end
	end)

	return true
end

--============================ 反虚空 ============================--

function API.AntiVoid(on)
	state.antivoid = on and true or false
	if state.antivoid then
		spawnTracked(function()
			local safePos = nil
			while state.antivoid do
				task.wait()
				local root = getRoot()
				if root then
					if root.Position.Y > 10 then
						safePos = root.CFrame
					elseif root.Position.Y < -100 and safePos then
						root.CFrame = safePos
					end
				end
			end
		end)
	end
	return state.antivoid
end

--============================ 背包 ============================--

function API.GrabBackpacks(on)
	state.grabBackpack = on and true or false
	local myBag = LP:FindFirstChildOfClass("Backpack")
	if state.grabBackpack and not myBag then
		notify("背包", "找不到自己的背包", 3)
		return false
	end

	if state.grabBackpack then
		spawnTracked(function()
			while state.grabBackpack do
				for _, plr in ipairs(Players:GetPlayers()) do
					local bag = plr:FindFirstChildOfClass("Backpack")
					if bag then
						for _, tool in ipairs(bag:GetChildren()) do
							if tool:IsA("Tool") then
								tool.Parent = LP:FindFirstChildOfClass("Backpack")
							end
						end
					end
					task.wait()
				end
				task.wait()
			end
		end)
	end

	return state.grabBackpack
end

--============================ 服务器跳转 ============================--

local function fetchServers(sortOrder)
	local url = string.format(
		"https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=%s&limit=100",
		game.PlaceId,
		sortOrder
	)
	local ok, res = pcall(function()
		return HttpService:JSONDecode(game:HttpGet(url))
	end)
	if ok and res and res.data then
		return res.data
	end
	return nil
end

local function hopTo(sortOrder, label)
	local list = fetchServers(sortOrder)
	if not list then
		notify("跳转失败", "获取服务器列表失败", 3)
		return false
	end

	for _, srv in ipairs(list) do
		if srv.playing < srv.maxPlayers then
			notify("服务器跳转", string.format("%s (%d/%d)", label, srv.playing, srv.maxPlayers), 2)
			task.wait(0.5)
			pcall(function()
				TeleportService:TeleportToPlaceInstance(game.PlaceId, srv.id, LP)
			end)
			return true
		end
	end

	notify("跳转失败", "没有可加入的服务器", 3)
	return false
end

function API.JoinLowestServer()
	return hopTo("Asc", "正在加入人少服务器")
end

function API.JoinFullestServer()
	return hopTo("Desc", "正在加入人多服务器")
end

function API.Rejoin()
	pcall(function()
		TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LP)
	end)
end

--============================ 界面翻译 ============================--

local translateCache = {}

local function looksEnglish(s)
	local letters, total = 0, 0
	for i = 1, #s do
		local b = string.byte(s, i)
		if b then
			total = total + 1
			if (b >= 65 and b <= 90) or (b >= 97 and b <= 122) then
				letters = letters + 1
			end
		end
	end
	if total == 0 then
		return false
	end
	return letters / total > 0.5
end

local function translateOnce(text)
	if not text or #text < 2 then
		return nil
	end
	if translateCache[text] then
		return translateCache[text]
	end
	local ok, res = pcall(function()
		local url = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=zh-CN&dt=t&q="
			.. HttpService:UrlEncode(text)
		local body = HttpService:JSONDecode(game:HttpGet(url))
		return body[1][1][1]
	end)
	if ok and res then
		translateCache[text] = res
		return res
	end
	return nil
end

function API.TranslateUI(on)
	state.translation = on and true or false
	if not state.translation then
		return false
	end

	spawnTracked(function()
		local playerGui = LP:WaitForChild("PlayerGui")
		while state.translation do
			local speed = math.clamp(tonumber(API.Config and API.Config.TranslateSpeed or 1) or 1, 1, 5)
			task.wait(1 / speed)
			pcall(function()
				local root = (Patch.GetGui and Patch.GetGui()) or playerGui
				for _, d in ipairs(root:GetDescendants()) do
					if d:IsA("TextLabel") or d:IsA("TextButton") then
						local txt = d.Text
						if txt and #txt >= 2 and looksEnglish(txt) then
							local tr = translateOnce(txt)
							if tr and tr ~= txt then
								d.Text = tr
							end
						end
					end
				end
			end)
		end
	end)

	return true
end

--============================ ③-2 补齐后端 ============================--

API.Ext = {
	RunSpeed = 50,
	TranslateSpeed = 2,
	LoopInterval = 0.8,
}

state.loopTeleport = false
state.loopFling = false
state.fastRun = false
state.antiFling = false
state.joinNotify = false
state.aim = false
state.bypassFly = false
state.viewPlayer = false

--==================== 胶囊位置存盘 ====================--

local PILL_DIR = "ChickenBeachChickenTech_Data"
local PILL_POS_FILE = PILL_DIR .. "/pill_pos.txt"

function Patch.SavePillPosition()
	if type(writefile) ~= "function" then
		return false
	end
	pcall(function()
		if type(isfolder) == "function" and not isfolder(PILL_DIR) then
			makefolder(PILL_DIR)
		end
		writefile(PILL_POS_FILE, tostring(Patch.Config.PillX or 0) .. "," .. tostring(Patch.Config.PillY or 0))
	end)
	return true
end

local function loadPillPosition()
	if type(isfile) ~= "function" or type(readfile) ~= "function" then
		return
	end
	local ok, data = pcall(function()
		if isfile(PILL_POS_FILE) then
			return readfile(PILL_POS_FILE)
		end
		return nil
	end)
	if not (ok and type(data) == "string") then
		return
	end
	local x, y = data:match("(-?%d+)[,;%s]+(-?%d+)")
	if x and y then
		Patch.Config.PillX = tonumber(x)
		Patch.Config.PillY = tonumber(y)
	end
end

loadPillPosition()

--==================== 外链脚本执行 ====================--

function API.RunRemote(url, label)
	if type(url) ~= "string" or url == "" then
		return false
	end
	local ok, err = pcall(function()
		local code = game:HttpGet(url, true)
		local fn = loadstring(code)
		if type(fn) ~= "function" then
			error("loadstring 失败")
		end
		fn()
	end)
	if ok then
		notify("已执行", tostring(label or "脚本"), 2)
		return true
	end
	notify("执行失败", tostring(label or "脚本") .. "\n" .. tostring(err), 6)
	return false
end

--==================== 战斗力小工具 ====================--

function API.KillAll()
	local n = 0
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LP and p.Character then
			local hum = p.Character:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.Health = 0
				n = n + 1
			end
		end
	end
	notify("击杀所有人", "本地处理 " .. n .. " 个", 3)
	return n
end

function API.Suicide()
	local hum = getHum()
	if hum then
		hum.Health = 0
		notify("自杀", "本地效果", 2)
		return true
	end
	return false
end

--==================== 快速跑步 ====================--

function API.SetRunSpeed(v)
	API.Ext.RunSpeed = math.clamp(tonumber(v) or 50, 5, 500)
	return API.Ext.RunSpeed
end

function API.FastRun(on)
	on = on and true or false
	if on == state.fastRun then
		return state.fastRun
	end
	state.fastRun = on
	if on then
		spawnTracked(function()
			while state.fastRun do
				RunService.Heartbeat:Wait()
				local ch = LP.Character
				local hum = ch and ch:FindFirstChildOfClass("Humanoid")
				if hum and hum.MoveDirection.Magnitude > 0 then
					pcall(function()
						ch:TranslateBy(hum.MoveDirection * (API.Ext.RunSpeed / 0.5))
					end)
				end
			end
		end)
	end
	return state.fastRun
end

--==================== 防甩飞 ====================--

function API.AntiFling(on)
	on = on and true or false
	state.antiFling = on
	if on then
		spawnTracked(function()
			while state.antiFling do
				task.wait(0.3)
				for _, p in ipairs(Players:GetPlayers()) do
					if p.Character then
						for _, d in ipairs(p.Character:GetDescendants()) do
							if d:IsA("BasePart") then
								d.CanCollide = false
							end
						end
					end
				end
			end
		end)
	else
		for _, p in ipairs(Players:GetPlayers()) do
			if p.Character then
				for _, d in ipairs(p.Character:GetDescendants()) do
					if d:IsA("BasePart") then
						d.CanCollide = true
					end
				end
			end
		end
	end
	return state.antiFling
end

--==================== 绕过飞行（屏蔽 ForceSelfDamage） ====================--

function API.BypassFly(on)
	on = on and true or false
	if state.bypassFly == on then
		return state.bypassFly
	end

	if on then
		if
			type(getrawmetatable) ~= "function"
			or type(setreadonly) ~= "function"
			or type(newcclosure) ~= "function"
			or type(getnamecallmethod) ~= "function"
		then
			notify("绕过飞行", "当前执行器不支持 metatable 操作", 4)
			return false
		end

		local ok = pcall(function()
			local mt = getrawmetatable(game)
			setreadonly(mt, false)
			local old = mt.__namecall
			local oldC = select(1, old) or old
			mt.__namecall = newcclosure(function(self, ...)
				if getnamecallmethod() == "FireServer" and tostring(self) == "ForceSelfDamage" then
					return nil
				end
				return old(self, ...)
			end)
			API._bypassOldNamecall = old
			API._bypassMT = mt
		end)

		if not ok then
			notify("绕过飞行", "挂载 namecall 失败", 4)
			return false
		end

		state.bypassFly = true
	else
		state.bypassFly = false
		pcall(function()
			if API._bypassMT and API._bypassOldNamecall then
				API._bypassMT.__namecall = API._bypassOldNamecall
				setreadonly(API._bypassMT, true)
			end
		end)
	end

	return state.bypassFly
end

--==================== 玩家进出通知 ====================--

Players.PlayerAdded:Connect(function(p)
	if not state.joinNotify then
		return
	end
	notify("玩家进入", p.DisplayName .. " (@" .. p.Name .. ")", 5)
end)

Players.PlayerRemoving:Connect(function(p)
	if not state.joinNotify then
		return
	end
	notify("玩家退出", p.DisplayName .. " (@" .. p.Name .. ")", 5)
end)

function API.JoinNotify(on)
	state.joinNotify = on and true or false
	return state.joinNotify
end

--==================== 查看 / 自瞄 ====================--

function API.ViewPlayer(on, name)
	local cam = Workspace.CurrentCamera
	if not cam then
		return false
	end

	if not on then
		state.viewPlayer = false
		local hum = getHum()
		if hum then
			cam.CameraSubject = hum
		end
		return false
	end

	local plr = Players:FindFirstChild(tostring(name or ""))
	local hum = plr and plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
	if not hum then
		notify("查看玩家", "目标不存在或未加载", 3)
		return false
	end

	state.viewPlayer = true
	cam.CameraSubject = hum
	return true
end

function API.AimAt(name, on)
	on = on and true or false
	if not on then
		state.aim = false
		return false
	end

	local plr = Players:FindFirstChild(tostring(name or ""))
	if not plr then
		notify("自瞄", "目标不存在", 3)
		return false
	end

	state.aim = true
	spawnTracked(function()
		while state.aim do
			local cam = Workspace.CurrentCamera
			local tr = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
			if not (cam and tr) then
				break
			end
			local pos = cam.CFrame.Position
			local dir = tr.Position - pos
			if dir.Magnitude > 0.1 then
				cam.CFrame = CFrame.new(pos, pos + dir.Unit)
			end
			RunService.RenderStepped:Wait()
		end
		state.aim = false
	end)
	return true
end

--==================== 循环传送 ====================--

local teleToken = 0

function API.StopLoopTeleport()
	state.loopTeleport = false
	teleToken = teleToken + 1
	return true
end

function API.LoopTeleport(mode, name, offset)
	API.StopLoopTeleport()
	task.wait(0.05)

	local plr = Players:FindFirstChild(tostring(name or ""))
	if not plr then
		notify("循环传送", "目标不存在", 3)
		return false
	end

	mode = tostring(mode or "beside")
	local off = tonumber(offset) or 3
	state.loopTeleport = true
	local token = teleToken

	spawnTracked(function()
		while state.loopTeleport and token == teleToken do
			RunService.Heartbeat:Wait()
			local root = getRoot()
			local tr = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
			if not (root and tr) then
				break
			end

			if mode == "above" then
				root.CFrame = tr.CFrame * CFrame.new(0, off, 0)
			elseif mode == "front" then
				local pos = (tr.CFrame * CFrame.new(0, 0, -off)).Position
				root.CFrame = CFrame.new(pos, tr.Position)
			elseif mode == "behind" then
				local pos = (tr.CFrame * CFrame.new(0, 0, off)).Position
				root.CFrame = CFrame.new(pos, tr.Position - tr.CFrame.LookVector)
			else
				root.CFrame = tr.CFrame + Vector3.new(0, off, 0)
			end
		end
		if token == teleToken then
			state.loopTeleport = false
		end
	end)

	return true
end

--==================== 循环甩飞 ====================--

local flingToken = 0

function API.StopLoopFling()
	state.loopFling = false
	flingToken = flingToken + 1
	return true
end

function API.LoopFling(name, interval)
	API.StopLoopFling()
	task.wait(0.05)

	if not Players:FindFirstChild(tostring(name or "")) then
		notify("循环甩飞", "目标不存在", 3)
		return false
	end

	state.loopFling = true
	local token = flingToken
	spawnTracked(function()
		while state.loopFling and token == flingToken do
			local plr = Players:FindFirstChild(tostring(name))
			if plr then
				pcall(API.Fling, plr.Name)
			else
				break
			end
			task.wait(interval or API.Ext.LoopInterval)
		end
		if token == flingToken then
			state.loopFling = false
		end
	end)

	return true
end

--==================== r6 饰品级伪装 ====================--

local APPAREL_CLASSES = {
	Accessory = true,
	Shirt = true,
	Pants = true,
	ShirtGraphic = true,
	BodyColors = true,
	CharacterMesh = true,
}

local ATTACH_BODY = {
	HatAttachment = "Head",
	HairAttachment = "Head",
	FaceFrontAttachment = "Head",
	FaceCenterAttachment = "Head",
	FaceBackAttachment = "Head",
	NeckAttachment = "UpperTorso",
	ShoulderAttachment = "UpperTorso",
	BackAttachment = "UpperTorso",
	WaistCenterAttachment = "LowerTorso",
	WaistFrontAttachment = "LowerTorso",
	WaistBackAttachment = "LowerTorso",
	LeftCollarAttachment = "UpperTorso",
	RightCollarAttachment = "UpperTorso",
	FrontAttachment = "UpperTorso",
}

local function isApparel(inst)
	return inst.ClassName and APPAREL_CLASSES[inst.ClassName] or false
end

local function pickBodyPart(character, name)
	local part = name and character:FindFirstChild(name)
	if part then
		return part
	end
	return character:FindFirstChild("UpperTorso")
		or character:FindFirstChild("Torso")
		or character:FindFirstChild("Head")
end

local function pickAttachment(bodyPart, srcName)
	local candidates = {srcName}
	if srcName == "HatAttachment" then
		table.insert(candidates, "HairAttachment")
	elseif srcName == "HairAttachment" then
		table.insert(candidates, "HatAttachment")
	end
	for _, n in ipairs(candidates) do
		if n then
			local a = bodyPart:FindFirstChild(n)
			if a and a:IsA("Attachment") then
				return a
			end
		end
	end
	for _, c in ipairs(bodyPart:GetChildren()) do
		if c:IsA("Attachment") then
			return c
		end
	end
	return nil
end

local function weldAccessory(accessory, character)
	if not accessory:FindFirstChild("Handle") then
		return false
	end

	local srcAttach
	for _, d in ipairs(accessory:GetDescendants()) do
		if d:IsA("Attachment") then
			srcAttach = d
			break
		end
	end

	local bodyName = srcAttach and ATTACH_BODY[srcAttach.Name]
	local bodyPart = pickBodyPart(character, bodyName or "Head")
	if not bodyPart then
		return false
	end

	local clone = accessory:Clone()
	clone.Parent = character

	local handle = clone:FindFirstChild("Handle")
	if not handle then
		clone:Destroy()
		return false
	end

	for _, c in ipairs(handle:GetChildren()) do
		if c:IsA("Weld") or c:IsA("WeldConstraint") then
			c:Destroy()
		end
	end

	local dstAttach
	for _, d in ipairs(clone:GetDescendants()) do
		if d:IsA("Attachment") then
			dstAttach = d
			break
		end
	end

	local targetAttach = dstAttach and pickAttachment(bodyPart, dstAttach.Name)
	if not targetAttach then
		clone:Destroy()
		return false
	end

	if dstAttach then
		handle.CFrame = bodyPart.CFrame * targetAttach.CFrame * dstAttach.CFrame:Inverse()
	end

	local weld = Instance.new("Weld")
	weld.Name = "AccessoryWeld"
	weld.Part0 = handle
	weld.Part1 = bodyPart
	weld.C0 = dstAttach and dstAttach.CFrame or CFrame.new()
	weld.C1 = targetAttach.CFrame
	weld.Parent = handle

	return true
end

local function copyBodyScale(hum, targetHum)
	if not (hum and targetHum) then
		return
	end
	for _, n in ipairs({"BodyDepthScale", "BodyHeightScale", "BodyWidthScale", "BodyProportionScale", "HeadScale"}) do
		local src = targetHum:FindFirstChild(n)
		local dst = hum:FindFirstChild(n)
		if src and dst then
			dst.Value = src.Value
		end
	end
end

function API.DisguiseR6(name)
	local plr = Players:FindFirstChild(tostring(name or ""))
	local myChar = LP.Character
	if not (plr and plr.Character and myChar) then
		notify("伪装失败", "目标或自己角色未加载", 3)
		return false
	end

	local myHum = myChar:FindFirstChildOfClass("Humanoid")
	local targetHum = plr.Character:FindFirstChildOfClass("Humanoid")
	if not (myHum and targetHum) then
		notify("伪装失败", "缺少 Humanoid", 3)
		return false
	end

	copyBodyScale(myHum, targetHum)

	local backup = {}
	for _, c in ipairs(myChar:GetChildren()) do
		if isApparel(c) then
			table.insert(backup, c:Clone())
		end
	end
	for _, c in ipairs(myChar:GetChildren()) do
		if isApparel(c) then
			c:Destroy()
		end
	end

	local okCount, failCount = 0, 0
	for _, c in ipairs(plr.Character:GetChildren()) do
		if isApparel(c) then
			if c:IsA("Accessory") then
				local ok = pcall(weldAccessory, c, myChar)
				if ok then
					okCount = okCount + 1
				else
					failCount = failCount + 1
				end
			else
				local ok = pcall(function()
					c:Clone().Parent = myChar
				end)
				if ok then
					okCount = okCount + 1
				else
					failCount = failCount + 1
				end
			end
		end
	end

	if okCount == 0 then
		for _, c in ipairs(backup) do
			c.Parent = myChar
		end
		notify("伪装失败", "目标饰品全部挂不上，已还原", 4)
		return false
	end

	notify("伪装完成", string.format("复制 %d，跳过 %d", okCount, failCount), 3)
	return true
end

function API.Shutdown()
	local dead = true
	for k, v in pairs(state) do
		if type(v) == "boolean" then
			state[k] = false
		end
	end
	pcall(function()
		if flyBV then
			flyBV:Destroy()
		end
		if flyBG then
			flyBG:Destroy()
		end
	end)
	pcall(function()
		if trailObj then
			trailObj:Destroy()
			trailObj = nil
		end
	end)
	pcall(function()
		local ch = LP.Character
		if ch then
			for _, d in ipairs(ch:GetDescendants()) do
				if d.Name == "ChuangTrail" or d.Name == "ChuangFlyVel" or d.Name == "ChuangFlyGyro" then
					d:Destroy()
				end
			end
		end
	end)
	pcall(function()
		local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.WalkSpeed = state.baseSpeed or hum.WalkSpeed
			if state.baseUseJumpPower then
				hum.UseJumpPower = true
				hum.JumpPower = state.baseJumpPower or hum.JumpPower
			else
				hum.UseJumpPower = false
				hum.JumpHeight = state.baseJumpHeight or hum.JumpHeight
			end
		end
	end)
	pcall(function()
		Workspace.Gravity = 196.2
		Workspace.FallenPartsDestroyHeight = -500
		if Workspace.CurrentCamera then
			Workspace.CurrentCamera.FieldOfView = 70
		end
	end)
	return dead
end

--============================ ④ 搭 Fluent 界面 ============================--

local Gui = {Window = nil, Tabs = {}, Controls = {}}
API.UI = Gui
API.Config = {
	TeleOffset = 3,
	OrbitRadius = 10,
	OrbitHeight = 0,
	OrbitSpeed = 0.6,
	SpinSpeed = 10,
	TrailColor = "彩虹",
	WalkSpeed = 16,
	SpeedOn = false,
	JumpPower = 50,
	JumpOn = false,
	Gravity = 196.2,
	GravityOn = false,
	TranslateSpeed = 2,
	KickReason = "你已退出游戏",
	SideOffset = 0,
	UpOffset = 3,
	LoopFront = 3,
	LoopAbove = 4,
	LoopBehind = 4,
}

local target = { name = nil, player = nil }

local function playerNames()
	local list = {}
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LP then
			table.insert(list, p.Name)
		end
	end
	if #list == 0 then
		table.insert(list, "无在线玩家")
	end
	return list
end

local function refreshTarget()
	if Gui.Controls.TargetDropdown and Gui.Controls.TargetDropdown.SetValues then
		Gui.Controls.TargetDropdown:SetValues(playerNames())
	end
end

local function resolveTarget()
	if not target.name or target.name == "无在线玩家" then
		API.Notify("提示", "先在「甩飞与传送」里选一个玩家", 3)
		return nil
	end
	local p = Players:FindFirstChild(target.name)
	if not p then
		API.Notify("提示", "玩家已离开", 3)
		return nil
	end
	return p
end

local function mobileIcon()
	return {Image = "rbxassetid://71024334944141", ImageRectOffset = Vector2.zero, ImageRectSize = Vector2.zero}
end

local UISvc = game:GetService("UserInputService")
local camera = workspace.CurrentCamera

local function deviceIsMobile()
	if not UISvc.TouchEnabled then
		return false
	end
	if UISvc.MouseEnabled then
		local ok, mobile = pcall(function()
			return version():find("^2.") == 1
		end)
		return ok and mobile == true
	end
	return true
end
local isMobileUI = deviceIsMobile()

local function metrics()
	local vp = camera.ViewportSize
	local margin = 8
	local topInset = guiInsetTop() + 8
	local availW = math.max(260, vp.X - margin * 2)
	local availH = math.max(220, vp.Y - topInset - 16)
	local w, h = defaultSize(vp, availW, availH)
	w, h = clampSaved(w, h, availW, availH)
	local tw = math.clamp(math.floor(w * 0.30), 104, math.min(132, math.floor(w * 0.36)))
	return vp, w, h, tw
end

local vp0, winW, winH, tabW = metrics()

pcall(function()
	BootPanel.Set("创建窗口", 0.68)
end)

--============================ 界面主题（Fluent 原生调色板） ============================--
-- 只调 Fluent 自己的 SetTheme：整套配色由库派生，不碰任何单个元素的颜色。
local function readSavedTheme()
	local name
	pcall(function()
		if type(isfile) == "function" and type(readfile) == "function" and isfile(THEME_PATH) then
			local t = readfile(THEME_PATH)
			if type(t) == "string" then
				name = t:match("^%s*(.-)%s*$")
			end
		end
	end)
	if name == "light" then
		name = "Light"
	elseif name == "dark" then
		name = "Dark"
	end
	if not name or name == "" then
		return "Light"
	end
	return name
end

local function saveThemeName(name)
	pcall(function()
		if type(writefile) ~= "function" then
			return
		end
		if type(isfolder) == "function" and type(makefolder) == "function" and not isfolder(UI_DIR) then
			makefolder(UI_DIR)
		end
		writefile(THEME_PATH, name)
	end)
end

Patch.Config.Theme = readSavedTheme()
Patch.Config.DarkMode = not LIGHT_THEMES[Patch.Config.Theme]

local Window = Fluent:CreateWindow({
	Title = "窗脚本",
	SubTitle = "依旧培根头",
	TabWidth = tabW,
	Size = UDim2.fromOffset(winW, winH),
	MinSize = Vector2.new(280, 230),
	Acrylic = (tonumber(UICfg.acrylic) or 0) == 1,
	Transparency = isMobileUI and 0.16 or 0.3,
	Theme = Patch.Config.Theme or "Light",
	MinimizeKey = Enum.KeyCode.RightControl,
	Search = true,
})

Gui.Window = Window
WinRef = Window
lastWindow = Window

--==================== 右下角缩放手柄 ====================--
-- FluentPlus 的手柄是 20×20、位置 (1,-20,1,-2)，几乎整块在窗口外，手机捏不到。
local function fixResizeGrip()
	local grip
	for _, d in ipairs(Window.Root:GetChildren()) do
		if
			d:IsA("Frame")
			and d.BackgroundTransparency == 1
			and d.Size.X.Offset == 20
			and d.Size.Y.Offset == 20
			and d.Position.X.Scale == 1
			and d.Position.X.Offset == -20
		then
			grip = d
			break
		end
	end
	if not grip then
		return false
	end

	grip.Size = UDim2.fromOffset(36, 36)
	grip.Position = UDim2.new(1, -40, 1, -40)
	grip.Active = true
	grip.ZIndex = 900

	if not grip:FindFirstChild("ChuangGripMark") then
		local mark = Instance.new("Frame")
		mark.Name = "ChuangGripMark"
		mark.AnchorPoint = Vector2.new(1, 1)
		mark.Position = UDim2.new(1, -3, 1, -3)
		mark.Size = UDim2.fromOffset(14, 14)
		mark.BackgroundColor3 = Color3.fromRGB(150, 155, 170)
		mark.BackgroundTransparency = 0.55
		mark.BorderSizePixel = 0
		mark.ZIndex = 901
		mark.Parent = grip

		local c = Instance.new("UICorner")
		c.CornerRadius = UDim.new(1, 0)
		c.Parent = mark

		local st = Instance.new("UIStroke")
		st.Thickness = 1
		st.Color = Color3.fromRGB(150, 155, 170)
		st.Transparency = 0.35
		st.Parent = mark
	end
	return true
end

pcall(function()
	task.defer(function()
		pcall(fixResizeGrip)
	end)
end)

--==================== 标题栏两排（2.9 形式：粗标题 + 淡署名） ====================--
-- FluentPlus 把 标题 / 副标题 塞在同一行（Horizontal UIListLayout、都 12px、Regular），
-- 出来就是「窗脚本 依旧培根头」并排一行。2.9 是两排：14px 粗标题在上，11px 淡署名在下。
-- 这里不改库源码（TextSize/FontWeight 那串字符串在库里遍地都是，打补丁必失配），
-- 改成按结构重排：两个 Label 挪进竖排容器，图标留在左侧，旧横排负责把「图标 + 竖排」摆好。
local WIN_TITLE = "窗脚本"
local WIN_SUBTITLE = "依旧培根头"

local function fixTitleBar()
	if Patch.Config.NativeLook then
		return false
	end
	local bar = Window.TitleBar and Window.TitleBar.Frame
	if not bar then
		return false
	end

	local inner
	for _, d in ipairs(bar:GetChildren()) do
		if d:IsA("Frame") and d:FindFirstChildWhichIsA("UIListLayout") then
			inner = d
			break
		end
	end
	if not inner or inner:FindFirstChild("TitleHolder") then
		return false
	end

	local title, subtitle, icon
	for _, d in ipairs(inner:GetChildren()) do
		if d:IsA("TextLabel") then
			if d.Text == WIN_TITLE then
				title = d
			elseif d.Text == WIN_SUBTITLE then
				subtitle = d
			end
		elseif d:IsA("ImageLabel") then
			icon = d
		end
	end
	if not title then
		return false
	end

	-- 竖排容器：旧横排会把它摆在图标右侧
	local holder = Instance.new("Frame")
	holder.Name = "TitleHolder"
	holder.BackgroundTransparency = 1
	holder.BorderSizePixel = 0
	holder.Size = icon and UDim2.new(1, -26, 1, 0) or UDim2.new(1, 0, 1, 0)
	holder.LayoutOrder = icon and 2 or 1
	holder.Parent = inner

	local stack = Instance.new("UIListLayout")
	stack.FillDirection = Enum.FillDirection.Vertical
	stack.Padding = UDim.new(0, 1)
	stack.SortOrder = Enum.SortOrder.LayoutOrder
	stack.HorizontalAlignment = Enum.HorizontalAlignment.Left
	stack.VerticalAlignment = Enum.VerticalAlignment.Center
	stack.Parent = holder

	if icon then
		icon.LayoutOrder = 1
	end

	-- 第一排：标题
	task.defer(function()
		pcall(function()
			title.Parent = holder
			title.LayoutOrder = 1
			title.AutomaticSize = Enum.AutomaticSize.None
			title.Size = UDim2.new(1, 0, 0, 16)
			title.TextSize = 14
			title.FontFace = Font.new(
				"rbxasset://fonts/families/GothamSSm.json",
				Enum.FontWeight.Bold,
				Enum.FontStyle.Normal
			)
			title.TextXAlignment = Enum.TextXAlignment.Left
			title.TextYAlignment = Enum.TextYAlignment.Center
			title.TextTransparency = 0
		end)

		-- 第二排：署名
		if subtitle then
			pcall(function()
				subtitle.Parent = holder
				subtitle.LayoutOrder = 2
				subtitle.AutomaticSize = Enum.AutomaticSize.None
				subtitle.Size = UDim2.new(1, 0, 0, 13)
				subtitle.TextSize = 11
				subtitle.TextTransparency = 0.45
				subtitle.TextXAlignment = Enum.TextXAlignment.Left
				subtitle.TextYAlignment = Enum.TextYAlignment.Center
			end)
		end
	end)

	return true
end

task.defer(function()
	pcall(fixTitleBar)
end)

--==================== 窗口外柔光阴影（取自 2.9 的设计） ====================--
-- FluentPlus 没有窗口投影，卡片和游戏场景直接糊在一起、边界发虚；
-- 2.9 是一张 9-slice 阴影图垫在窗口后面。这里按主题取色：
--   浅色 蓝灰 (150,158,180) 0.82  —— 纯黑在浅色底上会显脏
--   深色 纯黑 (0,0,0) 0.45      —— 灰紫在深色卡片边缘会发紫边
local rootShadow
local function shadowPalette()
	if Patch.Config.DarkMode then
		return Color3.fromRGB(0, 0, 0), 0.45
	end
	return Color3.fromRGB(150, 158, 180), 0.82
end

local function syncRootShadow()
	if not (rootShadow and rootShadow.Parent) then
		return
	end
	local root = Window.Root
	if not root then
		return
	end
	local rel = root.AbsolutePosition - rootShadow.Parent.AbsolutePosition
	local sz = root.AbsoluteSize
	rootShadow.Position = UDim2.fromOffset(math.floor(rel.X - 10), math.floor(rel.Y - 8))
	rootShadow.Size = UDim2.fromOffset(math.floor(sz.X + 20), math.floor(sz.Y + 16))
end

local function applyRootShadow()
	if not rootShadow then
		return
	end
	local c, t = shadowPalette()
	rootShadow.ImageColor3 = c
	rootShadow.ImageTransparency = t
	rootShadow.Visible = Patch.Config.WindowShadow and not Patch.Config.Lite
	syncRootShadow()
end

task.defer(function()
	pcall(function()
		if Patch.Config.NativeLook then
			return
		end
		local root = Window.Root
		rootShadow = Instance.new("ImageLabel")
		rootShadow.Name = "ChuangRootShadow"
		rootShadow.BackgroundTransparency = 1
		rootShadow.Image = "rbxassetid://6014261993"
		rootShadow.ScaleType = Enum.ScaleType.Slice
		rootShadow.SliceCenter = Rect.new(49, 49, 450, 450)
		rootShadow.ZIndex = math.max(0, (root.ZIndex or 1) - 1)
		rootShadow.Parent = root.Parent
		applyRootShadow()

		for _, prop in ipairs({ "Position", "Size", "AbsoluteSize" }) do
			pcall(function()
				root:GetPropertyChangedSignal(prop):Connect(syncRootShadow)
			end)
		end
		local cam = workspace.CurrentCamera
		if cam then
			cam:GetPropertyChangedSignal("ViewportSize"):Connect(function()
				task.delay(0.12, syncRootShadow)
			end)
		end

		-- 主题切换后重新取色：把 applyTheme 包一层，切完补一次阴影配色
		local baseApply = Patch.ApplyTheme
		if type(baseApply) == "function" then
			Patch.ApplyTheme = function(name)
				baseApply(name)
				pcall(applyRootShadow)
			end
		end
	end)
end)

-- 搜索框：占位汉化 + 放大镜从右边挪到左边
-- FluentPlus 里图标是 Position = UDim2.new(1, -13, 0.5, 0)、Anchor 0.5 → 死挂在右端，
-- 而文本框是 (0, 8) / Size 1,-36 左对齐，两边空得不对等。
-- 这里把图标贴到左端 10px，文本框整体右移，右侧留 10px 对称内边距。
task.delay(0.6, function()
	if Patch.Config.NativeLook then
		return
	end
	pcall(function()
		local box
		for _, d in ipairs(Window.Root:GetDescendants()) do
			if d:IsA("TextBox") and d.PlaceholderText == "Search..." then
				d.PlaceholderText = "搜索…"
				box = d
			end
		end
		if not box then
			return
		end

		local frame = box.Parent
		local icon
		if frame then
			for _, c in ipairs(frame:GetChildren()) do
				if c:IsA("ImageLabel") then
					icon = c
					break
				end
			end
		end
		if not icon then
			return
		end

		icon.AnchorPoint = Vector2.new(0, 0.5)
		icon.Position = UDim2.new(0, 10, 0.5, 0)
		box.TextXAlignment = Enum.TextXAlignment.Left
		box.Position = UDim2.new(0, 32, 0, 0)
		box.Size = UDim2.new(1, -42, 1, 0)
	end)
end)

--==================== FluentPlus → Renewed 风格适配层 ====================--
-- 页面代码全是 tab:Toggle(name, cfg) / AddSection(tab, title) 这套写法，
-- 这里把 FluentPlus 的 AddToggle / AddSection 包成同名方法，137 个控件零改动。

Window.Tab = function(self, cfg)
	return self:AddTab(cfg)
end

local function wrapTab(rawTab)
	if not rawTab then
		return rawTab
	end
	if rawTab.__fpWrapped then
		return rawTab
	end

	local proxy = { __fpWrapped = true }

	local elementMap = {
		Toggle = "AddToggle",
		Slider = "AddSlider",
		Dropdown = "AddDropdown",
		Input = "AddInput",
		Colorpicker = "AddColorpicker",
		Keybind = "AddKeybind",
	}

	return setmetatable(proxy, {
		__index = function(_, key)
			if elementMap[key] then
				return function(_, name, cfg)
					local tab = rawTab
					local fn = tab[elementMap[key]]
					if not fn then
						return nil
					end
					return fn(tab, name, cfg)
				end
			elseif key == "Button" then
				return function(_, cfg)
					return rawTab:AddButton(cfg)
				end
			elseif key == "Paragraph" then
				return function(_, name, cfg)
					cfg = cfg or {}
					return rawTab:AddParagraph({
						Title = cfg.Title or name,
						Content = cfg.Content or cfg.Value,
						Icon = cfg.Icon,
					})
				end
			elseif key == "Section" then
				return function(_, title, icon)
					return rawTab:AddSection(title, icon)
				end
			end
			return rawTab[key]
		end,
	})
end

--==================== UI 基线说明 ====================--
-- 从这版起 UI 由 Fluent 原生排版负责：不重排标题栏、不压页签行高、不改字号、
-- 不画紫底 selector、不加窗口阴影。要改外观先谈方案，别再叠补丁。

--==================== 布局说明 ====================--
-- 重编后不再手工摆标题栏/页签/容器，也不给 selector 上色、不加窗口阴影。
-- 位置与大小统一由上面的 fitWindow / scheduleFit 负责。

--==================== 中文替换 ====================--

local EN_CN = {
	["Close"] = "关闭",
	["Yes"] = "是",
	["No"] = "否",
	["Dialog"] = "提示",
	["Interface"] = "界面",
	["Button"] = "按钮",
	["Tab"] = "通用",
	["Search..."] = "搜索…",
	["Made with Fluent Renewed"] = "依旧培根头",
	["Are you sure you want to unload the interface?"] = "确定要关闭界面吗？",
}

local function localizeObject(obj)
	if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
		local t = obj.Text
		if type(t) == "string" then
			if EN_CN[t] then
				obj.Text = EN_CN[t]
				return
			end
			local key = t:match("^Press (.+) to toggle the interface%.$")
			if key then
				obj.Text = "按 " .. key .. " 收起/展开界面"
			end
		end
	end
end

--==================== 主题切换 ====================--

-- 换成 Fluent 库里的某套主题；只改主题名，不刷任何单元素颜色
function Patch.ApplyTheme(name)
	if type(name) == "boolean" then
		name = name and "Dark" or "Light"
	end
	name = tostring(name or "Light")
	name = FP_THEME_ALIAS[name] or name
	Patch.Config.Theme = name
	Patch.Config.DarkMode = not LIGHT_THEMES[name]
	saveThemeName(name)

	local ok = pcall(function()
		Fluent:SetTheme(name)
	end)
	if not ok then
		-- 名字不在库的列表里就退回深浅两套，别把界面留白
		pcall(function()
			Fluent:SetTheme(Patch.Config.DarkMode and "Dark" or "Light")
		end)
	end
	pcall(function()
		Patch.SetPillStyle(Patch.Config.DarkMode and "dark" or "light")
	end)
	if Patch.AfterTheme then
		pcall(Patch.AfterTheme)
	end
	return name
end

-- FluentPlus 的标题栏结构不一定带 CloseButton，取不到就跳过，别让整段挂掉
local _closeBtn = Window.TitleBar and Window.TitleBar.CloseButton
if _closeBtn then
		_closeBtn.Callback = function()
		Window:Dialog({
			Title = "关闭",
			Content = "确定要关闭界面吗？",
			Buttons = {
				{
					Title = "是",
					Callback = function()
						Patch.Exit()
					end,
				},
				{Title = "否", Callback = function() end},
			},
		})
	end
end

local dialogScrim

local function ensureDialogScrim()
	if dialogScrim and dialogScrim.Parent then
		return dialogScrim
	end
	local scrim = Instance.new("Frame")
	scrim.Name = "ChuangDialogScrim"
	scrim.Size = UDim2.fromScale(1, 1)
	scrim.Position = UDim2.fromOffset(0, 0)
	scrim.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	scrim.BackgroundTransparency = 0.5
	scrim.BorderSizePixel = 0
	scrim.ZIndex = 1990
	scrim.Active = true
	scrim.Visible = false
	scrim.Parent = Window.Root
	dialogScrim = scrim
	return scrim
end

local origDialog = Window.Dialog
Window.Dialog = function(self, cfg)
	-- 点任意按钮后遮罩立刻撤，不等 Fluent 自己收尾
	if cfg and type(cfg.Buttons) == "table" then
		for _, btn in ipairs(cfg.Buttons) do
			local cb = btn.Callback
			btn.Callback = function(...)
				if type(cb) == "function" then
					pcall(cb, ...)
				end
				pcall(function()
					if dialogScrim then
						dialogScrim.Visible = false
					end
				end)
			end
		end
	end

	local d = origDialog(Window, cfg)
	if d and d.Root then
		pcall(function()
			local scrim = ensureDialogScrim()
			local root = d.Root

			-- Dialog 默认挂在内层容器里，会被页签内容盖住，还会跟着容器一起半透明
			-- 提到 Window.Root 顶层，加个遮罩，底色板改成不透明
			root.Parent = Window.Root
			root.ZIndex = 2000
			root.BackgroundTransparency = 0
			root.ClipsDescendants = false
			Window.Root.ClipsDescendants = false

			root.Active = false
			scrim.ZIndex = 1990
			scrim.Active = false
			scrim.Visible = true

			-- 关掉弹窗后遮罩必须消失，否则它会一直盖在最上面把主界面点不动
			local function hideScrim()
				pcall(function()
					scrim.Visible = false
				end)
			end

			root.AncestryChanged:Connect(function()
				if not root.Parent then
					hideScrim()
				end
			end)
			pcall(function()
				root.Destroying:Connect(hideScrim)
			end)
			pcall(function()
				root:GetPropertyChangedSignal("Visible"):Connect(function()
					if not root.Visible then
						hideScrim()
					end
				end)
				root:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
					if root.AbsoluteSize.X < 1 then
						hideScrim()
					end
				end)
			end)

			-- 兜底：15 秒内没等到关闭信号就自己撤掉，绝不常驻
			task.spawn(function()
				local t = 0
				while t < 15 do
					task.wait(0.3)
					t = t + 0.3
					if not root.Parent or not root.Visible or root.AbsoluteSize.X < 1 then
						break
					end
				end
				hideScrim()
			end)
		end)
		-- 弹窗里的按钮也给按压反馈
		task.defer(function()
			pcall(addPressAnimations, d.Root)
		end)
	end
	return d
end

local function localizeAll()
	for _, d in ipairs(Window.Root:GetDescendants()) do
		pcall(localizeObject, d)
	end
end

localizeAll()

--==================== 控件安全包装 ====================--

local uiErrors = {}

local function stubElement()
	return {
		SetValue = function() end,
		GetValue = function() return nil end,
		SetValues = function() end,
		OnChanged = function() end,
		SetTitle = function() end,
		SetDesc = function() end,
		SetContent = function() end,
		Refresh = function() end,
	}
end

local elementIndex = 0

local function AddElement(tab, method, config)
	elementIndex = elementIndex + 1
	if not config then
		config = {}
	end

	if method == "Paragraph" and config.Value and not config.Content then
		config.Content = config.Value
		config.Value = nil
	end

	if config.Callback and not config.OnChanged then
		config.OnChanged = config.Callback
	end

	-- 滑块：FluentPlus 的 Round 在没有 Rounding 时会返回字符串，
	-- 随后 math.clamp 拿到字符串直接报错 → SetValue 挂 → 滑块整个不显示。
	-- 统一补 Rounding=0、把 Min/Max/Default 转成数字并夹好。
	if method == "Slider" then
		config.Min = tonumber(config.Min) or 0
		config.Max = tonumber(config.Max) or (config.Min + 1)
		if config.Max <= config.Min then
			config.Max = config.Min + 1
		end
		config.Default = math.clamp(tonumber(config.Default) or config.Min, config.Min, config.Max)
		config.Rounding = tonumber(config.Rounding) or 0
	end

	-- 长下拉自动开 Fluent 原生搜索框（脚本库/游戏脚本/颜色那种十几个选项的）
	if method == "Dropdown" then
		local vals = config.Values
		local count = 0
		if type(vals) == "table" then
			if #vals > 0 then
				count = #vals
			else
				for _ in pairs(vals) do
					count = count + 1
				end
			end
		end
		if count >= 10 then
			config.Search = true
		end
		if config.Searchable ~= nil then
			if config.Search == nil then
				config.Search = config.Searchable
			end
			config.Searchable = nil
		end
	end

	if type(tab[method]) ~= "function" then
		uiErrors[#uiErrors + 1] = method .. " 不在 tab 上"
		return stubElement()
	end

	local name = "el_" .. tostring(elementIndex) .. "_" .. method

	if method == "Button" then
		local ok, obj = pcall(function()
			return tab:Button(config)
		end)
		if ok and obj then
			return obj
		end
		uiErrors[#uiErrors + 1] = "Button: " .. tostring(obj)
		return stubElement()
	end

	local function tagElement(o)
		if method == "Slider" and o then
			pcall(function()
				if o.Root then
					o.Root:SetAttribute("ChuangNoPress", true)
				elseif o.SetAttribute then
					o:SetAttribute("ChuangNoPress", true)
				end
			end)
		end
		return o
	end

	local ok, obj = pcall(function()
		return tab[method](tab, name, config)
	end)
	if ok and obj then
		return tagElement(obj)
	end

	local ok2, obj2 = pcall(function()
		return tab[method](config)
	end)
	if ok2 and obj2 then
		return tagElement(obj2)
	end

	uiErrors[#uiErrors + 1] = method .. " 全签名失败: " .. tostring(obj) .. " / " .. tostring(obj2)
	return stubElement()
end

local function AddSection(tab, title)
	local ok, sec = pcall(function()
		return tab:Section(title)
	end)
	if ok and sec then
		return sec
	end
	return tab
end

local function AddTab(title, icon)
	local ok, tab = pcall(function()
		return Window:Tab({Title = title, Icon = icon})
	end)
	if ok and tab then
		return wrapTab(tab)
	end
	local err = tostring(tab)
	ok, tab = pcall(function()
		return Window:Tab({Title = title, Icon = "info"})
	end)
	if ok and tab then
		return wrapTab(tab)
	end
	uiErrors[#uiErrors + 1] = "Tab " .. title .. " · " .. err
	return {Container = Window.ContainerHolder, ScrollFrame = Window.ContainerHolder, Type = "Tab"}
end

pcall(fitWindow)
Patch.Config.PillWidth = math.min(196, math.max(120, math.floor(vp0.X * 0.34)))
Patch.Config.PillHeight = math.min(46, math.max(34, math.floor(vp0.Y * 0.11)))
-- 胶囊默认跟着主题走（深色主题配深色胶囊），之后用户仍可手动改
Patch.Config.PillStyle = Patch.Config.DarkMode and "dark" or "light"
pcall(Patch.Attach, Window)

-- 记住玩家手动拖到的位置：重排、切页、开键盘都不再弹回中间
local savePosPending = false
local function saveUIPos()
	if savePosPending then
		return
	end
	savePosPending = true
	task.delay(0.5, function()
		savePosPending = false
		local root = Window.Root
		if not root or not root.Parent then
			return
		end
		local x = math.floor(root.Position.X.Offset)
		local y = math.floor(root.Position.Y.Offset)
		if UICfg.x == x and UICfg.y == y then
			return
		end
		UICfg.x, UICfg.y = x, y
		saveUICfg()
	end)
end

pcall(function()
	Window.Root:GetPropertyChangedSignal("Position"):Connect(function()
		if (Patch.PosGuard or 0) > 0 then
			return
		end
		if not Window.Root.Visible then
			return
		end
		rememberWindowPos(Window, Window.Root.Position.X.Offset, Window.Root.Position.Y.Offset)
		saveUIPos()
	end)
end)

-- 右下角拖动改大小：记下来，下次按这个尺寸开
pcall(function()
	local resizePending = false
	Window.Root:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		if (Patch.PosGuard or 0) > 0 then
			return
		end
		if resizePending then
			return
		end
	resizePending = true
		task.delay(0.6, function()
			resizePending = false
			local root = Window.Root
			if not root or not root.Parent then
				return
			end
			local sz = root.AbsoluteSize
			if sz.X < 260 or sz.Y < 220 then
				return
			end
			rememberSize(sz.X, sz.Y)
			saveUIPos()
		end)
	end)
end)

pcall(function()
	BootPanel.Set("装载页签", 0.86)
end)

function Patch.Exit()
	local function try(fn)
		pcall(fn)
	end

	-- 1) 关功能：飞行、尾迹、速度、重力、广角全部复原
	try(function()
		if API and API.Shutdown then
			API.Shutdown()
		end
	end)

	-- 2) 停线程
	try(function()
		local th = getgenv().ChuangThreads
		if type(th) == "table" then
			for i = #th, 1, -1 do
				pcall(task.cancel, th[i])
				th[i] = nil
			end
		end
	end)

	-- 3) 收掉所有补间 / 呼吸
	try(function()
		local pill = pillGui and pillGui:FindFirstChild("FluentMobilePill")
		if pill then
			stopBreathe(pill)
		end
	end)

	-- 4) 销毁窗口、遮罩、胶囊
	try(function()
		if dialogScrim then
			dialogScrim:Destroy()
			dialogScrim = nil
		end
	end)
	try(function()
		local root = Window.Root
		local gui = root and root.Parent
		if gui then
			gui:Destroy()
		end
	end)
	try(function()
		if pillGui and pillGui.Parent then
			pillGui:Destroy()
		end
	end)

	-- 5) 收掉世界 / 音频副作用
	try(function()
		local blur = game:GetService("Lighting"):FindFirstChild("ChuangAcrylicBlur")
		if blur then
			blur:Destroy()
		end
	end)
	try(function()
		local ch = LP.Character
		if ch then
			for _, d in ipairs(ch:GetDescendants()) do
				if d.Name == "ChuangTrail" or d.Name == "ChuangFlyVel" or d.Name == "ChuangFlyGyro" then
					d:Destroy()
				end
			end
		end
	end)

	-- 6) 清全局标记，下一轮注入按全新状态启动
	try(function()
		getgenv().Chuang = nil
		getgenv().ChuangState = nil
	end)
	try(function()
		BootPanel.Finish()
	end)

	print("[窗] 界面已退出，功能全部复原")
end

--==================== 通用 ====================--

--==================== 绘制（ESP） ====================--
-- 原版没有这一页，是后加的：逐帧实时透视，放在第一个页签。
-- 2.8.4 起改成「纯实例」实现：ScreenGui + Frame + UIStroke + TextLabel。
-- 原因：部分手机执行器的 Drawing 只画得出 Line，Text/Square 根本不上屏，
-- 所以文字和方框以前看不清。实例由引擎渲染，文字、粗细、颜色都稳定。

local ESP = {
	on = false,
	maxDist = 600,
	fps = 20,
	cap = 35,
	box = true,
	corner = false,
	showName = true,
	showDist = true,
	showHp = true,
	tracer = false,
	teamCheck = true,
	aliveOnly = true,
	skeleton = false,
	skelDist = 220,
	skelCap = 8,
	offscreen = true,
	conn = nil,
	acc = 0,
	gui = nil,
	objs = {},
}

local ESP_PALETTE = {
	["白色"] = Color3.fromRGB(255, 255, 255),
	["青色"] = Color3.fromRGB(0, 240, 255),
	["红色"] = Color3.fromRGB(255, 70, 70),
	["紫色"] = Color3.fromRGB(200, 130, 255),
	["绿色"] = Color3.fromRGB(80, 255, 150),
	["黄色"] = Color3.fromRGB(255, 220, 60),
}

local espColor = ESP_PALETTE["白色"]
local ESP_BONE_COLOR = Color3.fromRGB(120, 235, 255)

local SKEL_R15 = {
	{ "Head", "UpperTorso" },
	{ "UpperTorso", "LowerTorso" },
	{ "UpperTorso", "LeftUpperArm" },
	{ "LeftUpperArm", "LeftLowerArm" },
	{ "LeftLowerArm", "LeftHand" },
	{ "UpperTorso", "RightUpperArm" },
	{ "RightUpperArm", "RightLowerArm" },
	{ "RightLowerArm", "RightHand" },
	{ "LowerTorso", "LeftUpperLeg" },
	{ "LeftUpperLeg", "LeftLowerLeg" },
	{ "LeftLowerLeg", "LeftFoot" },
	{ "LowerTorso", "RightUpperLeg" },
	{ "RightUpperLeg", "RightLowerLeg" },
	{ "RightLowerLeg", "RightFoot" },
}

local SKEL_R6 = {
	{ "Head", "Torso" },
	{ "Torso", "Left Arm" },
	{ "Torso", "Right Arm" },
	{ "Torso", "Left Leg" },
	{ "Torso", "Right Leg" },
}

local function espGuiGet()
	if ESP.gui and ESP.gui.Parent then
		return ESP.gui
	end
	local gui = Instance.new("ScreenGui")
	gui.Name = "ChuangESP"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.DisplayOrder = 90
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	local ok = pcall(function()
		gui.Parent = game:GetService("CoreGui")
	end)
	if not ok or not gui.Parent then
		pcall(function()
			gui.Parent = LP:WaitForChild("PlayerGui")
		end)
	end
	ESP.gui = gui
	return gui
end

local function espFrame(gui, name)
	local f = Instance.new("Frame")
	f.Name = name
	f.BackgroundTransparency = 1
	f.BorderSizePixel = 0
	f.AnchorPoint = Vector2.new(0, 0)
	f.ZIndex = 2
	f.Parent = gui
	return f
end

local function espLabel(gui, name)
	local t = Instance.new("TextLabel")
	t.Name = name
	t.BackgroundTransparency = 1
	t.BorderSizePixel = 0
	t.Font = Enum.Font.SourceSansBold
	t.TextColor3 = Color3.fromRGB(255, 255, 255)
	t.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	t.TextStrokeTransparency = 0.2
	t.TextSize = 14
	t.TextXAlignment = Enum.TextXAlignment.Center
	t.RichText = false
	t.ZIndex = 3
	t.Parent = gui
	return t
end

local function espSlot(plr)
	local s = ESP.objs[plr]
	if s then
		return s
	end
	local gui = espGuiGet()
	if not gui then
		return nil
	end
	s = {}

	s.box = espFrame(gui, "box")
	s.stroke = Instance.new("UIStroke")
	s.stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.stroke.Thickness = 2
	s.stroke.Color = espColor
	s.stroke.Parent = s.box

	s.name = espLabel(gui, "name")
	s.name.AnchorPoint = Vector2.new(0.5, 1)

	s.dist = espLabel(gui, "dist")
	s.dist.AnchorPoint = Vector2.new(0.5, 0)
	s.dist.TextSize = 13

	s.hpBg = espFrame(gui, "hpBg")
	s.hpBg.BackgroundTransparency = 0.25
	s.hpBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

	s.hp = espFrame(gui, "hp")
	s.hp.BackgroundTransparency = 0

	s.c1, s.c2, s.c3, s.c4 = espFrame(gui, "c1"), espFrame(gui, "c2"), espFrame(gui, "c3"), espFrame(gui, "c4")
	for i = 1, 4 do
		s["c" .. i].BackgroundTransparency = 0
		s["c" .. i].AnchorPoint = Vector2.new(0.5, 0.5)
	end

	s.arrow = espLabel(gui, "arrow")
	s.arrow.Text = "▲"
	s.arrow.Font = Enum.Font.SourceSansBold
	s.arrow.TextSize = 26
	s.arrow.Size = UDim2.fromOffset(40, 40)
	s.arrow.AnchorPoint = Vector2.new(0.5, 0.5)

	s.tracer = espFrame(gui, "tracer")
	s.tracer.BackgroundTransparency = 0.4
	s.tracer.AnchorPoint = Vector2.new(0.5, 0.5)
	s.tracer.Visible = false

	ESP.objs[plr] = s
	return s
end

local function espSkel(s, gui, n)
	if not s.skel then
		s.skel = {}
	end
	local list = s.skel
	for i = #list + 1, n do
		local f = Instance.new("Frame")
		f.Name = "bone" .. tostring(i)
		f.BorderSizePixel = 0
		f.AnchorPoint = Vector2.new(0.5, 0.5)
		f.BackgroundTransparency = 0
		f.BackgroundColor3 = ESP_BONE_COLOR
		f.ZIndex = 2
		f.Parent = gui
		list[i] = f
	end
	return list
end

local function espBones(ch)
	local hum = ch:FindFirstChildOfClass("Humanoid")
	if hum and hum.RigType == Enum.HumanoidRigType.R15 then
		return SKEL_R15
	end
	return SKEL_R6
end

-- 一条从 a 到 b 的细条（用 Frame 旋转模拟线），中心定位
local function espLineTo(f, a, b, thick)
	local dx, dy = b.X - a.X, b.Y - a.Y
	local len = math.sqrt(dx * dx + dy * dy)
	if len < 1 then
		f.Visible = false
		return
	end
	f.Visible = true
	f.Size = UDim2.fromOffset(math.floor(len), thick)
	f.Position = UDim2.fromOffset(math.floor((a.X + b.X) * 0.5), math.floor((a.Y + b.Y) * 0.5))
	f.Rotation = math.deg(math.atan2(dy, dx))
end

function ESP.step(dt)
	if not ESP.on then
		return
	end
	ESP.acc = ESP.acc + dt
	local gap = 1 / math.clamp(ESP.fps, 5, 60)
	if ESP.acc < gap then
		return
	end
	ESP.acc = 0

	local cam = Workspace.CurrentCamera
	if not cam then
		return
	end

	local myTeam = LP.Team
	local list = {}
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr == LP then
			continue
		end
		if ESP.teamCheck and myTeam ~= nil and plr.Team == myTeam then
			continue
		end
		local ch = plr.Character
		local hum = ch and ch:FindFirstChildOfClass("Humanoid")
		local root = ch and ch:FindFirstChild("HumanoidRootPart")
		if not hum or not root then
			continue
		end
		if ESP.aliveOnly and hum.Health <= 0 then
			continue
		end
		local d = (root.Position - cam.CFrame.Position).Magnitude
		if d > ESP.maxDist or d < 1 then
			continue
		end
		list[#list + 1] = { plr = plr, hum = hum, root = root, ch = ch, dist = d }
	end

	table.sort(list, function(a, b)
		return a.dist < b.dist
	end)

	local vp = cam.ViewportSize
	local gui = espGuiGet()
	if not gui then
		return
	end
	local drawn = {}
	local n = math.min(#list, math.max(1, math.floor(ESP.cap)))
	local skelBudget = math.max(0, math.floor(ESP.skelCap))
	local center = Vector2.new(vp.X * 0.5, vp.Y * 0.5)

	for i = 1, n do
		local it = list[i]
		local s = espSlot(it.plr)
		if s then
			drawn[it.plr] = true

			local head = cam:WorldToViewportPoint(it.root.Position + Vector3.new(0, 1.7, 0))
			local feet = cam:WorldToViewportPoint(it.root.Position - Vector3.new(0, 1.9, 0))
			local onScreen = head.Z > 0
				and feet.Z > 0
				and head.X > -20
				and head.X < vp.X + 20
				and head.Y > -20
				and head.Y < vp.Y + 20

			if not onScreen then
				s.box.Visible = false
				s.name.Visible = false
				s.dist.Visible = false
				s.hpBg.Visible = false
				s.hp.Visible = false
				s.tracer.Visible = false
				for ci = 1, 4 do
					s["c" .. ci].Visible = false
				end
				if s.skel then
					for si = 1, #s.skel do
						s.skel[si].Visible = false
					end
				end

				if ESP.offscreen then
					local rel = cam.CFrame:PointToObjectSpace(it.root.Position)
					local dir
					if rel.Z < 0 then
						dir = Vector2.new(rel.X, -rel.Y)
					else
						dir = Vector2.new(-rel.X, rel.Y)
					end
					if dir.Magnitude < 0.001 then
						dir = Vector2.new(0, -1)
					end
					dir = dir.Unit
					local margin = 40
					local tX, tY = math.huge, math.huge
					if dir.X > 0.0001 then
						tX = (vp.X - margin - center.X) / dir.X
					elseif dir.X < -0.0001 then
						tX = (margin - center.X) / dir.X
					end
					if dir.Y > 0.0001 then
						tY = (vp.Y - margin - center.Y) / dir.Y
					elseif dir.Y < -0.0001 then
						tY = (margin - center.Y) / dir.Y
					end
					local t = math.min(tX, tY)
					if t == math.huge or t <= 0 then
						t = 60
					end
					local tip = Vector2.new(center.X + dir.X * t, center.Y + dir.Y * t)
					s.arrow.Visible = true
					s.arrow.Position = UDim2.fromOffset(math.floor(tip.X), math.floor(tip.Y))
					-- ▲ 默认朝上，旋转到指向目标
					s.arrow.Rotation = math.deg(math.atan2(dir.X, -dir.Y))
				else
					s.arrow.Visible = false
				end
				continue
			end

			s.arrow.Visible = false

			local topY, botY = head.Y, feet.Y
			if botY < topY then
				topY, botY = botY, topY
			end
			local h = math.clamp(botY - topY, 12, vp.Y * 0.62)
			local w = math.max(10, h * 0.55)
			local cx = (head.X + feet.X) * 0.5
			local left = cx - w * 0.5
			local lw = math.clamp(math.floor(h * 0.045), 2, 4)
			local tsize = math.clamp(math.floor(vp.Y * 0.024), 13, 22)

			-- 方框：一个透明 Frame + UIStroke，引擎描边，粗细稳定
			s.box.Visible = ESP.box
			if ESP.box then
				s.box.Position = UDim2.fromOffset(math.floor(left), math.floor(topY))
				s.box.Size = UDim2.fromOffset(math.floor(w), math.floor(h))
				s.stroke.Thickness = lw
				s.stroke.Color = espColor
			end

			-- 角框：四角短斜线，默认关
			for ci = 1, 4 do
				local o = s["c" .. ci]
				if ESP.corner then
					local seg = math.clamp(h * 0.22, 6, 16)
					local cornerX = (ci == 1 or ci == 3) and left or (left + w)
					local cornerY = (ci <= 2) and topY or (topY + h)
					local sx = (ci == 1 or ci == 3) and 1 or -1
					local sy = (ci <= 2) and 1 or -1
					o.Visible = true
					o.BackgroundColor3 = espColor
					o.Size = UDim2.fromOffset(math.floor(seg * 1.4), lw + 1)
					o.Position = UDim2.fromOffset(
						math.floor(cornerX + sx * seg * 0.45),
						math.floor(cornerY + sy * seg * 0.45)
					)
					o.Rotation = sy * sx > 0 and 45 or -45
				else
					o.Visible = false
				end
			end

			-- 血条
			local frac = math.clamp(it.hum.Health / math.max(it.hum.MaxHealth, 1), 0, 1)
			local barH = math.clamp(math.floor(h * 0.09), 4, 7)
			local barY = topY + h + 3
			s.hpBg.Visible = ESP.showHp
			s.hp.Visible = ESP.showHp
			if ESP.showHp then
				s.hpBg.Position = UDim2.fromOffset(math.floor(left), math.floor(barY))
				s.hpBg.Size = UDim2.fromOffset(math.floor(w), barH)
				if frac > 0.55 then
					s.hp.BackgroundColor3 = Color3.fromRGB(70, 255, 110)
				elseif frac > 0.25 then
					s.hp.BackgroundColor3 = Color3.fromRGB(255, 205, 40)
				else
					s.hp.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
				end
				s.hp.Position = UDim2.fromOffset(math.floor(left), math.floor(barY))
				s.hp.Size = UDim2.fromOffset(math.max(1, math.floor(w * frac)), barH)
			end

			-- 描线（默认关，人多了会很乱）
			s.tracer.Visible = ESP.tracer
			if ESP.tracer then
				s.tracer.BackgroundColor3 = espColor
				espLineTo(s.tracer, Vector2.new(vp.X * 0.5, vp.Y - 6), Vector2.new(cx, topY + h * 0.5), 2)
			end

			-- 名字：白字黑描边 + 半透明黑底
			local shown = it.plr.DisplayName
			if shown == nil or shown == "" then
				shown = it.plr.Name
			end
			s.name.Visible = ESP.showName
			if ESP.showName then
				s.name.Text = shown .. "  " .. tostring(math.floor(it.hum.Health))
				s.name.TextSize = tsize
				s.name.Size = UDim2.fromOffset(math.floor(w) + 60, tsize + 8)
				s.name.Position = UDim2.fromOffset(math.floor(cx), math.floor(topY - 2))
				s.name.TextColor3 = Color3.fromRGB(255, 255, 255)
				s.name.TextStrokeTransparency = 0.15
			end

			-- 距离
			s.dist.Visible = ESP.showDist
			if ESP.showDist then
				s.dist.Text = tostring(math.floor(it.dist)) .. "m"
				s.dist.TextSize = math.clamp(math.floor(tsize * 0.85), 12, 18)
				s.dist.Size = UDim2.fromOffset(70, (tsize) + 4)
				s.dist.Position = UDim2.fromOffset(math.floor(cx), math.floor(topY + h + barH + 6))
			end

			-- 骨架：近处、限量
			if ESP.skeleton and skelBudget > 0 and it.dist <= ESP.skelDist then
				skelBudget = skelBudget - 1
				local bones = espBones(it.ch)
				local segs = espSkel(s, gui, #bones)
				for bi = 1, #bones do
					local o = segs[bi]
					local pa = it.ch:FindFirstChild(bones[bi][1])
					local pb = it.ch:FindFirstChild(bones[bi][2])
					if o and pa and pb and pa:IsA("BasePart") and pb:IsA("BasePart") then
						local a = cam:WorldToViewportPoint(pa.Position)
						local b = cam:WorldToViewportPoint(pb.Position)
						if a.Z > 0 and b.Z > 0 then
							o.BackgroundColor3 = ESP_BONE_COLOR
							espLineTo(o, Vector2.new(a.X, a.Y), Vector2.new(b.X, b.Y), lw)
						else
							o.Visible = false
						end
					elseif o then
						o.Visible = false
					end
				end
				for bi = #bones + 1, #segs do
					if segs[bi] then
						segs[bi].Visible = false
					end
				end
			elseif s.skel then
				for si = 1, #s.skel do
					if s.skel[si] then
						s.skel[si].Visible = false
					end
				end
			end
		end
	end

	for plr, s in pairs(ESP.objs) do
		if not drawn[plr] then
			s.box.Visible = false
			s.name.Visible = false
			s.dist.Visible = false
			s.hpBg.Visible = false
			s.hp.Visible = false
			s.tracer.Visible = false
			s.arrow.Visible = false
			for ci = 1, 4 do
				s["c" .. ci].Visible = false
			end
			if s.skel then
				for si = 1, #s.skel do
					if s.skel[si] then
						s.skel[si].Visible = false
					end
				end
			end
		end
	end

	local gone = nil
	for plr in pairs(ESP.objs) do
		if plr.Parent == nil then
			gone = gone or {}
			gone[#gone + 1] = plr
		end
	end
	if gone then
		for i = 1, #gone do
			local s = ESP.objs[gone[i]]
			if s then
				for _, key in ipairs({ "box", "name", "dist", "hpBg", "hp", "c1", "c2", "c3", "c4", "arrow", "tracer" }) do
					if s[key] then
						pcall(function()
							s[key]:Destroy()
						end)
					end
				end
				if s.skel then
					for si = 1, #s.skel do
						pcall(function()
							s.skel[si]:Destroy()
						end)
					end
				end
			end
			ESP.objs[gone[i]] = nil
		end
	end
end

function ESP.set(on)
	ESP.on = on and true or false
	if not ESP.on then
		if ESP.conn then
			pcall(function()
				ESP.conn:Disconnect()
			end)
			ESP.conn = nil
		end
		for _, s in pairs(ESP.objs) do
			for _, key in ipairs({ "box", "name", "dist", "hpBg", "hp", "c1", "c2", "c3", "c4", "arrow", "tracer" }) do
				if s[key] then
					pcall(function()
						s[key]:Destroy()
					end)
				end
			end
			if s.skel then
				for si = 1, #s.skel do
					pcall(function()
						s.skel[si]:Destroy()
					end)
				end
			end
		end
		table.clear(ESP.objs)
		if ESP.gui then
			pcall(function()
				ESP.gui:Destroy()
			end)
			ESP.gui = nil
		end
		return
	end
	espGuiGet()
	if not ESP.conn then
		ESP.conn = RunService.RenderStepped:Connect(function(dt)
			ESP.step(dt)
		end)
	end
	API.Notify("绘制", "ESP 已开启 · 最远 " .. tostring(math.floor(ESP.maxDist)) .. " 格", 4)
end

local TabEsp = AddTab("绘制", "eye")
Gui.Tabs.Esp = TabEsp

AddSection(TabEsp, "总开关")

AddElement(TabEsp, "Toggle", {
	Title = "实时 ESP",
	Description = "实例渲染 · 文字和框线由引擎画，一定看得清",
	Callback = function(on)
		ESP.set(on)
	end,
})

AddElement(TabEsp, "Paragraph", {
	Title = "说明",
	Content = "默认画 35 人。掉帧就按顺序关：描线 → 角框 → 骨架，再把人数降到 15。",
})

AddSection(TabEsp, "显示项")

AddElement(TabEsp, "Toggle", {
	Title = "方框",
	Default = true,
	Callback = function(on)
		ESP.box = on and true or false
	end,
})

AddElement(TabEsp, "Toggle", {
	Title = "角框",
	Description = "默认关，开了更花但多吃性能",
	Default = false,
	Callback = function(on)
		ESP.corner = on and true or false
	end,
})

AddElement(TabEsp, "Toggle", {
	Title = "名字和血量",
	Default = true,
	Callback = function(on)
		ESP.showName = on and true or false
	end,
})

AddElement(TabEsp, "Toggle", {
	Title = "距离",
	Default = true,
	Callback = function(on)
		ESP.showDist = on and true or false
	end,
})

AddElement(TabEsp, "Toggle", {
	Title = "血条",
	Default = true,
	Callback = function(on)
		ESP.showHp = on and true or false
	end,
})

AddElement(TabEsp, "Toggle", {
	Title = "描线",
	Description = "从屏幕底部连到目标，人多会显得乱，默认关",
	Default = false,
	Callback = function(on)
		ESP.tracer = on and true or false
	end,
})

AddSection(TabEsp, "骨架与屏外")

AddElement(TabEsp, "Toggle", {
	Title = "骨架（骨骼连线）",
	Description = "只画近处的人，R6 / R15 都支持",
	Default = false,
	Callback = function(on)
		ESP.skeleton = on and true or false
	end,
})

AddElement(TabEsp, "Toggle", {
	Title = "屏外箭头",
	Description = "人不在画面里就在边缘指个箭头",
	Default = true,
	Callback = function(on)
		ESP.offscreen = on and true or false
	end,
})

AddElement(TabEsp, "Slider", {
	Title = "骨架最远距离",
	Description = "超过这个距离不画骨骼",
	Min = 50,
	Max = 800,
	Default = 220,
	Callback = function(v)
		ESP.skelDist = math.floor(v)
	end,
})

AddElement(TabEsp, "Slider", {
	Title = "骨架最多画几人",
	Description = "骨骼最吃性能，默认 8",
	Min = 1,
	Max = 20,
	Default = 8,
	Callback = function(v)
		ESP.skelCap = math.floor(v)
	end,
})

AddSection(TabEsp, "过滤与性能")

AddElement(TabEsp, "Toggle", {
	Title = "队伍过滤",
	Description = "开着就不画同队的人",
	Default = true,
	Callback = function(on)
		ESP.teamCheck = on and true or false
	end,
})

AddElement(TabEsp, "Toggle", {
	Title = "只画活人",
	Default = true,
	Callback = function(on)
		ESP.aliveOnly = on and true or false
	end,
})

AddElement(TabEsp, "Slider", {
	Title = "最远距离",
	Description = "格（studs）",
	Min = 50,
	Max = 3000,
	Default = 600,
	Callback = function(v)
		ESP.maxDist = math.floor(v)
	end,
})

AddElement(TabEsp, "Slider", {
	Title = "刷新频率",
	Description = "每秒画几次，越低越省",
	Min = 5,
	Max = 60,
	Default = 20,
	Callback = function(v)
		ESP.fps = math.floor(v)
	end,
})

AddElement(TabEsp, "Slider", {
	Title = "最多画几个人",
	Description = "按距离近的优先 · 默认 35",
	Min = 1,
	Max = 60,
	Default = 35,
	Callback = function(v)
		ESP.cap = math.floor(v)
	end,
})

AddSection(TabEsp, "外观")

AddElement(TabEsp, "Dropdown", {
	Title = "配色",
	Description = "改完立刻生效，白最亮",
	Values = { "白色", "青色", "红色", "紫色", "绿色", "黄色" },
	Default = "白色",
	Callback = function(name)
		espColor = ESP_PALETTE[name] or ESP_PALETTE["白色"]
	end,
})

local TabGeneral = AddTab("通用", "sliders")
Gui.Tabs.General = TabGeneral
AddSection(TabGeneral, "移动")

local baseSpeed = state.baseSpeed or 16

Gui.Controls.SpeedSlider = AddElement(TabGeneral, "Slider", {
	Title = "移动速度",
	Description = "默认跟游戏一致（当前 " .. tostring(math.floor(baseSpeed)) .. "）",
	Min = 0,
	Max = 350,
	Default = math.clamp(math.floor(baseSpeed), 0, 350),
	Callback = function(v)
		API.Config.WalkSpeed = v
		if API.Config.SpeedOn then
			API.SetSpeed(v)
		end
	end,
})

Gui.Controls.SpeedToggle = AddElement(TabGeneral, "Toggle", {
	Title = "速度",
	Description = "关闭后回到游戏原本的速度",
	Callback = function(on)
		API.Config.SpeedOn = on and true or false
		state.speedOn = on and true or false
		if not on then
			API.SetSpeed(state.baseSpeed or 16)
			pcall(function()
				Gui.Controls.SpeedSlider:SetValue(math.clamp(math.floor(state.baseSpeed or 16), 0, 350))
			end)
		else
			API.SetSpeed(API.Config.WalkSpeed or state.baseSpeed or 16)
			pcall(startSpeedGuard)
		end
	end,
})

local baseJump
if state.baseUseJumpPower then
	baseJump = state.baseJumpPower or 50
else
	baseJump = state.baseJumpHeight or 7.2
end

Gui.Controls.JumpSlider = AddElement(TabGeneral, "Slider", {
	Title = "跳跃高度",
	Description = "默认跟游戏一致（当前 " .. tostring(math.floor(baseJump * 10) / 10) .. "）",
	Min = 0,
	Max = 500,
	Default = math.clamp(baseJump, 0, 500),
	Callback = function(v)
		API.Config.JumpPower = v
		state.jumpValue = v
		if API.Config.JumpOn then
			API.SetJumpHeight(v)
		end
	end,
})

Gui.Controls.GravityInput = AddElement(TabGeneral, "Input", {
	Title = "重力",
	Description = "默认 196.2",
	Default = "196.2",
	Placeholder = "196.2",
	Callback = function(text)
		local n = tonumber(text)
		if n then
			API.Config.Gravity = n
			if API.Config.GravityOn then
				API.SetGravity(n)
			end
		end
	end,
})

Gui.Controls.FovSlider = AddElement(TabGeneral, "Slider", {
	Title = "广角",
	Description = "默认 70",
	Min = 30,
	Max = 120,
	Default = 70,
	Callback = function(v)
		API.SetFOV(v)
	end,
})

AddSection(TabGeneral, "特殊移动")

Gui.Controls.NoclipToggle = AddElement(TabGeneral, "Toggle", {
	Title = "穿墙",
	Description = "关闭碰撞",
	Callback = function(on)
		API.Noclip(on)
	end,
})

Gui.Controls.InfJumpToggle = AddElement(TabGeneral, "Toggle", {
	Title = "无限跳跃",
	Description = "按住空格不断跳",
	Callback = function(on)
		API.InfiniteJump(on)
	end,
})

Gui.Controls.FreezeToggle = AddElement(TabGeneral, "Toggle", {
	Title = "无法移动",
	Description = "锁死自己",
	Callback = function(on)
		API.Freeze(on)
	end,
})

Gui.Controls.FlyToggle = AddElement(TabGeneral, "Toggle", {
	Title = "飞行",
	Description = "用摇杆方向飞",
	Callback = function(on)
		API.Fly(on)
	end,
})

Gui.Controls.FlySpeedSlider = AddElement(TabGeneral, "Slider", {
	Title = "飞行速度",
	Min = 10,
	Max = 400,
	Default = 100,
	Callback = function(v)
		API.SetFlySpeed(v)
	end,
})

Gui.Controls.SpinToggle = AddElement(TabGeneral, "Toggle", {
	Title = "自转",
	Description = "原地旋转",
	Callback = function(on)
		API.SetSpin(on, API.Config.SpinSpeed)
	end,
})

Gui.Controls.SpinSpeedSlider = AddElement(TabGeneral, "Slider", {
	Title = "自转速度",
	Min = 1,
	Max = 90,
	Default = 10,
	Callback = function(v)
		API.Config.SpinSpeed = v
	end,
})

Gui.Controls.RevVoidToggle = AddElement(TabGeneral, "Toggle", {
	Title = "反虚空",
	Description = "掉下去自动拉回",
	Callback = function(on)
		API.AntiVoid(on)
	end,
})

--==================== 角色 ====================--

local TabChar = AddTab("角色", "user")
Gui.Tabs.Char = TabChar
AddSection(TabChar, "血量")

Gui.Controls.MaxHealthSlider = AddElement(TabChar, "Slider", {
	Title = "血量上限",
	Min = 100,
	Max = 10000,
	Default = 100,
	Callback = function(v)
		API.SetMaxHealth(v)
	end,
})

Gui.Controls.HealthSlider = AddElement(TabChar, "Slider", {
	Title = "当前血量",
	Min = 1,
	Max = 10000,
	Default = 100,
	Callback = function(v)
		API.SetHealth(v)
	end,
})

Gui.Controls.GodToggle = AddElement(TabChar, "Toggle", {
	Title = "无敌",
	Description = "客户端锁血",
	Callback = function(on)
		API.GodMode(on)
	end,
})

AddSection(TabChar, "外观")

Gui.Controls.InvisibleToggle = AddElement(TabChar, "Toggle", {
	Title = "隐身",
	Description = "全身透明",
	Callback = function(on)
		API.Invisible(on)
	end,
})

Gui.Controls.HeadlessToggle = AddElement(TabChar, "Toggle", {
	Title = "无头",
	Description = "头部隐藏",
	Callback = function(on)
		API.Headless(on)
	end,
})

Gui.Controls.KorbloxToggle = AddElement(TabChar, "Toggle", {
	Title = "断腿",
	Description = "Korblox 右腿",
	Callback = function(on)
		API.Korblox(on)
	end,
})

Gui.Controls.NightToggle = AddElement(TabChar, "Toggle", {
	Title = "夜视",
	Description = "提亮画面",
	Callback = function(on)
		API.NightVision(on)
	end,
})

Gui.Controls.AnimDropdown = AddElement(TabChar, "Dropdown", {
	Title = "动画包",
	Description = "选一个替换默认动作",
	Values = API.ListAnimations(),
	Default = "忍者",
	Callback = function(name)
		API.ApplyAnimation(name)
	end,
})

--==================== 甩飞 ====================--

local TabFling = AddTab("甩飞", "swords")
Gui.Tabs.Fling = TabFling
AddSection(TabFling, "目标")

local firstTargets = playerNames()
Gui.Controls.TargetDropdown = AddElement(TabFling, "Dropdown", {
	Title = "目标玩家",
	Description = "刷新后再选",
	Values = firstTargets,
	Default = firstTargets[1],
	Callback = function(name)
		target.name = name
		target.player = Players:FindFirstChild(name)
	end,
})

AddElement(TabFling, "Button", {
	Title = "刷新玩家列表",
	Description = "玩家进出后点一下",
	Callback = function()
		refreshTarget()
	end,
})

AddSection(TabFling, "传送")

AddElement(TabFling, "Button", {
	Title = "传送到目标",
	Callback = function()
		local p = resolveTarget()
		if p then
			API.TeleportTo(p.Name, API.Config.TeleOffset, API.Config.SideOffset or 0, API.Config.UpOffset or 3)
		end
	end,
})

AddElement(TabFling, "Button", {
	Title = "把目标拉过来",
	Callback = function()
		local p = resolveTarget()
		if p then
			API.BringTo(p.Name, 3)
		end
	end,
})

Gui.Controls.TeleOffsetSlider = AddElement(TabFling, "Slider", {
	Title = "传送前后偏移",
	Description = "正数在前，负数在后",
	Min = -50,
	Max = 50,
	Default = 3,
	Callback = function(v)
		API.Config.TeleOffset = v
	end,
})

Gui.Controls.TeleSideSlider = AddElement(TabFling, "Slider", {
	Title = "传送左右偏移",
	Description = "正数在右，负数在左",
	Min = -50,
	Max = 50,
	Default = 0,
	Callback = function(v)
		API.Config.SideOffset = v
	end,
})

Gui.Controls.TeleUpSlider = AddElement(TabFling, "Slider", {
	Title = "传送上下偏移",
	Description = "默认 3",
	Min = -20,
	Max = 60,
	Default = 3,
	Callback = function(v)
		API.Config.UpOffset = v
	end,
})

AddSection(TabFling, "甩飞")

AddElement(TabFling, "Button", {
	Title = "甩飞一次",
	Description = "对当前目标",
	Callback = function()
		local p = resolveTarget()
		if p then
			API.Fling(p.Name)
		end
	end,
})

AddElement(TabFling, "Button", {
	Title = "甩飞所有人",
	Description = "除自己以外全部",
	Callback = function()
		API.FlingAll()
	end,
})

Gui.Controls.TouchFlingToggle = AddElement(TabFling, "Toggle", {
	Title = "碰到就甩飞",
	Description = "自己带着速度撞人",
	Callback = function(on)
		API.TouchFling(on)
	end,
})

AddSection(TabFling, "环绕")

Gui.Controls.OrbitToggle = AddElement(TabFling, "Toggle", {
	Title = "环绕目标",
	Description = "绕圈贴着目标跑",
	Callback = function(on)
		if on then
			local p = resolveTarget()
			if not p then
				return false
			end
			return API.Orbit(p.Name, true, API.Config.OrbitRadius, API.Config.OrbitHeight, API.Config.OrbitSpeed)
		end
		API.Orbit(nil, false)
	end,
})

Gui.Controls.OrbitRadiusSlider = AddElement(TabFling, "Slider", {
	Title = "环绕半径",
	Min = 2,
	Max = 60,
	Default = 10,
	Callback = function(v)
		API.Config.OrbitRadius = v
	end,
})

Gui.Controls.OrbitHeightSlider = AddElement(TabFling, "Slider", {
	Title = "环绕高度",
	Min = -20,
	Max = 25,
	Default = 0,
	Callback = function(v)
		API.Config.OrbitHeight = v
	end,
})

Gui.Controls.OrbitSpeedSlider = AddElement(TabFling, "Slider", {
	Title = "环绕速度",
	Min = 1,
	Max = 120,
	Default = 6,
	Callback = function(v)
		API.Config.OrbitSpeed = v / 10
	end,
})

--==================== 玩法 ====================--

local TabPlay = AddTab("玩法", "play")
Gui.Tabs.Play = TabPlay
AddSection(TabPlay, "尾迹")

Gui.Controls.TrailToggle = AddElement(TabPlay, "Toggle", {
	Title = "彩色尾迹",
	Description = "跑动时拖尾",
	Callback = function(on)
		API.Trail(on, API.Config.TrailColor)
	end,
})

Gui.Controls.TrailColorDropdown = AddElement(TabPlay, "Dropdown", {
	Title = "尾迹颜色",
	Values = {"彩虹", "青色", "蓝色", "绿色", "红色", "黄色", "橙色", "紫色", "粉色", "白色", "黑色"},
	Default = "彩虹",
	Callback = function(color)
		API.Config.TrailColor = color
		API.SetTrailColor(color)
	end,
})

AddSection(TabPlay, "战斗")

Gui.Controls.AutoAttackToggle = AddElement(TabPlay, "Toggle", {
	Title = "靠近自动攻击",
	Description = "手里要有工具",
	Callback = function(on)
		API.AutoAttack(on)
	end,
})

Gui.Controls.BackpackToggle = AddElement(TabPlay, "Toggle", {
	Title = "抢背包",
	Description = "把别人背包里的工具搬过来",
	Callback = function(on)
		API.GrabBackpacks(on)
	end,
})

AddSection(TabPlay, "伪装")

AddElement(TabPlay, "Button", {
	Title = "复制目标外观",
	Description = "只对当前目标生效",
	Callback = function()
		local p = resolveTarget()
		if p then
			API.CopyAppearance(p.Name)
		end
	end,
})

AddElement(TabPlay, "Button", {
	Title = "还原自己外观",
	Callback = function()
		API.RestoreAppearance()
	end,
})

--==================== 服务器 ====================--

local TabServer = AddTab("服务器", "server")
Gui.Tabs.Server = TabServer
AddSection(TabServer, "换服")

AddElement(TabServer, "Button", {
	Title = "加入人最少服务器",
	Callback = function()
		API.JoinLowestServer()
	end,
})

AddElement(TabServer, "Button", {
	Title = "加入人最多服务器",
	Callback = function()
		API.JoinFullestServer()
	end,
})

AddElement(TabServer, "Button", {
	Title = "重进当前服务器",
	Callback = function()
		API.Rejoin()
	end,
})

--==================== 界面 ====================--

local TabUi = AddTab("界面", "settings")
Gui.Tabs.Ui = TabUi
AddSection(TabUi, "最小化胶囊")

Gui.Controls.PillTextInput = AddElement(TabUi, "Input", {
	Title = "胶囊文字",
	Default = "打开界面",
	Callback = function(text)
		Patch.SetPillText(text)
	end,
})

Gui.Controls.PillStyleDropdown = AddElement(TabUi, "Dropdown", {
	Title = "胶囊配色",
	Values = {"light", "dark"},
	Default = Patch.Config.PillStyle == "dark" and "dark" or "light",
	Callback = function(style)
		Patch.SetPillStyle(style)
	end,
})

Gui.Controls.PillReactToggle = AddElement(TabUi, "Toggle", {
	Title = "胶囊周围弹动",
	Description = "划过胶囊附近会弹一下再回位",
	Default = true,
	Callback = function(on)
		Patch.Config.PillReact = on and true or false
	end,
})

Gui.Controls.PillReactRangeSlider = AddElement(TabUi, "Slider", {
	Title = "弹动感应范围",
	Description = "默认 96",
	Min = 30,
	Max = 260,
	Default = 96,
	Callback = function(v)
		Patch.Config.PillReactRange = v
	end,
})

AddElement(TabUi, "Button", {
	Title = "重置胶囊位置",
	Description = "回到屏幕正上方居中",
	Callback = function()
		Patch.ResetPillPosition()
	end,
})

AddElement(TabUi, "Button", {
	Title = "收起界面（测试胶囊条）",
	Callback = function()
		Patch.Minimize()
	end,
})

AddElement(TabUi, "Button", {
	Title = "恢复界面",
	Callback = function()
		Patch.Restore()
	end,
})

AddElement(TabUi, "Button", {
	Title = "关闭界面",
	Description = "弹出确认框，和截图一致",
	Callback = function()
		Window:Dialog({
			Title = "关闭",
			Content = "确定要关闭界面吗？",
			Buttons = {
				{
					Title = "是",
					Callback = function()
						Patch.Exit()
					end,
				},
				{Title = "否", Callback = function() end},
			},
		})
	end,
})

AddSection(TabUi, "适配")

Gui.Controls.KeyboardToggle = AddElement(TabUi, "Toggle", {
	Title = "键盘避让",
	Description = "点输入框自动上移窗口",
	Default = true,
	Callback = function(on)
		Patch.Config.KeyboardAvoid = on
	end,
})

Gui.Controls.PressToggle = AddElement(TabUi, "Toggle", {
	Title = "按钮按压动画",
	Description = "点按钮会微微缩小再弹回",
	Default = true,
	Callback = function(on)
		Patch.Config.ButtonPress = on and true or false
	end,
})

Gui.Controls.ScrollbarSlider = AddElement(TabUi, "Slider", {
	Title = "滚动条粗细",
	Min = 3,
	Max = 12,
	Default = 6,
	Callback = function(v)
		Patch.Config.ScrollBarThickness = v
		for _, d in ipairs(Window.Root:GetDescendants()) do
			if d:IsA("ScrollingFrame") then
				d.ScrollBarThickness = v
			end
		end
	end,
})

--==================== 信息 ====================--

local TabInfo = AddTab("信息", "info")
Gui.Tabs.Info = TabInfo
AddSection(TabInfo, "作者")

AddElement(TabInfo, "Paragraph", {
	Title = "这个脚本",
	Value = "UI: Fluent Renewed\n作者: 依旧培根头\n帮助者: 守村人\n完全免费，禁止倒卖",
})

AddElement(TabInfo, "Button", {
	Title = "复制 QQ 群号",
	Description = "1107181697",
	Callback = function()
		if setclipboard then
			setclipboard("1107181697")
			API.Notify("复制成功", "QQ 群号已复制", 2)
		end
	end,
})

AddElement(TabInfo, "Button", {
	Title = "复制作者名",
	Callback = function()
		if setclipboard then
			setclipboard("依旧培根头")
			API.Notify("复制成功", "已复制", 2)
		end
	end,
})

AddElement(TabInfo, "Paragraph", {
	Title = "执行环境",
	Value = tostring(game:GetService("Players").LocalPlayer.Name) .. " · UI 手机端已适配 · 动画补丁 v2.8.6",
})

AddSection(TabInfo, "Fluent")

AddElement(TabInfo, "Paragraph", {
	Title = "当前加载来源",
	Value = tostring(fpFrom or "未知")
		.. "\n锁定: "
		.. FP_PIN.Tag
		.. " · 原始 "
		.. tostring(FP_PIN.Bytes)
		.. " 字节 · 缓存已打 6 处补丁"
})

AddElement(TabInfo, "Button", {
	Title = "清掉 Fluent 缓存",
	Description = "下次启动会重新下载锁定版",
	Callback = function()
		pcall(function()
			if type(delfile) == "function" then
				delfile(FP_CACHE)
			end
		end)
		API.Notify("Fluent", "缓存已清，重开脚本生效", 3)
	end,
})

if #uiErrors > 0 then
	print("[分支] 控件构建失败 " .. tostring(#uiErrors) .. " 个")
end

if #uiErrors > 0 then
	AddSection(TabInfo, "诊断")
	AddElement(TabInfo, "Paragraph", {
		Title = "控件创建异常",
		Value = tostring(#uiErrors) .. " 个控件被跳过\n" .. table.concat(uiErrors, "\n"),
	})
end

--==================== 通用（补齐） ====================--

AddSection(TabGeneral, "开关补充")

Gui.Controls.JumpToggle = AddElement(TabGeneral, "Toggle", {
	Title = "跳跃开关",
	Description = "关闭时回到游戏原本的跳跃",
	Callback = function(on)
		API.Config.JumpOn = on and true or false
		state.jumpOn = on and true or false
		local hum = getHum()
		if on then
			API.SetJumpHeight(API.Config.JumpPower or state.jumpValue or baseJump)
		return
		end
		if hum then
			pcall(function()
				hum.UseJumpPower = state.baseUseJumpPower or false
				if hum.UseJumpPower then
					hum.JumpPower = state.baseJumpPower or hum.JumpPower
				else
					hum.JumpHeight = state.baseJumpHeight or hum.JumpHeight
				end
			end)
		end
		pcall(function()
			Gui.Controls.JumpSlider:SetValue(math.clamp(baseJump, 0, 500))
		end)
	end,
})

Gui.Controls.GravityToggle = AddElement(TabGeneral, "Toggle", {
	Title = "重力开关",
	Description = "关闭时恢复 196.2",
	Callback = function(on)
		API.Config.GravityOn = on and true or false
		if on then
			API.SetGravity(API.Config.Gravity or 196.2)
		else
			API.SetGravity(196.2)
		end
	end,
})

AddElement(TabGeneral, "Button", {
	Title = "重置广角",
	Description = "恢复默认 70",
	Callback = function()
		API.SetFOV(70)
		Gui.Controls.FovSlider:SetValue(70)
	end,
})

AddSection(TabGeneral, "快速跑步")

Gui.Controls.RunSpeedInput = AddElement(TabGeneral, "Input", {
	Title = "快速跑步速度",
	Default = "50",
	Placeholder = "数字越大越快",
	Callback = function(text)
		local n = tonumber(text)
		if n then
			API.SetRunSpeed(n)
		end
	end,
})

Gui.Controls.FastRunToggle = AddElement(TabGeneral, "Toggle", {
	Title = "快速跑步",
	Default = false,
	Callback = function(on)
		API.FastRun(on)
	end,
})

-- 速度没接管时，滑块跟着游戏实际速度走（换地图 / 游戏自己改速度也会同步）
spawnTracked(function()
	local lastSpeed = -1
	while true do
		task.wait(0.5)
		if not (Gui.Window and Gui.Window.Root and Gui.Window.Root.Parent) then
			break
		end
		local hum = getHum()
		if hum then
			local real = math.floor(hum.WalkSpeed)
			if API.Config.SpeedOn then
				lastSpeed = real
			elseif real ~= lastSpeed then
				lastSpeed = real
				state.baseSpeed = hum.WalkSpeed
				state.walkSpeed = hum.WalkSpeed
				pcall(function()
					Gui.Controls.SpeedSlider:SetValue(math.clamp(real, 0, 350))
				end)
			end
		end
	end
end)

AddSection(TabGeneral, "防护")

Gui.Controls.AntiFlingToggle = AddElement(TabGeneral, "Toggle", {
	Title = "防甩飞",
	Description = "把全场角色碰撞都关掉",
	Callback = function(on)
		API.AntiFling(on)
	end,
})

Gui.Controls.BypassFlyToggle = AddElement(TabGeneral, "Toggle", {
	Title = "绕过飞行",
	Description = "屏蔽 ForceSelfDamage，防止飞行被踢",
	Callback = function(on)
		API.BypassFly(on)
	end,
})

Gui.Controls.JoinNotifyToggle = AddElement(TabGeneral, "Toggle", {
	Title = "玩家进入/退出通知",
	Callback = function(on)
		API.JoinNotify(on)
	end,
})

AddSection(TabGeneral, "本地攻击")

AddElement(TabGeneral, "Button", {
	Title = "击杀所有人（客户端）",
	Description = "只在本机生效",
	Callback = function()
		API.KillAll()
	end,
})

AddElement(TabGeneral, "Button", {
	Title = "自杀",
	Description = "本地效果",
	Callback = function()
		API.Suicide()
	end,
})

--==================== 甩飞（补齐） ====================--

local target2 = { name = nil }

local function playerNames2()
	local list = {}
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LP then
			table.insert(list, p.Name)
		end
	end
	if #list == 0 then
		table.insert(list, "无在线玩家")
	end
	return list
end

AddSection(TabFling, "第二个目标")

local firstTargets2 = playerNames2()
Gui.Controls.Target2Dropdown = AddElement(TabFling, "Dropdown", {
	Title = "第二目标",
	Description = "给循环传送 / 自瞄用",
	Values = firstTargets2,
	Default = firstTargets2[1],
	Callback = function(name)
		target2.name = name
	end,
})

AddElement(TabFling, "Button", {
	Title = "刷新第二目标列表",
	Callback = function()
		if Gui.Controls.Target2Dropdown and Gui.Controls.Target2Dropdown.SetValues then
			Gui.Controls.Target2Dropdown:SetValues(playerNames2())
		end
	end,
})

local function resolveTarget2()
	local name = target2.name
	if not name or name == "无在线玩家" then
		name = target.name
	end
	if not name or name == "无在线玩家" then
		API.Notify("提示", "先选一个目标玩家", 3)
		return nil
	end
	local p = Players:FindFirstChild(name)
	if not p then
		API.Notify("提示", "玩家已离开", 3)
		return nil
	end
	return p
end

AddSection(TabFling, "循环传送 / 循环甩飞")

local pullLoop = false

Gui.Controls.LockTeleToggle = AddElement(TabFling, "Toggle", {
	Title = "锁定传送（贴着目标）",
	Description = "每帧贴到目标上方 3 格",
	Callback = function(on)
		local p = on and resolveTarget2() or nil
		if on and not p then
			return false
		end
		if on then
			return API.LoopTeleport("beside", p.Name, 3)
		end
		API.StopLoopTeleport()
	end,
})

Gui.Controls.PullToggle = AddElement(TabFling, "Toggle", {
	Title = "循环把目标传送过来",
	Callback = function(on)
		pullLoop = on and true or false
		if not pullLoop then
			return false
		end
		local p = resolveTarget2()
		if not p then
			pullLoop = false
			return false
		end
		spawnTracked(function()
			local plr = p
			while pullLoop do
				task.wait()
				local root = getRoot()
				local tr = plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
				if root and tr then
					tr.CFrame = root.CFrame + Vector3.new(0, 3, 0)
				else
					pullLoop = false
					break
				end
			end
		end)
	end,
})

Gui.Controls.ViewPlayerToggle = AddElement(TabFling, "Toggle", {
	Title = "查看目标视角",
	Callback = function(on)
		local p = on and resolveTarget2() or nil
		if on and not p then
			return false
		end
		API.ViewPlayer(on, p and p.Name)
	end,
})

Gui.Controls.LoopFlingToggle = AddElement(TabFling, "Toggle", {
	Title = "循环甩飞",
	Description = "每 1 秒甩一次目标",
	Callback = function(on)
		local p = on and resolveTarget2() or nil
		if on and not p then
			return false
		end
		if on then
			return API.LoopFling(p.Name, 1)
		end
		API.StopLoopFling()
	end,
})

Gui.Controls.AimToggle = AddElement(TabFling, "Toggle", {
	Title = "指定自瞄目标",
	Description = "相机一直朝向目标",
	Callback = function(on)
		local p = on and resolveTarget2() or nil
		if on and not p then
			return false
		end
		API.AimAt(p and p.Name, on)
	end,
})

AddSection(TabFling, "循环传送距离")

Gui.Controls.LoopFrontSlider = AddElement(TabFling, "Slider", {
	Title = "前方距离",
	Min = 3,
	Max = 25,
	Default = 3,
	Callback = function(v)
		API.Config.LoopFront = v
	end,
})

Gui.Controls.LoopFrontToggle = AddElement(TabFling, "Toggle", {
	Title = "循环传送到前方",
	Callback = function(on)
		local p = on and resolveTarget2() or nil
		if on and not p then
			return false
		end
		if on then
			return API.LoopTeleport("front", p.Name, API.Config.LoopFront or 3)
		end
		API.StopLoopTeleport()
	end,
})

Gui.Controls.LoopAboveSlider = AddElement(TabFling, "Slider", {
	Title = "头顶高度",
	Min = 4,
	Max = 25,
	Default = 4,
	Callback = function(v)
		API.Config.LoopAbove = v
	end,
})

Gui.Controls.LoopAboveToggle = AddElement(TabFling, "Toggle", {
	Title = "循环传送到头顶",
	Callback = function(on)
		local p = on and resolveTarget2() or nil
		if on and not p then
			return false
		end
		if on then
			return API.LoopTeleport("above", p.Name, API.Config.LoopAbove or 4)
		end
		API.StopLoopTeleport()
	end,
})

Gui.Controls.LoopBehindSlider = AddElement(TabFling, "Slider", {
	Title = "后方距离",
	Min = 4,
	Max = 30,
	Default = 4,
	Callback = function(v)
		API.Config.LoopBehind = v
	end,
})

Gui.Controls.LoopBehindToggle = AddElement(TabFling, "Toggle", {
	Title = "循环传送到后面",
	Callback = function(on)
		local p = on and resolveTarget2() or nil
		if on and not p then
			return false
		end
		if on then
			return API.LoopTeleport("behind", p.Name, API.Config.LoopBehind or 4)
		end
		API.StopLoopTeleport()
	end,
})

--==================== 伪装 ====================--

local TabDisguise = AddTab("伪装", "shield")
Gui.Tabs.Disguise = TabDisguise
AddSection(TabDisguise, "目标")

local disgTarget = nil
local firstDisg = playerNames()

Gui.Controls.DisgDropdown = AddElement(TabDisguise, "Dropdown", {
	Title = "目标玩家",
	Description = "r6 服要用饰品级伪装",
	Values = firstDisg,
	Default = firstDisg[1],
	Callback = function(name)
		disgTarget = name
	end,
})

AddElement(TabDisguise, "Button", {
	Title = "刷新玩家列表",
	Callback = function()
		if Gui.Controls.DisgDropdown and Gui.Controls.DisgDropdown.SetValues then
			Gui.Controls.DisgDropdown:SetValues(playerNames())
		end
	end,
})

AddSection(TabDisguise, "伪装")

AddElement(TabDisguise, "Button", {
	Title = "伪装成目标（r6 饰品级）",
	Description = "克隆饰品逐个焊接，r6 也能用",
	Callback = function()
		API.DisguiseR6(disgTarget or target.name)
	end,
})

AddElement(TabDisguise, "Button", {
	Title = "复制目标外观（R15）",
	Description = "ApplyDescription，r15 才准",
	Callback = function()
		API.CopyAppearance(disgTarget or target.name)
	end,
})

AddElement(TabDisguise, "Button", {
	Title = "还原自己外观",
	Description = "重载角色",
	Callback = function()
		API.RestoreAppearance()
	end,
})

--==================== 脚本库 ====================--
-- 原版里的「其他脚本」这一页，这里单独做成「脚本库」
-- 每个按钮走同一条路：HttpGet → loadstring → 直接跑，失败会在通知里报出来

local TabLib = AddTab("脚本库", "folder")
Gui.Tabs.Lib = TabLib

local function loadLib(name, url)
	return API.RunRemote(url, name)
end

local function LibBtn(title, desc, url)
	AddElement(TabLib, "Button", {
		Title = title,
		Description = desc,
		Callback = function()
			loadLib(title, url)
		end,
	})
end

AddSection(TabLib, "窗系列")

LibBtn("窗脚本中心", "依旧培根头的脚本合集入口", "https://raw.githubusercontent.com/pl11451481mvcxz/chuangjiaobenzhongxin/refs/heads/main/Script.lua")

LibBtn("窗脚本（加载器）", "窗脚本本体加载器", "https://raw.githubusercontent.com/pl11451481mvcxz/nb/refs/heads/main/%E7%AA%97%E8%84%9A%E6%9C%AC%E5%8A%A0%E8%BD%BD%E5%99%A8.lua")

AddSection(TabLib, "中文脚本")

LibBtn("茉莉璐", "LETHAL-APE · GhostlyPilot", "https://raw.githubusercontent.com/M0Li1u/GhostlyPilot--/refs/heads/main/LETHAL-APE.lua")

LibBtn("皮脚本", "xiaopi77 的皮脚本", "https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua")

LibBtn("XK", "XK Hub", "https://github.com/devslopo/DVES/raw/main/XK%20Hub")

LibBtn("叶脚本", "roblox-ye 中文 VIP 脚本", "https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/ROBLOX-CNVIP-XIAOYE.lua")

LibBtn("夜脚本", "ye script", "https://raw.githubusercontent.com/61646764343/ye-script/refs/heads/main/ye%20script.lua")

LibBtn("大司马 V6", "dasimaV6", "https://raw.githubusercontent.com/whenheer/dasimav6/refs/heads/main/dasimaV6.txt")

LibBtn("落叶中心", "落叶中心混淆版", "https://raw.githubusercontent.com/krlpl/Deciduous-center-LS/main/%E8%90%BD%E5%8F%B6%E4%B8%AD%E5%BF%83%E6%B7%B7%E6%B7%86.txt")

LibBtn("XK 脚本中心", "BINjiao 的 XK 本体", "https://raw.githubusercontent.com/BINjiaobzx6/BINjiao/main/XK.lua")

LibBtn("BS 脚本轻量版", "BS-loves_you", "https://raw.githubusercontent.com/vbxfhcd/BS/refs/heads/main/BS-loves_you.txt")

LibBtn("RB", "Rb-Hub", "https://raw.githubusercontent.com/Yungengxin/roblox/refs/heads/main/Rb-Hub")

LibBtn("恐脚本", "直接打加载器，跳过空转跳", "https://raw.githubusercontent.com/kongbaNB/9178/refs/heads/main/%E6%81%90%E8%84%9A%E6%9C%AC%E5%8A%A0%E8%BD%BD%E5%99%A8")

LibBtn("黑白脚本", "黑白脚本加载器", "https://raw.githubusercontent.com/tfcygvunbind/Apple/main/%E9%BB%91%E7%99%BD%E8%84%9A%E6%9C%AC%E5%8A%A0%E8%BD%BD%E5%99%A8")

AddSection(TabLib, "注入器工具")

LibBtn("执行 Dex", "Dex++ 资源浏览器", "https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua")

LibBtn("执行 rspy", "SimpleSpy V3", "https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua")

LibBtn("执行 Cspy", "Cobalt 远程监控", "https://gitlab.com/upio/cobalt/-/releases/permalink/latest/downloads/Cobalt.luau")

LibBtn("执行 mdex", "mdex", "https://raw.githubusercontent.com/infyiff/backup/main/dex.lua")

--==================== 游戏脚本 ====================--
-- 原版「服务器脚本」那一页：按游戏分开，每个按钮同样走 RunRemote

local TabGames = AddTab("游戏脚本", "gamepad-2")
Gui.Tabs.Games = TabGames

local function GameBtn(title, desc, url)
	AddElement(TabGames, "Button", {
		Title = title,
		Description = desc,
		Callback = function()
			API.RunRemote(url, title)
		end,
	})
end

AddSection(TabGames, "gb")

GameBtn("经典大黄牙", "GB.HUB 经典版", "https://raw.githubusercontent.com/pl11451481mvcxz/Yellowtooth/refs/heads/main/GB.HUB")

GameBtn("军团包检测", "GBHUB 军团包", "https://raw.githubusercontent.com/pl11451481mvcxz/Legio197/refs/heads/main/GBHUB.lua")

GameBtn("绕过飞行", "GB 专用飞行", "https://raw.githubusercontent.com/pl11451481mvcxz/gbfly/refs/heads/main/fly.lua")

GameBtn("甩飞", "GB 甩飞（pastefy）", "https://pastefy.app/xOXIJXr9/raw")

AddSection(TabGames, "监狱人生")

GameBtn("监狱人生①", "loader 版", "https://raw.githubusercontent.com/f34p9fh3a4/.xyz/refs/heads/main/loader.lua")

GameBtn("监狱人生②", "rscripts 版", "https://raw.githubusercontent.com/nlzzpro/rscripts/refs/heads/main/prisonlife")

AddSection(TabGames, "最强战场")

GameBtn("vexonhub", "需要解卡", "https://raw.githubusercontent.com/DiosDi/VexonHub/refs/heads/main/VexonHub")

GameBtn("TSB①", "phantasm", "https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/phantasm.lua")

GameBtn("穿墙透视", "同仓库 · 无二跳", "https://raw.githubusercontent.com/cytj777i/Deliver-through-the-wall-perspective/main/%E4%BC%A0%E9%80%81%E7%A9%BF%E5%A2%99%E9%80%8F%E8%A7%86")

GameBtn("远程打人", "SION ELTNAM ATLASIA", "https://rawscripts.net/raw/The-Strongest-Battlegrounds-SION-ELTNAM-ATLASIA-61168")

GameBtn("虚空秒杀", "pastefy 版", "https://pastefy.app/REPoaFWC/raw")

AddSection(TabGames, "doors")

GameBtn("Doors①", "AbysallContinued", "https://raw.githubusercontent.com/MaxPikaa/AbysallContinued/refs/heads/main/DOORS")

GameBtn("Doors②", "Doors But Decent 手机版", "https://raw.githubusercontent.com/KINGHUB01/BlackKing-obf/main/Doors%20But%20Decent%20Mobile")

GameBtn("Doors③", "mshax(prohax)", "https://raw.githubusercontent.com/atnew2025/Chinese-scripts/refs/heads/main/mshax(prohax).txt")

AddSection(TabGames, "竞争对手")

GameBtn("竞争对手②", "W1lteGame 自瞄", "https://raw.githubusercontent.com/W1lteGameYT/W1lteGame-Hub-Best-Rivals-Aimbot-Script-NO-KEY-/refs/heads/main/script")

AddSection(TabGames, "偷走一个蛋")

GameBtn("偷走一个蛋②", "脚本", "https://raw.githubusercontent.com/qq122565661/-/refs/heads/main/%E8%84%9A%E6%AD%A5.lua")

AddSection(TabGames, "MM2")

GameBtn("MM2①", "onyxscripts", "https://onyxscripts.xyz")

--==================== 信息（补齐） ====================--

local executorName = "未知"
pcall(function()
	if type(identifyexecutor) == "function" then
		executorName = tostring(identifyexecutor())
	end
end)

AddSection(TabInfo, "运行环境")

AddElement(TabInfo, "Paragraph", {
	Title = "当前环境",
	Value = "注入器: " .. executorName .. "\n用户名: " .. LP.Name .. "\n绘制: Roblox GUI（Fluent Renewed）",
})

AddSection(TabInfo, "混淆器")

local CopyLinks = {
	{"复制 wearedevs.net", "https://wearedevs.net/obfuscator"},
	{"复制 免费 Luraph", "https://junkie-development.de/"},
	{"复制 Luraph", "https://lura.ph/"},
	{"复制 moonveil", "https://moonveil.cc"},
	{"复制 goofyscator", "https://goofyscator.lua.cz/"},
}

for _, item in ipairs(CopyLinks) do
	AddElement(TabInfo, "Button", {
		Title = item[1],
		Callback = function()
			if setclipboard then
				setclipboard(item[2])
				API.Notify("复制成功", item[2], 2)
			end
		end,
	})
end

AddElement(TabInfo, "Button", {
	Title = "复制 Moonsec V3（反混淆）",
	Callback = function()
		if setclipboard then
			setclipboard(".gg/25ms")
			API.Notify("复制成功", "已复制", 2)
		end
	end,
})

AddElement(TabInfo, "Button", {
	Title = "复制 WeAreDabs（反混淆）",
	Callback = function()
		if setclipboard then
			setclipboard(".gg/threaded")
			API.Notify("复制成功", "已复制", 2)
		end
	end,
})

AddElement(TabInfo, "Button", {
	Title = "棍木",
	Description = "114514 元才买得到",
	Callback = function()
		if setclipboard then
			setclipboard("棍木")
			API.Notify("复制成功", "棍木", 2)
		end
	end,
})

AddSection(TabInfo, "退出")

Gui.Controls.KickReasonInput = AddElement(TabInfo, "Input", {
	Title = "退出原因",
	Default = "你已退出游戏",
	Placeholder = "错误代码 277",
	Callback = function(text)
		API.Config.KickReason = text
	end,
})

AddElement(TabInfo, "Button", {
	Title = "踢出（用上面的原因）",
	Callback = function()
		API.Kick(API.Config.KickReason or "你已退出游戏")
	end,
})

AddElement(TabInfo, "Button", {
	Title = "267 断开",
	Description = "带错误代码 267",
	Callback = function()
		API.Kick267("手动触发")
	end,
})

AddSection(TabInfo, "调试")

AddElement(TabInfo, "Button", {
	Title = "重新接管界面（AttachAll）",
	Callback = function()
		local n = Patch.AttachAll()
		API.Notify("界面", "已接管 " .. tostring(n), 2)
	end,
})

AddElement(TabInfo, "Button", {
	Title = "打印可用 API",
	Description = "输出到控制台",
	Callback = function()
		API.Help()
	end,
})

--==================== 界面（补齐） ====================--

AddSection(TabUi, "翻译")

Gui.Controls.TranslateToggle = AddElement(TabUi, "Toggle", {
	Title = "界面翻译",
	Description = "把英文 UI 逐条译成中文",
	Callback = function(on)
		API.TranslateUI(on)
	end,
})

Gui.Controls.TranslateSpeedSlider = AddElement(TabUi, "Slider", {
	Title = "翻译速度",
	Description = "默认 2",
	Min = 1,
	Max = 5,
	Default = 2,
	Callback = function(v)
		API.Config.TranslateSpeed = v
	end,
})

AddSection(TabUi, "布局与动画")

Gui.Controls.KeepPosToggle = AddElement(TabUi, "Toggle", {
	Title = "记住窗口位置",
	Description = "拖到哪就停哪，重排和切页不再弹回中间",
	Default = true,
	Callback = function(on)
		Patch.Config.KeepWindowPos = on and true or false
		if not on then
			Patch.WindowPos = nil
		end
	end,
})

AddElement(TabUi, "Button", {
	Title = "重置窗口大小与位置",
	Description = "清掉记住的尺寸/位置，回默认居中",
	Callback = function()
		Patch.WindowPos = nil
		UICfg.w, UICfg.h, UICfg.x, UICfg.y = nil, nil, nil, nil
		Patch.Config.KeepWindowPos = true
		saveUICfg()
		pcall(fitWindow)
	end,
})

Gui.Controls.PillDragToggle = AddElement(TabUi, "Toggle", {
	Title = "胶囊可拖动",
	Default = true,
	Callback = function(on)
		Patch.Config.PillDraggable = on and true or false
	end,
})

--==================== 界面 / 性能 ====================--

AddSection(TabUi, "外观")

local THEME_OPTIONS = {
	{label = "浅色 · Light", name = "Light"},
	{label = "浅色 · Balloon", name = "Balloon"},
	{label = "浅色 · SoftCream", name = "SoftCream"},
	{label = "浅色 · Cloud", name = "Cloud"},
	{label = "深色 · Dark", name = "Dark"},
	{label = "深色 · Darker", name = "Darker"},
	{label = "纯黑 · AMOLED", name = "AMOLED"},
	{label = "深色 · Midnight", name = "Midnight"},
	{label = "深色 · Ocean", name = "Ocean"},
	{label = "深色 · Forest", name = "Forest"},
	{label = "深色 · Sunset", name = "Sunset"},
	{label = "深色 · Bloody", name = "Bloody"},
	{label = "彩色 · Aqua", name = "Aqua"},
	{label = "彩色 · Amethyst", name = "Amethyst"},
	{label = "彩色 · Rose", name = "Rose"},
	{label = "彩色 · Emerald", name = "Emerald"},
	{label = "彩色 · Sapphire", name = "Sapphire"},
	{label = "彩色 · Grape", name = "Grape"},
}

local themeLabels = {}
for _, item in ipairs(THEME_OPTIONS) do
	themeLabels[#themeLabels + 1] = item.label
end

local function themeLabelOf(name)
	for _, item in ipairs(THEME_OPTIONS) do
		if item.name == name then
			return item.label
		end
	end
	return nil
end

Gui.Controls.AcrylicToggle = AddElement(TabUi, "Toggle", {
	Title = "毛玻璃（Acrylic）",
	Description = "Fluent 自带的真背景模糊，手机较吃帧；改了要重开界面才生效",
	Default = (tonumber(UICfg.acrylic) or 0) == 1,
	Callback = function(on)
		UICfg.acrylic = on and 1 or 0
		saveUICfg()
	end,
})

Gui.Controls.ThemeDropdown = AddElement(TabUi, "Dropdown", {
	Title = "界面主题",
	Description = "Fluent 原生调色板，整套切换，不逐个改色",
	Values = themeLabels,
	Default = themeLabelOf(Patch.Config.Theme) or themeLabels[1],
	Callback = function(label)
		for _, item in ipairs(THEME_OPTIONS) do
			if item.label == label then
				Patch.ApplyTheme(item.name)
				return
			end
		end
	end,
})

AddSection(TabUi, "外观")

Gui.Controls.NativeLookToggle = AddElement(TabUi, "Toggle", {
	Title = "原生外观",
	Description = "开：圆角层次、滚动条统一、标题栏两排、搜索图标左置全部跳过，界面回到 FluentPlus 原样。重开界面生效",
	Default = Patch.Config.NativeLook == true,
	Callback = function(on)
		UICfg.native = on and 1 or 0
		pcall(saveUICfg)
		notifyState("外观设置已记录，重开界面生效")
	end,
})

Gui.Controls.WindowShadowToggle = AddElement(TabUi, "Toggle", {
	Title = "窗口外阴影",
	Description = "给卡片垫一层柔光投影，边界更清楚。手机关掉能省一层全窗绘制",
	Default = Patch.Config.WindowShadow ~= false,
	Callback = function(on)
		Patch.Config.WindowShadow = on and true or false
		UICfg.winshadow = on and 1 or 0
		pcall(saveUICfg)
		pcall(applyRootShadow)
	end,
})

AddSection(TabUi, "性能")

Gui.Controls.PerfBreatheToggle = AddElement(TabUi, "Toggle", {
	Title = "胶囊呼吸动画",
	Description = "关掉后不跑循环补间",
	Default = true,
	Callback = function(on)
		Patch.Config.PillBreathe = on and true or false
		if not on then
			pcall(function()
				local pill = pillGui and pillGui:FindFirstChild("FluentMobilePill")
				if pill then
					stopBreathe(pill)
				end
			end)
		end
	end,
})

Gui.Controls.PerfSpringToggle = AddElement(TabUi, "Toggle", {
	Title = "胶囊弹簧反馈",
	Description = "关掉后彻底停掉每帧弹簧计算",
	Default = true,
	Callback = function(on)
		Patch.Config.PillSpring = on and true or false
	end,
})

Gui.Controls.LiteToggle = AddElement(TabUi, "Toggle", {
	Title = "极限模式",
	Description = "抹掉窗口与胶囊阴影、停掉呼吸/弹簧/涟漪，只留静态界面。低端机跑满帧用",
	Default = Patch.Config.Lite == true,
	Callback = function(on)
		Patch.Config.Lite = on and true or false
		UICfg.lite = on and 1 or 0
		pcall(saveUICfg)
		Patch.Config.PillBreathe = not on
		Patch.Config.PillSpring = not on
		pcall(function()
			local pill = pillGui and pillGui:FindFirstChild("FluentMobilePill")
			if pill and on then
				stopBreathe(pill)
			end
			local sh = pillGui and pillGui:FindFirstChild("FluentMobilePillShadow")
			if sh then
				sh.Visible = not on
			end
		end)
		pcall(applyRootShadow)
		notifyState(on and "极限模式已开：动画与阴影关闭" or "极限模式已关：动画恢复")
	end,
})

local instCount = 0
pcall(function()
	instCount = #Window.Root:GetDescendants()
end)

local perfBaseText = "页签 11 · 界面实例 " .. tostring(instCount) .. " 个"

Gui.Controls.PerfInfo = AddElement(TabUi, "Paragraph", {
	Title = "实时状态",
	Value = perfBaseText .. "\n帧率统计中…",
})

do
	local acc, frames, rate = 0, 0, 60
	RunService.RenderStepped:Connect(function(dt)
		acc = acc + dt
		frames = frames + 1
		if acc >= 1.5 then
			rate = math.floor(frames / acc)
			acc, frames = 0, 0
			pcall(function()
				local pInfo = Gui.Controls.PerfInfo
				if pInfo.SetContent then
					pInfo:SetContent(perfBaseText .. "\n当前帧率 " .. tostring(rate) .. " fps")
				elseif pInfo.SetDesc then
					pInfo:SetDesc(perfBaseText .. "\n当前帧率 " .. tostring(rate) .. " fps")
				end
			end)
		end
	end)
end

pcall(fitWindow)
pcall(localizeAll)
pcall(addPressAnimations, Window.Root)

--==================== 观感打磨（只碰几何与字号，不碰颜色） ====================--

local function setCorner(obj, r)
	if not obj then
		return
	end
	local c = obj:FindFirstChildOfClass("UICorner")
	if not c then
		c = Instance.new("UICorner")
		c.Parent = obj
	end
	if r >= 999 then
		c.CornerRadius = UDim.new(1, 0)
	else
		c.CornerRadius = UDim.new(0, r)
	end
end

local function unifyScrollbars(root)
	if not root then
		return
	end
	for _, d in ipairs(root:GetDescendants()) do
		if d:IsA("ScrollingFrame") then
			d.ScrollBarThickness = 6
			d.ScrollBarImageTransparency = 0.35
			pcall(function()
				d.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
			end)
		end
	end
end

local function polishUI()
	if Patch.Config.NativeLook then
		return
	end
	local root = Window.Root
	if not root then
		return
	end

	-- 圆角层次：窗口 16、内容 10、页签块 8、三键正圆
	setCorner(root, 16)
	setCorner(Window.ContainerCanvas, 10)
	if Window.TabHolder then
		for _, row in ipairs(Window.TabHolder:GetChildren()) do
			if row:IsA("TextButton") or row:IsA("Frame") then
				setCorner(row, 8)
			end
		end
	end

	-- 标题栏不在这里改：FluentPlus 没有 TitleHolder / tb.Title / tb.SubTitle，
	-- 这一段是从 Renewed 抄来的残留，在 Plus 里全部走不到，只会让人以为还有第二层控制。
	-- 标题栏的两排、字号、粗体由 fixTitleBar 单独负责（按结构重排，可跳过、可回退）。
	local tb = Window.TitleBar
	if tb then
		for _, b in ipairs({ tb.MinButton, tb.MaxButton, tb.CloseButton }) do
			if b and b.Frame then
				setCorner(b.Frame, 999)
			end
		end
	end

	unifyScrollbars(root)
end

Patch.AfterTheme = polishUI
pcall(polishUI)

-- Fluent 切主题/重建时会重刷自己的属性，主题一变就重新打一次，别让它把我们盖回去
pcall(function()
	if not Fluent.ThemeChanged then
		return
	end
	Fluent.ThemeChanged:Connect(function()
		task.defer(function()
			pcall(polishUI)
		end)
	end)
end)

-- 切页只补滚动条，不重复做圆角和字号
pcall(function()
	local origSelect = Window.SelectTab
	if typeof(origSelect) == "function" then
		Window.SelectTab = function(self, idx, ...)
			local res = origSelect(self, idx, ...)
			task.delay(0.2, function()
				pcall(unifyScrollbars, Window.Root)
			end)
			return res
		end
	end
end)

-- 屏幕尺寸变了只重排大小，不重建界面
camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
	scheduleFit(0.3)
end)

for i = 1, 11 do
	if pcall(function()
		Window:SelectTab(i)
	end) then
		break
	end
end

API.Notify("制作脚本(窗)", "已加载 v4.2.0 · FluentPlus · 18 主题", 5)
pcall(function()
	BootPanel.Finish()
end)
print(string.format("[窗] 界面就绪，总耗时 %.2fs", os.clock() - bootStart))
pcall(function()
	print(string.format("[窗] 界面实例 %d 个 · 页签 %d 个", #Window.Root:GetDescendants(), 11))
end)
print("[窗] 已加载 · Fluent 版 · getgenv().Chuang / getgenv().FluentMobile")
