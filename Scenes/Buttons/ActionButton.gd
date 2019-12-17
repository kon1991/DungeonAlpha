extends Button

onready var main = get_tree().current_scene
onready var textBox = main.find_node("TextBox")
onready var player = main.find_node("PlayerStats")
onready var enemy

signal end_turn

func _ready():
	connect("end_turn", main, "_on_PlayerStats_end_turn")
	set_process(true)
	pass # Replace with function body.

func _process(delta):
	if(player.player_turn == false):
		set_disabled(true)
	elif(player.player_turn == true && player.noButtonsPressed == true):
		set_disabled(false)

func _on_pressed():
	main.disable_buttons()
	pass # Replace with function body.

func set_enemy(newEnemy):
	enemy = newEnemy