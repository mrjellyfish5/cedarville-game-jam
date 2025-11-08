extends CharacterBody2D

var target_pos = Vector2.ZERO
var speed = 5000
var follow_method = "None" # none stays still, player follows, lamp goes to lamp, tempted doesn't allow capture
var temptation_range = 250

func _physics_process(delta: float) -> void:

	if follow_method == "Lamp" or follow_method == "Tempted":
		target_pos = nearest_lamp()

	
		
	elif follow_method == "Player":
		
		# tempt the moths
		if (nearest_lamp().distance_to(global_position) < temptation_range):
			follow_method = "Tempted"
		
		target_pos = get_tree().get_first_node_in_group("Player").position

	if follow_method != "None":
		velocity = (target_pos - global_position).normalized()
		velocity *= speed * delta
		move_and_slide()
		
		look_at(target_pos)
		rotate(90)

func nearest_lamp():
	
	if get_tree().get_nodes_in_group("Lamp").size() == 0:
		return Vector2(0,10000)
		
	var closest = get_tree().get_first_node_in_group("Lamp").position
	for lamp in get_tree().get_nodes_in_group("Lamp"):
		if lamp.position.distance_to(global_position) < closest.distance_to(global_position):
			closest = lamp.position
	return closest

func die():
	queue_free()

func _on_lamp_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("Lamp"):
		die()
	elif body.is_in_group("Player") and (follow_method == "Lamp"):
		follow_method = "Player"
		$follow_particle.emitting = true
		$moth_follow.play()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	follow_method = "Lamp"
