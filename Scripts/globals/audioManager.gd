extends Node

func playsoundeffect(soundName : String):
	var polySoundPlayer = AudioStreamPlayer.new();
	polySoundPlayer.autoplay = true;
	polySoundPlayer.stream = load("res://assets/sounds/%s.ogg" % soundName);
	polySoundPlayer.pitch_scale = randf_range(0.8,1.2);
	add_child(polySoundPlayer);
	await polySoundPlayer.finished
	polySoundPlayer.queue_free()
