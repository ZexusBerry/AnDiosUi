local TweenService = game:GetService("TweenService")

local AnDiosUi = {}

-- Функция для создания окна
function AnDiosUi:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.CoreGui
    ScreenGui.Name = "AnDiosUi"

    local MainFrame = Instance.new("Frame")
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
    TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.BorderSizePixel = 0

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = TitleBar
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Size = UDim2.new(1, -60, 1, 0)
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 20
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Position = UDim2.new(0, 10, 0, 0)

    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = TitleBar
    CloseButton.BackgroundTransparency = 1
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -40, 0, 0)
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 0, 0)
    CloseButton.TextSize = 20

    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Parent = TitleBar
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(1, -70, 0, 0)
    MinimizeButton.Font = Enum.Font.SourceSansBold
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.TextSize = 20

    CloseButton.MouseButton1Click:Connect(function()
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1})
        tween:Play()
        tween.Completed:Connect(function()
            ScreenGui:Destroy()
        end)
    end)

    MinimizeButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    local TabHolder = Instance.new("Frame")
    TabHolder.Parent = MainFrame
    TabHolder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabHolder.Size = UDim2.new(0, 150, 1, -30)
    TabHolder.Position = UDim2.new(0, 0, 0, 30)
    TabHolder.BorderSizePixel = 0

    local TabContainer = Instance.new("Frame")
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabContainer.Size = UDim2.new(1, -150, 1, -30)
    TabContainer.Position = UDim2.new(0, 150, 0, 30)
    TabContainer.BorderSizePixel = 0

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Parent = TabHolder
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    ScreenGui.DisplayOrder = 1000 -- Ensure it's on top of other GUIs

    return {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        TabHolder = TabHolder,
        TabContainer = TabContainer,
    }
end

-- Функция для добавления вкладки
function AnDiosUi:AddTab(gui, tabName)
    local TabButton = Instance.new("TextButton")
    TabButton.Parent = gui.TabHolder
    TabButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabButton.Size = UDim2.new(1, 0, 0, 30)
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.Text = tabName
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 18
    TabButton.BorderSizePixel = 0

    local TabFrame = Instance.new("Frame")
    TabFrame.Parent = gui.TabContainer
    TabFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.Visible = false
    TabFrame.BorderSizePixel = 0

    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Parent = TabFrame
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Padding = UDim.new(0, 5)

    TabButton.MouseButton1Click:Connect(function()
        for _, v in pairs(gui.TabContainer:GetChildren()) do
            if v:IsA("Frame") then
                v.Visible = false
            end
        end
        TabFrame.Visible = true
    end)

    return TabFrame
end

-- Функция для добавления элемента в виде строки
local function ArrangeElements(tab)
    local listLayout = tab:FindFirstChildOfClass("UIListLayout")
    if listLayout then
        local padding = 5
        local yOffset = 0
        for _, element in ipairs(tab:GetChildren()) do
            if element:IsA("Frame") or element:IsA("TextLabel") or element:IsA("TextButton") then
                element.Position = UDim2.new(0, 10, 0, yOffset)
                yOffset = yOffset + element.Size.Y.Offset + padding
            end
        end
    end
end

-- Функция для добавления надписи
function AnDiosUi:AddLabel(tab, text)
    local Label = Instance.new("TextLabel")
    Label.Parent = tab
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, -20, 0, 30)
    Label.Font = Enum.Font.SourceSansBold
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 18
    Label.TextXAlignment = Enum.TextXAlignment.Left

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
    CheckBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30```lua
    CheckBox.Size = UDim2.new(0, 20, 0, 20)
    CheckBox.Position = UDim2.new(0, 5, 0.5, -10)
    CheckBox.Font = Enum.Font.SourceSans
    CheckBox.Text = ""
    CheckBox.TextSize = 14
    CheckBox.BorderSizePixel = 0

    local CheckMark = Instance.new("TextLabel")
    CheckMark.Parent = CheckBox
    CheckMark.BackgroundTransparency = 1
    CheckMark.Size = UDim2.new(1, 0, 1, 0)
    CheckMark.Font = Enum.Font.SourceSansBold
    CheckMark.Text = "✓"
    CheckMark.TextColor3 = Color3.fromRGB(255, 255, 255)
    CheckMark.TextSize = 18
    CheckMark.Visible = false

    local CheckBoxLabel = Instance.new("TextLabel")
    CheckBoxLabel.Parent = CheckBoxFrame
    CheckBoxLabel.BackgroundTransparency = 1
    CheckBoxLabel.Size = UDim2.new(1, -30, 1, 0)
    CheckBoxLabel.Position = UDim2.new(0, 30, 0, 0)
    CheckBoxLabel.Font = Enum.Font.SourceSansBold
    CheckBoxLabel.Text = text
    CheckBoxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    CheckBoxLabel.TextSize = 18
    CheckBoxLabel.TextXAlignment = Enum.TextXAlignment.Left

    CheckBox.MouseButton1Click:Connect(function()
        CheckMark.Visible = not CheckMark.Visible
        if callback then
            callback(CheckMark.Visible)
        end
    end)

    ArrangeElements(tab)

    return CheckBox
end

-- Функция для добавления разделительной строки
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

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = DropDownFrame

    local DropDownButton = Instance.new("TextButton")
    DropDownButton.Parent = DropDownFrame
    DropDownButton.BackgroundTransparency = 1
    DropDownButton.Size = UDim2.new(1, 0, 1, 0)
    DropDownButton.Font = Enum.Font.SourceSansBold
    DropDownButton.Text = "Select an option"
    DropDownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropDownButton.TextSize = 18
    DropDownButton.TextXAlignment = Enum.TextXAlignment.Left

    local DropDownArrow = Instance.new("TextLabel")
    DropDownArrow.Parent = DropDownButton
    DropDownArrow.BackgroundTransparency = 1
    DropDownArrow.Size = UDim2.new(0, 20, 1, 0)
    DropDownArrow.Position = UDim2.new(1, -20, 0, 0)
    DropDownArrow.Font = Enum.Font.SourceSansBold
    DropDownArrow.Text = "▼"
    DropDownArrow.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropDownArrow.TextSize = 18

    local OptionFrame = Instance.new("Frame")
    OptionFrame.Parent = DropDownFrame
    OptionFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    OptionFrame.Size = UDim2.new(1, 0, 0, #options * 30)
    OptionFrame.Position = UDim2.new(0, 0, 1, 0)
    OptionFrame.Visible = false
    OptionFrame.BorderSizePixel = 0

    local OptionListLayout = Instance.new("UIListLayout")
    OptionListLayout.Parent = OptionFrame
    OptionListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    DropDownButton.MouseButton1Click:Connect(function()
        OptionFrame.Visible = not OptionFrame.Visible
    end)

    for _, option in pairs(options) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Parent = OptionFrame
        OptionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        OptionButton.Size = UDim2.new(1, 0, 0, 30)
        OptionButton.Font = Enum.Font.SourceSansBold
        OptionButton.Text = option
        OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        OptionButton.TextSize = 18
        OptionButton.BorderSizePixel = 0

        OptionButton.MouseButton1Click:Connect(function()
            DropDownButton.Text = option
            OptionFrame.Visible = false
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
    MessageFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MessageFrame.Size = UDim2.new(0, 300, 0, 100)
    MessageFrame.Position = UDim2.new(1, -320, 1, -120)
    MessageFrame.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MessageFrame

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = MessageFrame
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Size = UDim2.new(1, -20, 0, 40)
    TitleLabel.Position = UDim2.new(0, 10, 0, 10)
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 20
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = MessageFrame
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(1, -20, 0, 50)
    TextLabel.Position = UDim2.new(0, 10, 0, 50)
    TextLabel.Font = Enum.Font.SourceSans
    TextLabel.Text = text
    TextLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    TextLabel.TextSize = 18
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextYAlignment = Enum.TextYAlignment.Top

    local tweenShow = TweenService:Create(MessageFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(1, -320, 1, -120)})
    tweenShow:Play()

    wait(duration)

    local tweenHide = TweenService:Create(MessageFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(1, 0, 1, -120)})
    tweenHide:Play()
    tweenHide.Completed:Connect(function()
        MessageFrame:Destroy()
    end)
end
