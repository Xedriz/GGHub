local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local GGHub = {}
GGHub.Flying = false
GGHub.SofaEnabled = false
GGHub.Cloning = false
GGHub.BannerEnabled = false
GGHub.KnifeEnabled = false

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GGHubMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = game.CoreGui

local WelcomeFrame = Instance.new("Frame")
WelcomeFrame.Name = "WelcomeFrame"
WelcomeFrame.Size = UDim2.new(0, 400, 0, 200)
WelcomeFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
WelcomeFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
WelcomeFrame.BorderSizePixel = 0
WelcomeFrame.Visible = true
WelcomeFrame.Parent = ScreenGui

local WelcomeTitle = Instance.new("TextLabel")
WelcomeTitle.Name = "WelcomeTitle"
WelcomeTitle.Size = UDim2.new(1, 0, 0, 50)
WelcomeTitle.Position = UDim2.new(0, 0, 0, 0)
WelcomeTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
WelcomeTitle.BorderSizePixel = 0
WelcomeTitle.Text = "GGHub"
WelcomeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeTitle.TextSize = 30
WelcomeTitle.Font = Enum.Font.GothamBold
WelcomeTitle.Parent = WelcomeFrame

local WelcomeLogo = Instance.new("ImageLabel")
WelcomeLogo.Name = "WelcomeLogo"
WelcomeLogo.Size = UDim2.new(0, 40, 0, 40)
WelcomeLogo.Position = UDim2.new(0, 10, 0, 5)
WelcomeLogo.BackgroundTransparency = 1
WelcomeLogo.Image = "rbxassetid://6031280882"
WelcomeLogo.Parent = WelcomeTitle

local WelcomeMessage = Instance.new("TextLabel")
WelcomeMessage.Name = "WelcomeMessage"
WelcomeMessage.Size = UDim2.new(1, -40, 0, 80)
WelcomeMessage.Position = UDim2.new(0, 20, 0, 60)
WelcomeMessage.BackgroundTransparency = 1
WelcomeMessage.Text = "Bem-vindo ao GGHub Mod Menu!\n\nCarregando recursos..."
WelcomeMessage.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeMessage.TextSize = 18
WelcomeMessage.Font = Enum.Font.Gotham
WelcomeMessage.TextWrapped = true
WelcomeMessage.TextXAlignment = Enum.TextXAlignment.Center
WelcomeMessage.Parent = WelcomeFrame

local LoadingBar = Instance.new("Frame")
LoadingBar.Name = "LoadingBar"
LoadingBar.Size = UDim2.new(0.8, 0, 0, 20)
LoadingBar.Position = UDim2.new(0.1, 0, 0.8, 0)
LoadingBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
LoadingBar.BorderSizePixel = 0
LoadingBar.Parent = WelcomeFrame

local LoadingFill = Instance.new("Frame")
LoadingFill.Name = "LoadingFill"
LoadingFill.Size = UDim2.new(0, 0, 1, 0)
LoadingFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
LoadingFill.BorderSizePixel = 0
LoadingFill.Parent = LoadingBar

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 40, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "GGHub Mod Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.Parent = TopBar

local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Size = UDim2.new(0, 30, 0, 30)
Logo.Position = UDim2.new(0, 5, 0, 5)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://6031280882"
Logo.Parent = TopBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TopBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 200, 80)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 18
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Parent = TopBar

local Content = Instance.new("ScrollingFrame")
Content.Name = "Content"
Content.Size = UDim2.new(1, 0, 1, -40)
Content.Position = UDim2.new(0, 0, 0, 40)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 6
Content.CanvasSize = UDim2.new(0, 0, 0, 600)
Content.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.Parent = Content

local MiniFrame = Instance.new("Frame")
MiniFrame.Name = "MiniFrame"
MiniFrame.Size = UDim2.new(0, 200, 0, 40)
MiniFrame.Position = UDim2.new(0, 20, 0, 100)
MiniFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MiniFrame.BorderSizePixel = 0
MiniFrame.Visible = false
MiniFrame.Parent = ScreenGui

local MiniBar = Instance.new("Frame")
MiniBar.Name = "MiniBar"
MiniBar.Size = UDim2.new(1, 0, 1, 0)
MiniBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MiniBar.BorderSizePixel = 0
MiniBar.Parent = MiniFrame

local MiniTitle = Instance.new("TextLabel")
MiniTitle.Name = "MiniTitle"
MiniTitle.Size = UDim2.new(1, -80, 1, 0)
MiniTitle.Position = UDim2.new(0, 40, 0, 0)
MiniTitle.BackgroundTransparency = 1
MiniTitle.Text = "GGHub"
MiniTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniTitle.TextSize = 16
MiniTitle.Font = Enum.Font.GothamBold
MiniTitle.Parent = MiniBar

local MiniLogo = Instance.new("ImageLabel")
MiniLogo.Name = "MiniLogo"
MiniLogo.Size = UDim2.new(0, 30, 0, 30)
MiniLogo.Position = UDim2.new(0, 5, 0, 5)
MiniLogo.BackgroundTransparency = 1
MiniLogo.Image = "rbxassetid://6031280882"
MiniLogo.Parent = MiniBar

local ExpandButton = Instance.new("TextButton")
ExpandButton.Name = "ExpandButton"
ExpandButton.Size = UDim2.new(0, 30, 0, 30)
ExpandButton.Position = UDim2.new(1, -35, 0, 5)
ExpandButton.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
ExpandButton.BorderSizePixel = 0
ExpandButton.Text = "+"
ExpandButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExpandButton.TextSize = 18
ExpandButton.Font = Enum.Font.GothamBold
ExpandButton.Parent = MiniBar

function CreateSection(name)
    local Section = Instance.new("Frame")
    Section.Name = name .. "Section"
    Section.Size = UDim2.new(1, -20, 0, 30)
    Section.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Section.BorderSizePixel = 0
    Section.LayoutOrder = #Content:GetChildren()
    Section.Parent = Content
    
    local SectionTitle = Instance.new("TextLabel")
    SectionTitle.Name = "Title"
    SectionTitle.Size = UDim2.new(1, 0, 1, 0)
    SectionTitle.BackgroundTransparency = 1
    SectionTitle.Text = "  " .. name
    SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    SectionTitle.TextSize = 16
    SectionTitle.Font = Enum.Font.GothamBold
    SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    SectionTitle.Parent = Section
    
    return Section
end

function CreateButton(parent, name, callback)
    local Button = Instance.new("Frame")
    Button.Name = name .. "Button"
    Button.Size = UDim2.new(1, -20, 0, 40)
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.BorderSizePixel = 0
    Button.LayoutOrder = #parent:GetChildren()
    Button.Parent = parent
    
    local ButtonText = Instance.new("TextLabel")
    ButtonText.Name = "Text"
    ButtonText.Size = UDim2.new(1, -10, 1, 0)
    ButtonText.Position = UDim2.new(0, 10, 0, 0)
    ButtonText.BackgroundTransparency = 1
    ButtonText.Text = name
    ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
    ButtonText.TextSize = 14
    ButtonText.Font = Enum.Font.Gotham
    ButtonText.TextXAlignment = Enum.TextXAlignment.Left
    ButtonText.Parent = Button
    
    local ClickDetector = Instance.new("TextButton")
    ClickDetector.Name = "ClickDetector"
    ClickDetector.Size = UDim2.new(1, 0, 1, 0)
    ClickDetector.BackgroundTransparency = 1
    ClickDetector.Text = ""
    ClickDetector.Parent = Button
    
    ClickDetector.MouseButton1Click:Connect(callback)
    
    return Button
end

function CreateToggle(parent, name, callback)
    local Toggle = Instance.new("Frame")
    Toggle.Name = name .. "Toggle"
    Toggle.Size = UDim2.new(1, -20, 0, 40)
    Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Toggle.BorderSizePixel = 0
    Toggle.LayoutOrder = #parent:GetChildren()
    Toggle.Parent = parent
    
    local ToggleText = Instance.new("TextLabel")
    ToggleText.Name = "Text"
    ToggleText.Size = UDim2.new(1, -60, 1, 0)
    ToggleText.Position = UDim2.new(0, 10, 0, 0)
    ToggleText.BackgroundTransparency = 1
    ToggleText.Text = name
    ToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleText.TextSize = 14
    ToggleText.Font = Enum.Font.Gotham
    ToggleText.TextXAlignment = Enum.TextXAlignment.Left
    ToggleText.Parent = Toggle
    
    local ToggleButton = Instance.new("Frame")
    ToggleButton.Name = "Button"
    ToggleButton.Size = UDim2.new(0, 40, 0, 20)
    ToggleButton.Position = UDim2.new(1, -50, 0.5, -10)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Parent = Toggle
    
    local ToggleCircle = Instance.new("Frame")
    ToggleCircle.Name = "Circle"
    ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
    ToggleCircle.Position = UDim2.new(0, 2, 0.5, -8)
    ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleCircle.BorderSizePixel = 0
    ToggleCircle.Parent = ToggleButton
    
    local ClickDetector = Instance.new("TextButton")
    ClickDetector.Name = "ClickDetector"
    ClickDetector.Size = UDim2.new(1, 0, 1, 0)
    ClickDetector.BackgroundTransparency = 1
    ClickDetector.Text = ""
    ClickDetector.Parent = Toggle
    
    local toggled = false
    ClickDetector.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            TweenService:Create(ToggleButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 170, 255)}):Play()
            TweenService:Create(ToggleCircle, TweenInfo.new(0.3), {Position = UDim2.new(0, 22, 0.5, -8)}):Play()
        else
            TweenService:Create(ToggleButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
            TweenService:Create(ToggleCircle, TweenInfo.new(0.3), {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
        end
        
        callback(toggled)
    end)
    
    return Toggle, toggled
end

function CreateDropdown(parent, name, options, callback)
    local Dropdown = Instance.new("Frame")
    Dropdown.Name = name .. "Dropdown"
    Dropdown.Size = UDim2.new(1, -20, 0, 40)
    Dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Dropdown.BorderSizePixel = 0
    Dropdown.LayoutOrder = #parent:GetChildren()
    Dropdown.ClipsDescendants = true
    Dropdown.Parent = parent
    
    local DropdownText = Instance.new("TextLabel")
    DropdownText.Name = "Text"
    DropdownText.Size = UDim2.new(1, -30, 0, 40)
    DropdownText.Position = UDim2.new(0, 10, 0, 0)
    DropdownText.BackgroundTransparency = 1
    DropdownText.Text = name
    DropdownText.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownText.TextSize = 14
    DropdownText.Font = Enum.Font.Gotham
    DropdownText.TextXAlignment = Enum.TextXAlignment.Left
    DropdownText.Parent = Dropdown
    
    local DropdownArrow = Instance.new("TextLabel")
    DropdownArrow.Name = "Arrow"
    DropdownArrow.Size = UDim2.new(0, 20, 0, 40)
    DropdownArrow.Position = UDim2.new(1, -25, 0, 0)
    DropdownArrow.BackgroundTransparency = 1
    DropdownArrow.Text = "▼"
    DropdownArrow.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownArrow.TextSize = 14
    DropdownArrow.Font = Enum.Font.Gotham
    DropdownArrow.Parent = Dropdown
    
    local DropdownContent = Instance.new("Frame")
    DropdownContent.Name = "Content"
    DropdownContent.Size = UDim2.new(1, 0, 0, #options * 30)
    DropdownContent.Position = UDim2.new(0, 0, 0, 40)
    DropdownContent.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    DropdownContent.BorderSizePixel = 0
    DropdownContent.Visible = true
    DropdownContent.Parent = Dropdown
    
    local DropdownList = Instance.new("UIListLayout")
    DropdownList.SortOrder = Enum.SortOrder.LayoutOrder
    DropdownList.Parent = DropdownContent
    
    local selectedOption = ""
    local expanded = false
    
    for i, option in ipairs(options) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Name = option .. "Option"
        OptionButton.Size = UDim2.new(1, 0, 0, 30)
        OptionButton.BackgroundTransparency = 1
        OptionButton.Text = option
        OptionButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        OptionButton.TextSize = 14
        OptionButton.Font = Enum.Font.Gotham
        OptionButton.Parent = DropdownContent
        
        OptionButton.MouseButton1Click:Connect(function()
            selectedOption = option
            DropdownText.Text = name .. ": " .. selectedOption
            
            TweenService:Create(Dropdown, TweenInfo.new(0.3), {Size = UDim2.new(1, -20, 0, 40)}):Play()
            TweenService:Create(DropdownArrow, TweenInfo.new(0.3), {Rotation = 0}):Play()
            expanded = false
            
            callback(selectedOption)
        end)
    end
    
    local ClickDetector = Instance.new("TextButton")
    ClickDetector.Name = "ClickDetector"
    ClickDetector.Size = UDim2.new(1, 0, 0, 40)
    ClickDetector.BackgroundTransparency = 1
    ClickDetector.Text = ""
    ClickDetector.Parent = Dropdown
    
    ClickDetector.MouseButton1Click:Connect(function()
        expanded = not expanded
        if expanded then
            TweenService:Create(Dropdown, TweenInfo.new(0.3), {Size = UDim2.new(1, -20, 0, 40 + #options * 30)}):Play()
            TweenService:Create(DropdownArrow, TweenInfo.new(0.3), {Rotation = 180}):Play()
        else
            TweenService:Create(Dropdown, TweenInfo.new(0.3), {Size = UDim2.new(1, -20, 0, 40)}):Play()
            TweenService:Create(DropdownArrow, TweenInfo.new(0.3), {Rotation = 0}):Play()
        end
    end)
    
    return Dropdown, function() return selectedOption end
end

function MakeDraggable(frame)
    local dragToggle = nil
    local dragSpeed = 0.1
    local dragInput = nil
    local dragStart = nil
    local dragPos = nil
    
    local function UpdateInput(input)
        local Delta = input.Position - dragStart
        local Position = UDim2.new(dragPos.X.Scale, dragPos.X.Offset + Delta.X, dragPos.Y.Scale, dragPos.Y.Offset + Delta.Y)
        TweenService:Create(frame, TweenInfo.new(dragSpeed), {Position = Position}):Play()
    end
    
    frame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragToggle = true
            dragStart = input.Position
            dragPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)
    
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragToggle then
            UpdateInput(input)
        end
    end)
end

MakeDraggable(MainFrame)
MakeDraggable(MiniFrame)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    for _, connection in pairs(GGHub.Connections or {}) do
        if typeof(connection) == "RBXScriptConnection" then
            connection:Disconnect()
        end
    end
    GGHub.Connections = {}
end)

MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MiniFrame.Visible = true
end)

ExpandButton.MouseButton1Click:Connect(function()
    MiniFrame.Visible = false
    MainFrame.Visible = true
end)

function FlyV3(toggle)
    if toggle then
        GGHub.Flying = true
        
        local StartFly = function()
            if not Character or not Character:FindFirstChild("HumanoidRootPart") or not Character:FindFirstChild("Humanoid") then
                return
            end
            
            local HRP = Character.HumanoidRootPart
            local Humanoid = Character.Humanoid
            
            Humanoid.PlatformStand = true
            
            local BodyVelocity = Instance.new("BodyVelocity")
            BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            BodyVelocity.Velocity = Vector3.new(0, 0, 0)
            BodyVelocity.Name = "GGHubFly"
            BodyVelocity.Parent = HRP
            
            local BodyGyro = Instance.new("BodyGyro")
            BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            BodyGyro.CFrame = HRP.CFrame
            BodyGyro.Name = "GGHubGyro"
            BodyGyro.Parent = HRP
            
            local conn1 = RunService.RenderStepped:Connect(function()
                if not GGHub.Flying then return end
                
                local flySpeed = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and 150 or 50
                local character = LocalPlayer.Character
                if not character or not character:FindFirstChild("HumanoidRootPart") then return end
                
                local hrp = character.HumanoidRootPart
                local bodyVel = hrp:FindFirstChild("GGHubFly")
                local bodyGyro = hrp:FindFirstChild("GGHubGyro")
                
                if not bodyVel or not bodyGyro then return end
                
                bodyGyro.CFrame = CFrame.new(hrp.Position, hrp.Position + Camera.CFrame.LookVector)
                
                local moveDirection = Vector3.new(
                    UserInputService:IsKeyDown(Enum.KeyCode.D) and 1 or (UserInputService:IsKeyDown(Enum.KeyCode.A) and -1 or 0),
                    UserInputService:IsKeyDown(Enum.KeyCode.E) and 1 or (UserInputService:IsKeyDown(Enum.KeyCode.Q) and -1 or 0),
                    UserInputService:IsKeyDown(Enum.KeyCode.S) and 1 or (UserInputService:IsKeyDown(Enum.KeyCode.W) and -1 or 0)
                )
                
                local cameraCFrame = Camera.CFrame
                local moveVector = cameraCFrame:VectorToWorldSpace(moveDirection.X, moveDirection.Y, moveDirection.Z)
                
                bodyVel.Velocity = moveVector * flySpeed
            end)
            
            table.insert(GGHub.Connections, conn1)
        end
        
        StartFly()
        
        local conn2 = LocalPlayer.CharacterAdded:Connect(function(newCharacter)
            if GGHub.Flying then
                Character = newCharacter
                wait(1)
                StartFly()
            end
        end)
        
        table.insert(GGHub.Connections, conn2)
    else
        GGHub.Flying = false
        
        if Character and Character:FindFirstChild("HumanoidRootPart") then
            local HRP = Character.HumanoidRootPart
            
            if HRP:FindFirstChild("GGHubFly") then
                HRP.GGHubFly:Destroy()
            end
            
            if HRP:FindFirstChild("GGHubGyro") then
                HRP.GGHubGyro:Destroy()
            end
            
            if Character:FindFirstChild("Humanoid") then
                Character.Humanoid.PlatformStand = false
            end
        end
        
        for i, conn in pairs(GGHub.Connections) do
            if typeof(conn) == "RBXScriptConnection" then
                conn:Disconnect()
                GGHub.Connections[i] = nil
            end
        end
    end
end

function SpawnSofa(toggle)
    if toggle then
        if GGHub.SofaObject and GGHub.SofaObject.Parent then
            GGHub.SofaObject:Destroy()
        end
        
        GGHub.SofaEnabled = true
        
        local Sofa = Instance.new("Part")
        Sofa.Name = "GGHubSofa"
        Sofa.Size = Vector3.new(4, 1, 2)
        Sofa.Anchored = true
        Sofa.CanCollide = true
        Sofa.BrickColor = BrickColor.new("Really black")
        Sofa.Material = Enum.Material.SmoothPlastic
        Sofa.Parent = workspace
        
        local SofaBack = Instance.new("Part")
        SofaBack.Name = "GGHubSofaBack"
        SofaBack.Size = Vector3.new(4, 2, 0.5)
        SofaBack.Anchored = true
        SofaBack.CanCollide = true
        SofaBack.BrickColor = BrickColor.new("Really black")
        SofaBack.Material = Enum.Material.SmoothPlastic
        SofaBack.Parent = workspace
        
        local LeftArm = Instance.new("Part")
        LeftArm.Name = "GGHubSofaLeftArm"
        LeftArm.Size = Vector3.new(0.5, 1.2, 2)
        LeftArm.Anchored = true
        LeftArm.CanCollide = true
        LeftArm.BrickColor = BrickColor.new("Really black")
        LeftArm.Material = Enum.Material.SmoothPlastic
        LeftArm.Parent = workspace
        
        local RightArm = Instance.new("Part")
        RightArm.Name = "GGHubSofaRightArm"
        RightArm.Size = Vector3.new(0.5, 1.2, 2)
        RightArm.Anchored = true
        RightArm.CanCollide = true
        RightArm.BrickColor = BrickColor.new("Really black")
        RightArm.Material = Enum.Material.SmoothPlastic
        RightArm.Parent = workspace
        
        local Seat = Instance.new("Seat")
        Seat.Name = "GGHubSofaSeat"
        Seat.Size = Vector3.new(3, 0.5, 1.5)
        Seat.Anchored = true
        Seat.CanCollide = false
        Seat.BrickColor = BrickColor.new("Really red")
        Seat.Material = Enum.Material.SmoothPlastic
        Seat.Parent = workspace
        
        GGHub.SofaObject = Sofa
        GGHub.SofaParts = {Sofa, SofaBack, LeftArm, RightArm, Seat}
        
        local function UpdateSofaPosition()
            if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
            
            local HRP = Character.HumanoidRootPart
            local LookVector = HRP.CFrame.LookVector
            local RightVector = HRP.CFrame.RightVector
            local Position = HRP.Position - (LookVector * 4)
            
            Sofa.CFrame = CFrame.new(Position) * CFrame.Angles(0, math.atan2(LookVector.X, LookVector.Z), 0)
            SofaBack.CFrame = Sofa.CFrame * CFrame.new(0, 1.5, -0.75)
            LeftArm.CFrame = Sofa.CFrame * CFrame.new(-1.75, 0.6, 0)
            RightArm.CFrame = Sofa.CFrame * CFrame.new(1.75, 0.6, 0)
            Seat.CFrame = Sofa.CFrame * CFrame.new(0, 0.25, 0)
        end
        
        UpdateSofaPosition()
        
        local conn = RunService.Heartbeat:Connect(function()
            if GGHub.SofaEnabled and Character and Character:FindFirstChild("HumanoidRootPart") then
                UpdateSofaPosition()
            end
        end)
        
        table.insert(GGHub.Connections, conn)
    else
        GGHub.SofaEnabled = false
        
        if GGHub.SofaParts then
            for _, part in pairs(GGHub.SofaParts) do
                if part and part.Parent then
                    part:Destroy()
                end
            end
        end
        
        GGHub.SofaParts = nil
        GGHub.SofaObject = nil
    end
end

function KnifeV4(toggle)
    if toggle then
        GGHub.KnifeEnabled = true
        
        local Knife = Instance.new("Part")
        Knife.Name = "GGHubKnife"
        Knife.Size = Vector3.new(0.2, 1, 0.4)
        Knife.CanCollide = false
        Knife.Material = Enum.Material.Metal
        Knife.BrickColor = BrickColor.new("Mid gray")
        Knife.Parent = workspace
        
        local Handle = Instance.new("Part")
        Handle.Name = "GGHubKnifeHandle"
        Handle.Size = Vector3.new(0.2, 0.8, 0.2)
        Handle.CanCollide = false
        Handle.Material = Enum.Material.Wood
        Handle.BrickColor = BrickColor.new("Black")
        Handle.Parent = workspace
        
        local Blade = Instance.new("Part")
        Blade.Name = "GGHubKnifeBlade"
        Blade.Size = Vector3.new(0.05, 0.7, 0.3)
        Blade.CanCollide = false
        Blade.Material = Enum.Material.Metal
        Blade.BrickColor = BrickColor.new("Institutional white")
        Blade.Reflectance = 0.3
        Blade.Parent = workspace
        
        local Weld = Instance.new("Weld")
        Weld.Part0 = Knife
        Weld.Part1 = Character["Right Arm"]
        Weld.C0 = CFrame.new(0, -1, -0.5) * CFrame.Angles(math.rad(90), 0, 0)
        Weld.Parent = Knife
        
        local HandleWeld = Instance.new("Weld")
        HandleWeld.Part0 = Knife
        HandleWeld.Part1 = Handle
        HandleWeld.C0 = CFrame.new(0, -0.1, 0)
        HandleWeld.Parent = Handle
        
        local BladeWeld = Instance.new("Weld")
        BladeWeld.Part0 = Knife
        BladeWeld.Part1 = Blade
        BladeWeld.C0 = CFrame.new(0, 0.5, 0.05)
        BladeWeld.Parent = Blade
        
        GGHub.KnifeParts = {Knife, Handle, Blade}
        
        local function KnifeAttack()
            if not GGHub.KnifeEnabled then return end
            
            local oldPos = Knife.Position
            local oldRot = Knife.Rotation
            
            for i = 1, 10 do
                Weld.C0 = Weld.C0 * CFrame.Angles(0, 0, math.rad(-9))
                wait(0.02)
            end
            
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
                    local distance = (player.Character.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                    if distance <= 10 then
                        local damageRemote = ReplicatedStorage:FindFirstChild("DamageRemote")
                        if damageRemote then
                            damageRemote:FireServer(player.Character, 25)
                        end
                    end
                end
            end
            
            wait(0.2)
            
            for i = 1, 10 do
                Weld.C0 = Weld.C0 * CFrame.Angles(0, 0, math.rad(9))
                wait(0.02)
            end
        end
        
        local UserInputCon = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and GGHub.KnifeEnabled then
                KnifeAttack()
            end
        end)
        
        table.insert(GGHub.Connections, UserInputCon)
    else
        GGHub.KnifeEnabled = false
        
        if GGHub.KnifeParts then
            for _, part in pairs(GGHub.KnifeParts) do
                if part and part.Parent then
                    part:Destroy()
                end
            end
        end
        
        GGHub.KnifeParts = nil
    end
end

function ClonePlayer(toggle)
    if toggle then
        GGHub.Cloning = true
        
        local function CreateClone()
            if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
            
            local Clone = Character:Clone()
            Clone.Name = LocalPlayer.Name .. "_Clone"
            
            for _, item in pairs(Clone:GetDescendants()) do
                if item:IsA("Script") or item:IsA("LocalScript") then
                    item:Destroy()
                end
                
                if item:IsA("BasePart") then
                    item.Anchored = false
                    item.CanCollide = false
                end
            end
            
            if Clone:FindFirstChild("Humanoid") then
                Clone.Humanoid.PlatformStand = true
            end
            
            local HRP = Clone:FindFirstChild("HumanoidRootPart")
            if HRP then
                local BodyVelocity = Instance.new("BodyVelocity")
                BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                BodyVelocity.Velocity = Vector3.new(0, 0, 0)
                BodyVelocity.Parent = HRP
                
                local Position = Character.HumanoidRootPart.Position + Vector3.new(math.random(-10, 10), 0, math.random(-10, 10))
                HRP.CFrame = CFrame.new(Position)
            end
            
            Clone.Parent = workspace
            
            spawn(function()
                wait(30)
                if Clone and Clone.Parent then
                    Clone:Destroy()
                end
            end)
            
            return Clone
        end
        
        local cloneCount = 0
        local maxClones = 3
        
        local conn = RunService.Heartbeat:Connect(function()
            if GGHub.Cloning and cloneCount < maxClones then
                local clone = CreateClone()
                if clone then
                    cloneCount = cloneCount + 1
                    spawn(function()
                        wait(30)
                        cloneCount = cloneCount - 1
                    end)
                end
                wait(5)
            end
        end)
        
        table.insert(GGHub.Connections, conn)
    else
        GGHub.Cloning = false
        
        for _, child in pairs(workspace:GetChildren()) do
            if child.Name == LocalPlayer.Name .. "_Clone" then
                child:Destroy()
            end
        end
    end
end

function CopySkin(player)
    if not player or not player.Character then return end
    
    local targetCharacter = player.Character
    
    for _, item in pairs(Character:GetChildren()) do
        if item:IsA("Accessory") or item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic") or
           item:IsA("BodyColors") or item:IsA("CharacterMesh") then
            item:Destroy()
        end
    end
    
    for _, item in pairs(targetCharacter:GetChildren()) do
        if item:IsA("Accessory") then
            local clone = item:Clone()
            clone.Parent = Character
        elseif item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic") or item:IsA("BodyColors") then
            local clone = item:Clone()
            clone.Parent = Character
        elseif item:IsA("CharacterMesh") then
            local clone = item:Clone()
            clone.Parent = Character
        end
    end
end

function KillAll()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            
            local damageRemote = ReplicatedStorage:FindFirstChild("DamageRemote")
            if damageRemote then
                for i = 1, 10 do
                    damageRemote:FireServer(character, 100)
                    wait(0.1)
                end
            end
        end
    end
end

function KickPlayer(player)
    if not player then return end
    
    local kickRemote = ReplicatedStorage:FindFirstChild("KickRemote")
    if kickRemote then
        kickRemote:FireServer(player.UserId)
    else
        local networkRemote = ReplicatedStorage:FindFirstChild("NetworkRemote")
        if networkRemote then
            networkRemote:FireServer("Kick", player.UserId)
        end
    end
end

function SpawnBanner(toggle)
    if toggle then
        GGHub.BannerEnabled = true
        
        local Banner = Instance.new("Part")
        Banner.Name = "GGHubBanner"
        Banner.Size = Vector3.new(5, 5, 0.1)
        Banner.Transparency = 0.3
        Banner.CanCollide = false
        Banner.Anchored = true
        Banner.Material = Enum.Material.Neon
        Banner.BrickColor = BrickColor.new("Really blue")
        Banner.Parent = workspace
        
        local SurfaceGui = Instance.new("SurfaceGui")
        SurfaceGui.Face = Enum.NormalId.Front
        SurfaceGui.Parent = Banner
        
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, 0, 1, 0)
        Frame.BackgroundTransparency = 0.5
        Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Frame.BorderSizePixel = 0
        Frame.Parent = SurfaceGui
        
        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, 0, 0.3, 0)
        Title.Position = UDim2.new(0, 0, 0, 0)
        Title.BackgroundTransparency = 1
        Title.Text = "GGHub"
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextScaled = true
        Title.Font = Enum.Font.GothamBold
        Title.Parent = Frame
        
        local Subtitle = Instance.new("TextLabel")
        Subtitle.Size = UDim2.new(1, 0, 0.2, 0)
        Subtitle.Position = UDim2.new(0, 0, 0.3, 0)
        Subtitle.BackgroundTransparency = 1
        Subtitle.Text = "Premium Mod Menu"
        Subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
        Subtitle.TextScaled = true
        Subtitle.Font = Enum.Font.Gotham
        Subtitle.Parent = Frame
        
        local PlayerName = Instance.new("TextLabel")
        PlayerName.Size = UDim2.new(1, 0, 0.2, 0)
        PlayerName.Position = UDim2.new(0, 0, 0.6, 0)
        PlayerName.BackgroundTransparency = 1
        PlayerName.Text = "Usuário: " .. LocalPlayer.Name
        PlayerName.TextColor3 = Color3.fromRGB(255, 255, 100)
        PlayerName.TextScaled = true
        PlayerName.Font = Enum.Font.Gotham
        PlayerName.Parent = Frame
        
        local conn = RunService.Heartbeat:Connect(function()
            if not GGHub.BannerEnabled then return end
            
            if Character and Character:FindFirstChild("HumanoidRootPart") then
                local HRP = Character.HumanoidRootPart
                local position = HRP.Position + (HRP.CFrame.LookVector * 10) + Vector3.new(0, 5, 0)
                Banner.CFrame = CFrame.new(position, position + HRP.CFrame.LookVector)
            end
        end)
        
        table.insert(GGHub.Connections, conn)
        GGHub.BannerObject = Banner
    else
        GGHub.BannerEnabled = false
        
        if GGHub.BannerObject and GGHub.BannerObject.Parent then
            GGHub.BannerObject:Destroy()
            GGHub.BannerObject = nil
        end
    end
end

function CreateUI()
    GGHub.Connections = {}
    
    local MainSection = CreateSection("Principal")
    Content:AddChild(MainSection)
    
    local FlySection = CreateSection("Movimento")
    Content:AddChild(FlySection)
    
    local CombatSection = CreateSection("Combate")
    Content:AddChild(CombatSection)
    
    local TrollSection = CreateSection("Troll")
    Content:AddChild(TrollSection)
    
    local PlayersSection = CreateSection("Jogadores")
    Content:AddChild(PlayersSection)
    
    CreateToggle(MainSection, "Banner", function(toggle)
        SpawnBanner(toggle)
    end)
    
    local playersList = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(playersList, player.Name)
        end
    end
    
    local playerDropdown, getSelectedPlayer = CreateDropdown(PlayersSection, "Selecionar Jogador", playersList, function(selectedName)
        
    end)
    
    CreateButton(PlayersSection, "Copiar Skin", function()
        local selectedName = getSelectedPlayer()
        for _, player in pairs(Players:GetPlayers()) do
            if player.Name == selectedName then
                CopySkin(player)
                break
            end
        end
    end)
    
    CreateButton(PlayersSection, "Kick Jogador", function()
        local selectedName = getSelectedPlayer()
        for _, player in pairs(Players:GetPlayers()) do
            if player.Name == selectedName then
                KickPlayer(player)
                break
            end
        end
    end)
    
    CreateToggle(FlySection, "Fly V3", function(toggle)
        FlyV3(toggle)
    end)
    
    CreateToggle(TrollSection, "Sofá", function(toggle)
        SpawnSofa(toggle)
    end)
    
    CreateToggle(TrollSection, "Clonar", function(toggle)
        ClonePlayer(toggle)
    end)
    
    CreateToggle(CombatSection, "Knife V4", function(toggle)
        KnifeV4(toggle)
    end)
    
    CreateButton(CombatSection, "Matar Todos", function()
        KillAll()
    end)
    
    Players.PlayerAdded:Connect(function(player)
        if player ~= LocalPlayer then
            table.insert(playersList, player.Name)
            
            playerDropdown:Destroy()
            playerDropdown, getSelectedPlayer = CreateDropdown(PlayersSection, "Selecionar Jogador", playersList, function(selectedName)
                
            end)
        end
    end)
    
    Players.PlayerRemoving:Connect(function(player)
        for i, name in ipairs(playersList) do
            if name == player.Name then
                table.remove(playersList, i)
                break
            end
        end
        
        playerDropdown:Destroy()
        playerDropdown, getSelectedPlayer = CreateDropdown(PlayersSection, "Selecionar Jogador", playersList, function(selectedName)
            
        end)
    end)
    
    LocalPlayer.CharacterAdded:Connect(function(newCharacter)
        Character = newCharacter
    end)
end

function LoadGGHub()
    TweenService:Create(LoadingFill, TweenInfo.new(2), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    
    wait(2)
    WelcomeMessage.Text = "Bem-vindo ao GGHub Mod Menu!\n\nCarregamento concluído!"
    
    wait(1)
    CreateUI()
    
    WelcomeFrame.Visible = false
    MainFrame.Visible = true
end

LoadGGHub()

return GGHub
