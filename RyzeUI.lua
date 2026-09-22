local RyzeUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/RyzeCode/planecrazy/refs/heads/main/RyzeUI.lua"))()

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Window = RyzeUI:CreateWindow({ Name = "RyzeUI" })
local MiscTab = Window:CreateTab("MISC")

-- ============================
-- ESTADO
-- ============================
local flyEnabled = false
local flyActive = false
local flySpeed = 50
local flyKey = "E"

local noclipEnabled = false
local noclipActive = false
local noclipKey = "V"

-- ============================
-- FLY
-- ============================
MiscTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Order = 1,
    Callback = function(valor)
        flyEnabled = valor
        if not valor then
            flyActive = false
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

-- ============================
-- NOCLIP
-- ============================
MiscTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Order = 4,
    Callback = function(valor)
        noclipEnabled = valor
        if not valor then
            noclipActive = false
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

-- ============================
-- FLY: LÓGICA
-- ============================
RunService.RenderStepped:Connect(function()
    if not flyEnabled then return end

    local personaje = LocalPlayer.Character
    if not personaje then return end

    local hrp = personaje:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local cam = workspace.CurrentCamera
    if not cam then return end

    -- Si no está activo, desanclar
    if not flyActive then
        if hrp.Anchored then hrp.Anchored = false end
        return
    end

    -- Volar
    hrp.Anchored = true

    local velocidad = flySpeed / 10
    local direccion = Vector3.new(0, 0, 0)

    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        direccion = direccion + cam.CFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
        direccion = direccion - cam.CFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        direccion = direccion - cam.CFrame.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        direccion = direccion + cam.CFrame.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        direccion = direccion + Vector3.new(0, 1, 0)
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        direccion = direccion - Vector3.new(0, 1, 0)
    end

    if direccion.Magnitude > 0 then
        direccion = direccion.Unit * velocidad
        hrp.CFrame = hrp.CFrame + direccion
    end
end)

-- Tecla Fly (toggle: pulsar una vez ON, otra OFF)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    local nombre = input.UserInputType.Name
    if input.UserInputType == Enum.UserInputType.Keyboard then
        nombre = input.KeyCode.Name
    end

    -- Formatear clic izquierdo/derecho
    if input.UserInputType == Enum.UserInputType.MouseButton1 then nombre = "Clic Izquierdo" end
    if input.UserInputType == Enum.UserInputType.MouseButton2 then nombre = "Clic Derecho" end
    if input.UserInputType == Enum.UserInputType.MouseButton3 then nombre = "Clic Central" end

    if nombre == flyKey and flyEnabled then
        flyActive = not flyActive
    end
end)

-- ============================
-- NOCLIP: LÓGICA
-- ============================
local function aplicarNoclip()
    local personaje = LocalPlayer.Character
    if not personaje then return end
    for _, parte in ipairs(personaje:GetDescendants()) do
        if parte:IsA("BasePart") and parte.CanCollide then
            parte.CanCollide = false
        end
    end
end

local function quitarNoclip()
    local personaje = LocalPlayer.Character
    if not personaje then return end
    for _, parte in ipairs(personaje:GetDescendants()) do
        if parte:IsA("BasePart") then
            parte.CanCollide = true
        end
    end
end

RunService.Stepped:Connect(function()
    if noclipActive then
        aplicarNoclip()
    end
end)

-- Al respawnear, desactivamos todo
LocalPlayer.CharacterAdded:Connect(function()
    noclipActive = false
    flyActive = false
    task.wait(0.5)
    quitarNoclip()
end)

-- Tecla Noclip (toggle)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    local nombre = input.UserInputType.Name
    if input.UserInputType == Enum.UserInputType.Keyboard then
        nombre = input.KeyCode.Name
    end

    if input.UserInputType == Enum.UserInputType.MouseButton1 then nombre = "Clic Izquierdo" end
    if input.UserInputType == Enum.UserInputType.MouseButton2 then nombre = "Clic Derecho" end
    if input.UserInputType == Enum.UserInputType.MouseButton3 then nombre = "Clic Central" end

    if nombre == noclipKey and noclipEnabled then
        noclipActive = not noclipActive
        if not noclipActive then
            quitarNoclip()
        end
    end
end)

print("[RyzeUI] MISC cargado correctamente ✅")
