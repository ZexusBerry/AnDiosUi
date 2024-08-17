local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local AnDiosUi = {}
AnDiosUi.__index = AnDiosUi

-- Создание UI
function AnDiosUi:CreateUI()
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

    -- Заголовок окна
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Parent = MainFrame
    Header.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Header.Size = UDim2.new(1, 0, 0, 40)

    local Title = Instance.new("TextLabel")
    Title.Parent = Header
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, -80, 1, 0)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = "AnDios UI"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 20
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Position = UDim2.new(0, 10, 0, 0)

    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = Header
    CloseButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    CloseButton.Size = UDim2.new(0, 40, 1, 0)
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 20
    CloseButton.Position = UDim2.new(1, -40, 0, 0)
    CloseButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
    end)

    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Parent = Header
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MinimizeButton.Size = UDim2.new(0, 40, 1, 0)
    MinimizeButton.Font = Enum.Font.SourceSansBold
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.TextSize = 20
    MinimizeButton.Position = UDim2.new(1, -80, 0, 0)
    MinimizeButton.MouseButton1Click:Connect(function()
        MainFrame:TweenSize(UDim2.new(0, 500, 0, 40), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
        wait(0.5)
        if MainFrame.Size == UDim2.new(0, 500, 0, 40) then
            MinimizeButton.Text = "+"
            MinimizeButton.MouseButton1Click:Connect(function()
                MainFrame:TweenSize(UDim2.new(0, 500, 0, 300), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
                MinimizeButton.Text = "-"
            end)
        end
    end)

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Size = UDim2.new(1, 0, 1, -40)
    ContentFrame.Position = UDim2.new(0, 0, 0, 40)

    local TabHolder = Instance.new("Frame")
    TabHolder.Name = "TabHolder"
    TabHolder.Parent = ContentFrame
    TabHolder.BackgroundTransparency = 1
    TabHolder.Size = UDim2.new(1, 0, 1, -40)
    TabHolder.Position = UDim2.new(0, 0, 0, 0)

    local TabButtons = Instance.new("Frame")
    TabButtons.Name = "TabButtons"
    TabButtons.Parent = ContentFrame
    TabButtons.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabButtons.Size = UDim2.new(1, 0, 0, 40)
    TabButtons.Position = UDim2.new(0, 0, 1, -40)

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = TabButtons
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    self.ScreenGui = ScreenGui
    self.MainFrame = MainFrame
    self.TabHolder = TabHolder
    self.TabButtons = TabButtons

    return self
end

-- Функция для анимации элементов
local function TweenIn(element, properties, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(element, tweenInfo, properties)
    tween:Play()
    return tween
end

local function TweenOut(element, properties, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local tween = TweenService:Create(element, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Функция для корректного расположения элементов внутри табов
local function ArrangeElements(tab)
    local layout = tab:FindFirstChildOfClass("UIListLayout")
    if not layout then
        layout = Instance.new("UIListLayout")
        layout.Parent = tab
        layout.Padding = UDim.new(0, 5)
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    end
end

-- Добавление новой вкладки
function AnDiosUi:AddTab(name, imageId)
    local TabButton = Instance.new("TextButton")
    TabButton.Parent = self.TabButtons
    TabButton.BackgroundTransparency = 1
    TabButton.Size = UDim2.new(0, 100, 1, 0)
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 18

    local TabContent = Instance.new("Frame")
    TabContent.Parent = self.TabHolder
    TabContent.Name = name
    TabContent.BackgroundTransparency = 1
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.Visible = false

    local function UpdateTabVisibility()
        for _, tab in ipairs(self.TabHolder:GetChildren()) do
            if tab:IsA("Frame") then
                tab.Visible = false
            end
        end
        TabContent.Visible = true
    end

    TabButton.MouseButton1Click:Connect(UpdateTabVisibility)
    UpdateTabVisibility()

    return TabContent
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
        TweenOut(Button, {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}, 0.2)
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
function AnDiosUi:AddDropDown(tab, text, options, callback)
    local DropDown = Instance.new("Frame")
    DropDown.Parent = tab
    DropDown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    DropDown.Size = UDim2.new(1, -20, 0, 30)
    DropDown.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = DropDown

    local DropDownButton = Instance.new("TextButton")
    DropDownButton.Parent = DropDown
    DropDownButton.BackgroundTransparency = 1
    DropDownButton.Size = UDim2.new(1, 0, 1, 0)
    DropDownButton.Font = Enum.Font.SourceSansBold
    DropDownButton.Text = text
    DropDownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropDownButton.TextSize = 18

    local OptionFrame = Instance.new("Frame")
    OptionFrame.Parent = DropDown
    OptionFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    OptionFrame.Size = UDim2.new(1, 0, 0, #options * 30)
    OptionFrame.Position = UDim2.new(0, 0, 1, 0)
    OptionFrame.Visible = false

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = OptionFrame
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    for _, option in ipairs(options) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Parent = OptionFrame
        OptionButton.BackgroundTransparency = 1
        OptionButton.Size = UDim2.new(1, 0, 0, 30)
        OptionButton.Font = Enum.Font.SourceSansBold
        OptionButton.Text = option
        OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        OptionButton.TextSize = 18

        OptionButton.MouseButton1Click:Connect(function()
            DropDownButton.Text = option
            OptionFrame.Visible = false
            if callback then
                callback(option)
            end
        end)
    end

    DropDownButton.MouseButton1Click:Connect(function()
        OptionFrame.Visible = not OptionFrame.Visible
    end)

    ArrangeElements(tab)

    return DropDown
end

-- Добавление CheckBox
function AnDiosUi:AddCheckBox(tab, text, callback)
    local CheckBox = Instance.new("Frame")
    CheckBox.Parent = tab
    CheckBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    CheckBox.Size = UDim2.new(1, -20, 0, 30)
    CheckBox.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = CheckBox

    local CheckBoxButton = Instance.new("TextButton")
    CheckBoxButton.Parent = CheckBox
    CheckBoxButton.BackgroundTransparency = 1
    CheckBoxButton.Size = UDim2.new(1, 0, 1, 0)
    CheckBoxButton.Font = Enum.Font.SourceSansBold
    CheckBoxButton.Text = text
    CheckBoxButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CheckBoxButton.TextSize = 18

    local Checked = false

    CheckBoxButton.MouseButton1Click:Connect(function()
        Checked = not Checked
        if Checked then
            TweenIn(CheckBoxButton, {TextColor3 = Color3.fromRGB(0, 255, 0)}, 0.2)
        else
            TweenOut(CheckBoxButton, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
        end
        if callback then
            callback(Checked)
        end
    end)

    ArrangeElements(tab)

    return CheckBox
end

-- Добавление разделителя
function AnDiosUi:AddDivider(tab)
    local Divider = Instance.new("Frame")
    Divider.Parent = tab
    Divider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Divider.Size = UDim2.new(1, -20, 0, 2)

    ArrangeElements(tab)

    return Divider
end

-- Добавление сообщения
function AnDiosUi:AddMessage(text, description, duration, imageId)
    local MessageFrame = Instance.new("Frame")
    MessageFrame.Parent = self.ScreenGui
    MessageFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MessageFrame.Size = UDim2.new(0, 300, 0, 80)
    MessageFrame.Position = UDim2.new(1, -310, 1, 90)
    MessageFrame.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = MessageFrame

    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Parent = MessageFrame
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Size = UDim2.new(0, 60, 0, 60)
    ImageLabel.Position = UDim2.new(0, 10, 0, 10)
    ImageLabel.Image = imageId and "rbxassetid://" .. imageId or ""

    local MessageText = Instance.new("TextLabel")
    MessageText.Parent = MessageFrame
    MessageText.BackgroundTransparency = 1
    MessageText.Size = UDim2.new(1, -80, 0.5, 0)
    MessageText.Position = UDim2.new(0, 80, 0, 10)
    MessageText.Font = Enum.Font.SourceSansBold
    MessageText.Text = text
    MessageText.TextColor3 = Color3.fromRGB(255, 255, 255)
    MessageText.TextSize = 18
    MessageText.TextXAlignment = Enum.TextXAlignment.Left

    local MessageDescription = Instance.new("TextLabel")
    MessageDescription.Parent = MessageFrame
    MessageDescription.BackgroundTransparency = 1
    MessageDescription.Size = UDim2.new(1, -80, 0.5, 0)
    MessageDescription.Position = UDim2.new(0, 80, 0.5, 0)
    MessageDescription.Font = Enum.Font.SourceSans
    MessageDescription.Text = description
    MessageDescription.TextColor3 = Color3.fromRGB(200, 200, 200)
    MessageDescription.TextSize = 16
    MessageDescription.TextXAlignment = Enum.TextXAlignment.Left

    TweenIn(MessageFrame, {Position = UDim2.new(1, -310, 1, -90)}, 0.5)

    delay(duration or 3, function()
        TweenOut(MessageFrame, {Position = UDim2.new(1, -310, 1, 90)}, 0.5)
        wait(0.5)
        MessageFrame:Destroy()
    end)

    return MessageFrame
end

return AnDiosUi
