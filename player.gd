extends CharacterBody2D

const SPEED := 450.0
const JUMP_VELOCITY := -400
@onready var spawn = $"../Spawn"
@onready var camera = find_child("Camera2D")
@onready var end = $"../End"
@onready var animated_sprite = $AnimatedSprite2D
@onready var animationplayer = $"../move_solid_platforms"
@onready var fade_animationplayer = $"../fade"
@onready var platformVel = Vector2(0,0)
@onready var jumpedOnPlatform = false 
@onready var amountoftimessteppedonfadingplatform = 0
@onready var areasInside = 0
@onready var Level4 = %Level4

func load_switchable_areas():
	print("loading switchable areas")
	var SwitchableArea2Ds = get_tree().get_nodes_in_group("Switchable_Areas")
	print(SwitchableArea2Ds)
	for area in SwitchableArea2Ds:
		area.body_entered.connect(Callable(self,"_on_switchable_area_entered"))
		area.body_exited.connect(Callable(self,"_on_switchable_area_exited"))
		print("connected with", area)


#stops switching if player is inside switchable object
func _on_switchable_area_entered(body):
	await get_tree().create_timer(0.2).timeout;
	if body == self:
		# counts the amount of switchable objects the player is currently in
		areasInside += 1
		Global.insideSwitchableObject = true

func _on_switchable_area_exited(body):
	if body == self:
		# minuses amount when player leaves object
		areasInside -= 1
		# only re-enables switching if the player is not inside any objects
		if areasInside == 0:
			Global.insideSwitchableObject = false

func _ready():
	await get_tree().create_timer(1).timeout;
	call_deferred("load_switchable_areas")


func reset_old():
	self.position = spawn.position
	Global.switchState = true
	Global.reset_count += 1

func reset():
	var speed = camera.position_smoothing_speed
	camera.position_smoothing_speed = 30
	if spawn:
		self.position = spawn.position
	await get_tree().create_timer(1).timeout;
	camera.position_smoothing_speed = speed
#	Global.switchState = true
	Global.reset_count += 1
	Global.insideSwitchableObject = false

func _process(_delta:float) -> void:
	if Input.is_action_just_pressed("reset"):
		reset()
	
	# animations based on whether or not player is jumping or walking
	if is_on_floor():
		if Input.is_action_pressed("right"):
			animated_sprite.flip_h = false
			animated_sprite.play("run")
#			print("run right")
		elif Input.is_action_pressed("left"):
			animated_sprite.flip_h = true
			animated_sprite.play("run")
#			print("run left")
		else:
			animated_sprite.play("still")
	else:
		if Input.is_action_pressed("right"):
			animated_sprite.flip_h = false
			animated_sprite.play("jump")
#			print("jump right")
		elif Input.is_action_pressed("left"):
			animated_sprite.flip_h = true
			animated_sprite.play("jump")
#			print("jump left")



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		#checks if what you're jumping on is a platform
		if platformVel != Vector2(0,0):
			jumpedOnPlatform = true
			print("jumping on platform")
		else: 
			jumpedOnPlatform = false
		
		velocity.y = JUMP_VELOCITY


	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
			velocity.x = direction * SPEED
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, 40)
		else:
			velocity.x = move_toward(velocity.x, 0, 50)
			
	
	move_and_slide()
	platformVel = get_platform_velocity()


func _on_next_level_body_entered(body: Node2D) -> void:
	if get_tree().current_scene != Level4:
		Global.next_level()

func _on_fading_platform_area_2d_body_entered(body: Node2D) -> void:
	amountoftimessteppedonfadingplatform += 1
	if not animationplayer.is_playing():
		if body == self:
			animationplayer.play("move_solid/move_solid")
	if not fade_animationplayer.is_playing():
		if body == self:
			fade_animationplayer.play("fade/fade")

func die():
	reset()
	Global.death_count += 1
	print ("deaths: ", Global.death_count)

func _on_killzone_body_entered(body: Node2D) -> void:
	if body == self:
		die()
#		print("died to killzone")

func _on_spike_body_entered(body: Node2D) -> void:
	if body == self:
		die()
#		print("died to spike")
