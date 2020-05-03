extends Node
#monster name here

var item_rewards = { 	"Tick" : { 100 : [0, "S_Potion"]},
						"Dapper Tick" : { 80: [0, "S_Potion"], 100: [1, "Dapper_Hat"]},
						"Magic Man" : {1: [0, "Magic_Dust"], 100:[2, "Mana_Sword"]},
						"Blobby" : {99: [0, "S_Potion"], 100: [3, "Slime_Armor"]},
						"Bug Gang": {60:[0, "S_Potion"], 100: [2, "Bug_Sword"],},
						"DragonPoop": {80: [0,"Poop"], 99: [2, "Poop_Knife"], 100: [1, "Gold_Poop"]},
						"MegaBox": {100: [0, "S_Potion"]},
						"MegaBoxWon": {25:[2, "Mana_Sword"],  50: [2, "Bug_Sword"], 75: [2, "Flame_Sword"], 100: [3, "Slime_Armor"]},
						"Skelly": {100: [0, "S_Potion"]},
						"Doug": {100: [0, "Mimic_Juice"]},
						"Beholdey" :{100: [0, "S_Potion"]},
						"Wurm": {100: [2, "Wurm_Scale"]},
						"Devil": {100: [1, "Devil's Mark"]}
					}
					
func get_item_reward(mname):
	var loots = item_rewards.get(mname)
	var keys = loots.keys()
	randomize()
	var rand = randi()%100 +1
	print(rand)
	for key in loots.keys():
		if(rand <= key):
			return loots.get(key)
