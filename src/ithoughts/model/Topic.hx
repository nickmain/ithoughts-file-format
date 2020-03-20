package ithoughts.model;

class Topic {
    var element: Xml;

    public var text(get, set): String;
    public var color(get, set): Null<String>;
    public var shape(get, set): Null<Shape>;
    public var note(get, set): Null<String>;

    public function new(element: Xml) {
        this.element = element;
    }

    function get_text() {
        final text = element.get("text");
        if(text == null) return "";
        return text;
    }

    function set_text(text: String) {
        text = StringTools.replace(text, "\n", "&#10;");
        element.set("text", text);
        return text;
    }

    function get_color(): Null<String> {
        return element.get("color");
    }

    function set_color(color: Null<String>) {
        if(color == null) {
            element.remove("color");
            return color;
        }

        element.set("color", color);
        return color;
    }    

    function get_note(): Null<String> {
        return element.get("note");
    }

    function set_note(note: Null<String>) {
        if(note == null) {
            element.remove("note");
            return note;
        }

        note = StringTools.replace(note, "\n", "&#10;");
        element.set("note", note);
        return note;
    }   

    function get_shape(): Null<Shape> {
        return Shape.fromString(element.get("shape"));
    }

    function set_shape(shape: Null<Shape>) {
        if(shape == null) {
            element.remove("shape");
            return shape;
        }

        element.set("shape", Std.string(shape));
        return shape;
    } 
}