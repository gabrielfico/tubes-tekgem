extends Area2D

# Variabel untuk memeriksa apakah karakter berada dalam jangkauan
var character_in_range = false

# Referensi ke node OpenChest dan CloseChest
@onready var open_chest = $OpenChest
@onready var close_chest = $CloseChest

# Fungsi yang dipanggil saat node siap
func _ready():
	# Sembunyikan sprite OpenChest di awal
	open_chest.hide()

# Fungsi untuk memproses input
func _process(delta):
	# Jika karakter dalam jangkauan dan tombol F ditekan
	if character_in_range and Input.is_action_just_pressed("open_chest"):
		open_chest_chest()

# Fungsi untuk membuka chest
func open_chest_chest():
	# Tampilkan sprite OpenChest dan sembunyikan CloseChest
	open_chest.show()
	close_chest.hide()
	print("Chest terbuka!")

# Fungsi yang dipanggil saat karakter masuk ke dalam Area2D
func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):  # Pastikan karakter berada dalam group "Player"
		character_in_range = true
		show_interaction_message()

# Fungsi yang dipanggil saat karakter keluar dari Area2D
func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		character_in_range = false
		hide_interaction_message()

# Menampilkan pesan interaksi di layar
func show_interaction_message():
	print("Tekan F untuk membuka!")

# Menghilangkan pesan interaksi di layar
func hide_interaction_message():
	print("")  # Kosongkan pesan atau sembunyikan dari UI jika menggunakan Label
