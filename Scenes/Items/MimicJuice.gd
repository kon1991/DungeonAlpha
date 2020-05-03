extends "res://Scenes/Items/ItemButton.gd"

func _ready():
	itemName = "Mimic_Juice"
	
func _on_pressed():

	player.set_array_text(["You drink the Mimic Juice", "It tastes like it hasn't been implemented yet! -_/(' ')\\_-"])
	player.set_hp(10)
	player.set_mp(10)
	main.disable_buttons(main.itemContainer)
	yield(textBox, "end_player_text")
	on_Item_used()