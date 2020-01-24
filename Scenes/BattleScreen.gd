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
onready var itemContainer = $UI/ActionPanel/CenterContainer/ItemContainer
onready var actionContainer = $UI/ActionPanel/CenterContainer/ActionContainer
onready var specialContainer = $UI/ActionPanel/CenterContainer/SpecialContainer
onready var backButton = $UI/ActionPanel/BackButton
onready var statusContainer = $UI/StatusPanel/HBoxContainer
onready var postBattle = $UI/PostBattlePanel
onready var postBattleRewards = $UI/PostBattlePanel/MarginContainer/OuterVBox/InnerVBox
onready var nextButton = $UI/PostBattlePanel/MarginContainer/OuterVBox/CenterContainer/NextButton
var i = 0

func _ready():
	begin_battle()
	
	pass # Replace with function body.

func begin_battle():
	print("You have " + str(player.xp) +"XP!")
	var item_str ="You have"
	var inv = player.inventory
	for item in inv:
		item_str += " a " + item +","
	item_str += "!"
	print(item_str)
	get_next_enemy()
	get_buttons()
	get_items()
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
#	if(has_conditions):
#		yield(textBox, "end_player_text")
	if(player.status.get_child_count()>0):
		player.apply_statuses()
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

func _on_Enemy_died(won := true):
	yield(get_tree().create_timer(0.8), "timeout")
	var enemy_name = enemy.mname
	enemy.queue_free()
	#should move to a function##
	var buttons = buttonContainer.get_children()
	for button in buttons:
		button.queue_free()
	buttons = itemContainer.get_children()
	for button in buttons:
		button.queue_free()
	player.player_turn = false
	### magic time ####
	handle_post_battle(enemy_name, won)
	yield(nextButton, "pressed")
	var rewardLabels = postBattleRewards.get_children()
	
	for label in rewardLabels:
		label.queue_free()
	postBattle.visible = false
	##################
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
		
func get_items():
	for item in player.inventory:
		var Button = load("res://Scenes/Items/"+item+".tscn")
		var button = Button.instance()
		button.set_enemy(enemy)
		itemContainer.add_child(button)
	
		
func bind_buttons():
	var buttons = buttonContainer.get_children()
	for button in buttons:
		print(button.has_method("set_enemy"))
		button.set_enemy(enemy)
		
func disable_buttons():
	
	###MIGHT EXPAND WITH OTHER CONTAINERS####
	var buttons = buttonContainer.get_children()
	for button in buttons:
		button.set_disabled(true)
		player.noButtonsPressed = false
		
func handle_post_battle(mname, won):
	postBattle.visible = true
	if(won):
		var rewards = Global.determine_rewards(mname)
		for reward in rewards:
			var newLabel = Label.new()
			newLabel.text = reward.message
			postBattleRewards.add_child(newLabel)
		handle_rewards(rewards)
		rewards.clear()

func handle_rewards(rewards):
	for reward in rewards:
		if(reward.cat == reward.ITEM):
			player.inventory.append(reward.item_name)
		elif(reward.cat == reward.EXP):
			player.xp += reward.num

func _on_BackButton_pressed():
	backButton.visible = false
	itemContainer.visible = false
	actionContainer.visible = false
	specialContainer.visible = false
	buttonContainer.visible = true
	pass # Replace with function body.

func change_inventory(item):
	player.inventory.erase(item)
	var buttons = itemContainer.get_children()
	for button in buttons:
		button.queue_free()
	get_items()