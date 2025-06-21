extends Label

var timeelapsed : float
var stopped : bool

func _ready():
	Signalbus.playerdeath.connect(playerdeath);
	Signalbus.levelchange.connect(levelchanged);
	Signalbus.gamepaused.connect(togglestopwatch);

func _process(delta):
	if !stopped:
		timeelapsed += delta
		text = str(timeelapsed).pad_decimals(2)
	else:
		text = str(timeelapsed).pad_decimals(2)

func playerdeath():
	resettime()

func levelchanged(levelname : String):
	resettime()
	
func resettime():
	stopped = false
	timeelapsed = 0

func togglestopwatch(condition):
	stopped = condition
		
