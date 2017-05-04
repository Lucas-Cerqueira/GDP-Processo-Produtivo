extends Node2D

export var maxHealth = 100
export var speed = 100

var health
var direction = Vector2(0.0, 0.0)
var last_dir = 1

var shooting = false
var previous_shooting = false

var shoot_from
var camera

func _ready():
	health = maxHealth
	shoot_from = get_node("Sprite/shoot_from")
	camera = get_node("Camera2D")
	
	# Spawn the player at half of the level limit
	set_global_pos(Vector2(camera.get_limit(2)/2.0, 0))
	
	set_fixed_process(true)
	set_process_input(true)
	

func _fixed_process(delta):
	
	var camera_limit_left = camera.get_limit(0)
	var camera_limit_right = camera.get_limit(2)
	var sprite_size = (get_node("Sprite").get_item_rect().size[0])
	
	# Handle player movement
	var player_pos = get_pos()
	if Input.is_action_pressed("move_left") and (player_pos.x-sprite_size/2 > camera_limit_left):
		direction.x = -1.0
		last_dir = -1
		get_node("Sprite").set_scale(Vector2(-1.0,1.0))
		
	elif Input.is_action_pressed("move_right") and (player_pos.x+sprite_size/2 < camera_limit_right):
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

func TakeHit (damage):
	health -= damage
	if health <= 0:
		# Respawn
		health = maxHealth
		set_global_pos(Vector2(camera.get_limit(2)/2.0, 0))
	
