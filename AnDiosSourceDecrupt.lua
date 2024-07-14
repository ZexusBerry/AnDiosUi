local AnDiosUi = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local function TweenIn(object, properties, duration, ...)
    local tweenInfo = TweenInfo.new(duration, ...)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

local function TweenOut(object, properties, duration, ...)
    local tweenInfo = TweenInfo.new(duration, ...)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

function AnDiosUi:CreateScreenGui()
    local ScreenGui = Instance.new("ScreenGui")
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

function AnDiosUi:CreateTabContainer(MainFrame)
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabContainer.Size = UDim2.new(1, 0, 0, 40)
    TabContainer.Position = UDim2.new(0, 0, 0, 0)
    TabContainer.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = TabContainer

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = TabContainer
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    return TabContainer
end

function AnDiosUi:CreateTab(TabContainer, text, id)
    local Tab = Instance.new("TextButton")
    Tab.Parent = TabContainer
    Tab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Tab.Size = UDim2.new(0, 120, 0, 40)
    Tab.Font = Enum.Font.SourceSansBold
    Tab.Text = text
    Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tab.TextSize = 18
    Tab.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Tab

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = Tab
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    Tab.MouseButton1Click:Connect(function()
        for _, button in pairs(TabContainer:GetChildren()) do
            if button:IsA("TextButton") then
                button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            end
        end
        Tab.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)

    return Tab
end

local function ArrangeElements(tab)
    local layout = tab:FindFirstChildOfClass("UIListLayout")
    local contentSize = layout.AbsoluteContentSize
    local newSize = UDim2.new(1, 0, 0, contentSize.Y)
    tab.Size = newSize
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

function AnDiosUi:AddCheckBox(tab, text, callback)
    local CheckBox = Instance.new("Frame")
    CheckBox.Parent = tab
    CheckBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    CheckBox.Size = UDim2.new(1, -20, 0, 30)
    CheckBox.BorderSizePixel = 0

    local CheckBoxButton = Instance.new("TextButton")
    CheckBoxButton.Parent = CheckBox
    CheckBoxButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    CheckBoxButton.Size = UDim2.new(0, 30, 0, 30)
    CheckBoxButton.Text = ""
    CheckBoxButton.BorderSizePixel = 0

    local Checked = Instance.new("BoolValue")
    Checked.Parent = CheckBoxButton
    Checked.Value = false

    CheckBoxButton.MouseButton1Click:Connect(function()
        Checked.Value = not Checked.Value
        if Checked.Value then
            TweenIn(CheckBoxButton, {BackgroundColor3 = Color3.fromRGB(0, 200, 0)}, 0.3)
        else
            TweenOut(CheckBoxButton, {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}, 0.3)
        end
        if callback then
            callback(Checked.Value)
        end
    end)

    local CheckBoxLabel = Instance.new("TextLabel")
    CheckBoxLabel.Parent = CheckBox
    CheckBoxLabel.BackgroundTransparency = 1
    CheckBoxLabel.Size = UDim2.new(1, -40, 1, 0)
    CheckBoxLabel.Position = UDim2.new(0, 40, 0, 0)
    CheckBoxLabel.Font = Enum.Font.SourceSans
    CheckBoxLabel.Text = text
    CheckBoxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    CheckBoxLabel.TextSize = 18
    CheckBoxLabel.TextXAlignment = Enum.TextXAlignment.Left

    ArrangeElements(tab)

    return CheckBox
end

function AnDiosUi:CreateMessage(ScreenGui, text, iconId, duration)
    local Message = Instance.new("Frame")
    Message.Parent = ScreenGui
    Message.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Message.Size = UDim2.new(0, 300, 0, 80)
    Message.Position = UDim2.new(1, 0, 1, -90)
    Message.AnchorPoint = Vector2.new(1, 1)
    Message.BorderSizePixel = 0

    local Icon = Instance.new("ImageLabel")
    Icon.Parent = Message
    Icon.Size = UDim2.new(0, 50, 0, 50)
    Icon.Position = UDim2.new(0, 15, 0, 15)
    Icon.BackgroundTransparency = 1
    Icon.Image = iconId

    local MessageLabel = Instance.new("TextLabel")
    MessageLabel.Parent = Message
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.Size = UDim2.new(1, -80, 1, 0)
    MessageLabel.Position = UDim2.new(0, 80, 0, 0)
    MessageLabel.Font = Enum.Font.SourceSansBold
    MessageLabel.Text = text
    MessageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    MessageLabel.TextSize = 18
    MessageLabel.TextWrapped = true
    MessageLabel.TextXAlignment = Enum.TextXAlignment.Left

    TweenIn(Message, {Position = UDim2.new(1, -320, 1, -90)}, 0.5, Enum.EasingStyle.Quad)

    wait(duration or 5)

    TweenOut(Message, {Position = UDim2.new(1, 0, 1, -90)}, 0.5, Enum.EasingStyle.Quad).Completed:Connect(function()
        Message:Destroy()
    end)

    return Message
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
