extends Area2D

export var healAmount = 10
var spriteArray = ["res://Sprites/Food/bread.png", 
                   "res://Sprites/Food/hamburger.png", 
                   "res://Sprites/Food/pancake.png"]

var animPlayer

func _ready():
	set_enable_monitoring(false)
	animPlayer = get_node("AnimationPlayer")
	animPlayer.play("fall_food")
	randomize()
	var i = randi()%spriteArray.size()
	get_node("Sprite").set_texture(load(spriteArray[i]))
	set_process(true)

func _process(delta):
	if (not animPlayer.is_playing()):
		set_enable_monitoring(true)


func _on_Area2D_body_enter( body ):
	if (body.get_name() == "Player2D"):
		if (body.HealPlayer(healAmount)):
			queue_free()
