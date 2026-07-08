extends CharacterBody2D

@export var animacion: AnimatedSprite2D
@export var area_2d: Area2D

var _velocidad: float = 100.0
var _velocidad_salto: float = -300.0

func _ready():
	area_2d.body_entered.connect(_on_area_2d_body_entered)

func _physics_process(delta):
	#Gravedad
	velocity += get_gravity() * delta
	
	#Salto
	if Input.is_action_just_pressed("saltar") and is_on_floor():
		velocity.y = _velocidad_salto
	
	#Movimiento lateral
	if Input.is_action_pressed("derecha"):
		velocity.x = _velocidad
		animacion.flip_h = false
	elif Input.is_action_pressed("izquierda"):
		velocity.x = -_velocidad
		animacion.flip_h = true
		
	else:
		velocity.x = 0
		
	#Animacion
	if !is_on_floor():
		animacion.play("saltar")
	elif velocity.x != 0:
		animacion.play("correr")
	else:
		animacion.play("idle")

	move_and_slide()
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("muerto")
