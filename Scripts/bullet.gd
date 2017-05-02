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

func _on_Area2D_area_enter( area ):
	if (hit == true):
		return
	
	hit = true
	print ("Deu dano")
	area.get_parent().Take_hit(bullet_damage)
	set_process(false)
	self.queue_free()


func _on_bullet_Timer_timeout():
	set_process(false)
	self.queue_free()
