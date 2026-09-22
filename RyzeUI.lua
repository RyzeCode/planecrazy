--========================================================
-- PLANE CRAZY - BUILD COPY SCRIPT (CORREGIDO COMPLETO)
-- Autor original: niikkzx
-- Correcciones: PlayerAircraft -> P1ayerAircraft
-- Parte 1/4: UI + Configuración inicial
--========================================================

if game.Players.LocalPlayer.PlayerGui:FindFirstChild("PlaneCrazy") then
    game.Players.LocalPlayer.PlayerGui:FindFirstChild("PlaneCrazy"):Destroy()
end

local plrCopy = ""
local plrbase = nil
local A_1 = nil
local A_2 = nil
local A_3 = nil
local children4 = 0
local A_4 = nil
local main = nil

local PlaneCrazy = Instance.new("ScreenGui")
local Progress = Instance.new("TextLabel")
local List = Instance.new("ScrollingFrame")
local UI = Instance.new("UIListLayout")
local Copy = Instance.new("TextButton")
local Cancel = Instance.new("TextButton")
local Sample = Instance.new("TextButton")
local PayerName = Instance.new("TextLabel")
local TEMPO = Instance.new("TextLabel")
PlaneCrazy.ResetOnSpawn = false

local sound1 = Instance.new("Sound")
sound1.Volume = 2
sound1.SoundId = "rbxassetid://140910216"
sound1.Parent = PlaneCrazy

local sound2 = Instance.new("Sound")
sound2.Volume = 0.5
sound2.SoundId = "rbxassetid://537744814"
sound2.Parent = PlaneCrazy

PayerName.Name = "PayerName"
PayerName.Parent = PlaneCrazy
PayerName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PayerName.BackgroundTransparency = 1.000
PayerName.Position = UDim2.new(0.416914403, 0, 0.655511796, 0)
PayerName.Size = UDim2.new(0, 191, 0, 27)
PayerName.Font = Enum.Font.SourceSansBold
PayerName.Text = "N/A"
PayerName.TextColor3 = Color3.fromRGB(0, 0, 0)
PayerName.TextScaled = true
PayerName.TextSize = 14.000
PayerName.TextWrapped = true

TEMPO.Name = "Time"
TEMPO.Parent = PlaneCrazy
TEMPO.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TEMPO.BackgroundTransparency = 1.000
TEMPO.Position = UDim2.new(0.417, 0, 0.813, 0)
TEMPO.Size = UDim2.new(0, 191, 0, 27)
TEMPO.Font = Enum.Font.SourceSansBold
TEMPO.Text = ""
TEMPO.TextColor3 = Color3.fromRGB(0, 0, 0)
TEMPO.TextScaled = true
TEMPO.TextSize = 14.000
TEMPO.TextWrapped = true

PlaneCrazy.Name = "PlaneCrazy"
PlaneCrazy.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
PlaneCrazy.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Progress.Name = "Progress"
Progress.Parent = PlaneCrazy
Progress.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Progress.Position = UDim2.new(0.340, 0, 0.725, 0)
Progress.Size = UDim2.new(0, 395, 0, 50)
Progress.Font = Enum.Font.SourceSansBold
Progress.Text = "1/1"
Progress.TextColor3 = Color3.fromRGB(0, 0, 0)
Progress.TextScaled = true
Progress.TextSize = 14.000
Progress.TextWrapped = true

List.Name = "List"
List.Parent = PlaneCrazy
List.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
List.Position = UDim2.new(0.060, 0, 0.10, 0)
List.Size = UDim2.new(0.135, 0, 0.325, 0)
List.ScrollBarThickness = 6

UI.Name = "UI"
UI.Parent = List
UI.SortOrder = Enum.SortOrder.LayoutOrder

Copy.Name = "Copy"
Copy.Parent = PlaneCrazy
Copy.BackgroundColor3 = Color3.fromRGB(26, 255, 0)
Copy.Position = UDim2.new(0.414821118, 0, 0.860236228, 0)
Copy.Size = UDim2.new(0, 200, 0, 50)
Copy.Font = Enum.Font.SourceSansBold
Copy.Text = "Copy"
Copy.TextColor3 = Color3.fromRGB(0, 0, 0)
Copy.TextScaled = true
Copy.TextSize = 14.000
Copy.TextWrapped = true
Copy.Visible = false

Cancel.Name = "Cancel"
Cancel.Parent = PlaneCrazy
Cancel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Cancel.Position = UDim2.new(0.414821118, 0, 0.860236228, 0)
Cancel.Size = UDim2.new(0, 200, 0, 50)
Cancel.Font = Enum.Font.SourceSansBold
Cancel.Text = "Cancel"
Cancel.TextColor3 = Color3.fromRGB(0, 0, 0)
Cancel.TextScaled = true
Cancel.TextSize = 14.000
Cancel.TextWrapped = true
Cancel.Visible = false

Sample.Name = "Sample"
Sample.Parent = PlaneCrazy
Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Sample.Size = UDim2.new(1, 0, 0, 20)
Sample.Visible = false
Sample.Font = Enum.Font.SourceSansBold
Sample.TextColor3 = Color3.fromRGB(0, 0, 0)
Sample.TextScaled = true
Sample.TextSize = 14.000
Sample.TextWrapped = true

local canceled = false

--========================================================
-- CANCEL BUTTON
--========================================================

Cancel.MouseButton1Click:Connect(function()
    canceled = true
    Progress.Text = "Canceled!"
    Cancel.Visible = false
    wait(0.261)
    List.Visible = true
    Copy.Visible = true
    if game.Workspace:FindFirstChild("CopiedBase") then
        for i,v in pairs(game.Workspace:GetChildren()) do
            if v.Name == "CopiedBase" then
                v:Destroy()
            end
        end
    end
end)

--========================================================
-- COPY BUTTON (CORREGIDO: P1ayerAircraft)
--========================================================

Copy.MouseButton1Click:Connect(function()
    canceled = false
    -- ✅ CORRECCIÓN: P1ayerAircraft en lugar de PlayerAircraft
    if workspace.P1ayerAircraft:FindFirstChild(plrCopy) then
        Cancel.Visible = true
        List.Visible = false
        Copy.Visible = false
        children4 = 0
        local Event = game:GetService("ReplicatedStorage").Remotes.DestroyAll
        Event:InvokeServer()

        if game.Workspace:FindFirstChild("CopiedBase") then
            for i,v in pairs(game.Workspace:GetChildren()) do
                if v.Name == "CopiedBase" then
                    v:Destroy()
                end
            end
        end

        -- ✅ CORRECCIÓN: P1ayerAircraft
        local PlayerAircraft = workspace.P1ayerAircraft:FindFirstChild(plrCopy):Clone()
        PlayerAircraft.Parent = workspace
        PlayerAircraft.Name = "CopiedBase"

        for i,v in pairs(game.Workspace.BuildingZones:GetChildren()) do
            if v.SurfaceGui.NameFrame.PlayerName.Text == plrCopy then
                plrbase = v
            end
        end

        for i,v in pairs(PlayerAircraft:GetChildren()) do
            if canceled == false then

                -- ✅ CORRECCIÓN: P1ayerAircraft
                workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart = nil

                workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).ChildAdded:Connect(function(blockColor)
                    if blockColor.Name == "BlockStd" then
                        workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart = blockColor:WaitForChild("BlockStd")
                    elseif blockColor.Name == "WedgeStd" then
                        workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart = blockColor:WaitForChild("WedgeStd")
                    elseif blockColor.Name == "BlockBeam2" then
                        workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart = blockColor:WaitForChild("BlockStd")
                    elseif blockColor.Name == "BlockBeam" then
                        workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart = blockColor:WaitForChild("BlockStd")
                    elseif blockColor.Name == "OffsetBlockStd" then
                        workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart = blockColor:WaitForChild("BlockStd")
                    elseif blockColor.Name == "CornerWedgeStd" then
                        workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart = blockColor:WaitForChild("CornerWedge")
                    elseif blockColor.Name == "InnerWedgeStd" then
                        workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart = blockColor:WaitForChild("triangle1x1")
                    elseif blockColor.Name == "PyramidWedge" then
                        workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart = blockColor:WaitForChild("Union")
                    elseif blockColor.Name == "Trianglestd" then
                        workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart = blockColor:WaitForChild("triangle1x1")
                    elseif blockColor.Name == "Wedge1x2" then
                        workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart = blockColor:WaitForChild("WedgeStd")
                    elseif blockColor.Name == "Wedge1x3" then
                        workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart = blockColor:WaitForChild("WedgeStd")
                    elseif blockColor.Name == "Wedge1x4" then
                        workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart = blockColor:WaitForChild("WedgeStd")
                    elseif blockColor.Name == "WedgeBeam" then
                        workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart = blockColor:WaitForChild("WedgeStd")
                    end
                end)

                if v:IsA("Model") then
                    local blockSelected = nil
                    local blockSelectedSize = nil
                    local childrens = nil
                    local children = v:GetChildren()

                    for i = 1, #children do
                        childrens = i
                    end

                    for _,x in pairs(v:GetChildren()) do
                        if x:IsA("Part") and x.Shape == Enum.PartType.Block then
                            x.Name = "Model"
                        elseif x:IsA("UnionOperation") then
                            if x:FindFirstChild("Light") then
                                x.Name = "Light"
                            else
                                x.Name = "Model"
                            end
                        elseif x:IsA("LocalScript") then
                            x.Name = "LocalScript"
                        elseif x:IsA("MeshPart") then
                            x.Name = "Model"
                        elseif x:IsA("WedgePart") then
                            x.Name = "Model"
                        end

                        if x:IsA("Part") and x.Parent:FindFirstChild("Events") and x.Parent.Events:FindFirstChild("Backward") and x:FindFirstChild("HingeConstraint") then
                            x.Name = "MotorBlock"
                        end

                        if x:IsA("Part") and x.Shape == Enum.PartType.Ball then
                            if x.Parent:FindFirstChild("HitBox") then
                                x.Parent.HitBox.Name = "HitBoxBall"
                                x.Name = "Model"
                            else
                                x.Name = "ModelCylinder"
                                x.Parent.Model.Name = "HitBoxBall"
                                x.Name = "Model"
                            end
                        end

                        if x:IsA("Part") and x:FindFirstChild("VectorForce") then
                            if x.Parent.PrimaryPart.Size == Vector3.new(0.05, 0.05, 0.05) then
                                v.PrimaryPart.Name = "Model"
                                x.Name = "Base"
                                blockSelected = x
                            else
                                x.Name = "Control"
                                v.PrimaryPart.Name = "Primary"
                                if x.Parent:FindFirstChild("Model") then
                                    x.Parent.Model.Name = "Base"
                                    x.Name = "Model"
                                else
                                    v.PrimaryPart.Name = "Model"
                                end
                            end
                        end

                        if x:IsA("MeshPart") then
                            if x.MeshId == "rbxassetid://5141379289" then
                                if x.Parent:FindFirstChild("HitBox") then
                                    x.Parent.HitBox.Name = "HitBoxLadder"
                                    x.Name = "Model"
                                else
                                    x.Name = "ModelLadder"
                                    if x.Parent:FindFirstChild("Model") then
                                        x.Parent.Model.Name = "HitBoxLadder"
                                    end
                                    x.Name = "Model"
                                end
                            end
                        end

                        if x:IsA("Part") and x.Shape == Enum.PartType.Cylinder and x.Size == Vector3.new(2.5, 5, 5) then
                            if x.Parent:FindFirstChild("HitBox") then
                                x.Parent.HitBox.Name = "HitBoxCylinder"
                                x.Name = "Model"
                            else
                                x.Name = "ModelBall"
                                if x.Parent:FindFirstChild("Model") then
                                    x.Parent.Model.Name = "HitBoxCylinder"
                                end
                                x.Name = "Model"
                            end
                        end

                        if x:FindFirstChild("EngineSound") and x:FindFirstChild("BodyThrust") then
                            if x:FindFirstChild("EngineSound").SoundId == "rbxassetid://9125477715" then
                                for ____,Engine in pairs(v:GetChildren()) do
                                    if Engine:IsA("Part") then
                                        if Engine:FindFirstChild("Mesh") then
                                            blockSelected = x
                                            blockSelectedSize = Engine
                                        end
                                    end
                                end
                                x.Name = "MotorEngine"
                            end
                        end

                        if x:IsA("Model") then
                            if x:FindFirstChild("Model") then
                                if x.Model:FindFirstChild("WedgeStd_Weld") or x.Model:FindFirstChild("Part_Weld") then
                                    x.Name = "HalfWedge2"
                                else
                                    x.Name = "Modelo"
                                end
                            else
                                x.Name = "Modelo"
                            end
                        end
                    end

                    for __,Spring in pairs(v:GetChildren()) do
                        if Spring:FindFirstChild("PrismaticConstraint") then
                            main = Spring
                            if Spring.Parent:FindFirstChild("Spring") then
                                main.PivotOffset = CFrame.new(0,-1,0)
                                local block = Instance.new("Part")
                                block.Parent = workspace
                                block.Name = "blockTest"
                                block.Color = Color3.fromRGB(255, 0, 0)
                                block.Size = Vector3.new(2.5, 2.5, 2.5)
                                block.Anchored = true
                                block.CFrame = main:GetPivot()

                                local X1 = block.CFrame.X - plrbase.CFrame.X
                                local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)

                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = main.CFrame
                                A_3 = 10
                                A_4 = ""

                                v.Model.PivotOffset = CFrame.new(0,0,0)
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                block:Destroy()
                            end
                        end
                    end

                    if childrens > 0 or v:FindFirstChild("ArrowOrientation") or v:FindFirstChild("Spring") or v:FindFirstChild("HalfWedge2") or v:FindFirstChild("ArrowOffset") or v:FindFirstChild("Configuration") or v:FindFirstChild("HitBoxBall") then
                        -- La lógica de bloques continúa en la Parte 3
                                                    --CornerWedge 1x1
                        if v.Model:IsA("CornerWedgePart") then
                            if v.Model.Size == Vector3.new(2.5,2.5,2.5) then
                                local X1 = v.Model.CFrame.X - plrbase.CFrame.X
                                local Y1 = v.Model.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = v.Model.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 14
                                A_4 = ""
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                local A_7 = v.Model.Color
                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                Event2:FireServer(A_6, A_7)
                            end

                        elseif v.Model:IsA("MeshPart") then
                            if v.Model.MeshId == "rbxassetid://5100568015" then
                                local X1 = v.Model.CFrame.X - plrbase.CFrame.X
                                local Y1 = v.Model.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = v.Model.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 89
                                A_4 = ""
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                local A_7 = v.Model.Color
                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                Event2:FireServer(A_6, A_7)

                            elseif v.Model.MeshId == "rbxassetid://5141379289" then
                                v.Model.PivotOffset = CFrame.new(-1.05, 0, 0)
                                local block = Instance.new("Part")
                                block.Parent = workspace
                                block.Name = "blockTest"
                                block.Color = Color3.fromRGB(255, 0, 0)
                                block.Size = Vector3.new(2.5, 2.5, 2.5)
                                block.CFrame = v.Model:GetPivot()
                                local X1 = block.CFrame.X - plrbase.CFrame.X
                                local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 176
                                A_4 = ""
                                v.Model.PivotOffset = CFrame.new(0,0,0)
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                block:Destroy()
                                Event:InvokeServer(A_1, A_2, A_3, A_4)

                            elseif v.Model.MeshId == "rbxassetid://5099674343" then
                                if v.Model.Size == Vector3.new(2.5,2.5,2.5) then
                                    local X1 = v.Model.CFrame.X - plrbase.CFrame.X
                                    local Y1 = v.Model.CFrame.Y - plrbase.CFrame.Y
                                    local Z1 = v.Model.CFrame.Z - plrbase.CFrame.Z
                                    local X = math.round(X1 / 2.5)
                                    local Y = math.round(Y1 / 2.5)
                                    local Z = math.round(Z1 / 2.5)
                                    A_1 = Vector3.new(X, Y, Z)
                                    A_2 = v.Model.CFrame
                                    A_3 = 51
                                    A_4 = ""
                                    Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                    Event:InvokeServer(A_1, A_2, A_3, A_4)
                                    local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                    local A_7 = v.Model.Color
                                    local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                    Event2:FireServer(A_6, A_7)

                                elseif v.Model.Size == Vector3.new(2.5, 2.5, 7.5) then
                                    v.Model.PivotOffset = CFrame.new(0,0,-2.5)
                                    local block = Instance.new("Part")
                                    block.Parent = workspace
                                    block.Name = "blockTest"
                                    block.Color = Color3.fromRGB(255, 0, 0)
                                    block.Size = Vector3.new(2.5, 2.5, 2.5)
                                    block.CFrame = v.Model:GetPivot()
                                    local X1 = block.CFrame.X - plrbase.CFrame.X
                                    local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                    local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                    local X = math.round(X1 / 2.5)
                                    local Y = math.round(Y1 / 2.5)
                                    local Z = math.round(Z1 / 2.5)
                                    A_1 = Vector3.new(X, Y, Z)
                                    A_2 = v.Model.CFrame
                                    A_3 = 101
                                    A_4 = ""
                                    v.Model.PivotOffset = CFrame.new(0,0,0)
                                    Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                    Event:InvokeServer(A_1, A_2, A_3, A_4)
                                    block:Destroy()
                                    Event:InvokeServer(A_1, A_2, A_3, A_4)

                                elseif v.Model.Size == Vector3.new(2.5, 2.5, 5) then
                                    v.Model.PivotOffset = CFrame.new(0,0,-1.25)
                                    local block = Instance.new("Part")
                                    block.Parent = workspace
                                    block.Name = "blockTest"
                                    block.Color = Color3.fromRGB(255, 0, 0)
                                    block.Size = Vector3.new(2.5, 2.5, 2.5)
                                    block.CFrame = v.Model:GetPivot()
                                    local X1 = block.CFrame.X - plrbase.CFrame.X
                                    local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                    local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                    local X = math.round(X1 / 2.5)
                                    local Y = math.round(Y1 / 2.5)
                                    local Z = math.round(Z1 / 2.5)
                                    A_1 = Vector3.new(X, Y, Z)
                                    A_2 = v.Model.CFrame
                                    A_3 = 76
                                    A_4 = ""
                                    v.Model.PivotOffset = CFrame.new(0,0,0)
                                    Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                    Event:InvokeServer(A_1, A_2, A_3, A_4)
                                    block:Destroy()
                                    Event:InvokeServer(A_1, A_2, A_3, A_4)

                                elseif v.Model.Size == Vector3.new(2.5, 2.5, 10) then
                                    v.Model.PivotOffset = CFrame.new(0,0,-3.75)
                                    local block = Instance.new("Part")
                                    block.Parent = workspace
                                    block.Name = "blockTest"
                                    block.Color = Color3.fromRGB(255, 0, 0)
                                    block.Size = Vector3.new(2.5, 2.5, 2.5)
                                    block.CFrame = v.Model:GetPivot()
                                    local X1 = block.CFrame.X - plrbase.CFrame.X
                                    local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                    local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                    local X = math.round(X1 / 2.5)
                                    local Y = math.round(Y1 / 2.5)
                                    local Z = math.round(Z1 / 2.5)
                                    A_1 = Vector3.new(X, Y, Z)
                                    A_2 = v.Model.CFrame
                                    A_3 = 102
                                    A_4 = ""
                                    v.Model.PivotOffset = CFrame.new(0,0,0)
                                    Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                    Event:InvokeServer(A_1, A_2, A_3, A_4)
                                    block:Destroy()
                                end

                            elseif v.Model.MeshId == "rbxassetid://5100271873" then
                                local X1 = v.Model.CFrame.X - plrbase.CFrame.X
                                local Y1 = v.Model.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = v.Model.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 117
                                A_4 = ""
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)

                            elseif v.Model.MeshId == "rbxassetid://5100011495" then
                                local X1 = v.Model.CFrame.X - plrbase.CFrame.X
                                local Y1 = v.Model.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = v.Model.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 118
                                A_4 = ""
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                            end
                        end
                                                    elseif v.Model.MeshId == "rbxassetid://5099810267" then
                            if v.Model.Size == Vector3.new(2.5,2.5,2.5) then
                                local X1 = v.Model.CFrame.X - plrbase.CFrame.X
                                local Y1 = v.Model.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = v.Model.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 94
                                A_4 = ""
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                            elseif v.Model.Size == Vector3.new(2.5, 2.5, 7.5) then
                                v.Model.PivotOffset = CFrame.new(0,0,-2.5)
                                local block = Instance.new("Part")
                                block.Parent = workspace
                                block.Name = "blockTest"
                                block.Color = Color3.fromRGB(255, 0, 0)
                                block.Size = Vector3.new(2.5, 2.5, 2.5)
                                block.CFrame = v.Model:GetPivot()
                                local X1 = block.CFrame.X - plrbase.CFrame.X
                                local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 115
                                A_4 = ""
                                v.Model.PivotOffset = CFrame.new(0,0,0)
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                block:Destroy()
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                            elseif v.Model.Size == Vector3.new(2.5, 2.5, 5) then
                                v.Model.PivotOffset = CFrame.new(0,0,-1.25)
                                local block = Instance.new("Part")
                                block.Parent = workspace
                                block.Name = "blockTest"
                                block.Color = Color3.fromRGB(255, 0, 0)
                                block.Size = Vector3.new(2.5, 2.5, 2.5)
                                block.CFrame = v.Model:GetPivot()
                                local X1 = block.CFrame.X - plrbase.CFrame.X
                                local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 114
                                A_4 = ""
                                v.Model.PivotOffset = CFrame.new(0,0,0)
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                block:Destroy()
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                            elseif v.Model.Size == Vector3.new(2.5, 2.5, 10) then
                                v.Model.PivotOffset = CFrame.new(0,0,-3.75)
                                local block = Instance.new("Part")
                                block.Parent = workspace
                                block.Name = "blockTest"
                                block.Color = Color3.fromRGB(255, 0, 0)
                                block.Size = Vector3.new(2.5, 2.5, 2.5)
                                block.CFrame = v.Model:GetPivot()
                                local X1 = block.CFrame.X - plrbase.CFrame.X
                                local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 116
                                A_4 = ""
                                v.Model.PivotOffset = CFrame.new(0,0,0)
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                block:Destroy()
                            end

                        elseif v.Model.MeshId == "rbxassetid://5104102003" then
                            if v.Model.Size == Vector3.new(2.5, 1.25, 2.5) then
                                v.Model.PivotOffset = CFrame.new(0,-0.625,0)
                                local block = Instance.new("Part")
                                block.Parent = workspace
                                block.Name = "blockTest"
                                block.Color = Color3.fromRGB(255, 0, 0)
                                block.Size = Vector3.new(2.5, 2.5, 2.5)
                                block.CFrame = v.Model:GetPivot()
                                local X1 = block.CFrame.X - plrbase.CFrame.X
                                local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 67
                                A_4 = ""
                                v.Model.PivotOffset = CFrame.new(0,0,0)
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                block:Destroy()
                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                local A_7 = Color3.new(v.Model.Color.R,v.Model.Color.G,v.Model.Color.B)
                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                Event2:FireServer(A_6, A_7)
                            end

                        elseif v.Model.MeshId == "rbxassetid://5103725949" then
                            if v.Model.Size == Vector3.new(2.5, 1.25, 2.5) then
                                v.Model.PivotOffset = CFrame.new(0,-0.625,0)
                                local block = Instance.new("Part")
                                block.Parent = workspace
                                block.Name = "blockTest"
                                block.Color = Color3.fromRGB(255, 0, 0)
                                block.Size = Vector3.new(2.5, 2.5, 2.5)
                                block.CFrame = v.Model:GetPivot()
                                local X1 = block.CFrame.X - plrbase.CFrame.X
                                local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 66
                                A_4 = ""
                                v.Model.PivotOffset = CFrame.new(0,0,0)
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                block:Destroy()
                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                local A_7 = Color3.new(v.Model.Color.R,v.Model.Color.G,v.Model.Color.B)
                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                Event2:FireServer(A_6, A_7)
                            end

                        elseif v.Model.MeshId == "rbxassetid://5100251191" then
                            if v.Model.Size == Vector3.new(2.5, 1.25, 2.5) then
                                v.Model.PivotOffset = CFrame.new(0,0.625,0)
                                local block = Instance.new("Part")
                                block.Parent = workspace
                                block.Name = "blockTest"
                                block.Color = Color3.fromRGB(255, 0, 0)
                                block.Size = Vector3.new(2.5, 2.5, 2.5)
                                block.CFrame = v.Model:GetPivot()
                                local X1 = block.CFrame.X - plrbase.CFrame.X
                                local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 172
                                A_4 = ""
                                v.Model.PivotOffset = CFrame.new(0,0,0)
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                block:Destroy()
                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                local A_7 = Color3.new(v.Model.Color.R,v.Model.Color.G,v.Model.Color.B)
                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                Event2:FireServer(A_6, A_7)
                            end

                        elseif v.Model.MeshId == "rbxassetid://5100289988" then
                            if v.Model.Size == Vector3.new(2.5, 2.5, 2.5) then
                                local X1 = v.Model.CFrame.X - plrbase.CFrame.X
                                local Y1 = v.Model.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = v.Model.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 119
                                A_4 = ""
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                            end

                        elseif v.Model.MeshId == "rbxassetid://5099654065" then
                            if v.Model.Size == Vector3.new(2.5, 1.25, 2.5) then
                                v.Model.PivotOffset = CFrame.new(0,-0.625,0)
                                local block = Instance.new("Part")
                                block.Parent = workspace
                                block.Name = "blockTest"
                                block.Color = Color3.fromRGB(255, 0, 0)
                                block.Size = Vector3.new(2.5, 2.5, 2.5)
                                block.CFrame = v.Model:GetPivot()
                                local X1 = block.CFrame.X - plrbase.CFrame.X
                                local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 46
                                A_4 = ""
                                v.Model.PivotOffset = CFrame.new(0,0,0)
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                block:Destroy()
                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                local A_7 = Color3.new(v.Model.Color.R,v.Model.Color.G,v.Model.Color.B)
                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                Event2:FireServer(A_6, A_7)
                            elseif v.Model.Size == Vector3.new(2.5, 1.25, 5) then
                                v.Model.PivotOffset = CFrame.new(0,-0.625,-1.25)
                                local block = Instance.new("Part")
                                block.Parent = workspace
                                block.Name = "blockTest"
                                block.Color = Color3.fromRGB(255, 0, 0)
                                block.Size = Vector3.new(2.5, 2.5, 2.5)
                                block.CFrame = v.Model:GetPivot()
                                local X1 = block.CFrame.X - plrbase.CFrame.X
                                local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 86
                                A_4 = ""
                                v.Model.PivotOffset = CFrame.new(0,0,0)
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                block:Destroy()
                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                local A_7 = Color3.new(v.Model.Color.R,v.Model.Color.G,v.Model.Color.B)
                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                Event2:FireServer(A_6, A_7)
                            end
                        end
                                            elseif v:FindFirstChild("Light") then
                        for ________,LIGHT in pairs(v:GetChildren()) do
                            if LIGHT:IsA("Part") then
                                if LIGHT.Size == Vector3.new(2.5,2.5,2.5) then
                                    local X1 = LIGHT.CFrame.X - plrbase.CFrame.X
                                    local Y1 = LIGHT.CFrame.Y - plrbase.CFrame.Y
                                    local Z1 = LIGHT.CFrame.Z - plrbase.CFrame.Z
                                    local X = math.round(X1 / 2.5)
                                    local Y = math.round(Y1 / 2.5)
                                    local Z = math.round(Z1 / 2.5)
                                    A_1 = Vector3.new(X, Y, Z)
                                    A_2 = LIGHT.CFrame
                                    A_3 = 77
                                    A_4 = ""
                                    Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                    Event:InvokeServer(A_1, A_2, A_3, A_4)
                                end
                            end
                        end

                    elseif v.Model:IsA("UnionOperation") then
                        if v:FindFirstChild("Light") then
                        else
                            if v.Model.Size.X > 2.4 and v.Model.Size.Y > 2.4 and v.Model.Size.Z > 2.5 and v.Model.Size.X < 2.6 and v.Model.Size.Y < 2.6 and v.Model.Size.Z < 2.6 then
                                local X1 = v.Model.CFrame.X - plrbase.CFrame.X
                                local Y1 = v.Model.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = v.Model.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 71
                                A_4 = ""
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                local A_7 = Color3.new(v.Model.Color.R,v.Model.Color.G,v.Model.Color.B)
                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                Event2:FireServer(A_6, A_7)
                            end
                        end

                    elseif v.Model:IsA("WedgePart") then
                        --Wedge 1x1
                        if v.Model.Size == Vector3.new(2.5,2.5,2.5) then
                            local X1 = v.Model.CFrame.X - plrbase.CFrame.X
                            local Y1 = v.Model.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = v.Model.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.Model.CFrame
                            A_3 = 7
                            A_4 = ""
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)
                            local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                            local A_7 = Color3.new(v.Model.Color.R,v.Model.Color.G,v.Model.Color.B)
                            local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                            Event2:FireServer(A_6, A_7)

                        elseif v.Model.Size == Vector3.new(0.4, 2.5, 2.5) then
                            local X1 = v.Model.CFrame.X - plrbase.CFrame.X
                            local Y1 = v.Model.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = v.Model.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.Model.CFrame
                            A_3 = 44
                            A_4 = ""
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)
                            local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                            local A_7 = Color3.new(v.Model.Color.R,v.Model.Color.G,v.Model.Color.B)
                            local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                            Event2:FireServer(A_6, A_7)

                        elseif v.Model.Size == Vector3.new(1.25, 2.5, 2.5) then
                            v.Model.PivotOffset = CFrame.new(-0.625,0,0)
                            local block = Instance.new("Part")
                            block.Parent = workspace
                            block.Name = "blockTest"
                            block.Color = Color3.fromRGB(255, 0, 0)
                            block.Size = Vector3.new(2.5, 2.5, 2.5)
                            block.CFrame = v.Model:GetPivot()
                            local X1 = block.CFrame.X - plrbase.CFrame.X
                            local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.Model.CFrame
                            A_3 = 68
                            A_4 = ""
                            v.Model.PivotOffset = CFrame.new(0,0,0)
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)
                            block:Destroy()
                            local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                            local A_7 = Color3.new(v.Model.Color.R,v.Model.Color.G,v.Model.Color.B)
                            local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                            Event2:FireServer(A_6, A_7)

                        elseif v.Model.Size == Vector3.new(2.5, 1.25, 2.5) then
                            v.Model.PivotOffset = CFrame.new(0,-0.625,0)
                            local block = Instance.new("Part")
                            block.Parent = workspace
                            block.Name = "blockTest"
                            block.Color = Color3.fromRGB(255, 0, 0)
                            block.Size = Vector3.new(2.5, 2.5, 2.5)
                            block.CFrame = v.Model:GetPivot()
                            local X1 = block.CFrame.X - plrbase.CFrame.X
                            local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.Model.CFrame
                            A_3 = 45
                            A_4 = ""
                            v.Model.PivotOffset = CFrame.new(0,0,0)
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)
                            block:Destroy()
                            local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                            local A_7 = Color3.new(v.Model.Color.R,v.Model.Color.G,v.Model.Color.B)
                            local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                            Event2:FireServer(A_6, A_7)

                        elseif v.Model.Size == Vector3.new(2.5, 1.25, 1.25) then
                            v.Model.PivotOffset = CFrame.new(0, 0.625, -0.625)
                            local block = Instance.new("Part")
                            block.Parent = workspace
                            block.Name = "blockTest"
                            block.Color = Color3.fromRGB(255, 0, 0)
                            block.Size = Vector3.new(2.5, 2.5, 2.5)
                            block.CFrame = v.Model:GetPivot()
                            local X1 = block.CFrame.X - plrbase.CFrame.X
                            local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.Model.CFrame
                            A_3 = 70
                            A_4 = ""
                            v.Model.PivotOffset = CFrame.new(0,0,0)
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)
                            block:Destroy()
                            local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                            local A_7 = Color3.new(v.Model.Color.R,v.Model.Color.G,v.Model.Color.B)
                            local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                            Event2:FireServer(A_6, A_7)

                        elseif v.Model.Size == Vector3.new(2.5, 2.5, 5) then
                            v.Model.PivotOffset = CFrame.new(0,0,-1.25)
                            local block = Instance.new("Part")
                            block.Parent = workspace
                            block.Name = "blockTest"
                            block.Color = Color3.fromRGB(255, 0, 0)
                            block.Size = Vector3.new(2.5, 2.5, 2.5)
                            block.CFrame = v.Model:GetPivot()
                            local X1 = block.CFrame.X - plrbase.CFrame.X
                            local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.Model.CFrame
                            A_3 = 17
                            A_4 = ""
                            v.Model.PivotOffset = CFrame.new(0,0,0)
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)
                            block:Destroy()
                            local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                            local A_7 = Color3.new(v.Model.Color.R,v.Model.Color.G,v.Model.Color.B)
                            local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                            Event2:FireServer(A_6, A_7)

                        elseif v.Model.Size == Vector3.new(0.4, 5, 2.5) then
                            v.Model.PivotOffset = CFrame.new(0,-1.25,0)
                            local block = Instance.new("Part")
                            block.Parent = workspace
                            block.Name = "blockTest"
                            block.Color = Color3.fromRGB(255, 0, 0)
                            block.Size = Vector3.new(2.5, 2.5, 2.5)
                            block.CFrame = v.Model:GetPivot()
                            local X1 = block.CFrame.X - plrbase.CFrame.X
                            local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.Model.CFrame
                            A_3 = 8
                            A_4 = ""
                            v.Model.PivotOffset = CFrame.new(0,0,0)
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)
                            block:Destroy()
                            local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                            local A_7 = Color3.new(v.Model.Color.R,v.Model.Color.G,v.Model.Color.B)
                            local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                            Event2:FireServer(A_6, A_7)

                        elseif v.Model.Size == Vector3.new(0.4, 7.5, 2.5) then
                            v.Model.PivotOffset = CFrame.new(0,-2.5,0)
                            local block = Instance.new("Part")
                            block.Parent = workspace
                            block.Name = "blockTest"
                            block.Color = Color3.fromRGB(255, 0, 0)
                            block.Size = Vector3.new(2.5, 2.5, 2.5)
                            block.CFrame = v.Model:GetPivot()
                            local X1 = block.CFrame.X - plrbase.CFrame.X
                            local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.Model.CFrame
                            A_3 = 37
                            A_4 = ""
                            v.Model.PivotOffset = CFrame.new(0,0,0)
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)
                            block:Destroy()
                            local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                            local A_7 = Color3.new(v.Model.Color.R,v.Model.Color.G,v.Model.Color.B)
                            local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                            Event2:FireServer(A_6, A_7)

                        elseif v.Model.Size == Vector3.new(0.4, 10, 2.5) then
                            v.Model.PivotOffset = CFrame.new(0,-2.5,0)
                            local block = Instance.new("Part")
                            block.Parent = workspace
                            block.Name = "blockTest"
                            block.Color = Color3.fromRGB(255, 0, 0)
                            block.Size = Vector3.new(2.5, 2.5, 2.5)
                            block.CFrame = v.Model:GetPivot()
                            local X1 = block.CFrame.X - plrbase.CFrame.X
                            local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.Model.CFrame
                            A_3 = 29
                            A_4 = ""
                            v.Model.PivotOffset = CFrame.new(0,0,0)
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)
                            block:Destroy()
                            local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                            local A_7 = Color3.new(v.Model.Color.R,v.Model.Color.G,v.Model.Color.B)
                            local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                            Event2:FireServer(A_6, A_7)

                        elseif v.Model.Size == Vector3.new(2.5, 1.25, 5) then
                            v.Model.PivotOffset = CFrame.new(0,-0.625,-1.25)
                            local block = Instance.new("Part")
                            block.Parent = workspace
                            block.Name = "blockTest"
                            block.Color = Color3.fromRGB(255, 0, 0)
                            block.Size = Vector3.new(2.5, 2.5, 2.5)
                            block.CFrame = v.Model:GetPivot()
                            local X1 = block.CFrame.X - plrbase.CFrame.X
                            local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.Model.CFrame
                            A_3 = 85
                            A_4 = ""
                            v.Model.PivotOffset = CFrame.new(0,0,0)
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)
                            block:Destroy()
                            local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                            local A_7 = Color3.new(v.Model.Color.R,v.Model.Color.G,v.Model.Color.B)
                            local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                            Event2:FireServer(A_6, A_7)

                        elseif v.Model.Size == Vector3.new(10, 2.5, 2.5) then
                            v.Model.PivotOffset = CFrame.new(-3.75, 0, 0)
                            local block = Instance.new("Part")
                            block.Parent = workspace
                            block.Name = "blockTest"
                            block.Color = Color3.fromRGB(255, 0, 0)
                            block.Size = Vector3.new(2.5, 2.5, 2.5)
                            block.CFrame = v.Model:GetPivot()
                            local X1 = block.CFrame.X - plrbase.CFrame.X
                            local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.Model.CFrame
                            A_3 = 110
                            A_4 = ""
                            v.Model.PivotOffset = CFrame.new(0,0,0)
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)
                            block:Destroy()
                            local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                            local A_7 = Color3.new(v.Model.Color.R,v.Model.Color.G,v.Model.Color.B)
                            local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                            Event2:FireServer(A_6, A_7)

                        elseif v.Model.Size == Vector3.new(2.5, 2.5, 7.5) then
                            v.Model.PivotOffset = CFrame.new(0,0,-2.50)
                            local block = Instance.new("Part")
                            block.Parent = workspace
                            block.Name = "blockTest"
                            block.Color = Color3.fromRGB(255, 0, 0)
                            block.Size = Vector3.new(2.5, 2.5, 2.5)
                            block.CFrame = v.Model:GetPivot()
                            local X1 = block.CFrame.X - plrbase.CFrame.X
                            local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.Model.CFrame
                            A_3 = 31
                            A_4 = ""
                            v.Model.PivotOffset = CFrame.new(0,0,0)
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)
                            block:Destroy()
                            local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                            local A_7 = Color3.new(v.Model.Color.R,v.Model.Color.G,v.Model.Color.B)
                            local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                            Event2:FireServer(A_6, A_7)

                        elseif v.Model.Size == Vector3.new(2.5, 2.5, 10) then
                            v.Model.PivotOffset = CFrame.new(0,0,-3.75)
                            local block = Instance.new("Part")
                            block.Parent = workspace
                            block.Name = "blockTest"
                            block.Color = Color3.fromRGB(255, 0, 0)
                            block.Size = Vector3.new(2.5, 2.5, 2.5)
                            block.CFrame = v.Model:GetPivot()
                            local X1 = block.CFrame.X - plrbase.CFrame.X
                            local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.Model.CFrame
                            A_3 = 87
                            A_4 = ""
                            v.Model.PivotOffset = CFrame.new(0,0,0)
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)
                            block:Destroy()
                            local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                            local A_7 = Color3.new(v.Model.Color.R,v.Model.Color.G,v.Model.Color.B)
                            local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                            Event2:FireServer(A_6, A_7)
                        end
                                            elseif v:FindFirstChild("HalfWedge2") then
                        local X1 = v.Model.CFrame.X - plrbase.CFrame.X
                        local Y1 = v.Model.CFrame.Y - plrbase.CFrame.Y
                        local Z1 = v.Model.CFrame.Z - plrbase.CFrame.Z
                        local X = math.round(X1 / 2.5)
                        local Y = math.round(Y1 / 2.5)
                        local Z = math.round(Z1 / 2.5)
                        A_1 = Vector3.new(X, Y, Z)
                        A_2 = v.Model.CFrame
                        A_3 = 90
                        A_4 = ""
                        Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                        Event:InvokeServer(A_1, A_2, A_3, A_4)

                    elseif v:FindFirstChild("Rope") then
                        local main = v.PrimaryPart
                        main.PivotOffset = CFrame.new(0,-1,0)
                        local block = Instance.new("Part")
                        block.Parent = workspace
                        block.Name = "blockTest"
                        block.Color = Color3.fromRGB(255, 0, 0)
                        block.Size = Vector3.new(2.5, 2.5, 2.5)
                        block.Anchored = true
                        block.CFrame = main:GetPivot()
                        local X1 = block.CFrame.X - plrbase.CFrame.X
                        local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                        local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                        local X = math.round(X1 / 2.5)
                        local Y = math.round(Y1 / 2.5)
                        local Z = math.round(Z1 / 2.5)
                        A_1 = Vector3.new(X, Y, Z)
                        A_2 = main.CFrame
                        A_3 = 33
                        A_4 = ""
                        v.Model.PivotOffset = CFrame.new(0,0,0)
                        Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                        Event:InvokeServer(A_1, A_2, A_3, A_4)
                        block:Destroy()

                    elseif v:FindFirstChild("MotorBlock") then
                        if v.MotorBlock.HingeConstraint.ActuatorType == Enum.ActuatorType.Servo then
                            local X1 = v.Model.CFrame.X - plrbase.CFrame.X
                            local Y1 = v.Model.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = v.Model.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.Model.CFrame
                            A_3 = 148
                            A_4 = ""
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)
                        else
                            local X1 = v.Model.CFrame.X - plrbase.CFrame.X
                            local Y1 = v.Model.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = v.Model.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.Model.CFrame
                            A_3 = 12
                            A_4 = ""
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)
                        end

                    elseif v:FindFirstChild("MotorEngine") then
                        if blockSelected.Size.X > 0.5 and blockSelected.Size.Y > 0.5 and blockSelected.Size.Z > 0.5 and blockSelected.Size.X < 0.6 and blockSelected.Size.Y < 0.6 and blockSelected.Size.Z < 0.6 then
                            blockSelectedSize.PivotOffset = CFrame.new(0, -2.557, 0)
                            local block = Instance.new("Part")
                            block.Parent = workspace
                            block.Name = "blockTest"
                            block.Color = Color3.fromRGB(255, 0, 0)
                            block.Size = Vector3.new(2.5, 2.5, 2.5)
                            block.CFrame = blockSelectedSize:GetPivot()
                            local X1 = block.CFrame.X - plrbase.CFrame.X
                            local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.MotorEngine.CFrame
                            A_3 = 60
                            A_4 = ""
                            v.MotorEngine.PivotOffset = CFrame.new(0,0,0)
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)
                            block:Destroy()
                        elseif blockSelected.Size.X > 0.3 and blockSelected.Size.Y > 0.3 and blockSelected.Size.Z > 0.3 and blockSelected.Size.X < 0.4 and blockSelected.Size.Y < 0.4 and blockSelected.Size.Z < 0.4 then
                            blockSelectedSize.PivotOffset = CFrame.new(1.245, 0.457, 1.255)
                            local block = Instance.new("Part")
                            block.Parent = workspace
                            block.Name = "blockTest"
                            block.Color = Color3.fromRGB(255, 0, 0)
                            block.Size = Vector3.new(2.5, 2.5, 2.5)
                            block.CFrame = blockSelectedSize:GetPivot()
                            local X1 = block.CFrame.X - plrbase.CFrame.X
                            local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.MotorEngine.CFrame
                            A_3 = 43
                            A_4 = ""
                            v.MotorEngine.PivotOffset = CFrame.new(0,0,0)
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)
                            block:Destroy()
                        else
                            if blockSelected:FindFirstChild("Mass_Weld") then
                                local X1 = blockSelectedSize.CFrame.X - plrbase.CFrame.X
                                local Y1 = blockSelectedSize.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = blockSelectedSize.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.MotorEngine.CFrame
                                A_3 = 47
                                A_4 = ""
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                            else
                                local X1 = blockSelectedSize.CFrame.X - plrbase.CFrame.X
                                local Y1 = blockSelectedSize.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = blockSelectedSize.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.MotorEngine.CFrame
                                A_3 = 34
                                A_4 = ""
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                            end
                        end

                    elseif v.Model:IsA("Part") and v.Model.Shape == Enum.PartType.Ball then
                        if v.Model.Size == Vector3.new(2.5,2.5,2.5) then
                            local X1 = v:FindFirstChild("Model").CFrame.X - plrbase.CFrame.X
                            local Y1 = v:FindFirstChild("Model").CFrame.Y - plrbase.CFrame.Y
                            local Z1 = v:FindFirstChild("Model").CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.Model.CFrame
                            A_3 = 81
                            A_4 = ""
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)
                            local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                            local A_7 = v.Model.Color
                            local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                            Event2:FireServer(A_6, A_7)
                        elseif v.Model.Size == Vector3.new(5,5,5) then
                            v.Model.PivotOffset = CFrame.new(-1.25, -1.25, -1.25)
                            local block = Instance.new("Part")
                            block.Anchored = true
                            block.Parent = workspace
                            block.Name = "blockTest"
                            block.Color = Color3.fromRGB(255, 0, 0)
                            block.Size = Vector3.new(2.5, 2.5, 2.5)
                            block.CFrame = v.Model:GetPivot()
                            local X1 = block.CFrame.X - plrbase.CFrame.X
                            local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.Model.CFrame
                            A_3 = 82
                            A_4 = ""
                            v.Model.PivotOffset = CFrame.new(0,0,0)
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)
                            block:Destroy()
                            local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                            local A_7 = v.Model.Color
                            local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                            Event2:FireServer(A_6, A_7)
                        elseif v.Model.Size == Vector3.new(7.5,7.5,7.5) then
                            local X1 = v:FindFirstChild("Model").CFrame.X - plrbase.CFrame.X
                            local Y1 = v:FindFirstChild("Model").CFrame.Y - plrbase.CFrame.Y
                            local Z1 = v:FindFirstChild("Model").CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.Model.CFrame
                            A_3 = 83
                            A_4 = ""
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)
                            local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                            local A_7 = v.Model.Color
                            local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                            Event2:FireServer(A_6, A_7)
                        end
                                            elseif v.Model:IsA("Part") and v.Model.Shape == Enum.PartType.Cylinder then
                        if v.Model.Size == Vector3.new(2.5, 2.5, 2.5) then
                            local X1 = v.Model.CFrame.X - plrbase.CFrame.X
                            local Y1 = v.Model.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = v.Model.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.Model.CFrame
                            A_3 = 78
                            A_4 = ""
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)

                        elseif v.Model.Size == Vector3.new(2.5, 7.5, 7.5) then
                            local X1 = v.Model.CFrame.X - plrbase.CFrame.X
                            local Y1 = v.Model.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = v.Model.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.Model.CFrame
                            A_3 = 79
                            A_4 = ""
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)

                        elseif v.Model.Size == Vector3.new(2.5, 12.5, 12.5) then
                            local X1 = v.Model.CFrame.X - plrbase.CFrame.X
                            local Y1 = v.Model.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = v.Model.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.Model.CFrame
                            A_3 = 120
                            A_4 = ""
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)

                        elseif v.Model.Size == Vector3.new(2.5, 5, 5) then
                            if not v:FindFirstChild("ArrowOrientation") then
                                local block = Instance.new("Part")
                                block.Anchored = true
                                block.Parent = workspace
                                block.Name = "blockTest"
                                block.Color = Color3.fromRGB(255, 0, 0)
                                block.Size = Vector3.new(2.5, 2.5, 2.5)
                                block.CFrame = v.Model:GetPivot()
                                local X1 = block.CFrame.X - plrbase.CFrame.X
                                local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 125
                                A_4 = ""
                                v.Model.PivotOffset = CFrame.new(0,0,0)
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                block:Destroy()
                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                local A_7 = v.Model.Color
                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                Event2:FireServer(A_6, A_7)
                            else
                                v.Model.PivotOffset = CFrame.new(0, -1.25, -1.25)
                                local block = Instance.new("Part")
                                block.Anchored = true
                                block.Parent = workspace
                                block.Name = "blockTest"
                                block.Color = Color3.fromRGB(255, 0, 0)
                                block.Size = Vector3.new(2.5, 2.5, 2.5)
                                block.CFrame = v.Model:GetPivot()
                                local X1 = block.CFrame.X - plrbase.CFrame.X
                                local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 112
                                A_4 = ""
                                v.Model.PivotOffset = CFrame.new(0,0,0)
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                block:Destroy()
                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                local A_7 = v.Model.Color
                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                Event2:FireServer(A_6, A_7)
                            end
                        end

                    elseif v.Model:IsA("Part") and v.Model.Shape == Enum.PartType.Block then
                        if v:FindFirstChild("CFrameVal") and v:FindFirstChild("SelectedPart") then
                            local block = v.PrimaryPart
                            local X1 = block.CFrame.X - plrbase.CFrame.X
                            local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = block.CFrame
                            A_3 = 69
                            A_4 = ""
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)
                        end

                        if v:FindFirstChild("Light") then
                        else
                            if v.Model.Size == Vector3.new(2.5,2.5,2.5) then
                                if v.Model:FindFirstChild("BodyThrust") then
                                    local X1 = v:FindFirstChild("Model").CFrame.X - plrbase.CFrame.X
                                    local Y1 = v:FindFirstChild("Model").CFrame.Y - plrbase.CFrame.Y
                                    local Z1 = v:FindFirstChild("Model").CFrame.Z - plrbase.CFrame.Z
                                    local X = math.round(X1 / 2.5)
                                    local Y = math.round(Y1 / 2.5)
                                    local Z = math.round(Z1 / 2.5)
                                    A_1 = Vector3.new(X, Y, Z)
                                    A_2 = v.Model.CFrame
                                    A_3 = 6
                                    A_4 = ""
                                    Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                    Event:InvokeServer(A_1, A_2, A_3, A_4)
                                    local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                    local A_7 = v.Model.Color
                                    local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                    Event2:FireServer(A_6, A_7)
                                else
                                    if v:FindFirstChild("Configuration") then
                                        if v.Model:FindFirstChild("Light") then
                                            if v.Model.Light:IsA("PointLight") then
                                                local X1 = v:FindFirstChild("Model").CFrame.X - plrbase.CFrame.X
                                                local Y1 = v:FindFirstChild("Model").CFrame.Y - plrbase.CFrame.Y
                                                local Z1 = v:FindFirstChild("Model").CFrame.Z - plrbase.CFrame.Z
                                                local X = math.round(X1 / 2.5)
                                                local Y = math.round(Y1 / 2.5)
                                                local Z = math.round(Z1 / 2.5)
                                                A_1 = Vector3.new(X, Y, Z)
                                                A_2 = v.Model.CFrame
                                                A_3 = 74
                                                A_4 = ""
                                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                                local A_7 = v.Model.Color
                                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                                Event2:FireServer(A_6, A_7)
                                            elseif v.Model.Light:IsA("SpotLight") then
                                                local X1 = v:FindFirstChild("Model").CFrame.X - plrbase.CFrame.X
                                                local Y1 = v:FindFirstChild("Model").CFrame.Y - plrbase.CFrame.Y
                                                local Z1 = v:FindFirstChild("Model").CFrame.Z - plrbase.CFrame.Z
                                                local X = math.round(X1 / 2.5)
                                                local Y = math.round(Y1 / 2.5)
                                                local Z = math.round(Z1 / 2.5)
                                                A_1 = Vector3.new(X, Y, Z)
                                                A_2 = v.Model.CFrame
                                                A_3 = 75
                                                A_4 = ""
                                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                                local A_7 = v.Model.Color
                                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                                Event2:FireServer(A_6, A_7)
                                            end
                                        else
                                            if v:FindFirstChild("Events") then
                                                if v.Model:FindFirstChild("BodyPosition") and v.Model:FindFirstChild("BodyGyro") then
                                                    local X1 = v:FindFirstChild("Model").CFrame.X - plrbase.CFrame.X
                                                    local Y1 = v:FindFirstChild("Model").CFrame.Y - plrbase.CFrame.Y
                                                    local Z1 = v:FindFirstChild("Model").CFrame.Z - plrbase.CFrame.Z
                                                    local X = math.round(X1 / 2.5)
                                                    local Y = math.round(Y1 / 2.5)
                                                    local Z = math.round(Z1 / 2.5)
                                                    A_1 = Vector3.new(X, Y, Z)
                                                    A_2 = v.Model.CFrame
                                                    A_3 = 48
                                                    A_4 = ""
                                                    Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                                    Event:InvokeServer(A_1, A_2, A_3, A_4)
                                                    local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                                    local A_7 = v.Model.Color
                                                    local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                                    Event2:FireServer(A_6, A_7)
                                                elseif v.Model:FindFirstChild("BodyPosition") and not v.Model:FindFirstChild("BodyGyro") then
                                                    local X1 = v:FindFirstChild("Model").CFrame.X - plrbase.CFrame.X
                                                    local Y1 = v:FindFirstChild("Model").CFrame.Y - plrbase.CFrame.Y
                                                    local Z1 = v:FindFirstChild("Model").CFrame.Z - plrbase.CFrame.Z
                                                    local X = math.round(X1 / 2.5)
                                                    local Y = math.round(Y1 / 2.5)
                                                    local Z = math.round(Z1 / 2.5)
                                                    A_1 = Vector3.new(X, Y, Z)
                                                    A_2 = v.Model.CFrame
                                                    A_3 = 149
                                                    A_4 = ""
                                                    Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                                    Event:InvokeServer(A_1, A_2, A_3, A_4)
                                                    local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                                    local A_7 = v.Model.Color
                                                    local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                                end
                                            else
                                                local X1 = v:FindFirstChild("Model").CFrame.X - plrbase.CFrame.X
                                                local Y1 = v:FindFirstChild("Model").CFrame.Y - plrbase.CFrame.Y
                                                local Z1 = v:FindFirstChild("Model").CFrame.Z - plrbase.CFrame.Z
                                                local X = math.round(X1 / 2.5)
                                                local Y = math.round(Y1 / 2.5)
                                                local Z = math.round(Z1 / 2.5)
                                                A_1 = Vector3.new(X, Y, Z)
                                                A_2 = v.Model.CFrame
                                                A_3 = 24
                                                A_4 = ""
                                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                                local A_7 = v.Model.Color
                                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                                Event2:FireServer(A_6, A_7)
                                            end
                                        end
                                    else
                                        local X1 = v:FindFirstChild("Model").CFrame.X - plrbase.CFrame.X
                                        local Y1 = v:FindFirstChild("Model").CFrame.Y - plrbase.CFrame.Y
                                        local Z1 = v:FindFirstChild("Model").CFrame.Z - plrbase.CFrame.Z
                                        local X = math.round(X1 / 2.5)
                                        local Y = math.round(Y1 / 2.5)
                                        local Z = math.round(Z1 / 2.5)
                                        A_1 = Vector3.new(X, Y, Z)
                                        A_2 = v.Model.CFrame
                                        A_3 = 1
                                        A_4 = ""
                                        Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                        Event:InvokeServer(A_1, A_2, A_3, A_4)
                                        local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                        local A_7 = v.Model.Color
                                        local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                        Event2:FireServer(A_6, A_7)
                                    end
                                end
                                                            elseif v.Model.Size == Vector3.new(2.5, 0.2, 0.5) then
                                v.Model.PivotOffset = CFrame.new(0,0,1)
                                local block = Instance.new("Part")
                                block.Parent = workspace
                                block.Name = "blockTest"
                                block.Color = Color3.fromRGB(255, 0, 0)
                                block.Size = Vector3.new(2.5, 2.5, 2.5)
                                block.CFrame = v.Model:GetPivot()
                                local X1 = block.CFrame.X - plrbase.CFrame.X
                                local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 49
                                A_4 = ""
                                v.Model.PivotOffset = CFrame.new(0,0,0)
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                block:Destroy()
                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                local A_7 = v.Model.Color
                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                Event2:FireServer(A_6, A_7)

                            elseif v.Model.Size == Vector3.new(1.495, 0.195, 4.995) then
                                v.Model.PivotOffset = CFrame.new(0,0,-1.25)
                                local block = Instance.new("Part")
                                block.Parent = workspace
                                block.Name = "blockTest"
                                block.Color = Color3.fromRGB(255, 0, 0)
                                block.Size = Vector3.new(2.5, 2.5, 2.5)
                                block.CFrame = v.Model:GetPivot()
                                local X1 = block.CFrame.X - plrbase.CFrame.X
                                local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.PrimaryPart.CFrame
                                A_3 = 147
                                A_4 = ""
                                v.Model.PivotOffset = CFrame.new(0,0,0)
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                block:Destroy()
                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                local A_7 = v.Model.Color
                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                Event2:FireServer(A_6, A_7)

                            elseif v.Model.Size == Vector3.new(5, 0.2, 0.5) then
                                v.Model.PivotOffset = CFrame.new(-1.25,0,1)
                                local block = Instance.new("Part")
                                block.Parent = workspace
                                block.Name = "blockTest"
                                block.Color = Color3.fromRGB(255, 0, 0)
                                block.Size = Vector3.new(2.5, 2.5, 2.5)
                                block.CFrame = v.Model:GetPivot()
                                local X1 = block.CFrame.X - plrbase.CFrame.X
                                local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 4
                                A_4 = ""
                                v.Model.PivotOffset = CFrame.new(0,0,0)
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                block:Destroy()
                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                local A_7 = v.Model.Color
                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                Event2:FireServer(A_6, A_7)

                            elseif v.Model.Size == Vector3.new(2.5, 0.4, 2.5) then
                                local X1 = v:FindFirstChild("Model").CFrame.X - plrbase.CFrame.X
                                local Y1 = v:FindFirstChild("Model").CFrame.Y - plrbase.CFrame.Y
                                local Z1 = v:FindFirstChild("Model").CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 27
                                A_4 = ""
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                local A_7 = v.Model.Color
                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                Event2:FireServer(A_6, A_7)

                            elseif v.Model.Size == Vector3.new(5,0.4,2.5) then
                                v.Model.PivotOffset = CFrame.new(-1.25,0,0)
                                local block = Instance.new("Part")
                                block.Parent = workspace
                                block.Name = "blockTest"
                                block.Color = Color3.fromRGB(255, 0, 0)
                                block.Size = Vector3.new(2.5, 2.5, 2.5)
                                block.CFrame = v.Model:GetPivot()
                                local X1 = block.CFrame.X - plrbase.CFrame.X
                                local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 2
                                A_4 = ""
                                v.Model.PivotOffset = CFrame.new(0,0,0)
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                block:Destroy()
                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                local A_7 = v.Model.Color
                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                Event2:FireServer(A_6, A_7)

                            elseif v.Model.Size == Vector3.new(0.05, 0.05, 0.05) then
                                blockSelected.PivotOffset = CFrame.new(-1.25,0,0)
                                local block = Instance.new("Part")
                                block.Parent = workspace
                                block.Name = "blockTest"
                                block.Color = Color3.fromRGB(255, 0, 0)
                                block.Size = Vector3.new(2.5, 2.5, 2.5)
                                block.CFrame = blockSelected:GetPivot()
                                local X1 = block.CFrame.X - plrbase.CFrame.X
                                local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 25
                                A_4 = ""
                                blockSelected.PivotOffset = CFrame.new(0,0,0)
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                block:Destroy()
                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                local A_7 = blockSelected.Color
                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                Event2:FireServer(A_6, A_7)

                            elseif v.Model.Size == Vector3.new(7.5, 0.4, 2.5) then
                                v.Model.PivotOffset = CFrame.new(-2.5,0,0)
                                local block = Instance.new("Part")
                                block.Parent = workspace
                                block.Name = "blockTest"
                                block.Color = Color3.fromRGB(255, 0, 0)
                                block.Size = Vector3.new(2.5, 2.5, 2.5)
                                block.CFrame = v.Model:GetPivot()
                                local X1 = block.CFrame.X - plrbase.CFrame.X
                                local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 91
                                A_4 = ""
                                v.Model.PivotOffset = CFrame.new(0,0,0)
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                block:Destroy()
                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                local A_7 = v.Model.Color
                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                Event2:FireServer(A_6, A_7)

                            elseif v.Model.Size == Vector3.new(10, 0.4, 2.5) then
                                v.Model.PivotOffset = CFrame.new(-2.5,0,0)
                                local block = Instance.new("Part")
                                block.Parent = workspace
                                block.Name = "blockTest"
                                block.Color = Color3.fromRGB(255, 0, 0)
                                block.Size = Vector3.new(2.5, 2.5, 2.5)
                                block.CFrame = v.Model:GetPivot()
                                local X1 = block.CFrame.X - plrbase.CFrame.X
                                local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 28
                                A_4 = ""
                                v.Model.PivotOffset = CFrame.new(0,0,0)
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                block:Destroy()
                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                local A_7 = v.Model.Color
                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                Event2:FireServer(A_6, A_7)

                            elseif v.Model.Size == Vector3.new(2.5, 2.5, 10) then
                                if v.Model:FindFirstChild("BodyThrust") then
                                    v.Model.PivotOffset = CFrame.new(0,0,-3.75)
                                    local block = Instance.new("Part")
                                    block.Parent = workspace
                                    block.Name = "blockTest"
                                    block.Color = Color3.fromRGB(255, 0, 0)
                                    block.Size = Vector3.new(2.5, 2.5, 2.5)
                                    block.CFrame = v.Model:GetPivot()
                                    local X1 = block.CFrame.X - plrbase.CFrame.X
                                    local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                    local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                    local X = math.round(X1 / 2.5)
                                    local Y = math.round(Y1 / 2.5)
                                    local Z = math.round(Z1 / 2.5)
                                    A_1 = Vector3.new(X, Y, Z)
                                    A_2 = v.Model.CFrame
                                    A_3 = 30
                                    A_4 = ""
                                    v.Model.PivotOffset = CFrame.new(0,0,0)
                                    Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                    Event:InvokeServer(A_1, A_2, A_3, A_4)
                                    block:Destroy()
                                    local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                    local A_7 = v.Model.Color
                                    local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                    Event2:FireServer(A_6, A_7)
                                else
                                    if v:FindFirstChild("Configuration") then
                                        v.Model.PivotOffset = CFrame.new(0,0,-3.75)
                                        local block = Instance.new("Part")
                                        block.Parent = workspace
                                        block.Name = "blockTest"
                                        block.Color = Color3.fromRGB(255, 0, 0)
                                        block.Size = Vector3.new(2.5, 2.5, 2.5)
                                        block.CFrame = v.Model:GetPivot()
                                        local X1 = block.CFrame.X - plrbase.CFrame.X
                                        local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                        local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                        local X = math.round(X1 / 2.5)
                                        local Y = math.round(Y1 / 2.5)
                                        local Z = math.round(Z1 / 2.5)
                                        A_1 = Vector3.new(X, Y, Z)
                                        A_2 = v.Model.CFrame
                                        A_3 = 39
                                        A_4 = ""
                                        v.Model.PivotOffset = CFrame.new(0,0,0)
                                        Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                        Event:InvokeServer(A_1, A_2, A_3, A_4)
                                        block:Destroy()
                                        local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                        local A_7 = v.Model.Color
                                        local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                        Event2:FireServer(A_6, A_7)
                                    else
                                        v.Model.PivotOffset = CFrame.new(0,0,-3.75)
                                        local block = Instance.new("Part")
                                        block.Parent = workspace
                                        block.Name = "blockTest"
                                        block.Color = Color3.fromRGB(255, 0, 0)
                                        block.Size = Vector3.new(2.5, 2.5, 2.5)
                                        block.CFrame = v.Model:GetPivot()
                                        local X1 = block.CFrame.X - plrbase.CFrame.X
                                        local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                        local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                        local X = math.round(X1 / 2.5)
                                        local Y = math.round(Y1 / 2.5)
                                        local Z = math.round(Z1 / 2.5)
                                        A_1 = Vector3.new(X, Y, Z)
                                        A_2 = v.Model.CFrame
                                        A_3 = 16
                                        A_4 = ""
                                        v.Model.PivotOffset = CFrame.new(0,0,0)
                                        Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                        Event:InvokeServer(A_1, A_2, A_3, A_4)
                                        block:Destroy()
                                        local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                        local A_7 = v.Model.Color
                                        local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                        Event2:FireServer(A_6, A_7)
                                    end
                                end

                            elseif v.Model.Size == Vector3.new(2.5, 2.5, 17.5) then
                                local X1 = v:FindFirstChild("Model").CFrame.X - plrbase.CFrame.X
                                local Y1 = v:FindFirstChild("Model").CFrame.Y - plrbase.CFrame.Y
                                local Z1 = v:FindFirstChild("Model").CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 38
                                A_4 = ""
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                local A_7 = v.Model.Color
                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                Event2:FireServer(A_6, A_7)

                            elseif v.Model.Size == Vector3.new(2.5, 2.4, 2.5) then
                                local X1 = v:FindFirstChild("Model").CFrame.X - plrbase.CFrame.X
                                local Y1 = v:FindFirstChild("Model").CFrame.Y - plrbase.CFrame.Y
                                local Z1 = v:FindFirstChild("Model").CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 65
                                A_4 = ""
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                local A_7 = v.Model.Color
                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                Event2:FireServer(A_6, A_7)

                            elseif v.Model.Size == Vector3.new(2.5, 1.25, 2.5) then
                                if v:FindFirstChild("Configuration") then
                                    if v.Model:FindFirstChild("Light") then
                                        v.Model.PivotOffset = CFrame.new(0,-0.625,0)
                                        local block = Instance.new("Part")
                                        block.Anchored = true
                                        block.Parent = workspace
                                        block.Name = "blockTest"
                                        block.Color = Color3.fromRGB(255, 0, 0)
                                        block.Size = Vector3.new(2.5, 2.5, 2.5)
                                        block.CFrame = v.Model:GetPivot()
                                        local X1 = block.CFrame.X - plrbase.CFrame.X
                                        local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                        local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                        local X = math.round(X1 / 2.5)
                                        local Y = math.round(Y1 / 2.5)
                                        local Z = math.round(Z1 / 2.5)
                                        A_1 = Vector3.new(X, Y, Z)
                                        A_2 = v.Model.CFrame
                                        A_3 = 84
                                        A_4 = ""
                                        v.Model.PivotOffset = CFrame.new(0,0,0)
                                        Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                        Event:InvokeServer(A_1, A_2, A_3, A_4)
                                        block:Destroy()
                                        local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                        local A_7 = v.Model.Color
                                        local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                        Event2:FireServer(A_6, A_7)
                                    end
                                else
                                    v.Model.PivotOffset = CFrame.new(0,-0.625,0)
                                    local block = Instance.new("Part")
                                    block.Anchored = true
                                    block.Parent = workspace
                                    block.Name = "blockTest"
                                    block.Color = Color3.fromRGB(255, 0, 0)
                                    block.Size = Vector3.new(2.5, 2.5, 2.5)
                                    block.CFrame = v.Model:GetPivot()
                                    local X1 = block.CFrame.X - plrbase.CFrame.X
                                    local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                    local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                    local X = math.round(X1 / 2.5)
                                    local Y = math.round(Y1 / 2.5)
                                    local Z = math.round(Z1 / 2.5)
                                    A_1 = Vector3.new(X, Y, Z)
                                    A_2 = v.Model.CFrame
                                    A_3 = 26
                                    A_4 = ""
                                    v.Model.PivotOffset = CFrame.new(0,0,0)
                                    Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                    Event:InvokeServer(A_1, A_2, A_3, A_4)
                                    block:Destroy()
                                    local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                    local A_7 = v.Model.Color
                                    local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                    Event2:FireServer(A_6, A_7)
                                end

                            elseif v.Model.Size == Vector3.new(10, 1.25, 2.5) then
                                v.Model.PivotOffset = CFrame.new(-3.75,-0.625,0)
                                local block = Instance.new("Part")
                                block.Anchored = true
                                block.Parent = workspace
                                block.Name = "blockTest"
                                block.Color = Color3.fromRGB(255, 0, 0)
                                block.Size = Vector3.new(2.5, 2.5, 2.5)
                                block.CFrame = v.Model:GetPivot()
                                local X1 = block.CFrame.X - plrbase.CFrame.X
                                local Y1 = block.CFrame.Y - plrbase.CFrame.Y
                                local Z1 = block.CFrame.Z - plrbase.CFrame.Z
                                local X = math.round(X1 / 2.5)
                                local Y = math.round(Y1 / 2.5)
                                local Z = math.round(Z1 / 2.5)
                                A_1 = Vector3.new(X, Y, Z)
                                A_2 = v.Model.CFrame
                                A_3 = 92
                                A_4 = ""
                                v.Model.PivotOffset = CFrame.new(0,0,0)
                                Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                                Event:InvokeServer(A_1, A_2, A_3, A_4)
                                block:Destroy()
                                local A_6 = workspace.P1ayerAircraft:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart
                                local A_7 = v.Model.Color
                                local Event2 = game:GetService("ReplicatedStorage").Remotes.Paint
                                Event2:FireServer(A_6, A_7)
                            end
                        end

                    else
                        if v:FindFirstChild("Modelo") then
                            local X1 = v.Model.CFrame.X - plrbase.CFrame.X
                            local Y1 = v.Model.CFrame.Y - plrbase.CFrame.Y
                            local Z1 = v.Model.CFrame.Z - plrbase.CFrame.Z
                            local X = math.round(X1 / 2.5)
                            local Y = math.round(Y1 / 2.5)
                            local Z = math.round(Z1 / 2.5)
                            A_1 = Vector3.new(X, Y, Z)
                            A_2 = v.Model.CFrame
                            A_3 = 90
                            A_4 = ""
                            Event = game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion
                            Event:InvokeServer(A_1, A_2, A_3, A_4)
                        end
                    end
                end
            end
            
            local children3 = PlayerAircraft:GetChildren()
            children4 = i
            for mmm = 1, #children3 do
                children3 = mmm
            end
            if canceled == false then
                Progress.Text = children4 .. "/"..children3
                local tempoEstimado = children3 - children4
                tempoEstimado = string.format("%.1f",tempoEstimado/6)
                local min = math.floor(tempoEstimado / 60) + 1

                if min == 2 then
                    TEMPO.Text = min .. " minutes left"
                elseif min > 2 then
                    TEMPO.Text = min .. " minutes left"
                elseif min == 1 then
                    TEMPO.Text = "Less than 1 minute left"
                end
            end
            if children4 >= children3 then
                Progress.Text = "Finished!"
                Cancel.Visible = false
                List.Visible = true
                Copy.Visible = true
                TEMPO.Text = ""
                if game.Workspace:FindFirstChild("CopiedBase") then
                    for i,v in pairs(game.Workspace:GetChildren()) do
                        if v.Name == "CopiedBase" then
                            v:Destroy()
                        end
                    end
                end
            end
        end
    end
else
    Copy.Text = "Invalid!"
    Copy.TextColor3 = Color3.fromRGB(255,0,0)
    sound1:Play()
    wait(0.261)
    Copy.Text = "Copy"
    Copy.TextColor3 = Color3.fromRGB(0,0,0)
    end
end)

--========================================================
-- PLAYER LIST LOOP
--========================================================

while true do
    local playersList = game.Players:GetChildren()
    for ___,players in pairs(playersList) do
        local new = Sample:Clone()
        new.Name = players.Name
        new.Text = players.Name
        new.Parent = List
        new.Visible = true

        new.MouseButton1Click:Connect(function()
            plrCopy = players.Name
            Copy.Visible = true
            PayerName.Text = players.Name
        end)

        new.MouseEnter:Connect(function()
            sound2:Play()
        end)
    end
    wait(5)
    for ___,sampleTemp in pairs(List:GetChildren()) do
        if sampleTemp:IsA("TextButton") then
            sampleTemp:Destroy()
        end
    end
    wait()
end
