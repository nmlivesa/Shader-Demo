@tool
extends Node3D

@export_enum("sparks", "firework", "glowsticks") var particle_type : String
@export_group("Resource Folders")
@export_dir var particle_node_folder : String
@export_group("Tool Buttons")
@export_tool_button("Add Particles") var load_action = _spawn_particles
@export_tool_button("Remove Particles") var remove_action = _delete_particles
var particle_dict : Dictionary[String, String] = {"sparks": "Particles_Sparks.tscn", "firework": "Particles_Firework.tscn", "glowsticks" : "Particles_Lantern.tscn"}
var particles



func _spawn_particles() :
	if particles:
		particles.queue_free()
	
	var particle_file: String = particle_dict.get(particle_type)
	var particle_scene = load(particle_node_folder + "/" + particle_file)
	particles = particle_scene.instantiate()
	add_child(particles)

func _delete_particles():
	if particles:
		particles.queue_free()

func _ready() -> void:
	_spawn_particles()
	
	pass # Replace with function body.
