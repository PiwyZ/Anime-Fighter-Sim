```lua
-- [ Before u use this #Read First This not to to mon but just pos Require DPC 800T ]
-- [ Before u use this #Read First This not to to mon but just pos Require DPC 800T ]
-- [ Before u use this #Read First This not to to mon but just pos Require DPC 800T ]
--------------------------------------------------------------------------------------
-- Q = Start
-- E = Stop
local cfFrames = {
    CFrame.new(8252, -183, 15892),
    CFrame.new(8296, -183, 15734),
    CFrame.new(8128, -183, 15592),
    CFrame.new(7940, -183, 15667),
    CFrame.new(7973, -184, 15888),
    CFrame.new(8152, -184, 15942),
    CFrame.new(8077, -184, 15772)
}

local userInputService = game:GetService("UserInputService")
local startKey = Enum.KeyCode.Q
local stopKey = Enum.KeyCode.E

local loopRunning = false

local function moveCharacter()
    for _, cfFrame in ipairs(cfFrames) do
        if not loopRunning then
            break
        end
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = cfFrame
        wait(3)
    end
end

userInputService.InputBegan:Connect(function(input)
    if input.KeyCode == startKey then
        if not loopRunning then
            loopRunning = true
            moveCharacter()
        end
    elseif input.KeyCode == stopKey then
        loopRunning = false
    end
end)
```
