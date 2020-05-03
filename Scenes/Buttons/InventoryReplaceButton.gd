extends "res://Scenes/Buttons/ActionButton.gd"

signal inventoryReplace

func _ready():
#	connect("inventoryReplace", main, "_on_inventory_replace")
	enemy = null
#	set_disabled(false)
#	set_process(false)
#	connect("inventoryReplace", main, "_on_inventory_replace")
	pass
	
func _on_pressed():
	emit_signal("inventoryReplace", text)
	print(text)