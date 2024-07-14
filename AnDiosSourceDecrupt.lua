local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local AnDiosUi = {}
AnDiosUi.__index = AnDiosUi

local function TweenIn(object, properties, duration)
    local tween = TweenService:Create(object, TweenInfo.new(duration), properties)
    tween:Play()
    return tween
end

local function TweenOut(object, properties, duration)
    local tween = TweenService:Create(object, TweenInfo.new(duration), properties)
    tween:Play()
    return tween
end

local function ArrangeElements(tab)
    local UIListLayout = tab:FindFirstChildOfClass("UIListLayout")
    if not UIListLayout then
        UIListLayout = Instance.new("UIListLayout")
        UIListLayout.Parent = tab
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    end
end

function AnDiosUi.new()
    local self = setmetatable({}, AnDiosUi)

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
    Header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.Position = UDim2.new(0, 0, 0, 0)
    Header.BorderSizePixel = 0

    local UICornerHeader = Instance.new("UICorner")
    UICornerHeader.CornerRadius = UDim.new(0, 6)
    UICornerHeader.Parent = Header

    local Title = Instance.new("TextLabel")
    Title.Parent = Header
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, -80, 1, 0)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = "AnDios UI"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 20
    Title.Position = UDim2.new(0.5, -Title.TextBounds.X / 2, 0, 0)
    Title.BorderSizePixel = 0

    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = Header
    CloseButton.BackgroundTransparency = 1
    CloseButton.Size = UDim2.new(0, 40, 1, 0)
    CloseButton.Position = UDim2.new(1, -40, 0, 0)
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 20
    CloseButton.BorderSizePixel = 0

    CloseButton.MouseButton1Click:Connect(function()
        TweenOut(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3).Completed:Connect(function()
            MainFrame:Destroy()
        end)
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
    MinimizeButton.BorderSizePixel = 0

    MinimizeButton.MouseButton1Click:Connect(function()
        if MainFrame.Size == UDim2.new(0, 500, 0, 300) then
            TweenOut(MainFrame, {Size = UDim2.new(0, 500, 0, 40)}, 0.3)
        else
            TweenIn(MainFrame, {Size = UDim2.new(0, 500, 0, 300)}, 0.3)
        end
    end)

    self.MainFrame = MainFrame

    return self
end

function AnDiosUi:AddTab(name)
    local TabButton = Instance.new("TextButton")
    TabButton.Parent = self.MainFrame
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabButton.Size = UDim2.new(0, 100, 0, 30)
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 18
    TabButton.BorderSizePixel = 0

    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Parent = self.MainFrame
    TabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabFrame.Size = UDim2.new(1, 0, 1, -40)
    TabFrame.Position = UDim2.new(0, 0, 0, 40)
    TabFrame.Visible = false
    TabFrame.BorderSizePixel = 0
    TabFrame.CanvasSize = UDim2.new(0, 0, 1, 0)
    TabFrame.ScrollBarThickness = 6

    local UICornerTabFrame = Instance.new("UICorner")
    UICornerTabFrame.CornerRadius = UDim.new(0, 6)
    UICornerTabFrame.Parent = TabFrame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = TabFrame
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)

    TabButton.MouseButton1Click:Connect(function()
        for _, frame in ipairs(self.MainFrame:GetChildren()) do
            if frame:IsA("ScrollingFrame") then
                frame.Visible = false
            end
        end
        TabFrame.Visible = true
    end)

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
    DropdownButton.Background-Color3 = Color3.fromRGB(40, 40, 40)
    DropdownButton.Size = UDim2.new(1, 0, 1, 0)
    DropdownButton.Font = Enum.Font.SourceSansBold
    DropdownButton.Text = text
    DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownButton.TextSize = 18
    DropdownButton.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = DropdownButton

    local OptionsFrame = Instance.new("Frame")
    OptionsFrame.Parent = Dropdown
    OptionsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    OptionsFrame.Size = UDim2.new(1, 0, 0, #options * 30)
    OptionsFrame.Position = UDim2.new(0, 0, 1, 0)
    OptionsFrame.BorderSizePixel = 0
    OptionsFrame.ClipsDescendants = true
    OptionsFrame.Visible = false

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = OptionsFrame
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 2)

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

        local OptionUICorner = Instance.new("UICorner")
        OptionUICorner.CornerRadius = UDim.new(0, 4)
        OptionUICorner.Parent = OptionButton

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
        if OptionsFrame.Visible then
            TweenIn(OptionsFrame, {Size = UDim2.new(1, 0, 0, #options * 30)}, 0.3)
        else
            TweenOut(OptionsFrame, {Size = UDim2.new(1, 0, 0, 0)}, 0.3)
        end
    end)

    ArrangeElements(tab)

    return Dropdown
end

function AnDiosUi:AddCheckBox(tab, text, callback)
    local CheckBoxFrame = Instance.new("Frame")
    CheckBoxFrame.Parent = tab
    CheckBoxFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    CheckBoxFrame.Size = UDim2.new(1, -20, 0, 30)
    CheckBoxFrame.BorderSizePixel = 0

    local CheckBox = Instance.new("TextButton")
    CheckBox.Parent = CheckBoxFrame
    CheckBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    CheckBox.Size = UDim2.new(0, 30, 0, 30)
    CheckBox.Font = Enum.Font.SourceSansBold
    CheckBox.Text = ""
    CheckBox.TextSize = 18
    CheckBox.BorderSizePixel = 0

    local UICornerCheckBox = Instance.new("UICorner")
    UICornerCheckBox.CornerRadius = UDim.new(0, 4)
    UICornerCheckBox.Parent = CheckBox

    local CheckBoxLabel = Instance.new("TextLabel")
    CheckBoxLabel.Parent = CheckBoxFrame
    CheckBoxLabel.BackgroundTransparency = 1
    CheckBoxLabel.Size = UDim2.new(1, -35, 1, 0)
    CheckBoxLabel.Position = UDim2.new(0, 35, 0, 0)
    CheckBoxLabel.Font = Enum.Font.SourceSansBold
    CheckBoxLabel.Text = text
    CheckBoxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    CheckBoxLabel.TextSize = 18
    CheckBoxLabel.BorderSizePixel = 0

    local isChecked = false

    CheckBox.MouseButton1Click:Connect(function()
        isChecked = not isChecked
        if isChecked then
            TweenIn(CheckBox, {BackgroundColor3 = Color3.fromRGB(0, 255, 0)}, 0.2)
        else
            TweenOut(CheckBox, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.2)
        end
        if callback then
            callback(isChecked)
        end
    end)

    ArrangeElements(tab)

    return CheckBox
end

function AnDiosUi:AddMessage(text, description, duration, imageId)
    local MessageFrame = Instance.new("Frame")
    MessageFrame.Parent = self.MainFrame
    MessageFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MessageFrame.Size = UDim2.new(0, 300, 0, 80)
    MessageFrame.Position = UDim2.new(1, -310, 1, -90)
    MessageFrame.BorderSizePixel = 0
    MessageFrame.Visible = false

    local UICornerMessage = Instance.new("UICorner")
    UICornerMessage.CornerRadius = UDim.new(0, 6)
    UICornerMessage.Parent = MessageFrame

    local Icon = Instance.new("ImageLabel")
    Icon.Parent = MessageFrame
    Icon.BackgroundTransparency = 1
    Icon.Size = UDim2.new(0, 40, 0, 40)
    Icon.Position = UDim2.new(0, 10, 0, 20)
    Icon.Image = "rbxassetid://"..imageId
    Icon.BorderSizePixel = 0

    local Title = Instance.new("TextLabel")
    Title.Parent = MessageFrame
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, -60, 0, 30)
    Title.Position = UDim2.new(0, 60, 0, 10)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = text
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.BorderSizePixel = 0

    local Description = Instance.new("TextLabel")
    Description.Parent = MessageFrame
    Description.BackgroundTransparency = 1
    Description.Size = UDim2.new(1, -60, 0, 30)
    Description.Position = UDim2.new(0, 60, 0, 40)
    Description.Font = Enum.Font.SourceSans
    Description.Text = description
    Description.TextColor3 = Color3.fromRGB(200, 200, 200)
    Description.TextSize = 14
    Description.BorderSizePixel = 0

    TweenIn(MessageFrame, {Position = UDim2.new(1, -310, 1, -100)}, 0.3).Completed:Connect(function()
        wait(duration)
        TweenOut(MessageFrame, {Position = UDim2.new(1, -310, 1, -90)}, 0.3).Completed:Connect(function()
            MessageFrame:Destroy()
        end)
    end)

    return MessageFrame
end

return AnDiosUi
