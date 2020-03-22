extends "res://Scenes/Buttons/ActionButton.gd"

var itemName = "Acid_Vial"

func _on_pressed():
	#._on_pressed(main.itemContainer)
	main.disable_buttons(main.itemContainer)
	player.set_array_text(["You throw the vial of Blobby", "The caustic slime burns the "+ enemy.mname+"!"])
	enemy.set_hp(-7, "acid")
	yield(textBox, "end_player_text")
	main._on_BackButton_pressed()
	main.change_inventory(itemName)
	emit_signal("end_turn")
