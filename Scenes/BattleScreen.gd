extends Node

export(Array, PackedScene) var enemies = []
onready var player = $PlayerStats
onready var enemy
onready var textBox = $UI/CenterContainer/TextBox
onready var enemyPanel = $UI/EnemyStatPanel/EnemyStatContainer#
onready var playerHP = player.hpLabel
onready var playerMP = player.mpLabel
onready var enemyHP 
onready var enemyMood 
onready var animationPlayer = $AnimationPlayer
onready var buttonContainer = $UI/ActionPanel/CenterContainer/ButtonContainer
onready var itemContainer = $UI/ActionPanel/CenterContainer/ItemContainer
onready var actionContainer = $UI/ActionPanel/CenterContainer/ActionContainer
onready var specialContainer = $UI/ActionPanel/CenterContainer/SpecialContainer
onready var interactContainer = $UI/ActionPanel/CenterContainer/InteractContainer

onready var backButton = $UI/ActionPanel/BackButton
onready var statusContainer = $UI/StatusPanel/StatusContainer
onready var postBattle = $UI/PostBattlePanel
onready var postBattleRewards = $UI/PostBattlePanel/MarginContainer/OuterVBox/InnerVBox
onready var nextButton = $UI/PostBattlePanel/MarginContainer/OuterVBox/CenterContainer/NextButton
onready var textInput = $UI/ActionPanel/CenterContainer/TextInput
onready var tryAgainButton = $TryAgainContainer/TryAgainButton

onready var Reward = load("res://Scenes/RewardContainer.tscn")

var i = 0
var new_rewards = []
var current_interact = ""

signal interactionPropagation

func _ready():
	tryAgainButton.set_disabled(true)
	tryAgainButton.visible = false
	begin_battle()
	
	pass # Replace with function body.

func begin_battle():
	buttonContainer.visible = true
	specialContainer.visible = false
	actionContainer.visible = false
	interactContainer.visible = false
	itemContainer.visible = false
	get_next_enemy()
	player.create_weapon()
	get_buttons()
	get_items()
	get_skills()
	get_specials()
	
	player.mp = player.mp_regen
	playerHP.text = str(player.hp) + "/"  + str(player.max_hp) + "HP"
	playerMP.text = str(player.mp) + "/"  + str(player.max_mp) + "MP"
	#enemyHP.text= str(enemy.hp) + "/"  + str(enemy.max_hp) + "HP"
	enemyMood.text = enemy.mood
	yield(enemy, "greet_over")
	begin_player_turn()
	
func begin_player_turn():
	
	var has_conditions = player.check_new_conditions()
	if(player.status.get_child_count()>0):
		player.apply_statuses()
		yield(textBox, "end_player_text")
	change_visible_status()
	player.noButtonsPressed = true
	backButton.set_disabled(false)
	player.player_turn = true
	
func change_visible_status():
	var statusList = statusContainer.get_children()
	var count = 0
	for status in statusList:
		if(count<3):
			status.visible = true
		else:
			status.visible = false
	count += 1
	
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
#	var buttons = buttonContainer.get_children()
#	for button in buttons:
#		button.queue_free()
#	buttons = itemContainer.get_children()
#	for button in buttons:
#		button.queue_free()
#	buttons = actionContainer.get_children()
#	for button in buttons:
#		button.queue_free()
#	buttons = specialContainer.get_children()
#	for button in buttons:
#		button.queue_free()
	free_buttons(buttonContainer)
	free_buttons(itemContainer)
	free_buttons(actionContainer)
	free_buttons(specialContainer)
	free_buttons(interactContainer)
	
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
	textBox.text = ""
	#begin_battle()
	yield(animationPlayer,"animation_finished") #this probably doesnt do shit
	
func free_buttons(container):
	var buttons = container.get_children()
	for button in buttons:
		button.queue_free()
	
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
		#move signal connections to special function, to connect special signals
		enemy.connect("flash", self, "_on_Flash")
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

func get_skills():
	for skill in player.skills:
		var Button = load("res://Scenes/Buttons/"+skill+".tscn")
		var button = Button.instance()
		button.set_enemy(enemy)
		actionContainer.add_child(button)

func get_specials():
	for special in enemy.specials:
		var Button = load("res://Scenes/Buttons/"+special+".tscn")
		var button = Button.instance()
		button.set_enemy(enemy)
		specialContainer.add_child(button)

func get_interactions():
	for interaction in enemy.interactions:
		var Button = load("res://Scenes/Buttons/InteractButton.tscn")
		var button = Button.instance()
		button.set_enemy(enemy)
		button.text = interaction
		button.connect("interaction", self, "_on_interact")
		interactContainer.add_child(button)
		
	
func bind_buttons():
	var buttons = buttonContainer.get_children()
	for button in buttons:
		print(button.has_method("set_enemy"))
		button.set_enemy(enemy)
		
func disable_buttons(container= buttonContainer):
	
	backButton.set_disabled(true)
	var buttons = container.get_children()
	for button in buttons:
		button.set_disabled(true)
		player.noButtonsPressed = false
		
func handle_post_battle(mname, won):
	postBattle.visible = true
	if(won):
		new_rewards = Global.determine_rewards(mname)
	var num_rewards = []
	for reward in new_rewards:
		if(reward.cat == reward.ITEM or reward.cat == reward.PASS or reward.cat == reward.WEAP or reward.cat == reward.ARM):
			var newReward = Reward.instance()
			newReward.init(reward.cat, reward.item_name)
			postBattleRewards.add_child(newReward)
			newReward.set_reward_text(reward.message)
		else:
			var newLabel = Label.new()
			newLabel.text = reward.message
			postBattleRewards.add_child(newLabel)
			num_rewards.append(reward)
	handle_rewards(num_rewards)
	new_rewards.clear()

func handle_rewards(rewards):
	
	for reward in rewards:
		print(reward.cat)
		if(reward.cat == reward.ITEM):
			player.inventory.append(reward.item_name)
		elif(reward.cat == reward.EXP):
			player.xp += reward.num
		elif(reward.cat == reward.GOLD):
			player.gold += reward.num
		elif(reward.cat == reward.PASS):
			player.passive.append(reward.item_name)
			
func _on_BackButton_pressed():
	backButton.visible = false
	itemContainer.visible = false
	actionContainer.visible = false
	specialContainer.visible = false
	buttonContainer.visible = true
	textInput.visible = false
	pass # Replace with function body.

func change_inventory(item, delete=true):
	if(delete):
		player.inventory.erase(item)
	else:
		player.inventory.append(item)
	var buttons = itemContainer.get_children()
	for button in buttons:
		button.queue_free()
	get_items()

func _on_Flash():
	animationPlayer.play("flash")
	
func _on_interact(action):
	print(action)
	current_interact = action
	emit_signal("interactionPropagation")

func on_death():
	disable_buttons()
	tryAgainButton.visible = true
	animationPlayer.play("death")
	tryAgainButton.set_disabled(false)
