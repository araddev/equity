local FluxLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/araddev/equity/main/equity_uilib.lua"))()

local Workspace = game:GetService("Workspace")
local EntityService = game:GetService("EntityService")
local PacketService = game:GetService("PacketService")
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
	TabItemImage = "https://cdn.discordapp.com/attachments/1027869083162640384/1090713154146816210/icons8-sad-ghost-48.png"
})

local Tab2 = Gui:NewTab({
	TabName = "Blatant", -- Defaults to "Tab <Tab Order>"
	TabItemImage = "https://cdn.discordapp.com/attachments/1041371360003379271/1068622339891286088/account_box_FILL1_wght400_GRAD0_opsz48_1.png"
})

local UI = Gui:NewTab({
	TabName = "Customization", -- Defaults to "Tab <Tab Order>"
	TabItemImage = "https://cdn.discordapp.com/attachments/1027869083162640384/1090712902647939283/icons8-change-theme-48.png"
})

time = os.time()


local Eagle = false
local Killaura = false
local ReachToggle = false
local VelocityToggle = false
local Scaffold = false
local counter = 0



UI:NewToggle({
	Text = "Transparent UI",
	ItemDescription = "This thing is so cool",
	CallbackFunction = function(Callback)
		
	end
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
	Text = "Eagle",
	ItemDescription = "Auto place or god bridge basically",
	CallbackFunction = function(Callback)
		Eagle = not Eagle
	end
})

Tab1:NewToggle({
	Text = "NoClickDelay",
	ItemDescription = "Removes click delay",
	CallbackFunction = function(Callback)
		
	end
})

Tab2:NewToggle({
	Text = "SumoWalls",
	ItemDescription = "Walls around falls",
	CallbackFunction = function(Callback)
		
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

Tab1:NewToggle({
	Text = "Reach",
	ItemDescription = "Extends reach",
	CallbackFunction = function(Callback)
		ReachToggle = not ReachToggle
	end
})

Tab1:NewToggle({
	Text = "Velocity",
	ItemDescription = "Low knockback",
	CallbackFunction = function(Callback)
		VelocityToggle = not VelocityToggle
	end
})

Tab1:NewText({
	Text = "Player"
})

Tab1:NewToggle({
	Text = "AimAssist",
	ItemDescription = "Assists you in aiming",
	CallbackFunction = function(Callback)
		print("hello")
	end
})

Tab2:NewToggle({
	Text = "Kill Aura",
	ItemDescription = "Automatically kills people and shit",
	CallbackFunction = function(Callback)
		Killaura = not Killaura
	end
})

Tab2:NewToggle({
	Text = "Scaffold",
	ItemDescription = "Automatically places blocks !",
	CallbackFunction = function(Callback)
		Scaffold = not Scaffold
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
    print(by)
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
    local blockposUnder = Workspace:GetBlockPos(Character:GetPosX(), Character:GetPosY() - 1, Character:GetPosZ())  
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
                local blockpos = Workspace:GetBlockPos(Character:GetPosX() + x, Character:GetPosY() + y, Character:GetPosZ() + z)  
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
    local position = Workspace:GetVec3(offsets.x, offsets.y, offsets.z)

    print("position: ", position)
    print("ceilposy: ", math.ceil(posY))
    print("offsetsy: ", offsets.y)

    Character:Swing()

    Character:PlaceBlock(Character:GetStackHeld(), BlockposTarget, Face, position)
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
		if (distance < closestDistance) and (Entity.entityObject ~= PlayerEntity) and (not localPlayer:IsOnSameTeam(Entity.entityObject)) then
            closestDistance = distance
            closestEntity = Entity
        end
    end

    if closestEntity == nil then
        return
    end

    if (Time < os.time()) then
        localPlayer:Swing()
        math.randomseed(os.time())
        Time = os.time() + 100 + math.random(0, 100)
        PacketService:SendPacket("C02", { closestEntity.entityObject, localPlayer.Attack })
    end

    local yaw = localPlayer:GetYaw()
    local pitch = localPlayer:GetPitch()

    local moveYaw = GetYawChange(yaw, closestEntity:GetPosX(), closestEntity:GetPosZ())
    local movePitch = GetPitchChange(pitch, closestEntity:GetPosX(), closestEntity:GetPosY(), closestEntity:GetPosZ())

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

function DoVelocity()
	if counter < 5000 then
        --print("Packet: " .. tostring(e.packet))
        local WrappedPacket = packetservice:GetPacket(e.packet)
        
        if WrappedPacket.identifier == "S12" then
            --print("Packet: " .. WrappedPacket.identifier)
            e:setCanceled(true)
        end
        
        counter = counter + 1
    end
end

Script.ReceivePacket:Connect(function(e)
	if VelocityToggle then
		DoVelocity()
    end
end)

function DoReach()
	LocalPlayer:Reach(6)
end

Script.MouseClick1:Connect(function(e)
	if ReachToggle then
		DoReach()
	end
end)

Script.Update:Connect(function()
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
end)