extends Node
@export_enum("Purple","Pink") var team : String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func switch(team):
	if Global.switchState == true:
		if team == "Pink":
			self.self_modulate = Color(1,1,1,0.25)
			self.collision_enabled = false
		else:
			self.self_modulate = Color(1,1,1,1)
			self.collision_enabled = true
	else:
		if team == "Pink":
			self.self_modulate = Color(1,1,1,1)
			self.collision_enabled = true
		else:
			self.self_modulate = Color(1,1,1,0.25)
			self.collision_enabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	switch(team)
