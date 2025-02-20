-- MainScript.lua (разместите этот файл на GitHub)

local gui
local success, errorMessage = pcall(function()
    gui = loadstring(game:HttpGet("https://raw.githubusercontent.com/caboyd/LunaUI-ClassicFix/refs/heads/classic/LunaUnitFrames.lua"))() -- Или другой URL для LunaUI
end)

if not success then
    print("Ошибка загрузки LunaUI: " .. errorMessage)
    return
end

if not gui then
    print("LunaUI не инициализировалась")
    return
end

print("LunaUI успешно загружена")

-- Создание основного окна
local mainWindow = gui:Create({
    Title = "Glitch Hub",
    Size = UDim2.new(0, 400, 0, 300),
    Theme = "Dark",
    Draggable = true,
    closable = true
})

-- Создание вкладок
local mainTab = mainWindow:AddTab({
    Title = "Main"
})

local settingsTab = mainWindow:AddTab({
    Title = "Settings"
})

-- Premium variables
local premiumCode = ""
local isPremium = false
local generatedCode = ""

-- Function to generate premium code (INSECURE!)
local function generatePremiumCode()
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local code = ""
    for i = 1, 16 do
        code = code .. chars:sub(math.random(chars:len()), math.random(chars:len()))
    end
    return code
end


-- Main Tab content
mainTab:AddLabel({
    Text = "Welcome to Glitch Hub!",
    Size = UDim2.new(1, 0, 0, 20),
    Font = Enum.Font.SourceSansBold
})

mainTab:AddButton({
    Text = "Teleport to Lobby",
    Size = UDim2.new(1, 0, 0, 30),
    Callback = function()
       --Example action
        if game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
        else
            print("Игрок, персонаж или HumanoidRootPart не найдены.")
        end
    end
})

--Settings Tab content

settingsTab:AddLabel({
    Text = "Premium Settings",
    Size = UDim2.new(1, 0, 0, 20),
    Font = Enum.Font.SourceSansBold
})

local premiumBuyButton
local premiumCodeLabel

local function updatePremiumUI()
    if isPremium then
        premiumBuyButton.Text = "Premium Activated"
        premiumBuyButton.Enabled = false
        premiumCodeLabel.Text = "Premium Activated!"
    else
        premiumBuyButton.Text = "Buy Premium (Generate Code)"
        premiumBuyButton.Enabled = true
        premiumCodeLabel.Text = ""
    end
end


premiumBuyButton = settingsTab:AddButton({
    Text = "Buy Premium (Generate Code)",
    Size = UDim2.new(1, 0, 0, 30),
    Callback = function()
        if not isPremium then
            generatedCode = generatePremiumCode()
            print("Generated code: " .. generatedCode)
            premiumCodeLabel.Text = "Your Premium Code: " .. generatedCode
        else
            gui:Notification({Title = "Error", Text = "You already have Premium."})
        end
        updatePremiumUI()
    end
})

premiumCodeLabel = settingsTab:AddLabel({
    Text = "",
    Size = UDim2.new(1, 0, 0, 20),
    Font = Enum.Font.SourceSans
})


settingsTab:AddTextbox({
    PlaceholderText = "Enter Premium Code",
    Size = UDim2.new(1, 0, 0, 30),
    Callback = function(text)
        premiumCode = text
    end
})

settingsTab:AddButton({
    Text = "Activate Premium",
    Size = UDim2.new(1, 0, 0, 30),
    Callback = function()
        if premiumCode == generatedCode and generatedCode ~= "" then
            isPremium = true
            generatedCode = ""
            gui:Notification({Title = "Success", Text = "Premium Activated!"})
        else
            gui:Notification({Title = "Error", Text = "Invalid Premium Code!"})
        end
        updatePremiumUI()
    end
})

updatePremiumUI()

-- Example code to change the UI theme
settingsTab:AddButton({
    Text = "Toggle Theme",
    Size = UDim2.new(1, 0, 0, 30),
    Callback = function()
        if mainWindow.Theme == "Dark" then
            mainWindow:SetTheme("Light")
        else
            mainWindow:SetTheme("Dark")
        end
    end
})
