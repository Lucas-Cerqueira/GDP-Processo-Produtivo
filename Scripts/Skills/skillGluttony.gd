extends Node

onready var food_res = preload("res://Scenes/food.tscn")


func Activate(index):
	if (GlobalVariables.skillAvailable[index] && GlobalVariables.skillCharges[index] > 0):
		var x = randi()%100
		if (GlobalVariables.skillAvailable[4] && x < GlobalVariables.avarice_chance):
			get_parent().get_parent().TakeHit(GlobalVariables.avarice_health_penalty)
		else:
			GlobalVariables.skillCharges[index] -= 1
		get_child(0).start()
		
		#Generates an integer from 3 to 5
		randomize()
		var amount = randi(3,5)%3 + 3
		SpawnFood(amount)


func SpawnFood (amount):
	var sector_size = 1500/float(amount)
	print ("Amount: " + str(amount))
	for i in range(1,amount+1):
		var food = food_res.instance()
		var pos_x = rand_range (sector_size*(i-1)+20, sector_size*i-20)
		food.set_global_pos(Vector2(pos_x, 410))
		get_node('/root/main').add_child(food)
	


func _on_skillDuration_timeout():
	get_child(0).stop()
