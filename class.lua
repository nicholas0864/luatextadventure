-- Define the Character class
Character = {}
Character.__index = Character

--- Creates a new Character instance
-- @param name string The name of the character
-- @param class string The class of the character
-- @param health number The health of the character
-- @param attack number The attack value of the character
-- @param defense number The defense value of the character
-- @return Character The new Character instance
function Character:new(name, class, health, attack, defense)
    local character = {
        name = name,
        class = class,
        health = health,
        attack = attack,
        defense = defense
    }
    setmetatable(character, Character)
    return character
end

--- Displays the character's stats
function Character:displayStats()
    print("Name: " .. self.name)
    print("Class: " .. self.class)
    print("Health: " .. self.health)
    print("Attack: " .. self.attack)
    print("Defense: " .. self.defense)
end

-- Define subclasses for different character types
Warrior = setmetatable({}, {__index = Character})
Mage = setmetatable({}, {__index = Character})
Rogue = setmetatable({}, {__index = Character})

--- Creates a new Warrior instance
-- @param name string The name of the warrior
-- @return Warrior The new Warrior instance
function Warrior:new(name)
    return Character.new(self, name, "Warrior", 100, 15, 10)
end

--- Creates a new Mage instance
-- @param name string The name of the mage
-- @return Mage The new Mage instance
function Mage:new(name)
    return Character.new(self, name, "Mage", 70, 20, 5)
end

--- Creates a new Rogue instance
-- @param name string The name of the rogue
-- @return Rogue The new Rogue instance
function Rogue:new(name)
    return Character.new(self, name, "Rogue", 80, 10, 15)
end

--- Prints the available classes
function printAvailableClasses()
    local classes = {"Warrior[1]", "Mage[2]", "Rogue[3]"}
    print("Available classes:")
    for _, class in ipairs(classes) do
        print("- " .. class)
    end
end