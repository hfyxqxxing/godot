extends KinematicBody2D


var knockback = Vector2.ZERO
var velocity = Vector2.ZERO


export var MAX_SPEED = 50
export var acceleration = 100
export var friction = 200

enum {
	IDLE,
	WONDER,
	CHASE
}
var state = IDLE

const EnemyDeath = preload("res://Effects/DeathEffect.tscn")

onready var sprite = $Sprite
onready var status = $Stats
onready var detectionZone = $PlayerDetection

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, friction * delta)
	knockback = move_and_slide(knockback)
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
			seek_player()
		WONDER:
			pass
		CHASE:
			var player = detectionZone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, acceleration * delta)
			else:
				state = IDLE
			sprite.flip_h = velocity.x < 0
				
	velocity = move_and_slide(velocity)

func _on_HurtBox_area_entered(area):
	status.health -= area.damage
	knockback = area.knockback *120 
	
func _on_Stats_no_health():
	queue_free()
	var enemyDeath = EnemyDeath.instance()
	get_parent().add_child(enemyDeath)
	enemyDeath.global_position = global_position

func seek_player():
	if detectionZone.can_see_player():
		state = CHASE

