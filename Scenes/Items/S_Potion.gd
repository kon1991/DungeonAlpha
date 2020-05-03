extends "res://Scenes/Buttons/ActionButton.gd"

var itemName = "S_Potion"

func _ready():
#	itemName = "S_potion"
	pass # Replace with function body.

func _on_pressed():
	#._on_pressed(main.itemContainer)
	main.disable_buttons(main.itemContainer)
	player.set_hp(8)
	player.set_text("You drink the potion")
	yield(textBox, "end_player_text")
#	on_Item_used()
	main._on_BackButton_pressed()
	main.change_inventory(itemName)
	main.change_inventory("Bottle", false)
	emit_signal("end_turn")
