
NOOverview_Version = "V0.5"

SESSION = {}

SESSION.Gold = {} 
SESSION.Gold.All 		= 0
SESSION.Gold.Loot 		= 0
SESSION.Gold.Ausgaben 	= 0
SESSION.Gold.Repair 	= 0
SESSION.Gold.Quest 		= 0

CurrentSessionID = nil
CurrentCharID = nil

DEBUG = true

NOO = {}


-----------------------------------------------------------
---                German localization                  ---
-----------------------------------------------------------
--[[
if ( GetLocale() == "deDE" ) then
--INSTANCETIME_LOADED_TEXT = "erfolgreich geladen"; asdasdasd
    
end
]]
-- MainFrame: 
BUTTON_TEXT_UBERSICHT 	= "Übersicht"
BUTTON_TEXT_SESSION 	= "Session"
BUTTON_TEXT_TWINKS 		= "Twinks"
BUTTON_TEXT_RAIDS 		= "Raids"

if ( GetLocale() == "enEN" ) then
	--INSTANCETIME_LOADED_TEXT = "erfolgreich geladen";
    
end

--[[
	####	Snippets

	--> Class Icons erstellen	
	self.button1.icon:SetTexture("Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES")
    local coords = CLASS_ICON_TCOORDS["DRUID"]; -- get the coordinates of the class icon we want
    self.button1.icon:SetTexCoord(unpack(coords));

]]