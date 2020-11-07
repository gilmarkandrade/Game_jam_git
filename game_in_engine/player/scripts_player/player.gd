extends KinematicBody

var move = Vector3()
var speed = 1.2
var max_speed = 30
var global_direction = Vector3(0,0,1)
var local_direction = global_direction.rotated(Vector3(0,1,0), rotation.y)
onready var cam = get_node("Camera")

var sens = 0.2

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		var movement = event.relative
		cam.rotation.x += -deg2rad(movement.y * sens)
		#cam.rotation.x = clamp(cam.rotation.x, deg2rad(-90), deg2rad(90))
		rotation.y += -deg2rad(movement.x * sens)
		#rotate_y(deg2rad(-movement.x * sens))
		
		
func _physics_process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()

	 
	
	if Input.is_action_pressed("ui_move_impulse"):
		local_direction = global_direction.rotated(Vector3(0,1,0), rotation.y)
		move = local_direction * (speed*15)
			
		
		move.y = 0
	
	elif Input.is_action_pressed("ui_move_left"):
		
		if move.x < max_speed:
			move.x += speed
		else:
			move.x = + max_speed
	
	elif Input.is_action_pressed("ui_move_right"):
		
		if move.x > -max_speed:
			move.x -= speed
		else:
			move.x = - max_speed
	
	elif Input.is_action_pressed("ui_move_cima"):
		
		if move.y < max_speed:
			move.y += speed
		else:
			move.y = + max_speed
	
	elif Input.is_action_pressed("ui_move_down"):
		
		if move.y > -max_speed:
			move.y -= speed
		else:
			move.y = - max_speed
			
	else:
		
		if  move.z > 0:
			move.z -= 0.3
				
		elif  move.z < 0:
			move.z += 0.3
			
		if move.x > 0:
			move.x -= 0.3
			
		elif move.x < 0:
			move.x += 0.3
			
		if move.y < 0:
			move.y += 0.3
			
		elif move.y > 0:
			move.y -= 0.3
			
		else:
			move = Vector3(0,0,0)
			
	print(global_transform.origin)
	move = move_and_slide(move)
