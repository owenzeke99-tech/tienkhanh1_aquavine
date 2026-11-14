local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

-- Cấu hình Key, Link mới & Tên file lưu cache 24h
local CorrectKey = "DivineHubKeyDjwkwowj - LalwiwowoBekwiejeo"
local KeyLink = "https://link4m.org/BV7Fd0"
local SaveFileName = "DivineHub_KeyCache.json"

-- Hàm kiểm tra và lưu cache 24h (nếu executor hỗ trợ writefile/readfile)
local function CheckSavedKey()
	if writefile and readfile and isfile and isfile(SaveFileName) then
		local success, data = pcall(function()
			return HttpService:JSONDecode(readfile(SaveFileName))
		end)
		if success and data and data.Key == CorrectKey then
			-- Kiểm tra thời gian hết hạn (24 giờ = 86400 giây)
			if os.time() - data.Time < 86400 then
				return true
			end
		end
	end
	return false
end

local function SaveKeyCache()
	if writefile then
		local data = {
			Key = CorrectKey,
			Time = os.time()
		}
		pcall(function()
			writefile(SaveFileName, HttpService:JSONEncode(data))
		end)
	end
end

-- Nếu đã lưu key hợp lệ trong vòng 24h thì bỏ qua bảng Key và chạy luôn script chính
if CheckSavedKey() then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/Aquavine/main/DivineHub"))()
	return
end

-- Xóa UI cũ nếu đã tồn tại
if CoreGui:FindFirstChild("DivineHubUI") then
	CoreGui.DivineHubUI:Destroy()
end

-- Khởi tạo ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DivineHubUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Khung chính (Xanh pha tím + Trong suốt)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 360, 0, 230)
MainFrame.BackgroundColor3 = Color3.fromRGB(17, 20, 39)
MainFrame.BackgroundTransparency = 0.18
MainFrame.BorderSizePixel = 0

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

-- Viền sáng tinh tế
local MainStroke = Instance.new("UIStroke")
MainStroke.Parent = MainFrame
MainStroke.Color = Color3.fromRGB(129, 140, 248)
MainStroke.Transparency = 0.6
MainStroke.Thickness = 1.5

-- Đổ bóng mềm phía sau
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Parent = MainFrame
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.BackgroundTransparency = 1
Shadow.Position = UDim2.new(0.5, 0, 0.5, 4)
Shadow.Size = UDim2.new(1, 36, 1, 36)
Shadow.ZIndex = 0
Shadow.Image = "rbxassetid://6015897843"
Shadow.ImageColor3 = Color3.fromRGB(5, 8, 20)
Shadow.ImageTransparency = 0.35
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(49, 49, 450, 450)

-- Nút đóng (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(1, -35, 0, 10)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(148, 163, 184)
CloseBtn.TextStrokeTransparency = 1
CloseBtn.TextSize = 22

CloseBtn.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

-- Tiêu đề "DIVINE HUB"
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 18)
Title.Size = UDim2.new(1, 0, 0, 32)
Title.Font = Enum.Font.GothamBlack
Title.Text = "DIVINE HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextStrokeTransparency = 1
Title.TextSize = 24

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(224, 231, 255)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(165, 180, 252)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(216, 180, 254))
})
TitleGradient.Parent = Title

-- Phụ đề nhỏ (Tiếng Anh)
local SubTitle = Instance.new("TextLabel")
SubTitle.Name = "SubTitle"
SubTitle.Parent = MainFrame
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(0, 0, 0, 48)
SubTitle.Size = UDim2.new(1, 0, 0, 18)
SubTitle.Font = Enum.Font.GothamMedium
SubTitle.Text = "SECURE KEY SYSTEM"
SubTitle.TextColor3 = Color3.fromRGB(148, 163, 184)
SubTitle.TextStrokeTransparency = 1
SubTitle.TextSize = 11

-- Ô nhập Key
local KeyBox = Instance.new("TextBox")
KeyBox.Name = "KeyBox"
KeyBox.Parent = MainFrame
KeyBox.AnchorPoint = Vector2.new(0.5, 0)
KeyBox.BackgroundColor3 = Color3.fromRGB(26, 31, 58)
KeyBox.BackgroundTransparency = 0.25
KeyBox.Position = UDim2.new(0.5, 0, 0, 82)
KeyBox.Size = UDim2.new(0.84, 0, 0, 38)
KeyBox.Font = Enum.Font.GothamMedium
KeyBox.PlaceholderText = "Enter your key here..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(100, 116, 139)
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(241, 245, 249)
KeyBox.TextStrokeTransparency = 1
KeyBox.ClearTextOnFocus = false
KeyBox.MultiLine = false
KeyBox.BorderSizePixel = 0

local KeyBoxCorner = Instance.new("UICorner")
KeyBoxCorner.CornerRadius = UDim.new(0, 8)
KeyBoxCorner.Parent = KeyBox

local KeyBoxStroke = Instance.new("UIStroke")
KeyBoxStroke.Parent = KeyBox
KeyBoxStroke.Color = Color3.fromRGB(79, 70, 229)
KeyBoxStroke.Transparency = 0.5
KeyBoxStroke.Thickness = 1

KeyBox.Focused:Connect(function()
	TweenService:Create(KeyBoxStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(129, 140, 248), Transparency = 0}):Play()
end)
KeyBox.FocusLost:Connect(function()
	TweenService:Create(KeyBoxStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(79, 70, 229), Transparency = 0.5}):Play()
end)

-- Khu vực chứa 2 nút bấm ngang hàng
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Name = "ButtonContainer"
ButtonContainer.Parent = MainFrame
ButtonContainer.AnchorPoint = Vector2.new(0.5, 0)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Position = UDim2.new(0.5, 0, 0, 134)
ButtonContainer.Size = UDim2.new(0.84, 0, 0, 36)

-- Nút Get Key
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Name = "GetKeyBtn"
GetKeyBtn.Parent = ButtonContainer
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(26, 31, 58)
GetKeyBtn.BackgroundTransparency = 0.2
GetKeyBtn.Position = UDim2.new(0, 0, 0, 0)
GetKeyBtn.Size = UDim2.new(0.48, 0, 1, 0)
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Text = "Get Key"
GetKeyBtn.TextColor3 = Color3.fromRGB(203, 213, 225)
GetKeyBtn.TextStrokeTransparency = 1
GetKeyBtn.TextSize = 13
GetKeyBtn.AutoButtonColor = false

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 8)
GetKeyCorner.Parent = GetKeyBtn

local GetKeyStroke = Instance.new("UIStroke")
GetKeyStroke.Parent = GetKeyBtn
GetKeyStroke.Color = Color3.fromRGB(79, 70, 229)
GetKeyStroke.Transparency = 0.5
GetKeyStroke.Thickness = 1

-- Nút Check Key
local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Name = "SubmitBtn"
SubmitBtn.Parent = ButtonContainer
SubmitBtn.BackgroundColor3 = Color3.fromRGB(99, 102, 241)
SubmitBtn.BackgroundTransparency = 0.1
SubmitBtn.Position = UDim2.new(0.52, 0, 0, 0)
SubmitBtn.Size = UDim2.new(0.48, 0, 1, 0)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.Text = "Check Key"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.TextStrokeTransparency = 1
SubmitBtn.TextSize = 13
SubmitBtn.AutoButtonColor = false

local SubmitCorner = Instance.new("UICorner")
SubmitCorner.CornerRadius = UDim.new(0, 8)
SubmitCorner.Parent = SubmitBtn

-- HỆ THỐNG THÔNG BÁO NỔI HIỆN ĐẠI (MODERN TOAST NOTIFICATION)
local ToastFrame = Instance.new("Frame")
ToastFrame.Name = "ToastFrame"
ToastFrame.Parent = MainFrame
ToastFrame.AnchorPoint = Vector2.new(0.5, 0)
ToastFrame.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
ToastFrame.BackgroundTransparency = 0.15
ToastFrame.Position = UDim2.new(0.5, 0, 0, 180)
ToastFrame.Size = UDim2.new(0.84, 0, 0, 36)
ToastFrame.Visible = false
ToastFrame.ClipsDescendants = true

local ToastCorner = Instance.new("UICorner")
ToastCorner.CornerRadius = UDim.new(0, 8)
ToastCorner.Parent = ToastFrame

local ToastStroke = Instance.new("UIStroke")
ToastStroke.Parent = ToastFrame
ToastStroke.Color = Color3.fromRGB(244, 63, 94)
ToastStroke.Transparency = 0.3
ToastStroke.Thickness = 1.2

local ToastLabel = Instance.new("TextLabel")
ToastLabel.Name = "ToastLabel"
ToastLabel.Parent = ToastFrame
ToastLabel.BackgroundTransparency = 1
ToastLabel.Position = UDim2.new(0, 12, 0, 0)
ToastLabel.Size = UDim2.new(1, -24, 1, 0)
ToastLabel.Font = Enum.Font.GothamBold
ToastLabel.Text = ""
ToastLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ToastLabel.TextSize = 12
ToastLabel.TextXAlignment = Enum.TextXAlignment.Left
ToastLabel.TextStrokeTransparency = 1

local function ShowToast(text, isSuccess)
	ToastLabel.Text = text
	ToastStroke.Color = isSuccess and Color3.fromRGB(74, 222, 128) or Color3.fromRGB(244, 63, 94)
	ToastFrame.Visible = true
	ToastFrame.Size = UDim2.new(0.84, 0, 0, 0)
	ToastFrame.BackgroundTransparency = 1
	ToastLabel.TextTransparency = 1

	TweenService:Create(ToastFrame, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Size = UDim2.new(0.84, 0, 0, 36),
		BackgroundTransparency = 0.15
	}):Play()
	TweenService:Create(ToastLabel, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
end

local function AddHoverEffect(btn, normalColor, hoverColor)
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = normalColor}):Play()
	end)
end

AddHoverEffect(GetKeyBtn, Color3.fromRGB(26, 31, 58), Color3.fromRGB(39, 46, 84))
AddHoverEffect(SubmitBtn, Color3.fromRGB(99, 102, 241), Color3.fromRGB(129, 140, 248))

-- Hiệu ứng lắc kết hợp tự động xóa chữ khi sai key
local isShaking = false
local function ShakeUI()
	if isShaking then return end
	isShaking = true

	local originalPos = MainFrame.Position
	local shakeOffsets = {-12, 12, -10, 10, -6, 6, -3, 3, 0}

	TweenService:Create(MainStroke, TweenInfo.new(0.12), {Color = Color3.fromRGB(244, 63, 94), Transparency = 0.15}):Play()
	TweenService:Create(KeyBoxStroke, TweenInfo.new(0.12), {Color = Color3.fromRGB(244, 63, 94), Transparency = 0.15}):Play()

	task.spawn(function()
		for _, offset in ipairs(shakeOffsets) do
			local targetPos = UDim2.new(originalPos.X.Scale, originalPos.X.Offset + offset, originalPos.Y.Scale, originalPos.Y.Offset)
			local tween = TweenService:Create(MainFrame, TweenInfo.new(0.035, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = targetPos})
			tween:Play()
			tween.Completed:Wait()
		end
	end)

	KeyBox.Text = ""
	ShowToast("❌ Invalid Key! Please try again.", false)

	task.delay(0.8, function()
		if MainFrame and MainFrame.Parent then
			TweenService:Create(MainStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(129, 140, 248), Transparency = 0.6}):Play()
			TweenService:Create(KeyBoxStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(79, 70, 229), Transparency = 0.5}):Play()
		end
	end)

	isShaking = false
end

-- Hiệu ứng mở menu
MainFrame.Size = UDim2.new(0, 320, 0, 200)
MainFrame.BackgroundTransparency = 1
TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	Size = UDim2.new(0, 360, 0, 230),
	BackgroundTransparency = 0.18
}):Play()

-- Xử lý nút Get Key (với link mới)
GetKeyBtn.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard(KeyLink)
		ShowToast("🔗 Key link copied to clipboard!", true)
	else
		ShowToast("⚠️ Executor does not support clipboard!", false)
	end
end)

-- Xử lý nút Check Key & Lưu cache 24h
SubmitBtn.MouseButton1Click:Connect(function()
	if KeyBox.Text == CorrectKey then
		ShowToast("✅ Success! Loading Divine Hub...", true)
		SaveKeyCache() -- Lưu key để 24h sau tự động vượt
		
		TweenService:Create(MainStroke, TweenInfo.new(0.25), {Color = Color3.fromRGB(74, 222, 128), Transparency = 0.2}):Play()
		task.wait(0.8)

		local closeTween = TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Size = UDim2.new(0, 320, 0, 200),
			BackgroundTransparency = 1
		})
		closeTween:Play()
		closeTween.Completed:Wait()
		ScreenGui:Destroy()

		-- Chạy script chính
		loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/Aquavine/main/DivineHub"))()
	else
		ShakeUI()
	end
end)
