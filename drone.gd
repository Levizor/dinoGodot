extends ObstacleBase


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play()
	pos_y+= 200
	setpos()

func _on_body_entered(body: Node2D):
	if is_game_over(body):
		$AnimatedSprite2D.animation = "boom"
		collision.emit()
