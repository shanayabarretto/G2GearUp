-- first line takes class library and generates a paddle object that has methods and feilds
Car = Class{}

-- this function actually creates the object/assigns feilds/etc
function Car:init(x, y, width, height)
    -- colon allows objects to call methods, not unlike dots, but now we need an obj
    -- self keywords are important, refers to itself, belongs to itsself
    -- multiple paddles example
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    -- internally stored variables

    -- helps with movement, we change things in update using this value
    self.dy = 120
end

function Car:reset(x, y)
    self.x = x
    self.y = y
end

-- objects also need to be updated
-- since we feed in dt here, we must also feed it when calling the function from main
function Car:update(dt)
    if levelGen == 9 and ready4amb == 1 then

        if self.y < -65 then
            self.y = -70
            m2Enable = 1
        else 
            self.y = self.y - self.dy * dt
        end
        --if self.dy < 0 then --means its going to the top
        --self.y = math.max(120, self.y + self.dy * dt) -- remember that going up is negative + to scale by dt
        -- math.max caps it, 120 brings it to middle ish where we want things to happen
    end
end
 
function Car:render()  --  acts as a draw, still functions the same way as main
    if levelGen == 9 then
        love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    end
    -- allowed to printf here! 
    -- this one line of code functions for all "paddles" from init method
end

-- checking for collisions
--function Car:collides(box)
    -- check for space on the right, left, above, below
  --  if self.x > box.x + box.width or self.x + self.width < box.x or self.y > box.y + box.height or self.y + self.height < box.y then
    --    return false
    --end

    --return true
--end
