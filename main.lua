local Players = game:GetService("Players")
local rebirths = Players.LocalPlayer:WaitForChild("leaderstats"):WaitForChild("Rebirths")

if rebirths.Value > 0 then 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sigmaboiethena/hopper/refs/heads/main/main.lua"))()
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sigmaboiethena/autoreb2/refs/heads/main/main.lua"))()
end
