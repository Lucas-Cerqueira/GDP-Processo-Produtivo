extends Node2D

var enemyType = "medium"

var health
var maxHealth
var speed
var attackDamage
var attackRange
var velocity = Vector2(0.0, 0.0)

var player
var playerSpriteSize
var enemySpriteSize

var target

var samplePlayer
var bloodParticles
var lazinessParticles
onready var GlobalVariables = get_node("/root/GlobalVariables")
var animationPlayer
var animatedSprite

func _ready():
	samplePlayer = get_node("SamplePlayer2D")
	bloodParticles = get_node("Sprite/BloodParticles")
	lazinessParticles = get_node("LazinessParticles")

	if (enemyType == "medium"):
		maxHealth = GlobalVariables.mEnemyMaxHealth
		attackRange = GlobalVariables.mEnemyAttackRange
	else:
		maxHealth = GlobalVariables.bEnemyMaxHealth
		attackRange = GlobalVariables.bEnemyAttackRange
	health = maxHealth
	animatedSprite = get_node("Sprite")
	enemySpriteSize = animatedSprite.get_item_rect().size[0]
	animationPlayer = get_node("AnimationPlayer")
	set_fixed_process(true)

func _fixed_process(delta):
	if (enemyType == "medium"):
		speed = GlobalVariables.mEnemySpeed
		attackDamage = GlobalVariables.mEnemyAttackDamage
	else:
		speed = GlobalVariables.bEnemySpeed
		attackDamage = GlobalVariables.bEnemyAttackDamage
		
	
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
		lazinessParticles.set_scale(Vector2(1.0,1.0))
	else:
		set_scale(Vector2(-1.0,1.0))
		lazinessParticles.set_scale(Vector2(-1.0,1.0))
	
	if (abs(delta_x) >= attackRange):
		# Move to the right of left based on target position if not in range
		movement += speed * (delta_x/abs(delta_x))
	else:
		movement = 0
		if (target.get_name() == "Player2D"):
			animationPlayer.play("enemy_attack")

	if (movement == 0):
		animatedSprite.play("idle")
	else:
		animatedSprite.play("run")

	velocity.x = movement
	var motion = velocity * delta
	motion = move (motion)
	if (is_colliding()):
		var n =  get_collision_normal()
		motion = n.slide(motion)
		move(motion)

func AttackTarget():
	if ((target.get_global_pos()-animatedSprite.get_global_pos()).length() <= attackRange):
		if (target.has_method("TakeHit")):
			target.TakeHit (attackDamage)

func TakeHit (hit):
	health -= hit
	bloodParticles.set_emitting(false)
	bloodParticles.set_emitting(true)
	if (samplePlayer):
		samplePlayer.play("melee_strike")
	if health <= 0:
		#Antes aqui estava com set_process, o que não fazia nada já que aqui usamos fixed_process ~~
		var waveHandler = get_node("/root/main/WaveHandler")
		if (waveHandler):
			waveHandler.EnemyKilled()
		set_fixed_process(false)
		lazinessParticles.set_emitting(false)
		animationPlayer.play("enemyDeath")
