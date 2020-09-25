extends KinematicBody2D

var velocity = Vector2.ZERO


#可以用accleration，velocity+=，*delta，see 2

const MAX_SPEED = 100
const A = 10
const friction = 500

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get('parameters/playback')

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set('parameters/idle/blend_position',input_vector)
		animationTree.set('parameters/run/blend_position',input_vector)
		animationState.travel("run")
		velocity += input_vector * A
		velocity = velocity.clamped(MAX_SPEED)
	else:
		#velocity = velocity.move_toward()
		animationState.travel("idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
	velocity = move_and_slide(velocity)

