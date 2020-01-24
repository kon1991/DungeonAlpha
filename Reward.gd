extends Node

enum {ITEM, EXP}
var cat
var num
var message
var item_name

func _init(category, number, name):
	cat = category
	num = number
	
	if(cat == ITEM): 
		item_name = name
		message = "You found x" + str(num) + " " + item_name + "!"
		print(message)
	if(cat == EXP):
		message = "You gained " + str(num) + " EXP!"
		print(message)
	pass
