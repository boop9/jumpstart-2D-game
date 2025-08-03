extends Node2D

@onready var label = $Label


func _ready() -> void:
	Global.end_time = Time.get_unix_time_from_system()
	var time_taken_minutes = int((Global.end_time - Global.start_time) / 60)
	var time_taken_seconds = int((Global.end_time - Global.start_time) - (time_taken_minutes * 60))
	label.set_text("thank you for playing!!!! :) \n \n press R to restart \n \n deaths: " + str(Global.death_count)  + "\n" + " resets: " + str(Global.reset_count)+ "\n" + " time taken: " + str(time_taken_minutes) + ":" + str(time_taken_seconds))

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		get_tree().change_scene_to_file("res://Levels/Level1.tscn")
		Global.death_count = 0
		Global.reset_count = 0
