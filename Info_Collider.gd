extends StaticBody2D

#Simple info collider

var alreadyInteracted = false
var inBody = false

# Start by hiding the info (Z button) box
func _ready():
	$Sprite2.hide()


# While the player is near the collider (and hasn't interacted with it already),
# a "Z" prompt will hover over the collider
# Once the player has pressed Z, a textbox will play that'll pause the game
# Until it's done.
func _physics_process(delta):
	if alreadyInteracted == false:
		if inBody == true:
			$Sprite2.show()
			if Input.is_action_pressed("ui_interact"):
				#Insert whatever you want in the textbox here
				$Textbox.add_text("Placeholder Text")
				alreadyInteracted = true
	else:
		$Sprite2.hide()
	
	

func _on_ZBox_body_entered(body):
	if "Player" in body.name:
		inBody = true

func _on_ZBox_body_exited(body):
	if "Player" in body.name:
		inBody = false
