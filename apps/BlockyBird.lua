local App = createapp("Blocky Bird")
local GuiCollisionService = loadlib("GuiCollisionModule")
local uis = GetService("UserInputService")
local TweenService = GetService("TweenService")

local IsDead = false
local CanSpawn = true

local Canvas = new("Frame",App)
Canvas.Size = UDim2.fromScale(1,1)
Canvas.BackgroundTransparency = 1

local Sky = new("Frame",App)
Sky.Size = UDim2.fromScale(1,0.9)
Sky.BackgroundColor3 = Color3.fromRGB(0,200,255)
Sky.BorderSizePixel = 0

local Land = new("Frame",App)
Land.Size = UDim2.fromScale(1,0.1)
Land.Position = UDim2.fromScale(0,0.9)
Land.BackgroundColor3 = Color3.fromRGB(0,255,130)
Land.BorderSizePixel = 0

local Bird = new("Frame",App)
Bird.Name = "Bird"
Bird.Size = UDim2.fromScale(0.1,0.1)
Bird.Position = UDim2.fromScale(0.4,0.4)
Bird.BackgroundColor3 = Color3.fromRGB(255,255,0)
Bird.BorderSizePixel = 0

local BirdBeek = new("Frame",App.Bird)
BirdBeek.Size = UDim2.fromScale(1,0.3)
BirdBeek.Position = UDim2.fromScale(0.4,0.42)
BirdBeek.BackgroundColor3 = Color3.fromRGB(255,60,0)
BirdBeek.BorderSizePixel = 0

local GameOverText = new("TextLabel",App)
GameOverText.Size = UDim2.fromScale(0.4,0.2)
GameOverText.Position = UDim2.fromScale(0.3,0.3)
GameOverText.BackgroundTransparency = 1
GameOverText.BorderSizePixel = 0
GameOverText.Text = "Game Over"
GameOverText.Font = Enum.Font.Gotham
GameOverText.TextColor3 = Color3.fromRGB(255,255,255)
GameOverText.TextScaled = true
GameOverText.Visible = false
GameOverText.ZIndex = 2

local GameOverButton = new("TextButton",App)
GameOverButton.Size = UDim2.fromScale(0.4,0.1)
GameOverButton.Position = UDim2.fromScale(0.3,0.55)
GameOverButton.BackgroundColor3 = Color3.fromRGB(240,240,240)
GameOverButton.BorderSizePixel = 0
GameOverButton.Text = "Play Again?"
GameOverButton.Font = Enum.Font.Gotham
GameOverButton.TextColor3 = Color3.fromRGB(0,0,0)
GameOverButton.TextScaled = true
GameOverButton.Visible = false
GameOverButton.ZIndex = 2


local bird = Bird
local group = GuiCollisionService.createCollisionGroup() -- creating a group for our colliders

group:addCollider(Land,true) -- land will be a collider
group:addHitter(bird, { rotate }) -- bird will be the hitter

-------------------------------------------------------------------Collision Check Loop
local connection
local CollisionCheck = coroutine.create(function()
	while true do
		if CanSpawn == true then        
			local stages = math.random(1,5)
			local tmp1 = new("Frame",App)
			local tmp2 = new("Frame",App)
			tmp1.Visible = false
			tmp2.Visible = false
			tmp1.BackgroundColor3 = Color3.fromRGB(143, 143, 214)
			tmp2.BackgroundColor3 = Color3.fromRGB(143, 143, 214)
			tmp1.Name = "Down"
			tmp2.Name = "Up"
			if stages == 1 then
				tmp1.Position = UDim2.new(0.332, 0, 0.674, 0)
				tmp2.Position = UDim2.new(0.334, 0, 0, 0)
				tmp1.Size = UDim2.new(0.035, 0, 0.235, 0)
				tmp2.Size = UDim2.new(0.035, 0, 0.177, 0)
			elseif stages == 2 then
				tmp1.Position = UDim2.new(0.481, 0, 0.661, 0)
				tmp2.Position = UDim2.new(0.481, 0, 0, 0)
				tmp1.Size = UDim2.new(0.035, 0, 0.248, 0)
				tmp2.Size = UDim2.new(0.035, 0, 0.169, 0)
			elseif stages == 3 then
				tmp1.Position = UDim2.new(0.625, 0, 0.437, 0)
				tmp1.Size = UDim2.new(0.035, 0, 0.471, 0)
				tmp2 = nil
			elseif stages == 4 then
				tmp1.Position = UDim2.new(0.734, 0, 0.769, 0)
				tmp2.Position = UDim2.new(0.733, 0, 0, 0) 
				tmp1.Size = UDim2.new(0.035, 0, 0.137, 0)
				tmp2.Size = UDim2.new(0.035, 0, 0.253, 0)
			else
				tmp2.Position = UDim2.new(0.869, 0, 0, 0)
				tmp2.Size = UDim2.new(0.035, 0, 0.367, 0)
				tmp1 = nil
			end

			local parts = {tmp1, tmp2}

			for _, st in ipairs(parts) do

				local part = st--:Clone()

				part.ZIndex = 1
				part.Visible = true
				part.Position = UDim2.new(1.1, 0, part.Position.Y.Scale, 0)
				part.Parent = App

				local function callback(state)
					if state == Enum.TweenStatus.Completed then
						part:Destroy()
					end
				end

				local move = part:TweenPosition(
					UDim2.new(-0.1, part.Position.X.Offset, part.Position.Y.Scale, 0),           
					Enum.EasingDirection.Out, 
					Enum.EasingStyle.Linear,   
					10,                       
					true,                    
					callback
				)
			end
		end
		App.ChildAdded:Connect(function(instance)
			if instance.Name == "Up" or instance.Name == "Down" then
				group:addCollider(instance,true) -- adding the obstacle to our colliders
			end
		end)
		connection = group:getHitter(1).CollidersTouched.Event:Connect(function(hits) -- checking if the bird collides
			if hits then -- if the colliders were hit
				GameOverText.Visible = true         
				GameOverButton.Visible = true
				connection:Disconnect() -- disconnect our event
				IsDead = true
				CanSpawn = false
			end    
		end)
		wait(3)
	end
end)

-------------------------------------------------------------------Controls
function pull (bird)
	if IsDead == false then
		local function callback(state)
			if state == Enum.TweenStatus.Completed then -- if tween completed
				pull(bird) -- pull the bird down again!
			end
		end

		local tweenInfo = TweenInfo.new(
			.5, 
			Enum.EasingStyle.Linear, 
			Enum.EasingDirection.Out, 
			-1, 
			false,
			0 
		)

		local rotate = TweenService:Create(bird, tweenInfo, {Rotation = 30})
		rotate:Play() -- rotating our bird

		local down = bird:TweenPosition(
			UDim2.new(bird.Position.X.Scale,bird.Position.X.Offset,bird.Position.Y.Scale + 0.1, 0),           
			Enum.EasingDirection.Out, 
			Enum.EasingStyle.Linear,   
			.2,                       
			true,                    
			callback        
		) -- pulling our bird down using tweens
	end
end

function fly()
	if IsDead == false then
		local tweenInfo = TweenInfo.new(
			.5, 
			Enum.EasingStyle.Linear, 
			Enum.EasingDirection.Out, 
			-1, 
			false,
			0 
		)

		rotate = TweenService:Create(bird, tweenInfo, {Rotation = -15}) --
		rotate:Play() -- rotating our bird

		bird.Rotation = -15

		local up = bird:TweenPosition(            
			UDim2.new(bird.Position.X.Scale,bird.Position.X.Offset,bird.Position.Y.Scale - 0.2, 0),           
			Enum.EasingDirection.Out, 
			Enum.EasingStyle.Elastic,   
			1.9,                       
			true      
		) -- making our bird fly upwards
	end
end

uis.InputBegan:Connect(function(input, gameprocessed)
	if input.KeyCode == Enum.KeyCode.Space then -- if space is pressed
		fly() -- make the bird fly
	end
end)

uis.InputEnded:Connect(function(input, gameprocessed)
	wait(0.05)
	if input.KeyCode == Enum.KeyCode.Space then -- if the bird is not flying anymore
		pull(bird) -- we pull the bird down
	end
end)

GameOverButton.MouseButton1Click:Connect(function()
	Bird.Position = UDim2.fromScale(0.4,0.4)
	for _, obj in ipairs(App:GetChildren()) do
		if obj.Name == "Up" or obj.Name == "Down" then
			obj:Remove() -- remove obstacles
		end
	end
	Bird.Position = UDim2.fromScale(0.4,0.4)
	BirdBeek.Position = UDim2.fromScale(0.4,0.42)
	IsDead = false
	CanSpawn = true
	GameOverText.Visible = false
	GameOverButton.Visible = false
end)
coroutine.resume(CollisionCheck)
pull(bird)
