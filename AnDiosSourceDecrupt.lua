local TweenService = game:GetService("TweenService")

local AnDiosUi = {}

-- Функция для создания окна
function AnDiosUi:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.CoreGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Size = UDim2.new(0, 500, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
    MainFrame.ClipsDescendants = true
    MainFrame.Active = true
    MainFrame.Draggable = true

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    local TitleBar = Instance.new("Frame")
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.Position = UDim2.new(0, 0, 0, 0)

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = TitleBar
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Size = UDim2.new(1, -30, 1, 0)
    TitleLabel.Position = UDim2.new(0, 10, 0, 0)
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 18
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = TitleBar
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    CloseButton.Size = UDim2.new(0, 30, 1, 0)
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 18
    CloseButton.BorderSizePixel = 0

    local TabsFrame = Instance.new("Frame")
    TabsFrame.Parent = MainFrame
    TabsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabsFrame.Size = UDim2.new(0, 120, 1, -30)
    TabsFrame.Position = UDim2.new(0, 0, 0, 30)
    TabsFrame.ClipsDescendants = true

    local TabsLayout = Instance.new("UIListLayout")
    TabsLayout.Parent = TabsFrame
    TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder

    CloseButton.MouseButton1Click:Connect(function()
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(MainFrame, tweenInfo, {Transparency = 1})
        tween:Play()
        tween.Completed:Connect(function()
            ScreenGui:Destroy()
        end)
    end)

    return {ScreenGui = ScreenGui, MainFrame = MainFrame, TabsFrame = TabsFrame}
end

-- Функция для добавления вкладки
function AnDiosUi:AddTab(gui, title)
    local TabButton = Instance.new("TextButton")
    TabButton.Parent = gui.TabsFrame
    TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabButton.Size = UDim2.new(1, 0, 0, 30)
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.Text = title
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 18
    TabButton.BorderSizePixel = 0

    local TabFrame = Instance.new("Frame")
    TabFrame.Parent = gui.MainFrame
    TabFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabFrame.Size = UDim2.new(1, -120, 1, -30)
    TabFrame.Position = UDim2.new(0, 120, 0, 30)
    TabFrame.Visible = false

    local Layout = Instance.new("UIListLayout")
    Layout.Parent = TabFrame
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 10)

    TabButton.MouseButton1Click:Connect(function()
        for _, frame in pairs(gui.MainFrame:GetChildren()) do
            if frame:IsA("Frame") and frame ~= gui.TabsFrame then
                frame.Visible = false
            end
        end
        TabFrame.Visible = true
    end)

    return TabFrame
end

-- Функция для упорядочивания элементов
local function ArrangeElements(tab)
    local contentHeight = 0
    for _, element in pairs(tab:GetChildren()) do
        if element:IsA("GuiObject") then
            contentHeight = contentHeight + element.Size.Y.Offset + 10
        end
    end
    tab.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
end

-- Функция для анимации появления
local function TweenIn(object, properties, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
end

-- Функция для анимации исчезновения
local function TweenOut(object, properties, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
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

    return CheckBoxFrame
end

-- Функция для добавления разделителя
function AnDiosUi:AddDivider(tab)
    local Divider = Instance.new("Frame")
    Divider.Parent = tab
    Divider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
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
    DropDownFrame.ClipsDescendants = true

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = DropDownFrame

    local DropDownButton = Instance.new("TextButton")
    DropDownButton.Parent = DropDownFrame
    DropDownButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    DropDownButton.Size = UDim2.new(1, 0, 1, 0)
    DropDownButton.Font = Enum.Font.SourceSansBold
    DropDownButton.Text = "Select an option"
    DropDownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropDownButton.TextSize = 18
    DropDownButton.BorderSizePixel = 0

    local OptionsFrame = Instance.new("Frame")
    OptionsFrame.Parent = DropDownFrame
    OptionsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    OptionsFrame.Size = UDim2.new(1, 0, 0, #options * 30)
    OptionsFrame.Position = UDim2.new(0, 0, 1, 0)
    OptionsFrame.Visible = false

    local OptionsLayout = Instance.new("UIListLayout")
    OptionsLayout.Parent = OptionsFrame
    OptionsLayout.SortOrder = Enum.SortOrder.LayoutOrder

    for _, option in ipairs(options) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Parent = OptionsFrame
        OptionButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        OptionButton.Size = UDim2.new(1, 0, 0, 30)
        OptionButton.Font = Enum.Font.SourceSansBold
        OptionButton.Text = option
        OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        OptionButton.TextSize = 18
        OptionButton.BorderSizePixel = 0

        OptionButton.MouseButton1Click:Connect(function()
            DropDownButton.Text = option
            OptionsFrame.Visible = false
            if callback then
                callback(option)
            end
        end)
    end

    DropDownButton.MouseButton1Click:Connect(function()
        OptionsFrame.Visible = not OptionsFrame.Visible
    end)

    ArrangeElements(tab)

    return DropDownFrame
end

-- Функция для добавления сообщения
function AnDiosUi:AddMessage(gui, title, text, duration)
    local MessageFrame = Instance.new("Frame")
    MessageFrame.Parent = gui.ScreenGui
    MessageFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MessageFrame.Size = UDim2.new(0, 300, 0, 100)
    MessageFrame.Position = UDim2.new(1, -310, 1, -110)
    MessageFrame.AnchorPoint = Vector2.new(1, 1)
    MessageFrame.ClipsDescendants = true

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
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
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextSize = 18
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextYAlignment = Enum.TextYAlignment.Top

    TweenIn(MessageFrame, {Position = UDim2.new(1, -310, 1, -110)}, 0.5)

    wait(duration)

    local tween = TweenOut(MessageFrame, {Position = UDim2.new(1, 10, 1, -110)}, 0.5)
    tween.Completed:Connect(function()
        MessageFrame:Destroy()
    end)

    return MessageFrame
end
