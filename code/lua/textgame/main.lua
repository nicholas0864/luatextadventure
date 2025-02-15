-- Import the class from class.lua
local Class = require("class")
-- Import the items from items.lua
local items = require("items")
local HealthPotion = items.HealthPotion
local AttackBoost = items.AttackBoost
local DefenseBoost = items.DefenseBoost
-- Seed the random number generator with the current time to ensure different random results each run
math.randomseed(os.time())

--- Displays the introduction
local function introduction()
    print("Welcome to the Adventure Game!")
    print("Which class would you like to play as?")
end

--- Handles combat between the player and an enemy
-- @param player table The player character
-- @param enemy table The enemy character
local function combat(player, enemy)
    print("Combat starts!")
    while player.health > 0 and enemy.health > 0 do
        print("Your turn! Choose an action: attack, defend, run, or use item")
        local action = io.read()
        if action == "attack" then
            local damage = math.max(0, player.attack - enemy.defense)
            enemy.health = enemy.health - damage
            print("You deal " .. damage .. " damage to the " .. enemy.name .. ".")
        elseif action == "defend" then
            print("You defend against the next attack.")
            player.defense = player.defense + 5
        elseif action == "run" then
            print("You run away from the battle.")
            return
        elseif action == "use item" then
            if player.inventory and #player.inventory > 0 then
                print("Choose an item to use:")
                for i, item in ipairs(player.inventory) do
                    print(i .. ". " .. item.name)
                end
                local itemChoice = tonumber(io.read())
                if itemChoice and player.inventory[itemChoice] then
                    player.inventory[itemChoice]:use(player)
                    table.remove(player.inventory, itemChoice)
                else
                    print("Invalid choice. Try again.")
                end
            else
                print("You have no items to use.")
            end
        else
            print("Invalid action. Try again.")
        end

        if enemy.health > 0 then
            local damage = math.max(0, enemy.attack - player.defense)
            player.health = player.health - damage
            print("The " .. enemy.name .. " deals " .. damage .. " damage to you.")
        end
    end

    if player.health > 0 then
        print("You defeated the " .. enemy.name .. "!")
    else
        print("You were defeated by the " .. enemy.name .. ".")
    end
end

--- Handles random encounters
-- @param player table The player character
local function randomEncounter(player)
    -- Generate a random number between 1 and 3
    local encounter = math.random(1, 3)
    
    -- Handle the encounter based on the random number
    if encounter == 1 then
        print("You encounter a wild animal.")
        combat(player, {name = "Wild Animal", health = 50, attack = 10, defense = 5})
    elseif encounter == 2 then
        print("You find a peaceful village.")
        print("Do you want to explore the village or continue walking?")
        local choice = io.read()
        if choice == "explore" then
            print("You explore the village and make new friends.")
            print("They offer you food and shelter for the night.")
        elseif choice == "continue" then
            print("You continue walking and find a beautiful lake.")
            print("You rest by the lake and enjoy the serene view.")
        else
            print("Invalid choice. You get lost in the forest.")
        end
    elseif encounter == 3 then
        print("You find an old, mysterious cave.")
        print("Do you want to enter the cave or walk away?")
        local choice = io.read()
        if choice == "enter" then
            print("You enter the cave and find ancient artifacts.")
            print("You take some artifacts and leave the cave safely.")
            player.inventory = player.inventory or {}
            table.insert(player.inventory, HealthPotion:new())
            print("You found a Health Potion!")
        elseif choice == "walk away" then
            print("You walk away from the cave and continue your journey.")
        else
            print("Invalid choice. You get lost in the forest.")
        end
    end
end

--- Allows the player to choose a class
-- @return table The player character with the chosen class
local function chooseClass()
    local classes = {"Warrior", "Mage", "Rogue"}
    for i, class in ipairs(classes) do
        print(i .. ". " .. class)
    end
    local choice = tonumber(io.read())
    if choice and classes[choice] then
        print("You have chosen to play as a " .. classes[choice] .. ".")
        if classes[choice] == "Warrior" then
            return Warrior:new("Player")
        elseif classes[choice] == "Mage" then
            return Mage:new("Player")
        elseif classes[choice] == "Rogue" then
            return Rogue:new("Player")
        end
    else
        print("Invalid choice. Please choose a valid class.")
        return chooseClass()
    end
end

--- Handles the left path
-- @param player table The player character
local function leftPath(player)
    print("You chose to go left.")
    -- Call the random encounter function to determine what happens on the left path
    randomEncounter(player)
end

--- Handles the right path
-- @param player table The player character
local function rightPath(player)
    print("You chose to go right.")
    -- Call the random encounter function to determine what happens on the right path
    randomEncounter(player)
end

--- Main function to start the game
local function startGame()
    -- Display the introduction
    introduction()
    -- Let the player choose a class
    local player = chooseClass()
    -- Start the adventure
    while player.health > 0 do
        print("Choose a path: left or right")
        local path = io.read()
        if path == "left" then
            leftPath(player)
        elseif path == "right" then
            rightPath(player)
        else
            print("Invalid choice. Try again.")
        end
    end
    print("Game over!")
end

-- Start the game by calling the startGame function
startGame()