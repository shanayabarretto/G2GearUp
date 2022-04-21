-- this is a utility file, used for chopping up the spritesheet
-- Can call util from anywhere when you require it
-- using quads

-- takes an atlas- spritesheet. 
function generateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth -- I suppose this finds width as tile #- yes
    local sheetHeight = atlas:getHeight() / tileheight 
    -- cannot access these in main etc bc local. global takes away space

    local sheetCounter = 1 -- this should give numbers to our tiles, starts at 1 (normally, unlike c)
    local quads = {} -- table that stores quad. our tiles! this is like an array/python list

    for y = 0, sheetHeight - 1 do -- this goes through top to bottom. 0-3. specify quad in pixels- bc they start at 0.
        for x = 0, sheetWidth - 1 do -- double nested so we can cut all
            -- x, y, width, height, sw, sh, 0 based. finding where it began with pixel coordinates
            quads[sheetCounter] = love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth, tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return quads
end

-- maybe i should test for that 7:3 ratio i have