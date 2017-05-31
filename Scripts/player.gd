extends KinematicBody2D

export var jumpSpeed = 500

onready var bullet_res = preload("res://Scenes/bullet.tscn")

var health
var velocity = Vector2(0.0, 0.0)
var last_dir = 1

var grounded = false
var running = false
var shooting = false

var shotDelay
var shotElapsedTime
var previous_attacking = false

var spawnPosition

var shoot_from
var camera
var health_bar

var animatedSprite

func _ready():
	GlobalVariables.enemyTarget = self
	health = GlobalVariables.playerMaxHealth
	shotDelay = 1.0/float(GlobalVariables.playerBlastRateOfFire)
	shotElapsedTime = shotDelay
	animatedSprite = get_node("Sprite")
	shoot_from = get_node("Sprite/shoot_from")
	camera = get_node("Camera2D")
	health_bar = get_node("/root/main/UI/HealthBar")
	
	set_global_pos(Vector2(800,390))
	
	spawnPosition = get_global_pos()
	
	set_fixed_process(true)
	set_process_input(true)
	OS.set_window_title("The Last Angel")

func _fixed_process(delta):
	MoveCharacter(delta)
	
	# Handle player shooting
	shotElapsedTime += delta
	shooting = Input.is_action_pressed("shoot")
	if (shooting):
		if (running):
			animatedSprite.play("shoot_run")
		else:
			animatedSprite.play("shoot_idle")
		if (shotElapsedTime >= shotDelay):
			Shoot()
			shotElapsedTime = 0
	else:
		shotElapsedTime = shotDelay
	
	var attacking = Input.is_action_pressed("attack")
	if (attacking and not previous_attacking):
		Attack()
	previous_attacking = attacking
	
	

func MoveCharacter(delta):
	#Como tentativa de consertar o flickering do personagem quando ele aterrisa as vezes,
	#eu fiz alguns comentarios nessa função mas não acho que serviram pra ajudar alguma coisa.
	#Então eu só fiz mudar o Collision Margin no inspector mesmo pra o menor valor possível(0.001) e 
	# parece que foi consertado. Eu sei que tem uma razão para que nao coloquemos a margem de erro o minimo possível sempre
	# mas eu não lembro xD (o default é 0.08)
	
	
	velocity.y += GlobalVariables.gravity*delta
	grounded = test_move(Vector2(0,1))
	# Adds gravity and make the player jump
	if (grounded && Input.is_action_pressed("jump")):
		grounded = false
		velocity.y = -jumpSpeed

	var movement = 0
	var scale = animatedSprite.get_scale()
	# Handle player movingsideways
	if Input.is_action_pressed("move_left"):
		movement -= GlobalVariables.playerSpeed
		last_dir = -1
		animatedSprite.set_flip_h(true)
		
	elif Input.is_action_pressed("move_right"):
		movement += GlobalVariables.playerSpeed
		last_dir = 1
		animatedSprite.set_flip_h(false)
	
	
	
	if (movement == 0 || not grounded):
		running = false
		animatedSprite.play("idle")
	else:
		running = true
		if (not shooting):
			animatedSprite.play("run")
	velocity.x = movement
	var motion = velocity * delta
	motion = move (motion)
	if (is_colliding()):
		var n =  get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity) #Qual a necessidade de mudar velocity? Isso pode terminar tendo alguma interação com o velocity.y (velocidade de queda) alterando o velocity.x, como se fosse um escorregador lol
		move(motion)

func Shoot ():
	var bullet = bullet_res.instance()
	get_node('/root/main').add_child(bullet)
	bullet.set_global_pos(shoot_from.get_global_pos())
	bullet.get_node("Sprite").set_flip_h(animatedSprite.is_flipped_h())
	bullet.SetDirection (last_dir)

func Attack ():
	print ("Atacar")

func TakeHit (damage):
	health -= damage
	health_bar.UpdateHealthBar (health, GlobalVariables.playerMaxHealth)
	if (health <= 0):
		# Respawn
		var maxHealth = GlobalVariables.playerMaxHealth
		health = maxHealth
		health_bar.UpdateHealthBar (health, maxHealth)
		Transition.goto_scene("res://Scenes/Screens/gameOver.tscn")

func HealPlayer (amount):
	if (health == 100):
		return false
		
	health += amount
	health = clamp (health, 0, GlobalVariables.playerMaxHealth)
	health_bar.UpdateHealthBar (health, GlobalVariables.playerMaxHealth)
	return true
	
	