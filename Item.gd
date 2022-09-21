class Item:
	const rarities = {
		debris = "Debris",
		common = "Common",
		uncommon = "Uncommon",
		rare = "Rare",
		epic = "Epic",
		legendary = "Legendary",
		mythical = "Mythical"
	}

	const itemTypes = {
		Armor = "Armor",
		Consumable = "Consumable",
		Weapon = "Weapon"
	}

	const damageTypes = {
		Blunt = "Blunt",
		Slashing = "Slashing",
		Piercing = "Piercing",
		Energy = "Energy"
	}

	var itemRarity
	var itemType
	var damageType
	var damageResist
	var damageValue : float
	var damageDuration : float
	var damageReduction : float
	var itemDurability : float
	var itemName : String
	var itemDescription : String

	func RandomItem():
		self.itemRarity = rarities[ abs( rand_range(0, 6) )]
		self.itemType = itemTypes[ abs( rand_range(0, 2) )]
		self.damageType = damageTypes[ abs( rand_range(0, 3) )]
		self.damageResist = damageTypes[ abs( rand_range(0, 3) )]
		self.damageValue = rand_range(0, 100)
		self.damageDuration = rand_range(0, 100)
		self.damageReduction = rand_range(0, 100)
		self.itemDurability = rand_range(0, 100)
		self.name = self.itemRarity + " " + self.itemType + " of " + self.damageType
		self.itemDescription = self.name

	func _init():
		itemRarity = rarities.common
		itemType = itemTypes.Armor
		damageType = damageTypes.Energy
		damageResist = damageTypes.Energy
		damageValue  = 1.0
		damageDuration = 1.0
		damageReduction = 1.0
		itemDurability = 1.0
		itemName = "proBar"
		itemDescription = "gives you an energy boost"
