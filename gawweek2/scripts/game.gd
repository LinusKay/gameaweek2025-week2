extends Node3D

@export var player: CharacterBody3D
@export var ui: Control
@export var vending_machine: Node3D
@export var memory_ring: Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !player.interact.is_connected(vending_machine._on_interact):
		player.interact.connect(vending_machine._on_interact)
	if !memory_ring.forget.is_connected(vending_machine._on_forget):
		memory_ring.forget.connect(vending_machine._on_forget)
	if !vending_machine.vend.is_connected(player._on_vend):
		vending_machine.vend.connect(player._on_vend)
	if !vending_machine.request_memory.is_connected(memory_ring._on_memory_request):
		vending_machine.request_memory.connect(memory_ring._on_memory_request)
	if !memory_ring.selection_changed.is_connected(ui._on_selection_change):
		memory_ring.selection_changed.connect(ui._on_selection_change)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func _unhandled_input(event: InputEvent) -> void:
