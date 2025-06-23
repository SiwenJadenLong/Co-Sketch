extends Node;

signal playerDeath();
signal levelChange(new_level_name : String);
signal unloadLevel();

signal gamePaused(condition : bool);
signal togglePause();

signal lockPause();
signal levelWon();
