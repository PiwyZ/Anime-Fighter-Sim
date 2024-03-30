local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local success, Library = pcall(function()
    return loadstring(game:HttpGet(repo .. 'Library.lua'))()
end)
if not success then
    error("Failed to load Library module")
end

local success, ThemeManager = pcall(function()
    return loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
end)
if not success then
    error("Failed to load ThemeManager module")
end

local success, SaveManager = pcall(function()
    return loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
end)
if not success then
    error("Failed to load SaveManager module")
end

local TimeTrial = {}
TimeTrial.__index = TimeTrial

function TimeTrial.new(door)
    local self = setmetatable({}, TimeTrial)
    self.door = door
    self.label = nil
    return self
end

function TimeTrial:update()
    if self.door and self.door.Countdown and self.door.Countdown.SurfaceGui and self.door.Countdown.SurfaceGui.Background and self.door.Countdown.SurfaceGui.Background.Time then
        local timeString = self.door.Countdown.SurfaceGui.Background.Time.Text
        local minutes, seconds = timeString:match('(%d+) minutes (%d+) seconds')
        if minutes and seconds then
            local timeInSeconds = tonumber(minutes) * 60 + tonumber(seconds)
            if self.label then
                self.label:SetText(string.format("%s Time Trial: %d minutes %d seconds", self.door.Name, math.floor(timeInSeconds / 60), timeInSeconds % 60))
            end
        end
    end
end

local Window = Library:CreateWindow{
    Title = 'Example Menu',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
}

local Tabs = {
    Main = Window:AddTab('Anime Fighter'),
    ['UI Settings'] = Window:AddTab('UI Settings')
}

local LeftGroupBox = Tabs.Main:AddLeftGroupbox('# Time Counter')

local timeTrials = {}
for i = 1, 7 do
    local door = workspace.Worlds.Tower['Door' .. i]
    if door then
        local timeTrial = TimeTrial.new(door)
        table.insert(timeTrials, timeTrial)
    end
end

local function updateAllTimeTrials()
    while true do
        for _, timeTrial in ipairs(timeTrials) do
            timeTrial:update()
        end
        task.wait(1)
    end
end

task.spawn(updateAllTimeTrials)

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

local success, error_message = pcall(function()
    MenuGroup:AddButton('Unload', function() Library:Unload() end)
    MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

    Library.ToggleKeybind = Options.MenuKeybind
    ThemeManager:ApplyToTab(Tabs['UI Settings'])

    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes{'MenuKeybind'}
    SaveManager:SetFolder('MyScriptHub/specific-game')

    SaveManager:BuildConfigSection(Tabs['UI Settings'])
    SaveManager:LoadAutoloadConfig()
end)
if not success then
    warn("UI Settings setup failed: " .. error_message)
end
