class_name HUD extends CanvasLayer

signal Restart

#动态的获取分数
@onready var score_label = %ScoreLabel
@onready var message_label = %MessageLabel
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_start_button_pressed():
	Restart.emit()
	
	#启动计时器
	message_label.text = "GetReady!"
	$Panel/MessageTimer.start()
	$Panel/StartButton.visible = false
	

func _on_message_timer_timeout():
	message_label.visible = false
	

func show_game_over():
	message_label.text = "Game Over"
	message_label.visible = true
	
	$Panel/MessageTimer.start()
	await $Panel/MessageTimer.timeout
	
	message_label.visible = true
	await get_tree().create_timer(1.0).timeout
	message_label.text = "躲避坏蛋"
	$Panel/StartButton.visible = true

func update_score(socre:int):
	score_label.text = str(socre)