task.wait(5)

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local ProximityPromptService = game:GetService("ProximityPromptService")
local VIM = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer


local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local backpack = player:WaitForChild("Backpack")

local net = require(RS.Packages.Net);
local Sell = net:RemoteEvent("PlotService/Sell");
local CastEvent = net:RemoteEvent("FishingRod.Cast")
local CancelEvent = net:RemoteEvent("FishingRod.Cancel")
local MinigameClick = net:RemoteEvent("FishingRod.MinigameClick")

local function waitForPath(parent, ...)
    local cur = parent
    for _, name in ipairs({...}) do
        repeat task.wait() until cur and cur:FindFirstChild(name)
        cur = cur:FindFirstChild(name)
    end
    return cur
end

local function isBasePart(x)
    return typeof(x) == "Instance" and x:IsA("BasePart")
end

local function ensureChar()
    local c = player.Character or player.CharacterAdded:Wait()
    local h = c:FindFirstChildOfClass("Humanoid") or c:WaitForChild("Humanoid", 5)
    local hrp = c:FindFirstChild("HumanoidRootPart") or c.PrimaryPart
    return c, h, hrp
end

local function spamJump(times)
    times = times or 10
    local _, hum = ensureChar()
    if not hum then return end
    for _=1,times do
        pcall(function()
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
            hum.Jump = true
        end)
        task.wait(0.05)
    end
end

-- Improved walkToDynamic with faster stuck handling
local function walkToDynamic(target, reach, timeout, jumpWhileWalking)
    reach = reach or 3
    timeout = timeout or 35
    local _, hum, hrp = ensureChar()
    if not hum or not hrp then return false end

    local t0 = tick()
    local lastPos = hrp.Position
    local stuckCheck = tick()

    while tick() - t0 < timeout do
        if not target or not target.Parent then return false end

        local pos
        if target:IsA("ProximityPrompt") then
            local att = target.Parent
            if att and att:IsA("Attachment") then
                pos = att.WorldPosition
            elseif att and att:IsA("BasePart") then
                pos = att.Position
            end
        elseif isBasePart(target) then
            pos = target.Position
        end

        if not pos then return false end

        local mag = (hrp.Position - pos).Magnitude
        if mag <= reach then return true end

        pcall(function() hum:MoveTo(pos) end)
        if jumpWhileWalking then hum.Jump = true end

        -- Faster stuck handling
        if (hrp.Position - lastPos).Magnitude < 1 then
            if tick() - stuckCheck > 5 then
                local goal = {CFrame = hrp.CFrame + Vector3.new(0,5,0)}
                local tween = TweenService:Create(hrp, TweenInfo.new(0.3, Enum.EasingStyle.Linear), goal)
                tween:Play()
                task.wait(0.35)
                tween:Cancel()
                lastPos = hrp.Position + Vector3.new(math.random(),0,math.random())
                stuckCheck = tick()
            end
        else
            lastPos = hrp.Position
            stuckCheck = tick()
        end

        task.wait(0.15)
    end
    return false
end

local function firePrompt(prompt, tries, key, holdOverride)
    if not prompt or not prompt.Parent then return false end
    tries = tries or 3
    key = key or Enum.KeyCode.E
    holdOverride = holdOverride or nil

    for _ = 1, tries do
        local ok = pcall(function()
            local holdTime = holdOverride or tonumber(prompt.HoldDuration) or 0
            if holdTime < 0.25 then holdTime = 0.25 end

            pcall(function()
                prompt.RequiresLineOfSight = false
                prompt.MaxActivationDistance = math.max(prompt.MaxActivationDistance or 8, 12)
            end)

            VIM:SendKeyEvent(true, key, false, game)
            task.wait(holdTime)
            VIM:SendKeyEvent(false, key, false, game)
            task.wait(0.12)
        end)
        if ok then return true end
        task.wait(0.2)
    end
    return false
end

local function parsePrice(txt)
    if not txt then return math.huge end
    local s = tostring(txt):upper():gsub("%$", ""):gsub(",", "")
    local n = tonumber((s:match("[%d%.]+"))) or 0
    if s:find("K") then n = n * 1000 end
    if s:find("M") then n = n * 1000000 end
    if s:find("B") then n = n * 1000000000 end
    return n
end

local leaderstats = waitForPath(player, "leaderstats")
local rebirths, cashValue
task.spawn(function()
    while true do
        if player:FindFirstChild("leaderstats") then
            cashValue = player.leaderstats:FindFirstChild("Cash")
            rebirths = player.leaderstats:FindFirstChild("Rebirths")
        end
        task.wait(1)
    end
end)

local plots = waitForPath(Workspace, "Plots")

local function findMyPlot()
    for _, plot in ipairs(plots:GetChildren()) do
        local ok, text = pcall(function()
            local sign = plot:FindFirstChild("PlotSign")
            local gui = sign and sign:FindFirstChild("SurfaceGui")
            local frame = gui and gui:FindFirstChild("Frame")
            local label = frame and frame:FindFirstChild("TextLabel")
            return label and label.Text
        end)
        if ok and text == (player.Name.."'s Base") then
            return plot
        end
    end
end

local function ensureMyPlot()
    local p = findMyPlot()
    while not p do
        task.wait(1)
        p = findMyPlot()
    end
    return p
end

local function findPriceAndPurchasePrompt(model)
    local part = model:FindFirstChild("Part") or model:FindFirstChild("HumanoidRootPart")
    if not isBasePart(part) then return nil, nil, nil end

    local price = math.huge
    local info = part:FindFirstChild("Info")
    if info then
        local ao = info:FindFirstChild("AnimalOverhead")
        local priceLabel = ao and ao:FindFirstChild("Price")
        if priceLabel then
            price = parsePrice(priceLabel.Text)
        end
    end

    local purchasePrompt = nil
    local pa = part:FindFirstChild("PromptAttachment")
    if pa then
        for _, d in ipairs(pa:GetChildren()) do
            if d:IsA("ProximityPrompt") then
                local a = tostring(d.ActionText or ""):lower()
                if a:find("purchase") or a:find("buy") or a:find("kauf") then
                    purchasePrompt = d
                    break
                end
            end
        end
        if not purchasePrompt then
            purchasePrompt = pa:FindFirstChildOfClass("ProximityPrompt")
        end
    end

    if not purchasePrompt then
        for _, d in ipairs(model:GetDescendants()) do
            if d:IsA("ProximityPrompt") then
                local a = tostring(d.ActionText or ""):lower()
                if a:find("purchase") or a:find("buy") or a:find("kauf") then
                    purchasePrompt = d
                    break
                end
            end
        end
    end
    return part, purchasePrompt, price
end

local function getMovingAnimals()
    local list = {}
    for _, m in ipairs(Workspace:GetChildren()) do
        if m:IsA("Model") then
            local part, prompt, price = findPriceAndPurchasePrompt(m)
            if part and prompt and price and price < math.huge then
                table.insert(list, {model=m, part=part, prompt=prompt, price=price})
            end
        end
    end
    return list
end

local function bestAffordable()
    local best, bestPrice = nil, -1
    for _, entry in ipairs(getMovingAnimals()) do
        local p = entry.price or 0
        if cashValue and cashValue.Value and p > 0 and p <= cashValue.Value and p >= bestPrice then
            best = entry
            bestPrice = p
        end
    end
    return best
end

local function countOwned(plot)
    local pods = plot and plot:FindFirstChild("AnimalPodiums")
    if not pods then return 0 end
    local c = 0
    for _, pod in ipairs(pods:GetChildren()) do
        local oh = pod:FindFirstChild("Base") and pod.Base:FindFirstChild("Spawn") and pod.Base.Spawn:FindFirstChild("Attachment")
        oh = oh and oh:FindFirstChild("AnimalOverhead")
        if oh then c += 1 end
    end
    return c
end

local function collectCoins(plot)
    spamJump(10)
    task.wait(0.4)
    local pods = plot and plot:FindFirstChild("AnimalPodiums")
    if not pods then return end
    for _, pod in ipairs(pods:GetChildren()) do
        local hit = pod:FindFirstChild("Claim") and pod.Claim:FindFirstChild("Hitbox")
        if isBasePart(hit) then
            local ok = walkToDynamic(hit, 3, 10) -- reduced timeout
            task.wait(0.08)
        end
    end
end

local function podiumPrompt(pod)
    local spawn = pod:FindFirstChild("Base") and pod.Base:FindFirstChild("Spawn")
    local pa = spawn and spawn:FindFirstChild("PromptAttachment")
    if pa then
        for _, p in ipairs(pa:GetChildren()) do
            if p:IsA("ProximityPrompt") then
                local a = tostring(p.ActionText or ""):lower()
                if a:find("sell") then
                    return p
                end
            end
        end
        return pa:FindFirstChildOfClass("ProximityPrompt")
    end
    return nil
end

local function podiumPrice(pod)
    for _, d in ipairs(pod:GetDescendants()) do
        if d.Name=="AnimalOverhead" then
            local p = d:FindFirstChild("Price")
            if p and p:IsA("TextLabel") then
                return parsePrice(p.Text)
            end
        end
    end
    return math.huge
end

local function sellCheapest(plot)
    local pods = plot and plot:FindFirstChild("AnimalPodiums")
    if not pods then return end
    local entries = {}
    for _, pod in ipairs(pods:GetChildren()) do
        local pr = podiumPrice(pod)
        local prompt = podiumPrompt(pod)
        if prompt then
            table.insert(entries, {pod=pod, price=pr, prompt=prompt, index = tonumber(pod.Name)})
        end
    end
    table.sort(entries, function(a,b) return a.price < b.price end)
    if #entries==0 then return end

    local cheapest = entries[1].price
    for _, e in ipairs(entries) do
        if e.price==cheapest then
            local retries = 0
            while retries < 3 do
                if walkToDynamic(e.prompt, 3, 20) then
                    task.wait(0.5)
                    local success = firePrompt(e.prompt, 1, Enum.KeyCode.F, 3.5)
                    task.wait(0.5)
                    Sell:FireServer(e.index)
                    if success then break end
                end
                retries += 1
                task.wait(0.5)
            end
        end
    end
end

local function hasRequired(plot)
    local pods = plot and plot:FindFirstChild("AnimalPodiums")
    if not pods then return false end
    local f1,f2=false,false
    for _, pod in ipairs(pods:GetChildren()) do
        for _, d in ipairs(pod:GetDescendants()) do
            if d.Name=="AnimalOverhead" then
                local n = d:FindFirstChild("DisplayName") or d:FindFirstChild("Name")
                local t = n and n.Text or ""
                if t=="Trippi Troppi" then f1=true end
                if t=="Gangster Footera" then f2=true end
            end
        end
    end
    return f1 and f2
end

local function rebirth()
    local node = RS:FindFirstChild("Packages")
    node = node and node:FindFirstChild("Net")
    node = node and node:FindFirstChild("RF/Rebirth/RequestRebirth")
    if node and node.InvokeServer then
        pcall(function() node:InvokeServer() end)
    end
end

local function hasTool(toolName)
    return backpack:FindFirstChild(toolName) ~= nil
end

local function equipTool(toolName)
    local tool = backpack:FindFirstChild(toolName)
    if tool then
        humanoid:EquipTool(tool)
        return tool
    end
    return nil
end

local function autoFish()
    local fishingRod = equipTool("Fishing Rod")
    if not fishingRod then
        print("No fishing rod in eq (Is flood active?)")
        return
    end
    fishingRod:Activate()
    task.wait(2)
    CastEvent:FireServer(1)

    repeat 
        task.wait(0.1)
    until fishingRod:GetAttribute("minigame")

    while fishingRod:GetAttribute("minigame") do
        if fishingRod:GetAttribute("minigame") then
            MinigameClick:FireServer()
        end
        task.wait(0.1)
    end
    task.wait(0.5)
    humanoid:UnequipTools()
    -- CancelEvent:FireServer()
end

local myPlot = ensureMyPlot()
task.wait(1)

while true do
    if not myPlot or not myPlot.Parent then
        myPlot = ensureMyPlot()
    end

    if rebirths and rebirths.Value and rebirths.Value >= 1 then
        pcall(function() player:Kick("done") end)
        break
    end

    while not cashValue do
        task.wait(1)
    end

    while not hasTool("Fishing Rod") do
        print("Flood not active...")
        task.wait(2)
    end
    print("Flood started")

    while cashValue.Value < 500000 do
        local lockButton = myPlot:WaitForChild("Purchases"):FindFirstChild("PlotBlock"):FindFirstChild("Main")
        -- if isBasePart(lockButton) then
        --     walkToDynamic(lockButton, 3, 10)
        -- end
        task.wait(1)
        -- spamJump(3)
        -- if countOwned(myPlot) > 0 then 
            -- task.spawn(function() sellCheapest(myPlot) end)
            -- task.wait(6)
            -- print('collected coins')
        -- end

        local skip = false
        task.spawn(function()
            while countOwned(myPlot) > 0 and not skip do
                sellCheapest(myPlot)
                task.wait(1)
            end
        end)
        task.wait(10)
        skip = true

        task.wait(1)
        if countOwned(myPlot) <= 6 then
            autoFish()
        end
        task.wait(3)
    end
    
    if cashValue and cashValue.Value and cashValue.Value >= 500000 then
        local skip = false
        task.spawn(function()
            while countOwned(myPlot) > 0 and not skip do
                sellCheapest(myPlot)
                task.wait(1)
            end
        end)
        task.wait(10)
        skip = true
        while not hasRequired(myPlot) do
            local skip = false
            task.spawn(function()
                while countOwned(myPlot) > 6 and not skip do
                    sellCheapest(myPlot)
                    task.wait(1)
                end
            end)
            task.wait(5)
            skip = true
            local animals = getMovingAnimals()
            for _, entry in ipairs(animals) do
                local y = math.abs(entry.part.Orientation.Y)
                print(y)
                if not y then 
                    print('no orientation???/')
                end

                if y < 175.0 or y > 185.0 then
                    continue
                end
                local oh = entry.model:FindFirstChild("AnimalOverhead", true)
                local dn = oh and (oh:FindFirstChild("DisplayName") or oh:FindFirstChild("Name"))
                local name = dn and dn.Text or ""

                if name == "Trippi Troppi" or name == "Gangster Footera" then
                    local retries = 0
                    while retries < 3 do
                        if cashValue.Value >= entry.price then
                            if walkToDynamic(entry.prompt, 2.5, 20) then
                                firePrompt(entry.prompt, 3, Enum.KeyCode.E)
                                task.wait(0.5)
                                break
                            else
                                spamJump(3)
                            end
                        end
                        retries += 1
                        task.wait(0.5)
                    end
                end
            end
            task.wait(1)
        end

        rebirth()
        pcall(function() player:Kick("done") end)
        break
    end

    -- local owned = countOwned(myPlot)
    -- if owned >= 10 then
    --     collectCoins(myPlot)
    --     sellCheapest(myPlot)
    --     task.wait(1.9)
    -- else
    --     local best = bestAffordable()
    --     if best and isBasePart(best.part) and best.prompt then
    --         if walkToDynamic(best.prompt, 2.5, 20) then
    --             firePrompt(best.prompt, 3, Enum.KeyCode.E)
    --             task.wait(0.3)
    --         else
    --             if cashValue and cashValue.Value and cashValue.Value <= 25 then
    --                 spamJump(10)
    --                 task.wait(2.5)
    --                 collectCoins(myPlot)
    --             else
    --                 task.wait(0.5)
    --             end
    --         end
    --     else
    --         if cashValue and cashValue.Value and cashValue.Value <= 25 then
    --             spamJump(10)
    --             task.wait(2.5)
    --             collectCoins(myPlot)
    --         else
    --             task.wait(0.5)
    --         end
    --     end
    -- end
    task.wait(0.4)
end
