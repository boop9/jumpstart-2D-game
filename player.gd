extends CharacterBody2D

const SPEED := 450.0
const JUMP_VELOCITY := -420.0
@onready var spawn = $"../Spawn"
@onready var camera = find_child("Camera2D")
@onready var end = $"../End"

func _ready():
	pass

func _process(_delta:float) -> void:
	if Input.is_action_just_pressed("reset"):
		var speed = camera.position_smoothing_speed
		camera.position_smoothing_speed = 30
		if spawn:
			self.position = spawn.position
		await get_tree().create_timer(1).timeout;
		camera.position_smoothing_speed = speed



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, 40)
		else:
			velocity.x = move_toward(velocity.x, 0, 50)

	move_and_slide()


func _on_next_level_body_entered(body: Node2D) -> void:
	Global.next_level()
