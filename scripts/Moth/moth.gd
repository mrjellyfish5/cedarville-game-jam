extends CharacterBody2D

var target_pos = Vector2.ZERO
var speed = 2000

func _physics_process(delta: float) -> void:

	if (get_tree().get_nodes_in_group("Lamp").size() > 0):
		target_pos = get_tree().get_first_node_in_group("Lamp").position

	velocity = (target_pos - global_position).normalized()
	velocity *= speed * delta
	move_and_slide()
	
	look_at(target_pos)
	rotate(90)
