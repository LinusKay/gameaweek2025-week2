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
	if !vending_machine.vend_memory.is_connected(player._on_vend_memory):
		vending_machine.vend_memory.connect(player._on_vend_memory)
	if !vending_machine.vend_item.is_connected(player._on_vend_item):
		vending_machine.vend_item.connect(player._on_vend_item)
	if !vending_machine.request_memory.is_connected(memory_ring._on_memory_request):
		vending_machine.request_memory.connect(memory_ring._on_memory_request)
	if !memory_ring.selection_changed.is_connected(ui._on_selection_change):
		memory_ring.selection_changed.connect(ui._on_selection_change)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func _unhandled_input(event: InputEvent) -> void:
