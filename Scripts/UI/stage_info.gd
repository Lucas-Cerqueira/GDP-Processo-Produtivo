extends Label


func _ready():
	var stage = get_node("/root/changeScene").current_stage
	if (stage == 0):
		self.hide()
	else:
		self.show()
		self.text = "Stage " + str(stage)
