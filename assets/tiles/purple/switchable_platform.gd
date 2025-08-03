extends Sprite2D

@export_enum("Purple","Pink") var team : String

@onready var switchablePlatformCollider = $StaticBody2D

func _process(delta:float):
	Global.switch_alt(self,1,switchablePlatformCollider)
