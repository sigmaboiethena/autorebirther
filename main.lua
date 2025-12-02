-- Конфиг
local BACKEND_URL = "https://serverfetcher.onrender.com/"  -- Поменять на свой, в конце ссылки поставить /
local MIN_PLAYERS = 0                         -- /next фильтрует сервера с min_players

local WEBHOOKS = {
    -- admin ones
    -- ['https://discord.com/api/webhooks/1442175483994177567/mD0I1NtnsnAy5aocBcaNkQVSREz545SiAlAt8_Tu5yo54Y66wUb4dMZ72HJ8fuWvBOkR'] = {min = 1_000_000, max = 9_999_999},
    ['https://discord.com/api/webhooks/1442246699149168702/qIW_e9VjOha4G82Bej2ciVj50fAYyFARhcsVX_UqKFNoOG2HtmSsfILMC-sDSAogm0ho'] = {min = 10_000_000, max = 99_999_999},
    ['https://discord.com/api/webhooks/1442633477030674462/lWUD-f-K2Wy5l67zKLgAWzEipWV9crP6hZiKHzqHvUJtwcPCnl1VlKcWGXE5rulDUF6x'] = {min = 100_000_000, max = math.huge},
    -- user ones
    ['https://discord.com/api/webhooks/1442633779033411596/XnH3-3rlrj6NiNR7GVk6FhFszxkOmxZgzlg9ZoS8HAO17k1nte9TaoZr85uJHi9fPq7m'] = {min = 3_000_000, max = 9_999_999},
    ['https://discord.com/api/webhooks/1442633978270978059/1W0Dxr21NtsNaFXf0LxHVdkpPTqgmsmmxI2txVR9NWFr8ZOp8YcPR4fuegwnq3IauQxC'] = {min = 100_000_000, max = math.huge, highlight = true}
}

local brainRotImages = {
    ['default'] = "https://practicaltyping.com/wp-content/uploads/2020/07/gardenwallgreg.jpg",
    ['Swag Soda'] = "https://static.wikia.nocookie.net/stealabr/images/9/9f/Swag_Soda.png/revision/latest?cb=20251116003702",
    ['Mieteteira Bicicleteira'] = "https://static.wikia.nocookie.net/stealabr/images/6/6d/24_sin_t%C3%ADtulo_20251023155436.png/revision/latest?cb=20251125132431",
    ['La Secret Combinasion'] = "https://static.wikia.nocookie.net/stealabr/images/f/f2/Lasecretcombinasion.png/revision/latest?cb=20251006044448",
    ['67'] = "https://static.wikia.nocookie.net/stealabr/images/8/83/BOIIIIIII_SIX_SEVEN_%F0%9F%98%82%F0%9F%98%82%F0%9F%98%82%F0%9F%98%82%F0%9F%98%82%F0%9F%98%82%F0%9F%98%82%F0%9F%98%82%F0%9F%98%82%F0%9F%98%82.png/revision/latest?cb=20251129064658",
    ['Tang Tang Keletang'] = "https://static.wikia.nocookie.net/stealabr/images/8/8f/TangTang.png/revision/latest?cb=20251014024653",
    ['Eviledon'] = "https://static.wikia.nocookie.net/stealabr/images/7/78/Eviledonn.png/revision/latest?cb=20251012023919",
    ['Money Money Puggy'] = "https://static.wikia.nocookie.net/stealabr/images/0/09/Money_money_puggy.png/revision/latest?cb=20250928011934",
    ['Gobblino Uniciclino'] = "https://static.wikia.nocookie.net/stealabr/images/c/c5/Gobblino_Uniciclino.png/revision/latest?cb=20251126164826",
    ['Esok Sekolah'] = "https://static.wikia.nocookie.net/stealabr/images/2/2a/EsokSekolah2.png/revision/latest?cb=20250819001020",
    ['La Grande Combinasion'] = "https://static.wikia.nocookie.net/stealabr/images/d/d8/Carti.png/revision/latest?cb=20250909171004",
    ['Los Puggies'] = "https://static.wikia.nocookie.net/stealabr/images/c/c8/LosPuggies2.png/revision/latest?cb=20251109012744",
    ['Los Combinasionas'] = "https://static.wikia.nocookie.net/stealabr/images/3/36/Stop_taking_my_chips_im_just_a_baybeh.png/revision/latest?cb=20250909223756",
    ['Cooki and Milki'] = "https://static.wikia.nocookie.net/stealabr/images/9/9b/Cooki_and_milki.png/revision/latest?cb=20251106165517",
    ['Strawberry Elephant'] = "https://static.wikia.nocookie.net/stealabr/images/5/58/Strawberryelephant.png/revision/latest?cb=20250830235735",
    ['Dragon Cannelloni'] = "https://static.wikia.nocookie.net/stealabr/images/3/31/Nah_uh.png/revision/latest?cb=20250919124457",
    ['Spaghetti Tualetti'] = "https://static.wikia.nocookie.net/stealabr/images/b/b8/Spaghettitualetti.png/revision/latest?cb=20251122142032",
    ['Los Mobilis'] = "https://static.wikia.nocookie.net/stealabr/images/2/27/Losmobil.png/revision/latest?cb=20251012023251",
    ['Burguro And Fryuro'] = "https://static.wikia.nocookie.net/stealabr/images/6/65/Burguro-And-Fryuro.png/revision/latest?cb=20251007133840",
    ['Garama and Madundung'] = "https://static.wikia.nocookie.net/stealabr/images/e/ee/Garamadundung.png/revision/latest?cb=20250816022557",
    ['Nuclearo Dinossauro'] = "https://static.wikia.nocookie.net/stealabr/images/9/99/THERE_ARE_BUGS_UNDER_YOUR_SKIN.png/revision/latest?cb=20250902180735",
    ['Los Burritos'] = "https://static.wikia.nocookie.net/stealabr/images/9/97/LosBurritos.png/revision/latest?cb=20251123123907",
    ['Orcaledon'] = "https://static.wikia.nocookie.net/stealabr/images/a/a6/Orcaledon.png/revision/latest?cb=20251119170121",
    ['La Taco Combinasion'] = "https://static.wikia.nocookie.net/stealabr/images/8/84/Latacocombi.png/revision/latest?cb=20251030015001",
    ['Los Bros'] = "https://static.wikia.nocookie.net/stealabr/images/5/53/BROOOOOOOO.png/revision/latest?cb=20250909152032",
    ['Ketchuru and Musturu'] = "https://static.wikia.nocookie.net/stealabr/images/1/14/Ketchuru.png/revision/latest?cb=20251021163857",
    ['La Spooky Grande'] = "https://static.wikia.nocookie.net/stealabr/images/5/51/Spooky_Grande.png/revision/latest?cb=20251012022949",
    ['Los Spaghettis'] = "https://static.wikia.nocookie.net/stealabr/images/d/db/LosSpaghettis.png/revision/latest?cb=20251109012155",
    ['Los Spooky Combinasionas'] = "https://static.wikia.nocookie.net/stealabr/images/8/8a/Lospookycombi.png/revision/latest?cb=20251030015823",
    ['W or L'] = "https://static.wikia.nocookie.net/stealabr/images/2/28/Win_Or_Lose.png/revision/latest?cb=20251123084507",
    ['Tralaledon'] = "https://static.wikia.nocookie.net/stealabr/images/7/79/Brr_Brr_Patapem.png/revision/latest?cb=20250909171639",
    ['Tictac Sahur'] = "https://static.wikia.nocookie.net/stealabr/images/6/6f/Time_moving_slow.png/revision/latest?cb=20251103171934",
    ['Los Primos'] = "https://static.wikia.nocookie.net/stealabr/images/9/96/LosPrimos.png/revision/latest?cb=20251006044831",
    ['Lavadorito Spinito'] = "https://static.wikia.nocookie.net/stealabr/images/f/ff/Lavadorito_Spinito.png/revision/latest?cb=20251123122422",
    ['Los Nooo My Hotspotsitos'] = "https://static.wikia.nocookie.net/stealabr/images/c/cb/LosNooMyHotspotsitos.png/revision/latest?cb=20250903124000",
    ['Mariachi Corazoni'] = "https://static.wikia.nocookie.net/stealabr/images/5/5a/MariachiCora.png/revision/latest?cb=20251006211910",
    ['La Extinct Grande'] = "https://static.wikia.nocookie.net/stealabr/images/c/cd/La_Extinct_Grande.png/revision/latest?cb=20250914041757",
    ['Ketupat Kepat'] = "https://static.wikia.nocookie.net/stealabr/images/a/ac/KetupatKepat.png/revision/latest?cb=20251121154301",
    ['Tacorita Bicicleta'] = "https://static.wikia.nocookie.net/stealabr/images/0/0f/Gonna_rob_you_twin.png/revision/latest?cb=20251006133721",
    ['Los 67'] = "https://static.wikia.nocookie.net/stealabr/images/d/db/Los-67.png/revision/latest?cb=20251103171526",
    ['Tang Tang Keletang'] = "https://static.wikia.nocookie.net/stealabr/images/8/8f/TangTang.png/revision/latest?cb=20251014024653",
    ['Capitano Moby'] = "https://static.wikia.nocookie.net/stealabr/images/e/ef/Moby.png/revision/latest?cb=20251101185416",
    -- 10m
    ['Los Cucarachas'] = "https://static.wikia.nocookie.net/stealabr/images/a/ac/Los_Cucarachas_no_effect.png/revision/latest?cb=20251125124717",
    ['To to to Sahur'] = "https://static.wikia.nocookie.net/stealabr/images/5/58/Africa_by_toto_%28to_sahur%29.png/revision/latest?cb=20250924041210",
    ['Horegini Boom'] = "https://static.wikia.nocookie.net/stealabr/images/5/51/Hboom.png/revision/latest?cb=20251018135659",
    ['Burrito Bandito'] = "https://static.wikia.nocookie.net/stealabr/images/e/e6/PoTaTo.png/revision/latest?cb=20251022160548",
    ['Quesadilla Crocodila'] = "https://static.wikia.nocookie.net/stealabr/images/3/3f/QuesadillaCrocodilla.png/revision/latest?cb=20251006143118",
    ['Tung Tung Tung Sahur'] = "https://static.wikia.nocookie.net/stealabr/images/0/05/TungTungSahur.png/revision/latest?cb=20251129214723",
    ['Pot Hotspot'] = "https://static.wikia.nocookie.net/stealabr/images/4/4b/Pot_Hotspot.png/revision/latest?cb=20250915194349",
    ['Los Jobcitos'] = "https://static.wikia.nocookie.net/stealabr/images/a/af/LosJobcitos.png/revision/latest?cb=20251006202121",
    ['Graipuss Medussi'] = "https://static.wikia.nocookie.net/stealabr/images/b/b8/Graipuss.png/revision/latest?cb=20250816173622",
    ['La Cucaracha'] = "https://static.wikia.nocookie.net/stealabr/images/4/46/La_Cucaracha.png/revision/latest?cb=20250920195538",
    ['Pumpkini Spyderini'] = "https://static.wikia.nocookie.net/stealabr/images/d/da/Sammypumpkin.png/revision/latest?cb=20251030021310",
    ['Cuadramat and Pakrahmatmamat'] = "https://static.wikia.nocookie.net/stealabr/images/a/a3/Cuadramat.png/revision/latest?cb=20251126164937",
    ['Los Quesadillas'] = "https://static.wikia.nocookie.net/stealabr/images/9/99/LosQuesadillas.png/revision/latest?cb=20251123123650",
    ['Guerriro Digitale'] = "https://static.wikia.nocookie.net/stealabr/images/9/98/Guerrirodigitale.png/revision/latest?cb=20250830234708",
    ['Los Tipi Tacos'] = "https://static.wikia.nocookie.net/stealabr/images/f/f2/Los_tipi_tacos.png/revision/latest?cb=20250914130151",
    ['Zombie Tralala'] = "https://static.wikia.nocookie.net/stealabr/images/6/62/ZombieTralala.png/revision/latest?cb=20251012025915",
    ['Las Tralaleritas'] = "https://static.wikia.nocookie.net/stealabr/images/f/f4/LasTralaleritas.png/revision/latest?cb=20250817183119",
    ['Fragrama and Chocrama'] = 'https://static.wikia.nocookie.net/stealabr/images/5/56/Fragrama.png/revision/latest?cb=20251109011733',
    ['Los Tralaleritos'] = 'https://static.wikia.nocookie.net/stealabr/images/0/0f/Los_Tralaleritos.png/revision/latest?cb=20250816183135',
    ['Chicleteira Bicicleteira'] = 'https://static.wikia.nocookie.net/stealabr/images/5/5a/Chicleteira.png/revision/latest?cb=20250921012655',
    ['Job Job Job Sahur'] = 'https://static.wikia.nocookie.net/stealabr/images/0/03/Job.webp/revision/latest?cb=20250817162104',
    ['Chillin Chili'] = "https://static.wikia.nocookie.net/stealabr/images/e/e0/Chilin.png/revision/latest?cb=20251006204612",
    ['Los Chicleteiras'] = "https://static.wikia.nocookie.net/stealabr/images/4/4d/Los_ditos.png/revision/latest?cb=20250928224101",
    
}


-- Рефреш (было 0.40, сделал 0.30)
local WEBHOOK_REFRESH = 0.30
local MODEL_MAX_SIZE = 40

-- Телепорт (настройки)
local TP_MIN_GAP_S     = 1
local TP_JITTER_MIN_S  = 0.5
local TP_JITTER_MAX_S  = 0.5
local TP_STUCK_TIMEOUT = 12.0

-- Сервисы
local HttpService     = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players         = game:GetService("Players")
local CoreGui         = game:GetService("CoreGui")
local LocalPlayer     = Players.LocalPlayer

task.spawn(function()
    -- 1) Отключаем 3D графику
    local RunService = game:GetService("RunService")

    while true do
        pcall(function()
            RunService:Set3dRenderingEnabled(false)
        end)
        task.wait(1)
    end
end)

-- task.spawn(function() useless, fishstrap should cap fps without some warning
--     -- 2) Ставим очень низкий FPS (для нагрузки)
--     pcall(function()
--         if setfpscap then setfpscap(30) end
--     end)
-- end)

task.spawn(function()
    -- 3) Ловим любые попытки Roblox включить рендер
    local workspace = game:GetService("Workspace")

    while true do
        pcall(function()
            -- Стриминг: меньше загружается карта -> быстрее хоп
            workspace.StreamingEnabled = true
            workspace.StreamingMinRadius = 16
            workspace.StreamingTargetRadius = 32

            -- Удаление ненужных эффектов
            if workspace.CurrentCamera then
                workspace.CurrentCamera.FieldOfView = 30
            end
        end)
        task.wait(2)
    end
end)


-- ==========================================================
-- Анти-АФК (без ошибок при раннем запуске)
-- ==========================================================
task.spawn(function()
    while not Players.LocalPlayer do
        task.wait()
    end

    local vu = game:GetService("VirtualUser")

    Players.LocalPlayer.Idled:Connect(function()
        pcall(function()
            vu:CaptureController()
            vu:ClickButton2(Vector2.new())
        end)
    end)
end)

-- ==========================================================
-- HTTP helper
-- ==========================================================
local request = rawget(_G, "http_request")
    or rawget(_G, "request")
    or (syn and syn.request)
    or (http and http.request)

local function postJSON(path, tbl)
    local url  = BACKEND_URL .. path
    local body = HttpService:JSONEncode(tbl or {})
    if request then
        local ok, resp = pcall(function()
            return request({
                Url = url,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = body
            })
        end)
        if not ok or not resp or not (resp.Body or resp.body) then return nil end
        local ok2, data = pcall(function()
            return HttpService:JSONDecode(resp.Body or resp.body)
        end)
        if not ok2 then return nil end
        return data
    else
        local ok, raw = pcall(function()
            return HttpService:PostAsync(url, body, Enum.HttpContentType.ApplicationJson)
        end)
        if not ok then return nil end
        local ok2, data = pcall(function()
            return HttpService:JSONDecode(raw)
        end)
        if not ok2 then return nil end
        return data
    end
end

-- ==========================================================
-- Монитор зависания JobID (мягкий рестарт логики)
-- ==========================================================
local lastJobIdOkTime    = os.clock()
local consecutiveNoJobId = 0
local NO_JOBID_STALL_TIME = 120   -- 120 сек без нормального JobID => мягкий ресет
local MAX_CONSECUTIVE_NOJOB = 40  -- 40 подряд пустых ответов => ресет
local softResetInProgress = false

local function markJobIdOk()
    lastJobIdOkTime    = os.clock()
    consecutiveNoJobId = 0
end

local function markJobIdFail()
    consecutiveNoJobId = consecutiveNoJobId + 1
end

local function softResetJobFlow(reason)
    if softResetInProgress then return end
    softResetInProgress = true

    warn("[JOBID RESET] мягкий рестарт логики /next: " .. tostring(reason or "нет причины"))

    -- Попробуем освободить текущий ключ на бэкенде
    pcall(function()
        postJSON("release", {
            placeId = game.PlaceId,
            key     = tostring(game.JobId)
        })
    end)

    -- Сбрасываем локальные счётчики/тайминги
    lastJobIdOkTime    = os.clock()
    consecutiveNoJobId = 0
    lastAttemptJobId   = nil
    lastTeleportAt     = 0
    lastFailAt         = 0

    -- Даем бэкенду «подышать»
    task.delay(6, function()
        softResetInProgress = false
        warn("[JOBID RESET] мягкий рестарт завершён, продолжаем работу")
    end)
end

-- фоновый вотчдог на случай полной тишины
task.spawn(function()
    while true do
        local dt = os.clock() - lastJobIdOkTime
        if dt > NO_JOBID_STALL_TIME and not softResetInProgress then
            softResetJobFlow("watchdog: " .. math.floor(dt) .. " секунд без JobID")
        end
        task.wait(10)
    end
end)

-- ==========================================================
-- /next: minPlayers + JobID (с учётом мониторинга)
-- ==========================================================
local function nextServer()
    local data = postJSON("next", {
        placeId    = game.PlaceId,
        currentJob = game.JobId,
        minPlayers = MIN_PLAYERS,
    })
    print('fetched next ()')
    if type(data) == "table" and data.ok and data.id then
        markJobIdOk()
        return tostring(data.id)
    end

    markJobIdFail()

    if (consecutiveNoJobId >= MAX_CONSECUTIVE_NOJOB)
        or ((os.clock() - lastJobIdOkTime) > NO_JOBID_STALL_TIME) then
        softResetJobFlow("nextServer: слишком долго нет JobID")
    end

    task.wait(0.2)
    return nil
end

local function releaseKey(serverId)
    if not serverId then return end
    pcall(function()
        postJSON("release", { placeId = game.PlaceId, key = tostring(serverId) })
    end)
end

-- ==========================================================
-- Телепорт: повтор через бэкенд + джиттер + кулдавн + ватчдог
-- ==========================================================
local lastAttemptJobId, lastFailAt = nil, 0
local lastTeleportAt = 0

local function jitter()
    local j = math.random(
        math.floor(TP_JITTER_MIN_S * 1000),
        math.floor(TP_JITTER_MAX_S * 1000)
    ) / 1000
    task.wait(j)
end

local rebirths = Players.LocalPlayer:WaitForChild("leaderstats"):WaitForChild("Rebirths")
function tryTeleportTo(jobId)
    print('trying tp ', jobId)
    local now = os.clock()
    local gap = now - (lastTeleportAt or 0)
    if gap < TP_MIN_GAP_S then
        task.wait(TP_MIN_GAP_S - gap)
    end
    jitter()
    print('ass')
    lastAttemptJobId = tostring(jobId)
    -- task.wait(15)
    local ok = pcall(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, lastAttemptJobId, LocalPlayer)
    end)
    lastTeleportAt = os.clock()
    print('im not ok')
    if not ok then
        task.spawn(releaseKey, lastAttemptJobId)
        return false
    end
    print('im a flashlight hbu')
    print(rebirths.Value)
    -- ватчдог: если телепорт завис, берёт следующий
    task.spawn(function()
        local start = os.clock()
        task.wait(TP_STUCK_TIMEOUT)
        if (lastFailAt < start) and rebirths.Value > 0 then
            local nid = nextServer()
            if nid then tryTeleportTo(nid) end
        end
    end)
    return true
end

TeleportService.TeleportInitFailed:Connect(function(_, _, msg)
    print('tp failed')
    lastFailAt = os.clock()
    if lastAttemptJobId then
        task.spawn(releaseKey, lastAttemptJobId)
    end
    task.wait(0.6)
    local nextId = nextServer()
    if nextId and rebirths.Value > 0 then tryTeleportTo(nextId) end
end)

-- ==========================================================
-- /JOINED: Успешный вход (Бэкенд блокирует на 1 час)
-- ==========================================================
shared.__QUESAID_LAST_MARKED__ = shared.__QUESAID_LAST_MARKED__ or nil
local function markJoinedOnce()
    local jid = tostring(game.JobId)
    if shared.__QUESAID_LAST_MARKED__ == jid then return end
    shared.__QUESAID_LAST_MARKED__ = jid
    task.delay(2.0, function()
        pcall(function()
            postJSON("joined", { placeId = game.PlaceId, serverId = jid })
        end)
    end)
end

task.spawn(function()
    if not game:IsLoaded() then
        pcall(function() game.Loaded:Wait() end)
    end
    markJoinedOnce()
end)
pcall(function()
    Players.LocalPlayer.CharacterAdded:Connect(markJoinedOnce)
end)
task.spawn(function()
    local last = nil
    while true do
        local jid = tostring(game.JobId)
        if jid ~= last then
            last = jid
            markJoinedOnce()
        end
        task.wait(5)
    end
end)

-- ==========================================================
-- Парсер MPS для вебхуков
-- ==========================================================
local BLOCK_WORDS = {
    rainbow=true, gold=true, diamond=true, mythic=true, mythical=true,
    secret=true, legendary=true, epic=true, rare=true, common=true, god=true, godly=true,
    ["yin"]=true, ["yang"]=true, ["yin-yang"]=true, ["yin_yang"]=true,
    shiny=true, mega=true, giga=true, ["stolen"]=true, ["collect"]=true,
    ["owner"]=true, ["press"]=true, ["hold"]=true, ["click"]=true,
    ["equip"]=true, ["unequip"]=true, ["upgrade"]=true, ["craft"]=true, ["merge"]=true,
    ["vip"]=true, ["event"]=true
}

local function stripRichText(s)
    s = type(s) == "string" and s or ""
    s = s:gsub("<.->", "")
    s = s:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
    return s
end

local function isMoneyLine(s)
    local l = (s or ""):lower()
    return l:find("%$") or l:find("/s") or l:find("b/s") or l:find("m/s") or l:find("k/s")
end

local function isAllCaps(s)
    local letters = (s or ""):gsub("[^%a]", "")
    if #letters < 3 then return false end
    return letters:upper() == letters
end

local function hasOnlyBlockedWords(s)
    local any = false
    for w in (s or ""):gmatch("%S+") do
        local k = w:lower():gsub("[^%a%-_]", "")
        if k ~= "" then
            any = true
            if not BLOCK_WORDS[k] then return false end
        end
    end
    return any
end

local function scoreName(raw)
    local s = stripRichText(raw or "")
    if s == "" then return -1, "" end
    if isMoneyLine(s) then return -1, "" end
    if s:match("^%d+$") then
        local n = #s
        if n >= 2 and n <= 4 then
            return 100, s
        else
            return -1, ""
        end
    end
    if s:find("%d") then return -1, "" end
    if isAllCaps(s) or hasOnlyBlockedWords(s) then return -1, "" end
    local len = #s
    local words = 0
    for _ in s:gmatch("%S+") do words = words + 1 end
    local sc = 0
    sc = sc + math.min(len, 36)
    if words >= 2 and words <= 5 then sc = sc + 25 end
    if s:match("^[%u]") and not s:match("^[%u%s%-_']+$") then sc = sc + 3 end
    if s:find("[%.%,%!%?]") then sc = sc - 2 end
    return sc, s
end

local function parseMPS(s)
    if type(s) ~= "string" then return nil end
    local t = s:gsub(",", ""):gsub("%s+", "")
    local n, u = t:match("%$?([%d%.]+)([kKmMbB]?)/[sS]")
    if not n then return nil end
    local v = tonumber(n)
    if not v then return nil end
    local mult = (u == "k" or u == "K") and 1e3
        or (u == "m" or u == "M") and 1e6
        or (u == "b" or u == "B") and 1e9
        or 1
    return v * mult
end

local function shortMoney(v)
    v = tonumber(v) or 0
    if v >= 1e9 then
        local formatted = string.format("%.2f", v / 1e9):gsub("%.?0+$", "")
        return "$" .. formatted .. "B/s"
    elseif v >= 1e6 then
        local formatted = string.format("%.2f", v / 1e6):gsub("%.?0+$", "")
        return "$" .. formatted .. "M/s"
    elseif v >= 1e3 then
        return string.format("$%.0fK/s", v / 1e3)
    else
        return string.format("$%d/s", math.floor(v))
    end
end

local function firstBasePart(m)
    if m:IsA("Model") and m.PrimaryPart then return m.PrimaryPart end
    for _, d in ipairs(m:GetDescendants()) do
        if d:IsA("BasePart") then return d end
    end
end

local function scanModel(m)
    print('scanning model ', m.Name)
    if not m:IsA("Model") then return end

    local animalPodiums = m:FindFirstChild("AnimalPodiums")
    if not animalPodiums then return end

    local plotSign = m:FindFirstChild("PlotSign")
    if not plotSign then return end

    local surface = plotSign:FindFirstChild("SurfaceGui")
    if not surface then return end

    local frame = surface:FindFirstChildOfClass("Frame")
    local label = frame and frame:FindFirstChildOfClass("TextLabel")
    local owner = label and label.Text:match("([^']+)") or "Unknown"

    local all = {}
    local bestMPS = nil
    local bestName = m.Name

    for _, podium in ipairs(animalPodiums:GetChildren()) do
        local base = podium:FindFirstChild("Base")
        if not base then continue end

        local spawn = base:FindFirstChild("Spawn")
        if not spawn then continue end

        local attachment = spawn:FindFirstChild("Attachment")
        if not attachment then continue end

        local gui = attachment:FindFirstChildOfClass("BillboardGui")
        if not gui then continue end

        local gen = gui:FindFirstChild("Generation")
        if not gen then continue end

        local money = parseMPS(gen.Text or "")
        if not money then continue end

        local name = gui:FindFirstChild("DisplayName")
        name = name and name.Text or "?"
        
        if money > 5_000_000 then
            table.insert(all, { name = name, money = money })
        end

        if not bestMPS or money > bestMPS then
            bestMPS = money
            bestName = name
        end
    end

    if #all > 1 then
        table.sort(all, function(a, b) return a.money > b.money end)
    end

    return bestName, bestMPS, owner, all
end


-- =========================
-- Флаг: был ли отправлен хоть один вебхук
-- =========================

-- Надёжная отправка вебхуков (5 попыток)
local function sendWebhookReliable(url, data)
    if url == "" or url == nil then return end
    if not request then return end

    local json = HttpService:JSONEncode(data)

    for attempt = 1, 5 do
        local ok, resp = pcall(function()
            return request({
                Url = url,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = json
            })
        end)

        if ok and resp and (resp.StatusCode == 200 or resp.StatusCode == 204) then
            return true
        end

        task.wait(0.35 * attempt)
    end

    warn("[WEBHOOK] Failed after 5 attempts")
    return false
end

-- Вебхуки

local function sendWebhook(name, mps, url, fields, color, all, owner)
    if url == "" or not url then return end

    local placeId = game.PlaceId
    local jobId = game.JobId
    local formattedJobId = string.format("%s-%s-%s-%s-%s",
        string.sub(jobId, 1, 8),
        string.sub(jobId, 10, 13),
        string.sub(jobId, 15, 18),
        string.sub(jobId, 20, 23),
        string.sub(jobId, 25, 36)
    )

    local browserLink = "https://www.roblox.com/games/" .. tostring(placeId) .. "/?gameInstanceId=" .. tostring(jobId)
    local joinScript = 'game:GetService("TeleportService"):TeleportToPlaceInstance('
        .. tostring(placeId) .. ',"' .. tostring(jobId) .. '",game.Players.LocalPlayer)'

    local formattedMps = shortMoney(mps)
    local image = brainRotImages[tostring(name)] or brainRotImages["default"]

    local embed = {
        title = "🙉 Brainrot Notify",
        color = color or 16711680,
        fields = fields or {
            { name = "🏷️ Name", value = "**" .. tostring(name or "Unknown") .. "**", inline = true },
            { name = "💰 Money per sec", value = "**" .. formattedMps .. "**", inline = true },
            { name = "**👥 Players:**", value = "**" .. tostring(math.max(#Players:GetPlayers() - 1, 0))
                .. "**/**" .. tostring(Players.MaxPlayers or 0) .. "**", inline = true },
            -- { name = "**📱 Job-ID (Mobile):**", value = tostring(jobId), inline = false },
            { name = "**😱 Owner:**", value = '```'..tostring(owner or 'Unknown')..'```', inline = true },
            { name = "**🎭 All Brainrots (>5m/s)**", value = "```" .. all .. "```", inline = false },

            { name = "**Job ID: **", value = "```" .. tostring(formattedJobId) .. "```", inline = false },
            -- { name = "**🌐Join Link**", value = "[**Click to Join**](" .. browserLink .. ")", inline = false },
            { name = "**📜Join Script**", value = "```" .. joinScript .. "```", inline = false },
        },
        thumbnail = {
            url = image
        }, 
        footer = { text = "Made by Ethena Team since 1987 • Today at " .. os.date("%H:%M") }
    }

    sendWebhookReliable(url, { embeds = { embed } })
end

local function formatEntry(entry)
    return string.format("%s | %s", entry.name, shortMoney(entry.money))
end

local function formatList(list)
    local lines = {}
    for _, entry in ipairs(list) do
        table.insert(lines, formatEntry(entry))
    end
    return table.concat(lines, "\n")
end

local sentKeys = {}

local function useNotify(name, mps, owner, all)
    local urls = {}

    local key = tostring(game.JobId) .. "|" .. tostring(name) .. "|" .. tostring(math.floor(mps or 0))
    if sentKeys[key] then return end
    sentKeys[key] = true
    print('not sent yet')

    for url, range in pairs(WEBHOOKS) do
        if mps >= range.min and mps <= range.max then
            table.insert(urls, url)
            print('inserted url: ')
        end
    end

    local allBrainrots = formatList(all or {})

    for _, url in ipairs(urls) do
        local highlight = WEBHOOKS[url].highlight
        local fields = highlight and {
            { name = "🏷️ Name", value = "**__" .. tostring(name or "Unknown") .. "__**", inline = true },
            { name = "💰 Money per sec", value = "**__" .. shortMoney(mps) .. "__**", inline = true },
            { name = "**👥 Players:**", value = "**__" .. tostring(math.max(#Players:GetPlayers() - 1, 0))
                .. "__/**__" .. tostring(Players.MaxPlayers or 0) .. "__", inline = true },
        } or nil
        local color = (highlight or mps >= 100_000_000) and 16766720 or nil
        print('sending webhook', name, mps, url, fields)
        task.spawn(function()
            sendWebhook(name, mps, url, fields, color, allBrainrots, owner)
        end)
    end
end

-- ==========================================================
-- 🔥 РАННИЙ СКАНЕР WORKSPACE — ловит модели ещё до полной загрузки
-- ==========================================================
local earlyScanned = {}

task.spawn(function()
    task.wait()
    workspace.DescendantAdded:Connect(function(obj)
        if earlyScanned[obj] then return end
        earlyScanned[obj] = true

        task.wait(0.05)
        -- task.wait(1000)
        local name, mps, owner, all = scanModel(obj)
        if not mps then return end

        if mps > 0 then
            useNotify(name or obj.Name, mps, owner, all)
        end
    end)
end)

-- ==========================================================
-- Анти-кик реджоин через бэкенд
-- ==========================================================
local rejoinBusy = false
local function rejoinViaBackend()
    if rejoinBusy then return end
    rejoinBusy = true
    local tries = 0
    while tries < 6 do
        local id = nextServer()
        if id then
            local ok = tryTeleportTo(id)
            if ok then
                task.delay(10, function() rejoinBusy = false end)
                return true
            end
        end
        tries = tries + 1
        task.wait(0.6 + 0.4 * tries)
    end
    pcall(function()
        -- TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end)
    task.delay(10, function() rejoinBusy = false end)
    return false
end

task.spawn(function()
    while true do
        local prompt = CoreGui:FindFirstChild("RobloxPromptGui")
        if prompt then
            local overlay = prompt:FindFirstChild("promptOverlay")
            if overlay then
                local ep = overlay:FindFirstChild("ErrorPrompt")
                if ep and ep.Visible then
                    local hasText = false
                    pcall(function()
                        local msg = tostring(
                            ep.MessageArea
                            and ep.MessageArea.ErrorFrame
                            and ep.MessageArea.ErrorFrame.ErrorMessage
                            and ep.MessageArea.ErrorFrame.ErrorMessage.Text
                            or ""
                        )
                        if msg ~= "" then
                            local lower = msg:lower()
                            if lower:find("disconnect")
                                or lower:find("reconnect")
                                or lower:find("error code")
                                or lower:find("279")
                                or lower:find("277") then
                                hasText = true
                            end
                        end
                    end)
                    if hasText then
                        rejoinViaBackend()
                    end
                end
            end
        end
        task.wait(1.3)
    end
end)

-- ==========================================================
-- Главный цикл для вебхуков (парсер)
-- ==========================================================
task.spawn(function()
    while true do
        local bestModel, bestName, bestMPS, bestowner, bestall = nil, nil, -1, nil, nil

        for _, m in ipairs(workspace:WaitForChild("Plots"):GetChildren()) do
            print('PLOT: ', m.Name)
            local nm, mps, owner, all = scanModel(m)
            if mps then
                if mps > bestMPS then
                    bestMPS, bestModel, bestName, bestowner, bestall = mps, m, nm, owner, all
                end
            end
        end

        if bestModel and bestMPS > 0 then
            useNotify(bestName or bestModel.Name, bestMPS, bestowner, bestall)
        end

        task.wait(WEBHOOK_REFRESH)
    end
end)

-- ==========================================================
-- 🧠 ONE-SHOT BRAINROT HOPPER (режим B — с ретраями + мониторинг)
-- ==========================================================
local function getNextJob_oneShot()
    local data = postJSON("next", {
        placeId    = game.PlaceId,
        currentJob = game.JobId,
        minPlayers = MIN_PLAYERS
    })
    print('fetched next (oneshot)')
    if type(data) == "table" and data.ok and data.id then
        markJobIdOk()
        return tostring(data.id)
    end
    markJobIdFail()
    if (consecutiveNoJobId >= MAX_CONSECUTIVE_NOJOB)
        or ((os.clock() - lastJobIdOkTime) > NO_JOBID_STALL_TIME) then
        softResetJobFlow("getNextJob_oneShot: долго нет JobID")
    end
    return nil
end

local function oneShotHop()
    local jobId
    -- 🔁 Делаем до 12 попыток получить JobID
    for attempt = 1, 12 do
        print(string.format("[ONE-SHOT] Попытка %d получить Job ID...", attempt))
        jobId = getNextJob_oneShot()
        if jobId then
            break
        end
        -- маленькая пауза между попытками (увеличивается)
        task.wait(0.25 + attempt * 0.07)
    end

    if not jobId then
        warn("[ONE-SHOT] Не удалось получить Job ID даже после 12 попыток.")
        return
    end

    print("[ONE-SHOT] Получен Job ID:", jobId)

    -- ⏱ даём чуть-чуть времени, чтобы ранний сканер/лог успел отработать
    task.wait(math.random(45, 70) / 100) -- 0.45–0.70 сек
    -- task.wait(15)
    pcall(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, jobId, LocalPlayer)
    end)
end

-- Запуск one-shot хопера (после появления персонажа)
task.spawn(function()
    local lp = Players.LocalPlayer
    while not lp do
        task.wait()
        lp = Players.LocalPlayer
    end

    local character = lp.Character
    if not character then
        character = lp.CharacterAdded:Wait()
    end

    task.wait(0.10)
    oneShotHop()
end)

-- Конец файла
-- ペニス、ペニス、スプーン
