extends Node2D

var obstacles = []
var drone = load("res://drone.tscn")
var rng = RandomNumberGenerator.new()
var pit = load("res://pit.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.run_speed=4
	Globals.score=0
	Globals.load_high_score()
	get_tree().call_group("scores", "set_high_score", str(Globals.high_score))
	obstacles.append(load("res://bush.tscn"))
	obstacles.append(load("res://bench.tscn"))
	obstacles.append(load("res://trash.tscn"))
	$Dino.jump()

func _process(delta: float) -> void:
	for obstacle in $Obstacles.get_children():
		obstacle.move_local_x(-200*delta*Globals.run_speed)
	Globals.score+=delta*Globals.run_speed
		
func _on_obstacle_timer_timeout() -> void:
	$"Timers/Obstacle Timer".wait_time = rng.randf_range(0.7, 1.2)
	var obstacle
	if $"Timers/Obstacle Timer".wait_time>1 and Globals.run_speed>10:
		var pos: float
		var prev_width: float = 0
		var cur_width: float
		for i in rng.randi_range(2, 3):
			var rand = rng.randf_range(0, obstacles.size())
			obstacle = obstacles[rand].instantiate()
			obstacle.connect('collision', _on_obstacle_collision)
			$Obstacles.add_child(obstacle)
			
			var sprite = obstacle.get_node("Sprite2D") as Sprite2D
			cur_width = sprite.texture.get_size().x*obstacle.scale.x
			if i != 0:
				obstacle.position.x=pos+prev_width/2+cur_width/2+10
				
			prev_width = cur_width

			pos=obstacle.position.x
		return
			
	if(rng.randi()%3==0) and Globals.run_speed>7:
		obstacle=drone.instantiate()
	elif rng.randi()%3==0 and Globals.run_speed>9:
		obstacle = pit.instantiate()
	else:
		var rand = rng.randf_range(0, obstacles.size())
		obstacle = obstacles[rand].instantiate()
	
	obstacle.connect('collision', _on_obstacle_collision)
	$Obstacles.add_child(obstacle)
	 
	
	
func _on_score_updater_timeout() -> void:
	$Scores/Score.text=str(int(Globals.score))

func _on_obstacle_destroyer_area_entered(area: Area2D) -> void:
	$Obstacles.remove_child(area)
	area.queue_free()
	
func _on_acceleration_timer_timeout() -> void:
	Globals.run_speed+=1
	if Globals.run_speed>10h:
		$Timers/AccelerationTimer.queue_free()
		
func _on_obstacle_collision():
	$Dino.set_texture("over")
	get_tree().paused=true
	if Globals.score>Globals.high_score:
		Globals.high_score=int(Globals.score)
		Globals.save_high_score()
	$Scores/B.visible=false
	$Scores/Score.visible=false
	$Scores/GameOver.visible=true
	
