local a=2^32;local b=a-1;local function c(d,e)local f,g=0,1;while d~=0 or e~=0 do local h,i=d%2,e%2;local j=(h+i)%2;f=f+j*g;d=math.floor(d/2)e=math.floor(e/2)g=g*2 end;return f%a end;local function k(d,e,l,...)local m;if e then d=d%a;e=e%a;m=c(d,e)if l then m=k(m,l,...)end;return m elseif d then return d%a else return 0 end end;local function n(d,e,l,...)local m;if e then d=d%a;e=e%a;m=(d+e-c(d,e))/2;if l then m=n(m,l,...)end;return m elseif d then return d%a else return b end end;local function o(p)return b-p end;local function q(d,r)if r<0 then return lshift(d,-r)end;return math.floor(d%2^32/2^r)end;local function s(p,r)if r>31 or r<-31 then return 0 end;return q(p%a,r)end;local function lshift(d,r)if r<0 then return s(d,-r)end;return d*2^r%2^32 end;local function t(p,r)p=p%a;r=r%32;local u=n(p,2^r-1)return s(p,r)+lshift(u,32-r)end;local v={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function w(x)return string.gsub(x,".",function(l)return string.format("%02x",string.byte(l))end)end;local function y(z,A)local x=""for B=1,A do local C=z%256;x=string.char(C)..x;z=(z-C)/256 end;return x end;local function D(x,B)local A=0;for B=B,B+3 do A=A*256+string.byte(x,B)end;return A end;local function E(F,G)local H=64-(G+9)%64;G=y(8*G,8)F=F.."\128"..string.rep("\0",H)..G;assert(#F%64==0)return F end;local function I(J)J[1]=0x6a09e667;J[2]=0xbb67ae85;J[3]=0x3c6ef372;J[4]=0xa54ff53a;J[5]=0x510e527f;J[6]=0x9b05688c;J[7]=0x1f83d9ab;J[8]=0x5be0cd19;return J end;local function K(F,B,J)local L={}for M=1,16 do L[M]=D(F,B+(M-1)*4)end;for M=17,64 do local N=L[M-15]local O=k(t(N,7),t(N,18),s(N,3))N=L[M-2]L[M]=(L[M-16]+O+L[M-7]+k(t(N,17),t(N,19),s(N,10)))%a end;local d,e,l,P,Q,R,S,T=J[1],J[2],J[3],J[4],J[5],J[6],J[7],J[8]for B=1,64 do local O=k(t(d,2),t(d,13),t(d,22))local U=k(n(d,e),n(d,l),n(e,l))local V=(O+U)%a;local W=k(t(Q,6),t(Q,11),t(Q,25))local X=k(n(Q,R),n(o(Q),S))local Y=(T+W+X+v[B]+L[B])%a;T=S;S=R;R=Q;Q=(P+Y)%a;P=l;l=e;e=d;d=(Y+V)%a end;J[1]=(J[1]+d)%a;J[2]=(J[2]+e)%a;J[3]=(J[3]+l)%a;J[4]=(J[4]+P)%a;J[5]=(J[5]+Q)%a;J[6]=(J[6]+R)%a;J[7]=(J[7]+S)%a;J[8]=(J[8]+T)%a end;local function Z(F)F=E(F,#F)local J=I({})for B=1,#F,64 do K(F,B,J)end;return w(y(J[1],4)..y(J[2],4)..y(J[3],4)..y(J[4],4)..y(J[5],4)..y(J[6],4)..y(J[7],4)..y(J[8],4))end;local e;local l={["\\"]="\\",["\""]="\"",["\b"]="b",["\f"]="f",["\n"]="n",["\r"]="r",["\t"]="t"}local P={["/"]="/"}for Q,R in pairs(l)do P[R]=Q end;local S=function(T)return"\\"..(l[T]or string.format("u%04x",T:byte()))end;local B=function(M)return"null"end;local v=function(M,z)local _={}z=z or{}if z[M]then error("circular reference")end;z[M]=true;if rawget(M,1)~=nil or next(M)==nil then local A=0;for Q in pairs(M)do if type(Q)~="number"then error("invalid table: mixed or invalid key types")end;A=A+1 end;if A~=#M then error("invalid table: sparse array")end;for a0,R in ipairs(M)do table.insert(_,e(R,z))end;z[M]=nil;return"["..table.concat(_,",").."]"else for Q,R in pairs(M)do if type(Q)~="string"then error("invalid table: mixed or invalid key types")end;table.insert(_,e(Q,z)..":"..e(R,z))end;z[M]=nil;return"{"..table.concat(_,",").."}"end end;local g=function(M)return'"'..M:gsub('[%z\1-\31\\"]',S)..'"'end;local a1=function(M)if M~=M or M<=-math.huge or M>=math.huge then error("unexpected number value '"..tostring(M).."'")end;return string.format("%.14g",M)end;local j={["nil"]=B,["table"]=v,["string"]=g,["number"]=a1,["boolean"]=tostring}e=function(M,z)local x=type(M)local a2=j[x]if a2 then return a2(M,z)end;error("unexpected type '"..x.."'")end;local a3=function(M)return e(M)end;local a4;local N=function(...)local _={}for a0=1,select("#",...)do _[select(a0,...)]=true end;return _ end;local L=N(" ","\t","\r","\n")local p=N(" ","\t","\r","\n","]","}",",")local a5=N("\\","/",'"',"b","f","n","r","t","u")local m=N("true","false","null")local a6={["true"]=true,["false"]=false,["null"]=nil}local a7=function(a8,a9,aa,ab)for a0=a9,#a8 do if aa[a8:sub(a0,a0)]~=ab then return a0 end end;return#a8+1 end;local ac=function(a8,a9,J)local ad=1;local ae=1;for a0=1,a9-1 do ae=ae+1;if a8:sub(a0,a0)=="\n"then ad=ad+1;ae=1 end end;error(string.format("%s at line %d col %d",J,ad,ae))end;local af=function(A)local a2=math.floor;if A<=0x7f then return string.char(A)elseif A<=0x7ff then return string.char(a2(A/64)+192,A%64+128)elseif A<=0xffff then return string.char(a2(A/4096)+224,a2(A%4096/64)+128,A%64+128)elseif A<=0x10ffff then return string.char(a2(A/262144)+240,a2(A%262144/4096)+128,a2(A%4096/64)+128,A%64+128)end;error(string.format("invalid unicode codepoint '%x'",A))end;local ag=function(ah)local ai=tonumber(ah:sub(1,4),16)local aj=tonumber(ah:sub(7,10),16)if aj then return af((ai-0xd800)*0x400+aj-0xdc00+0x10000)else return af(ai)end end;local ak=function(a8,a0)local _=""local al=a0+1;local Q=al;while al<=#a8 do local am=a8:byte(al)if am<32 then ac(a8,al,"control character in string")elseif am==92 then _=_..a8:sub(Q,al-1)al=al+1;local T=a8:sub(al,al)if T=="u"then local an=a8:match("^[dD][89aAbB]%x%x\\u%x%x%x%x",al+1)or a8:match("^%x%x%x%x",al+1)or ac(a8,al-1,"invalid unicode escape in string")_=_..ag(an)al=al+#an else if not a5[T]then ac(a8,al-1,"invalid escape char '"..T.."' in string")end;_=_..P[T]end;Q=al+1 elseif am==34 then _=_..a8:sub(Q,al-1)return _,al+1 end;al=al+1 end;ac(a8,a0,"expected closing quote for string")end;local ao=function(a8,a0)local am=a7(a8,a0,p)local ah=a8:sub(a0,am-1)local A=tonumber(ah)if not A then ac(a8,a0,"invalid number '"..ah.."'")end;return A,am end;local ap=function(a8,a0)local am=a7(a8,a0,p)local aq=a8:sub(a0,am-1)if not m[aq]then ac(a8,a0,"invalid literal '"..aq.."'")end;return a6[aq],am end;local ar=function(a8,a0)local _={}local A=1;a0=a0+1;while 1 do local am;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="]"then a0=a0+1;break end;am,a0=a4(a8,a0)_[A]=am;A=A+1;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="]"then break end;if as~=","then ac(a8,a0,"expected ']' or ','")end end;return _,a0 end;local at=function(a8,a0)local _={}a0=a0+1;while 1 do local au,M;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="}"then a0=a0+1;break end;if a8:sub(a0,a0)~='"'then ac(a8,a0,"expected string for key")end;au,a0=a4(a8,a0)a0=a7(a8,a0,L,true)if a8:sub(a0,a0)~=":"then ac(a8,a0,"expected ':' after key")end;a0=a7(a8,a0+1,L,true)M,a0=a4(a8,a0)_[au]=M;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="}"then break end;if as~=","then ac(a8,a0,"expected '}' or ','")end end;return _,a0 end;local av={['"']=ak,["0"]=ao,["1"]=ao,["2"]=ao,["3"]=ao,["4"]=ao,["5"]=ao,["6"]=ao,["7"]=ao,["8"]=ao,["9"]=ao,["-"]=ao,["t"]=ap,["f"]=ap,["n"]=ap,["["]=ar,["{"]=at}a4=function(a8,a9)local as=a8:sub(a9,a9)local a2=av[as]if a2 then return a2(a8,a9)end;ac(a8,a9,"unexpected character '"..as.."'")end;local aw=function(a8)if type(a8)~="string"then error("expected argument of type string, got "..type(a8))end;local _,a9=a4(a8,a7(a8,1,L,true))a9=a7(a8,a9,L,true)if a9<=#a8 then ac(a8,a9,"trailing garbage")end;return _ end;local lEncode, lDecode, lDigest = a3, aw, Z;

local service = 19188;
local secret = "a33b7246-314e-4061-9719-c935f6066c97";
local useNonce = true;

local onMessage = function(message)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "키 시스템",
        Text = message,
        Duration = 5
    })
end;

repeat task.wait(1) until game:IsLoaded();

local requestSending = false;
local fSetClipboard, fRequest, fStringChar, fToString, fStringSub, fOsTime, fMathRandom, fMathFloor, fGetHwid = setclipboard or toclipboard, request or http_request or syn_request, string.char, tostring, string.sub, os.time, math.random, math.floor, gethwid or function() return game:GetService("Players").LocalPlayer.UserId end
local cachedLink, cachedTime = "", 0;

local host = "https://api.platoboost.com";
local hostResponse = fRequest({
    Url = host .. "/public/connectivity",
    Method = "GET"
});
if hostResponse.StatusCode ~= 200 or hostResponse.StatusCode ~= 429 then
    host = "https://api.platoboost.net";
end

function cacheLink()
    if cachedTime + (10*60) < fOsTime() then
        local response = fRequest({
            Url = host .. "/public/start",
            Method = "POST",
            Body = lEncode({
                service = service,
                identifier = lDigest(fGetHwid())
            }),
            Headers = {
                ["Content-Type"] = "application/json"
            }
        });

        if response.StatusCode == 200 then
            local decoded = lDecode(response.Body);

            if decoded.success == true then
                cachedLink = decoded.data.url;
                cachedTime = fOsTime();
                return true, cachedLink;
            else
                onMessage(decoded.message);
                return false, decoded.message;
            end
        elseif response.StatusCode == 429 then
            local msg = "you are being rate limited, please wait 20 seconds and try again.";
            onMessage(msg);
            return false, msg;
        end

        local msg = "Failed to cache link.";
        onMessage(msg);
        return false, msg;
    else
        return true, cachedLink;
    end
end

cacheLink();

local generateNonce = function()
    local str = ""
    for _ = 1, 16 do
        str = str .. fStringChar(fMathFloor(fMathRandom() * (122 - 97 + 1)) + 97)
    end
    return str
end

for _ = 1, 5 do
    local oNonce = generateNonce();
    task.wait(0.2)
    if generateNonce() == oNonce then
        local msg = "platoboost nonce error.";
        onMessage(msg);
        error(msg);
    end
end

local copyLink = function()
    local success, link = cacheLink();
    
    if success then
        fSetClipboard(link);
    end
end

local redeemKey = function(key)
    local nonce = generateNonce();
    local endpoint = host .. "/public/redeem/" .. fToString(service);

    local body = {
        identifier = lDigest(fGetHwid()),
        key = key
    }

    if useNonce then
        body.nonce = nonce;
    end

    local response = fRequest({
        Url = endpoint,
        Method = "POST",
        Body = lEncode(body),
        Headers = {
            ["Content-Type"] = "application/json"
        }
    });

    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body);

        if decoded.success == true then
            if decoded.data.valid == true then
                if useNonce then
                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then
                        return true;
                    else
                        onMessage("failed to verify integrity.");
                        return false;
                    end    
                else
                    return true;
                end
            else
                onMessage("key is invalid.");
                return false;
            end
        else
            if fStringSub(decoded.message, 1, 27) == "unique constraint violation" then
                onMessage("you already have an active key, please wait for it to expire before redeeming it.");
                return false;
            else
                onMessage(decoded.message);
                return false;
            end
        end
    elseif response.StatusCode == 429 then
        onMessage("you are being rate limited, please wait 20 seconds and try again.");
        return false;
    else
        onMessage("server returned an invalid status code, please try again later.");
        return false; 
    end
end

local verifyKey = function(key)
    if requestSending == true then
        onMessage("a request is already being sent, please slow down.");
        return false;
    else
        requestSending = true;
    end

    local nonce = generateNonce();
    local endpoint = host .. "/public/whitelist/" .. fToString(service) .. "?identifier=" .. lDigest(fGetHwid()) .. "&key=" .. key;

    if useNonce then
        endpoint = endpoint .. "&nonce=" .. nonce;
    end

    local response = fRequest({
        Url = endpoint,
        Method = "GET",
    });

    requestSending = false;

    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body);

        if decoded.success == true then
            if decoded.data.valid == true then
                if useNonce then
                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then
                        return true;
                    else
                        onMessage("failed to verify integrity.");
                        return false;
                    end
                else
                    return true;
                end
            else
                if fStringSub(key, 1, 4) == "KEY_" then
                    return redeemKey(key);
                else
                    onMessage("key is invalid.");
                    return false;
                end
            end
        else
            onMessage(decoded.message);
            return false;
        end
    elseif response.StatusCode == 429 then
        onMessage("you are being rate limited, please wait 20 seconds and try again.");
        return false;
    else
        onMessage("server returned an invalid status code, please try again later.");
        return false;
    end
end

local getFlag = function(name)
    local nonce = generateNonce();
    local endpoint = host .. "/public/flag/" .. fToString(service) .. "?name=" .. name;

    if useNonce then
        endpoint = endpoint .. "&nonce=" .. nonce;
    end

    local response = fRequest({
        Url = endpoint,
        Method = "GET",
    });

    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body);

        if decoded.success == true then
            if useNonce then
                if decoded.data.hash == lDigest(fToString(decoded.data.value) .. "-" .. nonce .. "-" .. secret) then
                    return decoded.data.value;
                else
                    onMessage("failed to verify integrity.");
                    return nil;
                end
            else
                return decoded.data.value;
            end
        else
            onMessage(decoded.message);
            return nil;
        end
    else
        return nil;
    end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "Murder Mystery Cheats - 키 입력"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.Parent = Frame

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
KeyBox.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyBox.PlaceholderText = "키를 여기에 붙여넣기"
KeyBox.Text = ""
KeyBox.Parent = Frame

local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Size = UDim2.new(0.8, 0, 0, 40)
GetKeyButton.Position = UDim2.new(0.1, 0, 0.55, 0)
GetKeyButton.Text = "키 받기 (클립보드에 복사)"
GetKeyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
GetKeyButton.TextColor3 = Color3.new(1,1,1)
GetKeyButton.Parent = Frame

local CheckButton = Instance.new("TextButton")
CheckButton.Size = UDim2.new(0.8, 0, 0, 40)
CheckButton.Position = UDim2.new(0.1, 0, 0.75, 0)
CheckButton.Text = "키 확인"
CheckButton.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
CheckButton.TextColor3 = Color3.new(1,1,1)
CheckButton.Parent = Frame

GetKeyButton.MouseButton1Click:Connect(function()
    copyLink()
    onMessage("키 링크가 클립보드에 복사됐습니다! 브라우저에서 열고 작업 완료하세요.")
end)

CheckButton.MouseButton1Click:Connect(function()
    local key = KeyBox.Text
    if key == "" then
        onMessage("키를 입력해주세요!")
        return
    end
    
    local success = verifyKey(key)
    
    if success then
        onMessage("키 인증 성공! 치트 로드중...")
        ScreenGui:Destroy()
        
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local Workspace = game:GetService("Workspace")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local TweenService = game:GetService("TweenService")
        local UserInputService = game:GetService("UserInputService")

        local LocalPlayer = Players.LocalPlayer
        local Camera = Workspace.CurrentCamera
        local Mouse = LocalPlayer:GetMouse()

        local ESPEnabled = true
        local SilentAimEnabled = true
        local AutoShootEnabled = true
        local MurdererKillAuraEnabled = true

        local SilentAimRange = 180
        local AutoShootDelay = 0.45
        local MurdererKillAuraRange = 25

        local RoleColors = {
            ["Murderer"] = Color3.fromRGB(255, 0, 0),
            ["Sheriff"] = Color3.fromRGB(0, 0, 255),
            ["Innocent"] = Color3.fromRGB(0, 255, 0),
            ["Hero"] = Color3.fromRGB(255, 255, 0),
        }

        local RemoteNames = {
            "Shoot", "Fire", "GunFire", "FireGun", "ShootEvent", "Hit", "Damage",
            "FireBullet", "ShootRemote", "GunShot", "BulletFire", "RemoteShoot",
            "KnifeHit", "Stab", "KnifeDamage", "MurderHit", "DamagePlayer"
        }

        local ESPBoxes = {}
        local ESPNames = {}

        local GunDropGui = Instance.new("ScreenGui")
        GunDropGui.Name = "GunDropNotification"
        GunDropGui.ResetOnSpawn = false
        GunDropGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

        local Notification = Instance.new("TextLabel")
        Notification.Size = UDim2.new(0, 340, 0, 80)
        Notification.Position = UDim2.new(0.5, -170, 0, 30)
        Notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Notification.BackgroundTransparency = 0.45
        Notification.TextColor3 = Color3.fromRGB(255, 150, 0)
        Notification.TextScaled = true
        Notification.Font = Enum.Font.GothamBlack
        Notification.Text = ""
        Notification.Visible = false
        Notification.Parent = GunDropGui

        local function ShowGunDrop()
            Notification.Text = "총이 떨어졌습니다! (Gun Dropped!)"
            Notification.Visible = true
            task.delay(5.2, function() Notification.Visible = false end)
        end

        Workspace.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then
                local nameLower = child.Name:lower()
                if nameLower:find("gun") or nameLower:find("knife") or nameLower:find("pistol") or nameLower:find("revolver") then
                    task.delay(math.random(0.1, 0.6), ShowGunDrop)
                end
            end
        end)

        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "MurderAdvancedGui"
        ScreenGui.ResetOnSpawn = false
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

        local MainFrame = Instance.new("Frame")
        MainFrame.Size = UDim2.new(0, 350, 0, 480)
        MainFrame.Position = UDim2.new(0, 60, 0, 180)
        MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
        MainFrame.BackgroundTransparency = 0.1
        MainFrame.BorderSizePixel = 0
        MainFrame.Parent = ScreenGui

        local TitleLabel = Instance.new("TextLabel")
        TitleLabel.Size = UDim2.new(1, 0, 0, 65)
        TitleLabel.BackgroundTransparency = 1
        TitleLabel.Text = "Murder Mystery Advanced Cheats"
        TitleLabel.TextColor3 = Color3.fromRGB(150, 150, 255)
        TitleLabel.Font = Enum.Font.GothamBlack
        TitleLabel.TextSize = 30
        TitleLabel.Parent = MainFrame

        local function CreateToggle(name, posY, default, callback)
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 190, 0, 45)
            label.Position = UDim2.new(0, 40, 0, posY)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.fromRGB(245, 245, 255)
            label.Text = name
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Font = Enum.Font.Gotham
            label.TextSize = 21
            label.Parent = MainFrame

            local button = Instance.new("TextButton")
            button.Size = UDim2.new(0, 120, 0, 45)
            button.Position = UDim2.new(0, 220, 0, posY)
            button.BackgroundColor3 = default and Color3.fromRGB(0, 230, 0) or Color3.fromRGB(230, 0, 0)
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.Text = default and "ON" or "OFF"
            button.Font = Enum.Font.GothamBold
            button.TextSize = 21
            button.Parent = MainFrame

            button.MouseButton1Click:Connect(function()
                local enabled = button.Text == "OFF"
                button.Text = enabled and "ON" or "OFF"
                button.BackgroundColor3 = enabled and Color3.fromRGB(0, 230, 0) or Color3.fromRGB(230, 0, 0)
                callback(enabled)
            end)
        end

        CreateToggle("ESP", 110, true, function(v) ESPEnabled = v end)
        CreateToggle("Silent Aim", 165, true, function(v) SilentAimEnabled = v end)
        CreateToggle("Auto Shoot", 220, true, function(v) AutoShootEnabled = v end)
        CreateToggle("Murderer Kill Aura", 275, true, function(v) MurdererKillAuraEnabled = v end)

        local RangeLabel = Instance.new("TextLabel")
        RangeLabel.Size = UDim2.new(0, 300, 0, 40)
        RangeLabel.Position = UDim2.new(0, 40, 0, 340)
        RangeLabel.BackgroundTransparency = 1
        RangeLabel.TextColor3 = Color3.fromRGB(150, 150, 255)
        RangeLabel.Text = "Silent Aim Range: 180"
        RangeLabel.TextXAlignment = Enum.TextXAlignment.Left
        RangeLabel.Font = Enum.Font.Gotham
        RangeLabel.TextSize = 19
        RangeLabel.Parent = MainFrame

        local RangeBox = Instance.new("TextBox")
        RangeBox.Size = UDim2.new(0, 110, 0, 40)
        RangeBox.Position = UDim2.new(0, 210, 0, 340)
        RangeBox.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
        RangeBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        RangeBox.Text = tostring(SilentAimRange)
        RangeBox.ClearTextOnFocus = false
        RangeBox.Font = Enum.Font.Gotham
        RangeBox.TextSize = 19
        RangeBox.Parent = MainFrame

        RangeBox.FocusLost:Connect(function()
            local val = tonumber(RangeBox.Text)
            if val and val >= 50 and val <= 2500 then
                SilentAimRange = val
                RangeLabel.Text = "Silent Aim Range: " .. val
            else
                RangeBox.Text = tostring(SilentAimRange)
            end
        end)

        local KillAuraRangeLabel = Instance.new("TextLabel")
        KillAuraRangeLabel.Size = UDim2.new(0, 300, 0, 40)
        KillAuraRangeLabel.Position = UDim2.new(0, 40, 0, 390)
        KillAuraRangeLabel.BackgroundTransparency = 1
        KillAuraRangeLabel.TextColor3 = Color3.fromRGB(150, 150, 255)
        KillAuraRangeLabel.Text = "Murderer Kill Aura Range: 25"
        KillAuraRangeLabel.TextXAlignment = Enum.TextXAlignment.Left
        KillAuraRangeLabel.Font = Enum.Font.Gotham
        KillAuraRangeLabel.TextSize = 19
        KillAuraRangeLabel.Parent = MainFrame

        local KillAuraRangeBox = Instance.new("TextBox")
        KillAuraRangeBox.Size = UDim2.new(0, 110, 0, 40)
        KillAuraRangeBox.Position = UDim2.new(0, 250, 0, 390)
        KillAuraRangeBox.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
        KillAuraRangeBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        KillAuraRangeBox.Text = tostring(MurdererKillAuraRange)
        KillAuraRangeBox.ClearTextOnFocus = false
        KillAuraRangeBox.Font = Enum.Font.Gotham
        KillAuraRangeBox.TextSize = 19
        KillAuraRangeBox.Parent = MainFrame

        KillAuraRangeBox.FocusLost:Connect(function()
            local val = tonumber(KillAuraRangeBox.Text)
            if val and val >= 10 and val <= 50 then
                MurdererKillAuraRange = val
                KillAuraRangeLabel.Text = "Murderer Kill Aura Range: " .. val
            else
                KillAuraRangeBox.Text = tostring(MurdererKillAuraRange)
            end
        end)

        local function CreateESP(player)
            if player == LocalPlayer or ESPBoxes[player] then return end

            local box = Drawing.new("Square")
            box.Thickness = 3.2
            box.Filled = false
            box.Transparency = 1
            box.Visible = false

            local nameTag = Drawing.new("Text")
            nameTag.Size = 20
            nameTag.Center = true
            nameTag.Outline = true
            nameTag.OutlineColor = Color3.new(0,0,0)
            nameTag.Font = Drawing.Fonts.UI
            nameTag.Visible = false

            ESPBoxes[player] = box
            ESPNames[player] = nameTag
        end

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then CreateESP(player) end
        end

        Players.PlayerAdded:Connect(function(player)
            task.delay(0.45, function()
                if player ~= LocalPlayer then CreateESP(player) end
            end)
        end)

        Players.PlayerRemoving:Connect(function(player)
            if ESPBoxes[player] then ESPBoxes[player]:Remove() ESPBoxes[player] = nil end
            if ESPNames[player] then ESPNames[player]:Remove() ESPNames[player] = nil end
        end)

        local MurdererOnScreen = false
        local CurrentMurderer = nil

        RunService.RenderStepped:Connect(function()
            MurdererOnScreen = false
            CurrentMurderer = nil

            if not ESPEnabled then
                for _, box in pairs(ESPBoxes) do box.Visible = false end
                for _, name in pairs(ESPNames) do name.Visible = false end
                return
            end

            for player, box in pairs(ESPBoxes) do
                local nameTag = ESPNames[player]
                local char = player.Character

                if not char or not player.Character or not player.Character:FindFirstChild("Humanoid") or player.Character.Humanoid.Health <= 0 or not char:FindFirstChild("HumanoidRootPart") then
                    box.Visible = false
                    nameTag.Visible = false
                    continue
                end

                local root = char.HumanoidRootPart
                local head = char:FindFirstChild("Head")
                if not head then continue end

                local rootPos, onScreen = Camera:WorldToViewportPoint(root.Position)
                if not onScreen then
                    box.Visible = false
                    nameTag.Visible = false
                    continue
                end

                local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0,1.1,0))
                local legPos = Camera:WorldToViewportPoint(root.Position - Vector3.new(0,4.5,0))

                local height = math.abs(headPos.Y - legPos.Y)
                local width = height * 0.46

                box.Size = Vector2.new(width, height)
                box.Position = Vector2.new(rootPos.X - width/2, rootPos.Y - height/2)
                box.Color = RoleColors[GetRole(player)] or Color3.new(1,1,1)
                box.Visible = true

                nameTag.Text = player.Name .. " [" .. GetRole(player) .. "]"
                nameTag.Position = Vector2.new(rootPos.X, box.Position.Y - 32)
                nameTag.Color = box.Color
                nameTag.Visible = true

                if GetRole(player) == "Murderer" and onScreen then
                    MurdererOnScreen = true
                    CurrentMurderer = player
                end
            end
        end)

        local function ApplyGodMode(char)
            task.wait(0.7)
            local hum = char:FindFirstChild("Humanoid") or char:WaitForChild("Humanoid", 7)
            if hum then
                hum.MaxHealth = math.huge
                hum.Health = math.huge
                hum.WalkSpeed = 27
            end
        end

        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall

        setreadonly(mt, false)

        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}

            if SilentAimEnabled and CurrentMurderer and method == "FireServer" then
                for _, rname in ipairs(RemoteNames) do
                    if self.Name:lower():find(rname:lower()) then
                        local char = CurrentMurderer.Character
                        if char then
                            local part = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
                            if part then
                                if typeof(args[1]) == "Vector3" then
                                    args[1] = part.Position + Vector3.new(0, math.random(-0.5, 0.5), 0)
                                elseif #args >= 2 then
                                    args[2] = part
                                end
                                return oldNamecall(self, unpack(args))
                            end
                        end
                    end
                end
            end

            return oldNamecall(self, ...)
        end)

        setreadonly(mt, true)

        local lastShot = 0
        RunService.Heartbeat:Connect(function()
            if not AutoShootEnabled then return end
            if not HasGun() then return end
            if not MurdererOnScreen or not CurrentMurderer then return end

            local now = tick()
            if now - lastShot >= AutoShootDelay then
                lastShot = now

                for _, rname in ipairs(RemoteNames) do
                    local remote = ReplicatedStorage:FindFirstChild(rname)
                    if remote and remote:IsA("RemoteEvent") then
                        pcall(function()
                            remote:FireServer()
                        end)
                    end
                end
            end
        end)

        RunService.Heartbeat:Connect(function()
            if not MurdererKillAuraEnabled then return end
            if GetRole(LocalPlayer) ~= "Murderer" then return end

            local char = LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end

            local root = char.HumanoidRootPart

            for _, player in ipairs(Players:GetPlayers()) do
                if player == LocalPlayer or not player.Character or not player.Character:FindFirstChild("Humanoid") or player.Character.Humanoid.Health <= 0 then continue end

                local tchar = player.Character
                local troot = tchar:FindFirstChild("HumanoidRootPart")
                if not troot then continue end

                if (troot.Position - root.Position).Magnitude <= MurdererKillAuraRange then
                    for _, rname in ipairs(RemoteNames) do
                        local remote = ReplicatedStorage:FindFirstChild(rname)
                        if remote and remote:IsA("RemoteEvent") then
                            pcall(function()
                                remote:FireServer(tchar:FindFirstChild("Humanoid"))
                            end)
                        end
                    end
                end
            end
        end)

        print("한국 머더리 치트 강화 버전 로드 완료!")
    else
        onMessage("키가 틀렸습니다. 다시 시도하세요.")
    end
end)

print("Platoboost 키 시스템 로드 완료!")
