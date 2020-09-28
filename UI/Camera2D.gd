extends Camera2D


onready var zuoshang = $Node/Topleft
onready var youxia = $Node/Rightdown

func _ready():
	limit_top = zuoshang.position.y
	limit_left = zuoshang.position.x
	limit_right = youxia.position.x
	limit_bottom = youxia.position.y
