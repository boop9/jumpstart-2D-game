extends Node

var switchState = true
var levels: Dictionary = {
	"1" = "res://Levels/Level1.tscn",
	"2" = "res://Levels/Level2.tscn"
}
var death_count = 0
var reset_count = 0
var insideSwitchableObject = false
var start_time = 0
var end_time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_user_signal("fade_in_completed")
	add_user_signal("fade_out_completed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	print(switchState)
	if Input.is_action_just_pressed("switch"):
			switchState = not switchState
			
	if insideSwitchableObject == true:
		print("inside switchable object")
	else:
		print("not inside")

func next_level():
	var currentSceneFile = get_tree().current_scene.scene_file_path
	var nextLevelNumber = currentSceneFile.to_int() + 1
	
	var nextLevelPath = "res://Levels/Level" + str(nextLevelNumber) + ".tscn"
	print ("switching to Level ", nextLevelNumber," at ",nextLevelPath)
	switchState = true
	get_tree().change_scene_to_file(nextLevelPath)

func fade_out(node, speed = 1):
	var faded_out = false
	var tween = get_tree().create_tween()
	tween.tween_property(node, "modulate:a", 0.25, 0.15/speed)
	tween.play()
	await tween.finished
	tween.kill()
	faded_out = true

func fade_in(node, speed = 1):
	var faded_in = false
	var tween = get_tree().create_tween()
	tween.tween_property(node, "modulate:a", 1, 0.15/speed)
	tween.play()
	await tween.finished
	tween.kill()
	emit_signal("fade_in_completed")
	faded_in = true

func switch(node : Node):
#	if insideSwitchableObject == false:
#		print("switched")
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

func switch_alt(node : Node,layer:int,collidernode:Node = node):
#	if insideSwitchableObject == false:
#		print("switched")
		if Global.switchState == true:
			if node.team == "Pink":
				Global.fade_out(node)
				if collidernode != node:	
					collidernode.set_collision_layer_value(layer,false)
				else:
					node.set_collision_layer_value(layer,false)
			elif node.team == "Purple":
				Global.fade_in(node)
				if collidernode != node:	
					collidernode.set_collision_layer_value(layer,true)
				else:
					node.set_collision_layer_value(layer,true)
		else:
			if node.team == "Pink":
				Global.fade_in(node)
				if collidernode != node:	
					collidernode.set_collision_layer_value(layer,true)
				else:
					node.set_collision_layer_value(layer,true)
			elif node.team == "Purple":
				Global.fade_out(node)
				if collidernode != node:	
					collidernode.set_collision_layer_value(layer,false)
				else:
					node.set_collision_layer_value(layer,false)
