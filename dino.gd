extends CharacterBody2D

var gravity = 9000
var jump_speed = -2600

func _ready() -> void:
	$AnimatedSprite2D.play()

func _process(_delta: float) -> void:
	if is_on_floor() and Input.is_action_pressed("Jump"):
		jump()
		
func set_texture(texture: String):
	$AnimatedSprite2D.animation = texture
		
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	move_and_slide()
	
func jump():
	$JumpSound.play()
	velocity.y = jump_speed
