-- controls the car i suppose, do you think we can cut it differently???
Player = Class{}


function Player:init(map)
    -- these are dimensions for the straight one tho so uhhh
    self.width = 64
    self.height = 64

    if levelGen == 4 then
        self.x = map.tileWidth * 6
    elseif levelGen == 5 or levelGen == 6 then
        self.x = map.tileWidth * 8 
    else
        self.x = map.tileWidth * 7 
    end

    self.y = map.tileHeight * 7 - 16

    -- gives it the data to work with
    self.texture = love.graphics.newImage('graphics/carswsignal.png')
    -- actual chopping
    self.frames = generateQuads(self.texture, 64, 64)
    -- array of frames

end

function Player:reset()
    if levelGen == 4 then
        self.x = map.tileWidth * 6
    elseif levelGen == 5 or levelGen == 6 then
        self.x = map.tileWidth * 8 
    else
        self.x = map.tileWidth * 7 
    end

    self.y = map.tileHeight * 7 - 16
    -- gonna need to account for the two specials
end

function Player:shiftttt()
    self.y = map.tileHeight * 5 - 9
end

function Player:update(dt)

    if levelGen == 1 or levelGen == 2 or levelGen == 6 or levelGen == 7 or levelGen == 8 then
        stopheight = map.tileHeight * 5 + 1
    elseif levelGen == 5 then
        stopheight = map.tileHeight * 5 - 9
    elseif levelGen == 3 or levelGen == 10 or levelGen == 9 then
        stopheight = map.tileHeight * 6 - 10 -- idk how effective this is 
    elseif levelGen == 4 then
        stopheight = map.tileHeight * 4 - 15
    end
    
    if self.y < stopheight then -- make this applicable to certain levels only, and it
        if levelGen == 1 or levelGen == 2 or levelGen == 4 or levelGen == 5 or levelGen == 6 or levelGen == 7 or levelGen == 8 or levelGen == 10 then
            if drive2Enable == 1 then
                moveEnable = 1                               
            else 
                moveEnable = 0
            end

        elseif levelGen == 3 then -- may be able to keep it with the other?

            if leftlaneEnable == 1 and self.x > map.tileWidth * 6 then
                goleftEnable = 1
            elseif leftlaneEnable == 1 and self.x < map.tileWidth * 6 then
                goleftEnable = 0
                leftlaneCheck = 1
            end

            if drive2Enable == 1 then
                moveEnable = 1                               
            else 
                moveEnable = 0
            end

        elseif levelGen == 9 then

            if leftlaneEnable == 1 and self.x > map.tileWidth * 7 then
                goleftEnable = 1
            elseif leftlaneEnable == 1 and self.x < map.tileWidth * 7 then
                goleftEnable = 0
                leftlaneCheck = 1
            end

            if rightlaneEnable == 1 and self.x < map.tileWidth * 8 then
                gorightEnable = 1
            elseif rightlaneEnable == 1 and self.x > map.tileWidth * 8 then
                gorightEnable = 0
                rightlaneCheck = 1
            end

            if drive2Enable == 1 then
                moveEnable = 1                               
            else 
                moveEnable = 0
            end

        end
    end

    if (self.y < 10) or (self.x < 42) or (self.x > (32 * 15 - 70)) then
        gameState = 'done'
    end

    if love.keyboard.isDown('left') then
        if goleftEnable == 1 then -- could do math.max but?
            self.x = self.x - speed * dt
            self.y = self.y - speed * dt
        end
    end

    if love.keyboard.isDown('right') then
        if gorightEnable == 1 then -- could do math.max but?
            self.x = self.x + speed * dt
            self.y = self.y - speed * dt
        end
    end

    if love.keyboard.isDown('up') then
        if moveEnable == 1 then
        -- change for right and left
        -- will need to add lane changes and ability checks here too
            if leftturnCheck == 1 then
                self.x = math.max(29, self.x - speed * dt)
            elseif rightturnCheck == 1 then
                self.x = math.min(32*15 - 64, self.x + speed * dt)
            else
                self.y = math.max(self.y - speed * dt, -5)
            end
        end
    end

    -- done state aaaaaaaaaaaaaaa

    -- ig we gotta cap it at any side of it touching the ends- that can be our end 
    -- this works for all but red light and ambulance- these i could change
    -- into green light and lane change left tho if i figure out how to animate the rectangle
    -- white with blue and red dot?
end

function Player:render()
    if leftturnCheck == 1 then
        love.graphics.draw(self.texture, self.frames[2], self.x - 32, self.y)
    elseif rightturnCheck == 1 then
        love.graphics.draw(self.texture, self.frames[3], self.x, self.y - 29)
    else
        love.graphics.draw(self.texture, self.frames[costume], self.x, self.y)
    end
end