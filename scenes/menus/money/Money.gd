extends Label

func _on_player_gold_collected():
	GlobalVars.level_gold += 1
	text = str(GlobalVars.level_gold)
