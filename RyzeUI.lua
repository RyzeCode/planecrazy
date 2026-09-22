-- RyzeUI.lua
-- Librería de UI + Lógica (Fly, Noclip, Build Scan/Paste/AutoBuild)
-- Autor: Ryze

local RyzeUI = {}

RyzeUI.Version = "1.0.0"
RyzeUI.Name = "RyzeUI"

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ============================
-- ESTADO GLOBAL (para limpieza)
-- ============================
local EstadoGlobal = {
    flyEnabled = false,
    flyActive = false,
    noclipEnabled = false,
    noclipActive = false,
    ghostFolder = nil,
}

-- ============================
-- FUNCIÓN DE LIMPIEZA GLOBAL
-- ============================
local function limpiarTodo()
    -- 1. Destruir plano fantasma
    if EstadoGlobal.ghostFolder then
        pcall(function() EstadoGlobal.ghostFolder:Destroy() end)
        EstadoGlobal.ghostFolder = nil
    end
    local ghost = workspace:FindFirstChild("RyzeUI_Ghost")
    if ghost then ghost:Destroy() end

    -- 2. Desactivar Fly (desanclar HRP)
    if LocalPlayer.Character then
        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            pcall(function() hrp.Anchored = false end)
        end
    end

    -- 3. Restaurar colisiones (Noclip)
    if LocalPlayer.Character then
        for _, parte in ipairs(LocalPlayer.Character:GetDescendants()) do
            if parte:IsA("BasePart") then
                pcall(function() parte.CanCollide = true end)
            end
        end
    end

    -- 4. Resetear estado
    EstadoGlobal.flyEnabled = false
    EstadoGlobal.flyActive = false
    EstadoGlobal.noclipEnabled = false
    EstadoGlobal.noclipActive = false

    -- 5. Destruir la UI
    local ui = game.CoreGui:FindFirstChild("RyzeUI_Screen")
    if ui then ui:Destroy() end

    print("[RyzeUI] Todo limpio ✅")
end

-- Exponer la función por si quieres llamarla manualmente
if getgenv then
    getgenv().RyzeUI_Limpiar = limpiarTodo
end

-- ============================
-- COLORES
-- ============================
local Colors = {
    Background   = Color3.fromRGB(35, 35, 40),
    TitleBar     = Color3.fromRGB(20, 60, 120),
    TabList      = Color3.fromRGB(35, 35, 40),
    TabActive    = Color3.fromRGB(55, 55, 65),
    TabInactive  = Color3.fromRGB(35, 35, 40),
    Content      = Color3.fromRGB(35, 35, 40),
    Button       = Color3.fromRGB(50, 50, 60),
    ButtonHover  = Color3.fromRGB(70, 70, 85),
    TextDark     = Color3.fromRGB(230, 230, 240),
    TextLight    = Color3.fromRGB(255, 255, 255),
    Bubble       = Color3.fromRGB(20, 60, 120),
    BubbleHover  = Color3.fromRGB(30, 90, 170),
    Border       = Color3.fromRGB(0, 0, 0),
    ToggleOn     = Color3.fromRGB(30, 144, 255),
    ToggleOff    = Color3.fromRGB(80, 80, 90),
    ToggleCircle = Color3.fromRGB(255, 255, 255),
    SliderFill   = Color3.fromRGB(30, 144, 255),
    SliderEmpty  = Color3.fromRGB(80, 80, 90),
    SliderKnob   = Color3.fromRGB(255, 255, 255),
    DropdownBg   = Color3.fromRGB(45, 45, 55),
    DropdownHover= Color3.fromRGB(70, 70, 85),
    Ghost        = Color3.fromRGB(100, 255, 100),
}

-- ============================
-- UTILIDAD
-- ============================
local function keyName(userInputType)
    if userInputType == Enum.UserInputType.MouseButton1 then return "Clic Izquierdo" end
    if userInputType == Enum.UserInputType.MouseButton2 then return "Clic Derecho" end
    if userInputType == Enum.UserInputType.MouseButton3 then return "Clic Central" end
    if userInputType == Enum.UserInputType.MouseWheel then return "Rueda" end
    local name = userInputType.Name
    name = name:gsub("Enum.UserInputType.", "")
    return name
end

-- ============================
-- CREAR VENTANA
-- ============================
function RyzeUI:CreateWindow(config)
    config = config or {}
    local windowName = config.Name or "RyzeUI"

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "RyzeUI_Screen"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = game.CoreGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 600, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    mainFrame.BackgroundColor3 = Colors.Background
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.ClipsDescendants = true
    mainFrame.Visible = true
    mainFrame.ZIndex = 5
    mainFrame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame

    local border = Instance.new("UIStroke")
    border.Color = Colors.Border
    border.Thickness = 2
    border.Parent = mainFrame

    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Colors.TitleBar
    titleBar.BorderSizePixel = 0
    titleBar.ZIndex = 6
    titleBar.Parent = mainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = titleBar

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -100, 1, 0)
    title.BackgroundTransparency = 1
    title.Text = windowName
    title.TextColor3 = Colors.TextLight
    title.TextSize = 18
    title.Font = Enum.Font.GothamBold
    title.ZIndex = 7
    title.Parent = titleBar

    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    minimizeBtn.Position = UDim2.new(1, -70, 0.5, -15)
    minimizeBtn.BackgroundTransparency = 1
    minimizeBtn.BorderSizePixel = 0
    minimizeBtn.Text = "—"
    minimizeBtn.TextColor3 = Colors.TextLight
    minimizeBtn.TextSize = 22
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.ZIndex = 7
    minimizeBtn.Parent = titleBar

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0.5, -15)
    closeBtn.BackgroundTransparency = 1
    closeBtn.BorderSizePixel = 0
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Colors.TextLight
    closeBtn.TextSize = 18
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.ZIndex = 7
    closeBtn.Parent = titleBar

    local divider = Instance.new("Frame")
    divider.Size = UDim2.new(1, 0, 0, 2)
    divider.Position = UDim2.new(0, 0, 0, 40)
    divider.BackgroundColor3 = Colors.Border
    divider.BorderSizePixel = 0
    divider.ZIndex = 6
    divider.Parent = mainFrame

    local tabList = Instance.new("Frame")
    tabList.Name = "TabList"
    tabList.Size = UDim2.new(0, 150, 1, -42)
    tabList.Position = UDim2.new(0, 0, 0, 42)
    tabList.BackgroundColor3 = Colors.TabList
    tabList.BorderSizePixel = 0
    tabList.ZIndex = 6
    tabList.Parent = mainFrame

    local verticalDivider = Instance.new("Frame")
    verticalDivider.Size = UDim2.new(0, 2, 1, -42)
    verticalDivider.Position = UDim2.new(0, 150, 0, 42)
    verticalDivider.BackgroundColor3 = Colors.Border
    verticalDivider.BorderSizePixel = 0
    verticalDivider.ZIndex = 6
    verticalDivider.Parent = mainFrame

    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, -152, 1, -42)
    contentFrame.Position = UDim2.new(0, 152, 0, 42)
    contentFrame.BackgroundColor3 = Colors.Content
    contentFrame.BorderSizePixel = 0
    contentFrame.ClipsDescendants = true
    contentFrame.ZIndex = 6
    contentFrame.Parent = mainFrame

    local bubble = Instance.new("TextButton")
    bubble.Name = "Bubble"
    bubble.Size = UDim2.new(0, 60, 0, 60)
    bubble.Position = UDim2.new(0.5, -30, 0, 10)
    bubble.AnchorPoint = Vector2.new(0, 0)
    bubble.BackgroundColor3 = Colors.Bubble
    bubble.BorderSizePixel = 0
    bubble.Text = "R"
    bubble.TextColor3 = Colors.TextLight
    bubble.TextSize = 32
    bubble.Font = Enum.Font.GothamBold
    bubble.Visible = false
    bubble.Active = true
    bubble.Parent = screenGui

    local bubbleCorner = Instance.new("UICorner")
    bubbleCorner.CornerRadius = UDim.new(1, 0)
    bubbleCorner.Parent = bubble

    local bubbleBorder = Instance.new("UIStroke")
    bubbleBorder.Color = Colors.Border
    bubbleBorder.Thickness = 2
    bubbleBorder.Parent = bubble

    local bubbleDragging = false
    local bubbleStartPos = nil
    local bubbleStartMouse = nil

    bubble.MouseEnter:Connect(function()
        bubble.BackgroundColor3 = Colors.BubbleHover
    end)
    bubble.MouseLeave:Connect(function()
        bubble.BackgroundColor3 = Colors.Bubble
    end)

    bubble.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            bubbleDragging = true
            bubbleStartPos = bubble.Position
            bubbleStartMouse = input.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not bubbleDragging then return end
        if input.UserInputType ~= Enum.UserInputType.MouseMovement
        and input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        local delta = input.Position - bubbleStartMouse
        if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
            bubble.Position = UDim2.new(
                bubbleStartPos.X.Scale, bubbleStartPos.X.Offset + delta.X,
                bubbleStartPos.Y.Scale, bubbleStartPos.Y.Offset + delta.Y
            )
        end
    end)

    bubble.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - bubbleStartMouse
            local seMovio = math.abs(delta.X) > 5 or math.abs(delta.Y) > 5

            bubbleDragging = false

            if not seMovio then
                bubble.Visible = false
                mainFrame.Visible = true
            end
        end
    end)

    minimizeBtn.MouseEnter:Connect(function()
        minimizeBtn.TextColor3 = Color3.fromRGB(180, 200, 230)
    end)
    minimizeBtn.MouseLeave:Connect(function()
        minimizeBtn.TextColor3 = Colors.TextLight
    end)
    minimizeBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
        bubble.Visible = true
    end)

    closeBtn.MouseEnter:Connect(function()
        closeBtn.TextColor3 = Color3.fromRGB(255, 120, 120)
    end)
    closeBtn.MouseLeave:Connect(function()
        closeBtn.TextColor3 = Colors.TextLight
    end)

    -- ✅ AL CERRAR: limpiar TODO
    closeBtn.MouseButton1Click:Connect(function()
        limpiarTodo()
    end)

    local Window = {}
    local tabs = {}

    function Window:CreateTab(tabName, icon)
        tabName = tabName or "Tab"

        local tabButton = Instance.new("TextButton")
        tabButton.Name = "Tab_" .. tabName
        tabButton.Size = UDim2.new(1, 0, 0, 35)
        tabButton.Position = UDim2.new(0, 0, 0, #tabs * 35)
        tabButton.BackgroundColor3 = Colors.TabInactive
        tabButton.BorderSizePixel = 0
        tabButton.Text = tabName
        tabButton.TextColor3 = Colors.TextDark
        tabButton.TextSize = 14
        tabButton.Font = Enum.Font.Gotham
        tabButton.ZIndex = 7
        tabButton.Parent = tabList

        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = "Content_" .. tabName
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.BackgroundTransparency = 1
        tabContent.BorderSizePixel = 0
        tabContent.ScrollBarThickness = 4
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabContent.Visible = false
        tabContent.ZIndex = 7
        tabContent.ClipsDescendants = true
        tabContent.Parent = contentFrame

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 6)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = tabContent

        local padding = Instance.new("UIPadding")
        padding.PaddingTop = UDim.new(0, 8)
        padding.PaddingLeft = UDim.new(0, 8)
        padding.PaddingRight = UDim.new(0, 8)
        padding.Parent = tabContent

        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabContent.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 40)
        end)

        local Tab = {}

        function Tab:CreateButton(buttonConfig)
            buttonConfig = buttonConfig or {}
            local buttonName = buttonConfig.Name or "Button"
            local callback = buttonConfig.Callback or function() end
            local order = buttonConfig.Order or 0

            local button = Instance.new("TextButton")
            button.Name = "Button_" .. buttonName
            button.Size = UDim2.new(1, -16, 0, 32)
            button.BackgroundColor3 = Colors.Button
            button.BorderSizePixel = 0
            button.Text = buttonName
            button.TextColor3 = Colors.TextDark
            button.TextSize = 14
            button.Font = Enum.Font.Gotham
            button.ZIndex = 8
            button.LayoutOrder = order
            button.Parent = tabContent

            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 6)
            btnCorner.Parent = button

            button.MouseEnter:Connect(function()
                button.BackgroundColor3 = Colors.ButtonHover
            end)
            button.MouseLeave:Connect(function()
                button.BackgroundColor3 = Colors.Button
            end)
            button.MouseButton1Click:Connect(function()
                pcall(callback)
            end)

            return button
        end

        function Tab:CreateToggle(toggleConfig)
            toggleConfig = toggleConfig or {}
            local toggleName = toggleConfig.Name or "Toggle"
            local currentValue = toggleConfig.CurrentValue or false
            local callback = toggleConfig.Callback or function() end
            local order = toggleConfig.Order or 0

            local toggle = Instance.new("TextButton")
            toggle.Name = "Toggle_" .. toggleName
            toggle.Size = UDim2.new(1, -16, 0, 32)
            toggle.BackgroundColor3 = Colors.Button
            toggle.BorderSizePixel = 0
            toggle.Text = toggleName
            toggle.TextColor3 = Colors.TextDark
            toggle.TextSize = 14
            toggle.Font = Enum.Font.Gotham
            toggle.TextXAlignment = Enum.TextXAlignment.Left
            toggle.ZIndex = 8
            toggle.LayoutOrder = order
            toggle.Parent = tabContent

            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 6)
            toggleCorner.Parent = toggle

            local paddingText = Instance.new("UIPadding")
            paddingText.PaddingLeft = UDim.new(0, 10)
            paddingText.Parent = toggle

            local indicator = Instance.new("Frame")
            indicator.Size = UDim2.new(0, 40, 0, 20)
            indicator.Position = UDim2.new(1, -50, 0.5, -10)
            indicator.BackgroundColor3 = currentValue and Colors.ToggleOn or Colors.ToggleOff
            indicator.BorderSizePixel = 0
            indicator.ZIndex = 9
            indicator.Parent = toggle

            local indCorner = Instance.new("UICorner")
            indCorner.CornerRadius = UDim.new(1, 0)
            indCorner.Parent = indicator

            local circle = Instance.new("Frame")
            circle.Size = UDim2.new(0, 16, 0, 16)
            circle.Position = currentValue and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
            circle.BackgroundColor3 = Colors.ToggleCircle
            circle.BorderSizePixel = 0
            circle.ZIndex = 10
            circle.Parent = indicator

            local circleCorner = Instance.new("UICorner")
            circleCorner.CornerRadius = UDim.new(1, 0)
            circleCorner.Parent = circle

            toggle.MouseButton1Click:Connect(function()
                currentValue = not currentValue
                indicator.BackgroundColor3 = currentValue and Colors.ToggleOn or Colors.ToggleOff
                circle.Position = currentValue and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                pcall(callback, currentValue)
            end)

            return toggle
        end

        function Tab:CreateSlider(sliderConfig)
            sliderConfig = sliderConfig or {}
            local sliderName = sliderConfig.Name or "Slider"
            local minValue = sliderConfig.Min or 0
            local maxValue = sliderConfig.Max or 100
            local currentValue = sliderConfig.CurrentValue or minValue
            local callback = sliderConfig.Callback or function() end
            local order = sliderConfig.Order or 0

            local container = Instance.new("TextButton")
            container.Size = UDim2.new(1, -16, 0, 50)
            container.BackgroundColor3 = Colors.Button
            container.BorderSizePixel = 0
            container.Text = ""
            container.AutoButtonColor = false
            container.ZIndex = 8
            container.LayoutOrder = order
            container.Parent = tabContent

            local contCorner = Instance.new("UICorner")
            contCorner.CornerRadius = UDim.new(0, 6)
            contCorner.Parent = container

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -80, 0, 20)
            label.Position = UDim2.new(0, 10, 0, 4)
            label.BackgroundTransparency = 1
            label.Text = sliderName
            label.TextColor3 = Colors.TextDark
            label.TextSize = 14
            label.Font = Enum.Font.Gotham
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.ZIndex = 9
            label.Parent = container

            local valueLabel = Instance.new("TextLabel")
            valueLabel.Size = UDim2.new(0, 70, 0, 20)
            valueLabel.Position = UDim2.new(1, -75, 0, 4)
            valueLabel.BackgroundTransparency = 1
            valueLabel.Text = tostring(currentValue)
            valueLabel.TextColor3 = Colors.TextDark
            valueLabel.TextSize = 14
            valueLabel.Font = Enum.Font.GothamBold
            valueLabel.TextXAlignment = Enum.TextXAlignment.Right
            valueLabel.ZIndex = 9
            valueLabel.Parent = container

            local bar = Instance.new("Frame")
            bar.Size = UDim2.new(1, -20, 0, 8)
            bar.Position = UDim2.new(0, 10, 1, -14)
            bar.BackgroundColor3 = Colors.SliderEmpty
            bar.BorderSizePixel = 0
            bar.ZIndex = 9
            bar.Parent = container

            local barCorner = Instance.new("UICorner")
            barCorner.CornerRadius = UDim.new(1, 0)
            barCorner.Parent = bar

            local fill = Instance.new("Frame")
            fill.Size = UDim2.new(0, 0, 1, 0)
            fill.BackgroundColor3 = Colors.SliderFill
            fill.BorderSizePixel = 0
            fill.ZIndex = 10
            fill.Parent = bar

            local fillCorner = Instance.new("UICorner")
            fillCorner.CornerRadius = UDim.new(1, 0)
            fillCorner.Parent = fill

            local knob = Instance.new("Frame")
            knob.Size = UDim2.new(0, 16, 0, 16)
            knob.Position = UDim2.new(0, -8, 0.5, -8)
            knob.BackgroundColor3 = Colors.SliderKnob
            knob.BorderSizePixel = 0
            knob.ZIndex = 11
            knob.Parent = bar

            local knobCorner = Instance.new("UICorner")
            knobCorner.CornerRadius = UDim.new(1, 0)
            knobCorner.Parent = knob

            local dragging = false

            local function actualizarDesdeX(inputX)
                local barAbsX = bar.AbsolutePosition.X
                local barAbsWidth = bar.AbsoluteSize.X
                if barAbsWidth <= 0 then return end

                local relative = math.clamp((inputX - barAbsX) / barAbsWidth, 0, 1)
                local newValue = math.floor(minValue + (maxValue - minValue) * relative + 0.5)

                currentValue = newValue
                fill.Size = UDim2.new(relative, 0, 1, 0)
                knob.Position = UDim2.new(relative, -8, 0.5, -8)
                valueLabel.Text = tostring(newValue)

                pcall(callback, newValue)
            end

            bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    actualizarDesdeX(input.Position.X)
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch) then
                    actualizarDesdeX(input.Position.X)
                end
            end)

            local initialRelative = (currentValue - minValue) / (maxValue - minValue)
            fill.Size = UDim2.new(initialRelative, 0, 1, 0)
            knob.Position = UDim2.new(initialRelative, -8, 0.5, -8)

            return container
        end

        function Tab:CreateDropdown(dropdownConfig)
            dropdownConfig = dropdownConfig or {}
            local dropdownName = dropdownConfig.Name or "Dropdown"
            local options = dropdownConfig.Options or {}
            local currentOption = dropdownConfig.CurrentOption or options[1]
            local callback = dropdownConfig.Callback or function() end
            local order = dropdownConfig.Order or 0

            local container = Instance.new("TextButton")
            container.Size = UDim2.new(1, -16, 0, 32)
            container.BackgroundColor3 = Colors.Button
            container.BorderSizePixel = 0
            container.Text = ""
            container.AutoButtonColor = false
            container.ZIndex = 8
            container.LayoutOrder = order
            container.Parent = tabContent

            local contCorner = Instance.new("UICorner")
            contCorner.CornerRadius = UDim.new(0, 6)
            contCorner.Parent = container

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -40, 1, 0)
            label.Position = UDim2.new(0, 10, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = dropdownName .. ": " .. tostring(currentOption)
            label.TextColor3 = Colors.TextDark
            label.TextSize = 14
            label.Font = Enum.Font.Gotham
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.ZIndex = 9
            label.Parent = container

            local arrow = Instance.new("TextLabel")
            arrow.Size = UDim2.new(0, 20, 1, 0)
            arrow.Position = UDim2.new(1, -25, 0, 0)
            arrow.BackgroundTransparency = 1
            arrow.Text = "▼"
            arrow.TextColor3 = Colors.TextDark
            arrow.TextSize = 12
            arrow.Font = Enum.Font.GothamBold
            arrow.ZIndex = 9
            arrow.Parent = container

            local optionList = Instance.new("Frame")
            optionList.Name = "OptionList_" .. dropdownName
            optionList.Size = UDim2.new(0, container.AbsoluteSize.X, 0, #options * 28)
            optionList.BackgroundColor3 = Colors.DropdownBg
            optionList.BorderSizePixel = 0
            optionList.Visible = false
            optionList.ZIndex = 100
            optionList.Parent = screenGui

            local listCorner = Instance.new("UICorner")
            listCorner.CornerRadius = UDim.new(0, 6)
            listCorner.Parent = optionList

            local listLayout = Instance.new("UIListLayout")
            listLayout.Parent = optionList

            for _, opt in ipairs(options) do
                local optButton = Instance.new("TextButton")
                optButton.Size = UDim2.new(1, 0, 0, 28)
                optButton.BackgroundColor3 = Colors.DropdownBg
                optButton.BorderSizePixel = 0
                optButton.Text = tostring(opt)
                optButton.TextColor3 = Colors.TextDark
                optButton.TextSize = 14
                optButton.Font = Enum.Font.Gotham
                optButton.ZIndex = 101
                optButton.Parent = optionList

                optButton.MouseEnter:Connect(function()
                    optButton.BackgroundColor3 = Colors.DropdownHover
                end)
                optButton.MouseLeave:Connect(function()
                    optButton.BackgroundColor3 = Colors.DropdownBg
                end)
                optButton.MouseButton1Click:Connect(function()
                    currentOption = opt
                    label.Text = dropdownName .. ": " .. tostring(opt)
                    optionList.Visible = false
                    pcall(callback, opt)
                end)
            end

            container.MouseButton1Click:Connect(function()
                if optionList.Visible then
                    optionList.Visible = false
                    return
                end

                local absPos = container.AbsolutePosition
                local absSize = container.AbsoluteSize
                local listHeight = #options * 28
                local screenHeight = screenGui.AbsoluteSize.Y

                optionList.Size = UDim2.new(0, absSize.X, 0, listHeight)

                if absPos.Y + absSize.Y + listHeight < screenHeight then
                    optionList.Position = UDim2.new(0, absPos.X, 0, absPos.Y + absSize.Y + 4)
                else
                    optionList.Position = UDim2.new(0, absPos.X, 0, absPos.Y - listHeight - 4)
                end

                optionList.Visible = true
            end)

            return container
        end

        function Tab:CreateKeybind(keybindConfig)
            keybindConfig = keybindConfig or {}
            local keybindName = keybindConfig.Name or "Keybind"
            local defaultKey = keybindConfig.DefaultKey or "F"
            local callback = keybindConfig.Callback or function() end
            local order = keybindConfig.Order or 0

            local currentKey = defaultKey

            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, -16, 0, 32)
            button.BackgroundColor3 = Colors.Button
            button.BorderSizePixel = 0
            button.Text = keybindName .. ": " .. tostring(currentKey)
            button.TextColor3 = Colors.TextDark
            button.TextSize = 14
            button.Font = Enum.Font.Gotham
            button.ZIndex = 8
            button.LayoutOrder = order
            button.Parent = tabContent

            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 6)
            btnCorner.Parent = button

            local esperando = false
            local tiempoActivacion = 0

            button.MouseButton1Click:Connect(function()
                if not esperando then
                    esperando = true
                    tiempoActivacion = tick()
                    button.Text = keybindName .. ": ..."
                end
            end)

            UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if not esperando then return end
                if tick() - tiempoActivacion < 0.2 then return end

                if input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.MouseWheel then
                    return
                end

                esperando = false

                local nombreBonito = keyName(input.UserInputType)
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    nombreBonito = input.KeyCode.Name
                end

                currentKey = nombreBonito
                button.Text = keybindName .. ": " .. tostring(currentKey)
                pcall(callback, currentKey, input)
            end)

            return button, function() return currentKey end
        end

        tabs[#tabs + 1] = { Button = tabButton, Content = tabContent }

        tabButton.MouseButton1Click:Connect(function()
            for _, t in ipairs(tabs) do
                t.Content.Visible = false
                t.Button.BackgroundColor3 = Colors.TabInactive
                t.Button.TextColor3 = Colors.TextDark
            end
            tabContent.Visible = true
            tabButton.BackgroundColor3 = Colors.TabActive
            tabButton.TextColor3 = Colors.TextDark
        end)

        if #tabs == 1 then
            tabContent.Visible = true
            tabButton.BackgroundColor3 = Colors.TabActive
            tabButton.TextColor3 = Colors.TextDark
        end

        return Tab
    end

    function Window:Destroy()
        limpiarTodo()
    end

    return Window
end

-- ============================
-- LÓGICA: BUILD Y MISC
-- ============================

local Window = RyzeUI:CreateWindow({ Name = "RyzeUI" })
local BuildTab = Window:CreateTab("BUILD")
local MiscTab = Window:CreateTab("MISC")

-- ============================
-- BUILD: SCAN, PASTE, AUTO BUILD, CLEAR
-- ============================
local scannedBuild = nil
local selectedTarget = nil

BuildTab:CreateDropdown({
    Name = "Target Player",
    Options = (function()
        local list = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                table.insert(list, p.Name)
            end
        end
        if #list == 0 then list = {"None"} end
        return list
    end)(),
    CurrentOption = "None",
    Order = 1,
    Callback = function(opt)
        selectedTarget = opt
        print("[RyzeUI] Jugador seleccionado:", opt)
    end
})

BuildTab:CreateButton({
    Name = "SCAN BUILD",
    Order = 2,
    Callback = function()
        if not selectedTarget or selectedTarget == "None" then
            return print("[RyzeUI] Selecciona un jugador primero")
        end

        local target = Players:FindFirstChild(selectedTarget)
        if not target then return print("[RyzeUI] Jugador no encontrado") end

        local aircraft = nil

        local playerAircraft = workspace:FindFirstChild("PlayerAircraft")
        if playerAircraft then
            aircraft = playerAircraft:FindFirstChild(target.Name)
        end

        if not aircraft then
            aircraft = workspace:FindFirstChild(target.Name .. " Aircraft")
        end

        if not aircraft then
            aircraft = workspace:FindFirstChild(target.Name)
        end

        if not aircraft then
            local buildZones = workspace:FindFirstChild("BuildingZones")
            if buildZones then
                for _, zona in ipairs(buildZones:GetChildren()) do
                    if zona.Name:find(target.Name) then
                        aircraft = zona:FindFirstChild("Aircraft")
                            or zona:FindFirstChild("Vehicle")
                            or zona:FindFirstChild(target.Name)
                        if aircraft then break end
                    end
                end
            end
        end

        if not aircraft then
            return print("[RyzeUI] No se encontró la nave de " .. target.Name)
        end

        print("[RyzeUI] Nave encontrada: " .. aircraft.Name .. " (" .. aircraft.ClassName .. ")")

        scannedBuild = {}
        scannedBuild.Origin = aircraft:GetPivot().Position
        scannedBuild.Parts = {}

        for _, part in ipairs(aircraft:GetDescendants()) do
            if part:IsA("BasePart") then
                table.insert(scannedBuild.Parts, {
                    Position = part.Position,
                    Size = part.Size,
                    Color = part.Color,
                    Material = part.Material,
                    CFrame = part.CFrame
                })
            end
        end

        print("[RyzeUI] Build escaneada: " .. #scannedBuild.Parts .. " bloques")
    end
})

BuildTab:CreateButton({
    Name = "PASTE (Mostrar Plano)",
    Order = 3,
    Callback = function()
        if not scannedBuild then
            return print("[RyzeUI] Primero escanea una build con SCAN BUILD")
        end

        if EstadoGlobal.ghostFolder then
            EstadoGlobal.ghostFolder:Destroy()
        end

        local ghostFolder = Instance.new("Folder")
        ghostFolder.Name = "RyzeUI_Ghost"
        ghostFolder.Parent = workspace
        EstadoGlobal.ghostFolder = ghostFolder

        local basePos
        if LocalPlayer.Character then
            basePos = LocalPlayer.Character:GetPivot().Position
        else
            basePos = Vector3.new(0, 0, 0)
        end

        for _, partData in ipairs(scannedBuild.Parts) do
            local ghostPart = Instance.new("Part")
            ghostPart.Size = partData.Size
            ghostPart.Color = Colors.Ghost
            ghostPart.Material = Enum.Material.ForceField
            ghostPart.Transparency = 0.5
            ghostPart.CanCollide = false
            ghostPart.Anchored = true
            ghostPart.Position = partData.Position - scannedBuild.Origin + basePos + Vector3.new(0, 5, 0)
            ghostPart.Parent = ghostFolder
        end

        print("[RyzeUI] Plano mostrado: " .. #scannedBuild.Parts .. " bloques fantasma")
    end
})

BuildTab:CreateButton({
    Name = "AUTO BUILD",
    Order = 4,
    Callback = function()
        if not scannedBuild or not selectedTarget then
            return print("[RyzeUI] Primero escanea una build con SCAN BUILD")
        end

        local target = Players:FindFirstChild(selectedTarget)
        if not target then return print("[RyzeUI] Jugador no encontrado") end

        local RS = game:GetService("ReplicatedStorage")
        local BuildFunctions
        local ok = pcall(function()
            BuildFunctions = require(RS.Modules.BuildFunctions)
        end)

        if not ok or not BuildFunctions then
            return print("[RyzeUI] No se pudo acceder a BuildFunctions. Usa el PASTE manual.")
        end

        local BuildZones = workspace:FindFirstChild("BuildingZones")
        local buildZone = nil
        if BuildZones then
            for _, zone in ipairs(BuildZones:GetChildren()) do
                if zone:FindFirstChild("Owner") and tostring(zone.Owner.Value) == target.Name then
                    buildZone = zone
                    break
                end
            end
        end

        if not buildZone then
            return print("[RyzeUI] No se encontró la Build Zone de " .. target.Name)
        end

        print("[RyzeUI] Iniciando AUTO BUILD de " .. target.Name .. "...")

        for index, partData in ipairs(scannedBuild.Parts) do
            local relativePos = partData.Position - scannedBuild.Origin

            local success = pcall(function()
                if BuildFunctions.PlaceBlock then
                    BuildFunctions.PlaceBlock(
                        relativePos,
                        partData.Size,
                        partData.CFrame,
                        partData.Color,
                        partData.Material,
                        buildZone
                    )
                end
            end)

            if success then
                print("[RyzeUI] Bloque " .. index .. "/" .. #scannedBuild.Parts .. " colocado")
            else
                warn("[RyzeUI] Error al colocar bloque " .. index)
            end

            task.wait(0.05)
        end

        print("[RyzeUI] AUTO BUILD completado ✅")
    end
})

BuildTab:CreateButton({
    Name = "CLEAR PASTE",
    Order = 5,
    Callback = function()
        if EstadoGlobal.ghostFolder then
            EstadoGlobal.ghostFolder:Destroy()
            EstadoGlobal.ghostFolder = nil
            print("[RyzeUI] Plano eliminado")
        end
        local ghost = workspace:FindFirstChild("RyzeUI_Ghost")
        if ghost then ghost:Destroy() end
    end
})

-- ============================
-- MISC: FLY Y NOCLIP
-- ============================
local flySpeed = 50
local flyKey = "E"
local noclipKey = "V"

MiscTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Order = 1,
    Callback = function(valor)
        EstadoGlobal.flyEnabled = valor
        if not valor then
            EstadoGlobal.flyActive = false
            if LocalPlayer.Character then
                local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then hrp.Anchored = false end
            end
        end
    end
})

MiscTab:CreateKeybind({
    Name = "Fly Key",
    DefaultKey = "E",
    Order = 2,
    Callback = function(nombre, input)
        flyKey = nombre
    end
})

MiscTab:CreateSlider({
    Name = "Fly Speed",
    Min = 1,
    Max = 100,
    CurrentValue = 50,
    Order = 3,
    Callback = function(valor)
        flySpeed = valor
    end
})

MiscTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Order = 4,
    Callback = function(valor)
        EstadoGlobal.noclipEnabled = valor
        if not valor then
            EstadoGlobal.noclipActive = false
            if LocalPlayer.Character then
                for _, parte in ipairs(LocalPlayer.Character:GetDescendants()) do
                    if parte:IsA("BasePart") then
                        pcall(function() parte.CanCollide = true end)
                    end
                end
            end
        end
    end
})

MiscTab:CreateKeybind({
    Name = "Noclip Key",
    DefaultKey = "V",
    Order = 5,
    Callback = function(nombre, input)
        noclipKey = nombre
    end
})

-- FLY: LÓGICA
RunService.RenderStepped:Connect(function()
    if not EstadoGlobal.flyEnabled then return end

    local personaje = LocalPlayer.Character
    if not personaje then return end

    local hrp = personaje:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local cam = workspace.CurrentCamera
    if not cam then return end

    if not EstadoGlobal.flyActive then
        if hrp.Anchored then hrp.Anchored = false end
        return
    end

    hrp.Anchored = true

    local velocidad = flySpeed / 10
    local direccion = Vector3.new(0, 0, 0)

    if UserInputService:IsKeyDown(Enum.KeyCode.W) then direccion = direccion + cam.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then direccion = direccion - cam.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then direccion = direccion - cam.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then direccion = direccion + cam.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direccion = direccion + Vector3.new(0, 1, 0) end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then direccion = direccion - Vector3.new(0, 1, 0) end

    if direccion.Magnitude > 0 then
        direccion = direccion.Unit * velocidad
        hrp.CFrame = hrp.CFrame + direccion
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    local nombre = input.UserInputType.Name
    if input.UserInputType == Enum.UserInputType.Keyboard then nombre = input.KeyCode.Name end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then nombre = "Clic Izquierdo" end
    if input.UserInputType == Enum.UserInputType.MouseButton2 then nombre = "Clic Derecho" end
    if input.UserInputType == Enum.UserInputType.MouseButton3 then nombre = "Clic Central" end

    if nombre == flyKey and EstadoGlobal.flyEnabled then
        EstadoGlobal.flyActive = not EstadoGlobal.flyActive
    end
end)

-- NOCLIP: LÓGICA
local function aplicarNoclip()
    local personaje = LocalPlayer.Character
    if not personaje then return end
    for _, parte in ipairs(personaje:GetDescendants()) do
        if parte:IsA("BasePart") and parte.CanCollide then
            parte.CanCollide = false
        end
    end
end

RunService.Stepped:Connect(function()
    if EstadoGlobal.noclipActive then
        aplicarNoclip()
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    EstadoGlobal.noclipActive = false
    EstadoGlobal.flyActive = false
    task.wait(0.5)
    if LocalPlayer.Character then
        for _, parte in ipairs(LocalPlayer.Character:GetDescendants()) do
            if parte:IsA("BasePart") then
                pcall(function() parte.CanCollide = true end)
            end
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    local nombre = input.UserInputType.Name
    if input.UserInputType == Enum.UserInputType.Keyboard then nombre = input.KeyCode.Name end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then nombre = "Clic Izquierdo" end
    if input.UserInputType == Enum.UserInputType.MouseButton2 then nombre = "Clic Derecho" end
    if input.UserInputType == Enum.UserInputType.MouseButton3 then nombre = "Clic Central" end

    if nombre == noclipKey and EstadoGlobal.noclipEnabled then
        EstadoGlobal.noclipActive = not EstadoGlobal.noclipActive
        if not EstadoGlobal.noclipActive and LocalPlayer.Character then
            for _, parte in ipairs(LocalPlayer.Character:GetDescendants()) do
                if parte:IsA("BasePart") then
                    pcall(function() parte.CanCollide = true end)
                end
            end
        end
    end
end)

print("[RyzeUI] Cargado correctamente ✅")
print("[RyzeUI] Para limpiar manualmente: getgenv().RyzeUI_Limpiar()")
