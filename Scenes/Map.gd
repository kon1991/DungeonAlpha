extends Node

onready var Block = load("res://Scenes/Block.tscn")
onready var grid = $UI/Center/Grid
onready var map = []


func _ready():
	map = [["X","X","X","X","X","X"],["X","O","X","X","O","X"],["O","X","X","O","X","O"],
	["X","X","O","X","X","X"],["X","X","X","X","X","X"],["X","X","X","X","X","X"],]
	
	for i in range(map.size()):
		for j in range(map[i].size()):
			var newBlock = Block.instance()
			if( map[i][j] == "O"):
				newBlock.set_pressed(true)
			grid.add_child(newBlock)
