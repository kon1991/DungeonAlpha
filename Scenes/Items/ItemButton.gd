extends "res://Scenes/Buttons/ActionButton.gd"

var itemName ="item"

func on_Item_used():
	print(itemName)
	main._on_BackButton_pressed()
	main.change_inventory(itemName)
	emit_signal("end_turn")