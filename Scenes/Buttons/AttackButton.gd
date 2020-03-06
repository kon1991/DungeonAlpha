extends "res://Scenes/Buttons/ActionButton.gd"


func _ready():
	
	pass # Replace with function body.

func _on_pressed():
	._on_pressed()
	main.disable_buttons()
#	player.set_text("You clobber the "+enemy.mname)
#	enemy.set_hp(-(player.damage + player.damage_mod))
	player.attack()
	yield(textBox, "end_player_text")
	emit_signal("end_turn")
	