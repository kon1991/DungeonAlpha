extends "res://Scenes/EnemyStats.gd"

onready var monsterName = "Bug Gang"
onready var monsterDamage = 2
onready var monsterMood = "SKSKS"
onready var monsterHP = 10
onready var specials = []
onready var monsterTags = []
onready var interactions = ["Yes", "No"]

onready var Reward = load("res://Reward.gd")

func _ready():
	set_stats(monsterName, monsterDamage, monsterHP, monsterMood)
	greet()
	sprite.scale = Vector2(1,1)
	yield(textBox, "end_enemy_text")

func take_turn():
	randomize()
	if(randi()%3 <= 1):
		attack()
	else:
		steal()
	pass
	
func attack():
	set_array_text(["\"NYEH\" the bugs shout,","as they scratch you everywhere"])
	player.set_hp(-damage)
	player.gold -= 2
	yield(textBox, "end_enemy_text")
	emit_signal("end_turn")
	
func steal():
	set_array_text(["The bugs swarm you", "Your pockets feel emptier"])
	yield(textBox, "end_enemy_text")
	player.gold -= 5
	emit_signal("end_turn")
	
# text order gets fucked.
func set_hp(new_hp, type="phys"):
	randomize()
	var mod = randi() % 100
	if(mod < 25 and type=="phys"):
		player.set_array_text(["The bugs take a defensive formation!", "Your attack is blocked"])
	else:
		.set_hp(new_hp)
	
func greet():
	if(player.passive.has("Bug_Coin")):
		set_array_text(["Ah, you frenk of bogs,", "Frenk can pass, mother protect you"])
		yield(textBox, "end_enemy_text")
		main._on_Enemy_died(false)
	else:
		set_array_text(["Hello, frenk", "gib moni?"])
		yield(textBox, "end_enemy_text")
		main.buttonContainer.visible = false
		main.interactContainer.visible = true
		main.get_interactions()
		player.player_turn = true
		yield(main, "interactionPropagation")
		if(main.current_interact == "Yes"):
			if(player.gold > 4):
				player.player_turn = false
				main.disable_buttons()
				main.interactContainer.visible = false
				set_text("Thankee frenkl, mother protect you")
				yield(textBox, "end_enemy_text")
				player.gold -= 4
				player.hp -= 2
				var newReward = Reward.new(1, 1, "Bug_Coin")
				main.new_rewards.append(newReward)
				main._on_Enemy_died(false)
				#code no money
		elif(main.current_interact == "No"):
			player.player_turn = false
			set_array_text(["Gib money SKSKSKS", "or take death SKSKSK"])
			yield(textBox, "end_enemy_text")
			main.buttonContainer.visible = true
			main.interactContainer.visible = false
			emit_signal("greet_over")
