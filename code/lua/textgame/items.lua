-- Define the Item class
Item = {}
Item.__index = Item

--- Creates a new Item instance
-- @param name string The name of the item
-- @param effect function The effect function of the item
-- @return Item The new Item instance
function Item:new(name, effect)
    local item = {
        name = name,
        effect = effect
    }
    setmetatable(item, Item)
    return item
end

--- Uses the item on a player
-- @param player table The player on whom the item is used
function Item:use(player)
    self.effect(player)
end

-- Define specific items
HealthPotion = setmetatable({}, {__index = Item})
AttackBoost = setmetatable({}, {__index = Item})
DefenseBoost = setmetatable({}, {__index = Item})

--- Creates a new HealthPotion instance
-- @return HealthPotion The new HealthPotion instance
function HealthPotion:new()
    return Item.new(self, "Health Potion", function(player)
        player.health = player.health + 20
        print("You used a Health Potion. Your health is now " .. player.health .. ".")
    end)
end

--- Creates a new AttackBoost instance
-- @return AttackBoost The new AttackBoost instance
function AttackBoost:new()
    return Item.new(self, "Attack Boost", function(player)
        player.attack = player.attack + 5
        print("You used an Attack Boost. Your attack is now " .. player.attack .. ".")
    end)
end

--- Creates a new DefenseBoost instance
-- @return DefenseBoost The new DefenseBoost instance
function DefenseBoost:new()
    return Item.new(self, "Defense Boost", function(player)
        player.defense = player.defense + 5
        print("You used a Defense Boost. Your defense is now " .. player.defense .. ".")
    end)
end

--- Module return table
-- @return table A table containing the HealthPotion, AttackBoost, and DefenseBoost classes
return {
    HealthPotion = HealthPotion,
    AttackBoost = AttackBoost,
    DefenseBoost = DefenseBoost
}