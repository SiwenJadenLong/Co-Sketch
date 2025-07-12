extends Node

var BGmusicplayer

func playsoundeffect(soundName : String, audioBus : String):
	var polySoundPlayer = AudioStreamPlayer.new();
	polySoundPlayer.bus = audioBus;
	polySoundPlayer.autoplay = true;
	polySoundPlayer.stream = load("res://assets/sounds/%s.ogg" % soundName);
	polySoundPlayer.pitch_scale = randf_range(0.8,1.2);
	add_child(polySoundPlayer);
	await polySoundPlayer.finished
	polySoundPlayer.queue_free()

func _ready() -> void:
	BGmusicplayer = AudioStreamPlayer.new()
	BGmusicplayer.volume_db = -50
	add_child(BGmusicplayer)
	
func changeBGMusic(musicname : String):
	BGmusicplayer.stop()
	BGmusicplayer.stream = load("res://assets/music/%s.ogg" % musicname)
	BGmusicplayer.play()
