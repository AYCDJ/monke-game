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
