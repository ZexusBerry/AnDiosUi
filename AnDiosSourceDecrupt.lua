local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local AnDiosUi = {}

local function TweenIn(instance, properties, duration)
    local tween = TweenService:Create(instance, TweenInfo.new(duration, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), properties)
    tween:Play()
    return tween
end

local function TweenOut(instance, properties, duration)
    local tween = TweenService:Create(instance, TweenInfo.new(duration, Enum.EasingStyle.Quint, Enum.EasingDirection.In), properties)
    tween:Play()
    return tween
end

local function ArrangeElements(tab)
    local layout = tab:FindFirstChild("UIListLayout")
    if not layout then
        layout = Instance.new("UIListLayout", tab)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 10)
    end
end

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
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = MainFrame

    local Header = Instance.new("Frame")
    Header.Parent = MainFrame
    Header.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Header.Size = UDim2.new(1, 0, 0, 50)
    Header.Position = UDim2.new(0, 0, 0, 0)

    local Title = Instance.new("TextLabel")
    Title.Parent = Header
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 24
    Title.BorderSizePixel = 0

    -- Центрирование текста
    local UIPadding = Instance.new("UIPadding")
    UIPadding.Parent = Title
    UIPadding.PaddingLeft = UDim.new(0, 10)
    UIPadding.PaddingRight = UDim.new(0, 10)

    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = Header
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    CloseButton.Size = UDim2.new(0, 50, 0, 50)
    CloseButton.Position = UDim2.new(1, -50, 0, 0)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 24
    CloseButton.BorderSizePixel = 0

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Кнопка свернуть
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Parent = Header
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
    MinimizeButton.Size = UDim2.new(0, 50, 0, 50)
    MinimizeButton.Position = UDim2.new(1, -100, 0, 0)
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    MinimizeButton.TextSize = 24
    MinimizeButton.BorderSizePixel = 0

    local minimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            TweenOut(MainFrame, {Size = UDim2.new(0, 500, 0, 50)}, 0.3)
        else
            TweenIn(MainFrame, {Size = UDim2.new(0, 500, 0, 300)}, 0.3)
        end
    end)

    self.MainFrame = MainFrame

    return self
end

function AnDiosUi:AddTab(title)
    local TabButton = Instance.new("TextButton")
    TabButton.Parent = self.MainFrame
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabButton.Size = UDim2.new(0, 100, 0, 50)
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.Text = title
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 18
    TabButton.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = TabButton

    local TabFrame = Instance.new("Frame")
    TabFrame.Parent = self.MainFrame
    TabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabFrame.Size = UDim2.new(1, -10, 1, -60)
    TabFrame.Position = UDim2.new(0, 10, 0, 60)
    TabFrame.Visible = false

    TabButton.MouseButton1Click:Connect(function()
        for _, child in pairs(self.MainFrame:GetChildren()) do
            if child:IsA("Frame") and child ~= TabFrame then
                child.Visible = false
            end
        end
        TabFrame.Visible = true
    end)

    ArrangeElements(TabFrame)

    return TabFrame
end

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

    local DropdownList = Instance.new("Frame")
    DropdownList.Parent = Dropdown
    DropdownList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    DropdownList.Size = UDim2.new(1, 0, 0, #options * 30)
    DropdownList.Position = UDim2.new(0, 0, 1, 0)
    DropdownList.Visible = false
    DropdownList.ClipsDescendants = true

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = DropdownList
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    for _, option in ipairs(options) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Parent = DropdownList
        OptionButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        OptionButton.Size = UDim2.new(1, 0, 0, 30)
        OptionButton.Font = Enum.Font.SourceSansBold
        OptionButton.Text = option
        OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        OptionButton.TextSize = 18
        OptionButton.BorderSizePixel = 0

        OptionButton.MouseButton1Click:Connect(function()
            DropdownButton.Text = option
            if callback then
                callback(option)
            end
            TweenOut(DropdownList, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
            wait(0.2)
            DropdownList.Visible = false
        end)
    end

    DropdownButton.MouseButton1Click:Connect(function()
        if DropdownList.Visible then
            TweenOut(DropdownList, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
            wait(0.2)
            DropdownList.Visible = false
        else
            DropdownList.Visible = true
            TweenIn(DropdownList, {Size = UDim2.new(1, 0, 0, #options * 30)}, 0.2)
        end
    end)

    ArrangeElements(tab)

    return Dropdown
end

function AnDiosUi:AddCheckBox(tab, text, callback)
    local CheckBox = Instance.new("Frame")
    CheckBox.Parent = tab
    CheckBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    CheckBox.Size = UDim2.new(1, -20, 0, 30)
    CheckBox.BorderSizePixel = 0

    local CheckBoxButton = Instance.new("TextButton")
    CheckBoxButton.Parent = CheckBox
    CheckBoxButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    CheckBoxButton.Size = UDim2.new(0, 30, 1, 0)
    CheckBoxButton.Font = Enum.Font.SourceSansBold
    CheckBoxButton.Text = ""
    CheckBoxButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CheckBoxButton.TextSize = 18
    CheckBoxButton.BorderSizePixel = 0

    local CheckBoxLabel = Instance.new("TextLabel")
    CheckBoxLabel.Parent = CheckBox
    CheckBoxLabel.BackgroundTransparency = 1
    CheckBoxLabel.Position = UDim2.new(0, 40, 0, 0)
    CheckBoxLabel.Size = UDim2.new(1, -40, 1, 0)
    CheckBoxLabel.Font = Enum.Font.SourceSans
    CheckBoxLabel.Text = text
    CheckBoxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    CheckBoxLabel.TextSize = 18

    local checked = false
    CheckBoxButton.MouseButton1Click:Connect(function()
        checked = not checked
        if checked then
            TweenIn(CheckBoxButton, {BackgroundColor3 = Color3.fromRGB(0, 255, 0)}, 0.2)
        else
            TweenOut(CheckBoxButton, {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}, 0.2)
        end
        if callback then
            callback(checked)
        end
    end)

    ArrangeElements(tab)

    return CheckBox
end

function AnDiosUi:AddMessage(text, description, image, duration)
    local MessageFrame = Instance.new("Frame")
    MessageFrame.Parent = self.MainFrame
    MessageFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MessageFrame.Size = UDim2.new(0, 300, 0, 100)
    MessageFrame.Position = UDim2.new(1, 310, 1, -110)
    MessageFrame.AnchorPoint = Vector2.new(1, 1)
    MessageFrame.ClipsDescendants = true

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = MessageFrame

    local Icon = Instance.new("ImageLabel")
    Icon.Parent = MessageFrame
    Icon.BackgroundTransparency = 1
    Icon.Size = UDim2.new(0, 40, 0, 40)
    Icon.Position = UDim2.new(0, 10, 0, 10)
    Icon.Image = image

    local Title = Instance.new("TextLabel")
    Title.Parent = MessageFrame
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, -60, 0, 40)
    Title.Position = UDim2.new(0, 60, 0, 10)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = text
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 24
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local Description = Instance.new("TextLabel")
    Description.Parent = MessageFrame
    Description.BackgroundTransparency = 1
    Description.Size = UDim2.new(1, -20, 0, 40)
    Description.Position = UDim2.new(0, 10, 0, 50)
    Description.Font = Enum.Font.SourceSans
    Description.Text = description
    Description.TextColor3 = Color3.fromRGB(255, 255, 255)
    Description.TextSize = 18
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.TextWrapped = true

    TweenIn(MessageFrame, {Position = UDim2.new(1, -10, 1, -10)}, 0.5)
    wait(duration)
    TweenOut(MessageFrame, {Position = UDim2.new(1, 310, 1, -110)}, 0.5)
    wait(0.5)
    MessageFrame:Destroy()
end

function AnDiosUi:AddDivider(tab)
    local Divider = Instance.new("Frame")
    Divider.Parent = tab
    Divider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Divider.Size = UDim2.new(1, -20, 0, 1)
    Divider.BorderSizePixel = 0

    ArrangeElements(tab)

    return Divider
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
