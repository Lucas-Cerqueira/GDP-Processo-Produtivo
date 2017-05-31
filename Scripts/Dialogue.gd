extends RichTextLabel
#var dialogue = ["Everything we built for ages you just turned to ASHES! How could you?", "Tsc... Aren't you just pathetic? We have used these foolish little creatures since the very beginning.. There's nothing to be sorry for.", "You have been guardian angel of several people and now you just talk like that? You've killed them all! You've slain them all! For what? Tell me!", "Those who don't see existence the way I do, those who choose not to follow me are doomed. That's what I did for...", "You said it yourself: I have been guardian angel several times. I learned that it's a dull task. I have no time for such things.. It is time for me to change how this works..", "You haven't killed us yet! I'm not letting you go. I'll do whatever is in my powers to stop you!", "You don't seem to understand, Gabriel. You are dead.", "Henry... Listen to me...", "Huh?", "You have just been murdered by Michael's Troops. You are in the edge of death, but I can stop it. I can bring you back to life.. I need to.. You are the only hope.. I'm sorry....", "Sorry for wha-", "What is happening to me? Where am I?", "I'm sorry ... This was m ..... last effort ....", "You have to sto.. p ...... my brother.... please save your own........", "......"]
export(String, MULTILINE) var dialogue_text
#export(String, FILE, "*.tscn") var next_scene

var dialogue
var changing_scene = false;
var page= 0
func _ready():
	dialogue = dialogue_text.split('\n')
	var character = dialogue[page][0]
	var text = dialogue[page].substr(2, dialogue[page].length())
	talking (character)
	set_bbcode(text)
	set_visible_characters(0)
	set_process_input(true)
	pass

func _input(event):
	if event.is_action("ui_accept") && event.is_pressed() && not changing_scene:
		if get_visible_characters() > get_total_character_count():
			if page < dialogue.size()-1 :
				page += 1
				var character = dialogue[page][0]
				var text = dialogue[page].substr(2, dialogue[page].length())
				talking (character)
				set_bbcode(text)
				set_visible_characters(0)
			else:
				#Transition.goto_scene(next_scene)
				Transition.goto_next_stage()
				changing_scene = true
		else:
			set_visible_characters(get_total_character_count())

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1)

func talking(char):
	#GABRIEL
	if char == "G":
		get_node("../IconMichael").hide()
		get_node("../LabelMichael").hide()
		get_node("../IconHenry").hide()
		get_node("../LabelHenry").hide()
		get_node("../IconGabriel").show()
		get_node("../LabelGabriel").show()
	#MICHAEL
	elif char == "M":
		get_node("../IconGabriel").hide()
		get_node("../LabelGabriel").hide()
		get_node("../IconHenry").hide()
		get_node("../LabelHenry").hide()
		get_node("../IconMichael").show()
		get_node("../LabelMichael").show()
	#HENRY
	elif char == "H":
		get_node("../IconGabriel").hide()
		get_node("../LabelGabriel").hide()
		get_node("../IconMichael").hide()
		get_node("../LabelMichael").hide()
		get_node("../IconHenry").show()
		get_node("../LabelHenry").show()