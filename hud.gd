extends CanvasLayer

signal start_game

var leaderboard = []
var leaderboard_items = 5

func _ready():
	var leaderboard_file = FileAccess.open(
		"resources/leaderboard.txt",
		FileAccess.READ
	)
	
	var splitted_leader
	
	for leader in leaderboard_file.get_as_text().split("\n"):
		splitted_leader = leader.split(",")
		
		if splitted_leader[0] == "": break
		if leaderboard.size() >= leaderboard_items: break
		
		leaderboard.append([splitted_leader[0], int(splitted_leader[1])])
	
	#display_leaderboard()
	
	
	
func display_leaderboard():
	$LeaderBoard.text = "LeaderBoard"
	$LeaderBoard.text += "\n"
	
	for leader in leaderboard:		
		$LeaderBoard.text += "\n"
		$LeaderBoard.text += leader[0]
		$LeaderBoard.text += " --- "
		$LeaderBoard.text += str(leader[1])
			
			
	$LeaderBoard.show()
	print(leaderboard)
	

func check_leaderboard_score(score):
	var new_leader_idx = 0
	var aux_leader
	var aux_leader_2
	
	for leader in leaderboard:
		if leader[1] < score:
			print("New Leader")
			aux_leader = leaderboard[new_leader_idx]
			leaderboard[new_leader_idx] = ["test", int(score)]
			
			for i in range(new_leader_idx, leaderboard.size() - 1):
				aux_leader_2 = leaderboard[i]
				leaderboard[i] = aux_leader
				aux_leader = aux_leader_2
				
			break
			
		new_leader_idx += 1
		
	if leaderboard.size() < leaderboard_items and leaderboard.size() <= new_leader_idx:
		print("New Leader")
		leaderboard.append(["test", score])
			

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func game_over(score):
	show_message("Game Over")
	
	#check_leaderboard_score(score)
	
	await $MessageTimer.timeout
	
	$Message.text = "Dodge the Creeps!"
	$Message.show()
	#display_leaderboard()
	
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)
	


func _on_message_timer_timeout() -> void:
	$Message.hide()
	$LeaderBoard.hide()


func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()
