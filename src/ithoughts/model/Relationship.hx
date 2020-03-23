package ithoughts.model;

class Relationship extends Element {

    public var startUuid(get, never): String;
    public var endUuid(get, never): String;
    public var color(get, set): Null<String>;

    public function new(element: Xml) {
        super(element);
    }

    function get_startUuid() {
        final uuid = element.get("end1-uuid");
        if(uuid == null) return "";
        return uuid;
    }

    function get_endUuid() {
        final uuid = element.get("end2-uuid");
        if(uuid == null) return "";
        return uuid;
    }

    function get_color(): Null<String> {
        return getStringProp("color");
    }

    function set_color(color: Null<String>) {
        return setStringProp("color", color);
    }         
}