extends KinematicBody2D


var knockback = Vector2.ZERO

enum {
	IDLE,
	WONDER,
	CHASE
}

const EnemyDeath = preload("res://Effects/DeathEffect.tscn")

onready var status = $Stats

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)

func _on_HurtBox_area_entered(area):
	status.health -= area.damage
	knockback = area.knockback *120 
	
func _on_Stats_no_health():
	queue_free()
	var enemyDeath = EnemyDeath.instance()
	get_parent().add_child(enemyDeath)
	enemyDeath.global_position = global_position
