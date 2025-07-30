extends Area2D

@export_enum("Purple","Pink") var team : String



func switch(node : Node):
	if Global.switchState == true:
		if node.team == "Pink":
			Global.fade_out(node)
			set_collision_mask_value(2,false)
		else:
			Global.fade_in(node)
			set_collision_mask_value(2,true)
	else:
		if node.team == "Pink":
			Global.fade_in(node)
			set_collision_mask_value(2,true)
		else:
			Global.fade_out(node)
			set_collision_mask_value(2,false)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	switch(self)
