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

    ItemItemContainer.BackgroundColor3 = Color3.fromRGB(255, 255,255)
    ItemItemContainer.Size = UDim2.new(0, 250, 0, SizeY - 15)
    ItemItemContainer.VerticalAlignment = "Bottom"
    ItemItemContainer.BorderSizePixel = 0
    ItemItemContainer.BackgroundTransparency = 1
    ItemItemContainer.HorizontalAlignment = "Right"

	Title.Text = TitleText
	Title.Font = GothamSSm
	Title.Position = UDim2.new(0, 12, 0, 16)
	
	Desc.Text = DescText
	Desc.Font = GothamSSm_Medium -- cant fucking use discord cdn because its blocked in iran
	Desc.Position = UDim2.new(0, 12, 0, 33)
	Desc.TextSize = 14	
	Desc.TextColor3 = Color3.fromRGB(225,225,225);
	
	ServerLocation.TextSize = 15
	ServerLocation.Position = UDim2.new(0, 12, 0, 31)
	
	SideBarParent.Size = UDim2.new(0, 120, 0, SizeY)
	SideBarParent.BackgroundTransparency = 1
	SideBarParent.ClipsDescendants = true
	
	SideBar.Size = UDim2.new(0, 125, 0, SizeY)
	SideBar.BackgroundColor3 = Color3.fromHex("#13121e")
	SideBar.BorderSizePixel = 0
	SideBar.CornerRadius = CornerRadius.new(5, 5, 5, 5)
	
	SideBarItemList.Size = UDim2.new(0, 125, 0, SizeY - 47)
	SideBarItemList.BackgroundTransparency = 1
	SideBarItemList.BorderSizePixel = 0
	SideBarItemList.VerticalAlignment = "bottom"
	
	UIListLayout.Padding = UDim.new(3, 1)
	UIListLayout.ChildrenHorizontalAlignment = "Center"
	
	UIListLayout.Parent = SideBarItemList
    ItemItemContainer.Parent = Frame
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
		local ItemContainer = Instance.new("ScrollingFrame")
		local ItemListLayout = Instance.new("UIListLayout")

		ItemContainer.ScrollBarThickness = 6
		
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
		TabItemTitle.TextSize = 16
		TabItemTitle.Font = "SourceSansPro-SemiBold"
		TabItemTitle.VerticalAlignment = "Center"
		TabItemTitle.Position = UDim2.new(0, 25, 0, 1)
		
		ItemContainer.BackgroundColor3 = Color3.fromRGB(255, 255,255)
		ItemContainer.Size = UDim2.new(0, 250, 0, SizeY - 30)
		ItemContainer.VerticalAlignment = "Bottom"
		ItemContainer.BorderSizePixel = 0
		ItemContainer.BackgroundTransparency = 1
		ItemContainer.HorizontalAlignment = "Center"
		ItemContainer.Visible = Active
		
		ItemListLayout.Padding = UDim.new(3, 1)
		ItemListLayout.ChildrenHorizontalAlignment = "Center"
		
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
			ItemButtonTitle.TextSize = 16
			
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
			TextComponent.TextSize = 14
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
			KeyBindButton.TextSize = 18.5
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
			Description.TextSize = 14
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
			ItemButtonTitle.TextSize = 16
			
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

		function Tab:NewTextBox(ToggleProperties)
			local Text = ToggleProperties.Text or "Text"
			local ItemDescription = ToggleProperties.ItemDescription or "Description"
			local ItemContent = ToggleProperties.ItemContent or "TextBox"
			local CallbackFunction = ToggleProperties.CallbackFunction
			
			local ItemButton = Instance.new("TextButton")
			local Circle = Instance.new("Frame")
			local ItemButtonTitle = Instance.new("TextLabel")
			local Description = Instance.new("TextLabel")
			local TextBox = Instance.new("TextBox")
			
			ItemButton.Size = UDim2.new(0, 225, 0, 40)
			ItemButton.Font = Poppins_SemiBold
			ItemButton.BorderSizePixel = 0
			ItemButton.BackgroundColor3 = Color3.fromHex("#12121e")
			ItemButton.CornerRadius = CornerRadius.new(6, 6, 6, 6)

			TextBox.Size = UDim2.new(0, 50, 0, 15)
			TextBox.Position = UDim2.new(0, -10, 0, 0)
			TextBox.HorizontalAlignment = "Right"
			TextBox.VerticalAlignment = "Center"
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

			Description.Parent = ItemButton
			Description.Text = ItemDescription
			Description.TextSize = 14
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
			ItemButtonTitle.TextSize = 16
			
			Circle.Parent = ItemButton
			TextBox.Parent = ItemButton
			ItemButton.Parent = ItemContainer
			ItemButtonTitle.Parent = ItemButton
		end

		GuiTabs[#GuiTabs + 1] = {Active = Active, TabItem = TabItem, ItemContainer = ItemContainer}
		return Tab
	end
	
	return Gui
end

return FluxLib