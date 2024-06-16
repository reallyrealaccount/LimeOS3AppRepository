local fs = loadlib("FileSystem")
local http = loadlib("Http")

local app = Lime.CreateWindow("Cookie Clicker 1.0")

local data = {
 ["cookieAmount"] = 0,
 ["incrementAmount"] = 1,
 ["upgrades"] = {
  ["cursor"] = 0,
  ["grandma"] = 0,
  ["bakery"] = 0,
 }
}

-- Loading data
if fs.FileExists("C:/System/AppData/CookieClicker.txt") then
 --fs.DeleteObject("C:/System/AppData/CookieClicker.txt","System")
 local fileData = fs.GetFile("C:/System/AppData/CookieClicker.txt").Data
 if fileData == "" then fileData = data end
 local decodedData = http.JSONDecode(fileData)
 data = decodedData
 print("Save file has been found, loaded player data")
else
 local jsonData = http.JSONEncode(data)
 fs.CreateFile("C:/System/AppData/CookieClicker.txt", nil, "R-W", "System")
 fs.WriteFile("C:/System/AppData/CookieClicker.txt", jsonData,
"System", true)
 print("Save file not found, creating new file")
end

-- UI
local scrollFrame = Lime.CreateUI(app, "ScrollingFrame")
scrollFrame.Size = UDim2.fromScale(1,1)
scrollFrame.BackgroundTransparency = 1
scrollFrame.CanvasSize = UDim2.new(0,0,2,0)
scrollFrame.AutomaticCanvasSize = "Y"
scrollFrame.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
scrollFrame.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
scrollFrame.ScrollingDirection = "Y"

local cookies = Lime.CreateUI(app, "TextLabel")
cookies.Size = UDim2.fromScale(0.6,0.2)
cookies.AnchorPoint = Vector2.new(0.5,0)
cookies.Position = UDim2.fromScale(0.5,0.1)
cookies.TextScaled = true
cookies.BackgroundTransparency = 1
cookies.TextColor3 = Color3.fromRGB(255,255,255)
cookies.Parent = scrollFrame
cookies.Text = "Cookies: "..data["cookieAmount"]

local perSecondText = Lime.CreateUI(app, "TextLabel")
perSecondText.Size = UDim2.fromScale(0.5,0.075)
perSecondText.AnchorPoint = Vector2.new(0.5,0)
perSecondText.Position = UDim2.fromScale(0.5,0.3)
perSecondText.TextScaled = true
perSecondText.BackgroundTransparency = 0.9
perSecondText.TextColor3 = Color3.fromRGB(255,255,255)
perSecondText.Parent = scrollFrame
perSecondText.Text = "Cookies per second: "
..tostring(data["upgrades"]["cursor"] + (data["upgrades"]["grandma"] * 5) + 
(data["upgrades"]["bakery"] * 100))

local fakebutton = Lime.CreateUI(app, "TextLabel")
-- fake button goes under the real clickable button
fakebutton.Size = UDim2.fromScale(0.7,0.4)
fakebutton.AnchorPoint = Vector2.new(0.5,0)
fakebutton.Position = UDim2.fromScale(0.5,0.475)
fakebutton.Text = ""
fakebutton.BackgroundColor3 = Color3.fromRGB(50,50,50)
fakebutton.Parent = scrollFrame

local fakebuttonCorner = Lime.CreateUI(app, "UICorner")
fakebuttonCorner.CornerRadius = UDim.new(0.1,0)
fakebuttonCorner.Parent = fakebutton

local button = Lime.CreateUI(app, "TextButton")
button.Size = UDim2.fromScale(0.7,0.4)
button.AnchorPoint = Vector2.new(0.5,0)
button.Position = UDim2.fromScale(0.5,0.45)
button.TextScaled = true
button.TextColor3 = Color3.fromRGB(255,255,255)
button.AutoButtonColor = false
button.BackgroundColor3 = Color3.fromRGB(70,70,70)
button.Parent = scrollFrame
if data["incrementAmount"] == 1 then
 button.Text = "+"..data["incrementAmount"].." Cookie"
else
 button.Text = "+"..data["incrementAmount"].." Cookies"
end

local buttonStroke = Lime.CreateUI(app, "UIStroke")
buttonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
buttonStroke.Thickness = 4
buttonStroke.Color = Color3.fromRGB(50,50,50)
--buttonStroke.Parent = button

local buttonCorner = Lime.CreateUI(app, "UICorner")
buttonCorner.CornerRadius = UDim.new(0.1,0)
buttonCorner.Parent = button

local upgradesDisclaimer = Lime.CreateUI(app, "TextLabel")
upgradesDisclaimer.Size = UDim2.fromScale(0.5,0.035)
upgradesDisclaimer.AnchorPoint = Vector2.new(0.5,0)
upgradesDisclaimer.Position = UDim2.fromScale(0.5,0.015)
upgradesDisclaimer.BackgroundTransparency = 1
upgradesDisclaimer.TextScaled = true
upgradesDisclaimer.TextColor3 = Color3.fromRGB(255,255,255)
upgradesDisclaimer.Parent = scrollFrame
upgradesDisclaimer.Text = "Scroll down for upgrades!"

local upgradesFrame = Lime.CreateUI(app, "Frame")
upgradesFrame.BackgroundTransparency = 1
upgradesFrame.AnchorPoint = Vector2.new(0.5,0)
upgradesFrame.Position = UDim2.fromScale(0.5,1.2)
upgradesFrame.Size = UDim2.fromScale(0.8,0.8)
upgradesFrame.Parent = scrollFrame

local upgradesFrameTitle = Lime.CreateUI(app, "TextLabel")
upgradesFrameTitle.Size = UDim2.fromScale(1,0.1)
upgradesFrameTitle.BackgroundTransparency = 1
upgradesFrameTitle.TextScaled = true
upgradesFrameTitle.TextColor3 = Color3.fromRGB(255,255,255)
upgradesFrameTitle.Parent = upgradesFrame
upgradesFrameTitle.Text = "Upgrades"

local upgradesScrollFrame = Lime.CreateUI(app, "ScrollingFrame")
upgradesScrollFrame.Position = UDim2.fromScale(0.5,0.15)
upgradesScrollFrame.AnchorPoint = Vector2.new(0.5,0)
upgradesScrollFrame.Size = UDim2.fromScale(0.95,0.8)
upgradesScrollFrame.BackgroundTransparency = 0.9
upgradesScrollFrame.AutomaticCanvasSize = "Y"
upgradesScrollFrame.CanvasSize = UDim2.new(0,0,1,0)
upgradesScrollFrame.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
upgradesScrollFrame.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
upgradesScrollFrame.ScrollingDirection = "Y"
upgradesScrollFrame.Parent = upgradesFrame

local upgrades = Lime.CreateUI(app, "Frame")
upgrades.Size = UDim2.fromScale(0.9,0.9)
upgrades.AnchorPoint = Vector2.new(0.5,0)
upgrades.Position = UDim2.fromScale(0.5,0.1)
upgrades.BackgroundTransparency = 1
upgrades.AutomaticSize = "Y"
upgrades.Parent = upgradesScrollFrame

local upgradesLayout = Lime.CreateUI(app, "UIGridLayout")
upgradesLayout.FillDirection = "Horizontal"
upgradesLayout.CellSize = UDim2.fromScale(0.4,0.1)
upgradesLayout.CellPadding = UDim2.fromScale(0.035,0.075)
upgradesLayout.Parent = upgrades

local function newUpgrade()
 local new = Lime.CreateUI(app, "TextButton")
 new.Size = UDim2.fromScale(0.4,0.1)
 new.BackgroundColor3 = Color3.fromRGB(50,50,50)

-- might remove stroke later
 local stroke = Lime.CreateUI(app, "UIStroke")
 stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
 stroke.Thickness = 4
 stroke.Color = Color3.fromRGB(50,50,50)
 stroke.Parent = new

 return new
end

local cursorUpgradeText = "Cursor (50 Cookies)"
if data["upgrades"]["cursor"] > 0 then
    cursorUpgradeText = "Cursor " .. (data["upgrades"]["cursor"] + 1) ..
" (" .. (data["upgrades"]["cursor"] * 50 * 1.5) .. " Cookies)"
end

local grandmaUpgradeText = "Grandma (250 Cookies)"
if data["upgrades"]["grandma"] > 0 then
    cursorUpgradeText = "Grandma " .. (data["upgrades"]["grandma"] + 1) ..
" (" .. (data["upgrades"]["grandma"] * 250 * 1.5) .. " Cookies)"
end

local bakeryUpgradeText = "Bakery (2000 Cookies)"
if data["upgrades"]["bakery"] > 0 then
    cursorUpgradeText = "Bakery " .. (data["upgrades"]["bakery"] + 1) ..
" (" .. (data["upgrades"]["bakery"] * 2000 * 1.5) .. " Cookies)"
end

local cursorUpgrade = newUpgrade()
cursorUpgrade.Parent = upgrades
cursorUpgrade.Text = cursorUpgradeText
cursorUpgrade.TextColor3 = Color3.fromRGB(255,255,255)

local grandmaUpgrade = newUpgrade()
grandmaUpgrade.Parent = upgrades
grandmaUpgrade.Text = grandmaUpgradeText
grandmaUpgrade.TextColor3 = Color3.fromRGB(255,255,255)

local bakeryUpgrade = newUpgrade()
bakeryUpgrade.Parent = upgrades
bakeryUpgrade.Text = bakeryUpgradeText
bakeryUpgrade.TextColor3 = Color3.fromRGB(255,255,255)

-- Mechanics
button.Activated:Connect(function()
 data["cookieAmount"] = data["cookieAmount"] + data["incrementAmount"]
 cookies.Text = "Cookies: "..data["cookieAmount"]
end)

button.MouseButton1Down:Connect(function()
 button.Position = UDim2.fromScale(0.5,0.475)
end)

button.MouseButton1Up:Connect(function()
 button.Position = UDim2.fromScale(0.5,0.45)
end)

while task.wait(1) do
 --print(http.JSONEncode(data))   
 data["cookieAmount"] = data["cookieAmount"] +
data["upgrades"]["cursor"] + (data["upgrades"]["grandma"] * 5) +
(data["upgrades"]["bakery"] * 100)
 
 perSecondText.Text = "Cookies per second: "
..tostring(data["upgrades"]["cursor"] + (data["upgrades"]["grandma"] * 5) + 
(data["upgrades"]["bakery"] * 100))

 local jsonData = http.JSONEncode(data)
 fs.WriteFile("C:/System/AppData/CookieClicker.txt", jsonData,
"System", true)
 --print(fs.GetFile("C:/System/AppData/CookieClicker.txt").Data)
end
