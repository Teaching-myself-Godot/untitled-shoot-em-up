extends Node3D

const MAX_X_VELOCITY = 40
const MAX_Z_VELOCITY = 40

var x_velocity = 0
var z_velocity = 0
var init_thruster_size = 0.28

signal shoot_bullet(origin_pos : Vector3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var left_is_pressed = false
	var right_is_pressed = false
	var down_is_pressed = false
	var up_is_pressed = false
	if Input.is_action_pressed("click"):
		var cts_size = Vector2(get_viewport().content_scale_size)
		var position2D = get_viewport().get_mouse_position()
		var factorVec2 = (position2D - (cts_size * 0.5)) / cts_size
		var mouse_pos = factorVec2 * Vector2(24, 48) - Vector2(0, 22)
		if mouse_pos.x < position.x - 0.1:
			left_is_pressed = true
		elif mouse_pos.x > position.x + 0.1:
			right_is_pressed = true
		if mouse_pos.y < position.z - 0.1:
			up_is_pressed = true
		elif mouse_pos.y > position.z + 0.1:
			down_is_pressed = true


	if right_is_pressed or Input.is_action_pressed("ui_right"):
		rotation.z -= deg_to_rad(2)
		if x_velocity < MAX_X_VELOCITY:
			x_velocity += 2
	elif left_is_pressed or Input.is_action_pressed("ui_left"):
		rotation.z += deg_to_rad(2)
		if x_velocity > -MAX_X_VELOCITY:
			x_velocity -= 2
	else:
		if rotation.z > 0:
			rotation.z -= deg_to_rad(2)
		elif rotation.z < 0:
			rotation.z += deg_to_rad(2)
#		if x_velocity > 0:
#			x_velocity -= 2
#		elif x_velocity < 0:
#			x_velocity += 2
		x_velocity = 0

	if up_is_pressed or Input.is_action_pressed("ui_up"):
		rotation.x -= deg_to_rad(1)
		if z_velocity > -MAX_Z_VELOCITY:
			z_velocity -= 2
	elif down_is_pressed or Input.is_action_pressed("ui_down"):
		rotation.x += deg_to_rad(1)
		if z_velocity < MAX_Z_VELOCITY:
			z_velocity += 2
	else:
		if rotation.x > 0:
			rotation.x -= deg_to_rad(1)
		elif rotation.x < 0:
			rotation.x += deg_to_rad(1)

		z_velocity = 0


	if rotation.z > deg_to_rad(36):
		rotation.z = deg_to_rad(36)
	if rotation.z < -deg_to_rad(36):
		rotation.z = -deg_to_rad(36)
	if rotation.x > deg_to_rad(18):
		rotation.x = deg_to_rad(18)
	if rotation.x < -deg_to_rad(18):
		rotation.x = -deg_to_rad(18)

	position.x += x_velocity * delta
	position.z += z_velocity * delta
	if position.x < -11:
		position.x = -11
	elif position.x > 11:
		position.x = 11
	if position.z < -42.5:
		position.z = -42.5
	elif position.z > 4.7:
		position.z = 4.7
	
	if z_velocity < -0.1:
		$Thruster.scale.y = 1 - z_velocity * 0.3
	elif z_velocity > 0.1:
		$Thruster.scale.y = 0.5
	else:
		$Thruster.scale.y = 1.7

func _on_bullet_timer_timeout():
	emit_signal("shoot_bullet", position)
