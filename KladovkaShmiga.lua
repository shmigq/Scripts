        local DarkraiX = loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Kavo-Ui/main/Darkrai%20Ui", true))()

        local Library = DarkraiX:Window("KladovkaDH","","",Enum.KeyCode.RightControl);

        --[[
        DarkraiX:Window(
        1 = Name Of Your Ui Library (string)
        2 = Game Name (You Can Keep This Empty To Get The Current Game Name!) (string)
        3 = A Logo If You Have One! (string)
        4 = Ui Library Toggle (I'll Not Prefer Touching It) (function)
        );
        ]]
        Tab1 = Library:Tab("Main")
        Tab2 = Library:Tab("Toggles")
        Tab3 = Library:Tab("Fun")
        Tab4 = Library:Tab("Visuals")

        --[[
        Library:Tab(
        1 = Your Tab Name! (string)
        )
        ]]Tab1:Button("Full-God",function()
            local localPlayer = game:GetService('Players').LocalPlayer;
                        local localCharacter = localPlayer.Character;
                        localCharacter:FindFirstChildOfClass('Humanoid').Health = 0;
                        local newCharacter = localPlayer.CharacterAdded:Wait();
                        local spoofFolder = Instance.new('Folder');
                        spoofFolder.Name = 'FULLY_LOADED_CHAR';
                        spoofFolder.Parent = newCharacter;
                        newCharacter:WaitForChild('RagdollConstraints'):Destroy();
                        local spoofValue = Instance.new('BoolValue', newCharacter);
                        spoofValue.Name = 'RagdollConstraints';
                        local name = game.Players.LocalPlayer.Name
                        local lol =    game.Workspace:WaitForChild(name)
                        local money = Instance.new("Folder",game.Players.LocalPlayer.Character);money.Name = "FULLY_LOADED_CHAR"
                        lol.Parent = game.Workspace.Players
                        game.Players.LocalPlayer.Character:WaitForChild("BodyEffects")
                        game.Players.LocalPlayer.Character.BodyEffects.BreakingParts:Destroy()
        end)

        --[[
        Tab1:Button(
        1 = Button Name (string)
        2 = callback (function)
        ]]
        Tab1:Button("Chat Spy",function()
            -- This is not mine, unsure who made it but i didn't create this

        -- // Initialise
        --if (getgenv().ChatSpy) then return getgenv().ChatSpy; end;
        repeat wait() until game:GetService("ContentProvider").RequestQueueSize == 0;
        repeat wait() until game:IsLoaded();

        -- // Vars
        local Players = game:GetService("Players");
        local StarterGui = game:GetService("StarterGui");
        local ReplicatedStorage = game:GetService("ReplicatedStorage");
        local LocalPlayer = Players.LocalPlayer;
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
        local DefaultChatSystemChatEvents = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents");
        local SayMessageRequest = DefaultChatSystemChatEvents:WaitForChild("SayMessageRequest");
        local OnMessageDoneFiltering = DefaultChatSystemChatEvents:WaitForChild("OnMessageDoneFiltering");
        getgenv().ChatSpy = {
            Enabled = true,
            SpyOnSelf = false,
            Public = false,
            Chat = {
                Colour  = Color3.fromRGB(255, 0, 0),
                Font = Enum.Font.SourceSans,
                TextSize = 18,
                Text = "",
            },
            IgnoreList = {
                {Message = ":part/1/1/1", ExactMatch = true},
                {Message = ":part/10/10/10", ExactMatch = true},
                {Message = "A?????????", ExactMatch = false},
                {Message = ":colorshifttop 10000 0 0", ExactMatch = true},
                {Message = ":colorshiftbottom 10000 0 0", ExactMatch = true},
                {Message = ":colorshifttop 0 10000 0", ExactMatch = true},
                {Message = ":colorshiftbottom 0 10000 0", ExactMatch = true},
                {Message = ":colorshifttop 0 0 10000", ExactMatch = true},
                {Message = ":colorshiftbottom 0 0 10000", ExactMatch = true},
            },
        };

        -- // Function
        function ChatSpy.checkIgnored(message)
            for i = 1, #ChatSpy.IgnoreList do
                local v = ChatSpy.IgnoreList[i];
                if (v.ExactMatch and message == v.Message) or (not v.ExactMatch and string.match(v.Message, message)) then 
                    return true;
                end;
            end;
            return false;
        end;

        function ChatSpy.onChatted(targetPlayer, message)
            if (targetPlayer == LocalPlayer and string.lower(message):sub(1, 4) == "/spy") then
                ChatSpy.Enabled = not ChatSpy.Enabled; wait(0.3);
                ChatSpy.Chat.Text = "[SPY] - "..(ChatSpy.Enabled and "Enabled." or "Disabled.");

                StarterGui:SetCore("ChatMakeSystemMessage", ChatSpy.Chat);
            elseif (ChatSpy.Enabled and (ChatSpy.SpyOnSelf or targetPlayer ~= LocalPlayer)) then
                local message = message:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ');

                local Hidden = true;
                local Connection = OnMessageDoneFiltering.OnClientEvent:Connect(function(packet, channel)
                    if (packet.SpeakerUserId == targetPlayer.UserId and packet.Message == message:sub(#message - #packet.Message + 1) and (channel == "All" or (channel == "Team" and not ChatSpy.Public and Players[packet.FromSpeaker].Team == LocalPlayer.Team))) then
                        Hidden = false;
                    end;
                end);

                wait(1);
                Connection:Disconnect();

                if (Hidden and ChatSpy.Enabled and not ChatSpy.checkIgnored(message)) then
                    if (#message > 1200) then
                        message = message:sub(1200) .. "...";
                    end;
                    ChatSpy.Chat.Text = "[SPY] - ["..targetPlayer.Name.."]: " .. message;
                    if (ChatSpy.Public) then SayMessageRequest:FireServer(ChatSpy.Chat.Text, "All"); else StarterGui:SetCore("ChatMakeSystemMessage", ChatSpy.Chat); end;
                end;
            end;
        end;

        -- // Handling Chats
        local AllPlayers = Players:GetPlayers();
        for i = 1, #AllPlayers do
            local player = AllPlayers[i];
            player.Chatted:Connect(function(message)
                ChatSpy.onChatted(player, message);
            end);
        end;

        Players.PlayerAdded:Connect(function(player)
            player.Chatted:Connect(function(message)
                ChatSpy.onChatted(player, message);
            end);
        end);

        -- // Initialise Text
        ChatSpy.Chat.Text = "[SPY] - "..(ChatSpy.Enabled and "Enabled." or "Disabled.");
        StarterGui:SetCore("ChatMakeSystemMessage", ChatSpy.Chat);

        -- // Update Chat Frame
        local chatFrame = LocalPlayer.PlayerGui.Chat.Frame;
        chatFrame.ChatChannelParentFrame.Visible = true;
        chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(), chatFrame.ChatChannelParentFrame.Size.Y);
        end)
        Tab1:Button("No Recoil",function()
            local CurrentFocus = game:GetService("Workspace").CurrentCamera.CFrame
            game:GetService("Workspace").CurrentCamera:Destroy()
            local Instance = Instance.new("Camera", game:GetService("Workspace"))
            Instance.CameraSubject = game:GetService("Players").LocalPlayer.Character.Humanoid
            Instance.CameraType = Enum.CameraType.Custom
            Instance.CFrame = CurrentFocus
        end)
        Tab1:Button("Auto Eat Chicken",function()
            Game.StarterGui:SetCore("SendNotification", {Title = "HSBC", Text = "Autoeat Activado [50 Health]", Duration = 60

        })

        while wait() do
                pcall(function()
                    if game.Players.LocalPlayer.Character.Humanoid.Health > 50 then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 999, 0)
                        if game.Players.LocalPlayer.Character:FindFirstChild("[Chicken]") == nil or game.Players.LocalPlayer.Backpack:FindFirstChild("[Chicken]") == nil then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[Chicken] - $7"].Head.CFrame
                            wait(0.5)
                            fireclickdetector(game.Workspace.Ignored.Shop["[Chicken] - $7"].ClickDetector)
                        end
                        pcall(function()game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack["[Chicken]"])end)
                        pcall(function()
                            game.Players.LocalPlayer.Character["[Chicken]"]:Activate()
                            wait(0.1)
                            game.Players.LocalPlayer.Character["[Chicken]"]:Deactivate()
                        end)
                    end
                end)
            end
        end)
        Tab1:Button("no jump cd",function()
            --auto exc support
        if not game.IsLoaded(game) then 
            game.Loaded.Wait(game.Loaded);
        end

        -- variables 
        local IsA = game.IsA;
        local newindex = nil 

        -- main hook
        newindex = hookmetamethod(game, "__newindex", function(self, Index, Value)
            if not checkcaller() and IsA(self, "Humanoid") and Index == "JumpPower" then 
                return
            end
            
            return newindex(self, Index, Value);
        end)
        end)
        Tab1:Button("Semi God",function()
            coroutine.resume(coroutine.create(function()
                while wait() do
                    if game.Players.LocalPlayer.Character.BodyEffects.Armor.Value < 10 then
                        _G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                        local target = game:GetService("Workspace").Ignored.Shop["[High-Medium Armor] - 2300"].Head.CFrame
                        player.Character.HumanoidRootPart.CFrame = CFrame.new(target)
                        wait(.5)
                        fireclickdetector(game.Workspace.Ignored.Shop['[High-Medium Armor] - 2300'].ClickDetector)
                        wait()
                        fireclickdetector(game.Workspace.Ignored.Shop['[High-Medium Armor] - 2300'].ClickDetector)
                        wait(.5)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
                    end
                    if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health < 70 then
                        _G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                        game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-789.114, -39.6752, -942.038)
                        wait(.5)
                        fireclickdetector(game.Workspace.Ignored.Shop['[Pizza] - $5'].ClickDetector)
                        wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
                        for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v.Name == '[Pizza]' then
                                v.Parent = game.Players.LocalPlayer.Character
                                for i = 1, 6 do
                                    v:Activate()
                                    wait(.5)
                                    v:Activate()
                                end
                            end
                        end
                    end 
                end
            end))

        end)
        Tab1:Button("Bullet Proof",function()
            Instance.new("Folder",game:GetService("Players").LocalPlayer.Character).Name = ("FULLY_LOADED_CHAR")
                    game:GetService("Players").LocalPlayer.Character:WaitForChild("BodyEffects"):WaitForChild("Dead"):Remove()
                    Instance.new("BoolValue",game:GetService("Players").LocalPlayer.Character:WaitForChild("BodyEffects")).Name = ("Dead")
                    repeat wait() until game:GetService("Players").LocalPlayer.Character:WaitForChild("BodyEffects"):findFirstChild("Dead")
                    game:GetService("Players").LocalPlayer.Character:WaitForChild("BodyEffects"):WaitForChild("Cuff").Value = false
                    game:GetService("Players").LocalPlayer.Character:findFirstChild("BodyEffects"):WaitForChild("Armor"):Destroy()
        game:GetService("ReplicatedStorage").MainEvent:FireServer("UpdateMousePos", game:GetService("Players").LocalPlayer:GetMouse().Hit.Position)

        end)
        Tab1:Button("Color Correction",function()
            -- // Created by rice

        local l = game:GetService("Lighting")

        local col = Instance.new("ColorCorrectionEffect", l)
        col.Brightness = 0
        col.Contrast = 0.01
        col.Saturation = 0.67
        end)
        Tab1:Button("God Mode Guns",function()
            local localPlayer = game:GetService('Players').LocalPlayer;
            local localCharacter = localPlayer.Character;
            localCharacter:FindFirstChildOfClass('Humanoid').Health = 0;
            local newCharacter = localPlayer.CharacterAdded:Wait();
            local spoofFolder = Instance.new('Folder');
            spoofFolder.Name = 'FULLY_LOADED_CHAR';
            spoofFolder.Parent = newCharacter;
            newCharacter:WaitForChild('RagdollConstraints'):Destroy();
            local spoofValue = Instance.new('BoolValue', newCharacter);
            spoofValue.Name = 'RagdollConstraints';
            local name = game.Players.LocalPlayer.Name
            local lol =    game.Workspace:WaitForChild(name)
            local money = Instance.new("Folder",game.Players.LocalPlayer.Character);money.Name = "FULLY_LOADED_CHAR"
            lol.Parent = game.Workspace.Players
            game.Players.LocalPlayer.Character:WaitForChild("BodyEffects")
            game.Players.LocalPlayer.Character.BodyEffects.BreakingParts:Destroy()
        end)
        Tab2:Toggle("Anti Stomp K",false,function(value)
            game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(KeyPressed)
                if KeyPressed == "k" then
                for L_170_forvar0, L_171_forvar1 in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if L_171_forvar1:IsA("BasePart") then
                        L_171_forvar1:Destroy()
                    end
                end
                end
            end)
                end)
    Tab3:Button("Bag All",function()
        game.StarterGui:SetCore("SendNotification", {Title = "HSBC", Text = "Bag-All Activado. Solo se puede desactivar con rejoin jijijija", Icon = "rbxassetid://505845268", Duration = 5, Button1 = "Okay!"})

        local bag = true
        local takingbag = true
        local Plr = game.Players.LocalPlayer
        repeat wait(1)
            if game.Players.LocalPlayer.Character:FindFirstChild("[BrownBag]") == nil then
                repeat
                    takingbag = true
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-314.580566, 51.1788902, -727.484558)
                    wait()
                    fireclickdetector(workspace.Ignored.Shop["[BrownBag] - $25"].ClickDetector)
                until Plr.Backpack:FindFirstChild("[BrownBag]")
                Plr.Backpack["[BrownBag]"].Parent = Plr.Character
                takingbag = false
            end
        
            if takingbag == false then
                local chars
                for i, v  in pairs(game.Players:GetPlayers()) do
                    if v.Character and v.Character:FindFirstChild("Christmas_Sock") == nil and v.Character:FindFirstChild("FULLY_LOADED_CHAR") and v ~= Plr then
                        chars = v.Character
                        if Plr.Character:FindFirstChild("[BrownBag]") then
                            Plr.Character["[BrownBag]"]:Activate()
                        end
                        Plr.Character.HumanoidRootPart.CFrame = v.Character.UpperTorso.CFrame * CFrame.new(0, 0, -2)
                    end
                    wait(0.005)
                end
                if not chars then
                    bag = false
                end
            end
        until bag == false
                end)
    Tab2:Toggle("Anti Slow",false,function(value)
        local mt = getrawmetatable(game)
        local backup
        backup = hookfunction(mt.__newindex, newcclosure(function(self, key, value)
        if key == "WalkSpeed" and value < 16 then
        value = 16
        end
        return backup(self, key, value)
        end))
        
                        end)
        Tab1:Button("Auto Clicker (V)",function()
            local time = 0.01 --decrease if too slow increase if too fast

            click = false
            m = game.Players.LocalPlayer:GetMouse()
            m.KeyDown:connect(function(key)
            if key == "v" then
            if click == true then click = false
            elseif
            click == false then click = true
            
            while click == true do 
            wait(time)
            mouse1click()
            end
            end
            end
            end)
            
                        end)
                        Tab3:Button("Auto Block",function()
                            --[[




    ]]--


    MainEvent = game:GetService('ReplicatedStorage').MainEvent
    player = game.Players.LocalPlayer;
    Distancia = 15; -- Here put the distance to activate

    game:GetService('RunService'):BindToRenderStep("Auto-Block", 0 , function()

        local forbidden = {'[Popcorn]','[HotDog]','[GrenadeLauncher]','[RPG]','[SMG]','[TacticalShotgun]','[AK47]','[AUG]','[Glock]', '[Shotgun]','[Flamethrower]','[Silencer]','[AR]','[Revolver]','[SilencerAR]','[LMG]','[P90]','[DrumGun]','[Double-Barrel SG]','[Hamburger]','[Chicken]','[Pizza]','[Cranberry]','[Donut]','[Taco]','[Starblox Latte]','[BrownBag]','[Weights]','[HeavyWeights]'}
    local Found = false
    for _,v in pairs(game.Workspace.Players:GetChildren()) do
        if (v.UpperTorso.Position - player.Character.HumanoidRootPart.Position).Magnitude <= Distancia then
            if v.BodyEffects.Attacking.Value == true and not table.find(forbidden, v:FindFirstChildWhichIsA('Tool').Name ) and v.Name ~= player.Name then
                Found = true
                MainEvent:FireServer('Block', player.Name)
                
            end
        end
    end
    if Found == false then
        if player.Character.BodyEffects:FindFirstChild('Block') then player.Character.BodyEffects.Block:Destroy() end
        end
    end)

                        end)
                        Tab1:Button("Auto Buy Armom",function()
                            local PERCENT_TO_BUY_ARMOR   = 50         --\\ percent of armor left that u want to buy
    local COMMAND_TO_STOP_BUYING = ('/e stop') --\\ message to stop buying

    ------------------------
    ------------------------

    function announce(title,text,time)
        game.StarterGui:SetCore("SendNotification", {
            Title = title;
            Text = text;
            Duration = time;
        })
    end
    announce('Autobuying armor at %' .. tostring(PERCENT_TO_BUY_ARMOR), 'chat ' .. COMMAND_TO_STOP_BUYING .. ' to stop', 8)

    local Stopped = false
    local Player = game.Players.LocalPlayer
    function Main1()
        while wait() do
            local function AutoArmor()
                local Origin = Player.Character.HumanoidRootPart.CFrame
                local Armor = Player.Character.BodyEffects.Armor
                if Armor.Value <= PERCENT_TO_BUY_ARMOR and Stopped == false then
                    repeat
                        wait()    
                        Player.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Ignored.Shop["[Medium Armor] - $1000"].Head.CFrame
                        fireclickdetector(game:GetService("Workspace").Ignored.Shop["[Medium Armor] - $1000"].ClickDetector)
                    until Armor.Value == 100 or Player.DataFolder.Currency.Value < 1000
                    Player.Character.HumanoidRootPart.CFrame = Origin
                end
            end
            local s,e = pcall(AutoArmor)
        end
    end
    function Main2()
        Player.Chatted:Connect(function(msg)
            if msg == COMMAND_TO_STOP_BUYING and Stopped == false then
                Stopped = true
                announce('stopped buying', '',5)
            end
        end)
    end
    coroutine.resume(coroutine.create(Main1))
    coroutine.resume(coroutine.create(Main2))

                        end)

    Tab1:Button("Auto Reload",function()
        _G.AutoReload = true -- change to false if u don't want it anymore.

        while _G.AutoReload == true and game:GetService("RunService").Heartbeat:Wait() do
        if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo") then
                        if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo").Value <= 0 then
                            game:GetService("ReplicatedStorage").MainEvent:FireServer("Reload", game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool")) 
                            wait(1)
                        end
                    end
                end
        end
                        end)
                        Tab3:Button("Fe Fat",function()
                            game.Players.LocalPlayer.Character.Humanoid.BodyDepthScale:Destroy()
                            game.Players.LocalPlayer.Character.Humanoid.BodyWidthScale:Destroy()
                            
                        end)
                        Tab1:Button("FPS Unlocker",function()
                            local fps = 400
    
        if setfpscap then
            setfpscap(fps)
    end
                        end)
                        Tab4:Button("Korblox & Headless",function()
                            local L_393_ = game.Players.LocalPlayer.Character
                            local L_394_ = L_393_:WaitForChild("Head")
                            local L_395_ = L_394_:WaitForChild("face")
                            L_395_.Transparency = 1 --Texture = "rbxassetid://209712379"
                            L_394_.Transparency = 1
                            local L_396_ = game.Players.LocalPlayer.Character
                            local L_397_ = game.Players.LocalPlayer.Character
                            local L_398_ = L_396_.Head
                            local L_399_ = L_398_.face
                            local L_400_ = L_397_.RightFoot
                            local L_401_ = L_397_.RightLowerLeg
                            local L_402_ = L_397_.RightUpperLeg
                            local L_403_ = L_397_.LeftFoot
                            local L_404_ = L_397_.LeftLowerLeg
                            local L_405_ = L_397_.LeftUpperLeg
                            L_400_.MeshId = "http://www.roblox.com/asset/?id=902942093"
                            L_401_.MeshId = "http://www.roblox.com/asset/?id=902942093"
                            L_402_.MeshId = "http://www.roblox.com/asset/?id=902942096"
                            L_402_.TextureID = "http://roblox.com/asset/?id=902843398"
                            L_400_.Transparency = 1
                            L_401_.Transparency = 1
                        end)
                        Tab4:Button("Rainbow Character",function()
                            for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                                if v:IsA("MeshPart") then
                                    v.Material = "ForceField"
                                    spawn(function()
                                        while wait() do
                                            for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                                                if v:IsA("MeshPart") then
                                                    v.Color = Color3.fromHSV(tick()%5/5,1,1)
                                                    wait()
                                                end
                                            end 
                                        end
                                    end)
                                end
                            end
                        end)
                        Tab1:Button("No Display Name",function()
                            pcall(function()
                                for i, v in pairs(game:GetService("Players"):GetPlayers()) do
                                    if v.Character then
                                        if v.Character:FindFirstChild("Humanoid") then
                                            v.Character:FindFirstChild("Humanoid").DisplayName = v.Name 
                                        end
                                    end
                                end
                            end)
                        end)
                        Tab4:Button("Headless",function()
                            game.Players.LocalPlayer.Character.Head.Transparency = 1
game.Players.LocalPlayer.Character.Head.Transparency = 1
for i,v in pairs(game.Players.LocalPlayer.Character.Head:GetChildren()) do
if (v:IsA("Decal")) then
v.Transparency = 1
end
end
                        end)
                        Tab4:Button("Korblox",function()
                            local ply = game.Players.LocalPlayer
                            local chr = ply.Character
                            chr.RightLowerLeg.MeshId = "902942093"
                            chr.RightLowerLeg.Transparency = "1"
                            chr.RightUpperLeg.MeshId = "http://www.roblox.com/asset/?id=902942096"
                            chr.RightUpperLeg.TextureID = "http://roblox.com/asset/?id=902843398"
                            chr.RightFoot.MeshId = "902942089"
                            chr.RightFoot.Transparency = "1"

                        end)
                        Tab2:Toggle("Anti Fling",false,function(value)
                            local localPlayer = game:GetService('Players').LocalPlayer;
                local localCharacter = localPlayer.Character;
                localCharacter:FindFirstChildOfClass('Humanoid').Health = 0;
                local newCharacter = localPlayer.CharacterAdded:Wait();
                local spoofFolder = Instance.new('Folder');
                spoofFolder.Name = 'FULLY_LOADED_CHAR';
                spoofFolder.Parent = newCharacter;
                newCharacter:WaitForChild('RagdollConstraints'):Destroy();
                local spoofValue = Instance.new('BoolValue', newCharacter);
                spoofValue.Name = 'RagdollConstraints';
                local name = game.Players.LocalPlayer.Name
                local lol =    game.Workspace:WaitForChild(name)
                local money = Instance.new("Folder",game.Players.LocalPlayer.Character);money.Name = "FULLY_LOADED_CHAR"
                lol.Parent = game.Workspace.Players
                game.Players.LocalPlayer.Character:WaitForChild("BodyEffects")
                game.Players.LocalPlayer.Character.BodyEffects.BreakingParts:Destroy()
                                end)
                                Tab2:Toggle("Anti Bag",false,function(value)
                                    local LP = game.Players.LocalPlayer;

                                    for i,v in ipairs(LP.Character:GetDescendants()) do
                                        if v.Name == "Christmas_Sock" then v:Destroy()
                                            end
                                        end
                                            
                                        LP.Character.ChildAdded:Connect(function()
                                        wait(0.3)
                                        for i,v in ipairs(LP.Character:GetDescendants()) do
                                        if v.Name == "Christmas_Sock" then v:Destroy()
                                        end
                                        end
                                        end)
                                end)
                                Tab3:Button("Bring All",function()
                                    -- u need to be fat
-- by farzad#9999
local host = "hellofarzad125" -- change to ur user

repeat wait() until game:IsLoaded()
-- < start of spraycan crasher > --
itemCount = 0
getgenv().groupid = nil
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
local getGroups = game:GetService("GroupService"):GetGroupsAsync(game.Players.LocalPlayer.UserId)
if unpack(getGroups) == nil then
    warn('no groups'); return
else
    for _, groupInfo in pairs(getGroups) do
        if _ == 1 then
            getgenv().groupid = groupInfo.Id
        end
    end
end
function equipall()
    for _,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:IsA"Tool" and v.Name == "[SprayCan]" then
            v.Parent = game.Players.LocalPlayer.Character
        end
    end
end
function unequip()
    for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA"Tool" and v.Name == "[SprayCan]" then
            v.Parent = game.Players.LocalPlayer.Backpack
        end
    end
end

repeat
    task.wait()
    game:GetService("ReplicatedStorage").MainEvent:FireServer("JoinCrew", getgenv().groupid)        --// join crew
    repeat wait() until game.Players.LocalPlayer.Backpack:FindFirstChild'[SprayCan]'; task.wait()   --// wait for tool to be added
    itemCount = itemCount + 1; print(itemCount)                                                     --// add count
    equipall()
until itemCount >= 40
unequip()
-- < end of spraycan grinder > --

local LocalPlayer = game.Players.LocalPlayer
local newHum = LocalPlayer.Character.Humanoid:Clone()
newHum.Parent = LocalPlayer.Character
LocalPlayer.Character.Humanoid:Destroy()

LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players:FindFirstChild(host).Character.HumanoidRootPart.CFrame
wait(.8)
for i,v in pairs(game.Players:GetChildren()) do
if v.UserId == game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Character.Name) or v.UserId == game.Players:GetUserIdFromNameAsync(host) then
else
local tool = LocalPlayer.Backpack:FindFirstChild("[SprayCan]")
tool.Parent = LocalPlayer.Character
firetouchinterest(tool.Handle, v.Character['Head'],0)
end
end

wait(.3)
if LocalPlayer.Character then
    game.Players.LocalPlayer.Character:BreakJoints()
end
                                end)

Tab1:Button("Fly (X)",function()


                                
