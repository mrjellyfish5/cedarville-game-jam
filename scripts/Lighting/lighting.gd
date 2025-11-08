extends CharacterBody2D

func lamp_fall(direction):
	$CollisionShape2D.queue_free()
	$anim.play("fall_" + direction)
	await $anim.animation_finished
	queue_free()
