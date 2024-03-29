local FluxLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/araddev/equity/main/equity_uilib.lua"))()

local Workspace = game:GetService("Workspace")
local EntityService = game:GetService("EntityService")
local PacketService = game:GetService("PacketService")
local LightingService = game:GetService("Lighting")
local ChatService = game:GetService("Chat")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Time = os.time()

local Gui = FluxLib:NewGui({
	SizeX = 370,
	SizeY = 245,
	Title = "EQUITY",
	Desc = "Early preview of Equity"
})

local Tab1 = Gui:NewTab({
	TabName = "Ghost", -- Defaults to "Tab <Tab Order>"
	TabItemImage = "https://forum.elysium.wtf/uploads/default/original/2X/f/f99966043a3b047ea93ab7f43ded1462ef1805c9.png"
})

local Tab2 = Gui:NewTab({
	TabName = "Blatant", -- Defaults to "Tab <Tab Order>"
	TabItemImage = "https://forum.elysium.wtf/uploads/default/original/2X/8/8930f31c3dd457a3ee48adbb1ae8676074799695.png"
})

local UI = Gui:NewTab({
	TabName = "Customization", -- Defaults to "Tab <Tab Order>"
	TabItemImage = "https://forum.elysium.wtf/uploads/default/original/2X/7/7e9bbd1b8bbb855eeb320d77314c62cdddc2e9b4.png"
})

time = os.time()


local Fullbright, prevBrightness = false, nil
local Eagle = false
local Killaura = false
local ReachToggle = false
local ReachRange = 4
local VelocityToggle = false
local Scaffold = false
local SumoWalls = false
local counter = 0



UI:NewToggle({
	Text = "Transparent UI",
	ItemDescription = "This thing is so cool",
	CallbackFunction = function(Callback)
		
	end,
})

UI:NewTextBox({
	Text = "Foreground",
	ItemDescription = "Customize the foreground color of the UI.",
	ItemContent = "OH MY GOD",
	CallbackFunction = function(Callback)
		
	end
})

Tab2:NewToggle({
	Text = "KickSelf",
	ItemDescription = "kicks you (works only in servers)",
	CallbackFunction = function(Callback)
		game:Shutdown("bye bye!")
	end
})

Tab1:NewToggle({
	Text = "NoClickDelay",
	ItemDescription = "Removes click delay",
	CallbackFunction = function(Callback)
		
	end
}):Slider({
	Name = "test",
	Min = 0,
	Max = 10,
	Default = 5,
    Callback = function(val)
        
    end
})
Tab1:NewToggle({
	Text = "Fullbright",
	ItemDescription = "Gives you night vision",
	CallbackFunction = function(Callback)
		Fullbright = Callback
		if Callback == false and prevBrightness ~= nil then
			LightingService.Brightness = prevBrightness
			prevBrightness = nil
		end
	end
})

Tab1:NewToggle({
	Text = "AutoClicker",
	ItemDescription = "Automatically clicks",
	CallbackFunction = function(Callback)
		
	end
})


Tab1:NewToggle({
	Text = "Wtap",
	ItemDescription = "Double click on click",
	CallbackFunction = function(Callback)
		
	end
})

Tab1:NewText({
	Text = "Player"
})

Tab1:NewToggle({
	Text = "Eagle",
	ItemDescription = "Auto place or god bridge basically",
	CallbackFunction = function(Callback)
		Eagle = not Eagle
	end
})

Tab1:NewToggle({
	Text = "Reach",
	ItemDescription = "Extends reach",
	CallbackFunction = function(Callback)
		ReachToggle = not ReachToggle
	end,
	OptionsMenu = true
}):Slider({
	Name = "Range",
	Min = 1,
	Max = 6,
	Default = 4,
    Callback = function(val)
        ReachRange = val
    end
})

Tab1:NewToggle({
	Text = "AimAssist",
	ItemDescription = "Assists you in aiming",
	CallbackFunction = function(Callback)
		print("hello")
	end,
	OptionsMenu = true
})

Tab1:NewToggle({
	Text = "Velocity",
	ItemDescription = "Low knockback",
	CallbackFunction = function(Callback)
		VelocityToggle = not VelocityToggle
	end,
	OptionsMenu = true
})
local killauraCooldown = 200
local killauraCooldownMin = 200
local killauraCooldownMax = 300
Tab2:NewToggle({
	Text = "Kill Aura",
	ItemDescription = "Automatically kills people and shit",
	CallbackFunction = function(Callback)
		Killaura = not Killaura
	end,
	OptionsMenu = true
}):SliderRange({
	Name = "Cooldown (MS)",
	Min = 200,
	Max = 500,
	DefaultMin = killauraCooldownMin,
	DefaultMax = killauraCooldownMax,
	Callback = function(min, max)
		killauraCooldownMin = min
		killauraCooldownMax = max
	end
})


Tab2:NewToggle({
	Text = "Scaffold",
	ItemDescription = "Automatically places blocks !",
	CallbackFunction = function(Callback)
		Scaffold = not Scaffold
	end,
	OptionsMenu = true
})

local DEFAULT_TYPE = "iron_ore"
local WALL_HEIGHT = 3
local MIN_GAP_HEIGHT = 3

Tab2:NewToggle({
	Text = "SumoWalls",
	ItemDescription = "Anti fall !!",
	CallbackFunction = function(Callback)
		SumoWalls = not SumoWalls
	end,
	OptionsMenu = true
}):Slider({
	Name = "Min Gap Height",
	Min = 2,
	Max = 10,
	Default = MIN_GAP_HEIGHT,
    Callback = function(val)
        MIN_GAP_HEIGHT = val
    end
}):Slider({
	Name = "Wall Height",
	Min = 1,
	Max = 10,
	Default = WALL_HEIGHT,
    Callback = function(val)
        WALL_HEIGHT = val
    end
}):TextBox({
    Name = "Block Type",
	Placeholder = "Block Type",
	Editable = true,
    Text = DEFAULT_TYPE,
    Callback = function(text)
        DEFAULT_TYPE = text
    end
})

local function WrapAngleTo180(angle)
    return (angle + 180) % 360 - 180
end

local function GetYawChange(yaw, x, z)
    local deltaX = x - LocalPlayer.Character:GetPosX()
    local deltaZ = z - LocalPlayer.Character:GetPosZ()
    local yawToEntity = math.deg(math.atan2(deltaZ, deltaX)) - 90
    return WrapAngleTo180(-(yaw - yawToEntity))
end

function GetPitchChange(pitch, posX, posY, posZ)
    local playerPosX = LocalPlayer.Character:GetPosX()
    local playerPosY = LocalPlayer.Character:GetPosY()
    local playerPosZ = LocalPlayer.Character:GetPosZ()

    local deltaY = posY - 2.2 - playerPosY
    local deltaX = posX - playerPosX
    local deltaZ = posZ - playerPosZ

    deltaY = posY - playerPosY + 0.0625

    local distance = math.sqrt(deltaX * deltaX + deltaZ * deltaZ)

    local pitchToEntity = (-math.deg(math.atan(deltaY / distance)) - 2 + (LocalPlayer.Character:GetDistance(posX, posY, posZ) * 0.2)) + 1
    return -WrapAngleTo180(pitch - pitchToEntity)
end

function GetOffsets(face, bx, by, bz)
    local offsets = {
    [LocalPlayer.East] = {x = bx + 1, y = by + 1, z = bz + 0.5},
    [LocalPlayer.West] = {x = bx, y = by + 1, z = bz + 0.5},
    [LocalPlayer.South] = {x = bx + 0.5, y = by + 1, z = bz + 1},
    [LocalPlayer.North] = {x = bx + 0.5, y = by + 1, z = bz},
    [LocalPlayer.Up] = {x = bx + 0.5, y = by + 1, z = bz + 0.5},
    [LocalPlayer.Down] = {x = bx + 0.5, y = by, z = bz + 0.5},
    }
    return offsets[face]
end

function DoScaffold()
	Character = LocalPlayer.Character
    local blockposUnder = Vector3.new(Character:GetPosX(), Character:GetPosY() - 1, Character:GetPosZ())  
    local blockUnder = Workspace:GetBlock(blockposUnder)
    local nameUnder = Workspace:GetBlockName(blockUnder)
    
    --print(blockpos)
    --print(block)
    --print(name)
    
    if(nameUnder ~= "air") then 
        return
    end

    local ClosestDistance = 8
    local BlockposTarget = nil

    local posX = 0
    local posY = 0
    local posZ = 0

    for x = -3, 3 do
        for y = -3, 3 do
            for z = -3, 3 do
                local blockpos = Vector3.new(Character:GetPosX() + x, Character:GetPosY() + y, Character:GetPosZ() + z)  
                local block = Workspace:GetBlock(blockpos)
                local name = Workspace:GetBlockName(block)
                
                --print(blockpos)
                --print(block)
                --print(name)
                
                if(name ~= "air") then 
                    local tempPosX = math.ceil(Character:GetPosX() + x) - 0.5
                    local tempPosY = math.ceil(Character:GetPosY() + y) - 0.5
                    local tempPosZ = math.ceil(Character:GetPosZ() + z) - 0.5

                    local Distance = Character:GetDistance(tempPosX, tempPosY, tempPosZ)
                    --local Distance = LocalPlayer:getDistanceSqToCenter(blockpos)
                    if(Distance < ClosestDistance) then
                        ClosestDistance = Distance
                        BlockposTarget = blockpos
                        posX = tempPosX
                        posY = tempPosY
                        posZ = tempPosZ
                    end
                end
            end
        end
    end

    if(BlockposTarget == nil) then
        return
    end

    print(Workspace:GetBlockName(Workspace:GetBlock(BlockposTarget)))
    print("Distance: ", ClosestDistance)
    print("PosX: ", posX)
    print("PosY: ", posY)
    print("PosZ: ", posZ)

    --LocalPlayer:SetPitch(GetPitchChange(0, posX, posY, posZ))
    --LocalPlayer:SetYaw(GetYawChange(0, posX, posZ))
    local Face = Character:GetHorizontalFacing(180 + GetYawChange(0, posX, posZ))

    local DiffrenceY = Character:GetPosY() - posY - 1.5

    print("Diff: ", DiffrenceY)

    if(DiffrenceY > 0) then
        Face = LocalPlayer.Up
    end

    --if(DiffrenceY < -1) then -- Downwards scaffold
    --    Face = LocalPlayer.Down
    --end

    local offsets = GetOffsets(Face, math.floor(posX), math.floor(posY), math.floor(posZ))
    local position = Vector3.new(offsets.x, offsets.y, offsets.z)

    print("position: ", position)
    print("ceilposy: ", math.ceil(posY))
    print("offsetsy: ", offsets.y)

    Character:Swing()

    Character:PlaceBlock(Character:GetStackHeld(), BlockposTarget:ToBlockPos(), Face, position)
end

function AttackClosest()
    LocalPlayer = game:GetService("Players").LocalPlayer
    localPlayer = LocalPlayer.Character -- when changing worlds the character changes so we have to do this to keep it updated

    local Entities = Workspace:GetPlayers()
    local PlayerEntity = localPlayer.entity

    local closestEntity
    local closestDistance = 5

    for _, Entity in ipairs(Entities) do
        --print(Entity:getName())
        local distance = localPlayer:GetDistanceToEntity(Entity.entityObject)
		if (distance < closestDistance) and (Entity.entityObject ~= PlayerEntity) then
            closestDistance = distance
            closestEntity = Entity
        end
    end

    if closestEntity == nil then
        return
    end

	Attack(closestEntity)
    local yaw = localPlayer:GetYaw()
    local pitch = localPlayer:GetPitch()

    local moveYaw = GetYawChange(yaw, closestEntity:GetPosX(), closestEntity:GetPosZ())
    local movePitch = GetPitchChange(pitch, closestEntity:GetPosX(), closestEntity:GetPosY()-0.5, closestEntity:GetPosZ())

    local gcd = 0.2

    local yawGcdFix = 0.05 - (moveYaw % gcd)
    local pitchGcdFix = 0.05 - (movePitch % gcd)

    localPlayer:AddYaw(moveYaw * 0.5 + yawGcdFix)
    localPlayer:AddPitch(movePitch * 0.5 + pitchGcdFix)
end

function DoEagle()
	if LocalPlayer.Character:IsBlockBelowAir() and LocalPlayer.Character:GetMoveForward() < 0.1 then
		if not LocalPlayer.Character:IsFlying() then
			time = os.time()
		end
	end
	if not ((os.time() - time) > 125 ) then
	LocalPlayer.Character:SetSneaking(true)
	else if not LocalPlayer.Character:IsSneakPressed() then
		LocalPlayer.Character:SetSneaking(false)
	end
	end
end

local workspace = Workspace

for i,v in pairs(workspace:GetClientBlocks()) do
    v:Remove()
end
local clientBlocks = {}
function getBlock(position)
    return workspace:GetBlock(position);
end
function place(x,y,z)
    local block = Instance.new("Block")
    block.Position = Vector3.new(x,y,z)
    block.Type = DEFAULT_TYPE
    block:Update()
    table.insert(clientBlocks, block)
end
function getHeightUntilGround(x,y,z)
    local height = 0
    while workspace:GetBlockName(x,y - height,z) == "air" and height < 100 do
        height = height + 1
    end
    return height
end
function clearGhostBlocks()
    for i,v in pairs(clientBlocks) do
        v:Remove()
        clientBlocks[i] = nil
    end
end
function doSumoWalls()
    local Character = LocalPlayer.Character
    if not Character then return end
    clearGhostBlocks()
    local x,y,z = Character:GetPosX(), Character:GetPosY(), Character:GetPosZ()
    local height = getHeightUntilGround(x,y,z)
    for xOffset = -2, 2 do
        for zOffset = -2, 2 do
            if(xOffset == 0 and zOffset == 0)then goto continue end
            local x,y,z = x + xOffset, y, z + zOffset

            local isGap = true
            for yOffset = 0, MIN_GAP_HEIGHT do
                if workspace:GetBlockName(x,y - yOffset,z) ~= "air" then 
                    isGap = false 
                    break 
                end
            end

            if isGap then
                local newHeight = getHeightUntilGround(x, y, z)
                if height < newHeight or Character:IsOnGround() then
                    for offset = 0, WALL_HEIGHT-1 do
                        place(x,y + 1 - offset,z)
                    end
                end
            end
            ::continue::
        end
    end
end

local counter = 0

function DoVelocity()
    print("HurtTime: " .. LocalPlayer.Character:GetHurtTime())
    if LocalPlayer.Character:GetHurtTime() == 9 then
        LocalPlayer.Character:SetMotionZ(0)
        LocalPlayer.Character:SetMotionY(0)
        LocalPlayer.Character:SetMotionX(0)
    end
end
function Attack(entity)
	if (Time < os.time()) then
		local Character = LocalPlayer.Character
		
        Character:Swing()
        math.randomseed(os.time())
        Time = os.time() + math.random(killauraCooldownMin, killauraCooldownMax)
        PacketService:SendPacket("C02", { entity.entityObject, Character.Attack })
    end
end
function DoReach()
	local entity = LocalPlayer:Reach(ReachRange)
	if entity then
		Attack(entity)
	end
end
function DoCrit()
	local x,y,z = LocalPlayer.Character:GetPosX(), LocalPlayer.Character:GetPosY(), LocalPlayer.Character:GetPosZ()
	PacketService:SendPacket("C04", {x, y + 0.0625,z, true})
	PacketService:SendPacket("C04", {x, y, z, false})
	PacketService:SendPacket("C04", {x, y + 1.1E-5D,z, false})
end

function DoFullbright()
	if LightingService.Brightness ~= 10 then
		prevBrightness = LightingService.Brightness -- sets it to 10 idk why
		LightingService.Brightness = 10
	end
end
Script.MouseClick1:Connect(function(e)
	--DoCrit()
	if ReachToggle then
		DoReach()
	end
end)

Script.Update:Connect(function()

    if VelocityToggle then
		DoVelocity()
    end
    --killaura handler
	if Killaura then
		AttackClosest()
    end

	if Scaffold then 
		DoScaffold()
	end

	-- eagle handler
	if Eagle then
		DoEagle()
    end

    if SumoWalls then
        doSumoWalls()
    else clearGhostBlocks() end
	if Fullbright then
		DoFullbright()
	end
end)