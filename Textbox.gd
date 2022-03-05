extends CanvasLayer

#Adjust the read rate of the textbox here
const READ_RATE = 0.2

#vars for easy access to the nodes
onready var textbox_container = $TextboxContainer
onready var symbol = $TextboxContainer/MarginContainer/HBoxContainer/Symbol
onready var text = $TextboxContainer/MarginContainer/HBoxContainer/Text


func _ready():
	hide_textbox()

#Resets the textbox and hides the container
func hide_textbox():
	symbol.text = ""
	text.text = ""
	textbox_container.hide()

#Shows the textbox and pauses the game
func show_textbox():
	symbol.text = "*"
	textbox_container.show()
	get_tree().paused = true

# Add text and read it based on the read rate
func add_text(next_text):
	text.text = next_text
	show_textbox()
	$Tween.interpolate_property(text, "percent_visible", 0.0, 1.0, len(next_text) * READ_RATE, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

# Unpause the game after the text is fully read
func _on_Tween_tween_completed(object, key):
	get_tree().paused = false
	$Timer.start()
	

# Hide the textbox after x seconds (check the timer node)
func _on_Timer_timeout():
	hide_textbox()
