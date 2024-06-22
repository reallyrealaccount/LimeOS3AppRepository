-- DISCLAIMER: This game is probably really easy to hack. If you are reading this and want to use the code, you should make your game more secure than this.

local fs = loadlib("FileSystem")
local http = loadlib("Http")
-- encryption lib?

local gameVersion = "1.0"

local confirmWindowCreated = false
local rebirthTextCreated = false
local upgradeTextCreated = false

local app = Lime.CreateWindow("Cookie Clicker " .. gameVersion)

-- local clickSound = Instance.new("Sound")
-- clickSound.SoundId = 6042053626
-- clickSound.Parent = app

-- local cookieSound = Instance.new("Sound")
-- cookieSound.SoundId = 6324790483
-- cookieSound.Parent = app

local data = {
    ["gameVersion"] = gameVersion,
    ["cookieAmount"] = 0,
    ["incrementAmount"] = 1,
    ["rebirths"] = 1, -- default 1 because of the multiplier thing
    ["upgrades"] = { -- amount of each upgrade (i.e. 5 cursors, 10 grandmas)
        ["cursor"] = 0,
        ["grandma"] = 0,
        ["bakery"] = 0
    }
}

print("a")

-- Loading data
if fs.FileExists(fs.GetOSDriveLetter() .. ":/System/AppData/CookieClicker.txt") then
    -- fs.DeleteObject(fs.GetOSDriveLetter() .. ":/System/AppData/CookieClicker.txt","System") --ONLY FOR TESTING, DO NOT UNCOMMENT
    local fileData = fs.GetFile(fs.GetOSDriveLetter() .. ":/System/AppData/CookieClicker.txt").Data
    if fileData == "" then
        fileData = data
    end
    local decodedData = http.JSONDecode(fileData)
    data = decodedData
    print("Save file found, loaded player data")
else
    data["cookieAmount"] = 17500
    local jsonData = http.JSONEncode(data)
    fs.CreateFile(fs.GetOSDriveLetter() .. ":/System/AppData/CookieClicker.txt", nil, "R-W", "System")
    fs.WriteFile(fs.GetOSDriveLetter() .. ":/System/AppData/CookieClicker.txt", jsonData, "System", true)
    print("Save file not found, creating new file")
end

print("aa")

-- **UI**
local scrollFrame = Lime.CreateUI(app, "ScrollingFrame")
scrollFrame.Size = UDim2.fromScale(1, 1)
scrollFrame.BackgroundTransparency = 1
scrollFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
scrollFrame.AutomaticCanvasSize = "Y"
scrollFrame.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
scrollFrame.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
scrollFrame.ScrollingDirection = "Y"

local cookies = Lime.CreateUI(app, "TextLabel")
cookies.Size = UDim2.fromScale(0.6, 0.2)
cookies.AnchorPoint = Vector2.new(0.5, 0)
cookies.Position = UDim2.fromScale(0.5, 0.1)
cookies.TextScaled = true
cookies.BackgroundTransparency = 1
cookies.TextColor3 = Color3.fromRGB(255, 255, 255)
cookies.Parent = scrollFrame
cookies.Text = "Cookies: " .. data["cookieAmount"]

local perSecondText = Lime.CreateUI(app, "TextLabel")
perSecondText.Size = UDim2.fromScale(0.5, 0.075)
perSecondText.AnchorPoint = Vector2.new(0.5, 0)
perSecondText.Position = UDim2.fromScale(0.5, 0.3)
perSecondText.TextScaled = true
perSecondText.BackgroundTransparency = 0.9
perSecondText.TextColor3 = Color3.fromRGB(255, 255, 255)
perSecondText.Parent = scrollFrame
perSecondText.Text = "Cookies per second: " .. tostring(data["upgrades"]["cursor"] + (data["upgrades"]["grandma"] * 5) + (data["upgrades"]["bakery"] * 50))

local fakebutton = Lime.CreateUI(app, "TextLabel")
-- fake button goes under the real clickable button
fakebutton.Size = UDim2.fromScale(0.7, 0.4)
fakebutton.AnchorPoint = Vector2.new(0.5, 0)
fakebutton.Position = UDim2.fromScale(0.5, 0.475)
fakebutton.Text = ""
fakebutton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
fakebutton.Parent = scrollFrame

local fakebuttonCorner = Lime.CreateUI(app, "UICorner")
fakebuttonCorner.CornerRadius = UDim.new(0.1, 0)
fakebuttonCorner.Parent = fakebutton

local button = Lime.CreateUI(app, "TextButton")
button.Size = UDim2.fromScale(0.7, 0.4)
button.AnchorPoint = Vector2.new(0.5, 0)
button.Position = UDim2.fromScale(0.5, 0.45)
button.TextScaled = true
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.AutoButtonColor = false
button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
button.Parent = scrollFrame
if data["incrementAmount"] == 1 then
    button.Text = "+" .. data["incrementAmount"] .. " Cookie"
else
    button.Text = "+" .. data["incrementAmount"] .. " Cookies"
end

local buttonStroke = Lime.CreateUI(app, "UIStroke")
buttonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
buttonStroke.Thickness = 4
buttonStroke.Color = Color3.fromRGB(50, 50, 50)
-- buttonStroke.Parent = button

local buttonCorner = Lime.CreateUI(app, "UICorner")
buttonCorner.CornerRadius = UDim.new(0.1, 0)
buttonCorner.Parent = button

local upgradesDisclaimer = Lime.CreateUI(app, "TextLabel")
upgradesDisclaimer.Size = UDim2.fromScale(0.5, 0.035)
upgradesDisclaimer.AnchorPoint = Vector2.new(0.5, 0)
upgradesDisclaimer.Position = UDim2.fromScale(0.5, 0.015)
upgradesDisclaimer.BackgroundTransparency = 1
upgradesDisclaimer.TextScaled = true
upgradesDisclaimer.TextColor3 = Color3.fromRGB(255, 255, 255)
upgradesDisclaimer.Parent = scrollFrame
upgradesDisclaimer.Text = "Scroll down for upgrades!"

local upgradesFrame = Lime.CreateUI(app, "Frame")
upgradesFrame.BackgroundTransparency = 1
upgradesFrame.AnchorPoint = Vector2.new(0.5, 0)
upgradesFrame.Position = UDim2.fromScale(0.5, 1.2)
upgradesFrame.Size = UDim2.fromScale(0.8, 0.8)
upgradesFrame.Parent = scrollFrame

local upgradesFrameTitle = Lime.CreateUI(app, "TextLabel")
upgradesFrameTitle.Size = UDim2.fromScale(1, 0.1)
upgradesFrameTitle.BackgroundTransparency = 1
upgradesFrameTitle.TextScaled = true
upgradesFrameTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
upgradesFrameTitle.Parent = upgradesFrame
upgradesFrameTitle.Text = "Upgrades"

local upgradesScrollFrame = Lime.CreateUI(app, "ScrollingFrame")
upgradesScrollFrame.Position = UDim2.fromScale(0.5, 0.15)
upgradesScrollFrame.AnchorPoint = Vector2.new(0.5, 0)
upgradesScrollFrame.Size = UDim2.fromScale(0.95, 0.8)
upgradesScrollFrame.BackgroundTransparency = 0.9
upgradesScrollFrame.AutomaticCanvasSize = "Y"
upgradesScrollFrame.CanvasSize = UDim2.new(0, 0, 1, 0)
upgradesScrollFrame.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
upgradesScrollFrame.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
upgradesScrollFrame.ScrollingDirection = "Y"
upgradesScrollFrame.Parent = upgradesFrame

local upgrades = Lime.CreateUI(app, "Frame")
upgrades.Size = UDim2.fromScale(0.9, 0.9)
upgrades.AnchorPoint = Vector2.new(0.5, 0)
upgrades.Position = UDim2.fromScale(0.5, 0.1)
upgrades.BackgroundTransparency = 1
upgrades.AutomaticSize = "Y"
upgrades.Parent = upgradesScrollFrame

local upgradesLayout = Lime.CreateUI(app, "UIGridLayout")
upgradesLayout.FillDirection = "Horizontal"
upgradesLayout.CellSize = UDim2.fromScale(0.4, 0.1)
upgradesLayout.CellPadding = UDim2.fromScale(0.035, 0.075)
upgradesLayout.Parent = upgrades

local function newUpgrade()
    local new = Lime.CreateUI(app, "TextButton")
    new.Size = UDim2.fromScale(0.4, 0.1)
    new.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

    -- might remove stroke later
    local stroke = Lime.CreateUI(app, "UIStroke")
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Thickness = 4
    stroke.Color = Color3.fromRGB(50, 50, 50)
    stroke.Parent = new

    return new
end

local cursorUpgradeText = "Cursor (50 Cookies)"
if data["upgrades"]["cursor"] > 0 then
    cursorUpgradeText = "Buy Cursor Lvl" .. (data["upgrades"]["cursor"] + 1) .. " (" .. ((data["upgrades"]["cursor"] * 50 * 1.2) * data["rebirths"]) .. " Cookies)"
end

local grandmaUpgradeText = "Grandma (250 Cookies)"
if data["upgrades"]["grandma"] > 0 then
    cursorUpgradeText = "Buy Grandma Lvl" .. (data["upgrades"]["grandma"] + 1) .. " (" .. ((data["upgrades"]["grandma"] * 250 * 1.5) * data["rebirths"]) .. " Cookies)"
end

local bakeryUpgradeText = "Bakery (2000 Cookies)"
if data["upgrades"]["bakery"] > 0 then
    cursorUpgradeText = "Buy Bakery Lvl" .. (data["upgrades"]["bakery"] + 1) .. " (" .. ((data["upgrades"]["bakery"] * 2000 * 1.5) * data["rebirths"]) .. " Cookies)"
end

local cursorUpgrade = newUpgrade()
cursorUpgrade.Parent = upgrades
cursorUpgrade.Text = cursorUpgradeText
cursorUpgrade.TextColor3 = Color3.fromRGB(255, 255, 255)

local grandmaUpgrade = newUpgrade()
grandmaUpgrade.Parent = upgrades
grandmaUpgrade.Text = grandmaUpgradeText
grandmaUpgrade.TextColor3 = Color3.fromRGB(255, 255, 255)

local bakeryUpgrade = newUpgrade()
bakeryUpgrade.Parent = upgrades
bakeryUpgrade.Text = bakeryUpgradeText
bakeryUpgrade.TextColor3 = Color3.fromRGB(255, 255, 255)

local rebirthTitle = Lime.CreateUI(app, "TextLabel")
rebirthTitle.Size = UDim2.fromScale(0.8, 0.1)
rebirthTitle.AnchorPoint = Vector2.new(0.5, 0)
rebirthTitle.Position = UDim2.fromScale(0.5, 2.05)
rebirthTitle.TextScaled = true
rebirthTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
rebirthTitle.TextWrapped = true
rebirthTitle.BackgroundTransparency = 1
rebirthTitle.Text = "Rebirth for a " .. tostring(data["rebirths"] + 1) .. "x multiplier! (Current: " .. tostring(data["rebirths"]) .. "x)"
rebirthTitle.Parent = scrollFrame

local fakerebirthbutton = Lime.CreateUI(app, "TextLabel")
-- fake button goes under the real clickable button
fakerebirthbutton.Size = UDim2.fromScale(0.5, 0.2)
fakerebirthbutton.AnchorPoint = Vector2.new(0.5, 0)
fakerebirthbutton.Position = UDim2.fromScale(0.5, 2.2)
fakerebirthbutton.Text = ""
fakerebirthbutton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
fakerebirthbutton.Parent = scrollFrame

local fakerebirthbuttonCorner = Lime.CreateUI(app, "UICorner")
fakerebirthbuttonCorner.CornerRadius = UDim.new(0.1, 0)
fakerebirthbuttonCorner.Parent = fakerebirthbutton

local rebirthButton = Lime.CreateUI(app, "TextButton")
rebirthButton.Size = UDim2.fromScale(0.5, 0.2)
rebirthButton.AnchorPoint = Vector2.new(0.5, 0)
rebirthButton.Position = UDim2.fromScale(0.5, 2.175)
rebirthButton.TextScaled = true
rebirthButton.TextColor3 = Color3.fromRGB(255, 255, 255)
rebirthButton.AutoButtonColor = false
rebirthButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
rebirthButton.Text = "Rebirth (" .. tostring(10000 * data["rebirths"] * 1.75) .. " Cookies)"
rebirthButton.Parent = scrollFrame

local rebirthButtonCorner = Lime.CreateUI(app, "UICorner")
rebirthButtonCorner.CornerRadius = UDim.new(0.1, 0)
rebirthButtonCorner.Parent = rebirthButton

print("aaa")

-- **Mechanics**
local function updateLabels()
    cookies.Text = "Cookies: " .. data["cookieAmount"]

    perSecondText.Text = "Cookies per second: " .. tostring((data["upgrades"]["cursor"] + (data["upgrades"]["grandma"] * 5) + (data["upgrades"]["bakery"] * 50)) * data["rebirths"])

    if data["incrementAmount"] == 1 then
        button.Text = "+" .. data["incrementAmount"] .. " Cookie"
    else
        button.Text = "+" .. data["incrementAmount"] .. " Cookies"
    end

    local cursorUpgradeText = "Cursor (50 Cookies)"
    if data["upgrades"]["cursor"] > 0 then
        cursorUpgradeText = "Buy Cursor Lvl" .. (data["upgrades"]["cursor"] + 1) .. " (" .. ((data["upgrades"]["cursor"] * 50 * 1.2) * data["rebirths"])  .. " Cookies)"
    end
    cursorUpgrade.Text = cursorUpgradeText

    local grandmaUpgradeText = "Grandma (250 Cookies)"
    if data["upgrades"]["grandma"] > 0 then
        grandmaUpgradeText = "Buy Grandma Lvl" .. (data["upgrades"]["grandma"] + 1) .. " (" .. ((data["upgrades"]["grandma"] * 250 * 1.5) * data["rebirths"]) .. " Cookies)"
    end
    grandmaUpgrade.Text = grandmaUpgradeText

    local bakeryUpgradeText = "Bakery (2000 Cookies)"
    if data["upgrades"]["bakery"] > 0 then
        bakeryUpgradeText = "Buy Bakery Lvl" .. (data["upgrades"]["bakery"] + 1) .. " (" .. ((data["upgrades"]["bakery"] * 2000 * 1.5) * data["rebirths"]) .. " Cookies)"
    end
    bakeryUpgrade.Text = bakeryUpgradeText

    rebirthTitle.Text = "Rebirth for a " .. tostring(data["rebirths"] + 1) .. "x multiplier! (Current: " .. tostring(data["rebirths"]) .. "x)"

    rebirthButton.Text = "Rebirth (" .. tostring(10000 * data["rebirths"] * 1.75) .. " Cookies)"
end

cursorUpgrade.Activated:Connect(function()
    -- clickSound:Play()
    if data["upgrades"]["cursor"] == 0 then
        if data["cookieAmount"] >= 50 then
            data["cookieAmount"] = data["cookieAmount"] - 50
            data["upgrades"]["cursor"] = data["upgrades"]["cursor"] + 1
            updateLabels()
        else
            if upgradeTextCreated == false then
                task.spawn(function()
                    local upgradesError = Lime.CreateUI(app, "TextLabel")
                    upgradesError.Size = UDim2.fromScale(0.8, 0.04)
                    upgradesError.AnchorPoint = Vector2.new(0.5, 0)
                    upgradesError.Position = UDim2.fromScale(0.5, 0.105)
                    upgradesError.TextColor3 = Color3.fromRGB(255, 0, 0)
                    upgradesError.BackgroundTransparency = 1
                    upgradesError.TextScaled = true
                    upgradesError.Text = "You cannot afford the Cursor upgrade! (Need " .. (50 - data["cookieAmount"]) .. " more cookies)"
                    upgradesError.Parent = upgradesFrame
                    upgradeTextCreated = true

                    task.wait(5)

                    upgradesError:Destroy()
                    upgradeTextCreated = false
                end)
            end
        end
    else
        if data["cookieAmount"] >= ((data["upgrades"]["cursor"] * 50 * 1.2) * data["rebirths"]) then
            data["cookieAmount"] = data["cookieAmount"] - ((data["upgrades"]["cursor"] * 50 * 1.2) * data["rebirths"])

            data["upgrades"]["cursor"] = data["upgrades"]["cursor"] + 1
            updateLabels()
        else
            if upgradeTextCreated == false then
                task.spawn(function()
                    local upgradesError = Lime.CreateUI(app, "TextLabel")
                    upgradesError.Size = UDim2.fromScale(0.8, 0.04)
                    upgradesError.AnchorPoint = Vector2.new(0.5, 0)
                    upgradesError.Position = UDim2.fromScale(0.5, 0.105)
                    upgradesError.TextColor3 = Color3.fromRGB(255, 0, 0)
                    upgradesError.BackgroundTransparency = 1
                    upgradesError.TextScaled = true
                    upgradesError.Text = "You cannot afford the Cursor upgrade! (Need " .. (((data["upgrades"]["cursor"] * data["rebirths"]) * 50 * 1.2) - data["cookieAmount"]) .. " more cookies)"
                    upgradesError.Parent = upgradesFrame
                    upgradeTextCreated = true

                    task.wait(5)

                    upgradesError:Destroy()
                    upgradeTextCreated = false
                end)
            end
        end
    end
end)

grandmaUpgrade.Activated:Connect(function()
    -- clickSound:Play()
    if data["upgrades"]["grandma"] == 0 then
        if data["cookieAmount"] >= 250 then
            data["cookieAmount"] = data["cookieAmount"] - 250
            data["upgrades"]["grandma"] = data["upgrades"]["grandma"] + 1
            updateLabels()
        else
            if upgradeTextCreated == false then
                task.spawn(function()
                    local upgradesError = Lime.CreateUI(app, "TextLabel")
                    upgradesError.Size = UDim2.fromScale(0.8, 0.04)
                    upgradesError.AnchorPoint = Vector2.new(0.5, 0)
                    upgradesError.Position = UDim2.fromScale(0.5, 0.105)
                    upgradesError.TextColor3 = Color3.fromRGB(255, 0, 0)
                    upgradesError.BackgroundTransparency = 1
                    upgradesError.TextScaled = true
                    upgradesError.Text = "You cannot afford the Grandma upgrade! (Need " .. (250 - data["cookieAmount"]) .. " more cookies)"
                    upgradesError.Parent = upgradesFrame
                    upgradeTextCreated = true

                    task.wait(5)

                    upgradesError:Destroy()
                    upgradeTextCreated = false
                end)
            end
        end
    else
        if data["cookieAmount"] >= ((data["upgrades"]["grandma"] * 250 * 1.5) * data["rebirths"]) then
            data["cookieAmount"] = data["cookieAmount"] - ((data["upgrades"]["grandma"] * 250 * 1.5) * data["rebirths"])

            data["upgrades"]["grandma"] = data["upgrades"]["grandma"] + 1
            updateLabels()
        else
            if upgradeTextCreated == false then
                task.spawn(function()
                    local upgradesError = Lime.CreateUI(app, "TextLabel")
                    upgradesError.Size = UDim2.fromScale(0.8, 0.04)
                    upgradesError.AnchorPoint = Vector2.new(0.5, 0)
                    upgradesError.Position = UDim2.fromScale(0.5, 0.105)
                    upgradesError.TextColor3 = Color3.fromRGB(255, 0, 0)
                    upgradesError.BackgroundTransparency = 1
                    upgradesError.TextScaled = true
                    upgradesError.Text = "You cannot afford the Grandma upgrade! (Need " .. (((data["upgrades"]["grandma"] * 250 * 1.5) * data["rebirths"]) - data["cookieAmount"]) .. " more cookies)"
                    upgradesError.Parent = upgradesFrame
                    upgradeTextCreated = true

                    task.wait(5)

                    upgradesError:Destroy()
                    upgradeTextCreated = false
                end)
            end
        end
    end
end)

bakeryUpgrade.Activated:Connect(function()
    -- clickSound:Play()
    if data["upgrades"]["bakery"] == 0 then
        if data["cookieAmount"] >= 2000 then
            data["cookieAmount"] = data["cookieAmount"] - 2000
            data["upgrades"]["bakery"] = data["upgrades"]["bakery"] + 1
            updateLabels()
        else
            if upgradeTextCreated == false then
                task.spawn(function()
                    local upgradesError = Lime.CreateUI(app, "TextLabel")
                    upgradesError.Size = UDim2.fromScale(0.8, 0.04)
                    upgradesError.AnchorPoint = Vector2.new(0.5, 0)
                    upgradesError.Position = UDim2.fromScale(0.5, 0.105)
                    upgradesError.TextColor3 = Color3.fromRGB(255, 0, 0)
                    upgradesError.BackgroundTransparency = 1
                    upgradesError.TextScaled = true
                    upgradesError.Text = "You cannot afford the Bakery upgrade! (Need " .. (2000 - data["cookieAmount"]) .. " more cookies)"
                    upgradesError.Parent = upgradesFrame
                    upgradeTextCreated = true

                    task.wait(5)

                    upgradesError:Destroy()
                    upgradeTextCreated = false
                end)
            end
        end
    else
        if data["cookieAmount"] >= ((data["upgrades"]["bakery"] * 2000 * 1.5) * data["rebirths"]) then
            data["cookieAmount"] = data["cookieAmount"] - ((data["upgrades"]["bakery"] * 2000 * 1.5) * data["rebirths"])

            data["upgrades"]["bakery"] = data["upgrades"]["bakery"] + 1
            updateLabels()
        else
            if upgradeTextCreated == false then
                task.spawn(function()
                    local upgradesError = Lime.CreateUI(app, "TextLabel")
                    upgradesError.Size = UDim2.fromScale(0.8, 0.04)
                    upgradesError.AnchorPoint = Vector2.new(0.5, 0)
                    upgradesError.Position = UDim2.fromScale(0.5, 0.105)
                    upgradesError.TextColor3 = Color3.fromRGB(255, 0, 0)
                    upgradesError.BackgroundTransparency = 1
                    upgradesError.TextScaled = true
                    upgradesError.Text = "You cannot afford the Bakery upgrade! (Need " .. (((data["upgrades"]["bakery"] * 2000 * 1.5) * data["rebirths"]) - data["cookieAmount"]) .. " more cookies)"
                    upgradesError.Parent = upgradesFrame
                    upgradeTextCreated = true

                    task.wait(5)

                    upgradesError:Destroy()
                    upgradeTextCreated = false
                end)
            end
        end
    end
end)

button.Activated:Connect(function()
    data["cookieAmount"] = data["cookieAmount"] + data["incrementAmount"]
    cookies.Text = "Cookies: " .. data["cookieAmount"]
end)

button.MouseButton1Down:Connect(function()
    button.Position = UDim2.fromScale(0.5, 0.475)
end)

button.MouseButton1Up:Connect(function()
    button.Position = UDim2.fromScale(0.5, 0.45)
end)

rebirthButton.Activated:Connect(function()
    if not confirmWindowCreated then
        if data["cookieAmount"] >= (10000 * data["rebirths"] * 1.75) then

            local rebirthWindow = Lime.CreateWindow("Confirm Rebirth - Cookie Clicker " .. gameVersion)

            confirmWindowCreated = true

            local textlabel = Lime.CreateUI(rebirthWindow, "TextLabel")
            textlabel.Size = UDim2.fromScale(0.6, 0.2)
            textlabel.AnchorPoint = Vector2.new(0.5, 0)
            textlabel.Position = UDim2.fromScale(0.5, 0.1)
            textlabel.TextScaled = true
            textlabel.BackgroundTransparency = 1
            textlabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            textlabel.Text = "This will reset your progress but give you an additional multiplier, are you sure you would like to continue?"
            textlabel.Parent = rebirthWindow

            local rebirthfakebutton = Lime.CreateUI(app, "TextLabel")
            -- fake button goes under the real clickable button
            rebirthfakebutton.Size = UDim2.fromScale(0.7, 0.4)
            rebirthfakebutton.AnchorPoint = Vector2.new(0.5, 0)
            rebirthfakebutton.Position = UDim2.fromScale(0.5, 0.475)
            rebirthfakebutton.Text = ""
            rebirthfakebutton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            rebirthfakebutton.Parent = rebirthWindow

            local rebirthfakebuttonCorner = Lime.CreateUI(app, "UICorner")
            rebirthfakebuttonCorner.CornerRadius = UDim.new(0.1, 0)
            rebirthfakebuttonCorner.Parent = rebirthfakebutton

            local rebirthConfirm = Lime.CreateUI(app, "TextButton")
            rebirthConfirm.Size = UDim2.fromScale(0.7, 0.4)
            rebirthConfirm.AnchorPoint = Vector2.new(0.5, 0)
            rebirthConfirm.Position = UDim2.fromScale(0.5, 0.45)
            rebirthConfirm.TextScaled = true
            rebirthConfirm.TextColor3 = Color3.fromRGB(255, 255, 255)
            rebirthConfirm.AutoButtonColor = false
            rebirthConfirm.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            rebirthConfirm.Text = "Confirm Rebirth"
            rebirthConfirm.Parent = rebirthWindow

            local rebirthbuttonCorner = Lime.CreateUI(app, "UICorner")
            rebirthbuttonCorner.CornerRadius = UDim.new(0.1, 0)
            rebirthbuttonCorner.Parent = rebirthConfirm

            rebirthConfirm.MouseButton1Down:Connect(function()
                rebirthConfirm.Position = UDim2.fromScale(0.5, 0.475)
            end)

            rebirthConfirm.MouseButton1Up:Connect(function()
                rebirthConfirm.Position = UDim2.fromScale(0.5, 0.45)
            end)

            rebirthConfirm.Activated:Connect(function()
                data["cookieAmount"] = 0
                data["rebirths"] = data["rebirths"] + 1
                data["incrementAmount"] = data["rebirths"]
                data["upgrades"] = {
                    ["cursor"] = 0,
                    ["grandma"] = 0,
                    ["bakery"] = 0
                }

                loadlib("ApplicationHandler").ExitProcess(rebirthWindow.Value.Value)
                confirmWindowCreated = false
                updateLabels()
            end)
        else
            if rebirthTextCreated == false then
                rebirthTextCreated = true

                task.spawn(function()
                    local rebirthError = Lime.CreateUI(app, "TextLabel")
                    rebirthError.Size = UDim2.fromScale(0.8, 0.04)
                    rebirthError.AnchorPoint = Vector2.new(0.5, 0)
                    rebirthError.Position = UDim2.fromScale(0.5, 2.135)
                    rebirthError.TextColor3 = Color3.fromRGB(255, 0, 0)
                    rebirthError.BackgroundTransparency = 1
                    rebirthError.TextScaled = true
                    rebirthError.Text = "You cannot afford to rebirth! (Need " .. tostring((10000 * data["rebirths"] * 1.75) - data["cookieAmount"]) .. " more cookies)"
                    rebirthError.Parent = scrollFrame

                    task.wait(5)

                    rebirthError:Destroy()
                    rebirthTextCreated = false
                end)
            end
        end
    end
end)

rebirthButton.MouseButton1Down:Connect(function()
    rebirthButton.Position = UDim2.fromScale(0.5, 2.2)
end)

rebirthButton.MouseButton1Up:Connect(function()
    rebirthButton.Position = UDim2.fromScale(0.5, 2.175)
end)

while app:GetChildren()[1] ~= nil do
    task.wait(1)
    -- print(http.JSONEncode(data))

    data["cookieAmount"] = data["cookieAmount"] + ((data["upgrades"]["cursor"] + (data["upgrades"]["grandma"] * 5) + (data["upgrades"]["bakery"] * 50)) * data["rebirths"])

    updateLabels()

    local jsonData = http.JSONEncode(data)
    fs.WriteFile(fs.GetOSDriveLetter() .. ":/System/AppData/CookieClicker.txt", jsonData, "System", true)
    -- print(fs.GetFile("fs.GetOSDriveLetter() .. :/System/AppData/CookieClicker.txt").Data)
end
