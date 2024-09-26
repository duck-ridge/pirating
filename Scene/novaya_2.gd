extends Node2D

var player_nominate: Dictionary = {
	"Jaguar": "Tiger",
	"Puma": "Tiger",
	"Lynx": "Jaguar",
	"Leopard": "Lynx",
	"Tiger": "Puma",
}

var target_players: Dictionary = {}
var crash_values: Dictionary = {}

func find_crash():
	for key in player_nominate.keys():
		var target = player_nominate[key]
		if target_players.has(target):
			target_players[target].append(key)
		else:
			target_players[target] = [key]
	print(target_players)
	for target in target_players.keys():
		if target_players[target].size() > 1:
			
			print("Crash detected! Players targeting", target, ":", target_players[target])
			for obj in target_players[target]:
				
				crash_values[obj] = player_nominate[obj]
				
				player_nominate[obj] = null
				
	
	print("Crash values: ", crash_values)


var chains: Array = []  # 用于存储多个链条
var processed: Array = []  # 用于标记已经处理过的玩家

func construct_chains():
	for k in player_nominate.keys():
		print("XDD" + k)
		if k in processed:
			continue
		if k in crash_values:
			continue
		var chain = {}
		var current_key = k
		while current_key not in processed:
		#while current_key != null and current_key not in processed:
			processed.append(current_key)  # 标记该玩家已处理
			print(current_key + " current_key")
			print(chain[current_key])
			chain[current_key] = player_nominate[current_key]
			current_key = player_nominate[current_key]  # 移动到下一个 key (即当前 value)  
		chains.append(chain)  # 将构建的链条加入链条数组中
	
	# 打印结果
	for i in range(chains.size()):
		print("Chain ", i + 1, ": ", chains[i])
	print(chains)
	
	
func _ready():
	find_crash()
	print("XX")
	construct_chains()

#chain 的 switch and loop
func appraise_chain():
	for c in chains:
		if c.size() == 2:
			pass
	
	
