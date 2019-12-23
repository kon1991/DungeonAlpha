extends Node

onready var main = get_tree().current_scene
onready var status = main.find_node("StatusContainer")
onready var textBox = main.find_node("TextBox")
onready var statPanel = main.find_node("PlayerStatPanel")
onready var hpLabel = statPanel.find_node("HPLabel")
onready var enemy #= main.find_node("EnemyStats") #find enemy on instance
onready var actions = ["AttackButton", "HealActionButton"]
onready var StatusRect = load("res://Scenes/StatusRect.tscn")


var hp = 10 setget set_hp
var max_hp = 10 
var player_turn = false setget set_player_turn
var new_conditions = []
var noButtonsPressed = true
export var damage = 5
var damage_mod = 0


func _ready():
	
	pass # Replace with function body.

#
func set_hp(new_hp):
	hp = hp + new_hp
	if (hp >= max_hp):
		hp = max_hp
	elif (hp <= 0):
		hp = 0
	hpLabel.text = str(hp) + "/"  + str(max_hp) + "HP"

func set_player_turn(turn):
	print("Player_turn: " + str(turn))
	player_turn = turn
	
func set_enemy(newEnemy):
	enemy = newEnemy
	
func set_text(text):
	textBox.set_text_with_origin(text, "player")
#	yield(textBox, "end_player_text")
	print("player : end text")
	
func check_new_conditions():
	var has_conditions = false
	for condition in new_conditions:
		has_conditions = true
		create_new_status(condition[0], condition[1], condition[2])
#		if(condition=="poison"):
#			set_hp(-2)
#			set_text("Poison courses through you!")
#		if(condition=="fear"):
#			damage -= 1
#			set_text("You tremble fearfully")
	new_conditions = []
	return has_conditions
	
func create_new_status(condition, dur, mod):
	var statusRect = StatusRect.instance()
	statusRect.init(condition, dur, mod)
	status.add_child(statusRect)
	
func apply_statuses():
	var statusList = status.get_children()
	for status in statusList:
		apply_status(status)
		
func apply_status(status):
	var type = status.type
	var mod = status.modifier
	var dur = status.duration
	match type:
			"poison":
				set_text("Poison courses through your veins!")
				set_hp(-status.modifier)
				status.set_duration(-1)
			"fear":
				set_text("Your knees tremble with dread!")
				if(!status.applied):
					damage_mod = damage_mod - 1
					status.applied = true
				status.set_duration(-1)
				if(status.duration<=0):
					damage_mod = damage_mod + 1