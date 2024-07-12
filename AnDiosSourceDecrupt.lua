-- AnDiosUi Library

local AnDiosUi = {}

-- Создание основного окна
function AnDiosUi:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local TabsContainer = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    
    ScreenGui.Name = "AnDiosUi"
    ScreenGui.Parent = game.CoreGui

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    
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

    return {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        Title = Title,
        TabsContainer = TabsContainer,
    }
end

-- Добавление вкладки
function AnDiosUi:AddTab(window, tabName)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabName or "Tab"
    TabButton.Parent = window.TabsContainer
    TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabButton.Size = UDim2.new(0, 100, 0, 30)
    TabButton.Font = Enum.Font.SourceSans
    TabButton.Text = tabName or "Tab"
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 20

    return TabButton
end

-- Переименование вкладки
function AnDiosUi:RenameTab(tab, newName)
    if tab and newName then
        tab.Text = newName
        tab.Name = newName
    end
end

-- Переключение между вкладками
function AnDiosUi:SwitchTab(tab)
    -- Логика переключения вкладок
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

return AnDiosUi
