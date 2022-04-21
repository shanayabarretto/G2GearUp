-- remember that main.lua must exist
-- so i guess in this program ill just make it using rectangles and transfer to sprite sheet.
-- SHOULD RESET STUFF BEFORE CHANGING BACK TO NORMAL STATE!!!
-- ALSO WATCH PONG11 FOR AUDIO!!!! + 12 to resize

-- constants for 16:9 aspect ratio
WINDOW_WIDTH = 1275
WINDOW_HEIGHT = 765 -- i adjusted them, not 16:9

--for virtual raster
VIRTUAL_WIDTH = 480 -- was 432
VIRTUAL_HEIGHT = 288

-- for car speed
--AMB_SPEED = 200 -- pixels per second

-- imports push library
push = require 'push'
-- imports class library
Class = require 'class'

-- all of these are accessible anywhere, only local creates a scope
-- You also need to import your own class files, must do this after class
require 'Util'
-- Util is used in Map so it must be before
require 'Car'
require 'Map'
-- may need to move this
require 'Player'


-- initializes game state at the beginning
function love.load()
    -- seed random number generator
    math.randomseed(os.time())

    love.graphics.setDefaultFilter('nearest', 'nearest') -- makes it not blurry
    -- adding a new font
    titles = love.graphics.newFont('fonts/GAMEPLAY-1987.ttf', 16) -- creates a font object
    orderfont = love.graphics.newFont('fonts/order.ttf', 8)
    fpsfont = love.graphics.newFont("fonts/font.ttf", 8)

    -- setting up the audio
    sounds = { 
        ['ambsound'] = love.audio.newSource('audio/ambulance.wav', 'static'),
        ['strsound'] = love.audio.newSource('audio/street4.wav', 'static')
    }

    -- labels the application window
    love.window.setTitle("G2 Gear Up!")

    -- make the object, init gets called implicitly bc of the parameters
    --car1 = Car(VIRTUAL_WIDTH / 2 - 10, VIRTUAL_HEIGHT / 2 + 60, 20, 50)
    -- Remove this later
    --randorec = Car(100, -50, 10, 20)
    

    -- we will make a class for maps, this is generating an object
    map = Map()
    ambb = Car(32*6+2, 32*9, 28, 60)
    amblue = Car(32*6+14, 32*9+12, 4, 4)
    amred = Car(32*6+10, 32*9+12, 4, 4)
    amred2 = Car(32*6+18, 32*9+12, 4, 4)

    --game state variable
    gameState = 'start'
    speed = 60
    -- RESET SPEED LATER

    -- decides how big the game screen is
    -- curly braces indicate a table
    -- push is an object, we are calling a method to help with this
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false, -- similar to other, just window
        vsync = true, -- no screen tearing
        resizable = false -- keep aspect ratio
    })

    -- where to stop at each level
    stopheight = 7

    -- variables for keyboard input
    costume = 1
    totalchanges = 0
    totalchanges2 = 0
    shoulderCheck = 0
    rearviewCheck = 0
    signalCheck = 0
    slowCheck = 0
    rightlaneCheck = 0
    leftlaneCheck = 0
    stopCheck = 0
    rightturnCheck = 0
    leftturnCheck = 0
    lookrightCheck = 0
    lookleftCheck = 0
    driveCheck = 0

    shoulderEnable = 0
    rearviewEnable = 0
    signalEnable = 0
    slowEnable = 0
    rightlaneEnable = 0
    leftlaneEnable = 0
    stopEnable = 0
    rightturnEnable = 0
    leftturnEnable = 0
    lookrightEnable = 0
    lookleftEnable = 0
    driveEnable = 0

    m2Enable = 0
    s2Enable = 0
    c2Enable = 0
    m2Check = 0
    s2Check = 0
    c2Check = 0
    moveEnable = 0
    startmove = 0
    drive2Enable = 0
    goleftEnable = 0
    changelight = 0
    gorightEnable = 0
    ready4amb = 0
    -- reset all when done
    -- I think they may only work for one time? if u have to use stuff twice = more vs
    -- does resetting to 0 in update even do anything ? idts

    -- use these to enable and change writing, fix in player.lua- right/left lanes, right/left turns, drive
end

-- function is called each frame, dt used to scale
function love.update(dt) -- dt moves things indpendent of frame rate

    -- needs to be called for autoscrolling
    map:update(dt)
    ambb:update(dt)
    amblue:update(dt)
    amred:update(dt)
    amred2:update(dt)

    -- checks for collision > has to be an obj tho?
    --if car1:collides(randorec) then
        -- tried changing game state but it doesnt let u change back lol
        -- fun revelation! you cant actually print stuff elsewhere!
        -- if they arent being rendered ig theyre still in the same spot righttttttttt
        -- even if i change gamestate i didnt move it
    --end
    -- updates the object
    --car1:update(dt)

    --if love.keyboard.isDown('up') then -- can add an elseif option
        --car1.dy = -CAR_SPEED -- changes the dy so things happen in the other file, negative bc up
    --end
end


-- can make different keys signify different things
function love.keypressed(key) -- only fires once when key is pressed
    if key == 'escape' then
        love.event.quit()
    end
    
    if key == 'space' then
        gameState = 'play'
    end

    -- REMOVE THIS LATER
    --if key == 'o' then
        --gameState = 'done' -- when it hits an end only- player.lua-- gotta cap
        -- at the end of each we only clear the variables ig
        -- except for the up arrow, that has to be done at the end only before saying done
        -- must change its movementttt
    --end

    if key == 'return' or key == 'enter' then
        if gameState == 'done' then
            speed = 60

            -- reset the vs
            totalchanges = 0
            totalchanges2 = 0
            costume = 1
            shoulderCheck = 0
            rearviewCheck = 0
            signalCheck = 0
            slowCheck = 0
            rightlaneCheck = 0
            leftlaneCheck = 0
            stopCheck = 0
            rightturnCheck = 0
            leftturnCheck = 0
            lookrightCheck = 0
            lookleftCheck = 0
            driveCheck = 0

            shoulderEnable = 0
            rearviewEnable = 0
            signalEnable = 0
            slowEnable = 0
            rightlaneEnable = 0
            leftlaneEnable = 0
            stopEnable = 0
            rightturnEnable = 0
            leftturnEnable = 0
            lookrightEnable = 0
            lookleftEnable = 0
            driveEnable = 0

            m2Enable = 0
            s2Enable = 0
            c2Enable = 0
            m2Check = 0
            s2Check = 0
            c2Check = 0
            moveEnable = 0
            startmove = 0
            drive2Enable = 0
            goleftEnable = 0
            changelight = 0
            gorightEnable = 0
            ready4amb = 0
            --done resetting

            levelGen = math.random(10)
            map:reset()
            ambb:reset(32*6+2, 32*9)
            amblue:reset(32*6+14, 32*9+12)
            amred:reset(32*6+10, 32*9+12)
            amred2:reset(32*6+18, 32*9+12)
            gameState = 'play'
        end
    end

    if key == 'down' and slowEnable == 1 then
        slowCheck = 1
        if levelGen == 10 then
            if speed == 40 then
            else
                speed = speed - 10
            end
        end

    end

    --if key == 'right' and rightlaneEnable == 1 then
        --rightlaneCheck = 1
    --end

    --if key == 'left' and leftlaneEnable == 1 then
        --leftlaneCheck = 1
    --end

    if (key == 'c' or key == 'C') and shoulderEnable == 1 then
        shoulderCheck = 1
        if c2Enable == 1 then
            c2Check = 1
        end
    end

    if (key == 'r' or key == 'R') and rightturnEnable == 1 then
        rightturnCheck = 1
    end

    if (key == 'l' or key == 'L') and leftturnEnable == 1 then
        leftturnCheck = 1
    end

    if (key == 't' or key == 'T') and stopEnable == 1 then
        stopCheck = 1
    end

    if key == 'up' and driveEnable == 1 then
        driveCheck = 1
        if drive2Enable == 1 then
            driveCheck = 2
        end
        -- i feel like for this we can have them add? but it has to reset when it hits a certain block
    end

    if (key == 'b' or key == 'B') and rearviewEnable == 1 then
        rearviewCheck = 1
        if m2Enable == 1 then
            m2Check = 1
        end
    end
    -- oh no... you do need a second v

    if (key == 's' or key == 'S') and signalEnable == 1 then
        signalCheck = 1
        if s2Enable == 1 then
            s2Check = 1
        end
    end

    if (key == 'a' or key == 'A') and lookleftEnable == 1 then
        lookleftCheck = 1
    end

    if (key == 'd' or key == 'D') and lookrightEnable == 1 then
        lookrightCheck = 1
    end

    -- clear first drive early on but not the last- hit coordinates
    -- gonna need to cap those, and ur gonna need to caplane change as well
    -- next step is changing texts
end


-- the love.draw() functions decides what gets displayed, called each frame after update
function love.draw()
    push:apply('start') -- required to render. Its a switch.
    -- clear the screen with one colour- last is opacity. 
    love.graphics.clear(119/255, 174/255, 64/255, 255/255)

    displayFPS()

    if gameState ~= 'start' then

        if levelGen ~= 9 then
            sounds['strsound']:play()
        end
        
        if levelGen == 10 then
            displaySpeed()
        end

        -- floor is necessary- integer
        -- love.graphics.translate(math.floor(-map.camX), math.floor(map.camY))
        -- he said + 0.5 for some reason
        map:render() 
        ambb:render()
        love.graphics.setColor(1, 0, 0, 1)
        amred:render()
        amred2:render()
        love.graphics.setColor(0, 0, 1, 1)
        amblue:render()
        love.graphics.setColor(1, 1, 1, 1)

        love.graphics.setFont(fpsfont)
        -- colours?
        love.graphics.printf("'C' = SHOULDER CHECK", 10, 30, VIRTUAL_WIDTH, 'left')
        love.graphics.printf("'T' = STOP CAR", 100, 30, VIRTUAL_WIDTH, 'left')
        love.graphics.printf("'S' = TURN ON SIGNAL", -10, 30, VIRTUAL_WIDTH, 'right')
        love.graphics.printf("'B' = CHECK REARVIEW", -100, 30, VIRTUAL_WIDTH, 'right')
        love.graphics.printf("'R' = TURN RIGHT", 10, 40, VIRTUAL_WIDTH, 'left')
        love.graphics.printf("'L' = TURN LEFT", 100, 40, VIRTUAL_WIDTH, 'left')
        love.graphics.printf("'A' = LOOK TO LEFT", -23, 40, VIRTUAL_WIDTH, 'right')
        love.graphics.printf("'D' = LOOK TO RIGHT", -105, 40, VIRTUAL_WIDTH, 'right')
        love.graphics.printf("'<' = CHANGE LANES-L", 10, 50, VIRTUAL_WIDTH, 'left')
        love.graphics.printf("'>' = CHANGE LANES-R", 100, 50, VIRTUAL_WIDTH, 'left')
        love.graphics.printf("'^' = DRIVE VEHICLE", -19, 50, VIRTUAL_WIDTH, 'right')
        love.graphics.printf("'v' = SLOW VEHICLE", -110, 50, VIRTUAL_WIDTH, 'right')

        if levelGen == 1 then
            love.graphics.setFont(titles)
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.printf("APPROACHING STOP SIGN", 0, 65, VIRTUAL_WIDTH, 'center')

            love.graphics.setFont(orderfont)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.printf("1. drive forward", 10, 32*5 + 10, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("2. Slow down", 10, 32*5 + 25, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("3. check rearview mirror", 10, 32*5 + 40, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("4. stop", 10, 32*5 + 55, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("5. look right", 10, 32*5 + 70, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("6. look left", 10, 32*5 + 85, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("7. drive forward", 10, 32*5 + 100, VIRTUAL_WIDTH, 'left')

            love.graphics.setColor(44/255, 93/255, 44/255, 1)

            -- still need to disable funcs!! what if i say all next ones r 0- nope
            driveEnable = 1 -- still must add to all
            movee() -- move enable cannot be here
            if driveCheck ~= 0 then
                if moveEnable == 0 then
                    love.graphics.printf("1. drive forward", 10, 32*5 + 10, VIRTUAL_WIDTH, 'left')
                    slowEnable = 1
                end
                if slowCheck == 1 then
                    love.graphics.printf("2. Slow down", 10, 32*5 + 25, VIRTUAL_WIDTH, 'left')
                    rearviewEnable = 1
                    if rearviewCheck == 1 then
                        love.graphics.printf("3. check rearview mirror", 10, 32*5 + 40, VIRTUAL_WIDTH, 'left')
                        stopEnable = 1
                        if stopCheck == 1 then
                            love.graphics.printf("4. stop", 10, 32*5 + 55, VIRTUAL_WIDTH, 'left')
                            lookrightEnable = 1
                            if lookrightCheck == 1 then
                                love.graphics.printf("5. look right", 10, 32*5 + 70, VIRTUAL_WIDTH, 'left')
                                lookleftEnable = 1
                                if lookleftCheck == 1 then
                                    love.graphics.printf("6. look left", 10, 32*5 + 85, VIRTUAL_WIDTH, 'left')
                                    love.graphics.printf("1. drive forward", 10, 32*5 + 10, VIRTUAL_WIDTH, 'left')
                                    drive2Enable = 1
                                     -- most recent would make it 1 right
                                    if driveCheck > 1 then
                                        love.graphics.printf("7. drive forward", 10, 32*5 + 100, VIRTUAL_WIDTH, 'left')
                                        -- dont let it acc end till done, acc no
                                    end
                                end
                            end
                        end
                    end
                end
            end


        elseif levelGen == 2 then
            love.graphics.setFont(titles)
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.printf("APPROACHING ALL WAY STOP SIGN", 0, 65, VIRTUAL_WIDTH, 'center')

            love.graphics.setFont(orderfont)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.printf("1. drive forward", 10, 32*5 + 25, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("2. Slow down", 10, 32*5 + 40, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("3. check rearview mirror", 10, 32*5 + 55, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("4. stop", 10, 32*5 + 70, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("5. drive forward", 10, 32*5 + 85, VIRTUAL_WIDTH, 'left')

            love.graphics.setColor(44/255, 93/255, 44/255, 1)

            -- still need to disable funcs!! what if i say all next ones r 0- nope
            driveEnable = 1
            movee()
            if driveCheck ~= 0 then
                if moveEnable == 0 then
                    love.graphics.printf("1. drive forward", 10, 32*5 + 25, VIRTUAL_WIDTH, 'left')
                    slowEnable = 1
                end
                if slowCheck == 1 then
                    love.graphics.printf("2. Slow down", 10, 32*5 + 40, VIRTUAL_WIDTH, 'left')
                    rearviewEnable = 1
                    if rearviewCheck == 1 then
                        love.graphics.printf("3. check rearview mirror", 10, 32*5 + 55, VIRTUAL_WIDTH, 'left')
                        stopEnable = 1
                        if stopCheck == 1 then
                            love.graphics.printf("4. stop", 10, 32*5 + 70, VIRTUAL_WIDTH, 'left')
                            love.graphics.printf("1. drive forward", 10, 32*5 + 25, VIRTUAL_WIDTH, 'left')
                            drive2Enable = 1
                            if driveCheck > 1 then
                                love.graphics.printf("5. drive forward", 10, 32*5 + 85, VIRTUAL_WIDTH, 'left')
                                    -- dont let it acc end till done, acc no
                            end
                        end       
                    end
                end
            end


        elseif levelGen == 3 then
            love.graphics.setFont(titles)
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.printf("CHANGE TO LEFT LANE", 0, 65, VIRTUAL_WIDTH, 'center')

            love.graphics.setFont(orderfont)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.printf("1. drive forward", 10, 32*3, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("2. check rearview mirror", 10, 32*3 + 15, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("3. signal", 10, 32*3 + 30, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("4. shoulder check", 10, 32*3 + 45, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("5. change to left lane", 10, 32*3 + 60, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("6. drive forward", 10, 32*3 + 75, VIRTUAL_WIDTH, 'left')

            love.graphics.setColor(44/255, 93/255, 44/255, 1)

            -- still need to disable funcs!! what if i say all next ones r 0- nope
            driveEnable = 1
            movee()
            if driveCheck ~= 0 then
                if moveEnable == 0 then
                    love.graphics.printf("1. drive forward", 10, 32*3, VIRTUAL_WIDTH, 'left')
                    rearviewEnable = 1
                end
                if rearviewCheck == 1 then
                    love.graphics.printf("2. check rearview mirror", 10, 32*3 + 15, VIRTUAL_WIDTH, 'left')
                    signalEnable = 1
                    if signalCheck == 1 then
                        lanechanges()
                        love.graphics.printf("3. signal", 10, 32*3 + 30, VIRTUAL_WIDTH, 'left')
                        shoulderEnable = 1
                        if shoulderCheck == 1 then
                            love.graphics.printf("4. shoulder check", 10, 32*3 + 45, VIRTUAL_WIDTH, 'left')
                            love.graphics.printf("1. drive forward", 10, 32*3, VIRTUAL_WIDTH, 'left')
                            leftlaneEnable = 1
                            if leftlaneCheck == 1 then -- dont let it turn till it hits smth specific- in player.lua
                                -- when it hits its done
                                love.graphics.printf("5. change to left lane", 10, 32*3 + 60, VIRTUAL_WIDTH, 'left')
                                totalchanges = 1
                                lanechanges()
                                drive2Enable = 1
                                if driveCheck > 1 then
                                    love.graphics.printf("6. drive forward", 10, 32*3 + 75, VIRTUAL_WIDTH, 'left')
                                    -- dont let it acc end till done, acc no
                                end
                            end
                        end
                    end
                end
            end

        elseif levelGen == 4 then
            love.graphics.setFont(titles)
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.printf("TURN LEFT", 0, 65, VIRTUAL_WIDTH, 'center')

            love.graphics.setFont(orderfont)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.printf("1. signal", 10, 32*5 + 10, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("2. drive", 10, 32*5 + 25, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("3. slow down", 10, 32*5 + 40, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("4. stop if necessary", 10, 32*5 + 55, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("5. look left", 10, 32*5 + 70, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("6. turn left", 10, 32*5 + 85, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("7. drive vehicle", 10, 32*5 + 100, VIRTUAL_WIDTH, 'left')

            love.graphics.setColor(44/255, 93/255, 44/255, 1)

            -- still need to disable funcs!! what if i say all next ones r 0- nope
            signalEnable = 1
            if signalCheck == 1 then
                lanechanges()
                totalchanges = 2
                love.graphics.printf("1. signal", 10, 32*5 + 10, VIRTUAL_WIDTH, 'left')
                driveEnable = 1
                movee()
                if driveCheck ~= 0 then
                    if moveEnable == 0 then
                        love.graphics.printf("2. drive", 10, 32*5 + 25, VIRTUAL_WIDTH, 'left')
                        slowEnable = 1
                    end
                    if slowCheck == 1 then
                        love.graphics.printf("2. drive", 10, 32*5 + 25, VIRTUAL_WIDTH, 'left')
                        love.graphics.printf("3. slow down", 10, 32*5 + 40, VIRTUAL_WIDTH, 'left')
                        love.graphics.printf("4. stop if necessary", 10, 32*5 + 55, VIRTUAL_WIDTH, 'left')
                        lookleftEnable = 1
                        if lookleftCheck == 1 then
                            love.graphics.printf("5. look left", 10, 32*5 + 70, VIRTUAL_WIDTH, 'left')
                            leftturnEnable = 1
                            if leftturnCheck == 1 then
                                love.graphics.printf("6. turn left", 10, 32*5 + 85, VIRTUAL_WIDTH, 'left')
                                drive2Enable = 1
                                if driveCheck > 1 then
                                    love.graphics.printf("7. drive vehicle", 10, 32*5 + 100, VIRTUAL_WIDTH, 'left')
                                end
                            end
                        end
                    end
                end
            end
            
        elseif levelGen == 5 then
            love.graphics.setFont(titles)
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.printf("TURN RIGHT", 0, 65, VIRTUAL_WIDTH, 'center')
            
            love.graphics.setFont(orderfont)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.printf("1. signal", 32*10+10, 32*5 + 20, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("2. drive", 32*10+10, 32*5 + 35, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("3. slow down", 32*10+10, 32*5 + 50, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("4. look right", 32*10+10, 32*5 + 65, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("5. turn right", 32*10+10, 32*5 + 80, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("6. drive vehicle", 32*10+10, 32*5 + 95, VIRTUAL_WIDTH, 'left')

            love.graphics.setColor(44/255, 93/255, 44/255, 1)

            -- still need to disable funcs!! what if i say all next ones r 0- nope
            signalEnable = 1
            if signalCheck == 1 then
                lanechangesr()
                totalchanges2 = 2
                love.graphics.printf("1. signal", 32*10+10, 32*5 + 20, VIRTUAL_WIDTH, 'left')
                driveEnable = 1
                movee()
                if driveCheck ~= 0 then
                    if moveEnable == 0 then
                        love.graphics.printf("2. drive", 32*10+10, 32*5 + 35, VIRTUAL_WIDTH, 'left')
                        slowEnable = 1
                    end
                    if slowCheck == 1 then
                        love.graphics.printf("2. drive", 32*10+10, 32*5 + 35, VIRTUAL_WIDTH, 'left')
                        love.graphics.printf("3. slow down", 32*10+10, 32*5 + 50, VIRTUAL_WIDTH, 'left')
                        lookrightEnable = 1
                        if lookrightCheck == 1 then
                            love.graphics.printf("4. look right", 32*10+10, 32*5 + 65, VIRTUAL_WIDTH, 'left') -- for peds
                            rightturnEnable = 1
                            if rightturnCheck == 1 then
                                love.graphics.printf("5. turn right", 32*10+10, 32*5 + 80, VIRTUAL_WIDTH, 'left')
                                drive2Enable = 1
                                if driveCheck > 1 then
                                    love.graphics.printf("6. drive vehicle", 32*10+10, 32*5 + 95, VIRTUAL_WIDTH, 'left')
                                end
                            end
                        end
                    end
                end
            end

        elseif levelGen == 6 then
            love.graphics.setFont(titles)
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.printf("TURN RIGHT ON RED LIGHT", 0, 65, VIRTUAL_WIDTH, 'center')

            love.graphics.setFont(orderfont)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.printf("1. signal", 50, 32*5 + 20, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("2. drive", 50, 32*5 + 35, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("3. slow down", 50, 32*5 + 50, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("4. check rearview", 32*10+10, 32*5 + 20, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("5. stop, then move up", 32*10+10, 32*5 + 35, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("6. look right", 32*10+10, 32*5 + 50, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("7. look left", 32*10+10, 32*5 + 65, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("8. turn right", 32*10+10, 32*5 + 80, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("9. drive vehicle", 32*10+10, 32*5 + 95, VIRTUAL_WIDTH, 'left')

            love.graphics.setColor(44/255, 93/255, 44/255, 1)
            signalEnable = 1
            if signalCheck == 1 then
                lanechangesr()
                totalchanges2 = 2
                love.graphics.printf("1. signal", 50, 32*5 + 20, VIRTUAL_WIDTH, 'left')
                driveEnable = 1
                movee()
                if driveCheck ~= 0 then
                    if moveEnable == 0 then
                        love.graphics.printf("2. drive", 50, 32*5 + 35, VIRTUAL_WIDTH, 'left')
                        slowEnable = 1
                    end
                    if slowCheck == 1 then
                        love.graphics.printf("2. drive", 50, 32*5 + 35, VIRTUAL_WIDTH, 'left')
                        love.graphics.printf("3. slow down", 50, 32*5 + 50, VIRTUAL_WIDTH, 'left')
                        rearviewEnable = 1
                        if rearviewCheck == 1 then
                            love.graphics.printf("4. check rearview", 32*10+10, 32*5 + 20, VIRTUAL_WIDTH, 'left')
                            stopEnable = 1
                            if stopCheck == 1 then
                                love.graphics.printf("5. stop, then move up", 32*10+10, 32*5 + 35, VIRTUAL_WIDTH, 'left')
                                shiftt()
                                lookrightEnable = 1
                                if lookrightCheck == 1 then
                                    love.graphics.printf("6. look right", 32*10+10, 32*5 + 50, VIRTUAL_WIDTH, 'left')
                                    lookleftEnable = 1
                                    if lookleftCheck == 1 then
                                        love.graphics.printf("7. look left", 32*10+10, 32*5 + 65, VIRTUAL_WIDTH, 'left')
                                        rightturnEnable = 1
                                        if rightturnCheck == 1 then
                                            love.graphics.printf("8. turn right", 32*10+10, 32*5 + 80, VIRTUAL_WIDTH, 'left')
                                            drive2Enable = 1
                                            if driveCheck > 1 then
                                                love.graphics.printf("9. drive vehicle", 32*10+10, 32*5 + 95, VIRTUAL_WIDTH, 'left') 
                                            end
                                        end
                                    end            
                                end
                            end
                        end
                    end
                end
            end

        elseif levelGen == 7 then
            love.graphics.setFont(titles)
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.printf("APPROACHING RED LIGHT", 0, 65, VIRTUAL_WIDTH, 'center')
            -- change when it switches

            love.graphics.setFont(orderfont)
            love.graphics.setColor(16/255, 58/255, 171/255, 1)
            love.graphics.printf("When light becomes green:", 10, 32*5 + 70, VIRTUAL_WIDTH, 'left')
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.printf("1. drive", 10, 32*5 + 10, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("2. slow down", 10, 32*5 + 25, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("3. check rearview mirror", 10, 32*5 + 40, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("4. stop", 10, 32*5 + 55, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("5. look left", 10, 32*5 + 85, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("6. look right", 32*10+10, 32*5 + 10, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("7. drive vehicle", 32*10+10, 32*5 + 25, VIRTUAL_WIDTH, 'left')

            love.graphics.setColor(44/255, 93/255, 44/255, 1)

            -- still need to disable funcs!! what if i say all next ones r 0- nope
            driveEnable = 1
            movee()
            if driveCheck ~= 0 then
                if moveEnable == 0 then
                    love.graphics.printf("1. drive", 10, 32*5 + 10, VIRTUAL_WIDTH, 'left')
                    slowEnable = 1
                end
                if slowCheck == 1 then
                    love.graphics.printf("1. drive", 10, 32*5 + 10, VIRTUAL_WIDTH, 'left')
                    love.graphics.printf("2. slow down", 10, 32*5 + 25, VIRTUAL_WIDTH, 'left')
                    rearviewEnable = 1
                    if rearviewCheck == 1 then
                        love.graphics.printf("3. check rearview mirror", 10, 32*5 + 40, VIRTUAL_WIDTH, 'left')
                        stopEnable = 1
                        if stopCheck == 1 then
                            changelightt()
                            love.graphics.printf("4. stop", 10, 32*5 + 55, VIRTUAL_WIDTH, 'left')
                            lookleftEnable = 1
                            -- need to add some signal to change light
                            if lookleftCheck == 1 then
                                love.graphics.printf("5. look left", 10, 32*5 + 85, VIRTUAL_WIDTH, 'left')
                                lookrightEnable = 1
                                if lookrightCheck ==1 then
                                    love.graphics.printf("6. look right", 32*10+10, 32*5 + 10, VIRTUAL_WIDTH, 'left')
                                    drive2Enable = 1
                                    if driveCheck > 1 then
                                        love.graphics.printf("7. drive vehicle", 32*10+10, 32*5 + 25, VIRTUAL_WIDTH, 'left')
                                    end
                                end
                            end
                        end
                    end
                end
            end

        elseif levelGen == 8 then
            love.graphics.setFont(titles)
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.printf("APPROACHING GREEN LIGHT", 0, 65, VIRTUAL_WIDTH, 'center')

            love.graphics.setFont(orderfont)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.printf("1. drive forward", 10, 32*5+25, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("2. slow down", 10, 32*5 + 40, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("3. look left", 10, 32*5 + 55, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("4. look right", 10, 32*5 + 70, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("5. drive forward", 10, 32*5 + 85, VIRTUAL_WIDTH, 'left')

            love.graphics.setColor(44/255, 93/255, 44/255, 1)

            -- still need to disable funcs!! what if i say all next ones r 0- nope
            driveEnable = 1
            movee()
            if driveCheck ~= 0 then
                if moveEnable == 0 then
                    love.graphics.printf("1. drive forward", 10, 32*5+25, VIRTUAL_WIDTH, 'left')
                    slowEnable = 1
                end
                if slowCheck == 1 then
                    love.graphics.printf("1. drive forward", 10, 32*5+25, VIRTUAL_WIDTH, 'left')
                    love.graphics.printf("2. slow down", 10, 32*5 + 40, VIRTUAL_WIDTH, 'left')
                    lookleftEnable = 1
                    if lookleftCheck == 1 then
                        love.graphics.printf("3. look left", 10, 32*5 + 55, VIRTUAL_WIDTH, 'left')
                        lookrightEnable = 1
                        if lookrightCheck == 1 then
                            love.graphics.printf("4. look right", 10, 32*5 + 70, VIRTUAL_WIDTH, 'left')
                            drive2Enable = 1
                            if driveCheck > 1 then
                                love.graphics.printf("5. drive forward", 10, 32*5 + 85, VIRTUAL_WIDTH, 'left')
                            end 
                        end
                    end
                end
            end

        elseif levelGen == 9 then
            
            if m2Enable == 0 then
                sounds['ambsound']:play()
                sounds['strsound']:pause()
            else
                sounds['strsound']:play()
            end
            love.graphics.setFont(titles)
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.printf("AMBULANCE APPROACHING", 0, 65, VIRTUAL_WIDTH, 'center')

            -- needs lots of editing
            love.graphics.setFont(orderfont)
            love.graphics.setColor(16/255, 58/255, 171/255, 1)
            love.graphics.printf("When ambulance passes:", 20, 32*4 + 100, VIRTUAL_WIDTH, 'left')
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.printf("1. drive", 20, 32*4 + 10, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("2. check rearview mirror", 20, 32*4 + 25, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("3. signal", 20, 32*4 + 40, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("4. shoulder check", 20, 32*4 + 55, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("5. change to right lane", 20, 32*4 + 70, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("6. stop", 20, 32*4 + 85, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("7. check rearview mirror", 20, 32*4 + 115, VIRTUAL_WIDTH, 'left')

            love.graphics.printf("8. signal", 32*10+ 10, 32*4 + 10, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("9. shoulder check", 32*10+10, 32*4 + 25, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("10. move one lane left", 32*10+10, 32*4 + 40, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("11. drive forward", 32*10+10, 32*4 + 55, VIRTUAL_WIDTH, 'left')

            love.graphics.setColor(44/255, 93/255, 44/255, 1)

            -- still need to disable funcs!! what if i say all next ones r 0- nope
            driveEnable = 1
            movee()
            if driveCheck ~= 0 then
                if moveEnable == 0 then
                    love.graphics.printf("1. drive", 20, 32*4 + 10, VIRTUAL_WIDTH, 'left')
                    rearviewEnable = 1
                end
                if rearviewCheck == 1 then
                    love.graphics.printf("1. drive", 20, 32*4 + 10, VIRTUAL_WIDTH, 'left')
                    love.graphics.printf("2. check rearview mirror", 20, 32*4 + 25, VIRTUAL_WIDTH, 'left')
                    signalEnable = 1
                    if signalCheck == 1 then
                        lanechangesr()
                        love.graphics.printf("3. signal", 20, 32*4 + 40, VIRTUAL_WIDTH, 'left')
                        shoulderEnable = 1
                        if shoulderCheck == 1 then
                            love.graphics.printf("4. shoulder check", 20, 32*4 + 55, VIRTUAL_WIDTH, 'left')
                            rightlaneEnable = 1
                            if rightlaneCheck == 1 then
                                totalchanges2 = 1
                                lanechangesr()
                                love.graphics.printf("5. change to right lane", 20, 32*4 + 70, VIRTUAL_WIDTH, 'left')
                                stopEnable = 1
                                if stopCheck == 1 then
                                    love.graphics.printf("6. stop", 20, 32*4 + 85, VIRTUAL_WIDTH, 'left')
                                    -- m2 should only be enabled when the ambulance hits
                                    --m2Enable = 1
                                    ready4amb = 1
                                    if m2Check == 1 then
                                        love.graphics.printf("7. check rearview mirror", 20, 32*4 + 115, VIRTUAL_WIDTH, 'left')
                                        s2Enable = 1
                                        if s2Check == 1 then
                                            lanechanges()
                                            love.graphics.printf("8. signal", 32*10+ 10, 32*4 + 10, VIRTUAL_WIDTH, 'left')
                                            c2Enable = 1
                                            if c2Check == 1 then
                                                love.graphics.printf("9. shoulder check", 32*10+10, 32*4 + 25, VIRTUAL_WIDTH, 'left')
                                                leftlaneEnable = 1
                                                if leftlaneCheck == 1 then
                                                    totalchanges = 1
                                                    lanechanges()
                                                    love.graphics.printf("10. move one lane left", 32*10+10, 32*4 + 40, VIRTUAL_WIDTH, 'left')
                                                    drive2Enable = 1
                                                    if driveCheck > 1 then
                                                        love.graphics.printf("11. drive forward", 32*10+10, 32*4 + 55, VIRTUAL_WIDTH, 'left')
                                                    end 
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            
            
        elseif levelGen == 10 then
            love.graphics.setFont(titles)
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.printf("ENTERING SCHOOL ZONE", 0, 65, VIRTUAL_WIDTH, 'center')

            love.graphics.setFont(orderfont)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.printf("1. drive forward", 10, 32*3 + 10, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("2. slow down to 40 km per hr", 10, 32*3 + 25, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("3. look left", 10, 32*3 + 40, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("4. look right", 10, 32*3 + 55, VIRTUAL_WIDTH, 'left')
            love.graphics.printf("5. drive forward", 10, 32*3 + 70, VIRTUAL_WIDTH, 'left')

            love.graphics.setColor(44/255, 93/255, 44/255, 1)

            -- still need to disable funcs!! what if i say all next ones r 0- nope
            movee()
            driveEnable = 1
            if driveCheck ~= 0 then
                if moveEnable == 0 then
                    love.graphics.printf("1. drive forward", 10, 32*3 + 10, VIRTUAL_WIDTH, 'left')
                    slowEnable = 1
                end
                if slowCheck == 1 then -- ig u could check if its over 2 as well
                    love.graphics.printf("1. drive forward", 10, 32*3 + 10, VIRTUAL_WIDTH, 'left')
                    if speed == 40 then
                        love.graphics.printf("2. slow down to 40 km per hr", 10, 32*3 + 25, VIRTUAL_WIDTH, 'left')
                        lookleftEnable = 1
                    end
                    if lookleftCheck == 1 then
                        love.graphics.printf("3. look left", 10, 32*3 + 40, VIRTUAL_WIDTH, 'left')
                        lookrightEnable = 1
                        if lookrightCheck == 1 then
                            love.graphics.printf("4. look right", 10, 32*3 + 55, VIRTUAL_WIDTH, 'left')
                            drive2Enable = 1
                            if driveCheck > 1 then
                                love.graphics.printf("5. drive forward", 10, 32*3 + 70, VIRTUAL_WIDTH, 'left')
                            end 
                        end
                    end
                end
            end
        end

        if gameState == 'done' then
            love.graphics.setColor(43/255, 111/255, 36/255, 1)
            love.graphics.rectangle('line', 70, VIRTUAL_HEIGHT / 2 - 30, 342, 28)
            love.graphics.setColor(0, 1, 0, 1)
            love.graphics.rectangle('fill', 70, VIRTUAL_HEIGHT / 2 - 29, 340, 26)
            love.graphics.setFont(titles)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.printf("GREAT! PRESS ENTER TO CONTINUE", 0, VIRTUAL_HEIGHT / 2 - 25, VIRTUAL_WIDTH, 'center')
            love.graphics.setColor(1, 1, 1, 1)
        end
        
        -- i dont think line below does anything
        --love.graphics.rotate(math.pi)
        
        --draws the car as per the other files instructions
        --love.graphics.setColor(1, 1, 0, 1)
        --car1:render()
        --love.graphics.setColor(1, 1, 1, 1) 
        
        -- ill make a stop sign i guess
        -- randorec:render()
        -- Made the x position weird for collision
        -- remove these later ^^ 
    end 

    -- take away 6 because its 12 pixels, centered makes x centre. Ig we can only centre on one axis
    if gameState == 'start' then
        love.graphics.setFont(titles)
        love.graphics.printf("WELCOME TO G2 GEAR UP!", 0, 30, VIRTUAL_WIDTH, 'center') -- all caps cause of font
        love.graphics.printf("PRESS THE SPACE BAR TO BEGIN", 0, VIRTUAL_HEIGHT - 46, VIRTUAL_WIDTH, 'center')

        love.graphics.setFont(orderfont) -- similar font that looks uniform
        love.graphics.printf("Instructions:", 10, 65, VIRTUAL_WIDTH, 'left')
        love.graphics.printf("Keyboard inputs:", 10, 125, VIRTUAL_WIDTH, 'left')

        love.graphics.setColor(16/255, 58/255, 171/255, 1)
        love.graphics.printf("1. Press the up arrow to move the car along.", 10, 80, VIRTUAL_WIDTH, 'left')
        love.graphics.printf("2. When presented with a scenario that requires action, follow", 10, 95, VIRTUAL_WIDTH, 'left')
        love.graphics.printf("directions on the screen.", 10, 110, VIRTUAL_WIDTH, 'left')
        
        love.graphics.printf("'C' to shoulder check. 'B' to check rearview mirror. 'S' to signal.", 10, 140, VIRTUAL_WIDTH, 'left')
        love.graphics.printf("'T' to stop. 'R' to turn right. 'L' to turn left", 10, 155, VIRTUAL_WIDTH, 'left')
        love.graphics.printf("'A' to look left. 'D' to look right. Use right and left arrow", 10, 170, VIRTUAL_WIDTH, 'left')
        love.graphics.printf("keys to change lanes, and the down arrow to slow the vehicle.", 10, 185, VIRTUAL_WIDTH, 'left')
        love.graphics.printf("drive to the end of the screen to complete the level.", 10, 200, VIRTUAL_WIDTH, 'left')
        love.graphics.printf("Press 'esc' to exit, and have fun!", 10, 215, VIRTUAL_WIDTH, 'left')
        love.graphics.setColor(1, 1, 1, 1)
    end

    push:apply('end')
end

function displayFPS()
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.setFont(fpsfont)
    love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 10, 10)
    -- needs to be a string to add, .. is a concatonator
    love.graphics.setColor(1, 1, 1, 1)
end

function displaySpeed()
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.setFont(fpsfont)
    love.graphics.print("SPEED: " .. speed, VIRTUAL_WIDTH - 50, 10)
    -- needs to be a string to add, .. is a concatonator
    love.graphics.setColor(1, 1, 1, 1)
end

function movee()
    if startmove == 0 then
        moveEnable = 1
        startmove = 1
    end
end

function lanechanges()
    if totalchanges == 0 then
        costume = 4
    end
    if totalchanges == 1 then
        costume = 1
    end
end

function lanechangesr()
    if totalchanges2 == 0 then
        costume = 5
    end
    if totalchanges2 == 1 then
        costume = 1
    end
end

function shiftt()
    if levelGen == 6 and lookrightEnable == 0 then
        map:shifttt()
    end
end

function changelightt()
    if levelGen == 7 and lookleftEnable == 0 then
        changelight = 1
    end
end


-- he has an incrementing variable but we have to change gamestate and such, variables in load.
-- we also have to move proc gen up with the screen ;/
-- add in free space for after each
-- change meaning in a game state??? like R AND L buttons
-- can u do proc gen of smth moving on its own? if not just put a sign on top that says dont stop
-- I skipped Pong 4- ball moving alone
-- all movement must be multiplied by dt i think
-- use the mario block switch to change the traffic light
-- skipped all ball stuff
-- skipped pong 8- scores + score (9)
-- I did not cap my up movement- mario2
-- actual ambulance goes by
