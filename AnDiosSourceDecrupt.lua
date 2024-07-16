local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local AnDiosUi = {}

-- Функция для создания твина
local function TweenIn(object, properties, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

local function TweenOut(object, properties, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Функция для организации элементов в табе
local function ArrangeElements(tab)
    local elements = tab:GetChildren()
    local yOffset = 10
    for _, element in ipairs(elements) do
        if element:IsA("Frame") or element:IsA("TextButton") or element:IsA("TextLabel") or element:IsA("TextBox") then
            element.Position = UDim2.new(0, 10, 0, yOffset)
            yOffset = yOffset + element.Size.Y.Offset + 10
        end
    end
    tab.Size = UDim2.new(1, 0, 0, yOffset)
end

-- Функция для создания UI
function AnDiosUi:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.CoreGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Size = UDim2.new(0, 500, 0, 500)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -250)
    MainFrame.ClipsDescendants = true
    MainFrame.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    local Header = Instance.new("Frame")
    Header.Parent = MainFrame
    Header.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Header.Size = UDim2.new(1, 0, 0, 50)
    Header.Position = UDim2.new(0, 0, 0, 0)
    Header.BorderSizePixel = 0

    local Title = Instance.new("TextLabel")
    Title.Parent = Header
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 24
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = Header
    CloseButton.BackgroundTransparency = 1
    CloseButton.Size = UDim2.new(0, 50, 1, 0)
    CloseButton.Position = UDim2.new(1, -50, 0, 0)
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 0, 0)
    CloseButton.TextSize = 24

    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Parent = Header
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Size = UDim2.new(0, 50, 1, 0)
    MinimizeButton.Position = UDim2.new(1, -100, 0, 0)
    MinimizeButton.Font = Enum.Font.SourceSansBold
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 0)
    MinimizeButton.TextSize = 24

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local isMinimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            TweenOut(MainFrame, {Size = UDim2.new(0, 500, 0, 50)}, 0.5)
        else
            TweenIn(MainFrame, {Size = UDim2.new(0, 500, 0, 500)}, 0.5)
        end
    end)

    local TabFrame = Instance.new("Frame")
    TabFrame.Parent = MainFrame
    TabFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabFrame.Size = UDim2.new(0, 150, 1, -50)
    TabFrame.Position = UDim2.new(0, 0, 0, 50)
    TabFrame.BorderSizePixel = 0

    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabFrame
    TabList.SortOrder = Enum.SortOrder.LayoutOrder

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ContentFrame.Size = UDim2.new(1, -150, 1, -50)
    ContentFrame.Position = UDim2.new(0, 150, 0, 50)
    ContentFrame.BorderSizePixel = 0

    local ContentList = Instance.new("UIListLayout")
    ContentList.Parent = ContentFrame
    ContentList.SortOrder = Enum.SortOrder.LayoutOrder
    ContentList.Padding = UDim.new(0, 10)

    return {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        Header = Header,
        TabFrame = TabFrame,
        ContentFrame = ContentFrame
    }
end

-- Функция для добавления вкладки
function AnDiosUi:AddTab(gui, name)
    local TabButton = Instance.new("TextButton")
    TabButton.Parent = gui.TabFrame
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabButton.Size = UDim2.new(1, 0, 0, 50)
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 18
    TabButton.BorderSizePixel = 0

    local TabContent = Instance.new("Frame")
    TabContent.Parent = gui.ContentFrame
    TabContent.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.Visible = false
    TabContent.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = TabButton

    TabButton.MouseButton1Click:Connect(function()
        for _, child in ipairs(gui.ContentFrame:GetChildren()) do
            if child:IsA("Frame") then
                child.Visible = false
            end
        end
        TabContent.Visible = true
    end)

    ArrangeElements(gui.TabFrame)

    return TabContent
end

-- Функция для добавления лейбла
function AnDiosUi:AddLabel(tab, text)
    local Label = Instance.new("TextLabel")
    Label.Parent = tab
    Label.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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

-- Функция для добавления кнопки
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
        if callback then
            callback()
        end
    end)

    ArrangeElements(tab)

    return Button
end

-- Функция для добавления чекбокса
function AnDiosUi:AddCheckBox(tab, text, callback)
    local CheckBoxFrame = Instance.new("Frame")
    CheckBoxFrame.Parent = tab
    CheckBoxFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    CheckBoxFrame.Size = UDim2.new(1, -20, 0, 30)
    CheckBoxFrame.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = CheckBoxFrame

    local CheckBox = Instance.new("TextButton")
    CheckBox.Parent = CheckBoxFrame
    CheckBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    CheckBox.Size = UDim2.new(0, 30, 0, 30)
    CheckBox.Font = Enum.Font.SourceSansBold
    CheckBox.Text = ""
    CheckBox.BorderSizePixel = 0

    local Check = Instance.new("TextLabel")
    Check.Parent = CheckBox
    Check.BackgroundTransparency = 1
    Check.Size = UDim2.new(1, 0, 1, 0)
    Check.Font = Enum.Font.SourceSansBold
    Check.Text = "✓"
    Check.TextColor3 = Color3.fromRGB(255, 255, 255)
    Check.TextSize = 18
    Check.Visible = false

    local Label = Instance.new("TextLabel")
    Label.Parent = CheckBoxFrame
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 40, 0, 0)
    Label.Size = UDim2.new(1, -40, 1, 0)
    Label.Font = Enum.Font.SourceSansBold
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 18
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local checked = false
    CheckBox.MouseButton1Click:Connect(function()
        checked = not checked
        Check.Visible = checked
        if callback then
            callback(checked)
        end
    end)

    ArrangeElements(tab)

    return CheckBox
end

-- Функция для добавления разделителя
function AnDiosUi:AddDivider(tab)
    local Divider = Instance.new("Frame")
    Divider.Parent = tab
    Divider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Divider.Size = UDim2.new(1, -20, 0, 2)
    Divider.BorderSizePixel = 0

    ArrangeElements(tab)

    return Divider
end

-- Функция для добавления выпадающего списка
function AnDiosUi:AddDropDown(tab, options, callback)
    local DropDownFrame = Instance.new("Frame")
    DropDownFrame.Parent = tab
    DropDownFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    DropDownFrame.Size = UDim2.new(1, -20, 0, 30)
    DropDownFrame.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = DropDownFrame

    local DropDownButton = Instance.new("TextButton")
    DropDownButton.Parent = DropDownFrame
    DropDownButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    DropDownButton.Size = UDim2.new(1, 0, 1, 0)
    DropDownButton.Font = Enum.Font.SourceSansBold
    DropDownButton.Text = "Select Option"
    DropDownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropDownButton.TextSize = 18
    DropDownButton.BorderSizePixel = 0

    local DropDownList = Instance.new("Frame")
    DropDownList.Parent = DropDownFrame
    DropDownList.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    DropDownList.Size = UDim2.new(1, 0, 0, 0)
    DropDownList.Position = UDim2.new(0, 0, 1, 0)
    DropDownList.BorderSizePixel = 0
    DropDownList.ClipsDescendants = true
    DropDownList.Visible = false

    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Parent = DropDownList
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local isOpen = false
    DropDownButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            DropDownList.Visible = true
            TweenIn(DropDownList, {Size = UDim2.new(1, 0, 0, #options * 30)}, 0.2)
        else
            TweenOut(DropDownList, {Size = UDim2.new(1, 0, 0, 0)}, 0.2).Completed:Connect(function()
                DropDownList.Visible = false
            end)
        end
    end)

    for _, option in ipairs(options) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Parent = DropDownList
        OptionButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        OptionButton.Size = UDim2.new(1, 0, 0, 30)
        OptionButton.Font = Enum.Font.SourceSansBold
        OptionButton.Text = option
        OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        OptionButton.TextSize = 18
        OptionButton.BorderSizePixel = 0

        OptionButton.MouseButton1Click:Connect(function()
            DropDownButton.Text = option
            isOpen = false
            TweenOut(DropDownList, {Size = UDim2.new(1, 0, 0, 0)}, 0.2).Completed:Connect(function()
                DropDownList.Visible = false
            end)
            if callback then
                callback(option)
            end
        end)
    end

    ArrangeElements(tab)

    return DropDownButton
end

-- Функция для добавления сообщения
function AnDiosUi:AddMessage(gui, title, text, duration)
    local MessageFrame = Instance.new("Frame")
    MessageFrame.Parent = gui.ScreenGui
    MessageFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MessageFrame.Size = UDim2.new(0, 300, 0, 100)
    MessageFrame.Position = UDim2.new(1, 300, 1, -110)
    MessageFrame.BorderSizePixel = 0
    MessageFrame.ClipsDescendants = true

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MessageFrame

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = MessageFrame
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Size = UDim2.new(1, -20, 0, 30)
    TitleLabel.Position = UDim2.new(0, 10, 0, 10)
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 18
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = MessageFrame
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(1, -20, 0, 50)
    TextLabel.Position = UDim2.new(0, 10, 0, 40)
    TextLabel.Font = Enum.Font.SourceSans
    TextLabel.Text = text
    TextLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    TextLabel.TextSize = 16
    TextLabel.TextWrapped = true
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextYAlignment = Enum.TextYAlignment.Top

    TweenIn(MessageFrame, {Position = UDim2.new(1, -310, 1, -110)}, 0.5)

    delay(duration or 3, function()
        TweenOut(MessageFrame, {Position = UDim2.new(1, 300, 1, -110)}, 0.5).Completed:Connect(function()
            MessageFrame:Destroy()
        end)
    end)

    return MessageFrame
end

return AnDiosUi
