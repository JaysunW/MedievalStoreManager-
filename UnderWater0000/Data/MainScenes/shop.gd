extends Node2D

var selected_item = null

func buy_item(item, container):
	var player_gold = GoldService.get_gold()
	if item["price"] <= player_gold:
		#Give player the upgrade
		print("category: " + str(item["name"]))
		GoldService.add_gold(-item["price"])
		container.item_bought()
		var tool_stats = LoadoutService.get_tool_stats()
		tool_stats[item["name"]][item["id"]]["unlocked"] = true
		LoadoutService.set_tool_stats(tool_stats)
	else:
		container.not_bought()
		pass
		# Show that it couldn't be bought


func _on_texture_button_button_down():
	SceneSwitcherService.switch_scene(SceneSwitcherService.main_scene_path)
