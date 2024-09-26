extends Node

var turn_is_done: bool = false
var centre_treasure: int

#var all_player: Dictionary = {
	#"Jaguar": 2,
	#"Puma": 0,
	#"Lynx": 0,
	#"Leopard": 3,
	#"Tiger": 0,
	#"CenterTreasure": 10
#}
var all_player: Dictionary = {
	"ZhengYiSao": 0,
	"Jack": 0,
	"Anne": 0,
	"Rollo": 0,
	"Blacksmith": 0,
	"CenterTreasure": 15
}

func _ready():
	for key in all_player.keys():
		if key == "CenterTreasure":
			return
		all_player[key] += 1
	turn_is_done = true
	
	
func generate_steal_chain():
	pass

#var is_steal_CenterTreasure: Dictionary = {
	#"Jaguar": false,
	#"Puma": false,
	#"Lynx": false,
	#"Leopard": false,
	#"Tiger": false,
	#}
var is_steal_CenterTreasure: Dictionary = {
	"ZhengYiSao": true,
	"Jack": false,
	"Anne": false,
	"Rollo": false,
	"Blacksmith": false,
	}

var player_nominate: Dictionary = {
	"ZhengYiSao": null,
	"Jack": null,
	"Anne": null,
	"Rollo": null,
	"Blacksmith": null,
}

#var player_nominate: Dictionary = {
	#"ZhengYiSao": null,
	#"Jack": "ZhengYiSao",
	#"Anne": "Jack",
	#"Rollo": "Anne",
	#"Blacksmith": "Rollo",
#}




func refresh():
	#player_nominate = {
	#"Jaguar": null,
	#"Puma": null,
	#"Lynx": null,
	#"Leopard": null,
	#"Tiger": null,
	#}
	player_nominate = {
	"ZhengYiSao": null,
	"Jack": null,
	"Anne": null,
	"Rollo": null,
	"Blacksmith": null,
	}
	
	#is_steal_CenterTreasure = {
	#"Jaguar": false,
	#"Puma": false,
	#"Lynx": false,
	#"Leopard": false,
	#"Tiger": false,
	#}
	is_steal_CenterTreasure = {
	"ZhengYiSao": false,
	"Jack": false,
	"Anne": false,
	"Rollo": false,
	"Blacksmith": false,
	}
