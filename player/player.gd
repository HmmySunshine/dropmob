class_name Player extends Area2D

signal hit

@export var speed:float = 400

var velocity:Vector2:
    get:
        return velocity
    set(value):
        velocity = value
        
var move_direction:Vector2:
    get:
        return move_direction
    set(value):
        move_direction = value

var _screen_size:Vector2

func _ready():
    hide()
    _screen_size = get_viewport_rect().size

func _process(delta):
    #(1,0)
    move_direction = init_dirction()
    velocity = move_direction.normalized() * speed

    if velocity.x != 0:
        $AnimatedSprite2D.play("move_walk")
        $AnimatedSprite2D.flip_v = false
        #类似与三目效果
        $AnimatedSprite2D.flip_h = velocity.x < 0
    elif velocity.y != 0:
        $AnimatedSprite2D.play("move_up")
        $AnimatedSprite2D.flip_h = false
        #if的写法
        if velocity.y > 0:
            $AnimatedSprite2D.flip_v = true
        elif velocity.y < 0:
            $AnimatedSprite2D.flip_v = false
    else:
        $AnimatedSprite2D.stop()

    self.position += velocity * delta
    position = position.clamp(Vector2.ZERO, _screen_size)
        

func init_dirction() -> Vector2:
    var move_dir:Vector2 = Vector2.ZERO

    if Input.is_action_pressed("move_up"):
        move_dir += Vector2.UP    
    if Input.is_action_pressed("move_down"):
        move_dir += Vector2.DOWN
    if Input.is_action_pressed("move_left"):
        move_dir += Vector2.LEFT
    if Input.is_action_pressed("move_right"):
        move_dir += Vector2.RIGHT

    return move_dir
    
#隐藏角色并发出信号
func _on_body_entered(_body:Node2D):
    hide()
    hit.emit()
    #延迟设置
    $CollisionShape2D.set_deferred("disabled", true)

func start_game(pos):
    self.position = pos
    show()
    $CollisionShape2D.disabled = false