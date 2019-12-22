extends Node

export(Array, PackedScene) var enemies = []
onready var player = $PlayerStats
onready var enemy
onready var textBox = $UI/CenterContainer/TextBox
onready var enemyPanel = $UI/EnemyStatPanel/EnemyStatContainer#
onready var playerHP = player.hpLabel
onready var enemyHP 
onready var enemyMood 
onready var animationPlayer = $AnimationPlayer
onready var buttonContainer = $UI/ActionPanel/CenterContainer/ButtonContainer
onready var statusContainer = $UI/StatusPanel/HBoxContainer
var i = 0

func _ready():
	begin_battle()
	pass # Replace with function body.

func begin_battle():
	get_next_enemy()
	get_buttons()
#	bind_buttons()
	playerHP.text = str(player.hp) + "/"  + str(player.max_hp) + "HP"
	print(enemy.hp)
	print(enemyHP.text+"   ")
	#enemyHP.text= str(enemy.hp) + "/"  + str(enemy.max_hp) + "HP"
	enemyMood.text = enemy.mood
	begin_player_turn()
	
func begin_player_turn():
	
#	yield(get_tree().create_timer(0.8), "timeout")

	print("begin player turn")
	#check for conditions
	var has_conditions = player.check_new_conditions()
	if(has_conditions):
		yield(textBox, "end_player_text")
	player.noButtonsPressed = true
	player.player_turn = true
	
func begin_enemy_turn():
	print("begin enemy turn")
	player.player_turn = false
#	yield(get_tree().create_timer(0.8), "timeout")
	enemy.take_turn()
	


func _on_EnemyStats_enemy_end_turn():
	if(!player.player_turn):
		begin_player_turn()


func _on_PlayerStats_end_turn():
	print("!!!!!")
	if(player.player_turn):
		print("!!!!!!!!!!!")
		if(!enemy.dead and !enemy.is_queued_for_deletion()):
			begin_enemy_turn()

func _on_Enemy_died():
	enemy.queue_free()
	var buttons = buttonContainer.get_children()
	for button in buttons:
		button.queue_free()
	player.player_turn = false
	animationPlayer.play("Fade")
	#begin_battle()
	yield(animationPlayer,"animation_finished") #this probably doesnt do shit
	
	
	
func get_next_enemy():
	if(enemies.size()>0):
		var Enemy = enemies.pop_front()
		enemy = Enemy.instance()
		add_child(enemy)
		enemyHP = enemy.hpLabel
		enemyMood = enemy.moodLabel
		player.set_enemy(enemy)
		enemy.connect("enemy_died", self, "_on_Enemy_died")
		enemy.connect("end_turn", self, "_on_EnemyStats_enemy_end_turn")
	else:
		print("all done")
	pass
	
func get_buttons():
	for action in player.actions:
		var Button = load("res://Scenes/Buttons/"+action+".tscn")
		var button = Button.instance()
		button.set_enemy(enemy)
		buttonContainer.add_child(button)
		
func bind_buttons():
	var buttons = buttonContainer.get_children()
	for button in buttons:
		print(button.has_method("set_enemy"))
		button.set_enemy(enemy)
		
func disable_buttons():
	var buttons = buttonContainer.get_children()
	for button in buttons:
		button.set_disabled(true)
		player.noButtonsPressed = false
