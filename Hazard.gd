extends Node2D


func _ready():
	pass

# Reload the scene once the player touches the hazardous collider
func _on_Area2D_body_entered(body):
	if "Player" in body.name:		
		get_tree().reload_current_scene()
