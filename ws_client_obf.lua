-- Bootstrap: wait for game and WebSocket API to be ready
repeat task.wait() until game:IsLoaded() and WebSocket and WebSocket.connect

print("[Autoexec] Environment ready, running obfuscated script...")

-- Obfuscated code below (paste your full obfuscated code here)
local a = WebSocket.connect("ws://localhost:8765")

a.OnMessage:Connect(function(b)
    print("[WebSocket] Message received:", b)
    local c, d = b:match("([^,]+),(%d+)")
    if c and d then
        _G.CHB_ENC_CODE = c
        _G.CHB_PLACE_ID = tonumber(d)
        print("[Join Script] Running join loader...")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/JoinScript.lua"))()
    else
        print("[Error] Failed to parse join script data")
    end
end)

a.OnClose:Connect(function()
    print("[WebSocket] Connection closed. Reconnecting in 5 seconds...")
    task.wait(5)
end)

print("[WebSocket] Client started, connecting to ws://localhost:8765")
