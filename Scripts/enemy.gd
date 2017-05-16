extends Node2D

export var maxHealth = 100
export var speed = 200
export var attackDamage = 25
export var attackRange = 10

var health
var velocity = Vector2(0.0, 0.0)
const GRAVITY = 600

var player
var playerSpriteSize
var enemySpriteSize

var animationPlayer

func _ready():
	health = maxHealth
	player = get_node("/root/Tutorial/Player2D")
	playerSpriteSize = player.get_node("Sprite").get_item_rect().size[0]
	enemySpriteSize = get_node("Sprite").get_item_rect().size[0]
	animationPlayer = get_node("AnimationPlayer")
	set_fixed_process(true)

func _fixed_process(delta):
	if (not animationPlayer.is_playing()):
		HuntPlayer(delta)

func HuntPlayer(delta):
	velocity.y += GRAVITY*delta
	
	var movement = 0
	var target_pos = player.get_pos()
	# Player is on the right side of the enemy, so move to the right
	if (target_pos.x-playerSpriteSize/2.0 > get_global_pos().x+enemySpriteSize/2.0):
		movement += speed
		get_node("Sprite").set_scale(Vector2(1.0,1.0))
		
	# Player in on the left side of the enemy, so flip it and move
	# to the left
	elif (target_pos.x+playerSpriteSize/2.0 < get_global_pos().x-enemySpriteSize/2.0):
		movement -= speed
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
		velocity = n.slide(velocity)
		move(motion)

func AttackPlayer():
	if ((player.get_global_pos()-get_node("Sprite").get_global_pos()).length() <= attackRange):
		player.TakeHit (attackDamage)

func TakeHit (damage):
	health -= damage
	if health <= 0:
		set_process(false)
		self.queue_free()

