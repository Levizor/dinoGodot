extends Area2D

class_name ObstacleBase


@export var pos_y: float 

signal collision
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setpos();
	

func setpos() -> void:
	var width = get_viewport_rect().size[0]
	position = Vector2(width+500, pos_y)

	
func is_game_over(body: Node2D) -> bool:
	return body.name == "Dino"

func game_over() -> void:
	Globals.game_over = true

func _on_body_entered(body: Node2D) -> void:
	if(is_game_over(body)):
		collision.emit()
		

		
