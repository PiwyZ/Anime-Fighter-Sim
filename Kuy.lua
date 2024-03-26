-- Required modules
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- Constants
local gameService = game:GetService("ReplicatedStorage")
local player = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")

-- Variables
local petsFolder = game.Workspace:FindFirstChild("Pets")
local AutoPetClone1, AutoPetClone2 = false, false
local Cloned1Done, Cloned2Done = false, false
local PetID1, PetID2

-- Function to get pet IDs
local function GetIDs()
    PetID1, PetID2 = nil, nil
    for _, pet in ipairs(petsFolder:GetChildren()) do
        if pet:FindFirstChild("Data") and pet.Data:FindFirstChild("UID") then
            if not PetID1 then
                PetID1 = pet.Data.UID.Value
                print(PetID1)
            elseif not PetID2 then
                PetID2 = pet.Data.UID.Value
                print(PetID2)
                break
            end
        end
    end
end

-- Function to clone a pet
local function ClonePet(id, machine)
    gameService.Remote.AttemptClone:FireServer(id, machine)
end

-- Function to withdraw from machine
local function WithdrawFromMachine(machine)
    gameService.Remote.AttemptWithdrawCloneMachine:FireServer(machine)
end

-- Function to equip an artifact
local function EquipArtifact(name, slot)
    gameService.Remote.EquipArtefact:FireServer(name, slot)
end

-- Main window and tabs
local Window = Fluent:CreateWindow({ Title = "Extra Scripts", SubTitle = "- Irlv", TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = true, Theme = "Dark", MinimizeKey = Enum.KeyCode.RightControl })
local Tabs = { Main = Window:AddTab({ Title = "Main", Icon = "home" }), Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }), Clone = Window:AddTab({ Title = "Clone", Icon = "copy" })}

-- Main tab
local MainTab = Tabs.Main

-- Button to swap team
--[[MainTab:AddButton({
    Title = '[Swap Team]',
    Description = "Customize your team",
    Callback = function()
 
    end
})]]
MainTab:AddButton({
    Title = '[ Select First Artifact ]',
    Description = "Custom Artifact",
    Callback = function()
        Window:Dialog({
            Title = "Select First Artifact",
            Content = "",
            Buttons = {
                { Title = "Yen", Callback = function() EquipArtifact("Yen", "CurrentArtefact") Notify("Equip Yen") end },
                { Title = "Passive", Callback = function() EquipArtifact("Dreams", "CurrentArtefact") Notify("Equip Passive") end },
                { Title = "Times", Callback = function() EquipArtifact("Time", "CurrentArtefact") Notify("Equip Time") end },
                { Title = "Drops", Callback = function() EquipArtifact("Drops", "CurrentArtefact") Notify("Equip Drops") end },
                { Title = "Equip", Callback = function() EquipArtifact("Equip", "CurrentArtefact") Notify("Equip Equip") end },
                { Title = "Attack", Callback = function() EquipArtifact("Damage", "CurrentArtefact") Notify("Equip Damage") end },
                { Title = "Key", Callback = function() EquipArtifact("Dungeon", "CurrentArtefact") Notify("Equip Dungeon") end },
                { Title = "Luck", Callback = function() EquipArtifact("Luck", "CurrentArtefact") Notify("Equip Luck") end },
            }
        })
    end
})

MainTab:AddButton({
    Title = '[ Select Second Artifact ]',
    Description = "Custom Artifact",
    Callback = function()
        Window:Dialog({
            Title = "Select Second Artifact",
            Content = "",
            Buttons = {
                { Title = "Yen", Callback = function() EquipArtifact("Yen", "CurrentSecondArtefact") Notify("Equip Yen") end },
                { Title = "Passive", Callback = function() EquipArtifact("Dreams", "CurrentSecondArtefact") Notify("Equip Passive") end },
                { Title = "Times", Callback = function() EquipArtifact("Time", "CurrentSecondArtefact") Notify("Equip Time") end },
                { Title = "Drops", Callback = function() EquipArtifact("Drops", "CurrentSecondArtefact") Notify("Equip Drops") end },
                { Title = "Equip", Callback = function() EquipArtifact("Equip", "CurrentSecondArtefact") Notify("Equip Equip") end },
                { Title = "Attack", Callback = function() EquipArtifact("Damage", "CurrentSecondArtefact") Notify("Equip Damage") end },
                { Title = "Key", Callback = function() EquipArtifact("Dungeon", "CurrentSecondArtefact") Notify("Equip Dungeon") end },
                { Title = "Luck", Callback = function() EquipArtifact("Luck", "CurrentSecondArtefact") Notify("Equip Luck") end },
            }
        })
    end
})

-- Button to save pet IDs
MainTab:AddButton({
    Title = '[ 📄Save id pets ]',
    Description = "This is for clone functions\nEquip only *2* pets then click this button\n after this you can swap to your teams no problem",
    Callback = function()
        GetIDs()
    end
})

local Clone1Toggle = MainTab:AddToggle("Clone1Toggle", {Title = "Auto Clone 1", Default = false })
Clone1Toggle:OnChanged(function(value)
    AutoPetClone1 = value
end)

local Clone2Toggle = MainTab:AddToggle("Clone2Toggle", {Title = "Auto Clone 2", Default = false })
Clone2Toggle:OnChanged(function(value)
    AutoPetClone2 = value
end)

local function Notify(Text)
    Fluent:Notify({
        Title = "AFS - Extra",
        Content = Text,
        Duration = 8
    })
end

Window:SelectTab(1)
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
Notify("Scripts have been Loaded.")

local function ProcessCloning()
    if AutoPetClone1 and not Cloned1Done then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-6730.70312, -182.165451, -4739.05127, 0.569838881, 7.61294194e-10, 0.821756423, -1.02772929e-10, 1, -8.55156279e-10, -0.821756423, 4.02847006e-10, 0.569838881)
        wait(3)
        ClonePet(PetID1, "A")
        Cloned1Done = true
    end
    if AutoPetClone2 and Cloned1Done and not Cloned2Done then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-4168.07227, -189.446075, -10412.1992, -0.873169065, 8.48298409e-09, -0.48741743, 2.48879584e-09, 1, 1.29454634e-08, 0.48741743, 1.00904956e-08, -0.873169065)
        wait(3)
        ClonePet(PetID2, "B")
        Cloned2Done = true
    end
    if Cloned1Done and Cloned2Done then
        WithdrawFromMachine("A")
        WithdrawFromMachine("B")
    end
end

runService.Heartbeat:Connect(ProcessCloning)
