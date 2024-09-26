extends Node2D

var player_nominate: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	player_nominate = GlobalCompute.player_nominate
	legal_check()
	find_crash()
	construct_chains()
	sort_chains()

func legal_check():
	var legal_list: Array = ["ZhengYiSao", "Jack", "Anne", "Rollo", "Blacksmith", ]
	for v in player_nominate.values():
		if v in legal_list:
			print("values pass: novaya legal check")
		else:
			print("values wrong value: novaya legal check")
			print("values check stop: novaya legal check")
			return
			
	for k in player_nominate.keys():
		if k in legal_list:
			print("keys pass: novaya legal check")
		else:
			print("keys wrong value: novaya legal check")
			print("keys check stop: novaya legal check")
			return

# Dictionary to store which players target each value (target)
var target_players: Dictionary = {}
var crash_values: Dictionary = {}

func find_crash():
	for key in player_nominate.keys():
		var target = player_nominate[key]
		if target_players.has(target):
			target_players[target].append(key)
		else:
			target_players[target] = [key]

	for target in target_players.keys():
		if target_players[target].size() > 1:
			print("Crash detected! Players targeting ", target, ":", target_players[target])

			for obj in target_players[target]:
				player_nominate[obj] = null
				crash_values[obj] = player_nominate[obj]




# Every chains: Array can contain multiple Dictionary
var chains: Array = []

# at the begining it should be equials to crash_values
var unprocessed: Dictionary = {}
var processed: Dictionary = {}

func construct_chains():
	unprocessed = player_nominate.duplicate()
	
	for k in unprocessed.keys():
		
		if k in processed.keys():
			continue
		if unprocessed[k] == null:
			continue
		var temp_chain = {}
		
		#add it into processed dictionary
		processed[k] = unprocessed[k]
		temp_chain[k] = unprocessed[k]
		unprocessed.erase(k)
		
		# add from behind
		var nk = temp_chain.values()[temp_chain.size() - 1]
		print("unprocessed " + str(unprocessed))
		print("processed " + str(processed))
		print("temp_chain " + str(temp_chain))
		print("nk " + str(nk))
		print("------------------------- ")
		while nk in unprocessed.keys() and nk not in processed.keys():
		#for nk in unprocessed.keys():
			processed[nk] = unprocessed[nk]
			temp_chain[nk] = unprocessed[nk]
			
			var done = nk
			unprocessed.erase(done)
			
			nk = temp_chain[nk]
			print("=====")
			print("unprocessed " + str(unprocessed))
			print("processed " + str(processed))
			print("temp_chain " + str(temp_chain))
			print("nk " + str(nk))
			print("=====")
			if !nk:
				print("no behind for")
				continue
				#chains.append(temp_chain)
				
			
			
			
		# add from front
		print("unprocessed before add from front" + str(unprocessed))
		var single_chain: Dictionary = {}
		while temp_chain.keys()[0] in unprocessed.values():
			single_chain = {}
			print("temp_chain.keys()[0] " + temp_chain.keys()[0])
			for pk in unprocessed.values():
				print("====")
				print("pk " + pk)
				if pk == temp_chain.keys()[0]:
					print("yes we found pk " + pk + " in unprocessed.values")
					
					# the order number of pk's key
					var order_num = unprocessed.values().find(pk)	
					print("order_num for " + str(pk) + "'s owner in unprocessed " + str(order_num))
					
					processed[unprocessed.keys()[order_num]] = unprocessed[unprocessed.keys()[order_num]]
					
					print("processed " + str(processed))
					
					single_chain[unprocessed.keys()[order_num]] = unprocessed[unprocessed.keys()[order_num]]
					
					print("single_chain " + str(single_chain))
					
					unprocessed.erase(unprocessed.keys()[order_num])
					
					print("unprocessed " + str(unprocessed))
					
					
					for c in temp_chain:
						single_chain[c] = temp_chain[c]
					print("****single_chain " + str(single_chain))
					temp_chain = single_chain
					single_chain = {}
			print("****single_chain " + str(temp_chain))
			
		var i = 1
		while i in [1, 2, 3, 4, 5, 6, 7]:
			i += 1
			print(i)
		
		if temp_chain.size() < 1:
			continue
		chains.append(temp_chain)
		
		
	print("unprocessed " + str(unprocessed))
	print("processed " + str(processed))
	print("chains " + str(chains))
	
	var real_unprocessed = player_nominate.duplicate()
	for key in processed.keys():
		real_unprocessed.erase(key)
	print(real_unprocessed)
	# add all real_unprocessed left out to the chains
	for r in real_unprocessed:
		var new_pair: Dictionary
		new_pair[r] = real_unprocessed[r]
		chains.append(new_pair)
	real_unprocessed = {}
	print("is_steal_CenterTreasure " + str(GlobalCompute.is_steal_CenterTreasure))
	print(chains)
	
func sort_chains():
	var i = 0
	for c in chains:
		# the last value is null or cat?
		if c.values()[c.size()-1] == null:
			# the final value of dictionary is center island
			if GlobalCompute.is_steal_CenterTreasure[c.keys()[c.size()-1]] == true:
				$Label.text += str(chains[i])
				$Label.text += str("\n Chain ", i + 1, ": ", str(c.keys()[c.size()-1]) + " is a single chain, but")
				$Label.text += " The final value steal from center island"
				
				GlobalCompute.all_player["CenterTreasure"] -= 1
				GlobalCompute.all_player[c.keys()[0]] += 1
				
			# the final value of dictionary is crashed
			else:
				$Label.text += str("\n Chain ", i + 1, ": ", chains[i], " a single chain")
				
				var player_stored_treasure = GlobalCompute.all_player[c.keys()[c.size()-1]]	
				
				GlobalCompute.all_player[c.keys()[c.size()-1]] = 0
				GlobalCompute.all_player[c.keys()[0]] += player_stored_treasure
				
		# all pirate involved
		elif c.size() == 5:
			$Label.text += str("\n Chain ", i + 1, ": ", chains[i], " is a long long loop")
		
		# some pirate involved Mexican standoff or switch
		elif c.keys()[0] == c.values()[c.size()-1]:
			# or switch
			if c.size() == 2:
				$Label.text += str("\n Chain ", i + 1, ": ", chains[i], " is a switch")
				var player1_stored_treasure = GlobalCompute.all_player[c.values()[0]]
				var player2_stored_treasure = GlobalCompute.all_player[c.values()[1]]
				GlobalCompute.all_player[c.keys()[0]] = player2_stored_treasure
				GlobalCompute.all_player[c.keys()[1]] = player1_stored_treasure
			else:
				$Label.text += str("\n Chain ", i + 1, ": ", chains[i], " is a loop")
		else:
			print("can not identify go sort_chains")
		i += 1
	GlobalCompute.refresh()
	

func _on_button_pressed():
	GlobalCompute.refresh()
	get_tree().change_scene_to_file("res://Scene/main_scene.tscn")
	
