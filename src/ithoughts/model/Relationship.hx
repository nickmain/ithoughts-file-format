package ithoughts.model;

class Relationship extends Element {

    public var startUuid(get, never): String;
    public var endUuid(get, never): String;
    public var color(get, set): Null<String>;
    public var dashed(get, set): Bool;
    public var startText(get, set): Null<String>;
    public var centerText(get, set): Null<String>;
    public var endText(get, set): Null<String>;
    public var type(get, set): RelationshipType;
    public var startArrow(get, set): ArrowType;
    public var endArrow(get, set): ArrowType;

    /**
     * Offset for curved is relative to center of start topic.
     * Only y-offset is relevant to angled type.
     */
    public var offset(get, set): {x: Float, y: Float};

    public function new(element: Xml) {
        super(element);
    }

    function get_offset() {
        return getPosition("b-offset");
    }

    function set_offset(offset: {x: Float, y: Float}) {
        return setPosition("b-offset", offset);
    }

    function get_startArrow(): ArrowType {
        return ArrowType.fromString(element.get("end1-style"));
    }

    function set_startArrow(type: ArrowType) {
        element.set("end1-style", Std.string(type));
        return type;
    } 

    function get_endArrow(): ArrowType {
        return ArrowType.fromString(element.get("end2-style"));
    }

    function set_endArrow(type: ArrowType) {
        element.set("end2-style", Std.string(type));
        return type;
    } 

    function get_type(): RelationshipType {
        return RelationshipType.fromString(element.get("type"));
    }

    function set_type(type: RelationshipType) {
        element.set("type", Std.string(type));
        return type;
    } 

    function get_startText() {
        return getNullableString("end1-text");
    }

    function set_startText(text: Null<String>) {
        return setNullableString("end1-text", text);
    }

    function get_endText() {
        return getNullableString("end2-text");
    }

    function set_endText(text: Null<String>) {
        return setNullableString("end2-text", text);
    }

    function get_centerText() {
        return getNullableString("center-text");
    }

    function set_centerText(text: Null<String>) {
        return setNullableString("center-text", text);
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

    function get_dashed() {
        return getBoolProp("dashed");
    }

    function set_dashed(dashed: Bool) {
        return setBoolProp("dashed", dashed);
    }
}