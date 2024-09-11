extends Node



@export var run_speed: float = 4
@export var score: float = 0 
@export var high_score: int
const SAVE_PATH = "user://high_score.ini"

func save_high_score():
	var config = ConfigFile.new()
	config.set_value("high_score", "high_score", high_score)
	config.save(SAVE_PATH)
	
func load_high_score():
	var config = ConfigFile.new()
	config.load(SAVE_PATH)
		
	high_score=config.get_value("high_score", "high_score", 0) 
