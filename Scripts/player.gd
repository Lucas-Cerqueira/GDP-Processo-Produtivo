extends Node2D

export var speed = 100
var direction = Vector2(0.0, 0.0)
var last_dir = 1

var shooting = false
var previous_shooting = false

var shoot_from

func _ready():
	shoot_from = get_node("Sprite/shoot_from")
	
	set_fixed_process(true)
	set_process_input(true)
	

func _fixed_process(delta):
	
	# Handle player movement
	var player_pos = get_pos()
	if Input.is_action_pressed("move_left"):
		direction.x = -1.0
		last_dir = -1
		get_node("Sprite").set_scale(Vector2(-1.0,1.0))
		
	elif Input.is_action_pressed("move_right"):
		direction.x = 1.0
		last_dir = 1
		get_node("Sprite").set_scale(Vector2(1.0,1.0))
		
	else:
		direction.x = 0.0
		
	player_pos += direction * speed * delta
	set_pos(player_pos)
	
	# Handle player shooting
	shooting = Input.is_action_pressed("shoot")
	if (shooting and not previous_shooting):
		Shoot()
		
	previous_shooting = shooting

func Shoot ():
	var bullet = preload("res://Scenes/bullet.tscn").instance()
	
	get_tree().get_root().add_child(bullet)
	bullet.set_global_pos(shoot_from.get_global_pos())
	bullet.SetDirection (last_dir)
	
