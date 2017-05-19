extends Node2D

export var attackRange = 10

var health
var velocity = Vector2(0.0, 0.0)

var player
var playerSpriteSize
var enemySpriteSize

onready var lazinessParticles = get_node("LazinessParticles")
onready var GlobalVariables = get_node("/root/GlobalVariables")
var animationPlayer

func _ready():
	health = GlobalVariables.enemyMaxHealth
	player = get_node("/root/main/Player2D")
	playerSpriteSize = player.get_node("Sprite").get_item_rect().size[0]
	enemySpriteSize = get_node("Sprite").get_item_rect().size[0]
	animationPlayer = get_node("AnimationPlayer")
	set_fixed_process(true)

func _fixed_process(delta):
	if (not animationPlayer.is_playing()):
		HuntPlayer(delta)
	
	if (GlobalVariables.laziness_active):
		lazinessParticles.set_emitting(true)
	else:
		lazinessParticles.set_emitting(false)

func HuntPlayer(delta):
	velocity.y += GlobalVariables.gravity*delta
	
	var movement = 0
	var target_pos = player.get_pos()
	# Player is on the right side of the enemy, so move to the right
	if (target_pos.x-playerSpriteSize/2.0 > get_global_pos().x+enemySpriteSize/2.0):
		movement += GlobalVariables.enemySpeed
		get_node("Sprite").set_scale(Vector2(1.0,1.0))
		
	# Player in on the left side of the enemy, so flip it and move
	# to the left
	elif (target_pos.x+playerSpriteSize/2.0 < get_global_pos().x-enemySpriteSize/2.0):
		movement -= GlobalVariables.enemySpeed
		get_node("Sprite").set_scale(Vector2(-1.0,1.0))

	# Attack
	else:
		movement = 0
		animationPlayer.play("enemy_attack")
	
	velocity.x = movement
	var motion = velocity * delta
	motion = move (motion)
	if (is_colliding()):
		var n =  get_collision_normal()
		motion = n.slide(motion)
		move(motion)

func AttackPlayer():
	if ((player.get_global_pos()-get_node("Sprite").get_global_pos()).length() <= attackRange):
		player.TakeHit (GlobalVariables.enemyAttackDamage)

func TakeHit (damage):
	health -= damage
	if health <= 0:
		#Antes aqui estava com set_process, o que não fazia nada já que aqui usamos fixed_process ~~
		get_node("/root/main/WaveHandler").EnemyKilled()
		set_fixed_process(false)
		queue_free()

