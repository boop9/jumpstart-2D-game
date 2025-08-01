extends AnimatableBody2D

@export_enum("Purple","Pink") var team : String
@export var fadeable : bool = false

func _ready():
	pass

func _process(delta:float):
	Global.switch_alt(self,1)

func fade(time):
	pass
func _on_fading_platform_area_2d_body_entered(body: Node2D) -> void:
	if body == self:
		for speed in range(0.5,10):
			Global.fade_out(self,speed)
			print("fading in")
			await get_tree().create_timer(0.15/speed).timeout
			Global.fade_in(self,speed)
			await get_tree().create_timer(0.15/speed).timeout
