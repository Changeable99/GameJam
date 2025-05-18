extends Label

var moneyTimer : Timer
var secsToUpdateMoneyLabel : float = 0.5

func _process(delta: float) -> void:
	if Global.gameOver:
		text = str(0)

func _ready() -> void:
	moneyTimer = Timer.new()
	moneyTimer.wait_time = secsToUpdateMoneyLabel
	moneyTimer.connect("timeout", _update_money)
	add_child(moneyTimer)
	moneyTimer.start()

func _update_money():
	text = str(Global.currentMoney)
	moneyTimer.start()
