-- AnDiosUi Library
local AnDiosUi = {}

-- Create Main Menu
function AnDiosUi:CreateMenu(name)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = name
    ScreenGui.Parent = game.CoreGui
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    MainFrame.Parent = ScreenGui
    
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 50)
    Header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Header.Parent = MainFrame
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.BackgroundTransparency = 1
    Title.Text = name
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 24
    Title.Parent = Header

    -- Make MainFrame draggable
    local UIS = game:GetService("UserInputService")
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    self.MainFrame = MainFrame
    self.Tabs = {}
    self.CurrentTab = nil
end

-- Add Tab
function AnDiosUi:AddTab(name)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name .. "Tab"
    TabButton.Size = UDim2.new(0, 100, 0, 50)
    TabButton.Text = name
    TabButton.Parent = self.MainFrame.Header
    
    local TabContent = Instance.new("Frame")
    TabContent.Name = name .. "Content"
    TabContent.Size = UDim2.new(1, 0, 1, -50)
    TabContent.Position = UDim2.new(0, 0, 0, 50)
    TabContent.BackgroundTransparency = 1
    TabContent.Visible = false
    TabContent.Parent = self.MainFrame

    TabButton.MouseButton1Click:Connect(function()
        if self.CurrentTab then
            self.CurrentTab.Visible = false
        end
        TabContent.Visible = true
        self.CurrentTab = TabContent
    end)

    table.insert(self.Tabs, {Button = TabButton, Content = TabContent})
end

-- Rename Tab
function AnDiosUi:RenameTab(oldName, newName)
    for _, tab in ipairs(self.Tabs) do
        if tab.Button.Name == oldName .. "Tab" then
            tab.Button.Name = newName .. "Tab"
            tab.Button.Text = newName
            tab.Content.Name = newName .. "Content"
            break
        end
    end
end

return AnDiosUi
