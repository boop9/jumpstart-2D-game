extends AnimatableBody2D

@export_enum("Purple","Pink") var team : String
@export var fadeable : bool = false

func _ready():
	pass

func _process(delta:float):
	Global.switch_alt(self,1)

func fade(time):
	pass


func _on_platform_fade_animation_finished(anim_name: StringName) -> void:
	self.visible = false
