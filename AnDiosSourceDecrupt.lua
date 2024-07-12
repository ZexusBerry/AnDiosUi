local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local AnDiosUi = {}

-- Создание окна
function AnDiosUi:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TopBar = Instance.new("Frame")
    local TitleLabel = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")

    ScreenGui.Name = "AnDiosUi"
    ScreenGui.Parent = game.CoreGui

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Size = UDim2.new(0, 500, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
    MainFrame.ClipsDescendants = true

    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TopBar.Size = UDim2.new(1, 0, 0, 30)

    TitleLabel.Name = "TitleLabel"
    TitleLabel.Parent = TopBar
    TitleLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TitleLabel.Size = UDim2.new(1, -40, 1, 0)
    TitleLabel.Position = UDim2.new(0, 10, 0, 0)
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.Text = title or "AnDiosUi"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 18
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TopBar
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 18

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    AnDiosUi:MakeDraggable(MainFrame)

    return {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        TopBar = TopBar,
        TitleLabel = TitleLabel,
        CloseButton = CloseButton,
        Tabs = {}
    }
end

-- Создание вкладки
function AnDiosUi:AddTab(window, tabName, imageId)
    local TabButton = Instance.new("TextButton")
    local TabContent = Instance.new("Frame")

    TabButton.Name = tabName or "Tab"
    TabButton.Parent = window.MainFrame
    TabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TabButton.Size = UDim2.new(0, 100, 0, 30)
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.Text = tabName or "Tab"
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 18

    TabContent.Name = "TabContent"
    TabContent.Parent = window.MainFrame
    TabContent.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabContent.Size = UDim2.new(1, 0, 1, -30)
    TabContent.Position = UDim2.new(0, 0, 0, 30)
    TabContent.Visible = false

    TabButton.MouseButton1Click:Connect(function()
        for _, tab in pairs(window.Tabs) do
            tab.Content.Visible = false
        end
        TabContent.Visible = true
    end)

    table.insert(window.Tabs, {Button = TabButton, Content = TabContent})

    return {
        Button = TabButton,
        Content = TabContent
    }
end

-- Переименование вкладки
function AnDiosUi:RenameTab(tab, newName)
    tab.Button.Text = newName or "Tab"
end

-- Установка изображения вкладки
function AnDiosUi:SetTabImage(tab, imageId)
    -- Можно добавить сюда код для установки изображения на кнопку вкладки
end

-- Упорядочивание элементов внутри вкладки
local function ArrangeElements(tabContent)
    local UIGridLayout = tabContent:FindFirstChildOfClass("UIGridLayout") or Instance.new("UIGridLayout")
    UIGridLayout.Parent = tabContent
    UIGridLayout.CellSize = UDim2.new(0, 150, 0, 40)
    UIGridLayout.FillDirectionMaxCells = 3
end

-- Добавление кнопки на вкладку
function AnDiosUi:AddButton(tab, buttonText, callback)
    local Button = Instance.new("TextButton")

    Button.Name = buttonText or "Button"
    Button.Parent = tab.Content
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Button.Size = UDim2.new(0, 150, 0, 40)
    Button.Font = Enum.Font.SourceSansBold
    Button.Text = buttonText or "Button"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 18
    Button.AutoButtonColor = true

    Button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)

    ArrangeElements(tab.Content)

    return Button
end

-- Добавление метки на вкладку
function AnDiosUi:AddLabel(tab, labelText)
    local Label = Instance.new("TextLabel")

    Label.Name = labelText or "Label"
    Label.Parent = tab.Content
    Label.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Label.Size = UDim2.new(0, 150, 0, 40)
    Label.Font = Enum.Font.SourceSansBold
    Label.Text = labelText or "Label"
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 18

    ArrangeElements(tab.Content)

    return Label
end

-- Добавление выпадающего списка на вкладку
function AnDiosUi:AddDropdown(tab, dropdownText, options, callback)
    local Dropdown = Instance.new("Frame")
    local DropdownButton = Instance.new("TextButton")
    local DropdownList = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local isExpanded = false

    Dropdown.Name = dropdownText or "Dropdown"
    Dropdown.Parent = tab.Content
    Dropdown.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Dropdown.Size = UDim2.new(0, 150, 0, 40)

    DropdownButton.Name = "DropdownButton"
    DropdownButton.Parent = Dropdown
    DropdownButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    DropdownButton.Size = UDim2.new(1, 0, 1, 0)
    DropdownButton.Font = Enum.Font.SourceSansBold
    DropdownButton.Text = dropdownText or "Dropdown"
    DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownButton.TextSize = 18

    DropdownList.Name = "DropdownList"
    DropdownList.Parent = Dropdown
    DropdownList.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    DropdownList.Position = UDim2.new(0, 0, 1, 0)
    DropdownList.Size = UDim2.new(1, 0, 0, #options * 30)
    DropdownList.ClipsDescendants = true
    DropdownList.Visible = false

    UIListLayout.Parent = DropdownList
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    for _, option in pairs(options) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Name = option
        OptionButton.Parent = DropdownList
        OptionButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        OptionButton.Size = UDim2.new(1, 0, 0, 30)
        OptionButton.Font = Enum.Font.SourceSansBold
        OptionButton.Text = option
        OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        OptionButton.TextSize = 18

        OptionButton.MouseButton1Click:Connect(function()
            DropdownButton.Text = option
            TweenOut(DropdownList, {Size = UDim2.new(1, 0, 0, 0)}, 0.5).Completed:Connect(function()
                DropdownList.Visible = false
            end)
            isExpanded = false
            if callback then
                callback(option)
            end
        end)
    end

    DropdownButton.MouseButton1Click:Connect(function()
        if isExpanded then
            TweenOut(DropdownList, {Size = UDim2.new(1, 0, 0, 0)}, 0.5).Completed:Connect(function()
                DropdownList.Visible = false
            end)
        else
            DropdownList.Visible = true
            TweenIn(DropdownList, {Size = UDim2.new(1, 0, 0, #options * 30)}, 0.5)
        end
        isExpanded = not isExpanded
    end)

    ArrangeElements(tab.Content)

    return Dropdown
end

-- Перетаскивание окна
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
