extends "res://Scenes/EnemyStats.gd"

onready var monsterName = "Blobby"
onready var monsterDamage = 2
onready var monsterMood = "Slimy"
onready var monsterHP = 12
onready var specials = ["ScoopButton"]
onready var monsterTags = ["fire_vuln"]

func _ready():
	set_stats(monsterName, monsterDamage, monsterHP, monsterMood)
	greet()
	yield(textBox, "end_enemy_text")
	pass # Replace with function body.

func take_turn():
	regen()
	yield(textBox, "end_enemy_text")
	attack()
	
func attack():
	player.set_hp(-damage)
#	potentionally debuffs you, scrambles letter and placement of buttons maybe?
	set_text("Slimy tendrils grope you!")
	yield(textBox, "end_enemy_text")
	emit_signal("end_turn")
	
func regen():
	set_hp(2)
	set_text("Blobby regenerates!")
	### possible respritegenation
	
func set_hp(new_hp, type="phys"):
	if(type == "acid"):
		new_hp = 0
	.set_hp(new_hp)

func change_sprite():
	var newTexture = load("res://Images/blobby-damaged4.png")
	animationPlayer.play("scoop")
	yield(animationPlayer, "animation_finished")
	sprite.texture = newTexture
		
func greet():
	set_array_text(["Slime flows down form the ceiling", "It unites into Blobby!"])
	yield(textBox, "end_enemy_text")
	emit_signal("greet_over")