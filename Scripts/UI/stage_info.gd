extends Label


func _ready():
	var stage = Transition.current_stage
	if (stage == 0):
		self.hide()
	else:
		self.show()
		self.text = "Stage " + str(stage)
