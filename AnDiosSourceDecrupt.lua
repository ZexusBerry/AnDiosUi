local AnDiosUi = {}

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Создание основного меню
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
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Parent = MainFrame
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 24

    local TabFrame = Instance.new("Frame")
    TabFrame.Parent = MainFrame
    TabFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabFrame.Size = UDim2.new(0, 150, 1, -50)
    TabFrame.Position = UDim2.new(0, 0, 0, 50)
    TabFrame.BorderSizePixel = 0

    local UICornerTabFrame = Instance.new("UICorner")
    UICornerTabFrame.CornerRadius = UDim.new(0, 10)
    UICornerTabFrame.Parent = TabFrame

    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabFrame
    TabList.SortOrder = Enum.SortOrder.LayoutOrder

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ContentFrame.Size = UDim2.new(1, -150, 1, -50)
    ContentFrame.Position = UDim2.new(0, 150, 0, 50)
    ContentFrame.BorderSizePixel = 0

    local UICornerContentFrame = Instance.new("UICorner")
    UICornerContentFrame.CornerRadius = UDim.new(0, 10)
    UICornerContentFrame.Parent = ContentFrame

    local ContentList = Instance.new("UIListLayout")
    ContentList.Parent = ContentFrame
    ContentList.SortOrder = Enum.SortOrder.LayoutOrder

    self.MainFrame = MainFrame
    self.TabFrame = TabFrame
    self.ContentFrame = ContentFrame
    self.TabButtons = {}

    self:MakeDraggable(Title)

    return self, MainFrame
end

-- Функция для создания анимации
local function Tween(object, properties, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Добавление вкладок
function AnDiosUi:AddTab(name)
    local TabButton = Instance.new("TextButton")
    TabButton.Parent = self.TabFrame
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabButton.Size = UDim2.new(1, 0, 0, 40)
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 18
    TabButton.BorderSizePixel = 0

    local UICornerTabButton = Instance.new("UICorner")
    UICornerTabButton.CornerRadius = UDim.new(0, 4)
    UICornerTabButton.Parent = TabButton

    local TabContent = Instance.new("Frame")
    TabContent.Parent = self.ContentFrame
    TabContent.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.Visible = false
    TabContent.BorderSizePixel = 0

    local ContentList = Instance.new("UIListLayout")
    ContentList.Parent = TabContent
    ContentList.SortOrder = Enum.SortOrder.LayoutOrder

    self.TabButtons[name] = {Button = TabButton, Content = TabContent}

    TabButton.MouseButton1Click:Connect(function()
        for _, tab in pairs(self.TabButtons) do
            tab.Content.Visible = false
            tab.Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end
        TabContent.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)

    return TabContent
end

-- Установка доступности вкладки
function AnDiosUi:SetTabEnabled(name, enabled)
    local tab = self.TabButtons[name]
    if tab then
        tab.Button.Visible = enabled
    end
end

-- Добавление метки
function AnDiosUi:AddLabel(tab, text)
    local Label = Instance.new("TextLabel")
    Label.Parent = tab
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 0, 30)
    Label.Font = Enum.Font.SourceSansBold
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 18
    Label.BorderSizePixel = 0

    return Label
end

-- Добавление кнопки
function AnDiosUi:AddButton(tab, text, callback)
    local Button = Instance.new("TextButton")
    Button.Parent = tab
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
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
    Dropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Dropdown.Size = UDim2.new(1, 0, 0, 30)
    Dropdown.BorderSizePixel = 0

    local DropdownButton = Instance.new("TextButton")
    DropdownButton.Parent = Dropdown
    DropdownButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
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
            OptionFrame.Visible = false
            if callback then
                callback(option)
            end
        end)
    end

    DropdownButton.MouseButton1Click:Connect(function()
        OptionFrame.Visible = not OptionFrame.Visible
    end)

    return Dropdown
end

-- Создание сообщений
function AnDiosUi:CreateMessage(imageId, text, description, duration)
    local ScreenGui = game.CoreGui:FindFirstChild("ScreenGui")
    if not ScreenGui then
        ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Parent = game.CoreGui
    end

    local MessageFrame = Instance.new("Frame")
    MessageFrame.Parent = ScreenGui
    MessageFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MessageFrame.Size = UDim2.new(0, 300, 0, 100)
    MessageFrame.Position = UDim2.new(1, -350, 1, -150)
    MessageFrame.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MessageFrame

    local Image = Instance.new("ImageLabel")
    Image.Parent = MessageFrame
    Image.BackgroundTransparency = 1
    Image.Size = UDim2.new(0, 80, 0, 80)
    Image.Position = UDim2.new(0, 10, 0, 10)
    Image.Image = imageId

    local Title = Instance.new("TextLabel")
    Title.Parent = MessageFrame
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, -100, 0, 40)
    Title.Position = UDim2.new(0, 100, 0, 10)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = text
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 24

    local Description = Instance.new("TextLabel")
    Description.Parent = MessageFrame
    Description.BackgroundTransparency = 1
    Description.Size = UDim2.new(1, -100, 0, 40)
    Description.Position = UDim2.new(0, 100, 0, 50)
    Description.Font = Enum.Font.SourceSans
    Description.Text = description
    Description.TextColor3 = Color3.fromRGB(255, 255, 255)
    Description.TextSize = 18

    -- Показ сообщения
    Tween(MessageFrame, {Position = UDim2.new(1, -350, 1, -150)}, 0.5)

    -- Удаление сообщения через duration секунд
    delay(duration, function()
        Tween(MessageFrame, {Position = UDim2.new(1, 0, 1, -150)}, 0.5).Completed:Connect(function()
            MessageFrame:Destroy()
        end)
    end)
end

-- Привязка к клавишам
function AnDiosUi:BindKey(key, callback)
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode[key] then
            callback()
        end
    end)
end

-- Делаем фрейм перетаскиваемым
function AnDiosUi:MakeDraggable(frame)
    local dragging
    local dragInput
    local dragStart
    local startPos

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
