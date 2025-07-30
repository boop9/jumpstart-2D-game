extends Node

var switchState = true
var levels: Dictionary = {
	"1" = "res://Levels/Level1.tscn",
	"2" = "res://Levels/Level2.tscn"
}



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("switch"):
		switchState = not switchState

func next_level():
	var currentSceneFile = get_tree().current_scene.scene_file_path
	var nextLevelNumber = currentSceneFile.to_int() + 1
	
	var nextLevelPath = "res://Levels/Level" + str(nextLevelNumber) + ".tscn"
	print ("switching to Level ", nextLevelNumber," at ",nextLevelPath)
	get_tree().change_scene_to_file(nextLevelPath)

func fade_out(node):
	var tween = get_tree().create_tween()
	tween.tween_property(node, "modulate:a", 0.25, 0.15)
	tween.play()
	await tween.finished
	tween.kill()

func fade_in(node):
	var tween = get_tree().create_tween()
	tween.tween_property(node, "modulate:a", 1, 0.15)
	tween.play()
	await tween.finished
	tween.kill()

func switch(node : Node):
	if switchState == true:
		if node.team == "Pink":
			fade_out(node)
			node.collision_enabled = false
		else:
			fade_in(node)
			node.collision_enabled = true
	else:
		if node.team == "Pink":
			fade_in(node)
			node.collision_enabled = true
		else:
			fade_out(node)
			node.collision_enabled = false
