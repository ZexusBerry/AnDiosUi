local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local AnDiosUi = {}
AnDiosUi.__index = AnDiosUi

function AnDiosUi:CreateScreenGui()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AnDiosUI"
    ScreenGui.Parent = game.CoreGui
    return ScreenGui
end

function AnDiosUi:CreateMainFrame(ScreenGui)
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

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = MainFrame
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    return MainFrame
end

function AnDiosUi:CreateHeader(MainFrame, title)
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Parent = MainFrame
    Header.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Header.Size = UDim2.new(1, 0, 0, 30)
    Header.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Header

    local Title = Instance.new("TextLabel")
    Title.Parent = Header
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, -60, 1, 0)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Position = UDim2.new(0, 10, 0, 0)

    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = Header
    CloseButton.BackgroundTransparency = 1
    CloseButton.Size = UDim2.new(0, 30, 1, 0)
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 0, 0)
    CloseButton.TextSize = 18
    CloseButton.Position = UDim2.new(1, -40, 0, 0)
    CloseButton.MouseButton1Click:Connect(function()
        MainFrame:Destroy()
    end)

    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Parent = Header
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Size = UDim2.new(0, 30, 1, 0)
    MinimizeButton.Font = Enum.Font.SourceSansBold
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.TextSize = 18
    MinimizeButton.Position = UDim2.new(1, -70, 0, 0)
    MinimizeButton.MouseButton1Click:Connect(function()
        if MainFrame.Size == UDim2.new(0, 500, 0, 30) then
            MainFrame:TweenSize(UDim2.new(0, 500, 0, 300), "Out", "Sine", 0.5, true)
        else
            MainFrame:TweenSize(UDim2.new(0, 500, 0, 30), "Out", "Sine", 0.5, true)
        end
    end)

    AnDiosUi:MakeDraggable(Header)

    return Header
end

local function TweenIn(instance, properties, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

local function TweenOut(instance, properties, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

function AnDiosUi:ArrangeElements(tab)
    local UIListLayout = tab:FindFirstChildOfClass("UIListLayout")
    if not UIListLayout then
        UIListLayout = Instance.new("UIListLayout")
        UIListLayout.Parent = tab
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 10)
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

    self:ArrangeElements(tab)

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

    self:ArrangeElements(tab)

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
        OptionButton.Font = Enum.Font.SourceSans
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

    self:ArrangeElements(tab)

    return Dropdown
end

-- Добавление CheckBox
function AnDiosUi:AddCheckBox(tab, text, callback)
    local CheckBoxFrame = Instance.new("Frame")
    CheckBoxFrame.Parent = tab
    CheckBoxFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    CheckBoxFrame.Size = UDim2.new(1, -20, 0, 30)
    CheckBoxFrame.BorderSizePixel = 0

    local CheckBox = Instance.new("TextButton")
    CheckBox.Parent = CheckBoxFrame
    CheckBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    CheckBox.Size = UDim2.new(0, 30, 0, 30)
    CheckBox.Font = Enum.Font.SourceSansBold
    CheckBox.Text = ""
    CheckBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    CheckBox.TextSize = 18
    CheckBox.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = CheckBox

    local Label = Instance.new("TextLabel")
    Label.Parent = CheckBoxFrame
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, -40, 1, 0)
    Label.Font = Enum.Font.SourceSans
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 18
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Position = UDim2.new(0, 40, 0, 0)

    local isChecked = false

    CheckBox.MouseButton1Click:Connect(function()
        isChecked = not isChecked
        if isChecked then
            CheckBox.BackgroundColor3 = Color3.fromRGB(30, 150, 30)
        else
            CheckBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
        if callback then
            callback(isChecked)
        end
    end)

    self:ArrangeElements(tab)

    return CheckBox
end

-- Добавление Divider
function AnDiosUi:AddDivider(tab)
    local Divider = Instance.new("Frame")
    Divider.Parent = tab
    Divider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Divider.Size = UDim2.new(1, -20, 0, 1)
    Divider.BorderSizePixel = 0

    self:ArrangeElements(tab)

    return Divider
end

-- Добавление Message
function AnDiosUi:ShowMessage(text, image, duration)
    local MessageFrame = Instance.new("Frame")
    MessageFrame.Parent = self.ScreenGui
    MessageFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MessageFrame.Size = UDim2.new(0, 300, 0, 100)
    MessageFrame.Position = UDim2.new(1, -350, 1, 150)
    MessageFrame.BorderSizePixel = 0
    MessageFrame.AnchorPoint = Vector2.new(1, 1)

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = MessageFrame

    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Parent = MessageFrame
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Size = UDim2.new(0, 60, 0, 60)
    ImageLabel.Position = UDim2.new(0, 20, 0, 20)
    ImageLabel.Image = image

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = MessageFrame
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(1, -100, 1, -40)
    TextLabel.Position = UDim2.new(0, 80, 0, 20)
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.Text = text
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextSize = 18
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextWrapped = true

    TweenIn(MessageFrame, {Position = UDim2.new(1, -350, 1, -50)}, 0.5)

    delay(duration, function()
        TweenOut(MessageFrame, {Position = UDim2.new(1, -350, 1, 150)}, 0.5)
        wait(0.5)
        MessageFrame:Destroy()
    end)
end

-- Функция для создания вкладок
function AnDiosUi:CreateTab(TabContainer, name)
    local TabButton = Instance.new("TextButton")
    TabButton.Parent = TabContainer
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabButton.Size = UDim2.new(0, 100, 0, 30)
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 18
    TabButton.BorderSizePixel = 0

    local TabFrame = Instance.new("Frame")
    TabFrame.Parent = self.MainFrame
    TabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabFrame.Size = UDim2.new(1, 0, 1, -60)
    TabFrame.Position = UDim2.new(0, 0, 0, 60)
    TabFrame.Visible = false
    TabFrame.BorderSizePixel = 0

    TabButton.MouseButton1Click:Connect(function()
        for _, frame in pairs(self.MainFrame:GetChildren()) do
            if frame:IsA("Frame") and frame.Name ~= "Header" and frame.Name ~= "TabContainer" then
                frame.Visible = false
            end
        end
        TabFrame.Visible = true
    end)

    self:ArrangeElements(TabFrame)

    return TabFrame
end

function AnDiosUi:MakeDraggable(Frame)
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Frame.InputChanged:Connect(function(input)
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
