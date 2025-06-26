extends Node;

signal playerDeath();
signal playerDeathPosition(deathPosition : Vector2, player : String);

signal levelChange(newLevelName : String);
signal unloadLevel();

signal gamePaused(condition : bool);
signal togglePause();

signal lockPause();
signal levelWon();

signal editingEntered(player: String);
signal editingExited();
