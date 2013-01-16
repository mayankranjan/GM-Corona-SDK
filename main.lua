-----------------------------------------------------------------------------------------
--
-- main.lua
--
-- Note: You will need to have access to the Game Minion developer portal in order
-- to make use of this and the Game Minion lib (gameminion.lua)
--
-- This file is not meant to be used as is, at the very least gm.init() must be updated
-- with your own game's Access Key and Secret Key.
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

-- Initialize Game Minion
-- Make sure you use your own Access and Secret games keys! This is available on the Portal - [Your Game] - General
gm = gm.init("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")

-- use registerUser() before login you need to have created a user/player 
gm:loginAPI("email","password")

--As a security measure and standard practice we return an error, but we never reveal if the credencials are incorrect or the user doesn't exist
local function listenerLogin(event)
        if (event.errorMsg ~= nil) then         
        	print( "Error Message: "..event.errorMsg)
        end

        --gm:getMyProfile()
        gm:getLeaderboards()

end

local function listenerMyProfile(event)
        if (event.errorMsg ~= nil) then         
        	print( "Error Message: "..event.errorMsg)
        else
        	print("Username: "..event.results.username)
        	print("Email: "..event.results.email)

        end
        --gm:updateMyProfile(nil,nil,"Doe2")
end

local function listenerLeaderboards(event)
        if (event.errorMsg ~= nil) then         
        	print( "Error Message: "..event.errorMsg)
        else
        	if (event.type == "AllLeaderboards") then
				print( "ID ="..event.results[1]._id)
				print( "Leaderboard Name: "..event.results[1].name)
				--gm:submitHighScore(event.results[1]._id, "99200")
        		gm:getLeaderboardScores(event.results[1]._id)
        	end

        	if (event.type == "GetScores") then
        		print( "Username: "..event.results[1].username.."    Score: "..event.results[1].value)
        	end
        end
end


--Here are event listeners that will call the method "listenerLogin" when the response is received
--Please review the gameminion.lua to see the event names that are returned
Runtime:addEventListener( "LoggedIn", listenerLogin )
Runtime:addEventListener( "LoginError", listenerLogin )
Runtime:addEventListener( "MyProfile", listenerMyProfile )
Runtime:addEventListener( "Leaderboards", listenerLeaderboards )
