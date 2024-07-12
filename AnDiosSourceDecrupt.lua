-- AnDiosUi Library

local TweenService = game:GetService("TweenService")
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
    local CloseButton = Instance.new("TextButton")
    local MinimizeButton = Instance.new("TextButton")
    
    ScreenGui.Name = "AnDiosUi"
    ScreenGui.Parent = game.CoreGui

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.ClipsDescendants = true
    
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(0, 400, 0, 50)
    Title.Font = Enum.Font.SourceSans
    Title.Text = title or "AnDiosUi"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 24

    TabsContainer.Name = "TabsContainer"
    TabsContainer.Parent = MainFrame
    TabsContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabsContainer.Position = UDim2.new(0, 0, 0.2, 0)
    TabsContainer.Size = UDim2.new(0, 400, 0, 250)

    UIListLayout.Parent = TabsContainer
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

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
        if MainFrame.Size == UDim2.new(0, 400, 0, 300) then
            TweenOut(MainFrame, {Size = UDim2.new(0, 400, 0, 50)}, 0.5)
        else
            TweenIn(MainFrame, {Size = UDim2.new(0, 400, 0, 300)}, 0.5)
        end
    end)

    return {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        Title = Title,
        TabsContainer = TabsContainer,
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

    return TabButton
end

-- Переименование вкладки
function AnDiosUi:RenameTab(tab, newName)
    if tab and newName then
        tab.Text = newName
        tab.Name = newName
    end
end

-- Изменение изображения вкладки
function AnDiosUi:SetTabImage(tab, imageId)
    if tab and tab:FindFirstChild("Image") then
        tab.Image.Image = "rbxassetid://" .. (imageId or "")
    end
end

-- Переключение между вкладками
function AnDiosUi:SwitchTab(tab)
    -- Логика переключения вкладок
end

-- Добавление кнопки на вкладку
function AnDiosUi:AddButton(tab, buttonText, callback)
    local Button = Instance.new("TextButton")

    Button.Name = buttonText or "Button"
    Button.Parent = tab
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Button.Size = UDim2.new(0, 100, 0, 30)
    Button.Font = Enum.Font.SourceSans
    Button.Text = buttonText or "Button"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 20

    Button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)

    return Button
end

-- Перемещение окна
function AnDiosUi:MakeDraggable(frame)
    local UIS = game:GetService("UserInputService")
    local dragging
    local dragInput
    local dragStart
    local startPos

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

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- Добавление метода SetTabImage в объект AnDiosUi
AnDiosUi.SetTabImage = SetTabImage

return AnDiosUi
