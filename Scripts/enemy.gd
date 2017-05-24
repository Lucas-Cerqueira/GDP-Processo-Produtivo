extends Node2D

export var attackRange = 10

var health
var velocity = Vector2(0.0, 0.0)

var player
var playerSpriteSize
var enemySpriteSize

var target

onready var lazinessParticles = get_node("LazinessParticles")
onready var GlobalVariables = get_node("/root/GlobalVariables")
var animationPlayer

func _ready():
	health = GlobalVariables.enemyMaxHealth
	enemySpriteSize = get_node("Sprite").get_item_rect().size[0]
	animationPlayer = get_node("AnimationPlayer")
	set_fixed_process(true)

func _fixed_process(delta):
	target = GlobalVariables.enemyTarget
	
	if (not animationPlayer.is_playing()):
		HuntTarget(delta)
	
	if (GlobalVariables.laziness_active):
		lazinessParticles.set_emitting(true)
	else:
		lazinessParticles.set_emitting(false)

func HuntTarget(delta):
	velocity.y += GlobalVariables.gravity*delta
	
	var movement = 0
	var target_pos = target.get_pos()
	var delta_x = target_pos.x - get_global_pos().x
	
	# Flip the enemy sprite based on target position
	if (delta_x > 0):
		set_scale(Vector2(1.0,1.0))
	else:
		set_scale(Vector2(-1.0,1.0))
	
	if (abs(delta_x) >= GlobalVariables.enemyAttackRange):
		# Move to the right of left based on target position if not in range
		movement += GlobalVariables.enemySpeed * (delta_x/abs(delta_x))
	else:
		movement = 0
		if (target.get_name() == "Player2D"):
			animationPlayer.play("enemy_attack")

	velocity.x = movement
	var motion = velocity * delta
	motion = move (motion)
	if (is_colliding()):
		var n =  get_collision_normal()
		motion = n.slide(motion)
		move(motion)

func AttackTarget():
	if ((target.get_global_pos()-get_node("Sprite").get_global_pos()).length() <= attackRange):
		if (target.has_method("TakeHit")):
			target.TakeHit (GlobalVariables.enemyAttackDamage)

func TakeHit (damage):
	health -= damage
	if health <= 0:
		#Antes aqui estava com set_process, o que não fazia nada já que aqui usamos fixed_process ~~
		get_node("/root/main/WaveHandler").EnemyKilled()
		set_fixed_process(false)
		queue_free()

