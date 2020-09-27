extends Node

export(float) var max_health = 1
onready var health = max_health setget set_health

#func _process(delta):
#	if health <=0:
#		emit_signal("no_health")


signal no_health


func set_health(value):
	health = value
	if health <= 0:
		emit_signal("no_health")
