extends AnimatableBody2D

@export_enum("Purple","Pink") var team : String
@export var fadeable : bool = false

func _ready():
	pass

func _process(delta:float):
	Global.switch_alt(self,1)

func fade(time):
	pass


func _on_fade_animation_finished(anim_name: StringName) -> void:
	self.set_collision_layer_value(1,true)


func _on_fade_animation_started(anim_name: StringName) -> void:
	await get_tree().create_timer(5.4).timeout
	self.set_collision_layer_value(1, false)
	
