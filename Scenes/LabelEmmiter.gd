extends Node

onready var main = get_tree().current_scene
onready var playerPos = main.find_node("PlayerPosition")
onready var enemyPos = main.find_node("EnemyPosition")
onready var DeltaLabel = load("res://Scenes/DeltaLabel.tscn")

var green = '00c135'
var red = '9c0b0b'
var color = '000000'

func create_label(origin, type, hp):
	randomize()
	var newLabel = DeltaLabel.instance()
	if(type=="heal"):
		color = green
	elif(type=="hurt"):
		color = red
	newLabel.set("custom_colors/font_color", color) 
	newLabel.text = str(abs(hp))
	if(origin == "player"):
		newLabel.rect_position = playerPos.position + Vector2(randi()%10 - 20, 0)
	elif(origin == "enemy"):
		newLabel.rect_position = enemyPos.position + Vector2(randi()%10 - 20, 0)
	main.add_child(newLabel)
	color = '000000'
