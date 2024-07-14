local AnDiosUi = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Функции для создания анимаций
local function TweenIn(object, properties, duration, easingStyle, easingDirection)
    easingStyle = easingStyle or Enum.EasingStyle.Quad
    easingDirection = easingDirection or Enum.EasingDirection.Out
    local tweenInfo = TweenInfo.new(duration, easingStyle, easingDirection)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

local function TweenOut(object, properties, duration, easingStyle, easingDirection)
    easingStyle = easingStyle or Enum.EasingStyle.Quad
    easingDirection = easingDirection or Enum.EasingDirection.In
    local tweenInfo = TweenInfo.new(duration, easingStyle, easingDirection)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Основная функция для создания меню
function AnDiosUi:CreateMenu(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AnDiosUi"
    ScreenGui.Parent = game.CoreGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.ClipsDescendants = true
    MainFrame.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = MainFrame

    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Parent = MainFrame
    Header.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Header.Size = UDim2.new(1, 0, 0, 50)
    Header.BorderSizePixel = 0

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = Header
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Font = Enum.Font.SourceSans
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 24

    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = Header
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    CloseButton.Size = UDim2.new(0, 50, 1, 0)
    CloseButton.Position = UDim2.new(1, -50, 0, 0)
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 24

    CloseButton.MouseButton1Click:Connect(function()
        TweenOut(MainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.5).Completed:Connect(function()
            ScreenGui:Destroy()
        end)
    end)

    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = Header
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 50)
    MinimizeButton.Size = UDim2.new(0, 50, 1, 0)
    MinimizeButton.Position = UDim2.new(1, -100, 0, 0)
    MinimizeButton.Font = Enum.Font.SourceSansBold
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = Color3.fromRGB(30, 30, 30)
    MinimizeButton.TextSize = 24

    local minimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        if minimized then
            TweenIn(MainFrame, {Size = UDim2.new(0, 600, 0, 400), Position = UDim2.new(0.5, -300, 0.5, -200)}, 0.5)
        else
            TweenOut(MainFrame, {Size = UDim2.new(0, 600, 0, 50), Position = UDim2.new(0.5, -300, 0.5, -25)}, 0.5)
        end
        minimized = not minimized
    end)

    self:MakeDraggable(Header)

    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabContainer.Size = UDim2.new(1, 0, 0, 30)
    TabContainer.Position = UDim2.new(0, 0, 0, 50)
    TabContainer.BorderSizePixel = 0
    TabContainer.CanvasSize = UDim2.new(0, 0, 0, 30)
    TabContainer.ScrollBarThickness = 5
    TabContainer.ScrollingDirection = Enum.ScrollingDirection.X

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = TabContainer
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local Tabs = {}

    function self:AddTab(name)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = name .. "Tab"
        TabButton.Parent = TabContainer
        TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TabButton.Size = UDim2.new(0, 100, 1, 0)
        TabButton.Font = Enum.Font.SourceSansBold
        TabButton.Text = name
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextSize = 20
        TabButton.BorderSizePixel = 0

        local TabFrame = Instance.new("ScrollingFrame")
        TabFrame.Name = name .. "Frame"
        TabFrame.Parent = MainFrame
        TabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        TabFrame.Size = UDim2.new(1, 0, 1, -80)
        TabFrame.Position = UDim2.new(0, 0, 0, 80)
        TabFrame.BorderSizePixel = 0
        TabFrame.Visible = false
        TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabFrame.ScrollBarThickness = 5

        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.Parent = TabFrame
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 10)

        table.insert(Tabs, {Button = TabButton, Frame = TabFrame})

        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Tabs) do
                tab.Frame.Visible = false
                tab.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            end
            TabFrame.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end)

        TabContainer.CanvasSize = UDim2.new(0, #Tabs * 100, 0, 30)

        return TabFrame
    end

    -- Анимация появления меню
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    TweenIn(MainFrame, {Size = UDim2.new(0, 600, 0, 400), Position = UDim2.new(0.5, -300, 0.5, -200)}, 0.5)

    return self, MainFrame
end

-- Функция для упорядочивания элементов
local function ArrangeElements(container)
    local canvasHeight = 0
    for _, element in ipairs(container:GetChildren()) do
        if element:IsA("GuiObject") then
            canvasHeight = canvasHeight + element.Size.Y.Offset + 10
        end
    end
    container.CanvasSize = UDim2.new(0, 0, 0, canvasHeight)
end

-- Добавление Label
function AnDiosUi:AddLabel(tab, text)
    local Label = Instance.new("TextLabel")
    Label.Parent = tab
    Label.BackgroundColor3 = Color3.fromRGB(30,40, 40)
    Label.Size = UDim2.new(1, -20, 0, 30)
    Label.Font = Enum.Font.SourceSans
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 18
    Label.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = Label

    ArrangeElements(tab)

    return Label
end

-- Добавление Button
function AnDiosUi:AddButton(tab, text, callback)
    local Button = Instance.new("TextButton")
    Button.Parent = tab
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.Size = UDim2.new(1, -20, 0, 30)
    Button.Font = Enum.Font.SourceSansBold
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 18
    Button.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        TweenOut(Button, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.2)
        wait(0.2)
        TweenIn(Button, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}, 0.2)
        if callback then
            callback()
        end
    end)

    ArrangeElements(tab)

    return Button
end

-- Добавление DropDown
function AnDiosUi:AddDropdown(tab, text, options, callback)
    local Dropdown = Instance.new("Frame")
    Dropdown.Parent = tab
    Dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Dropdown.Size = UDim2.new(1, -20, 0, 30)
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
            TweenOut(OptionFrame, {Size = UDim2.new(1, 0, 0, 0)}, 0.3).Completed:Connect(function()
                OptionFrame.Visible = false
            end)
            if callback then
                callback(option)
            end
        end)
    end

    DropdownButton.MouseButton1Click:Connect(function()
        if OptionFrame.Visible then
            TweenOut(OptionFrame, {Size = UDim2.new(1, 0, 0, 0)}, 0.3).Completed:Connect(function()
                OptionFrame.Visible = false
            end)
        else
            OptionFrame.Visible = true
            TweenIn(OptionFrame, {Size = UDim2.new(1, 0, 0, #options * 30)}, 0.3)
        end
    end)

    ArrangeElements(tab)

    return Dropdown
end

-- Добавление Divider
function AnDiosUi:AddDivider(tab)
    local Divider = Instance.new("Frame")
    Divider.Parent = tab
    Divider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Divider.Size = UDim2.new(1, -20, 0, 2)
    Divider.BorderSizePixel = 0

    ArrangeElements(tab)

    return Divider
end

-- Функция для создания сообщений
function AnDiosUi:CreateMessage(text, description, duration, image)
    local MessageFrame = Instance.new("Frame")
    MessageFrame.Parent = game.CoreGui
    MessageFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MessageFrame.Size = UDim2.new(0, 300, 0, 100)
    MessageFrame.Position = UDim2.new(1, 300, 1, -150)
    MessageFrame.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = MessageFrame

    local MessageTitle = Instance.new("TextLabel")
    MessageTitle.Parent = MessageFrame
    MessageTitle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MessageTitle.Size = UDim2.new(1, -60, 0, 30)
    MessageTitle.Font = Enum.Font.SourceSansBold
    MessageTitle.Text = text
    MessageTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    MessageTitle.TextSize = 20
    MessageTitle.Position = UDim2.new(0, 10, 0, 10)
    MessageTitle.BorderSizePixel = 0

    local MessageDescription = Instance.new("TextLabel")
    MessageDescription.Parent = MessageFrame
    MessageDescription.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MessageDescription.Size = UDim2.new(1, -20, 0, 50)
    MessageDescription.Font = Enum.Font.SourceSans
    MessageDescription.Text = description
    MessageDescription.TextColor3 = Color3.fromRGB(200, 200, 200)
    MessageDescription.TextSize = 16
    MessageDescription.Position = UDim2.new(0, 10, 0, 40)
    MessageDescription.BorderSizePixel = 0
    MessageDescription.TextWrapped = true

    if image then
        local MessageImage = Instance.new("ImageLabel")
        MessageImage.Parent = MessageFrame
        MessageImage.BackgroundTransparency = 1
        MessageImage.Size = UDim2.new(0, 40, 0, 40)
        MessageImage.Position = UDim2.new(1, -50, 0, 10)
        MessageImage.Image = image
    end

    TweenIn(MessageFrame, {Position = UDim2.new(1, -320, 1, -150)}, 0.5)

    delay(duration, function()
        TweenOut(MessageFrame, {Position = UDim2.new(1, 300, 1, -150)}, 0.5).Completed:Connect(function()
            MessageFrame:Destroy()
        end)
    end)
end

-- Функция для перемещения окна
function AnDiosUi:MakeDraggable(header)
    local dragging = false
    local dragInput, mousePos, framePos

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = header.Parent.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            header.Parent.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

return AnDiosUi
