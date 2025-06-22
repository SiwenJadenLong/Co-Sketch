extends Label

var timeelapsed : float
var stopped : bool

func _ready():
	SignalBus.playerDeath.connect(playerdeath);
	SignalBus.levelChange.connect(levelchanged);
	SignalBus.gamePaused.connect(togglestopwatch);

#Count time as long as stopwatch is not stopped
func _process(delta):
	if !stopped:
		timeelapsed += delta;
	text = "Finished in: %s" % str(timeelapsed).pad_decimals(2);

func playerdeath():
	resettime();

func levelchanged(levelname : String):
	resettime();

func resettime():
	stopped = false;
	timeelapsed = 0;

func togglestopwatch(condition):
	stopped = condition;
