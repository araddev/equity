local FluxLib = {}

function FluxLib:NewGui(GuiProperties)
	-- Fonts (loading them from discord and guilded cdn because im 2 lazy)
	local GothamSSm = "https://cdn.discordapp.com/attachments/695925843834306592/1071401151913803786/1746-font.otf"
	local GothamSSm_Medium = "https://img.guildedcdn.com/ContentMediaGenericFiles/f2afb4c395f1bf4f604d816bc719664f-Full.otf?w=1&h=1"
	local Poppins_SemiBold = "https://cdn.discordapp.com/attachments/1123581682784677940/1123593374776172544/Poppins-SemiBold.ttf"
	local Outfit_Regular = "https://img.guildedcdn.com/ContentMediaGenericFiles/55c9ece0a0c8820c818f4664c8ce72ae-Full.ttf?w=1&h=1"

	local Gui = {}
	local GuiTabs = {}


	local function GuiTabs_GetTableIndex(ItemContainer)
		for i = 1, #GuiTabs do
			local GuiTab = GuiTabs[i]
			if GuiTab.ItemContainer == ItemContainer then
				return GuiTab
			end
		end
	end
	
	local SizeX = GuiProperties.SizeX or 370
	local SizeY = GuiProperties.SizeY or 245
	local TitleText = GuiProperties.Title and string.upper(GuiProperties.Title) or "GUI"
	local DescText = GuiProperties.Desc or "Preview"
	local Player = game:GetService("Players").LocalPlayer
	local Mouse = Player:GetMouse()
	local ScreenGui = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local SideBarParent = Instance.new("Frame")
	local SideBar = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local Desc = Instance.new("TextLabel")
	local ServerLocation = Instance.new("TextLabel")
	local SideBarItemList = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local TweenService = game:GetService("TweenService")
	local Radius = CornerRadius.new(5, 5, 5, 5)



	Script.KeyType:Connect(function(e)
	if e.KeyCode == 54 then
    ScreenGui:Open()
	end
	end)

	Frame.Size = UDim2.new(0, SizeX, 0, SizeY)
	Frame.CornerRadius = CornerRadius.new(5, 5, 5, 5)
	Frame.BorderSizePixel = 0
	Frame.BackgroundColor3 = Color3.fromHex("#0e0e1a")
	Frame.Draggable = true
	Frame.VerticalAlignment = "Center"
	Frame.HorizontalAlignment = "Center"
	Frame.ClipsDescendants = true

	Title.Text = TitleText
	Title.Font = GothamSSm
	Title.Position = UDim2.new(0, 12, 0, 16)
	
	Desc.Text = DescText
	Desc.Font = GothamSSm_Medium -- cant fucking use discord cdn because its blocked in iran
	Desc.Position = UDim2.new(0, 12, 0, 33)
	Desc.FontSize = 14	
	Desc.TextColor3 = Color3.fromRGB(225,225,225);
	
	ServerLocation.FontSize = 15
	ServerLocation.Position = UDim2.new(0, 12, 0, 31)
	
	SideBarParent.Size = UDim2.new(0, 120, 0, SizeY)
	SideBarParent.BackgroundTransparency = 1
	SideBarParent.ClipsDescendants = true
	
	SideBar.Size = UDim2.new(0, 125, 0, 245)
	SideBar.BackgroundColor3 = Color3.fromHex("#13121e")
	SideBar.BorderSizePixel = 0
	SideBar.CornerRadius = CornerRadius.new(5, 5, 5, 5)
	
	SideBarItemList.Size = UDim2.new(0, 125, 0, 198)
	SideBarItemList.BackgroundTransparency = 1
	SideBarItemList.BorderSizePixel = 0
	SideBarItemList.VerticalAlignment = "bottom"
	
	UIListLayout.Padding = UDim.new(3, 0)
	UIListLayout.ChildrenHorizontalAlignment = "Center"
	
	UIListLayout.Parent = SideBarItemList
	SideBarItemList.Parent = SideBar
	ServerLocation.Parent = SideBar
	Title.Parent = SideBar
	Desc.Parent = SideBar
	SideBar.Parent = SideBarParent
	SideBarParent.Parent = Frame
	Frame.Parent = ScreenGui
	ScreenGui.IsEnabled = true
	
	function Gui:NewTab(TabProperties)
		local Tab = {}
		
		local TabName = TabProperties.TabName or "Tab ".. tostring(#GuiTabs + 1)
		local TabItemImage = TabProperties.TabItemImage
		local AccentColor = TabProperties.AccentColor or Color3.fromHex("#5e1f9e")
		local Active = TabProperties.Active or (#GuiTabs == 0 and true or false)
		
		if Active and #GuiTabs > 0 then
			for i = 1, #GuiTabs do
				local GuiTab = GuiTabs[i]
				if GuiTab.Active then
					GuiTab.Active = false
					GuiTab.TabItem.BackgroundTransparency = 1
					GuiTab.ItemContainer.Visible = false
				end
			end
		end
		
		local TabItem = Instance.new("TextButton")
		local TabItemIcon = Instance.new("ImageLabel")
		local TabItemTitle = Instance.new("TextLabel")
		local ItemContainer = Instance.new("Frame")
		local ItemListLayout = Instance.new("UIListLayout")
		
		TabItem.Size = UDim2.new(0, 125, 0, 24)
		TabItem.BorderSizePixel = 0
		TabItem.BackgroundColor3 = AccentColor
		TabItem.BackgroundTransparency = Active and 0 or 1
		
		TabItemIcon.Size = UDim2.new(0, 16, 0, 16)
		TabItemIcon.VerticalAlignment = "Center"
		TabItemIcon.Image = TabItemImage
		TabItemIcon.BackgroundTransparency = 1
		TabItemIcon.Position = UDim2.new(0, 6, 0, 0)
		
		TabItemTitle.Text = TabName
		TabItemTitle.FontSize = 16
		TabItemTitle.Font = "SourceSansPro-SemiBold"
		TabItemTitle.VerticalAlignment = "Center"
		TabItemTitle.Position = UDim2.new(0, 25, 0, 1)
		
		ItemContainer.BackgroundColor3 = Color3.fromRGB(255, 255,255)
		ItemContainer.Size = UDim2.new(0, 250, 0, 230)
		ItemContainer.VerticalAlignment = "Bottom"
		ItemContainer.BorderSizePixel = 0
		ItemContainer.BackgroundTransparency = 1
		ItemContainer.HorizontalAlignment = "Right"
		ItemContainer.Visible = Active
		
		ItemListLayout.Padding = UDim.new(3, 1)
		ItemListLayout.ChildrenHorizontalAlignment = "Center"
		
		TabItem.Parent = SideBarItemList
		TabItemIcon.Parent = TabItem
		TabItemTitle.Parent = TabItem
		ItemContainer.Parent = Frame
		ItemListLayout.Parent = ItemContainer
		
		TabItem.MouseButton1Click:Connect(function()
			local Self_GuiTab = GuiTabs_GetTableIndex(ItemContainer)
			if not Self_GuiTab.Active then
				Self_GuiTab.Active = true
				ItemContainer.Visible = true
                local TabSelectTween = TweenService:Create(TabItem, TweenInfo.new(0.5), {BackgroundTransparency = 0})
                TabSelectTween:Play()
				for i = 1, #GuiTabs do
					local GuiTab = GuiTabs[i]
					if GuiTab ~= Self_GuiTab and GuiTab.Active then
						GuiTab.Active = false
						GuiTab.ItemContainer.Visible = false
                        local TabUnselectTween = TweenService:Create(GuiTab.TabItem, TweenInfo.new(0.5), {BackgroundTransparency = 1})
						TabUnselectTween:Play()
					end
				end
			end
		end)
		
		function Tab:NewButton(ButtonProperties)
			local Text = ButtonProperties.Text or "Text"
			local CallbackFunction = ButtonProperties.CallbackFunction
			
			local ItemButton = Instance.new("TextButton")
			local Circle = Instance.new("Frame")
			local ItemButtonTitle = Instance.new("TextLabel")
			local OuterCircle = Instance.new("TextButton")
			local InnerCircle = Instance.new("Frame")
			
			local Toggled = false
			
			ItemButton.Size = UDim2.new(0, 225, 0, 24)
			ItemButton.BorderSizePixel = 0
			ItemButton.BackgroundColor3 = Color3.fromHex("#12121e")
			ItemButton.CornerRadius = Radius
			
			Circle.Size = UDim2.new(0, 7, 0, 7)
			Circle.Position = UDim2.new(0, 9, 0, 0)
			Circle.CornerRadius = CornerRadius.new(6, 6, 6, 6)
			Circle.BackgroundColor3 = Color3.fromHex("#d3d3d3")
			Circle.BorderSizePixel = 0
			Circle.VerticalAlignment = "Center"
			
			ItemButtonTitle.VerticalAlignment = "Center"
			ItemButtonTitle.Position = UDim2.new(0, 22, 0, 1)
			ItemButtonTitle.Text = Text
			ItemButtonTitle.FontSize = 16
			
			OuterCircle.Size = UDim2.new(0, 16, 0, 7)
			OuterCircle.Position = UDim2.new(0, -11, 0, 0)
			OuterCircle.CornerRadius = CornerRadius.new(6, 6, 6, 6)
			OuterCircle.BackgroundColor3 = Color3.fromHex("#e4e4e4")
			OuterCircle.BorderSizePixel = 0
			OuterCircle.VerticalAlignment = "Center"
			OuterCircle.HorizontalAlignment = "Right"
			
			InnerCircle.Size = UDim2.new(0, 10, 0, 10)
			InnerCircle.Position = UDim2.new(0, 0, 0, 0)
			InnerCircle.CornerRadius = CornerRadius.new(10, 10, 10, 10)
			InnerCircle.BackgroundColor3 = Color3.fromHex("#fefefe")
			InnerCircle.BorderSizePixel = 0
			InnerCircle.VerticalAlignment = "Center"
			
			ItemButton.MouseButton1Click:Connect(function()
				Toggled = not Toggled
				if Toggled then
					local UnToggleTween = TweenService:Create(InnerCircle, TweenInfo.new(0.01), {Position = UDim2.new(0, 0, 0, 0)})
					local UnToggleTweenColor = TweenService:Create(InnerCircle, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromHex("#fefefe")})
					UnToggleTween:Play()
					UnToggleTweenColor:Play()
				else
					local ToggleTween = TweenService:Create(InnerCircle, TweenInfo.new(0.01), {Position = UDim2.new(0, 7, 0, 0)})
					local UnToggleTweenColor = TweenService:Create(InnerCircle, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromHex("#5e1f9e")})
					ToggleTween:Play()
					UnToggleTweenColor:Play()
				end
				if CallbackFunction then
					CallbackFunction()
				end
			end)
			
			ItemButton.Parent = ItemContainer
			Circle.Parent = ItemButton
			ItemButtonTitle.Parent = ItemButton
		end
		
		function Tab:NewText(TextProperties)
			local Text = TextProperties.Text or "Text"
			local TextComponent = Instance.new("TextLabel")
			local TextContainer = Instance.new("Frame")

			TextContainer.Size = UDim2.new(0, 225, 0, 17)
			TextContainer.BackgroundTransparency = 1

			TextComponent.VerticalAlignment = "Center"
			TextComponent.TextColor3 = Color3.fromRGB(190, 190, 190)
			TextComponent.FontSize = 14
			TextComponent.HorizontalAlignment = "Left"
			TextComponent.Text = Text
			TextComponent.Font = GothamSSm_Medium

			TextComponent.Parent = TextContainer
			TextContainer.Parent = ItemContainer
		end

		function Tab:NewToggle(ToggleProperties)
			local Text = ToggleProperties.Text or "Text"
			local ItemDescription = ToggleProperties.ItemDescription or "Description"
			local CallbackFunction = ToggleProperties.CallbackFunction
			
			local ItemButton = Instance.new("TextButton")
			local Circle = Instance.new("Frame")
			local ItemButtonTitle = Instance.new("TextLabel")
			local OuterCircle = Instance.new("TextButton")
			local InnerCircle = Instance.new("Frame")
			local Description = Instance.new("TextLabel")
			local TextButton = Instance.new("TextButton")
			local KeyBindButton = Instance.new("TextButton")
			local UserInputService = game:GetService("UserInputService")
			local Toggled = false
			local listening = true
			local keybind
			
			ItemButton.Size = UDim2.new(0, 225, 0, 40)
			ItemButton.Font = Poppins_SemiBold
			ItemButton.BorderSizePixel = 0
			ItemButton.BackgroundColor3 = Color3.fromHex("#12121e")
			ItemButton.CornerRadius = CornerRadius.new(6, 6, 6, 6)

			KeyBindButton.Size = UDim2.new(0, 15, 0, 15)
			KeyBindButton.Position = UDim2.new(0, -35, 0, 0)
			KeyBindButton.HorizontalAlignment = "Right"
			KeyBindButton.VerticalAlignment = "Center"
			KeyBindButton.Radius = 10
			KeyBindButton.FontSize = 18.5
			KeyBindButton.PaddingTop = 1
			KeyBindButton.BorderSizePixel = 0
			KeyBindButton.BackgroundColor3 = Color3.fromHex("#2a2a48")
			KeyBindButton.MouseButton1Click:Connect(function()
			listening = true
			KeyBindButton.Text = "..."
			  local function onInputBegan(input, _gameProcessed)
			  	 if listening == true then 
			  	    keybind = input.KeyCode
			  	    KeyBindButton.Text = keybind
			  	    listening = false
			  	 end

				  if input.KeyCode == keybind then
                    if Toggled then
                        Toggled = false
						CallbackFunction()
                        local UnToggleTween = TweenService:Create(InnerCircle, TweenInfo.new(0.01), {Position = UDim2.new(0, 0, 0, 0)})
						local UnToggleTweenColor = TweenService:Create(InnerCircle, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromHex("#fefefe")})
						UnToggleTween:Play()
						UnToggleTweenColor:Play()
                    else
                        Toggled = true
						CallbackFunction()
                        local ToggleTween = TweenService:Create(InnerCircle, TweenInfo.new(0.01), {Position = UDim2.new(0, 7, 0, 0)})
						local UnToggleTweenColor = TweenService:Create(InnerCircle, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromHex("#5e1f9e")})
						ToggleTween:Play()
						UnToggleTweenColor:Play()
                    end
                 end
			  end
			 UserInputService.InputBegan:Connect(onInputBegan)
			end)

			Description.Parent = ItemButton
			Description.Text = ItemDescription
			Description.FontSize = 15
			Description.TextColor3 = Color3.fromHex("#83868b")
			Description.Position = UDim2.new(0, 9, 0, 24)
			
			Circle.Size = UDim2.new(0, 7, 0, 7)
			Circle.Position = UDim2.new(0, 9, 0, -5)
			Circle.CornerRadius = CornerRadius.new(6, 6, 6, 6)
			Circle.BackgroundColor3 = Color3.fromHex("#d3d3d3")
			Circle.BorderSizePixel = 0
			Circle.VerticalAlignment = "Center"
			
			ItemButtonTitle.VerticalAlignment = "Center"
			ItemButtonTitle.Position = UDim2.new(0, 22, 0, -4)
			ItemButtonTitle.Text = Text
			ItemButtonTitle.FontSize = 16
			
			OuterCircle.Size = UDim2.new(0, 16, 0, 7)
			OuterCircle.Position = UDim2.new(0, -11, 0, 0)
			OuterCircle.CornerRadius = CornerRadius.new(6,6, 6, 6)
			OuterCircle.BackgroundColor3 = Color3.fromRGB(224, 224, 224)
			OuterCircle.BorderSizePixel = 0
			OuterCircle.VerticalAlignment = "Center"
			OuterCircle.HorizontalAlignment = "Right"
			
			InnerCircle.Size = UDim2.new(0, 10, 0, 10)
			InnerCircle.Position = UDim2.new(0, 0, 0, 0)
			InnerCircle.CornerRadius = CornerRadius.new(10, 10, 10, 10)
			InnerCircle.BackgroundColor3 = Color3.fromHex("#fefefe")
			InnerCircle.BorderSizePixel = 0
			InnerCircle.VerticalAlignment = "Center"
			
			OuterCircle.MouseButton1Click:Connect(function()
				if Toggled then
					local UnToggleTween = TweenService:Create(InnerCircle, TweenInfo.new(0.01), {Position = UDim2.new(0, 0, 0, 0)})
					local UnToggleTweenColor = TweenService:Create(InnerCircle, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromHex("#fefefe")})
					UnToggleTween:Play()
					UnToggleTweenColor:Play()
				else
					local ToggleTween = TweenService:Create(InnerCircle, TweenInfo.new(0.01), {Position = UDim2.new(0, 7, 0, 0)})
					local UnToggleTweenColor = TweenService:Create(InnerCircle, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromHex("#5e1f9e")})
					ToggleTween:Play()
					UnToggleTweenColor:Play()
				end
				Toggled = not Toggled
				if CallbackFunction then
					CallbackFunction(Toggled)
				end
			end)
			
			KeyBindButton.Parent = ItemButton
			ItemButton.Parent = ItemContainer
			Circle.Parent = ItemButton
			ItemButtonTitle.Parent = ItemButton
			OuterCircle.Parent = ItemButton
			InnerCircle.Parent = OuterCircle
		end
		
		GuiTabs[#GuiTabs + 1] = {Active = Active, TabItem = TabItem, ItemContainer = ItemContainer}
		return Tab
	end
	
	return Gui
end

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
        if (distance < closestDistance) and (Entity.entityObject ~= PlayerEntity) then
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
	if VelocityToggle == true then
		DoVelocity()
    end
end)

function DoReach()
	LocalPlayer:Reach(6)
end

Script.MouseClick1:Connect(function(e)
	if ReachToggle == true then
		DoReach()
	end
end)



Script.Update:Connect(function()
    --killaura handler
	if Killaura == true then
		AttackClosest()
    end

	if Scaffold == true then 
		DoScaffold()
	end

	-- eagle handler
	if Eagle == true then
		DoEagle()
    end
end)