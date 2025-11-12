extends Node

var sfx_player := AudioStreamPlayer.new()
var music_player := AudioStreamPlayer.new()
var sfx_player_pickup := AudioStreamPlayer.new()
var sfx_player_shell := AudioStreamPlayer.new()


var mainMusic_1 = preload("res://Assets/Sounds/Music/Water Theme - G Major - Jordan Ottesen.mp3")
var vacuumSuckingSFX = preload("res://Assets/Sounds/SFX/vacuum-cleaner-noise-27307.mp3")
var pickUpSFX = preload("res://Assets/Sounds/SFX/BlopSFX.mp3")
var pickUpShellSFX = preload("res://Assets/Sounds/SFX/metal-clang-284809.mp3")

var is_vacuum_playing: bool = false
var vacuum_tween: Tween  # Keep track of current fade tween

func _ready():
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS
	add_child(sfx_player)
	add_child(music_player)
	add_child(sfx_player_pickup)
	add_child(sfx_player_shell)

	
	music_player.stream = mainMusic_1
	music_player.volume_db = -10
	music_player.play()


func play_sfx(stream: AudioStream):
	sfx_player.pitch_scale = 1
	sfx_player.stream = stream
	sfx_player.play()

func play_music(stream: AudioStream):
	music_player.stop()
	music_player.stream = stream
	music_player.play()

func play_main_music():
	music_player.stream = mainMusic_1
	music_player.play()

func stop_music():
	music_player.stop()


func play_vacuum_sfx():
	is_vacuum_playing = true

	if vacuum_tween:
		vacuum_tween.kill()  # Stop previous tween
	sfx_player.stop()
	sfx_player.stream = vacuumSuckingSFX
	sfx_player.pitch_scale = randf_range(0.75, 1.25)
	
	sfx_player.volume_db = -40  # Start quiet for fade-in
	sfx_player.play()
	
	var vacuumVolume = -12
	vacuum_tween = create_tween()
	vacuum_tween.tween_property(sfx_player, "volume_db", vacuumVolume, 0.4)



func stop_vacuum_sfx():
	is_vacuum_playing = false
	if vacuum_tween:
		vacuum_tween.kill()  # Stop previous tween
	vacuum_tween = create_tween()
	vacuum_tween.tween_property(sfx_player, "volume_db", -60, 0.4)
	vacuum_tween.tween_callback(Callable(self, "_stop_vacuum_final"))
	
func _stop_vacuum_final():
	sfx_player.stop()
	sfx_player.volume_db = -3
	
func play_pickup_sfx():
	sfx_player_pickup.stream = pickUpSFX
	sfx_player_pickup.pitch_scale = randf_range(0.95, 1.05)
	sfx_player_pickup.volume_db = 0
	sfx_player_pickup.play()
	
func play_pickup_shell_sfx():
	sfx_player_shell.stream = pickUpShellSFX
	sfx_player_shell.pitch_scale = randf_range(0.95, 1.05)
	sfx_player_shell.volume_db = 0
	sfx_player_shell.play()
