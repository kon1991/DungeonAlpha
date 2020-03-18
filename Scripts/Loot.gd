extends Node

var item_rewards = { "Tick" : { 40: [0, "S_Potion"], 80: [2, "Bug_Sword"], 100: [1, "Dapper_Hat"]},
						"Magic Man" : {100: [0, "Magic_Dust"]},
						"Beholdey" :{100: [0, "S_Potion"]},
						"Blobby" : {100: [0, "S_Potion"]},
						"Bug Gang": {100: [0, "S_Potion"]},
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