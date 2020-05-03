extends "res://Scenes/Items/ItemButton.gd"

func _ready():
	itemName = "Poop"
	
func _on_pressed():

	player.set_array_text("You throw poo on the " + enemy.mname, enemy.mname + " stinks!")
	main.disable_buttons(main.itemContainer)
	enemy.add_tag("Poopy")
	yield(textBox, "end_player_text")
	on_Item_used()