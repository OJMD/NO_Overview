
NOO.Scripte = {}

-- ### Init Addon Variablen
function NOO.Scripte.Init()

    -- Datenbank initialisieren
    if NOODB == nil then
        NOODB = {}
        NOODB.Session = {}
        NOODB.Chars = {}
    end

    if NOODB.Session ~= nil then
        for i, session in pairs( NOODB.Session ) do
            if session.GUID == UnitGUID("player") and session.Datum == date("%d.%m.%y") then
                CurrentSessionID = i
                if Debuging then
                    print('--> Session wurde gefunden: ' .. CurrentCharID) 
                end             
            end
        end

        if CurrentSessionID == nil then
            CurrentSessionID = table.getn( NOODB.Session ) + 1
            
            NOODB.Session[ CurrentSessionID ] = {
                Gold = 0,
                Realm = GetRealmName("player"),                
                GUID = UnitGUID("player"),
                Datum = date("%d.%m.%y"),
                Timer = 0,
                Ep = 0,
                Ausgaben = 0,
                Repair = 0,
                IniGold = 0,
                IniEp = 0,
                IniTimer = 0
            }
        end
    end
    
end

-- ### Addon Load Data
function NOO.Scripte.Load()
    
    if SESSION.Gold.All == 0 then SESSION.Gold.All = GetMoney("player") end
    
    -- Initial Textfelder vom Monitor auf 0 setzen...
    NOOverview_MonitorFrame_AnzeigeGold:SetText( NOO.Scripte.GoldString( SESSION.Gold.All ) )
    NOOverview_MonitorFrame_AnzeigeGoldGesamt:SetText("0")
    NOOverview_MonitorFrame_AnzeigeEP:SetText("0")
    NOOverview_MonitorFrame_AnzeigeEPGesamt:SetText("0")
    NOOverview_MonitorFrame_AnzeigeDauer:SetText("0")
    NOOverview_MonitorFrame_AnzeigeDauerGesamt:SetText("0")

    --Test
end

-- ### Update Gold
function NOO.Scripte.UpdateGold()
    local tempMoney = 0
end


-- ### Update LevelUp
function NOO.Scripte.PlayerLevelUp()
    -- Dies ist ein Githup Test
end



NOO.Scripte.Monitor = {}

function NOO.Scripte.Monitor.OnLoad(self, event, ...)

    --standard addon loaded events, register addon chat channel prefix, after 1 second delay (allowing for GUIDs) draw and load data
    if event == "ADDON_LOADED" and select(1, ...) == "NO_Overview" then

        NOO.Scripte.Init()           
    end   


    if event == "PLAYER_ENTERING_WORLD" then
        NOO.Scripte.Load()                  
        if DEBUG then  
            print("--> Event PLAYER_ENTERING_WORLD") 
        end
    end
    
    if ( event == "PLAYER_MONEY" ) then        
        NOO.Scripte.UpdateGold()                  
        if DEBUG then  
            print("--> Event PLAYER_MONEY") 
        end                     
    end
    
    if ( event == "PLAYER_LEVEL_UP" ) then        
        NOO.Scripte.PlayerLevelUp()                  
        if DEBUG then  
            print("--> Event PLAYER_LEVEL_UP") 
        end                     
    end
end

--[[
    ######### Main Frame ###########
]]

-- Button Text MainFrame Menü
ButtonText = {}
ButtonText[1] = {	text 	= BUTTON_TEXT_UBERSICHT,
					icon 	= "Interface\\HELPFRAME\\HelpIcon-ReportLag",
					frame 	= "stats"};
ButtonText[2] = {	text 	= BUTTON_TEXT_SESSION,
					icon 	=	"Interface\\HelpFrame\\HelpIcon-AccountSecurity",
					frame 	= "session"};
ButtonText[3] = {	text 	= BUTTON_TEXT_TWINKS,
                    icon 	= "Interface\\HelpFrame\\HelpIcon-CharacterStuck",
                    frame 	= "session"};
ButtonText[4] = {	text 	= BUTTON_TEXT_RAIDS,
                    icon	= "Interface\\HelpFrame\\HelpIcon-Bug",
                    frame 	= "session"};
        
NOO.Scripte.MainFrame = {}

function NOO.Scripte.MainFrame.SetFrameByKey( key )    
    --print("Show Frame: " .. key )
    local data = ButtonText[key];
    if data.frame then
        local showFrame = NOOverview_MainFrame[data.frame];
        for a,frame in pairs(ButtonText) do
            -- print("Frame: " .. frame.frame )
            if showFrame ~= frame.frame then
                NOOverview_MainFrame[ frame.frame ]:Hide();
            end
        end
        showFrame:Show();
    end
end

function NOO.Scripte.MainFrame.OnLoad(self)
    self.leftInset.Bg:SetTexture("Interface\\HelpFrame\\Tileable-Parchment", true, true);

	self.Header.Bg:SetTexture("Interface\\FrameGeneral\\UI-Background-Rock", true, true);
	self.Header.Bg:SetHorizTile(true);
	self.Header.Bg:SetVertTile(true);
    self.Header.HeaderTitle:SetText( "|cff1e90ffNeo|r & |cffcc00ccOJMD|r 's Overview " .. NOOverview_Version )

	self.Bg:SetTexture("Interface\\FrameGeneral\\UI-Background-Rock", true, true);
	self.Bg:SetHorizTile(true);
    self.Bg:SetVertTile(true);
    
end



-- #### Sonstige Funktionen



--[[ Formatiere Gold String]]
function NOO.Scripte.GoldString( gold )
	local str = "";
	local negative = false;

	if( gold > 0 ) then
		gold = gold -- + 101
	end

	if ( gold < 0 ) then
		str = "|cffff0000 -" .. GetCoinTextureString( ( gold * -1 ) ).. "|r";
		negative = true;
	else
		str = "|cffFFFFFF " .. GetCoinTextureString( gold ) .. "|r";
	end
	return str , negative
end
