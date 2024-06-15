local app = CreateWin("Clicker")
local cookieAmount = 0
local incrementAmount = 1

local scrollFrame = CreateUI(app, "ScrollingFrame")
scrollFrame.Size = UDim2.fromScale(1,1)
scrollFrame.BackgroundTransparency = 1
scrollFrame.AutomaticCanvasSize = "Y"
--scrollFrame.CanvasSize.Y = Vector2.new(1,0)
scrollFrame.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
scrollFrame.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
scrollFrame.ScrollingDirection = "Y"

local cookies = CreateUI(app, "TextLabel")
cookies.Size = UDim2.fromScale(0.6,0.2)
cookies.AnchorPoint = Vector2.new(0.5,0)
cookies.Position = UDim2.fromScale(0.5,0.1)
cookies.TextScaled = true
cookies.BackgroundTransparency = 1
cookies.TextColor3 = Color3.fromRGB(255,255,255)
cookies.Parent = scrollFrame
cookies.Text = "Cookies: "..cookieAmount

local button = CreateUI(app, "TextButton")
button.Size = UDim2.fromScale(0.7,0.4)
button.AnchorPoint = Vector2.new(0.5,0)
button.Position = UDim2.fromScale(0.5,0.45)
button.TextScaled = true
button.TextColor3 = Color3.fromRGB(255,255,255)
button.BackgroundColor3 = Color3.fromRGB(70,70,70)
button.Parent = scrollFrame
button.Text = "+"..incrementAmount.." Cookie"

local buttonStroke = CreateUI(app, "UIStroke")
buttonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
buttonStroke.Thickness = 4
buttonStroke.Color = Color3.fromRGB(50,50,50)
buttonStroke.Parent = button

local buttonCorner = CreateUI(app, "UICorner")
buttonCorner.CornerRadius = UDim.new(0.1,0)
buttonCorner.Parent = button

button.Activated:Connect(function()
 cookieAmount = cookieAmount + 1
 cookies.Text = "Cookies: "..cookieAmount
end)
