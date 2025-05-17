extends Node

var currentMoney: int = 1000
var currentChaos: int = 500
var currentTime = 0
var displayTime: String
var gameState: GameState = GameState.DEFAULT

enum GameState {
	DEFAULT,
	MINIGAME,
	MENU
}

func _process(delta: float) -> void:
	_change_money(-3)
	_calculate_time(delta)
	
func _change_chaos(chaos: int) -> void:
	currentChaos += chaos
	
func _change_money(money: int) -> void:
	currentMoney += money
	if currentMoney <= 0:
		currentMoney = 0
		_end_game()
	
func _calculate_time(delta) -> void:
	currentTime += delta
	var minutes = int(currentTime) / 60
	var seconds = int(currentTime) % 60
	displayTime = "%02d:%02d" % [minutes, seconds]
	
func _end_game():
	print("GAME OVER")
