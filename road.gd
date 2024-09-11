extends Node2D

@export var texture_width: float

func _ready() -> void:
	texture_width = $RoadTexture.get_rect().size[0]*$RoadTexture.transform.get_scale()[0]



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position[0] < -texture_width/2:
		position[0]=position[0]+texture_width/2
	move_local_x(-200*delta*Globals.run_speed)
