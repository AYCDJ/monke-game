extends Node

var difficulty := "normal" # easy normal hard

func get_player_health() -> int:
	match difficulty:
		"easy":
			return 5
		"normal":
			return 3
		"hard":
			return 1
		_:
			return 3

func get_monkey_lifetime() -> float:
	match difficulty:
		"easy":
			return 4.0
		"normal":
			return 3.0
		"hard":
			return 1.0
		_:
			return 3.0
