-- Source:https://github.com/tekezo/Karabiner/issues/814#issuecomment-415388742

-- HANDLE SCROLLING WITH MOUSE BUTTON PRESSED
local rightAdditionalButton = 4

local oldmousepos = {}
local scrollmult = -4	-- negative multiplier makes mouse work like traditional scrollwheel

dragOtherToScroll = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDragged }, function(e)
    local pressedMouseButton = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])
    -- print ("pressed mouse " .. pressedMouseButton)
    if rightAdditionalButton == pressedMouseButton
        then 
            -- print("scroll");
            oldmousepos = hs.mouse.getAbsolutePosition()    
            local dx = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaX'])
            local dy = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaY'])
            local scroll = hs.eventtap.event.newScrollEvent({dx * scrollmult, dy * scrollmult},{},'pixel')
            -- put the mouse back
            hs.mouse.setAbsolutePosition(oldmousepos)
            return true, {scroll}
        else 
            return false, {}
        end 
end)

dragOtherToScroll:start()