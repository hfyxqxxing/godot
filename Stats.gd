extends Node

export(float) var max_health = 1 setget set_max_health
var health = max_health setget set_health

#func _process(delta):
#	if health <=0:
#		emit_signal("no_health")


signal no_health
signal health_changed(value)
signal max_health_changed(value)

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value
	emit_signal("health_changed",health)
	if health <= 0:
		emit_signal("no_health")

#onready 在使用前被调用时并赋值export，就回到ready里做
func _ready():
	self.health = max_health
