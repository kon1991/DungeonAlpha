extends Node

onready var main = get_tree().current_scene
onready var textBox = main.find_node("TextBox")
onready var statPanel = main.find_node("PlayerStatPanel")
onready var hpLabel = statPanel.find_node("HPLabel")
onready var enemy #= main.find_node("EnemyStats") #find enemy on instance
onready var actions = ["AttackButton", "HealActionButton"]


var hp = 10 setget set_hp
var max_hp = 10 
var ap = 1
var maxap = 1
var player_turn = false
export var damage = 5


func _ready():
	
	pass # Replace with function body.


#func _on_ActionButton_pressed():
#	if (player_turn):
#		player_turn = false
#		enemy.set_hp(-damage)
#		main.textBox.text = "You clobber the Tick"
#		if(enemy.hp>0):
#			emit_signal("end_turn")
#			print("end_turn")
#	pass # Replace with function body.
#
func set_hp(new_hp):
	hp = hp + new_hp
	if (hp >= max_hp):
		hp = max_hp
	elif (hp <= 0):
		hp = 0
	hpLabel.text = str(hp) + "/"  + str(max_hp) + "HP"
	
func set_enemy(newEnemy):
	enemy = newEnemy
	
func set_text(text):
	textBox.set_text_with_origin(text, "player")
#	yield(textBox, "end_player_text")
	print("player : end text")