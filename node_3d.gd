extends Node3D

var Bullet = preload("res://bullet.tscn")

func _on_playership_shoot_bullet(origin_pos):
	var new_bullet_right = Bullet.instantiate()
	var new_bullet_left  = Bullet.instantiate()
	add_child(new_bullet_right)
	add_child(new_bullet_left)
	new_bullet_right.position = origin_pos + Vector3(4.0, 0, -3.0)
	new_bullet_left.position  = origin_pos + Vector3(-4.0, 0, -3.0)
