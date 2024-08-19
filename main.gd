class_name Main extends Node2D

@export var mob_scene: PackedScene
@onready var hud:HUD = %HUD

var score:int:
	get:
		return score
	set(value):
		score = value
		hud.update_score(score)


	
func _ready():
	mob_scene = preload("res://mob/mob.tscn")
	

func _process(_delta):
	pass

func game_over():
	hud.show_game_over()
	
	$MobTimer.stop()
	$ScoreTimer.stop()
	score = 0
	
	print("gameover")
	
	

func new_game():
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$StartTimer.start()
	$Player.start_game($StartPosition.position)



func _on_start_timer_timeout():
	print("start")
	$MobTimer.start()
	$ScoreTimer.start()


func _on_score_timer_timeout():
	score += 1
	

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate() as Mob

		#获取路径对象
	var mob_spawn_location = $MobPath/MobSpawnLocation
		#设置路径生成位置随机
	mob_spawn_location.progress_ratio = randf()
	print(mob_spawn_location.progress_ratio)
		#方向
		
	var dirction = mob_spawn_location.rotation + PI / 2
		#再旋
	mob.position = mob_spawn_location.position
	dirction += randf_range(-PI / 4, PI / 4)


	mob.rotation = dirction
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(dirction)

	add_child(mob)


func _on_hud_restart():
	new_game()


func _on_player_hit():
	game_over()
	
