extends "res://Scenes/Buttons/ActionButton.gd"

var itemName = "S_Potion"

func _ready():
	pass # Replace with function body.

func _on_pressed():
	#._on_pressed(main.itemContainer)
	main.disable_buttons(main.itemContainer)
	print("glug glug glug")
	player.set_hp(8)
	player.set_text("You drink the potion")
	yield(textBox, "end_player_text")
	main._on_BackButton_pressed()
	main.change_inventory(itemName)
	main.change_inventory("Bottle", false)
	emit_signal("end_turn")
