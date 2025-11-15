extends Control

@onready var time_label: Label = $VBoxContainer/TimeLabel
@onready var button: Button = $VBoxContainer/StartStopButton
@onready var message_label: Label = $VBoxContainer/MessageLabel
@onready var timer: Timer = $GameTimer

var elapsed_time: float = 0.0 
var is_running: bool = false 


func _ready():
	update_display()
	button.pressed.connect(_on_button_pressed)
	timer.timeout.connect(_on_timer_timeout)
	message_label.visible = false
	
func _process(_delta):
	if is_running:
		time_label.text = format_time(elapsed_time)


func _on_button_pressed():
	print("button pressed")
	if is_running:
		stop_timer()
	else:
		print("ok " )
		start_timer()
		
func start_timer():
	is_running = true 
	button.text = "STOP"
	message_label.visible = false 
	timer.start()
	
func stop_timer():
	is_running =false
	button.text = "START"
	timer.stop()
	check_result()
	
func _on_timer_timeout():
	elapsed_time += 1.0
	
func check_result():
	var target: float = 300.0
	if abs(elapsed_time - target) < 0.5:
		message_label.text = "BRAWO! Perfekcyjnie !!!"
		message_label.modulate = Color.GREEN
	else:
		message_label.text = "Spróbuj jeszcze raz!\nTwój czas: " + format_time(elapsed_time)
	message_label.visible = true 
	reset_timer()
	
func reset_timer():
	elapsed_time = 0.0 
	update_display()
	
func update_display():
	print("supdateing")
#	time_label.text = format_time(elapsed_time)
	
func format_time(seconds: float)-> String:
	var mins: int = int(seconds) / 60
	var secs: int = int(seconds) % 60
	return "%02d:%02d" % [mins, secs]
