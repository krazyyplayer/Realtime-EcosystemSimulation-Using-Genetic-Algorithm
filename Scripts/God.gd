extends KinematicBody
var speed = 7 
var acceleration = 20
var gravity = 0
var jump = 5
var mouse_on = false
var mouse_sensitivity = 0.5

var direction = Vector3()
var velocity = Vector3()
var fall= Vector3()
onready var head = $Head
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if event is InputEventMouseMotion and not mouse_on:
		rotate_y(deg2rad(-event.relative.x*mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y*mouse_sensitivity))
		#head.rotation.x = clamp(head.rotation.x,deg2rad(180),deg2rad(360))

func _process(delta):
	direction = Vector3()
	
	if not is_on_floor():
		fall.y -=gravity*delta
		
	if(Input.is_action_just_pressed("jump")):
		fall.y=jump
	if(Input.is_action_just_pressed("ui_cancel")):
		if not mouse_on:
			mouse_on=true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			mouse_on=false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if(Input.is_action_pressed("move_forward")):
		direction-=transform.basis.z
	elif(Input.is_action_pressed("move_backward")):
		direction+=transform.basis.z
	
	if(Input.is_action_pressed("move_left")):
		direction-=transform.basis.x
	elif(Input.is_action_pressed("move_right")):
		direction+=transform.basis.x
		
	direction = direction.normalized()
	
	velocity = velocity.linear_interpolate(direction*speed,acceleration*delta)
	
	velocity = move_and_slide(velocity,Vector3.UP)
	move_and_slide(fall,Vector3.UP)
		
