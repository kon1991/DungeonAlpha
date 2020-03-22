extends "res://Scenes/Buttons/ActionButton.gd"

var itemName = "Tick"

func _on_pressed():
	main.disable_buttons(main.itemContainer)
	player.set_array_text(["The tick bravely jumps into the fray!", "It starts sucking, bravely!", "The tick dies, doing what it loved", "..sucking strangers"])
	enemy.set_hp(-2)
	player.set_hp(2)
	yield(textBox, "end_player_text")
	main._on_BackButton_pressed()
	main.change_inventory(itemName)
	emit_signal("end_turn")
