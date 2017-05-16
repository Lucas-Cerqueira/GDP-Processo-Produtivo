extends Node2D

export var bullet_speed = 300
export var bullet_damage = 25

var direction = 1
var hit = false

func _ready():
	set_process(true)

func _process(delta):
	translate (Vector2(bullet_speed*delta*direction, 0))

func  SetDirection (d):
	if (d == 1 or d == -1):
		direction = d

func _on_Area2D_body_enter( body ):
	if (hit == true):
		return
	
	hit = true
	body.TakeHit(bullet_damage)
	set_process(false)
	self.queue_free()

func _on_VisibilityNotifier2D_exit_viewport( viewport ):
	#print ("Bullet destroyed")
	set_process(false)
	self.queue_free()


func _on_bulletLifeTime_timeout():
	pass
	#set_process(false)
	#self.queue_free()
