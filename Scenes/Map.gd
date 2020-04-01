extends Node

onready var Block = load("res://Scenes/Block.tscn")
onready var grid = $UI/Center/Grid
onready var map = []
onready var player = $Node2D/Sprite
onready var main = get_tree().current_scene
onready var UI = $UI
onready var animationPlayer = $AnimationPlayer
onready var fade = $FADE
var complex = 4
var connected = []
const def_map = [["X","X","X","X","X","X"],["X","X","X","X","X","X"],["X","X","X","X","X","X"],
	["X","X","X","X","X","X"],["X","X","X","X","X","X"],["X","X","X","X","X","X"]]


func _ready():
	map = def_map
	create_map()
#	set_process(true)
	
#func _process(delta):
#	player.position = get_viewport().get_mouse_position()

func _on_Button_pressed():
	var blocks = get_tree().get_nodes_in_group("blocks")
	for block in blocks:
		block.free()
	connected = []
	create_map()
	pass # Replace with function body.

func create_map():
	map = [["X","X","X","X","X","X"],["X","X","X","X","X","X"],["X","X","X","X","X","X"],
	["X","X","X","X","X","X"],["X","X","X","X","X","X"],["X","X","X","X","X","X"]]
	randomize()
	var origins = create_origins()
	
	
	for origin in origins:
		get_closest_point(origin, origins)
		
	for i in range(map.size()):
		for j in range(map[i].size()):
			var newBlock = Block.instance()
			newBlock.init(i,j)
			newBlock.connect("set_sprite", self, "on_set_sprite")
			newBlock.connect("block_pressed", self, "on_block_pressed")
			if( map[i][j] == "X"):
				newBlock.set_disabled(true)
			else:
				newBlock.add_to_group("active_blocks")
			grid.add_child(newBlock)
	var active_blocks = get_tree().get_nodes_in_group("active_blocks")
	var starting_block = active_blocks[randi()%active_blocks.size()]
	starting_block.set_is_visible(true)
	starting_block.set_pressed(true)
	starting_block.starting = true
	create_content(active_blocks)
	for block in active_blocks:
		if(is_block_neighbour(starting_block,block)):
			block.set_is_visible(true)
	yield(starting_block, "draw")
	player.global_position = Vector2(starting_block.rect_global_position.x+8, starting_block.rect_global_position.y+8)
#
func on_set_sprite(pos):
	player.position = Vector2(pos.x+8, pos.y+8)

func on_block_pressed(pressed_block, enemy):
	if enemy != null:
		var newEnemyScene = load("res://Scenes/"+enemy+".tscn")
		main.enemies.append(newEnemyScene)
		animationPlayer.play("fadeOut")
		yield(animationPlayer, "animation_finished")
		fade.visible = false
		set_visible(false)
		main.begin_battle()
	var blocks = get_tree().get_nodes_in_group("blocks")
	for block in blocks:
		if(is_block_neighbour(pressed_block, block)):
			block.set_is_visible(true)

func is_block_neighbour(pressed_block,block):
	var is_neighbour = false
	if(block.x == pressed_block.x +1 and block.y == pressed_block.y):
		is_neighbour = true
	elif(block.x == pressed_block.x -1 and block.y == pressed_block.y):
		is_neighbour = true
	elif(block.x == pressed_block.x  and block.y == pressed_block.y +1):
		is_neighbour = true
	elif(block.x == pressed_block.x  and block.y == pressed_block.y -1):
		is_neighbour = true
	return is_neighbour
		
			
func create_origins():
	var origins = []
	for i in range(3):
		var origin = Vector2(int(clamp(randi()%6,1,4)),int(clamp(randi()%6,1,4)))
		while is_distance_not_enough(origin,origins):
#		while map[int(origin.x)][int(origin.y)] == "O":
			origin = Vector2(int(clamp(randi()%6,1,4)),int(clamp(randi()%6,1,4)))
		map[int(origin.x)][int(origin.y)]  = "O"
		origins.append(origin)
	return origins

func is_distance_not_enough(origin, origins):
	var enough = false
	var min_dist = 100
	for e_origin in origins:
		if(min_dist>origin.distance_to(e_origin)):
			min_dist = origin.distance_to(e_origin)
	if(min_dist<2):
		enough = true
	return enough

func ez_passage(origins):
	var curr_y
	var curr_x
	var min_x = min(origins[0].x,origins[1].x)
	var max_x = max(origins[0].x,origins[1].x)
	var end_point
	if(min_x == origins[0].x):
		curr_y = origins[0].y
		end_point = origins[1]
	else:
		curr_y = origins[1].y
		end_point = origins[0]
	var last_x 
	for i in range(min_x, max_x+1):
		map[i][curr_y] = "O"
		last_x = i
	var mid_point = Vector2(last_x,curr_y)	

	var min_y = min(mid_point.y,end_point.y)
	var max_y = max(mid_point.y,end_point.y)
	if(min_y == mid_point.y):
		curr_x = mid_point.x
	else:
		curr_x = end_point.x
	for i in range(min_y, max_y+1):
		map[curr_x][i] = "O"	

			
func get_closest_point(curr_point, points):
#	print("CURRENT ORIGIN IS: " + str(curr_point.x) + str(curr_point.y))
	var min_dist = 100
	var min_point = Vector2(0,0)
	for point in points:
		if curr_point!=point:
			if(!is_point_connected(curr_point, point)):
				if(min_dist>curr_point.distance_to(point)):
					min_dist = curr_point.distance_to(point)
					min_point = point
#	print("CLOSEST POINT IS: " + 	str(min_point.x) + str(min_point.y) )
	if(min_point!=Vector2(0,0)):
		if(count_connections(curr_point) + count_connections(min_point) < 2):
			create_passage(curr_point, min_point)
			connected.append([curr_point, min_point])
	print(connected)
#			print("**DISTANCE TO: " + str(point.x) + str(point.y) + " is " + str(curr_point.distance_to(point)))

func create_passage(origin1, origin2):
	var curr_y
	var curr_x
	var min_x = min(origin1.x,origin2.x)
	var max_x = max(origin1.x,origin2.x)
	var end_point
	if(min_x == origin1.x):
		curr_y = origin1.y
		end_point = origin2
	else:
		curr_y = origin2.y
		end_point = origin1
	var last_x 
	for i in range(min_x, max_x+1):
		map[i][curr_y] = "O"
		last_x = i
	var mid_point = Vector2(last_x,curr_y)	

	var min_y = min(mid_point.y,end_point.y)
	var max_y = max(mid_point.y,end_point.y)
	if(min_y == mid_point.y):
		curr_x = mid_point.x
	else:
		curr_x = end_point.x
	for i in range(min_y, max_y+1):
		map[curr_x][i] = "O"	
		
func is_point_connected(x,y):
	if(!connected.has([x,y]) and !connected.has([y,x])):
		return false
	else:
		return true

func count_connections(point):
	var count = 0
	for c in connected:
		if c[0] == point or c[1] == point:
			count += 1
	return count

func create_content(blocks):
	var has_shop = false
	var has_shrine = false
	for block in blocks:
		if !block.starting:
			var rand_block = randi()%5
			match rand_block:
				0,1,2:
					block.type = "fight"
				3:
					if(!has_shop):
						block.type = "shop"
						has_shop = true
					else:
						block.type = "fight"
				4: 
					if(!has_shrine):
						block.type = "shrine"
						has_shrine = true
					else:
						block.type = "fight"
			if block.type == "fight":
				block.get_random_enemy()
	pass
	
func set_visible(value):
	UI.set_visible(value)
	fade.visible = value
	print(value)