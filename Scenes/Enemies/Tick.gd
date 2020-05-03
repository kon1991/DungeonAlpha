extends "res://Scenes/EnemyStats.gd"

onready var monsterName = "Tick"
onready var monsterDamage = 3
onready var monsterMood = "Calm"
onready var monsterHP = 10
onready var specials = ["PetTickButton"]
onready var hearts = $Hearts
onready var dapper = false
onready var dapperTexture = load("res://Images/Enemies/Tick/tik.png")

func _ready():
	randomize()
	if randi()%100 < 20:
		monsterName = "Dapper Tick"
		dapper = true
		sprite.texture = dapperTexture
	set_stats(monsterName, monsterDamage, monsterHP, monsterMood)
	hearts.position = position.position + Vector2(-3,-20)
#	greet()

func take_turn():
	if(mood=="Hungry"):
		suck()
	else:
		attack()
		if(hearts.is_emitting()):
			print("hearts")
	pass
	
func attack():
	player.set_hp(-damage)
	if dapper:
		set_text("The Tick slaps you")
	else:
		set_text("The Tick scratches you")
#	player.new_conditions.append(["mag", 2, 2])
	yield(textBox, "end_enemy_text")
	emit_signal("end_turn")
	
func suck():
	player.set_hp(-(damage-1))
	set_hp(2)
	set_text("The Tick sucks your blood!")
	yield(textBox, "end_enemy_text")
	emit_signal("end_turn")
	
func set_hp(new_hp, type="phys"):
	.set_hp(new_hp)
	if(hp <=5):
		set_mood("Hungry")
		print(mood)
		moodLabel.set("custom_colors/font_color", '9c0b0b') #red
		
func greet():
	if dapper:
		set_text("Dapper Tick tips his Top Hat")
	else:
		set_text("A monstrous Tick appears!")
	yield(textBox, "end_enemy_text")
	emit_signal("greet_over")
	
