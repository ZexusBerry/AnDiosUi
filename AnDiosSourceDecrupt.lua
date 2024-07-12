local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local AnDiosUi = {}

-- Создание меню
function AnDiosUi:CreateMenu(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.CoreGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Size = UDim2.new(0, 500, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
    MainFrame.ClipsDescendants = true

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Parent = MainFrame
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 24

    local TabContainer = Instance.new("Frame")
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 0, 0, 30)
    TabContainer.Size = UDim2.new(1, 0, 1, -30)
    
    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabContainer
    TabList.FillDirection = Enum.FillDirection.Horizontal
    TabList.SortOrder = Enum.SortOrder.LayoutOrder

    AnDiosUi.ScreenGui = ScreenGui
    AnDiosUi.MainFrame = MainFrame
    AnDiosUi.TabContainer = TabContainer
    AnDiosUi.TabList = TabList

    self:MakeDraggable(Title)

    return AnDiosUi, MainFrame
end

-- Добавление вкладки
function AnDiosUi:AddTab(name)
    local TabButton = Instance.new("TextButton")
    TabButton.Parent = self.TabContainer
    TabButton.BackgroundTransparency = 1
    TabButton.Size = UDim2.new(0, 100, 1, 0)
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 18

    local TabFrame = Instance.new("Frame")
    TabFrame.Name = name
    TabFrame.Parent = self.MainFrame
    TabFrame.BackgroundTransparency = 1
    TabFrame.Size = UDim2.new(1, 0, 1, -30)
    TabFrame.Position = UDim2.new(0, 0, 0, 30)
    TabFrame.Visible = false

    TabButton.MouseButton1Click:Connect(function()
        for _, tab in ipairs(self.MainFrame:GetChildren()) do
            if tab:IsA("Frame") and tab.Name ~= "MainFrame" then
                tab.Visible = false
            end
        end
        TabFrame.Visible = true
    end)

    return TabFrame
end

-- Анимация появления
local function TweenIn(object, properties, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Анимация исчезновения
local function TweenOut(object, properties, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Добавление кнопки
function AnDiosUi:AddButton(tab, text, callback)
    local Button = Instance.new("TextButton")
    Button.Parent = tab
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.Size = UDim2.new(1, 0, 0, 30)
    Button.Font = Enum.Font.SourceSansBold
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 18
    Button.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        TweenIn(Button, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, 0.1).Completed:Connect(function()
            TweenOut(Button, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}, 0.1)
        end)
        if callback then
            callback()
        end
    end)

    return Button
end

-- Добавление Dropdown
function AnDiosUi:AddDropdown(tab, text, options, callback)
    local Dropdown = Instance.new("Frame")
    Dropdown.Parent = tab
    Dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Dropdown.Size = UDim2.new(1, 0, 0, 30)
    Dropdown.BorderSizePixel = 0

    local DropdownButton = Instance.new("TextButton")
    DropdownButton.Parent = Dropdown
    DropdownButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    DropdownButton.Size = UDim2.new(1, 0, 1, 0)
    DropdownButton.Font = Enum.Font.SourceSansBold
    DropdownButton.Text = text
    DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownButton.TextSize = 18
    DropdownButton.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = DropdownButton

    local OptionFrame = Instance.new("Frame")
    OptionFrame.Parent = Dropdown
    OptionFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    OptionFrame.Size = UDim2.new(1, 0, 0, #options * 30)
    OptionFrame.Position = UDim2.new(0, 0, 1, 0)
    OptionFrame.Visible = false
    OptionFrame.BorderSizePixel = 0

    local OptionList = Instance.new("UIListLayout")
    OptionList.Parent = OptionFrame
    OptionList.SortOrder = Enum.SortOrder.LayoutOrder

    for _, option in ipairs(options) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Parent = OptionFrame
        OptionButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        OptionButton.Size = UDim2.new(1, 0, 0, 30)
        OptionButton.Font = Enum.Font.SourceSansBold
        OptionButton.Text = option
        OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        OptionButton.TextSize = 18
        OptionButton.BorderSizePixel = 0

        OptionButton.MouseButton1Click:Connect(function()
            DropdownButton.Text = option
            TweenOut(OptionFrame, {Size = UDim2.new(1, 0, 0, 0)}, 0.3).Completed:Connect(function()
                OptionFrame.Visible = false
            end)
            if callback then
                callback(option)
            end
        end)
    end

    DropdownButton.MouseButton1Click:Connect(function()
        OptionFrame.Visible = true
        TweenIn(OptionFrame, {Size = UDim2.new(1, 0, 0, #options * 30)}, 0.3)
    end)

    return Dropdown
end

-- Создание сообщения
function AnDiosUi:CreateMessage(icon, text, description, duration)
    local MessageFrame = Instance.new("Frame")
    MessageFrame.Parent = game.CoreGui
    MessageFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MessageFrame.Size = UDim2.new(0, 300, 0, 80)
    MessageFrame.Position = UDim2.new(1, -350, 1, -100)
    MessageFrame.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = MessageFrame

    local Icon = Instance.new("ImageLabel")
    Icon.Parent = MessageFrame
    Icon.BackgroundTransparency = 1
    Icon.Size = UDim2.new(0, 50, 0, 50)
    Icon.Position = UDim2.new(0, 10, 0, 15)
    Icon.Image = icon

    local MessageText = Instance.new("TextLabel")
    MessageText.Parent = MessageFrame
    MessageText.BackgroundTransparency = 1
    MessageText.Size = UDim2.new(1, -70, 0, 50)
    MessageText.Position = UDim2.new(0, 70, 0, 15)
    MessageText.Font = Enum.Font.SourceSansBold
    MessageText.Text = text
    MessageText.TextColor3 = Color3.fromRGB(255, 255, 255)
    MessageText.TextSize = 18
    MessageText.TextXAlignment = Enum.TextXAlignment.Left

    local DescriptionText = Instance.new("TextLabel")
    DescriptionText.Parent = MessageFrame
    DescriptionText.BackgroundTransparency = 1
    DescriptionText.Size = UDim2.new(1, -70, 0, 20)
    DescriptionText.Position = UDim2.new(0, 70, 0, 40)
    DescriptionText.Font = Enum.Font.SourceSans
    DescriptionText.Text = description
    DescriptionText.TextColor3 = Color3.fromRGB(200, 200, 200)
    DescriptionText.TextSize = 14
    DescriptionText.TextXAlignment = Enum.TextXAlignment.Left

    TweenIn(MessageFrame, {Position = UDim2.new(1, -350, 1, -150)}, 0.5)

    delay(duration, function()
        TweenOut(MessageFrame, {Position = UDim2.new(1, -350, 1, -100)}, 0.5).Completed:Connect(function()
            MessageFrame:Destroy()
        end)
    end)
end

-- Привязка скриптов к клавишам
function AnDiosUi:BindKey(key, callback)
    UserInputService.InputBegan:Connect(function(input, isProcessed)
        if not isProcessed and input.KeyCode == key then
            callback()
        end
    end)
end

-- Делаем меню перетаскиваемым
function AnDiosUi:MakeDraggable(frame)
    local dragging, dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

return AnDiosUi
