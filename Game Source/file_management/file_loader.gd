extends Node

func _on_button_pressed():
    $FileDialog.popup()

func _on_file_dialog_file_selected(path):
    var reader = ZIPReader.new()
    if reader.open(path) != OK:
        print("Opening file failed")
        return
    var runes = reader.read_file("definitions/runes.json").get_string_from_ascii()
    reader.close()

    var runes_json = JSON.parse_string(JSON.parse_string(runes))
    
    var example_sprite = runes_json[0]["sprite_svg"]
    var image = Image.new()
    image.load_svg_from_string(example_sprite)
    $Sprite.texture = ImageTexture.create_from_image(image)