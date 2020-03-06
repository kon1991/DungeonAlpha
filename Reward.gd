extends Node

enum {ITEM, PASS, WEAP, ARM, EXP, GOLD}
var cat
var num
var message
var item_name

func _init(category, number, name):
	cat = category
	num = number
	
	if(cat == ITEM): 
		item_name = name
		message = "You found " + item_name + "!"
	if(cat == EXP):
		message = "You gained " + str(num) + " EXP!"
	if(cat == GOLD):
		item_name = "gold"
		message = "You gained " + str(num) + " GP!"
	if(cat == PASS):
		item_name = name
		message = "You found " + item_name + "!"
	if(cat == WEAP):
		item_name = name
		message = "You found " + item_name + "!"
	pass
