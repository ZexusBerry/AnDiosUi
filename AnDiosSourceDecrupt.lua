local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local AnDiosUi = {}

-- Функция для создания окна
function AnDiosUi:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CustomUI"
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

    local Title = Instance.new("TextLabel")
    Title.Parent = MainFrame
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, -20, 0, 30)
    Title.Position = UDim2.new(0, 10, 0, 10)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local TabHolder = Instance.new("Frame")
    TabHolder.Parent = MainFrame
    TabHolder.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabHolder.Size = UDim2.new(1, -20, 0, 30)
    TabHolder.Position = UDim2.new(0, 10, 0, 50)
    TabHolder.BorderSizePixel = 0

    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabHolder
    TabList.FillDirection = Enum.FillDirection.Horizontal
    TabList.SortOrder = Enum.SortOrder.LayoutOrder

    local Tabs = Instance.new("Frame")
    Tabs.Parent = MainFrame
    Tabs.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Tabs.Size = UDim2.new(1, -20, 1, -90)
    Tabs.Position = UDim2.new(0, 10, 0, 90)
    Tabs.BorderSizePixel = 0

    local TabContentLayout = Instance.new("UIListLayout")
    TabContentLayout.Parent = Tabs
    TabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local function TweenIn(element, properties, duration)
        local tween = TweenService:Create(element, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), properties)
        tween:Play()
        return tween
    end

    local function TweenOut(element, properties, duration)
        local tween = TweenService:Create(element, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.In), properties)
        tween:Play()
        return tween
    end

    local function ArrangeElements(parent)
        for _, child in ipairs(parent:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextButton") or child:IsA("TextLabel") then
                child.Size = UDim2.new(1, -20, 0, 30)
            end
        end
    end

    -- Функция для закрытия меню с анимацией рассеивания
    local function CloseMenu()
        TweenOut(MainFrame, {BackgroundTransparency = 1}, 0.5).Completed:Connect(function()
            ScreenGui:Destroy()
        end)
    end

    -- Кнопка для закрытия меню
    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = MainFrame
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -40, 0, 10)
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 18
    CloseButton.BorderSizePixel = 0

    local UICornerCloseButton = Instance.new("UICorner")
    UICornerCloseButton.CornerRadius = UDim.new(0, 10)
    UICornerCloseButton.Parent = CloseButton

    CloseButton.MouseButton1Click:Connect(CloseMenu)

    return {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        Tabs = Tabs,
        TabHolder = TabHolder
    }
end

-- Функция для добавления вкладки
function AnDiosUi:AddTab(gui, title)
    local TabButton = Instance.new("TextButton")
    TabButton.Parent = gui.TabHolder
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabButton.Size = UDim2.new(0, 100, 1, 0)
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.Text = title
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 18
    TabButton.BorderSizePixel = 0

    local TabFrame = Instance.new("Frame")
    TabFrame.Parent = gui.Tabs
    TabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.Visible = false

    local function ShowTab()
        for _, tab in ipairs(gui.Tabs:GetChildren()) do
            if tab:IsA("Frame") then
                tab.Visible = false
            end
        end
        TabFrame.Visible = true
    end

    TabButton.MouseButton1Click:Connect(ShowTab)

    ShowTab()

    return TabFrame
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

    CheckBox.MouseButton1Click:Connect(function()
        Check.Visible = not Check.Visible
        if callback then
            callback(Check.Visible)
        end
    end)

    ArrangeElements(tab)

    return CheckBoxFrame
end

-- Функция для добавления разделительной строки
function AnDiosUi:AddDivider(tab)
    local Divider = Instance.new("Frame")
    Divider.Parent = tab
    Divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
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
