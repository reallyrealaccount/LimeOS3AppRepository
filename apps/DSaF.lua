local HttpService = GetService("HttpService")
local UserInputService = GetService("UserInputService")
local fullscreen = false
save = {name = "kevin", money = 0, night = 0, tour_finished = false}
local money = 0
local name = "missingno"
local night = 0
local tour_finished = false
local app = createapp("DSaF LimeOS Edition")
local frame = new("Frame", app)
frame.Size = UDim2.fromScale(1, 1)
frame.Position = UDim2.fromScale(0, 0)
frame.BorderSizePixel = 0
local info = new("TextLabel", app)
info.Size = UDim2.fromScale(1, 0.5)
info.Position = UDim2.fromScale(0, 0)
info.Text =
    "hello welcome to the ugly launch screen anyway this game isnt official and it sux so like eh"
info.TextScaled = true
local play = new("TextButton", app)
play.Size = UDim2.fromScale(1, 0.5)
play.Position = UDim2.fromScale(0, 0.5)
play.Text = "play the game lol"
play.TextScaled = true
play.MouseButton1Click:Connect(function() menu() end)
function menu()
    app:ClearAllChildren()
    local frame = new("Frame", app)
    frame.Size = UDim2.fromScale(1, 1)
    frame.Position = UDim2.fromScale(0, 0)
    frame.BorderSizePixel = 0
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    local bg = new("ImageLabel", app)
    bg.Size = UDim2.fromScale(1, 1)
    bg.Position = UDim2.fromScale(0, 0)
    bg.Image = "http://www.roblox.com/asset/?id=4670130618"
    bg.BackgroundTransparency = 1
    local title = new("TextLabel", app)
    title.Size = UDim2.fromScale(1, 0.2)
    title.Position = UDim2.fromScale(0, 0.2)
    title.Text = "DSaF LimeOS Edition!"
    title.TextScaled = true
    title.BorderSizePixel = 0
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    local options_frame = new("Frame", app)
    options_frame.Size = UDim2.fromScale(0.8, 0.4)
    options_frame.Position = UDim2.fromScale(0.1, 0.5)
    options_frame.BorderSizePixel = 5
    options_frame.BorderColor3 = Color3.fromRGB(65, 70, 75)
    options_frame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    local play_button = new("TextButton", options_frame)
    play_button.Size = UDim2.fromScale(1, 0.25)
    play_button.Position = UDim2.fromScale(0, 0.1)
    play_button.Text = "Play!"
    play_button.TextScaled = true
    play_button.BorderSizePixel = 0
    play_button.BackgroundTransparency = 1
    play_button.TextColor3 = Color3.fromRGB(255, 255, 255)
    play_button.MouseButton1Click:Connect(function() play() end)
    local options = new("TextButton", options_frame)
    options.Size = UDim2.fromScale(1, 0.25)
    options.Position = UDim2.fromScale(0, 0.35)
    options.Text = "Options!"
    options.TextScaled = true
    options.BorderSizePixel = 0
    options.BackgroundTransparency = 1
    options.TextColor3 = Color3.fromRGB(255, 255, 255)
    options.MouseButton1Click:Connect(function() optionsmenu() end)
    local exit = new("TextButton", options_frame)
    exit.Size = UDim2.fromScale(1, 0.25)
    exit.Position = UDim2.fromScale(0, 0.6)
    exit.Text = "Exit :("
    exit.TextScaled = true
    exit.BorderSizePixel = 0
    exit.BackgroundTransparency = 1
    exit.TextColor3 = Color3.fromRGB(255, 255, 255)
    exit.MouseButton1Click:Connect(function()
        local LimeExplorer = loadlib("LimeExplorer")
        LimeExplorer.CloseApp("DSaF LimeOS Edition")
        --uisfolder().HomeScreen.MainFrame.Visible = true
    end)
end
function optionsmenu()
    app:ClearAllChildren()
    local frame = new("Frame", app)
    frame.Size = UDim2.fromScale(1, 1)
    frame.Position = UDim2.fromScale(0, 0)
    frame.BorderSizePixel = 0
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    local bg = new("ImageLabel", app)
    bg.Size = UDim2.fromScale(1, 1)
    bg.Position = UDim2.fromScale(0, 0)
    bg.Image = "http://www.roblox.com/asset/?id=4670130618"
    bg.BackgroundTransparency = 1
    local title = new("TextLabel", app)
    title.Size = UDim2.fromScale(1, 0.2)
    title.Position = UDim2.fromScale(0, 0.2)
    title.Text = "Options!"
    title.TextScaled = true
    title.BorderSizePixel = 0
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    local options_frame = new("Frame", app)
    options_frame.Size = UDim2.fromScale(0.8, 0.45)
    options_frame.Position = UDim2.fromScale(0.1, 0.5)
    options_frame.BorderSizePixel = 5
    options_frame.BorderColor3 = Color3.fromRGB(65, 70, 75)
    options_frame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    local fullscreen_button = new("TextButton", options_frame)
    fullscreen_button.Size = UDim2.fromScale(1, 0.25)
    fullscreen_button.Position = UDim2.fromScale(0, 0.1)
    fullscreen_button.Text = "Fullscreen: off"
    fullscreen_button.TextScaled = true
    fullscreen_button.BorderSizePixel = 0
    fullscreen_button.BackgroundTransparency = 1
    fullscreen_button.TextColor3 = Color3.fromRGB(255, 255, 255)
    fullscreen_button.MouseButton1Click:Connect(function()
        if fullscreen then
            fullscreen = false
            fullscreen_button.Text = "Fullscreen: off"
            --uisfolder().HomeScreen.MainFrame.Visible = true
            app.Parent.Size = UDim2.new(0, 320, 0, 330)
            app.Parent.TopBar.Visible = true
            app.Size = UDim2.fromScale(1, 1)
            app.Position = UDim2.fromScale(0, 0)
        else
            fullscreen = true
            fullscreen_button.Text = "Fullscreen: on"
            --uisfolder().HomeScreen.MainFrame.Visible = false
            app.Parent.Size = UDim2.fromScale(1, 1)
            app.Parent.Position = UDim2.fromScale(0, 0)
            app.Parent.TopBar.Visible = false
            app.Size = UDim2.fromScale(0.6, 1)
            app.Position = UDim2.fromScale(0.2, 0)
        end
    end)
    local back = new("TextButton", options_frame)
    back.Size = UDim2.fromScale(1, 0.25)
    back.Position = UDim2.fromScale(0, 0.6)
    back.Text = "Back!"
    back.TextScaled = true
    back.BorderSizePixel = 0
    back.BackgroundTransparency = 1
    back.TextColor3 = Color3.fromRGB(255, 255, 255)
    back.MouseButton1Click:Connect(function() menu() end)
end
function play()
    --[[if uisfolder().Apps.Explorer.MainFrame.System_Folder:FindFirstChild(
        "DSaF_Saves") and
        uisfolder().Apps.Explorer.MainFrame.System_Folder.DSaF_Saves:FindFirstChild(
            "save.json") then
        save = HttpService:JSONDecode(uisfolder().Apps.Explorer.MainFrame
                                          .System_Folder.DSaF_Saves["save.json"]
                                          .Value)
    end--]]
    money = save.money
    name = save.name
    night = save.night
    tour_finished = save.tour_finished
    app:ClearAllChildren()
    local frame = new("Frame", app)
    frame.Size = UDim2.fromScale(1, 1)
    frame.Position = UDim2.fromScale(0, 0)
    frame.BorderSizePixel = 0
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    if night == 0 then
        local name_input = new("TextBox", app)
        name_input.Size = UDim2.fromScale(1, 0.5)
        name_input.Position = UDim2.fromScale(0, 0)
        name_input.BorderSizePixel = 0
        name_input.Text = "Please select a name!"
        name_input.TextScaled = true
        name_input.BackgroundTransparency = 1
        name_input.TextColor3 = Color3.fromRGB(255, 255, 255)
        local name_submit = new("TextButton", app)
        name_submit.Size = UDim2.fromScale(1, 0.5)
        name_submit.Position = UDim2.fromScale(0, 0.5)
        name_submit.BorderSizePixel = 0
        name_submit.Text = "Submit"
        name_submit.TextScaled = true
        name_submit.BackgroundTransparency = 1
        name_submit.TextColor3 = Color3.fromRGB(255, 255, 255)
        name_submit.MouseButton1Click:Connect(function()
            night = 1
            name = name_input.Text
        end)
        while wait() do
            if night == 1 then
                name_input:Destroy()
                name_submit:Destroy()
                break
            end
        end
    end
    local money_text = new("TextLabel", app)
    money_text.Size = UDim2.fromScale(0.2, 0.2)
    money_text.Position = UDim2.fromScale(0.8, 0.8)
    money_text.BorderSizePixel = 0
    money_text.Text = "$" .. money
    money_text.TextScaled = true
    money_text.BackgroundTransparency = 0.5
    money_text.TextTransparency = 0.5
    money_text.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    if night == 1 then
        night1()
    else
        print("something happen'd?")
        manu()
    end
end
function night1()
    dialog("Well hello!\nWelcome to Day Shift at Freddy's LimeOS edition")
    dialog("This game is WIP\nAnyway I hope you enjoy!")
    -- 4670130618 purple guy
    -- 5229995920 phone guy
    -- 10220542917 prize counter
    -- 8308257724 dining area
    -- 8308130756 kitchen
    if tour_finished then
        changeroom(10220542917)
    else
        changeroom(10220542917)
        make_person_appear(5229995920)
        dialog("Welcome " .. name .. " to your new job at freddy fazbenders!",
               "Phone guy")
        dialog(
            "You will work the day shift!\nPlease sign the employee contract",
            "Phone guy")
        if selection(2, "Sure?", "What does it do?") == 2 then
            dialog("DONT SIGN IT\nRUN WHILE YOU STILL CAN", "Phone guy")
            if selection(2, "OK ILL RUN", "Nah Ill just sign it") == 1 then
                -- trigger ending
                menu()
                return
            end
        end
        dialog("Ok thanks, you now work here forever unpaid!", "Phone guy")
        if selection(2, "WHAT?", "ok") == 2 then
            dialog("Wait your fine with that? uhhh ok anyway", "Phone guy")
        end
        dialog("Ok! Now time for the tour!", "Phone guy")
        dialog("This room is the prize counter where you can buy prizes",
               "Phone guy")
        changeroom(8308257724)
        dialog(
            "This is the dining room where you will serve and entertain guests!",
            "Phone guy")
        changeroom(8308130756)
        dialog("This is the kitchen where you can cook pizza for the guests!",
               "Phone guy")
        dialog("Anyway have fun!", "Phone guy")
        make_person_dissapear(5229995920)
        thingsinkitchen()
    end
end
function thingsinprizecounter()
    if selection(3, "idk", "idk", "Exit to map") == 3 then map() end
end
function thingsindiningarea()
    if selection(3, "idk", "idk", "Exit to map") == 3 then map() end
end
function thingsinkitchen()
    if selection(3, "idk", "idk", "Exit to map") == 3 then map() end
end
function map()
    map_frame = new("Frame", app)
    map_frame.Size = UDim2.fromScale(1, 1)
    map_frame.Position = UDim2.fromScale(0, 0)
    map_frame.BorderSizePixel = 0
    map_frame.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    local map_button1 = new("TextButton", map_frame)
    map_button1.Size = UDim2.fromScale(0.2, 0.3)
    map_button1.Position = UDim2.fromScale(0.4, 0)
    map_button1.BorderSizePixel = 0
    map_button1.Text = "Prize counter"
    map_button1.TextScaled = true
    map_button1.BackgroundTransparency = 1
    map_button1.TextColor3 = Color3.fromRGB(255, 255, 255)
    map_button1.MouseButton1Click:Connect(function()
        map_frame:Destroy()
        changeroom(10220542917)
        thingsinprizecounter()
    end)
    local map_button2 = new("TextButton", map_frame)
    map_button2.Size = UDim2.fromScale(0.2, 0.3)
    map_button2.Position = UDim2.fromScale(0.4, 0.3)
    map_button2.BorderSizePixel = 0
    map_button2.Text = "Dining room"
    map_button2.TextScaled = true
    map_button2.BackgroundTransparency = 1
    map_button2.TextColor3 = Color3.fromRGB(255, 255, 255)
    map_button2.MouseButton1Click:Connect(function()
        map_frame:Destroy()
        changeroom(8308257724)
        thingsindiningarea()
    end)
    local map_button3 = new("TextButton", map_frame)
    map_button3.Size = UDim2.fromScale(0.2, 0.3)
    map_button3.Position = UDim2.fromScale(0.4, 0.6)
    map_button3.BorderSizePixel = 0
    map_button3.Text = "Kitchen"
    map_button3.TextScaled = true
    map_button3.BackgroundTransparency = 1
    map_button3.TextColor3 = Color3.fromRGB(255, 255, 255)
    map_button3.MouseButton1Click:Connect(function()
        map_frame:Destroy()
        changeroom(8308130756)
        thingsinkitchen()
    end)
    local exit_button = new("TextButton", map_frame)
    exit_button.Size = UDim2.fromScale(0.1, 0.1)
    exit_button.Position = UDim2.fromScale(0, 0)
    exit_button.BorderSizePixel = 0
    exit_button.Text = "Quit to menu"
    exit_button.TextScaled = true
    exit_button.BackgroundTransparency = 1
    exit_button.TextColor3 = Color3.fromRGB(255, 255, 255)
    exit_button.MouseButton1Click:Connect(function()
        save.name = name
        save.money = money
        save.night = night
        --[[if not uisfolder().Apps.Explorer.MainFrame.System_Folder:FindFirstChild(
            "DSaF_Saves") then
            local save_folder = uisfolder().Apps.Explorer.MainFrame
                                    .System_Folder:Clone()
            save_folder:ClearAllChildren()
            save_folder.Name = "DSaF_Saves"
            save_folder.Parent = uisfolder().Apps.Explorer.MainFrame
                                     .System_Folder
            if uisfolder().Apps.Explorer.MainFrame.System_Folder.DSaF_Saves:FindFirstChild(
                "save.json") then
                -- it exists!
                uisfolder().Apps.Explorer.MainFrame.System_Folder.DSaF_Saves:FindFirstChild(
                    "save.json").Value = HttpService:JSONEncode(save)
            else
                local savefile = uisfolder().Parent.SystemFiles.RegEditData
                                     .PlayerPassword:Clone()
                savefile:ClearAllChildren()
                savefile.Parent = save_folder
                savefile.Name = "save.json"
                savefile.Value = HttpService:JSONEncode(save)
            end
        end]]
        menu()
    end)
end
function changeroom(id)
    if app:FindFirstChild("bg_room") then
        app.bg_room.Image = "http://www.roblox.com/asset/?id=" .. id
    else
        local bg = new("ImageLabel", app)
        bg.Size = UDim2.fromScale(1, 1)
        bg.Position = UDim2.fromScale(0, 0)
        bg.Image = "http://www.roblox.com/asset/?id=" .. id
        bg.Name = "bg_room"
    end
end
function make_person_appear(id)
    local person = new("ImageLabel", app)
    person.Size = UDim2.fromScale(1, 1)
    person.Position = UDim2.fromScale(0, 0)
    person.Image = "http://www.roblox.com/asset/?id=" .. id
    person.BackgroundTransparency = 1
    person.Name = "person_" .. id
end
function make_person_dissapear(id) app["person_" .. id]:Destroy() end
function selection(options, option1, option2, option3)
    local size = 0.1
    size = size * options
    local option_size = 1
    option_size = option_size / options
    local return_value
    local selection_frame = new("Frame", app)
    selection_frame.Size = UDim2.fromScale(0.2, size)
    selection_frame.Position = UDim2.fromScale(0.8, 0)
    selection_frame.BorderSizePixel = 0
    selection_frame.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    if option1 then
        local option1_button = new("TextButton", selection_frame)
        option1_button.Size = UDim2.fromScale(1, option_size)
        option1_button.Position = UDim2.fromScale(0, 0)
        option1_button.BorderSizePixel = 0
        option1_button.Text = option1
        option1_button.TextScaled = true
        option1_button.BackgroundTransparency = 1
        option1_button.MouseButton1Click:Connect(function()
            selection_frame:Destroy()
            return_value = 1
        end)
    end
    if option2 then
        local option2_button = new("TextButton", selection_frame)
        option2_button.Size = UDim2.fromScale(1, option_size)
        option2_button.Position = UDim2.fromScale(0, option_size)
        option2_button.BorderSizePixel = 0
        option2_button.Text = option2
        option2_button.TextScaled = true
        option2_button.BackgroundTransparency = 1
        option2_button.MouseButton1Click:Connect(function()
            selection_frame:Destroy()
            return_value = 2
        end)
    end
    if option3 then
        local option3_button = new("TextButton", selection_frame)
        option3_button.Size = UDim2.fromScale(1, option_size)
        option3_button.Position = UDim2.fromScale(0, option_size * 2)
        option3_button.BorderSizePixel = 0
        option3_button.Text = option3
        option3_button.TextScaled = true
        option3_button.BackgroundTransparency = 1
        option3_button.MouseButton1Click:Connect(function()
            selection_frame:Destroy()
            return_value = 3
        end)
    end
    while wait() do if return_value then return return_value end end
end
function dialog(text, person)
    local waiting = false
    local person_frame
    if person then
        person_frame = new("Frame", app)
        person_frame.Size = UDim2.fromScale(0.3, 0.2)
        person_frame.Position = UDim2.fromScale(0, 0.4)
        person_frame.BorderSizePixel = 0
        person_frame.BackgroundTransparency = 0.55
        person_frame.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        local person_text = new("TextLabel", person_frame)
        person_text.Size = UDim2.fromScale(1, 1)
        person_text.Position = UDim2.fromScale(0, 0)
        person_text.BorderSizePixel = 0
        person_text.Text = person
        person_text.TextScaled = true
        person_text.BackgroundTransparency = 1
        person_text.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
    local dialog_frame = new("Frame", app)
    dialog_frame.Size = UDim2.fromScale(1, 0.4)
    dialog_frame.Position = UDim2.fromScale(0, 0.6)
    dialog_frame.BorderSizePixel = 0
    dialog_frame.BackgroundTransparency = 0.55
    dialog_frame.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    local dialog_text = new("TextLabel", dialog_frame)
    dialog_text.Size = UDim2.fromScale(1, 1)
    dialog_text.Position = UDim2.fromScale(0, 0)
    dialog_text.BorderSizePixel = 0
    dialog_text.Text = text
    dialog_text.TextScaled = true
    dialog_text.BackgroundTransparency = 1
    dialog_text.TextColor3 = Color3.fromRGB(255, 255, 255)
    function stop_waiting()
        awaitdisconnect:Disconnect()
        dialog_frame:Destroy()
        if person_frame then person_frame:Destroy() end
        waiting = true
    end
    awaitdisconnect = UserInputService.InputBegan:Connect(stop_waiting)
    while wait() do if waiting then break end end
    return
end
