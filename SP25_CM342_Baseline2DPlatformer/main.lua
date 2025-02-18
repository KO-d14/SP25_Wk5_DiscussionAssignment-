-- SP25, WK 6 Assignment 

--[[
    
INSTRUCTIONS FOR CODE PART: 
----------------------------

A. Build the Baseline 2D Platformer. 
https://love2d.org/wiki/Tutorial:Baseline_2D_Platformer

After you have finished the build. Customize the player to a character of your choice.

Character Image Credit: 
Wingedmichael. Pigeon Pixel. DeviantArt, 21 July 2020, https://www.deviantart.com/wingedmichael/art/Pigeon-Pixel-830957246.
 --]]

--  ---------------- PART 1: CREATE A PLATFORM --------------
 platform = {}
--  ---------------- PART 2: CREATE THE PLAYER --------------
 player = {} 

 function love.load()
   --  ---------------- PART 1: CREATE A PLATFORM --------------
    -- Height and width of the plaform 
    platform.width = love.graphics.getWidth()    -- This makes the platform as wide as the whole game window.
    platform.height = love.graphics.getHeight()  -- This makes the platform as tall as the whole game window.
        
    -- Coordinates of the platform rendered  
    platform.x = 0                               -- This starts drawing the platform at the left edge of the game window.
    platform.y = platform.height / 2             -- This puts the platform in the middle of the game window.

    --  ---------------- PART 2: CREATE THE PLAYER --------------
    -- Coordinates of the player rendered
    player.x = love.graphics.getWidth() / 2      -- This puts the player in the middle of the game window horizontally/width 
    player.y = love.graphics.getHeight() / 2     -- This puts the player in the middle of the game window vertically/height

    -- calls the image file of the player; assigned to the player variable
    player.img =  love.graphics.newImage('pigeon.png')

    --  ---------------- PART 3: CREATING PLAYER'S MOVEMENT --------------
    -- Set the player's speed; adjust value to increase or decrease speed
    player.speed = 200 

    --  ---------------- PART 4: ADDING A JUMP  ---------------
    player.ground = player.y                     -- This makes the player land on the plaform.
    player.yVelocity = 0                         -- Whenever the player hasn't jumped yet, the Y-Axis velocity is always at 0. 

    player.jumpHeight = -300                     -- How high the player jumps
    player.gravity = -500                        -- How fast the player comes back down
 end 

 -- --------------------------------------------------------------

 function love.update(dt)
    --  ---------------- PART 3: CREATING PLAYER'S MOVEMENT --------------
    -- Assign keyboard inputs 
    if love.keyboard.isDown('d') then                                        -- If the 'd' key is being pressed...
        -- Creates boundary for window's right edge 

        --[[ 
      LEARNED:
        The colon automatically passes the player.img as the first argument (i.e., self) to the getWidth method.
        --]]

        if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
             player.x = player.x + (player.speed * dt)                      -- ... then move the player to the right.
        end 
    elseif love.keyboard.isDown('a') then                                   -- If the 'a' key is being pressed...
        -- Creates boundary for window's left edge
        if player.x > 0 then 
            player.x = player.x - (player.speed * dt)                       -- ... then move the player to the left.
        end
    end 

   --  ---------------- PART 4: ADDING A JUMP  --------------
   if love.keyboard.isDown ('space') then                                   -- If the 'spacebar' is pressed... 
      -- Game checks if player is on the ground. NOTE: when player is on ground, Y-Axis velocity = 0 
      if player.yVelocity == 0 then 
         player.yVelocity = player.jumpHeight                               -- ... then the player jumps.
      end 
   end 

   -- Adds physics to the jump
   if player.yVelocity ~= 0 then                                            -- If the player is in the air/jumps...
      player.y = player.y + player.yVelocity * dt                           -- ... then the player's jumps.
      player.yVelocity = player.yVelocity - player.gravity * dt             -- Gravity pulls the player back down.
   end 
   -- Collision detection; makes sure character lands on ground 
   if player.y >  player.ground then                                        -- Checks if player jumped...
      player.yVelocity = 0                                                  -- Y-Axis velocity is set back to 0 <-- means character is on ground again 
      player.y = player.ground                                              -- Y-Axis velocity is set back to 0 <-- means character is on ground again  (?)
   end 
end 


 -- --------------------------------------------------------------

 function love.draw()
    --  ---------------- PART 1: CREATE A PLATFORM --------------
    love.graphics.setColor(1, 1, 1)             -- This sets the platform color to white.

    -- This draws the platform <-- white rectangle with designated coordination, width, and height
    love.graphics.rectangle('fill', platform.x, platform.y, platform.width, platform.height)

    --  ---------------- PART 2: CREATE THE PLAYER --------------
    -- This draws the player <-- image with designated coordination, width, and height
    love.graphics.draw(player.img, player.x, player.y, 0, 1, 1, 0, 32)
 end 


