extends VBoxContainer

@onready var warrior_image = $WarriorSelected
@onready var ability_name = $AbilityContainer/AbilityName
@onready var time_cost = $AbilityContainer/TimeCost

func set_warrior(warrior_data: Dictionary):
	# Example: { "name": "Knight", "icon": "res://assets/knight.png", "ability": "Time Slash", "cost": 2.5 }
	warrior_image.texture = load(warrior_data["icon"])
	ability_name.text = "Ability: " + warrior_data["ability"]
	time_cost.text = "Time Cost: " + str(warrior_data["cost"]) + " sec"
