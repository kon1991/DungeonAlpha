extends Node

onready var main = get_tree().current_scene
onready var textBox = main.textBox
onready var player = main.find_node("PlayerStats")
onready var statPanel = main.find_node("EnemyStatPanel")

onready var moodLabel = statPanel.find_node("Mood")
onready var hpLabel = statPanel.find_node("HPLabel")
onready var position = main.find_node("EnemyPosition")

onready var labelEmmiter = main.find_node("LabelEmmiter")
onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

onready var hp = 10 setget set_hp
onready var mood = "Calm" setget set_mood
onready var max_hp = 10 
onready var damage = 3
onready var dead = false
onready var mname = "#@???!?"
onready var specialActions = []
onready var tags = []

signal end_turn
signal enemy_died
signal greet_over





func _ready():
	sprite.position = position.position
	sprite.scale = Vector2(2,2)
	hpLabel.set_text(str(hp) + "/"  + str(max_hp) + "HP")
	moodLabel.set_text(mood)
	moodLabel.set("custom_colors/font_color", 'ffffff') 
#	greet()

func set_stats(mName, mDamage, mHP, mMood, mtags=[]):
	mname = mName
	damage = mDamage
	mood = mMood
	hp = mHP
	max_hp = mHP
	hpLabel.set_text(str(hp) + "/"  + str(max_hp) + "HP")
	tags = mtags
	
func greet():
	if(mname==null):
		mname = "missingN"
	set_text(mname + " is attacking you!")
	
func take_turn():
	if player.hp > 0:
		attack()
	else: 
		#end game
		pass
	emit_signal("end_turn")

func set_hp(new_hp, type="phys"):
	if(new_hp>0):
		labelEmmiter.create_label("enemy", "heal", new_hp)
	elif(new_hp<0):
		labelEmmiter.create_label("enemy", "hurt", new_hp)
	hp = hp + new_hp
	if (hp >= max_hp):
		hp = max_hp
	elif (hp <= 0):
		hp = 0
		dead = true
	hpLabel.text= str(hp) + "/"  + str(max_hp) + "HP"
	if(dead):
		
		emit_signal("enemy_died")
		print("emit")

func attack():
	print("try")
	pass

func set_mood(new_mood):
	moodLabel.text = new_mood
	mood = new_mood
	
func set_text(text):
	textBox.set_text_with_origin(text, "enemy")
	print("enemy: en text")

func set_array_text(textArray):
	textBox.set_array_text(textArray, "enemy")
	
func has_tag(tag):
	if(tags.has(tag)):
		return true
	else:
		return false