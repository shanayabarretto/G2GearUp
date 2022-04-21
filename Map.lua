-- Map is a Class
Map = Class{}

-- giving names to quads
ALLWAY_TILE = 1
ROAD_TILE = 2
LEFTA_TILE = 3
EVENTROAD_TILE = 4
INTERS_TILE = 5
BLANKROAD_TILE = 6
AMBULANCE_TILE = 7
STOP_TILE = 8
GREENL_TILE = 9
REDL_TILE = 10
RIGHTINT_TILE = 11
SIDEINT_TILE = 12
TOPINT_TILE = 13
EMPTY_TILE = 14
BUSH_TILE = 15
POLE_TILE = 16
RIGHTA_TILE = 17
LEFTINT_TILE = 18
BLANK2_TILE = 19
TOPMID_TILE = 20
SPEEDSIGN_TILE = 21


local SCROLL_SPEED = 62

-- must figure out how to iterate row by row 

function Map:init()
    -- Spritesheet ot reference to map tiles to quads
    self.spritesheet = love.graphics.newImage('graphics/carspritessss.png') -- this makes a texture object, puts texture in memory
    -- this is just texture data, we have not chopped it yet
    -- to do that we must generate quads. my tiles are 32x32 pixels
    self.tileWidth = 32
    self.tileHeight = 32
    
    -- I know only 9 on screen at a time but ig i need to incr this???

    self.mapWidth = 15 -- guessed and tested
    self.mapHeight = 9
    -- whats acc being displayed to the map
    self.tiles = {}
    -- now this is the actual map. we iterate over this and draw textures with quads
    -- is it cause its a list???? i think so, itll start at 0?

    -- for autoscrolling, 'camera' feature
    self.camX = 0
    self.camY = 0

    self.tileSprites = generateQuads(self.spritesheet, self.tileWidth, self.tileHeight)
    -- returns quads, a list

    levelGen = math.random(10)

    -- gives player the map
    self.player = Player(self)

    -- now we have to populate map, iterates through
    -- how come hes starting at 1?
    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            self:setTile(x, y, EMPTY_TILE)
        end
    end

    -- 3 rows of road
    for x = 7, 9 do
        for y = 1, self.mapHeight do -- can add -1 to go bw
            self:setTile(x, y, BLANKROAD_TILE)
        end
    end

    -- ig i just code my scenarios seperately then
    for x = 8, 8 do
        for y = 1, self.mapHeight do -- can add -1 to go bw
            self:setTile(x, y, ROAD_TILE)
        end
    end
    -- I feel like the moving sprite is on a seperate sheet so like. lit.
    -- ok so i do need to seed math.random
    -- I guess I need a reset thing
    math.random(10) -- calling bc it acts weird
    --math.random(10) = math.random(10)


end

-- where did he get this tile method?
function Map:setTile(x, y, tile)
    -- stores 2d map rep in a 1d way
    -- whereever y is, minus the one index, 
    self.tiles[(y-1) * self.mapWidth + x] = tile
end

-- returns it if you need to find out what the tile is
function Map:getTile(x, y)
    return self.tiles[(y-1) * self.mapWidth + x]
end

function Map:shifttt()
    self.player:shiftttt()
end

function Map:reset()
    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            self:setTile(x, y, EMPTY_TILE)
        end
    end

    -- 3 rows of road
    for x = 7, 9 do
        for y = 1, self.mapHeight do -- can add -1 to go bw
            self:setTile(x, y, BLANKROAD_TILE)
        end
    end

    -- ig i just code my scenarios seperately then
    for x = 8, 8 do
        for y = 1, self.mapHeight do -- can add -1 to go bw
            self:setTile(x, y, ROAD_TILE)
        end
    end

    self.player:reset()
end

function Map:update(dt)
    -- I want to move upward so I used camY instead
    -- dont want artifacting so use floor- not a fraction
    -- I IGNORED HIS PIXELS VARIABLE!!

    -- I removed all of this bc im not dealing with camera movements
    --if love.keyboard.isDown('up') then -- im not sure if keypressed works tho > func
        --self.camY = self.camY + SCROLL_SPEED * dt
    --end

    if levelGen == 1 then -- stop sign

        for y = 4, 5 do
            for x = 1, self.mapWidth do
                self:setTile(x, y, BLANKROAD_TILE)
            end
        end

        self:setTile(10, 7, POLE_TILE)
        self:setTile(10, 6, STOP_TILE)
        self:setTile(8, 6, INTERS_TILE)
        self:setTile(7, 6, SIDEINT_TILE)
        self:setTile(9, 6, SIDEINT_TILE)
        self:setTile(8, 3, TOPMID_TILE)
        self:setTile(7, 3, TOPINT_TILE)
        self:setTile(9, 3, TOPINT_TILE)
        self:setTile(11, 8, BUSH_TILE)
        self:setTile(12, 7, BUSH_TILE)
        self:setTile(14, 8, BUSH_TILE)
        
    elseif levelGen == 2 then -- all way stop
        
        for y = 4, 5 do
            for x = 1, self.mapWidth do
                self:setTile(x, y, BLANKROAD_TILE)
            end
        end

        self:setTile(10, 7, POLE_TILE)
        self:setTile(10, 6, ALLWAY_TILE)
        self:setTile(8, 6, INTERS_TILE)
        self:setTile(7, 6, SIDEINT_TILE)
        self:setTile(9, 6, SIDEINT_TILE)
        self:setTile(8, 3, TOPMID_TILE)
        self:setTile(7, 3, TOPINT_TILE)
        self:setTile(9, 3, TOPINT_TILE)
        self:setTile(6, 4, LEFTINT_TILE)
        self:setTile(6, 5, LEFTINT_TILE)
        self:setTile(10, 4, RIGHTINT_TILE)
        self:setTile(10, 5, RIGHTINT_TILE)
        self:setTile(12, 7, BUSH_TILE)
        self:setTile(14, 8, BUSH_TILE)

    elseif levelGen == 3 then -- change lanes
        
        self:setTile(8, 7, EVENTROAD_TILE)
        self:setTile(7, 6, BLANK2_TILE)
        self:setTile(7, 5, BLANK2_TILE)
        self:setTile(14, 6, BUSH_TILE)
        self:setTile(12, 8, BUSH_TILE)
        self:setTile(11, 6, BUSH_TILE)
        self:setTile(12, 4, BUSH_TILE)
        self:setTile(2, 8, BUSH_TILE)
        self:setTile(4, 7, BUSH_TILE)
        self:setTile(5, 8, BUSH_TILE)

    elseif levelGen == 4 then -- turn left
        for y = 4, 5 do
            for x = 1, self.mapWidth do
                self:setTile(x, y, BLANKROAD_TILE)
            end
        end

        self:setTile(8, 6, INTERS_TILE)
        self:setTile(7, 6, SIDEINT_TILE)
        self:setTile(9, 6, SIDEINT_TILE)
        self:setTile(8, 3, TOPMID_TILE)
        self:setTile(7, 3, TOPINT_TILE)
        self:setTile(9, 3, TOPINT_TILE)
        self:setTile(6, 4, LEFTINT_TILE)
        self:setTile(6, 5, LEFTINT_TILE)
        self:setTile(10, 4, RIGHTINT_TILE)
        self:setTile(10, 5, RIGHTINT_TILE)
        self:setTile(12, 7, BUSH_TILE)
        self:setTile(14, 8, BUSH_TILE)
        self:setTile(10, 6, POLE_TILE)
        self:setTile(10, 5, LEFTA_TILE)
        self:setTile(6, 7, POLE_TILE)
        self:setTile(6, 6, GREENL_TILE)
            

    elseif levelGen == 5 then -- turn right
        
        for y = 4, 5 do
            for x = 1, self.mapWidth do
                self:setTile(x, y, BLANKROAD_TILE)
            end
        end

        self:setTile(8, 6, INTERS_TILE)
        self:setTile(7, 6, SIDEINT_TILE)
        self:setTile(9, 6, SIDEINT_TILE)
        self:setTile(8, 3, TOPMID_TILE)
        self:setTile(7, 3, TOPINT_TILE)
        self:setTile(9, 3, TOPINT_TILE)
        self:setTile(6, 4, LEFTINT_TILE)
        self:setTile(6, 5, LEFTINT_TILE)
        self:setTile(10, 4, RIGHTINT_TILE)
        self:setTile(10, 5, RIGHTINT_TILE)
        self:setTile(4, 7, BUSH_TILE)
        self:setTile(2, 8, BUSH_TILE)
        self:setTile(6, 6, POLE_TILE)
        self:setTile(6, 5, RIGHTA_TILE)
        self:setTile(10, 7, POLE_TILE)
        self:setTile(10, 6, GREENL_TILE)

    elseif levelGen == 6 then -- turn right on red light
        for y = 4, 5 do
            for x = 1, self.mapWidth do
                self:setTile(x, y, BLANKROAD_TILE)
            end
        end

        self:setTile(8, 6, INTERS_TILE)
        self:setTile(7, 6, SIDEINT_TILE)
        self:setTile(9, 6, SIDEINT_TILE)
        self:setTile(8, 3, TOPMID_TILE)
        self:setTile(7, 3, TOPINT_TILE)
        self:setTile(9, 3, TOPINT_TILE)
        self:setTile(6, 4, LEFTINT_TILE)
        self:setTile(6, 5, LEFTINT_TILE)
        self:setTile(10, 4, RIGHTINT_TILE)
        self:setTile(10, 5, RIGHTINT_TILE)
        self:setTile(4, 8, BUSH_TILE)
        self:setTile(2, 9, BUSH_TILE)
        self:setTile(6, 6, POLE_TILE)
        self:setTile(6, 5, RIGHTA_TILE)
        self:setTile(10, 7, POLE_TILE)
        self:setTile(10, 6, REDL_TILE)

    elseif levelGen == 7 then -- stop at red light

        for y = 4, 5 do
            for x = 1, self.mapWidth do
                self:setTile(x, y, BLANKROAD_TILE)
            end
        end

        self:setTile(8, 6, INTERS_TILE)
        self:setTile(7, 6, SIDEINT_TILE)
        self:setTile(9, 6, SIDEINT_TILE)
        self:setTile(8, 3, TOPMID_TILE)
        self:setTile(7, 3, TOPINT_TILE)
        self:setTile(9, 3, TOPINT_TILE)
        self:setTile(6, 4, LEFTINT_TILE)
        self:setTile(6, 5, LEFTINT_TILE)
        self:setTile(10, 4, RIGHTINT_TILE)
        self:setTile(10, 5, RIGHTINT_TILE)
        self:setTile(14, 7, BUSH_TILE)
        self:setTile(12, 8, BUSH_TILE)
        self:setTile(10, 7, POLE_TILE)

        if changelight == 0 then
            self:setTile(10, 6, REDL_TILE)
        else
            self:setTile(10, 6, GREENL_TILE)
        end
        
    elseif levelGen == 8 then -- green light

        for y = 4, 5 do
            for x = 1, self.mapWidth do
                self:setTile(x, y, BLANKROAD_TILE)
            end
        end

        self:setTile(8, 6, INTERS_TILE)
        self:setTile(7, 6, SIDEINT_TILE)
        self:setTile(9, 6, SIDEINT_TILE)
        self:setTile(8, 3, TOPMID_TILE)
        self:setTile(7, 3, TOPINT_TILE)
        self:setTile(9, 3, TOPINT_TILE)
        self:setTile(6, 4, LEFTINT_TILE)
        self:setTile(6, 5, LEFTINT_TILE)
        self:setTile(10, 4, RIGHTINT_TILE)
        self:setTile(10, 5, RIGHTINT_TILE)
        self:setTile(14, 7, BUSH_TILE)
        self:setTile(12, 8, BUSH_TILE)
        self:setTile(10, 7, POLE_TILE)
        self:setTile(10, 6, GREENL_TILE)

    elseif levelGen == 9 then --  ambulance approaching
        self:setTile(8, 7, EVENTROAD_TILE)
        self:setTile(9, 6, BLANK2_TILE)
        self:setTile(9, 5, BLANK2_TILE)
        self:setTile(11, 8, BUSH_TILE)
        self:setTile(14, 7, BUSH_TILE)
        self:setTile(12, 4, AMBULANCE_TILE)
        self:setTile(4, 4, AMBULANCE_TILE)
        -- change dx and dy with side buttons

    elseif levelGen == 10 then -- school zone

        self:setTile(8, 7, EVENTROAD_TILE)
        self:setTile(14, 6, BUSH_TILE)
        self:setTile(12, 8, BUSH_TILE)
        self:setTile(11, 4, BUSH_TILE)
        self:setTile(2, 8, BUSH_TILE)
        self:setTile(4, 7, BUSH_TILE)
        self:setTile(5, 8, BUSH_TILE)
        self:setTile(10, 6, SPEEDSIGN_TILE)
        self:setTile(10, 7, POLE_TILE)

    end

    -- updates player
    self.player:update(dt)
end

function Map:render()
    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do -- one for tables, 0 for pixels
            -- spritesheet + quad 
            love.graphics.draw(self.spritesheet, self.tileSprites[self:getTile(x, y)], 
            (x - 1) * self.tileWidth, (y-1) * self.tileHeight)
        end
    end 
    -- not sure why we are rendering it here
    self.player:render()
end
