extends CharacterBody2D
class_name Enemy

@onready var loot_drop : LootDropComponent = $"Loot Drops"
@onready var health_bar: HealthBar = $HealthBar
@onready var hit_flash_player: AnimationPlayer = $Sprite2D/HitFlashPlayer
@onready var animation_tree: AnimationTree = $Animation/AnimationTree

@onready var enemy_attack: BasicAttack = $"Enemy Attack"

@onready var player = get_tree().get_first_node_in_group("Player")

var knockback_distance := 200
var knockback_direction : Vector2

@export var speed := 100
var direction: Vector2

var can_act := true

func _physics_process(_delta: float) -> void:
	if !can_act:
		return
	if player:
		direction = (player.position - position).normalized()
		velocity = direction * speed + knockback_direction
		if position.distance_to(player.position) < 20:
			attack_animation()
		move_and_slide()
		enemy_attack.global_position = global_position + direction * 25
		animate()
		

func _on_health_component_is_dead() -> void:
	loot_drop.drop_item()
	loot_drop.drop_tile()
	queue_free()

func _on_health_component_health_changed(current: float, max: float) -> void:
	if health_bar:
		health_bar.update_health_bar(current, max)


func _on_health_component_damage_taken(damage_position: Vector2, knockback_power: float) -> void:
	apply_knockback(knockback_power)
	hit_flash_player.play("hit_flash")

func apply_knockback(knockback_power: float) -> void:
	var tween = get_tree().create_tween()
	var dir = (player.position - position).normalized() * -1 * knockback_distance * knockback_power
	tween.tween_property(self, "knockback_direction", dir, 0.1)
	tween.tween_property(self, "knockback_direction", Vector2.ZERO, 0.2)
	

func attack_animation() -> void:
	$Animation/AnimationTree.set("parameters/AttackOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	
func attack() -> void:
	enemy_attack.attack(global_position)
	
func animate() -> void:
	if direction:
		var animation_direction = Vector2(round(direction.x),round(direction.y))
		animation_tree.set("parameters/MoveStateMachine/move/blend_position", animation_direction)
		animation_tree.set("parameters/Attack/blend_position", animation_direction)


func _on_animation_tree_animation_started(anim_name: StringName) -> void:
	can_act = false

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	can_act = true
