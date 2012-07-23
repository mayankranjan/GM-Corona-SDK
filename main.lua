-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- helpers
_W = display.contentWidth
_H = display.contentHeight

-- imports
local gm = require("gameminion")
local json = require("json")

local friendID

-- initialize Game Minion
-- Make sure you use your own Access and Secret games keys!
gm = gm.init("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")

gm:loginAPI("janedoe@mailmail.com","password")



--As a security measure and standard practice we return an error, but we never reveal if the credencials are incorrect or the user doesn't exist
local function listenerLogin(event)
        if (event.errorMsg ~= nil) then         
        	print( "Error Message: "..event.errorMsg)
        end
        --gm:updateMyProfile(nil,nil,"Doe2")
        gm:getMyProfile()
end


--Here are event listeners that will call the method "listenerLogin" when the response is received
--Please review the gameminion.lua to see the event names that are returned
Runtime:addEventListener( "LoggedIn", listenerLogin )
Runtime:addEventListener( "LoginError", listenerLogin )