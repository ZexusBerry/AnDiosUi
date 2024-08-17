local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local AnDiosUi = {}

-- Create a tween for UI element animations
local function CreateTween(object, properties, duration, easingStyle, easingDirection)
    local tweenInfo = TweenInfo.new(duration, easingStyle, easingDirection)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Arrange elements within a given tab
local function ArrangeElements(tab)
    local elements = tab:GetChildren()
    local yOffset = 10
    for _, element in ipairs(elements) do
        if element:IsA("Frame") or element:IsA("TextButton") or element:IsA("TextLabel") or element:IsA("TextBox") then
            element.Position = UDim2.new(0, 10, 0, yOffset)
            yOffset = yOffset + element.Size.Y.Offset + 10
        end
    end
    tab.Size = UDim2.new(1, 0, 0, yOffset)
end

-- Create the main window
function AnDiosUi:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.CoreGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Size = UDim2.new(0, 500, 0, 500)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -250)
    MainFrame.ClipsDescendants = true
    MainFrame.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    local Header = Instance.new("Frame")
    Header.Parent = MainFrame
    Header.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Header.Size = UDim2.new(1, 0, 0, 50)
    Header.Position = UDim2.new(0, 0, 0, 0)
    Header.BorderSizePixel = 0

    local Title = Instance.new("TextLabel")
    Title.Parent = Header
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 24
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = Header
    CloseButton.BackgroundTransparency = 1
    CloseButton.Size = UDim2.new(0, 50, 1, 0)
    CloseButton.Position = UDim2.new(1, -50, 0, 0)
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 0, 0)
    CloseButton.TextSize = 24

    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Parent = Header
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Size = UDim2.new(0, 50, 1, 0)
    MinimizeButton.Position = UDim2.new(1, -100, 0, 0)
    MinimizeButton.Font = Enum.Font.SourceSansBold
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 0)
    MinimizeButton.TextSize = 24

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local isMinimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            CreateTween(MainFrame, {Size = UDim2.new(0, 500, 0, 50)}, 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        else
            CreateTween(MainFrame, {Size = UDim2.new(0, 500, 0, 500)}, 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        end
    end)

    local TabFrame = Instance.new("Frame")
    TabFrame.Parent = MainFrame
    TabFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabFrame.Size = UDim2.new(0, 150, 1, -50)
    TabFrame.Position = UDim2.new(0, 0, 0, 50)
    TabFrame.BorderSizePixel = 0

    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabFrame
    TabList.SortOrder = Enum.SortOrder.LayoutOrder

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ContentFrame.Size = UDim2.new(1, -150, 1, -50)
    ContentFrame.Position = UDim2.new(0, 150, 0, 50)
    ContentFrame.BorderSizePixel = 0

    local ContentList = Instance.new("UIListLayout")
    ContentList.Parent = ContentFrame
    ContentList.SortOrder = Enum.SortOrder.LayoutOrder
    ContentList.Padding = UDim.new(0, 10)

    return {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        Header = Header,
        TabFrame = TabFrame,
        ContentFrame = ContentFrame
    }
end

-- Add a tab with a button to switch between content
function AnDiosUi:AddTab(gui, name)
    local TabButton = Instance.new("TextButton")
    TabButton.Parent = gui.TabFrame
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabButton.Size = UDim2.new(1, 0, 0, 50)
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 18
    TabButton.BorderSizePixel = 0

    local TabContent = Instance.new("Frame")
    TabContent.Parent = gui.ContentFrame
    TabContent.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.Visible = false
    TabContent.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = TabButton

    TabButton.MouseButton1Click:Connect(function()
        for _, child in ipairs(gui.ContentFrame:GetChildren()) do
            if child:IsA("Frame") then
                child.Visible = false
            end
        end
        TabContent.Visible = true
    end)

    ArrangeElements(gui.TabFrame)

    return TabContent
end

-- Add a label to a tab
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

-- Add a button to a tab
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

-- Add a message to a tab
function AnDiosUi:AddMessage(tab, message, duration)
    local MessageLabel = Instance.new("TextLabel")
    MessageLabel.Parent = tab
    MessageLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    MessageLabel.Size = UDim2.new(1, -20, 0, 30)
    MessageLabel.Font = Enum.Font.SourceSans
    MessageLabel.Text = message
    MessageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    MessageLabel.TextSize = 18
    MessageLabel.BorderSizePixel = 0
    MessageLabel.TextTransparency = 0
    MessageLabel.Visible = true

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = MessageLabel

    if duration then
        delay(duration, function()
            CreateTween(MessageLabel, {TextTransparency = 1}, 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            wait(0.5)
            MessageLabel:Destroy()
        end)
    end

    ArrangeElements(tab)

    return MessageLabel
end

return AnDiosUi
