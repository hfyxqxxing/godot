extends KinematicBody2D

var velocity = Vector2.ZERO
var roll_vector = Vector2.ZERO
var direction = 0

#可以用accleration，velocity+=，*delta，see 2

export var MAX_SPEED = 100
export var A = 10
export var friction = 500
export(float) var roll_speed = 0.8

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get('parameters/playback')
onready var SwordHit = $attackpivot/SwordHit

enum {
	MOVE,
	ATTACK,
	ROLL
}

var state = MOVE

func _ready():
	animationTree.active = true
	SwordHit.knockback = roll_vector
	
	

func _physics_process(delta):
	match state:
		MOVE:
			Moves(delta)
		ATTACK:
			Attacks(delta)
		ROLL:
			Rolls(delta)

func Moves(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	roll_vector = input_vector
	SwordHit.knockback = find_direction(input_vector)
	
	if input_vector != Vector2.ZERO:
		animationTree.set('parameters/idle/blend_position',input_vector)
		animationTree.set('parameters/run/blend_position',input_vector)
		animationTree.set('parameters/attack/blend_position',input_vector)
		animationTree.set('parameters/roll/blend_position',input_vector)
		animationState.travel("run")
		velocity += input_vector * A
		velocity = velocity.clamped(MAX_SPEED)
	else:
		#velocity = velocity.move_toward()
		animationState.travel("idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("ui_attack"):
		state = ATTACK
		
	if Input.is_action_just_pressed("ui_roll"):
		state = ROLL
	
func Attacks(delta):
	velocity = Vector2.ZERO
	animationState.travel("attack")

#保留滑动，或者直接改为0
func Rolls(delta):
	velocity = roll_vector * MAX_SPEED  * roll_speed
	animationState.travel("roll")
	velocity = move_and_slide(velocity)
	#velocity = Vector2.ZERO
	#velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

func roll_is_finished():
	#velocity = Vector2.ZERO
	#velocity = velocity.move_toward(Vector2.ZERO, friction)
	state = MOVE	

func attack_is_finished():
	state = MOVE


func find_direction(velocity):
	if velocity.x == 0:
		direction = velocity.y * 100
	else:
		direction = velocity.y / velocity.x
	if velocity.x >= 0:
		if direction >= -1 and direction <= 1:
			return Vector2.RIGHT
		elif direction > 1:
			return Vector2.DOWN
		else:
			return Vector2.UP
	if velocity.x < 0:
		if direction >= -1 and direction <= 1:
			return Vector2.LEFT
		elif direction > 1:
			return Vector2.UP
		else:
			return Vector2.DOWN
