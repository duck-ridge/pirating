extends Node2D

@onready var player_temp = preload("res://Players/player.tscn")
#var char_name: Array = ["Jaguar", "Puma", "Lynx", "Leopard", "Tiger"]
var char_name: Array = ["ZhengYiSao", "Jack", "Anne", "Rollo", "Blacksmith"]
var current_char_num: int = 0
var last_char

func _ready():
	SignalBus.connect("next_char", NextChar)
	SignalBus.connect("reveal_result", EndTurn)
	generate_player(0)
	#if GlobalCompute.all_player["CenterTreasure"] < 1:
		#pass


@onready var novaya = preload("res://Scene/novaya.tscn")
func NextChar():
	current_char_num += 1
	generate_player(current_char_num)
	print(current_char_num)
	if current_char_num > 4:
		print("current_char_num")
		get_tree().change_scene_to_file("res://Scene/novaya.tscn")
	
func generate_player(char_num: int):
	if last_char:
		last_char.queue_free()
	var player_inst = player_temp.instantiate()
	
	if char_num > 4:
		SignalBus.emit_signal("reveal_result")
		return
		
	player_inst.char_name = char_name[char_num]
	add_child(player_inst)
	player_inst.position = Vector2(500, 200)
	last_char = player_inst
	
func EndTurn():
	pass
