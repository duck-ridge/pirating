extends Node2D
class_name Player

#@export_enum("Jaguar", "Puma", "Lynx", "Leopard", "Tiger", "CenterTreasure") var char_name: String
@export_enum("ZhengYiSao", "Jack", "Anne", "Rollo", "Blacksmith", "CenterTreasure") var char_name: String
@onready var next_nutton = $InfoVBox/NextButton
var grab_treasure_target: String
var grab_treasure_amount: int = 0
var owned_treasure_target: String
var owned_treasure_amount: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	construct_local_dictionary()
	organize_target_info()
	next_nutton.disabled = true
	

func steal_from(target: String):
	pass


var target_dictionary: Dictionary
func organize_target_info():
	var keys = LocalOperativeDictionary.keys()
	var values = LocalOperativeDictionary.values()
	var name_label = $InfoVBox.get_child(0)
	
	name_label.text = char_name + " " + str(GlobalCompute.all_player[char_name])
	
	for c in $InfoVBox.get_children():
		if c.get_class() == "Button" and c != next_nutton:
			
			var list_name
			var list_value
			
			list_name = keys[c.get_index() - 1]
			list_value = values[c.get_index() - 1]
			
			c.text = str(list_name) + " Treasure " + str(list_value)
			target_dictionary[list_name] = list_value
			print(target_dictionary)

var LocalOperativeDictionary
func construct_local_dictionary():
	LocalOperativeDictionary = GlobalCompute.all_player.duplicate()
	for k in LocalOperativeDictionary.keys():
		if k == char_name:
			LocalOperativeDictionary.erase(char_name)
			print(LocalOperativeDictionary)
	
	
func _on_next_button_pressed():
	SignalBus.emit_signal("next_char")


func _on_button_1_pressed():
	var order = $InfoVBox/Button1.get_index() - 1
	print("grab_treasure_target " + str(target_dictionary.keys()[order]))
	print("grab_treasure_amount " + str(target_dictionary.values()[order]))
	
	grab_treasure_target = target_dictionary.keys()[order]
	grab_treasure_amount = target_dictionary.values()[order]
	#target_dictionary.keys()[order]
	GlobalCompute.player_nominate[char_name] = target_dictionary.keys()[order]
	next_nutton.disabled = false
	
func _on_button_2_pressed():
	var order = $InfoVBox/Button2.get_index() - 1
	print("grab_treasure_target " + str(target_dictionary.keys()[order]))
	print("grab_treasure_amount " + str(target_dictionary.values()[order]))
	
	grab_treasure_target = target_dictionary.keys()[order]
	grab_treasure_amount = target_dictionary.values()[order]
	
	GlobalCompute.player_nominate[char_name] = target_dictionary.keys()[order]
	next_nutton.disabled = false
	
func _on_button_3_pressed():
	var order = $InfoVBox/Button3.get_index() - 1
	print("grab_treasure_target " + str(target_dictionary.keys()[order]))
	print("grab_treasure_amount " + str(target_dictionary.values()[order]))
	
	grab_treasure_target = target_dictionary.keys()[order]
	grab_treasure_amount = target_dictionary.values()[order]
	
	GlobalCompute.player_nominate[char_name] = target_dictionary.keys()[order]
	next_nutton.disabled = false
	
func _on_button_4_pressed():
	var order = $InfoVBox/Button4.get_index() - 1
	print("grab_treasure_target " + str(target_dictionary.keys()[order]))
	print("grab_treasure_amount " + str(target_dictionary.values()[order]))
	
	grab_treasure_target = target_dictionary.keys()[order]
	grab_treasure_amount = target_dictionary.values()[order]
	
	GlobalCompute.player_nominate[char_name] = target_dictionary.keys()[order]
	next_nutton.disabled = false
	
func _on_button_5_pressed():
	var order = $InfoVBox/Button5.get_index() - 1
	print("grab_treasure_target " + str(target_dictionary.keys()[order]))
	print("grab_treasure_amount " + str(target_dictionary.values()[order]))

	grab_treasure_target = target_dictionary.keys()[order]
	grab_treasure_amount = target_dictionary.values()[order]
	
	print(order)
	print(grab_treasure_target)
	print(grab_treasure_amount)
	GlobalCompute.is_steal_CenterTreasure[char_name] = true
	GlobalCompute.player_nominate[char_name] = null
	print(GlobalCompute.player_nominate)
	next_nutton.disabled = false
