extends CharacterBody2D

const PLAYABLE_SPEED: float = 500
const JUMP_VEL: float = -1000
const GRAVITY: float = 40
const MAX_FALL: float = 1000
const MAX_JUMPS: int = 3

var jumps_remaining: int = 3

func _physics_process(delta):
	
	velocity.x = 0
	
	if Input.is_action_pressed("Move Right"):
		velocity.x = PLAYABLE_SPEED
		$idle.flip_h = false
		$attack.flip_h = false
		
	if Input.is_action_pressed("Move Left"):
		velocity.x = -PLAYABLE_SPEED
		$idle.flip_h = true
		$attack.flip_h = true
	
	if !(velocity.y >= MAX_FALL):
		velocity.y += GRAVITY
	
	if Input.is_action_just_pressed("Jump") and jumps_remaining > 0:
		$anim.play("idle")
		jump()
		jumps_remaining -= 1
		
	if Input.is_action_just_pressed("attack"):
		attack()
	
	if is_on_floor():
		jumps_remaining = MAX_JUMPS
	
	move_and_slide()

func jump() -> void:
	velocity.y = JUMP_VEL

func attack():
	set_physics_process(false)
	$anim.play("attack")
	await $anim.animation_finished
	set_physics_process(true)


func _on_attack_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Lamp"):
		if $idle.flip_h:
			body.lamp_fall("left")
		else:
			body.lamp_fall("right")
