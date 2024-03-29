local FluxLib = {}
local ts = game:GetService("TweenService")
local animation = Instance.new("BindableEvent")
local create = function(a, b)
    local b = b or {}
    local c = Instance.new(a)
    for i, v in pairs(b) do
        c[i] = v
    end
    return c
end


function FluxLib:NewGui(GuiProperties)
	-- Fonts (loading them from discord and guilded cdn because im 2 lazy)
	local GothamSSm = "https://forum.elysium.wtf/uploads/default/original/2X/b/b59cc03a78884ea608624fecbf919ed032c8fd3d.ttf"
	local GothamSSm_Medium = "https://forum.elysium.wtf/uploads/default/original/2X/1/1112beb22b9344db1ff5f72791e6772e9f4b0b84.ttf"
	local Poppins_SemiBold = "https://forum.elysium.wtf/uploads/default/original/2X/1/11cab7bae700c3ab30edf4ba5367d6dc808b1787.ttf"
	local Outfit_Bold = "https://forum.elysium.wtf/uploads/default/original/2X/4/4d7991b68c5b84c852824697b6ced99c691a0c18.ttf"
	local Outfit_SemiBold = "https://forum.elysium.wtf/uploads/default/original/2X/1/11cab7bae700c3ab30edf4ba5367d6dc808b1787.ttf"
	local Outfit_Black = "https://forum.elysium.wtf/uploads/default/original/2X/d/db01f8b70a55a08418f146114a7a9f503a8608e4.ttf"
	local Outfit_Medium = "https://forum.elysium.wtf/uploads/default/original/2X/1/1112beb22b9344db1ff5f72791e6772e9f4b0b84.ttf"
	local Outfit = "https://forum.elysium.wtf/uploads/default/original/2X/b/b59cc03a78884ea608624fecbf919ed032c8fd3d.ttf"

	local Gui = {}
	local GuiTabs = {}

	local function baseElement(ItemContainer, text, description)
		local ItemHolder = create("Frame",{
			Size = UDim2.new(0,215,0,41),
			BackgroundTransparency = 1,
			BorderSizePixel = 1,
			ClipsDescendants = true
		})
		local ItemButton =
			create(
			"TextButton",
			{
				Parent = ItemHolder,
				Size = UDim2.new(0, 215, 0, 40),
				Font = Outfit_SemiBold,
				BorderSizePixel = 0,
				BackgroundColor3 = Color3.fromHex("#12121e"),
				CornerRadius = CornerRadius.new(6, 6, 6, 6),
			}
		)
		local Circle =
			create(
			"Frame",
			{
				Size = UDim2.new(0, 7, 0, 7),
				Position = UDim2.new(0, 9, 0.5, -7),
				CornerRadius = CornerRadius.new(6, 6, 6, 6),
				BackgroundColor3 = Color3.fromHex("#ddddf0"),
				BorderSizePixel = 0
			}
		)

		local ItemButtonTitle =
			create(
			"TextLabel",
			{
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, 22, 0.5, -5),
				Text = text,
				TextColor3 = Color3.fromHex("#ddddf0"),
				Font = Outfit_Medium,
				TextSize = 16
			}
		)



		local Description = create("TextLabel",{
			Parent = ItemButton,
			Text = description,
			Font = Outfit,
			TextSize = 16,
			TextColor3 = Color3.fromHex("#27273b"),
			Position = UDim2.new(0, 9, 0, 24),
		})


		Circle.Parent = ItemButton
		ItemButtonTitle.Parent = ItemButton
		ItemHolder.Parent = ItemContainer
		return ItemButton, Circle, ItemButtonTitle,ItemHolder
	end
	local function GuiTabs_GetTableIndex(ItemContainer)
		for i = 1, #GuiTabs do
			local GuiTab = GuiTabs[i]
			if GuiTab.ItemContainer == ItemContainer then
				return GuiTab
			end
		end
	end
	
	local SizeX = GuiProperties.SizeX or 370
	local SizeY = 290
	local TitleText = GuiProperties.Title and string.upper(GuiProperties.Title) or "GUI"
	local DescText = GuiProperties.Desc or "Preview"
	local Player = game:GetService("Players").LocalPlayer
	local Mouse = Player:GetMouse()
	local ScreenGui = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
    local ItemItemContainer = Instance.new("Frame")
	local SideBarParent = Instance.new("Frame")
	local SideBar = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
    local Version = Instance.new("TextLabel")
	local Desc = Instance.new("TextLabel")
	local ServerLocation = Instance.new("TextLabel")
	local SideBarItemList = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local TweenService = game:GetService("TweenService")
	local Radius = CornerRadius.new(5, 5, 5, 5)



	game:GetService("UserInputService").InputBegan:Connect(function(a,b)
		if a.KeyCode == Enum.KeyCode.RightShift then
			ScreenGui:Open()
			for i,v in pairs(ScreenGui:GetDescendants()) do
				if v.Transparency ~= nil then
					v.Transparency = 1
					ts:Create(v,TweenInfo.new(0.5),{Transparency = 0}):Play()
				end
			end
		end
	end)

	Frame.Size = UDim2.new(0, SizeX, 0, SizeY)
	Frame.CornerRadius = CornerRadius.new(5, 5, 5, 5)
	Frame.BorderSizePixel = 0
	Frame.BackgroundColor3 = Color3.fromHex("#0e0e1a")
	Frame.Draggable = true
	Frame.AnchorPoint = Vector2.new(0.5,0.5)
	Frame.Position = UDim2.new(0.5,0,0.5,0)
	Frame.ClipsDescendants = true

	ItemItemContainer.Position = UDim2.new(1,-125,0,15)
    ItemItemContainer.BackgroundColor3 = Color3.fromRGB(255, 255,255)
    ItemItemContainer.Size = UDim2.new(0, 250, 0, SizeY - 15)
    ItemItemContainer.BorderSizePixel = 0
    ItemItemContainer.BackgroundTransparency = 1
	ItemItemContainer.AnchorPoint = Vector2.new(0,0)

	Title.Text = TitleText
	Title.Font = Outfit_Bold
	Title.Position = UDim2.new(0, 12, 0, 14)

    Version.Text = "0.0.1"
    Version.TextSize = 15
    Version.TextColor3 = Color3.fromHex("#5e1f9e")
    Version.Position = UDim2.new(0, 70, 0, 10)
    Version.Font = Outfit_Bold
	
	Desc.Text = DescText
	Desc.Font = Outfit_Medium -- cant fucking use discord cdn because its blocked in iran
	Desc.Position = UDim2.new(0, 12, 0, 33)
	Desc.TextSize = 15	
	Desc.TextColor3 = Color3.fromRGB(225,225,225);
	
	ServerLocation.TextSize = 15
	ServerLocation.Position = UDim2.new(0, 12, 0, 31)
	
	SideBarParent.Size = UDim2.new(0, 120, 0, SizeY)
	SideBarParent.BackgroundTransparency = 1
	SideBarParent.BackgroundColor3 = Color3.fromRGB(0,0,0)
	SideBarParent.ClipsDescendants = true
	
	SideBar.Size = UDim2.new(0, 125, 0, SizeY)
	SideBar.BackgroundColor3 = Color3.fromHex("#13121e")
	SideBar.BorderSizePixel = 0
	SideBar.CornerRadius = CornerRadius.new(5, 5, 5, 5)
	
	SideBarItemList.Size = UDim2.new(0, 125, 0, SizeY - 47)
	SideBarItemList.BackgroundTransparency = 1
	SideBarItemList.BorderSizePixel = 0
	SideBarItemList.Position = UDim2.new(0,0,0,47)
	--SideBarItemList.AnchorPoint = Vector2.new(0,1)

	UIListLayout.Padding = UDim.new(0, 5)
	UIListLayout.HorizontalAlignment = "Center"
	
	UIListLayout.Parent = SideBarItemList
    ItemItemContainer.Parent = Frame
	SideBarItemList.Parent = SideBar
	ServerLocation.Parent = SideBar
    Version.Parent = SideBar
	Title.Parent = SideBar
	Desc.Parent = SideBar
	SideBar.Parent = SideBarParent
	SideBarParent.Parent = Frame
	Frame.Parent = ScreenGui
	ScreenGui.Enabled = true
	
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
		local ItemContainer = Instance.new("ScrollingFrame")
		local ItemListLayout = Instance.new("UIListLayout")

		ItemContainer.AutomaticCanvasSize = "Y"
		ItemContainer.ScrollBarThickness = 6
        ItemContainer.ScrollBarImageTransparency = 1
		
		TabItem.Size = UDim2.new(0, 125, 0, 24)
		TabItem.BorderSizePixel = 0
		TabItem.BackgroundColor3 = AccentColor
		TabItem.BackgroundTransparency = Active and 0 or 1
		
		TabItemIcon.Size = UDim2.new(0, 16, 0, 16)
		--TabItemIcon.AnchorPoint = Vector2.new(0,0)
		TabItemIcon.Image = TabItemImage
		TabItemIcon.BackgroundTransparency = 1
		TabItemIcon.Position = UDim2.new(0, 6, 0, 3)
		
		TabItemTitle.Text = TabName
		TabItemTitle.TextSize = 16
		TabItemTitle.Font = Outfit_SemiBold
		--TabItemTitle.AnchorPoint = Vector2.new(0,0)
		TabItemTitle.Position = UDim2.new(0, 25, 0.5, -2)
		
		ItemContainer.BackgroundColor3 = Color3.fromRGB(255,255,255)
		ItemContainer.Size = UDim2.new(0, 240, 0, SizeY - 15)
		ItemContainer.BorderSizePixel = 0
		ItemContainer.BackgroundTransparency = 1
		ItemContainer.Position = UDim2.new(1,-122.5,0,0)
		ItemContainer.Visible = Active
		ItemContainer.AutomaticCanvasSize = "Y"
		
		ItemListLayout.Padding = UDim.new(0, 5)
		ItemListLayout.HorizontalAlignment = "Center"
		
		TabItem.Parent = SideBarItemList
		TabItemIcon.Parent = TabItem
		TabItemTitle.Parent = TabItem
		ItemContainer.Parent = ItemItemContainer
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
			
			local ItemButton, Circle, ItemButtonTitle = baseElement(ItemContainer, Text, ItemDescription)

			local OuterCircle = Instance.new("TextButton")
			local InnerCircle = Instance.new("Frame")
			
			local Toggled = false
			

			
			OuterCircle.Size = UDim2.new(0, 16, 0, 7)
			OuterCircle.Position = UDim2.new(0, -11, 0, 0)
			OuterCircle.CornerRadius = CornerRadius.new(6, 6, 6, 6)
			OuterCircle.BackgroundColor3 = Color3.fromHex("#e4e4e4")
			OuterCircle.BorderSizePixel = 0

			OuterCircle.AnchorPoint = Vector2.new(1,0.5)

			InnerCircle.Size = UDim2.new(0, 10, 0, 10)
			InnerCircle.Position = UDim2.new(0, 0, 0, 0)
			InnerCircle.CornerRadius = CornerRadius.new(10, 10, 10, 10)
			InnerCircle.BackgroundColor3 = Color3.fromHex("#fefefe")
			InnerCircle.BorderSizePixel = 0
			InnerCircle.AnchorPoint = Vector2.new(0,0.5)
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
					CallbackFunction(Toggled)
				end
			end)
		end
		
		function Tab:NewText(TextProperties)
			local Text = TextProperties.Text or "Text"
			local TextComponent = Instance.new("TextLabel")
			local TextContainer = Instance.new("Frame")

			TextContainer.Size = UDim2.new(0, 215, 0, 17)
			TextContainer.BackgroundTransparency = 1

			--TextComponent.AnchorPoint = Vector2.new(0,0.5)
			TextComponent.Position = UDim2.new(0,0,0.5,-3.5)
			TextComponent.TextColor3 = Color3.fromRGB(190, 190, 190)
			TextComponent.TextSize = 14
			TextComponent.Text = Text
			TextComponent.Font = Outfit_Medium

			TextComponent.Parent = TextContainer
			TextContainer.Parent = ItemContainer
		end

		function Tab:NewToggle(ToggleProperties)
			local Text = ToggleProperties.Text or "Text"
			local ItemDescription = ToggleProperties.ItemDescription or "Description"
			local CallbackFunction = ToggleProperties.CallbackFunction
			local OptionsMenu = ToggleProperties.OptionsMenu
		
			
			
			local ItemButton, Circle, ItemButtonTitle, ItemHolder = baseElement(ItemContainer, Text, ItemDescription)
			local OuterCircle = create("TextButton",{
				Size = UDim2.new(0, 16, 0, 7),
				Position = UDim2.new(1, -15, 0.5, -3),
				CornerRadius = CornerRadius.new(6, 6, 6, 6),
				BackgroundColor3 = Color3.fromRGB(224, 224, 224),
				BorderSizePixel = 0,
			})

			local InnerCircle = create("Frame",{
				Size = UDim2.new(0, 10, 0, 10),
				Position = UDim2.new(0, 0, 0, -2),
				CornerRadius = CornerRadius.new(10, 10, 10, 10),
				BackgroundColor3 = Color3.fromHex("#fefefe"),
				BorderSizePixel = 0,
			})
			OuterCircle.Parent = ItemButton
			InnerCircle.Parent = OuterCircle
			
			local UserInputService = game:GetService("UserInputService")
			local TweenService = game:GetService"TweenService"
			local Toggled = false
			local UnToggleTween = TweenService:Create(InnerCircle, TweenInfo.new(0.01), {Position = UDim2.new(0, 0, 0, -2)})
			local UnToggleTweenColor = TweenService:Create(InnerCircle, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromHex("#fefefe")})
			local ToggleTween = TweenService:Create(InnerCircle, TweenInfo.new(0.01), {Position = UDim2.new(0, 7, 0, -2)})
			local ToggleTweenColor = TweenService:Create(InnerCircle, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromHex("#5e1f9e")})
			local function Toggle()
				Toggled = not Toggled
				if Toggled then
					ToggleTween:Play()
					ToggleTweenColor:Play()
				else
					UnToggleTween:Play()
					UnToggleTweenColor:Play()
				end
				if CallbackFunction then
					CallbackFunction(Toggled)
				end
			end
			OuterCircle.MouseButton1Click:Connect(Toggle)
			--if OptionsMenu then
			
			
			
			local OFFSET = 0
			local ELEMENT_COLOR = Color3.fromRGB(16,16,28)
			local holder = create("Frame",{
				Parent = ItemHolder,
				Position = UDim2.new(0,OFFSET,0, 45),
				Size = UDim2.new(1,-OFFSET/2,1,0),
				BackgroundTransparency = 1
			})
			local uilistlayout = create("UIListLayout",{
				Parent = holder,
				Padding = UDim.new(0,5)
			})


			local DOTS_SIZE = 2
			local DOTS_OFFSET = 4
			local DOTS_START = 40 / 2 - 1 - DOTS_OFFSET


			local thickness = 11
			local buttonHolder = create("Frame",{
				Parent = ItemButton,
				Position = UDim2.new(1,-thickness/2,0,0),
				Size = UDim2.new(0,thickness,1,0),
				CornerRadius = CornerRadius.new(0,0,6,6),
				BackgroundColor3 = Color3.fromRGB(22,22,34),
				BorderSizePixel = 0
			})
			local dots = {}
			for i=1,3 do
				dots[i] = create("Frame",{
					Parent = buttonHolder,
					Size = UDim2.new(0,DOTS_SIZE, 0, DOTS_SIZE),
					Position = UDim2.new(0.5, -0.5, 0, DOTS_START + DOTS_OFFSET * (i-1)),
					BackgroundColor3 = Color3.fromRGB(45,45,75),
					BorderSizePixel = 0,

				})
			end

			local button = create("TextButton",{
				Parent = buttonHolder,
				Size = UDim2.new(1,0,1,0),
				BackgroundTransparency = 1
			})

			local OptionsToggled = false
			local function ToggleOptions()
				OptionsToggled = not OptionsToggled
				if OptionsToggled then
					TweenService:Create(buttonHolder, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromHex("#5e1f9e")}):Play()
					for i,v in pairs(dots) do
						TweenService:Create(v, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(195,168,222)}):Play()
					end
					TweenService:Create(ItemHolder, TweenInfo.new(0.5), {Size = UDim2.new(0, 215, 0, 50 + math.max(20,uilistlayout.AbsoluteContentSize.Y))}):Play()
				else
					TweenService:Create(buttonHolder, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(22,22,34)}):Play()
					for i,v in pairs(dots) do
						TweenService:Create(v, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(45,45,75)}):Play()
					end
					TweenService:Create(ItemHolder, TweenInfo.new(0.5), {Size = UDim2.new(0, 215, 0, 41)}):Play()
				end
			end
			button.MouseButton1Click:Connect(ToggleOptions)

			local Menu = {}
			function Menu._baseElement(title)
				local base = create("Frame",{
					Parent = holder,
					Size = UDim2.new(1,0,0,20),
					Radius = 5,
					BackgroundColor3 = ELEMENT_COLOR,
					BorderSizePixel = 0
				})
				local name = create("TextLabel",{
					Parent = base,
					Text = title,
					Position = UDim2.new(0,5,0.5,-2),
					TextSize = 16,
					Font = Outfit_Medium
				})
				return base
			end
			function Menu:Keybind(options)
				local UserInputService = game:GetService("UserInputService")
				local name = options.Name or "Keybind"
				local callback = options.Callback or Toggle

				local listening = false
				local keybind


				local base = self._baseElement(name)

				local button = create("TextButton",{
					Parent = base,
					Position = UDim2.new(1,-2,0.5,-3.6),
					AnchorPoint = Vector2.new(1,0),
					Size = UDim2.new(0,11,0,11),
					Radius = 5,
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(42,42,72),
					TextColor3 = Color3.fromRGB(255,255,255),
					TextSize = 18.5,
					PaddingTop = 1
				})
				local function set(keycode)
					keybind = keycode
					listening = false
					button.Text = keycode and keycode.Name or ""
				end

				button.MouseButton1Click:Connect(function()
					keybind = nil
					listening = true
					button.Text = "..."
				end)
				local function onInputBegan(inputObject, _gameProcessed)
					if _gameProcessed then return end
					if not inputObject.KeyCode then return end
					if inputObject.KeyCode.Name == "Unknown" then return end
					if listening then
						if inputObject.KeyCode == Enum.KeyCode.Escape or inputObject.KeyCode == Enum.KeyCode.Backspace then
							set(nil)
							return
						end	
					
						set(inputObject.KeyCode)
						--button.Size = UDim2.new(0,5+(12 * #button.Text),0,11)
					elseif inputObject.KeyCode == keybind then
						callback()
					end
				end
				UserInputService.InputBegan:Connect(onInputBegan)
				
				return self
			end
			function Menu:Slider(options)
				local UserInputService = game:GetService("UserInputService")
				local mouse = game:GetService("Players").LocalPlayer:GetMouse()

				local name = options.Name or "Slider"
				local callback = options.Callback or function() end

				local min = options.Min or 0
				local max = options.Max or 100
				local current = options.Default or options.Current or min
				local prefix = options.Prefix or ""

				local base = self._baseElement(name)

				local line = create("Frame",{
					Parent = base,
					Position = UDim2.new(1,-2,0.5,-0.5),
					AnchorPoint = Vector2.new(1,0),
					Size = UDim2.new(0,60,0,2),
					BorderSizePixel = 0,
					BorderColor3 = Color3.fromRGB(),
					BackgroundColor3 = Color3.fromRGB(42,42,72)
				})
				local button = create("TextButton",{
					Parent = line,
					Size = UDim2.new(1,0,0,7),
					AnchorPoint = Vector2.new(0,0.5),
					Position = UDim2.new(0,0,0.5,0),
					BackgroundTransparency = 1,
					BorderSizePixel = 0
				})
				local current_filled = create("Frame",{
					Parent = line,
					Position = UDim2.new(0,0,0.5,0),
					Size = UDim2.new(0.5,0,1,0),
					AnchorPoint = Vector2.new(0,0.5),
					BackgroundColor3 = Color3.fromRGB(72,72,102),
					BorderSizePixel = 0
				})
				local current_frame = create("Frame",{
					Parent = line,
					Position = UDim2.new(0.5,0,0.5,0),
					AnchorPoint = Vector2.new(0,0.5),
					Size = UDim2.new(0,7,0,7),						
					BorderSizePixel = 0,
					BorderColor3 = Color3.fromRGB(),
					BackgroundColor3 = Color3.fromRGB(72,72,102),
					Radius = 14,
					Draggable = true
				})
				local current_value = create("TextLabel",{
					BackgroundTransparency = 1,
					Parent = base,
					Position = UDim2.new(1,-35,0.5,-1),
					TextXAlignment = Enum.TextXAlignment.Right,
					TextSize = 16,
					Font = Outfit_Medium,
					Text = current,
				})

				local sliding = false
				local function valueFromRange(val)
					local value = (max-min) * val + min
					return value
				end
				local function rangeFromValue(value)
					return (value - min) / (max - min)
				end
				local function set(value)
					current = value
					current_value.Text = string.format("%.2f%s", current,prefix)

					current_frame.Position = UDim2.new(rangeFromValue(value),-1.75,0.5,0)
					current_filled.Size = UDim2.new(rangeFromValue(value),0,1,0)
					if callback then callback(value) end
				end
				set(current)
				local function update()
					local absolutePosition = line.AbsolutePosition.X
					local absoluteSize = line.AbsoluteSize.X
					local sliderX = (mouse.X / 2 - absolutePosition)
					local range = math.min(1,math.max(sliderX/absoluteSize, 0))
					set(valueFromRange(range), range)
				end
				button.MouseButton1Down:Connect(function()
					sliding = true
					Frame.Draggable = false
					update()
					UserInputService.InputChanged:Connect(function(inputObject, _gameProcessed)
						if sliding and inputObject.UserInputType == Enum.UserInputType.MouseMovement then
							update()
						end
					end)
					UserInputService.InputEnded:Connect(function(inputObject, _gameProcessed)
						if sliding and inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
							sliding = false
							Frame.Draggable = true
							update()
						end
					end)
				end)
				return self
			end
			function Menu:SliderRange(options)
				local UserInputService = game:GetService("UserInputService")
				local mouse = game:GetService("Players").LocalPlayer:GetMouse()

				local name = options.Name or "Slider"
				local callback = options.Callback or function() end

				local min = options.Min or 0
				local max = options.Max or 100
				local currentSliderMin = options.DefaultMin or min
				local currentSliderMax = options.DefaultMax or min
				local prefix = options.Prefix or ""

				local base = self._baseElement(name)
				
				
				local line = create("Frame",{
					Parent = base,
					Position = UDim2.new(1,-5,0.5,0),
					AnchorPoint = Vector2.new(1,0),
					Size = UDim2.new(0,60,0,2),
					BorderSizePixel = 0,
					BorderColor3 = Color3.fromRGB(),
					BackgroundColor3 = Color3.fromRGB(42,42,72)
				})
				local current_filled = create("Frame",{
					Parent = line,
					Position = UDim2.new(0,0,0.5,0),
					Size = UDim2.new(0.5,0,1,0),
					AnchorPoint = Vector2.new(0,0.5),
					BackgroundColor3 = Color3.fromRGB(72,72,102),
					BorderSizePixel = 0
				})
				local current_min = create("ImageButton",{
					Parent = line,
					Position = UDim2.new(0,0,0,1),
					AnchorPoint = Vector2.new(0,0.5),
					Size = UDim2.new(0,7,0,7),						
					BorderSizePixel = 0,
					BorderColor3 = Color3.fromRGB(),
					ImageColor3 = Color3.fromRGB(72,72,102),
					BackgroundTransparency = 1,
					Draggable = true,
					Image = "https://forum.elysium.wtf/uploads/default/original/2X/0/0fae326c4563d0498b864dc0ec03185e6e588ff6.png"
				})
				local current_max = create("ImageButton",{
					Parent = line,
					Position = UDim2.new(1,0,0,1),
					AnchorPoint = Vector2.new(0,0.5),
					Size = UDim2.new(0,7,0,7),						
					BorderSizePixel = 0,
					BorderColor3 = Color3.fromRGB(),
					ImageColor3 = Color3.fromRGB(72,72,102),
					BackgroundTransparency = 1,
					Draggable = true,
					Image = "https://forum.elysium.wtf/uploads/default/original/2X/0/0fae326c4563d0498b864dc0ec03185e6e588ff6.png",
					Rotation = 180,
				})
				local current_value = create("TextLabel",{
					BackgroundTransparency = 1,
					Parent = base,
					Position = UDim2.new(1,-40,0.5,-1),
					TextXAlignment = Enum.TextXAlignment.Right,
					TextSize = 16,
					Font = Outfit_Medium,
					Text = "",
				})
				local slidingMin = false
				local slidingMax = false
				local function valueFromRange(val)
					local value = (max-min) * val + min
					return value
				end
				local function rangeFromValue(value)
					return (value - min) / (max - min)
				end
				local function set(min,max)
					currentSliderMin = min
					currentSliderMax = max
					local scaledMin = rangeFromValue(min)
					local scaledMax = rangeFromValue(max)
					current_filled.Position = UDim2.new(scaledMin,0, 0.5,0)
					current_filled.Size = UDim2.new(scaledMax - scaledMin,0, 1,0)
					
					current_max.Position = UDim2.new(scaledMax,0,0,1)
					current_min.Position = UDim2.new(scaledMin,-3.5,0,1)
					
					current_value.Text = string.format("%d - %d", min, max)
					if callback then callback(min, max) end
				end
				set(currentSliderMin, currentSliderMax)
				local function update()
					local absolutePosition = line.AbsolutePosition.X
					local absoluteSize = line.AbsoluteSize.X
					local sliderX = (mouse.X / 2 - absolutePosition)
					local range = math.min(1,math.max(sliderX/absoluteSize, 0))
				
					local min = currentSliderMin
					local max = currentSliderMax
					if slidingMin then
						min = valueFromRange(range)
					elseif slidingMax then
						max = valueFromRange(range)
					end
					if min > max then
						if slidingMin then
							min = max
						else
							max = min
						end
					end
					
					set(min,max)
				end
				local function start()
					Frame.Draggable = false
					update()
					UserInputService.InputChanged:Connect(function(inputObject, _gameProcessed)
						if (slidingMin or slidingMax) and inputObject.UserInputType == Enum.UserInputType.MouseMovement then
							update()
						end
					end)
					UserInputService.InputEnded:Connect(function(inputObject, _gameProcessed)
						if (slidingMin or slidingMax)  and inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
							slidingMin = false
							slidingMax = false
							Frame.Draggable = true
							update()
						end
					end)
				end
				current_min.MouseButton1Down:Connect(function()
					slidingMin = true
					start()
				end)				
				current_max.MouseButton1Down:Connect(function()
					slidingMax = true
					start()
				end)
			end	
			function Menu:TextBox(options)
				local name = options.Name or "Textbox"
				local callback = options.Callback or function() end

				local text = options.Text or ""
				local editable = options.Editable
				local placeholder = options.Placeholder or ""

				local base = self._baseElement(name)
				
				local box = create("TextBox",{
					Parent = base,
					Position = UDim2.new(1,-2,0.5,0),
					AnchorPoint = Vector2.new(1,0.5),
					Size = UDim2.new(0,80,0,10),
					TextEditable = editable,
					Text = text,
					PlaceholderText = placeholder,
					Radius = 3,
					TextSize = 16,
					PaddingTop = 1,
					--TextWrapped = true,
					--ClearTextOnFocus = false,
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromHex("#2a2a48"),
					TextColor3 = Color3.fromHex("#ffffff"),
				})
				box.TextChanged:Connect(callback)
				return self
			end
			
			Menu:Keybind({
				Name = "Keybind"
			})
			return Menu
			--end
		end

		function Tab:NewTextBox(ToggleProperties)
			local Text = ToggleProperties.Text or "Text"
			local ItemDescription = ToggleProperties.ItemDescription or "Description"
			local ItemContent = ToggleProperties.ItemContent or "TextBox"
			local CallbackFunction = ToggleProperties.CallbackFunction
			
			local ItemButton, Circle, ItemButtonTitle = baseElement(ItemContainer, Text, ItemDescription)
			local TextBox = Instance.new("TextBox")

			TextBox.Size = UDim2.new(0, 50, 0, 15)
			TextBox.Position = UDim2.new(1, -25, 0.5, -7)
			TextBox.Radius = 10
			TextBox.TextSize = 16
			TextBox.PaddingTop = 1
			TextBox.TextWrapped = true
			TextBox.TextEditable = true
			TextBox.ClearTextOnFocus = false
			TextBox.BorderSizePixel = 0
			TextBox.BackgroundColor3 = Color3.fromHex("#2a2a48")
			TextBox.TextColor3 = Color3.fromHex("#ffffff")
			TextBox.TextChanged:Connect(function()
				CallbackFunction()
			end)
			TextBox.Text = ToggleProperties.ItemContent

			
			TextBox.Parent = ItemButton
		end

		GuiTabs[#GuiTabs + 1] = {Active = Active, TabItem = TabItem, ItemContainer = ItemContainer}
		return Tab
	end
	
	return Gui
end
return FluxLib