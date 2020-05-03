extends Node

onready var ScryDict = {"Tick" : ["Blood sucking beast that infest the dungeon", "It might look cute, but beware it's actually the size of a dog",
									"Loves to drink blood, but also health potions."],
						"Dapper Tick": ["A true gentleman, unlike his uncivilized cousins.", "They say clothes dont maketh man,",
									"But that hat! Amazing."],
						"Blobby" : ["Acidic slime that's consumed bits and pieces of unfortunate dungeoneers,", "granting him sentience and a sense of cruelty",
									"Afraid of fire and bottles for some reason"],
						"Magic Man" : ["Diminutive practitioner of Arcane Magics", "Teleports away when hurt too much",
										"The spell \"Zho-Kalar-Irog!\" can stop him!"],
						"Bug Gang" : ["Bandits from the Bug kingdom, lowly servants of the Queen", "Small but fast, good at teamwork and setting traps.",
									"If you get them on your side their loyalty is well known."],
						"Dragon Poop" : ["The poop of a dragon, imbued by magical energies from jewels the dragon couldn't digest",
										"A stinky annoyance at first but beware of it's insidious magic"],
						"Skelly" : ["Undead guardian of the dungeon, rich in calcium" , "Loves to laugh and slice up those who intrude on his domain"],
						"Beholdey" : ["A lesser Beholder, terrifying abomination native to the depths of the dungeon", "Randomly zaps each foes with his three rays, each deadlier than the last"],
						"MegaBox" : ["Most hated and yet coveted creature of the dungeon", "Runs around lauging at those too poor to play it's game.", "Laughs even harder at those who lose"],
						"Doug": ["It's Doug! How could you forget Doug?", "He's your best friend in all the dungeon!", "Good old Doug, you can definitely trust him"]}

func get_scry(monsterName):
	var response = ScryDict.get(monsterName, ["This monster is unknown.","Be careful!"])
	return response