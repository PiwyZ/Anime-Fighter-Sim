local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({ Title = "Extra Scripts", SubTitle = "- Irlv", TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = true, Theme = "Rose", MinimizeKey = Enum.KeyCode.RightControl })
local Tabs = { Main = Window:AddTab({ Title = "Main", Icon = "chevrons-up" }), Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }) }
local Mein = Tabs.Main

Mein:AddButton({
    Title = '[Swap Team]',
    Description = "Customize your team",
    Callback = function()
        Window:Dialog({
            Title = "Select Team Number.",
            Content = "",
            Buttons = {
                { Title = "Team 1", Callback = function() end },
                { Title = "Team 2", Callback = function() end },
                { Title = "Team 3", Callback = function() end },
                { Title = "Team 4", Callback = function() end },
                { Title = "Team 5", Callback = function() end }
            }
        })
    end
})



Mein:AddButton({
    Title = '[ Select First Artifact ]',
    Description = "Custom Artifact",
    Callback = function()
        Window:Dialog({
            Title = "Select First Artifac",
            Content = "",
            Buttons = {
                { Title = "Yen", Callback = function() EquipArtifact("Yen") Notify("Equip Yen") end },
                { Title = "Passive", Callback = function() EquipArtifact("Dreams") Notify("Equip Passive") end },
                { Title = "Times", Callback = function() EquipArtifact("Time") Notify("Equip Time") end },
                { Title = "Drops", Callback = function() EquipArtifact("Drops") Notify("Equip Drops") end },
                { Title = "Equip", Callback = function() EquipArtifact("Equip") Notify("Equip Equip") end },
                { Title = "Attack", Callback = function() EquipArtifact("Damage") Notify("Equip Damage") end },
                { Title = "Key", Callback = function() EquipArtifact("Dungeon") Notify("Equip Dungeon") end },
                { Title = "Luck", Callback = function() EquipArtifact("Luck") Notify("Equip Luck") end },
            }
        })
    end
})

Mein:AddButton({
    Title = '[ Select Second Artifact ]',
    Description = "Custom Artifact",
    Callback = function()
        Window:Dialog({
            Title = "Select Second Artifac",
            Content = "",
            Buttons = {
                { Title = "Yen", Callback = function() EquipArtifact2("Yen") Notify("Equip Yen") end },
                { Title = "Passive", Callback = function() EquipArtifact2("Dreams") Notify("Equip Passive") end },
                { Title = "Times", Callback = function() EquipArtifact2("Time") Notify("Equip Time") end },
                { Title = "Drops", Callback = function() EquipArtifact2("Drops") Notify("Equip Drops") end },
                { Title = "Equip", Callback = function() EquipArtifact2("Equip") Notify("Equip Equip") end },
                { Title = "Attack", Callback = function() EquipArtifact2("Damage") Notify("Equip Damage") end },
                { Title = "Key", Callback = function() EquipArtifact2("Dungeon") Notify("Equip Dungeon") end },
                { Title = "Luck", Callback = function() EquipArtifact2("Luck") Notify("Equip Luck") end },
            }
        })
    end
})

function EquipArtifact(name)
    local args = {name, "CurrentArtefact"}
    game:GetService("ReplicatedStorage").Remote.EquipArtefact:FireServer(unpack(args))
end
function EquipArtifact2(name)
    local args = {name, "CurrentSecondArtefact"}
    game:GetService("ReplicatedStorage").Remote.EquipArtefact:FireServer(unpack(args))
end
function Notify(Text)
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
Notify("Scrips Has been Loaded.")
SaveManager:LoadAutoloadConfig()


