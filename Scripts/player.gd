extends KinematicBody2D

export var maxHealth = 100
export var speed = 100
export var ACCELERATION = 0.5
export var GRAVITY = 500
export var jumpSpeed = 500

onready var bullet_res = preload("res://Scenes/bullet.tscn")

var health
var velocity = Vector2(0.0, 0.0)
var last_dir = 1

var grounded = false

var previous_shooting = false
var previous_attacking = false

var spawnPosition

var shoot_from
var camera
var health_bar

func _ready():
	health = maxHealth
	shoot_from = get_node("Sprite/shoot_from")
	camera = get_node("Camera2D")
	health_bar = get_node("/root/main/UI/HealthBar")
	
	spawnPosition = get_global_pos()
	
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
	#Como tentativa de consertar o flickering do personagem quando ele aterrisa as vezes,
	#eu fiz alguns comentarios nessa função mas não acho que serviram pra ajudar alguma coisa.
	#Então eu só fiz mudar o Collision Margin no inspector mesmo pra o menor valor possível(0.001) e 
	# parece que foi consertado. Eu sei que tem uma razão para que nao coloquemos a margem de erro o minimo possível sempre
	# mas eu não lembro xD (o default é 0.08)
	
	
	#Em vez de armazenar uma variavel grounded, ve se nao acha melhor usar test_move( Vector2(0,1) ) 
	#E entao só adicionar GRAVITY à velocity.y caso test_move retornasse false (quando não encontra chão)
	#Assim elimina também a necessidade do ground detector
	
	velocity.y += GRAVITY*delta
	grounded = test_move(Vector2(0,1))
	# Adds gravity and make the player jump
	if (grounded && Input.is_action_pressed("jump")):
		grounded = false
		velocity.y = -jumpSpeed

	var movement = 0
	var scale = get_node("Sprite").get_scale()
	# Handle player movingsideways
	if Input.is_action_pressed("move_left"):
		movement -= speed
		last_dir = -1
		
		get_node("Sprite").set_scale(Vector2(-abs(scale.x),scale.y))
		
	elif Input.is_action_pressed("move_right"):
		movement += speed
		last_dir = 1
		get_node("Sprite").set_scale(Vector2(abs(scale.x),scale.y))
	
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
	
	get_tree().get_root().add_child(bullet)
	bullet.set_global_pos(shoot_from.get_global_pos())
	bullet.SetDirection (last_dir)

func Attack ():
	print ("Atacar")

func TakeHit (damage):
	health -= damage
	health_bar.UpdateHealthBar (health, maxHealth)
	if health <= 0:
		# Respawn
		health = maxHealth
		health_bar.UpdateHealthBar (health, maxHealth)
		set_global_pos(spawnPosition)