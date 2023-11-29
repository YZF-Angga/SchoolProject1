extends CharacterBody2D


@export var move_speed : float = 210
@export var starting_directing: Vector2 = Vector2(0,1 )

#paramaters/idle/blend_position

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

func _ready():
	update_animation_parameter(starting_directing)

func _physics_process(delta):
	#get input direction 
	var input_direction = Vector2(
		Input.get_action_strength("kanan") - Input.get_action_strength("kiri"),
		Input.get_action_strength("bawah") - Input.get_action_strength("atas")
	)
	
	if Input.is_action_just_pressed("Exit"):
		get_tree().change_scene_to_file("res://UI/mainmenu.tscn")
	
	update_animation_parameter(input_direction)
	
	
	velocity = input_direction * move_speed
	
	
	move_and_slide()
	
	pick_new_state()

func update_animation_parameter(move_input : Vector2):
	#don't change animation parameter if there are no move_input
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/walk/blend_position", move_input)
		animation_tree.set("parameters/idle/blend_position", move_input)


func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")

