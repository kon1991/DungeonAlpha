extends "res://Scenes/Buttons/ActionButton.gd"

func _ready():
	pass # Replace with function body.

func _on_pressed():
	player.set_hp(4)
#	player.player_turn = false
	player.set_text("You heal yourself")
	yield(textBox, "end_player_text")
	emit_signal("end_turn")
