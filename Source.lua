local GGHub = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local MissionRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("MissionSystem")
local AttackRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Combat")

local FarmingEnabled = false
local CurrentMission = nil
local NPCsToKill = {}
local DeathCount = 0
local LastMission = ""

local MissionsData = {
    [1] = {Name = "NoviceQuest", RequiredLevel = 1, NPCType = "Novice"},
    [10] = {Name = "MarineQuest", RequiredLevel = 10, NPCType = "Marine"},
    [20] = {Name = "BanditQuest", RequiredLevel = 20, NPCType = "Bandit"},
    [30] = {Name = "DesertBanditQuest", RequiredLevel = 30, NPCType = "DesertBandit"},
    [40] = {Name = "FishmanQuest", RequiredLevel = 40, NPCType = "Fishman"},
    [50] = {Name = "SkyIslandQuest", RequiredLevel = 50, NPCType = "SkyWarrior"},
    [65] = {Name = "ColiseumQuest", RequiredLevel = 65, NPCType = "ColiseumFighter"},
    [80] = {Name = "ImpelDownQuest", RequiredLevel = 80, NPCType = "Prisoner"},
    [100] = {Name = "MarineStronghold", RequiredLevel = 100, NPCType = "EliteMarine"},
    [120] = {Name = "NewWorldQuest", RequiredLevel = 120, NPCType = "NewWorldPirate"},
    [140] = {Name = "SkypieanQuest", RequiredLevel = 140, NPCType = "SkypieanGuard"},
    [160] = {Name = "FloatingIslandQuest", RequiredLevel = 160, NPCType = "FloatingIslandBeast"},
    [180] = {Name = "DressrosaQuest", RequiredLevel = 180, NPCType = "DressrosaSoldier"},
    [200] = {Name = "WanoQuest", RequiredLevel = 200, NPCType = "WanoSamurai"}
}

local UI = Instance.new("ScreenGui")
UI.Name = "GGHubAutofarm"
UI.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = UI

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TitleLabel.BorderSizePixel = 0
TitleLabel.Text = "GGHub - Meme Sea Autofarm"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Parent = MainFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(1, -20, 0, 30)
StatusLabel.Position = UDim2.new(0, 10, 0, 50)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: Not Running"
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.TextSize = 14
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = MainFrame

local MissionLabel = Instance.new("TextLabel")
MissionLabel.Name = "MissionLabel"
MissionLabel.Size = UDim2.new(1, -20, 0, 30)
MissionLabel.Position = UDim2.new(0, 10, 0, 80)
MissionLabel.BackgroundTransparency = 1
MissionLabel.Text = "Current Mission: None"
MissionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
MissionLabel.TextSize = 14
MissionLabel.Font = Enum.Font.SourceSans
MissionLabel.TextXAlignment = Enum.TextXAlignment.Left
MissionLabel.Parent = MainFrame

local LevelLabel = Instance.new("TextLabel")
LevelLabel.Name = "LevelLabel"
LevelLabel.Size = UDim2.new(1, -20, 0, 30)
LevelLabel.Position = UDim2.new(0, 10, 0, 110)
LevelLabel.BackgroundTransparency = 1
LevelLabel.Text = "Your Level: 0"
LevelLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LevelLabel.TextSize = 14
LevelLabel.Font = Enum.Font.SourceSans
LevelLabel.TextXAlignment = Enum.TextXAlignment.Left
LevelLabel.Parent = MainFrame

local StartButton = Instance.new("TextButton")
StartButton.Name = "StartButton"
StartButton.Size = UDim2.new(0, 120, 0, 40)
StartButton.Position = UDim2.new(0.5, -130, 1, -50)
StartButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
StartButton.BorderSizePixel = 0
StartButton.Text = "Start"
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartButton.TextSize = 16
StartButton.Font = Enum.Font.SourceSansBold
StartButton.Parent = MainFrame

local StopButton = Instance.new("TextButton")
StopButton.Name = "StopButton"
StopButton.Size = UDim2.new(0, 120, 0, 40)
StopButton.Position = UDim2.new(0.5, 10, 1, -50)
StopButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
StopButton.BorderSizePixel = 0
StopButton.Text = "Stop"
StopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopButton.TextSize = 16
StopButton.Font = Enum.Font.SourceSansBold
StopButton.Parent = MainFrame

local function tween(obj, properties, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(obj, tweenInfo, properties)
    tween:Play()
    return tween
end

local function getPlayerLevel()
    if LocalPlayer and LocalPlayer.Stats then
        return LocalPlayer.Stats.Level.Value or 1
    end
    return 1
end

local function findBestMission()
    local playerLevel = getPlayerLevel()
    local bestMissionKey = 1
    
    for levelReq, missionData in pairs(MissionsData) do
        if playerLevel >= levelReq and levelReq > bestMissionKey then
            bestMissionKey = levelReq
        end
    end
    
    return MissionsData[bestMissionKey]
end

local function teleportToMission()
    local mission = findBestMission()
    if mission then
        local missionNPC = workspace:FindFirstChild("MissionNPC_" .. mission.Name)
        if missionNPC then
            Character:SetPrimaryPartCFrame(missionNPC.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0))
            task.wait(1)
            
            local args = {
                [1] = "AcceptMission",
                [2] = mission.Name
            }
            MissionRemote:FireServer(unpack(args))
            
            CurrentMission = mission
            LastMission = mission.Name
            MissionLabel.Text = "Current Mission: " .. mission.Name
            return true
        end
    end
    return false
end

local function findNPCs()
    NPCsToKill = {}
    local mission = CurrentMission
    
    if mission then
        for _, npc in pairs(workspace.NPCs:GetChildren()) do
            if npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") and 
               npc.Name:find(mission.NPCType) and npc.Humanoid.Health > 0 then
                table.insert(NPCsToKill, npc)
            end
        end
    end
    
    return #NPCsToKill > 0
end

local function attackNPC(npc)
    if npc and npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") then
        if npc.Humanoid.Health <= 0 then
            return false
        end
        
        local targetPosition = npc.HumanoidRootPart.Position + Vector3.new(0, 10, 0)
        local targetCFrame = CFrame.new(targetPosition, npc.HumanoidRootPart.Position)
        
        if (HumanoidRootPart.Position - targetPosition).Magnitude > 2 then
            Character:SetPrimaryPartCFrame(targetCFrame)
        end
        
        AttackRemote:FireServer("Attack")
        task.wait(0.1)
        return true
    end
    return false
end

local function checkMissionComplete()
    local questStatus = LocalPlayer.PlayerGui:FindFirstChild("QuestStatus")
    if questStatus and questStatus:FindFirstChild("Status") then
        return questStatus.Status.Text:find("Completed") ~= nil
    end
    return false
end

local function respawnCharacter()
    if Character and Character:FindFirstChild("Humanoid") then
        Character.Humanoid.Health = 0
        task.wait(5)
        Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        Humanoid = Character:WaitForChild("Humanoid")
        HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
        DeathCount = DeathCount + 1
        return true
    end
    return false
end

local function farmingLoop()
    while FarmingEnabled do
        LevelLabel.Text = "Your Level: " .. getPlayerLevel()
        
        if not CurrentMission or checkMissionComplete() then
            if not teleportToMission() then
                StatusLabel.Text = "Status: Failed to find mission"
                task.wait(5)
                continue
            end
        end
        
        if not findNPCs() then
            StatusLabel.Text = "Status: Looking for NPCs"
            task.wait(1)
            continue
        end
        
        for _, npc in pairs(NPCsToKill) do
            if not FarmingEnabled then break end
            if not npc or not npc.Parent then continue end
            
            StatusLabel.Text = "Status: Attacking " .. npc.Name
            
            local attackAttempts = 0
            while attackNPC(npc) and attackAttempts < 50 do
                attackAttempts = attackAttempts + 1
                if Character:FindFirstChild("Humanoid") and Character.Humanoid.Health <= Character.Humanoid.MaxHealth * 0.3 then
                    respawnCharacter()
                    break
                end
                task.wait(0.2)
            end
            
            task.wait(0.5)
        end
        
        task.wait(1)
    end
    
    StatusLabel.Text = "Status: Not Running"
end

StartButton.MouseButton1Click:Connect(function()
    if not FarmingEnabled then
        FarmingEnabled = true
        StatusLabel.Text = "Status: Running"
        StartButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        coroutine.wrap(farmingLoop)()
    end
end)

StopButton.MouseButton1Click:Connect(function()
    FarmingEnabled = false
    StartButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    StatusLabel.Text = "Status: Stopped"
end)

LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    Humanoid = Character:WaitForChild("Humanoid")
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    
    if FarmingEnabled and LastMission ~= "" then
        task.wait(1)
        teleportToMission()
    end
end)

local function displayWelcome()
    local WelcomeFrame = Instance.new("Frame")
    WelcomeFrame.Name = "WelcomeFrame"
    WelcomeFrame.Size = UDim2.new(0, 300, 0, 150)
    WelcomeFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
    WelcomeFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    WelcomeFrame.BorderSizePixel = 0
    WelcomeFrame.Parent = UI
    
    local WelcomeTitle = Instance.new("TextLabel")
    WelcomeTitle.Name = "WelcomeTitle"
    WelcomeTitle.Size = UDim2.new(1, 0, 0, 50)
    WelcomeTitle.Position = UDim2.new(0, 0, 0, 0)
    WelcomeTitle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    WelcomeTitle.BorderSizePixel = 0
    WelcomeTitle.Text = "GGHub"
    WelcomeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    WelcomeTitle.TextSize = 30
    WelcomeTitle.Font = Enum.Font.GothamBold
    WelcomeTitle.Parent = WelcomeFrame
    
    local WelcomeMessage = Instance.new("TextLabel")
    WelcomeMessage.Name = "WelcomeMessage"
    WelcomeMessage.Size = UDim2.new(1, -20, 0, 60)
    WelcomeMessage.Position = UDim2.new(0, 10, 0, 60)
    WelcomeMessage.BackgroundTransparency = 1
    WelcomeMessage.Text = "Meme Sea Autofarm has been loaded successfully!"
    WelcomeMessage.TextColor3 = Color3.fromRGB(255, 255, 255)
    WelcomeMessage.TextSize = 16
    WelcomeMessage.Font = Enum.Font.Gotham
    WelcomeMessage.TextWrapped = true
    WelcomeMessage.Parent = WelcomeFrame
    
    task.wait(3)
    tween(WelcomeFrame, {Position = UDim2.new(0.5, -150, -0.5, -75)}, 1).Completed:Connect(function()
        WelcomeFrame:Destroy()
    end)
end

local function checkGameValid()
    local isMemeSea = game.PlaceId == 11599532987 or 
                      game.GameId == 11599532987 or 
                      game.PlaceId == 11599533151
    
    if not isMemeSea then
        local ErrorFrame = Instance.new("Frame")
        ErrorFrame.Name = "ErrorFrame"
        ErrorFrame.Size = UDim2.new(0, 300, 0, 150)
        ErrorFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
        ErrorFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        ErrorFrame.BorderSizePixel = 0
        ErrorFrame.Parent = UI
        
        local ErrorTitle = Instance.new("TextLabel")
        ErrorTitle.Name = "ErrorTitle"
        ErrorTitle.Size = UDim2.new(1, 0, 0, 50)
        ErrorTitle.Position = UDim2.new(0, 0, 0, 0)
        ErrorTitle.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        ErrorTitle.BorderSizePixel = 0
        ErrorTitle.Text = "GGHub - Error"
        ErrorTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        ErrorTitle.TextSize = 24
        ErrorTitle.Font = Enum.Font.GothamBold
        ErrorTitle.Parent = ErrorFrame
        
        local ErrorMessage = Instance.new("TextLabel")
        ErrorMessage.Name = "ErrorMessage"
        ErrorMessage.Size = UDim2.new(1, -20, 0, 60)
        ErrorMessage.Position = UDim2.new(0, 10, 0, 60)
        ErrorMessage.BackgroundTransparency = 1
        ErrorMessage.Text = "This script only works in Meme Sea!"
        ErrorMessage.TextColor3 = Color3.fromRGB(255, 255, 255)
        ErrorMessage.TextSize = 16
        ErrorMessage.Font = Enum.Font.Gotham
        ErrorMessage.TextWrapped = true
        ErrorMessage.Parent = ErrorFrame
        
        task.wait(5)
        UI:Destroy()
        return false
    end
    
    return true
end

local function makeGuiDraggable(gui)
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

makeGuiDraggable(MainFrame)

local function initialize()
    if checkGameValid() then
        displayWelcome()
        return GGHub
    else
        return nil
    end
end

return initialize()
