extends KinematicBody2D


var knockback = Vector2.ZERO
var velocity = Vector2.ZERO


export var MAX_SPEED = 50
export var acceleration = 100
export var friction = 200

enum {
	IDLE,
	WANDER,
	CHASE
}
var state = IDLE

const EnemyDeath = preload("res://Effects/DeathEffect.tscn")

onready var sprite = $Sprite
onready var status = $Stats
onready var detectionZone = $PlayerDetection
onready var hurtbox = $HurtBox
onready var soft = $SoftCollision
onready var wanderControl = $WandeControl

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, friction * delta)
	knockback = move_and_slide(knockback)
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
			jungle()
				
		WANDER:
			jungle()
			move_to(wanderControl.target_position,delta)
			
			if global_position.distance_to(wanderControl.target_position) <= 4:
				state = pick_random_state([IDLE,WANDER])
			sprite.flip_h = velocity.x < 0
				
			
		CHASE:
			var player = detectionZone.player
			if player != null:
				move_to(player.global_position,delta)
			else:
				state = IDLE
			sprite.flip_h = velocity.x < 0
		
	if soft.is_colliding():
		velocity += soft.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)
	
func move_to(target_position, delta):
	var direction = global_position.direction_to(target_position)
	velocity = velocity.move_toward(direction * MAX_SPEED, acceleration * delta)

func _on_HurtBox_area_entered(area):
	status.health -= area.damage
	knockback = area.knockback *120 
	hurtbox.create_hit_effect()
	
func _on_Stats_no_health():
	queue_free()
	var enemyDeath = EnemyDeath.instance()
	get_parent().add_child(enemyDeath)
	enemyDeath.global_position = global_position

func seek_player():
	if detectionZone.can_see_player():
		state = CHASE

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()
	
func jungle():
	seek_player()
	if wanderControl.get_time_left() == 0:
		state = pick_random_state([IDLE, WANDER])
		wanderControl.start_wander(rand_range(1,3))
