-- AnDiosUi Library

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local AnDiosUi = {}

-- Функция для анимации появления элемента
local function TweenIn(element, properties, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(element, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Функция для анимации исчезновения элемента
local function TweenOut(element, properties, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local tween = TweenService:Create(element, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Создание основного окна
function AnDiosUi:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local TabsContainer = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local ContentFrame = Instance.new("Frame")
    local CloseButton = Instance.new("TextButton")
    local MinimizeButton = Instance.new("TextButton")

    ScreenGui.Name = "AnDiosUi"
    ScreenGui.Parent = game.CoreGui

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
    MainFrame.Size = UDim2.new(0, 500, 0, 400)
    MainFrame.ClipsDescendants = true

    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(0, 500, 0, 50)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = title or "AnDiosUi"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 24

    TabsContainer.Name = "TabsContainer"
    TabsContainer.Parent = MainFrame
    TabsContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabsContainer.Position = UDim2.new(0, 0, 0.125, 0)
    TabsContainer.Size = UDim2.new(0, 500, 0, 50)

    UIListLayout.Parent = TabsContainer
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    ContentFrame.Name = "ContentFrame"
    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ContentFrame.Position = UDim2.new(0, 0, 0.25, 0)
    ContentFrame.Size = UDim2.new(0, 500, 0, 300)
    ContentFrame.ClipsDescendants = true

    CloseButton.Name = "CloseButton"
    CloseButton.Parent = MainFrame
    CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -40, 0, 10)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.MouseButton1Click:Connect(function()
        TweenOut(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.5).Completed:Connect(function()
            ScreenGui:Destroy()
        end)
    end)

    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = MainFrame
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(200, 200, 0)
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(1, -80, 0, 10)
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.MouseButton1Click:Connect(function()
        if MainFrame.Size == UDim2.new(0, 500, 0, 400) then
            TweenOut(MainFrame, {Size = UDim2.new(0, 500, 0, 50)}, 0.5)
        else
            TweenIn(MainFrame, {Size = UDim2.new(0, 500, 0, 400)}, 0.5)
        end
    end)

    return {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        Title = Title,
        TabsContainer = TabsContainer,
        ContentFrame = ContentFrame,
        Tabs = {},
    }
end

-- Добавление вкладки
function AnDiosUi:AddTab(window, tabName, imageId)
    local TabButton = Instance.new("TextButton")
    local Image = Instance.new("ImageLabel")

    TabButton.Name = tabName or "Tab"
    TabButton.Parent = window.TabsContainer
    TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabButton.Size = UDim2.new(0, 100, 0, 30)
    TabButton.Font = Enum.Font.SourceSans
    TabButton.Text = tabName or "Tab"
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 20

    Image.Name = "Image"
    Image.Parent = TabButton
    Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Image.BackgroundTransparency = 1
    Image.Size = UDim2.new(0, 20, 0, 20)
    Image.Position = UDim2.new(0, 5, 0, 5)
    Image.Image = "rbxassetid://" .. (imageId or "")

    local TabContent = Instance.new("Frame")
    TabContent.Name = tabName or "TabContent"
    TabContent.Parent = window.ContentFrame
    TabContent.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.Visible = false

    TabButton.MouseButton1Click:Connect(function()
        for _, tab in pairs(window.Tabs) do
            tab.Content.Visible = false
            tab.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
        TabContent.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)

    table.insert(window.Tabs, {Button = TabButton, Content = TabContent})

    return {
        Button = TabButton,
        Content = TabContent
    }
end

-- Переименование вкладки
function AnDiosUi:RenameTab(tab, newName)
    if tab and newName then
        tab.Button.Text = newName
        tab.Button.Name = newName
        tab.Content.Name = newName .. "Content"
    end
end

-- Изменение изображения вкладки
function AnDiosUi:SetTabImage(tab, imageId)
    if tab and tab.Button:FindFirstChild("Image") then
        tab.Button.Image.Image = "rbxassetid://" .. (imageId or "")
    end
end

-- Функция для расположения элементов
local function ArrangeElements(parent)
    local padding = 10
    local xOffset, yOffset = 0, 0
    local parentWidth = parent.AbsoluteSize.X

    for _, element in ipairs(parent:GetChildren()) do
        if element:IsA("GuiObject") then
            element.Position = UDim2.new(0, xOffset, 0, yOffset)
            xOffset = xOffset + element.Size.X.Offset + padding

            if xOffset + element.Size.X.Offset > parentWidth then
                xOffset = 0
                yOffset = yOffset + element.Size.Y.Offset + padding
                element.Position = UDim2.new(0, xOffset, 0, yOffset)
                xOffset = xOffset + element.Size.X.Offset + padding
            end
        end
    end
end

-- Добавление кнопки на вкладку
function AnDiosUi:AddButton(tab, buttonText, callback)
    local Button = Instance.new("TextButton")

    Button.Name = buttonText or "Button"
    Button.Parent = tab.Content
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Button.Size = UDim2.new(0, 150, 0, 40)
    Button.Font = Enum.Font.SourceSans
    Button.Text = buttonText or "Button"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 20
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
    Label.Font = Enum.Font.SourceSans
    Label.Text = labelText or "Label"
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 20

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
    DropdownButton.Font = Enum.Font.SourceSans
    DropdownButton.Text = dropdownText or "Dropdown"
    DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownButton.TextSize = 20

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
        OptionButton.Font = Enum.Font.SourceSans
        OptionButton.Text = option
        OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        OptionButton.TextSize = 20

        OptionButton.MouseButton1Click:Connect(function()
            DropdownButton.Text = option
            TweenOut(DropdownList, {Size = UDim2.new(1, 0, 0, 0)}, 0.5).Completed:Connect(function()
                DropdownList.Visible = false
            end)
            if callback then
                callback(option)
            end
            isExpanded = false
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

-- Установка значения выпадающего списка
function AnDiosUi:SetDropdownValue(dropdown, value)
    for _, child in pairs(dropdown.DropdownList:GetChildren()) do
        if child:IsA("TextButton") and child.Text == value then
            dropdown.DropdownButton.Text = value
            return
        end
    end
end

-- Функция для перемещения окна
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
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
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
