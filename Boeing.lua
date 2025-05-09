local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("GGHub - Mod Menu Flutuante", "DarkTheme")

local welcomeMessage = "Bem-vindo ao GGHub! Aproveite as funções incríveis!"
game.StarterGui:SetCore("SendNotification", {
	Title = "GGHub";
	Text = welcomeMessage;
	Duration = 5;
})

local MainTab = Window:NewTab("Menu Principal")
local MainSection = MainTab:NewSection("Funções")

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local modMenu = Instance.new("Frame")
modMenu.Size = UDim2.new(0, 300, 0, 400)
modMenu.Position = UDim2.new(0.5, -150, 0.3, -200)
modMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
modMenu.BorderSizePixel = 0
modMenu.AnchorPoint = Vector2.new(0.5, 0.5)
modMenu.Parent = game.CoreGui

local banner = Instance.new("TextLabel")
banner.Size = UDim2.new(1, 0, 0, 50)
banner.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
banner.TextColor3 = Color3.new(1, 1, 1)
banner.Font = Enum.Font.GothamBold
banner.TextSize = 24
banner.Text = "GGHub - Menu Flutuante"
banner.Parent = modMenu

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = modMenu
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.Padding = UDim.new(0, 10)

local buttonsFrame = Instance.new("ScrollingFrame")
buttonsFrame.Size = UDim2.new(1, 0, 1, -50)
buttonsFrame.Position = UDim2.new(0, 0, 0, 50)
buttonsFrame.BackgroundTransparency = 1
buttonsFrame.BorderSizePixel = 0
buttonsFrame.ScrollBarThickness = 6
buttonsFrame.Parent = modMenu

local buttonsLayout = Instance.new("UIListLayout")
buttonsLayout.Parent = buttonsFrame
buttonsLayout.SortOrder = Enum.SortOrder.LayoutOrder
buttonsLayout.Padding = UDim.new(0, 10)

local function createButton(text, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.9, 0, 0, 40)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.GothamSemibold
	btn.TextSize = 18
	btn.Text = text
	btn.AutoButtonColor = true
	btn.Parent = buttonsFrame
	btn.MouseButton1Click:Connect(callback)
	btn.MouseEnter:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
	end)
	btn.MouseLeave:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	end)
	return btn
end

local function copySkinFromPlayer(targetPlayer)
	if not targetPlayer.Character then return end
	local targetChar = targetPlayer.Character
	local localChar = player.Character
	if not localChar then return end

	for _, item in pairs(localChar:GetChildren()) do
		if item:IsA("Accessory") or item:IsA("Hat") then
			item:Destroy()
		end
	end

	for _, item in pairs(targetChar:GetChildren()) do
		if item:IsA("Accessory") or item:IsA("Hat") then
			local clone = item:Clone()
			clone.Parent = localChar
		end
	end
end

local function knifeV4()
	local tool = Instance.new("Tool")
	tool.Name = "KnifeV4"
	tool.RequiresHandle = true
	tool.CanBeDropped = false

	local handle = Instance.new("Part")
	handle.Name = "Handle"
	handle.Size = Vector3.new(1, 4, 0.2)
	handle.Color = Color3.fromRGB(100, 100, 100)
	handle.Material = Enum.Material.Metal
	handle.Parent = tool

	tool.Parent = player.Backpack

	tool.Activated:Connect(function()
		local character = player.Character
		if not character then return end
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if not humanoid then return end
		local ray = Ray.new(handle.Position, handle.CFrame.LookVector * 5)
		local part, pos = workspace:FindPartOnRay(ray, character)
		if part and part.Parent then
			local h = part.Parent:FindFirstChildOfClass("Humanoid")
			if h and h ~= humanoid then
				h:TakeDamage(50)
			end
		end
	end)
end

local flying = false
local flySpeed = 50
local bodyVelocity, bodyGyro

local function flyV3()
	if flying then
		flying = false
		if bodyVelocity then bodyVelocity:Destroy() end
		if bodyGyro then bodyGyro:Destroy() end
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			player.Character.HumanoidRootPart.Anchored = false
		end
	else
		local character = player.Character
		if not character then return end
		local hrp = character:FindFirstChild("HumanoidRootPart")
		if not hrp then return end

		flying = true
		bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.Velocity = Vector3.new(0, 0, 0)
		bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		bodyVelocity.Parent = hrp

		bodyGyro = Instance.new("BodyGyro")
		bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
		bodyGyro.CFrame = hrp.CFrame
		bodyGyro.Parent = hrp

		RunService:BindToRenderStep("FlyControl", Enum.RenderPriority.Character.Value, function()
			if not flying then return end
			local moveDir = Vector3.new()
			if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + workspace.CurrentCamera.CFrame.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - workspace.CurrentCamera.CFrame.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - workspace.CurrentCamera.CFrame.RightVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + workspace.CurrentCamera.CFrame.RightVector end
			moveDir = Vector3.new(moveDir.X, 0, moveDir.Z).Unit * flySpeed
			if moveDir ~= moveDir then moveDir = Vector3.new(0, 0, 0) end
			bodyVelocity.Velocity = moveDir + Vector3.new(0, 0, 0)
			bodyGyro.CFrame = workspace.CurrentCamera.CFrame
		end)
	end
end

local function sofa()
	local character = player.Character
	if not character then return end
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local sofaPart = Instance.new("Part")
	sofaPart.Size = Vector3.new(5, 1, 3)
	sofaPart.Anchored = true
	sofaPart.CanCollide = true
	sofaPart.Position = hrp.Position - Vector3.new(0, 3, 0)
	sofaPart.BrickColor = BrickColor.new("Brown")
	sofaPart.Name = "Sofá"
	sofaPart.Parent = workspace

	wait(10)
	if sofaPart and sofaPart.Parent then
		sofaPart:Destroy()
	end
end

local function killAll()
	for _, plr in pairs(game.Players:GetPlayers()) do
		if plr ~= player and plr.Character then
			local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
			if humanoid and humanoid.Health > 0 then
				humanoid.Health = 0
			end
		end
	end
end

local function clonePlayer()
	local character = player.Character
	if not character then return end
	local clone = character:Clone()
	clone.Name = player.Name .. "_Clone"
	clone.Parent = workspace
	clone:SetPrimaryPartCFrame(character.HumanoidRootPart.CFrame * CFrame.new(3, 0, 0))
	for _, part in pairs(clone:GetChildren()) do
		if part:IsA("BasePart") then
			part.Anchored = false
		end
	end
end

local function kickPlayer()
	game.Players.LocalPlayer:Kick("Você foi expulso pelo GGHub!")
end

createButton("Copiar Skin de Jogador", function()
	local targetName = game:GetService("UserInputService"):GetFocusedTextBox()
	local targetPlayer = nil
	for _, plr in pairs(game.Players:GetPlayers()) do
		if plr.Name:lower() == targetName.Text:lower() then
			targetPlayer = plr
			break
		end
	end
	if targetPlayer then
		copySkinFromPlayer(targetPlayer)
	else
		game.StarterGui:SetCore("SendNotification", {
			Title = "Erro";
			Text = "Jogador não encontrado.";
			Duration = 3;
		})
	end
end)

createButton("Knife V4", function()
	knifeV4()
	game.StarterGui:SetCore("SendNotification", {
		Title = "GGHub";
		Text = "Knife V4 adicionado ao inventário!";
		Duration = 3;
	})
end)

createButton("Fly V3 (Pressione WASD para mover)", function()
	flyV3()
	if flying then
		game.StarterGui:SetCore("SendNotification", {
			Title = "GGHub";
			Text = "Voando ativado!";
			Duration = 3;
		})
	else
		game.StarterGui:SetCore("SendNotification", {
			Title = "GGHub";
			Text = "Voando desativado!";
			Duration = 3;
		})
	end
end)

createButton("Sofá", function()
	sofa()
	game.StarterGui:SetCore("SendNotification", {
		Title = "GGHub";
		Text = "Sofá criado por 10 segundos!";
		Duration = 3;
	})
end)

createButton("Matar Todos", function()
	killAll()
	game.StarterGui:SetCore("SendNotification", {
		Title = "GGHub";
		Text = "Todos os jogadores foram mortos!";
		Duration = 3;
	})
end)

createButton("Clonar", function()
	clonePlayer()
	game.StarterGui:SetCore("SendNotification", {
		Title = "GGHub";
		Text = "Clone criado!";
		Duration = 3;
	})
end)

createButton("Kick", function()
	kickPlayer()
end)

local dragging = false
local dragInput, mousePos, framePos

modMenu.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		mousePos = input.Position
		framePos = modMenu.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

modMenu.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - mousePos
		modMenu.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
	end
end)
