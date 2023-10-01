extends Area3D

@export var velocity = Vector3(0, 0, -75.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta
