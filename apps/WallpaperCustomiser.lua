-- update test
local RegistryHandler = loadlib("RegistryHandler")
local AccountManager = loadlib("AccountManager")
local DesktopManager = loadlib("DesktopManager")
local Http = loadlib("Http")

local app = Lime.CreateWindow("Wallpaper Customiser")

local label = Lime.CreateUI(app, "TextLabel")
label.Size = UDim2.fromScale(1, 0.6)
label.BackgroundTransparency = 1
label.TextScaled = true
label.Text = "Insert a valid roblox Decal ID below!"
label.TextColor3 = Color3.fromRGB(255, 255, 255)

local box = Lime.CreateUI(app, "TextBox")
box.Size = UDim2.fromScale(1, 0.2)
box.Position = UDim2.fromScale(0, 0.6)
box.TextScaled = true
box.Text = "1234"
box.PlaceholderText = "1234"
box.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
box.TextColor3 = Color3.fromRGB(255, 255, 255)

local button = Lime.CreateUI(app, "TextButton")
button.Size = UDim2.fromScale(1, 0.2)
button.Position = UDim2.fromScale(0, 0.8)
button.TextScaled = true
button.Text = "Change wallpaper"
button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.MouseButton1Click:Connect(function()
    -- Convert Decal ID to Image ID
    -- Why the hell is this even neccesary?
    button.Text = "Please wait..."
    local imageId = Http.HttpGet("https://rbxdecal.glitch.me/"..box.Text)
    RegistryHandler.SetKey("Users/"..AccountManager.GetCurrentUser().."/UserSettings/Background","http://www.roblox.com/asset/?id="..imageId)
    RegistryHandler.SetKey("Users/"..AccountManager.GetCurrentUser().."/UserSettings/BackgroundMode", 1)
    RegistryHandler.SaveRegistry()
    DesktopManager.UpdateWallpaper()
    button.Text = "Change wallpaper"
end)
