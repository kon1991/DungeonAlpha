extends Node

onready var main = get_tree().current_scene
onready var status = main.find_node("StatusContainer")
onready var textBox = main.find_node("TextBox")
onready var animationPlayer = main.find_node("AnimationPlayer")
onready var statPanel = main.find_node("PlayerStatPanel")
onready var hpLabel = statPanel.find_node("HPLabel")
onready var mpLabel = statPanel.find_node("MPLabel")
onready var labelEmmiter = main.find_node("LabelEmmiter")
onready var enemy #= main.find_node("EnemyStats") #find enemy on instance
onready var actions = ["AttackButton", "AbilityActionButton", "ItemActionButton", "SpecialActionButton"]
onready var skills = ["PowerWordButton", "HealActionButton", "ScryButton"]
onready var StatusRect = load("res://Scenes/StatusRect.tscn")
onready var passiveManager =$PassiveManager

onready var Weapon = load("res://Scenes/Weapons/Sword.gd")
onready var weapon_name = "Sword" setget set_weapon
onready var weapon 

onready var Armor = load("res://Scenes/Armor/Scale_Mail.gd")
onready var armor_name = "Scale_mail" setget set_armor
onready var armor

onready var inventory = ["Bottle", "Poop_Bottle", "Magic_Dust", "Acid_Vial"]

onready var passive = []

onready var passiveAbilities = []


onready var xp = 0
onready var gold = 10

var hp = 20 setget set_hp
var max_hp = 20
var mp = 10 setget set_mp
var max_mp = 10
var mp_regen = 5
var player_turn = false setget set_player_turn
var new_conditions = []
var noButtonsPressed = true
export var damage = 10
var damage_mod = 0

#special vars
var doom_count = 0
var poop_count = 0

signal player_attack_start
signal player_attack_end
signal end_turn


func _ready():
	connect("end_turn", main, "_on_PlayerStats_end_turn")
#	passiveManager.connect("player_attack_end_over", self, "on_player_attack_end_over")
	pass # Replace with function body.

#
func set_hp(new_hp, type="phys"):
	if(new_hp<0):
		new_hp = armor.calculate_damage(new_hp, type)
	if(new_hp>0):
		labelEmmiter.create_label("player", "heal", new_hp)
	else:
		labelEmmiter.create_label("player", "hurt", new_hp)
	hp = hp + new_hp
	if (hp >= max_hp):
		hp = max_hp
	elif (hp <= 0):
		main.on_death()
	hpLabel.text = str(hp) + "/"  + str(max_hp) + "HP"

func set_mp(new_mp):
	mp = mp + new_mp
	if (mp >= max_mp):
		mp = max_mp
	elif (mp <= 0):
		mp = 0
	mpLabel.text = str(mp) + "/"  + str(max_mp) + "MP"

func set_weapon(new_weapon):
	weapon_name = new_weapon
	Weapon = load("res://Scenes/Weapons/"+weapon_name+".gd")
	
func set_armor(new_armor):
	armor_name = new_armor
	Weapon = load("res://Scenes/Armor/"+armor_name+".gd")
	
func set_player_turn(turn):
	print("Player_turn: " + str(turn))
	player_turn = turn
	
func set_enemy(newEnemy):
	enemy = newEnemy
	passiveManager.enemy = newEnemy
	
func set_text(text):
	textBox.set_text_with_origin(text, "player")

func set_array_text(textArray):
	textBox.set_array_text(textArray, "player")

func create_weapon():
#	weapon = Weapon.new("Sword", 9, 1, "You slash the ", enemy, self)
	weapon = Weapon.new(enemy,self)

func create_armor():
	armor = Armor.new(enemy,self)	
	
func attack():
	var attack_effect = "attack"
	if weapon.effect != null:
		attack_effect = weapon.effect + "_" + attack_effect
	var damage_dealt = weapon.attack()
	main.animationPlayer.play(attack_effect)
	yield(textBox, "end_player_text")
	passiveManager._on_player_attack_end(damage_dealt)
	if passiveManager.attack_end.size() > 0 && passiveManager.effects_activated:
		print("EFFECTS ACTIVATED")
		yield(passiveManager, "player_attack_end_over")
	print("END TURN YOU FCUCK")
	emit_signal("end_turn")

	
func check_new_conditions():
	var has_conditions = false
	var condition_num = 0
	for condition in new_conditions:
		condition_num += 1
		has_conditions = true
		create_new_status(condition[0], condition[1], condition[2])
	new_conditions = []
	return has_conditions
	
func create_new_status(condition, dur, mod):
	var statusRect = StatusRect.instance()
	statusRect.init(condition, dur, mod)
	
	status.add_child(statusRect)
	
func apply_statuses():
	var statusList = status.get_children()
	doom_count = 0
	poop_count = 0
	for status in statusList:
		apply_status(status)
	match doom_count:
		1:
			set_text("A chill runs down your spine")
		2:
			set_text("A buzzing fills your head")
		3:
			set_text("You feel doomed...")
		4:
			set_array_text(["The gates of hell open", "Dark tentacles drag you into the abyss", "It's over..."])	
			set_hp(-max_hp)
	if poop_count >0:
		if poop_count == 1:
			set_text("You stink!")
		else:
			set_text("You stink!x"+str(poop_count))

func get_statuses():
	var statusList = status.get_children()
	return statusList

func clear_status():
	var statusList = status.get_children()
	for status in statusList:
		status.queue_free()
				
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
			"mag":
				print("You got the virus")
			"poop":
#				set_text("You stink!")
				poop_count += 1
			"penta":
				doom_count += 1
				status.set_duration(-1)
