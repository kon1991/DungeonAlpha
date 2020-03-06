extends Button

onready var main = get_tree().current_scene
onready var textBox = main.find_node("TextBox")
onready var player = main.find_node("PlayerStats")
onready var enemy
onready var timer = $TooltipTimer
onready var Tooltip = load("res://Scenes/ToolTip.tscn")
onready var tooltip

signal end_turn

func _ready():
	connect("end_turn", main, "_on_PlayerStats_end_turn")
	set_process(true)
	tooltip = Tooltip.instance()
	main.add_child(tooltip)
	tooltip.visible = false
	pass # Replace with function body.

func _process(delta):
	if(player.player_turn == false):
		set_disabled(true)
	elif(player.player_turn == true && player.noButtonsPressed == true):
		set_disabled(false)

func _on_pressed():
	#add parameter for which menu to disable
#	main.disable_buttons()
	_on_mouse_exited()
	pass # Replace with function body.

func set_enemy(newEnemy):
	enemy = newEnemy

func _on_mouse_entered():
	timer.start()
	pass


func _on_TooltipTimer_timeout():
#	modulate = Color(1,1,1, 0)
#	var mouse_pos = get_viewport().get_mouse_position()
#	var view_size = get_viewport().get_size()
#	var tooltip_size = tooltip.rect_size
#	var diff = (160 - (mouse_pos.x + tooltip_size.x))
##	print("MOUSE :" + str(mouse_pos.x))
##	print("VIEW :" + str(view_size.x))
##	print("TTSIZE :" + str(tooltip_size.x))
#	print("DIFFF : " + str(diff))
#	if(diff<0):
#		mouse_pos.x += diff
#	tooltip.rect_global_position = mouse_pos
#
#	tooltip.visible = true
	pass


func _on_mouse_exited():
	timer.stop()
	tooltip.visible = false
	pass # Replace with function body.
