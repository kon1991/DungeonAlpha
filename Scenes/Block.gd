extends TextureButton

var x
var y
var type setget set_type
var position 
var is_visible = false setget set_is_visible
var starting = false
var enemy = null
onready var icon = $TextureRect
onready var visibleSprite = load("res://Images/Blocks/NotVisitedBlock.png")
onready var invisibleSprite = load("res://Images/Blocks/InvisibleBlock.png")
onready var pressedSprite = load("res://Images/Blocks/DefaultBlock.png")

signal set_sprite
signal block_pressed

func _ready():
	add_to_group("blocks")
#	set_normal_texture(visibleSprite)
	
func init(_x,_y):
	x = _x
	y = _y

func set_type(new_type):
	type = new_type
	var texture
	if type == "fight":
		texture = load("res://Images/Blocks/Symbols/InteractIcon.png")
	elif type == "shop":
		texture = load("res://Images/Blocks/Symbols/ShopIcon.png")
	elif type == "shrine":
		texture = load("res://Images/Blocks/Symbols/ShrineIcon.png")
	icon.set_texture(texture)

func get_random_enemy():
	var enemyDict = Enemies.enemies
	var floor_enemies = enemyDict["floor_0"]
	var randEnemy = floor_enemies[randi()%floor_enemies.size()]
	enemy = randEnemy

func _on_Block_pressed():
	if(is_visible):
		print("ASDA")
		print(enemy)
		set_pressed(true)
		emit_signal("block_pressed", Vector2(x,y), enemy)
#		icon.visible = true

func set_pressed(state):
	if(state==true):
		.set_pressed(true)
	

func _on_Block_mouse_entered():
	print(rect_global_position)
#	set_is_visible(true)
	emit_signal("set_sprite", rect_global_position)

func set_is_visible(_visible):
	is_visible = _visible
	if is_visible:
		set_normal_texture(visibleSprite)
		set_hover_texture(pressedSprite)
		
		set_pressed_texture(pressedSprite)
	else:
		set_normal_texture(invisibleSprite)
		set_hover_texture(invisibleSprite)
		set_pressed_texture(invisibleSprite)

