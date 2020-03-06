extends "res://Scenes/Buttons/ActionButton.gd"

var itemName = "Magic_Dust"
func _ready():
	pass # Replace with function body.

func _on_pressed():
	#._on_pressed(main.itemContainer)
	main.disable_buttons(main.itemContainer)
	player.set_array_text(["You sprinkle the magic dust", "You feel protected"])
	player.clear_status()
	yield(textBox, "end_player_text")
	main._on_BackButton_pressed()
	main.change_inventory(itemName)
	emit_signal("end_turn")

