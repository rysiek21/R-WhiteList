ESX, ListWhiteList = nil, {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function loadWhiteList()
    ListWhiteList = {}
    local IDs = MySQL.Sync.fetchAll('SELECT identifier FROM whitelist')
    for k,v in ipairs(IDs) do
        ListWhiteList[k] = v.identifier
    end
end

MySQL.ready(function()
	loadWhiteList()
end)

function OnPlayerConnecting(name, setKickReason, deferrals)
    local isOnWhiteList
    local player = source
    local steamIdentifier
    local identifiers = GetPlayerIdentifiers(player)
    deferrals.defer()


    Wait(0)

    deferrals.update(string.format("Checking WhiteList...", name))

    Wait(1000)

    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end
    print(steamIdentifier)

    Wait(0)

    if not steamIdentifier then
        deferrals.done("Run Steam and connect again.")
    else
        loadWhiteList()
        Wait(100)
        for k,x in pairs(ListWhiteList) do
            if x == steamIdentifier then
                isOnWhiteList = true
                break
            end
        end
        if isOnWhiteList == true then
            deferrals.done()
        else
            deferrals.done("You are not whitelisted!")
        end
    end
end

AddEventHandler("playerConnecting", OnPlayerConnecting)