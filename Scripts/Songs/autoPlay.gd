extends SamplePlayer

func _ready():
	self.play(self.get_sample_library().get_sample_list()[0])