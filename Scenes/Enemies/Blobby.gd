extends "res://Scenes/EnemyStats.gd"

onready var monsterName = "Blobby"
onready var monsterDamage = 3
onready var monsterMood = "Slimy"
onready var monsterHP = 12
onready var specials = ["ScoopButton"]
onready var monsterTags = ["fire_vuln"]
onready var damagedBlobby = load("res://Images/Enemies/Blobby/blobby-damaged4.png")
onready var tween = $Tween
var up = true
var trans_type = Tween.TRANS_SINE

func _ready():
	set_stats(monsterName, monsterDamage, monsterHP, monsterMood, monsterTags)
	tween.interpolate_property(sprite, "position",
        null, sprite.position + Vector2(0, -3), 1.5,
       trans_type, Tween.EASE_IN_OUT)
	tween.start()
	pass # Replace with function body.

func take_turn():
	regen()
	yield(textBox, "end_enemy_text")
	attack()
	
func attack():
	player.set_hp(-damage, "acid")
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
	if(type == "fire"):
		new_hp = new_hp * 2
	.set_hp(new_hp)

func change_sprite():
	print("ASDSADADAASDDASDADASDASDA")
#	yield(animationPlayer, "animation_finished")
	animationPlayer.play("scoop")
	yield(animationPlayer, "animation_finished")
	animationPlayer.play("damaged")
		
func greet():
	set_array_text(["Slime flows down form the ceiling", "It unites into Blobby!"])
	yield(textBox, "end_enemy_text")
	emit_signal("greet_over")
	
func _on_Tween_tween_all_completed():
	if up:
		tween.interpolate_property(sprite, "position", null, sprite.position + Vector2(0, 6), 2,
        trans_type, Tween.EASE_IN_OUT)
		up = false
		tween.start()
	else:
		tween.interpolate_property(sprite, "position",
        null, sprite.position + Vector2(0, -6), 2,
        trans_type, Tween.EASE_IN_OUT)
		up = true
		tween.start()
	pass # Replace with function body.
