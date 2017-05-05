extends KinematicBody2D

export var maxHealth = 100
export var speed = 100
export var ACCELERATION = 0.5
export var GRAVITY = 500
export var jumpSpeed = 500

var health
var velocity = Vector2(0.0, 0.0)
var last_dir = 1

var grounded = false

var previous_shooting = false
var previous_attacking = false

var shoot_from
var camera

func _ready():
	health = maxHealth
	shoot_from = get_node("Sprite/shoot_from")
	camera = get_node("Camera2D")
	
	# Spawn the player at half of the level limit
	#set_global_pos(Vector2(camera.get_limit(2)/2.0, 0))
	
	set_fixed_process(true)
	set_process_input(true)
	

func _fixed_process(delta):
	
	MoveCharacter(delta)
	
	# Handle player shooting
	var shooting = Input.is_action_pressed("shoot")
	if (shooting and not previous_shooting):
		Shoot()
	previous_shooting = shooting
	
	var attacking = Input.is_action_pressed("attack")
	if (attacking and not previous_attacking):
		Attack()
	previous_attacking = attacking
	
	

func MoveCharacter(delta):
	var camera_limit_left = camera.get_limit(0)
	var camera_limit_right = camera.get_limit(2)
	var sprite_size = (get_node("Sprite").get_item_rect().size[0])
	
	# Adds gravity and make the player jump
	velocity.y += GRAVITY * delta
	if (grounded and Input.is_action_pressed("jump")):
		grounded = false
		velocity.y = -jumpSpeed

	velocity = move_and_slide (velocity, Vector2(0.0,-1.0), 20)
	
#	# Handle player movingsideways
	var movement = 0.0
	var player_pos = get_pos()
	if Input.is_action_pressed("move_left") and (player_pos.x-sprite_size/2 > camera_limit_left):
		movement -= speed
		last_dir = -1
		get_node("Sprite").set_scale(Vector2(-1.0,1.0))
		
	elif Input.is_action_pressed("move_right") and (player_pos.x+sprite_size/2 < camera_limit_right):
		movement += speed
		last_dir = 1
		get_node("Sprite").set_scale(Vector2(1.0,1.0))
	
	velocity.x = lerp (velocity.x, movement, ACCELERATION)   # Interpolates between current and target velocity

func Shoot ():
	var bullet = preload("res://Scenes/bullet.tscn").instance()
	
	get_tree().get_root().add_child(bullet)
	bullet.set_global_pos(shoot_from.get_global_pos())
	bullet.SetDirection (last_dir)

func Attack ():
	print ("Atacar")

func TakeHit (damage):
	health -= damage
	if health <= 0:
		# Respawn
		health = maxHealth
		set_global_pos(Vector2(camera.get_limit(2)/2.0, 0))


func _on_GroundDetector_body_enter( body ):
	grounded = true

func _on_GroundDetector_body_exit( body ):
	grounded = false
