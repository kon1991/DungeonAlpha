extends "res://Scenes/Items/ItemButton.gd"

func _ready():
	itemName = "Poop_Bottle"
	
func _on_pressed():
	main.disable_buttons(main.itemContainer)
	player.set_hp(-8)
	player.set_array_text(["You drink the poo", "WHY"])
	yield(textBox, "end_player_text")
#	on_Item_used()
#	main._on_BackButton_pressed()
#	main.change_inventory(itemName)
#	main.change_inventory("Bottle", false)
#	emit_signal("end_turn")
	on_Item_used()
	main.change_inventory("Bottle", false)