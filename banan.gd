extends Area2D
"""
@export var value: int = 1

signal collected

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("collected")
		hide()
		$BananShape2D.disabled = true
	print("Banantouch", body.name) #debug
	print("Touched:", body.name, "Groups:", body.get_groups()) #debug
"""


signal collected

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node):
	print("Banana touched:", body.name, "Groups:", body.get_groups())
	if body.is_in_group("player"):
		print("Collected by player!")
		hide()
		$CollisionShape2D.disabled = true
		emit_signal("collected")
