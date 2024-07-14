local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local AnDiosUi = {}

-- Основные настройки UI
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

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = MainFrame

    local Header = Instance.new("Frame")
    Header.Parent = MainFrame
    Header.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BorderSizePixel = 0

    local HeaderText = Instance.new("TextLabel")
    HeaderText.Parent = Header
    HeaderText.BackgroundTransparency = 1
    HeaderText.Size = UDim2.new(1, 0, 1, 0)
    HeaderText.Font = Enum.Font.SourceSansBold
    HeaderText.Text = title
    HeaderText.TextColor3 = Color3.fromRGB(255, 255, 255)
    HeaderText.TextSize = 20
    HeaderText.TextWrapped = true

    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = Header
    CloseButton.BackgroundTransparency = 1
    CloseButton.Size = UDim2.new(0, 40, 1, 0)
    CloseButton.Position = UDim2.new(1, -40, 0, 0)
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 20

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Parent = Header
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Size = UDim2.new(0, 40, 1, 0)
    MinimizeButton.Position = UDim2.new(1, -80, 0, 0)
    MinimizeButton.Font = Enum.Font.SourceSansBold
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.TextSize = 20

    local minimized = false

    MinimizeButton.MouseButton1Click:Connect(function()
        if minimized then
            TweenService:Create(MainFrame, TweenInfo.new(0.5), {Size = UDim2.new(0, 500, 0, 300)}):Play()
            minimized = false
        else
            TweenService:Create(MainFrame, TweenInfo.new(0.5), {Size = UDim2.new(0, 500, 0, 40)}):Play()
            minimized = true
        end
    end)

    local TabContainer = Instance.new("Frame")
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundTransparency = 1
    TabContainer.Size = UDim2.new(1, 0, 1, -40)
    TabContainer.Position = UDim2.new(0, 0, 0, 40)
    TabContainer.ClipsDescendants = true

    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabContainer
    TabList.FillDirection = Enum.FillDirection.Horizontal
    TabList.SortOrder = Enum.SortOrder.LayoutOrder

    function AnDiosUi:CreateTab(name)
        local TabButton = Instance.new("TextButton")
        TabButton.Parent = TabContainer
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabButton.Size = UDim2.new(0, 100, 1, 0)
        TabButton.Font = Enum.Font.SourceSansBold
        TabButton.Text = name
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextSize = 18
        TabButton.BorderSizePixel = 0

        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 4)
        UICorner.Parent = TabButton

        local TabContent = Instance.new("Frame")
        TabContent.Parent = TabContainer
        TabContent.BackgroundTransparency = 1
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.Position = UDim2.new(0, 0, 1, 0)
        TabContent.Visible = false

        local TabList = Instance.new("UIListLayout")
        TabList.Parent = TabContent
        TabList.FillDirection = Enum.FillDirection.Vertical
        TabList.SortOrder = Enum.SortOrder.LayoutOrder

        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(TabContainer:GetChildren()) do
                if v:IsA("Frame") and v ~= TabContainer then
                    v.Visible = false
                end
            end
            TabContent.Visible = true
        end)

        ArrangeElements(TabContent)

        return TabContent
    end

    return AnDiosUi
end

-- Функции для анимаций
local function TweenIn(obj, properties, duration)
    local tween = TweenService:Create(obj, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), properties)
    tween:Play()
    return tween
end

local function TweenOut(obj, properties, duration)
    local tween = TweenService:Create(obj, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.In), properties)
    tween:Play()
    return tween
end

-- Расположение элементов в табе
local function ArrangeElements(tab)
    local elements = tab:GetChildren()
    local yOffset = 10
    for _, element in ipairs(elements) do
        if element:IsA("GuiObject") then
            element.Position = UDim2.new(0, 10, 0, yOffset)
            yOffset = yOffset + element.Size.Y.Offset + 10
        end
    end
end

-- Добавление Label
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

function AnDiosUi:AddDivider(tab)
    local Divider = Instance.new("Frame")
    Divider.Parent = tab
    Divider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Divider.Size = UDim2.new(1, -20, 0, 2)
    Divider.BorderSizePixel = 0

    ArrangeElements(tab)

    return Divider
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
    DropdownButton.BackgroundColor3 = Color3.fromRGB(50, 40, 50)
    DropdownButton.Size = UDim2.new(1, 0, 1, 0)
    DropdownButton.Font = Enum.Font.SourceSans
    DropdownButton.Text = text
    DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownButton.TextSize = 18
    DropdownButton.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = DropdownButton

    local OptionsFrame = Instance.new("Frame")
    OptionsFrame.Parent = Dropdown
    OptionsFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    OptionsFrame.Size = UDim2.new(1, 0, 0, #options * 30)
    OptionsFrame.Position = UDim2.new(0, 0, 1, 0)
    OptionsFrame.BorderSizePixel = 0
    OptionsFrame.Visible = false
    OptionsFrame.ClipsDescendants = true

    local OptionsList = Instance.new("UIListLayout")
    OptionsList.Parent = OptionsFrame
    OptionsList.SortOrder = Enum.SortOrder.LayoutOrder

    for _, option in ipairs(options) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Parent = OptionsFrame
        OptionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        OptionButton.Size = UDim2.new(1, 0, 0, 30)
        OptionButton.Font = Enum.Font.SourceSans
        OptionButton.Text = option
        OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        OptionButton.TextSize = 18
        OptionButton.BorderSizePixel = 0

        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 4)
        UICorner.Parent = OptionButton

        OptionButton.MouseButton1Click:Connect(function()
            DropdownButton.Text = option
            OptionsFrame.Visible = false
            if callback then
                callback(option)
            end
        end)
    end

    DropdownButton.MouseButton1Click:Connect(function()
        OptionsFrame.Visible = not OptionsFrame.Visible
    end)

    ArrangeElements(tab)

    return Dropdown
end

-- Добавление анимированного CheckBox
function AnDiosUi:AddCheckBox(tab, text, callback)
    local CheckBoxFrame = Instance.new("Frame")
    CheckBoxFrame.Parent = tab
    CheckBoxFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    CheckBoxFrame.Size = UDim2.new(1, -20, 0, 30)
    CheckBoxFrame.BorderSizePixel = 0

    local CheckBox = Instance.new("TextButton")
    CheckBox.Parent = CheckBoxFrame
    CheckBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    CheckBox.Size = UDim2.new(0, 30, 1, 0)
    CheckBox.Font = Enum.Font.SourceSans
    CheckBox.Text = ""
    CheckBox.TextSize = 18
    CheckBox.BorderSizePixel = 0

    local Check = Instance.new("Frame")
    Check.Parent = CheckBox
    Check.BackgroundColor3 = Color3.fromRGB(40, 255, 40)
    Check.Size = UDim2.new(0.8, 0, 0.8, 0)
    Check.Position = UDim2.new(0.1, 0, 0.1, 0)
    Check.Visible = false

    local UICornerCheckBox = Instance.new("UICorner")
    UICornerCheckBox.CornerRadius = UDim.new(0, 4)
    UICornerCheckBox.Parent = CheckBox

    local UICornerCheck = Instance.new("UICorner")
    UICornerCheck.CornerRadius = UDim.new(0, 4)
    UICornerCheck.Parent = Check

    local CheckBoxLabel = Instance.new("TextLabel")
    CheckBoxLabel.Parent = CheckBoxFrame
    CheckBoxLabel.BackgroundTransparency = 1
    CheckBoxLabel.Size = UDim2.new(1, -40, 1, 0)
    CheckBoxLabel.Position = UDim2.new(0, 40, 0, 0)
    CheckBoxLabel.Font = Enum.Font.SourceSans
    CheckBoxLabel.Text = text
    CheckBoxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    CheckBoxLabel.TextSize = 18
    CheckBoxLabel.TextXAlignment = Enum.TextXAlignment.Left

    CheckBox.MouseButton1Click:Connect(function()
        Check.Visible = not Check.Visible
        if callback then
            callback(Check.Visible)
        end
    end)

    ArrangeElements(tab)

    return CheckBox
end

-- Добавление сообщения
function AnDiosUi:ShowMessage(text, duration, image)
    local Message = Instance.new("Frame")
    Message.Parent = game.CoreGui
    Message.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Message.Size = UDim2.new(0, 300, 0, 100)
    Message.Position = UDim2.new(1, -320, 1, -120)
    Message.AnchorPoint = Vector2.new(1, 1)
    Message.BorderSizePixel = 0
    Message.Visible = false

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Message

    local MessageText = Instance.new("TextLabel")
    MessageText.Parent = Message
    MessageText.BackgroundTransparency = 1
    MessageText.Size = UDim2.new(1, -20, 1, 0)
    MessageText.Position = UDim2.new(0, 20, 0, 0)
    MessageText.Font = Enum.Font.SourceSans
    MessageText.Text = text
    MessageText.TextColor3 = Color3.fromRGB(255, 255, 255)
    MessageText.TextSize = 18
    MessageText.TextWrapped = true
    MessageText.TextXAlignment = Enum.TextXAlignment.Left

    if image then
        local MessageImage = Instance.new("ImageLabel")
        MessageImage.Parent = Message
        MessageImage.BackgroundTransparency = 1
        MessageImage.Size = UDim2.new(0, 40, 0, 40)
        MessageImage.Position = UDim2.new(0, 10, 0, 10)
        MessageImage.Image = image
    end

    TweenIn(Message, {Position = UDim2.new(1, -320, 1, -120)}, 0.5).Completed:Connect(function()
        wait(duration)
        TweenOut(Message, {Position = UDim2.new(1, -320, 1, -150)}, 0.5).Completed:Connect(function()
            Message:Destroy()
        end)
    end)
end

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
