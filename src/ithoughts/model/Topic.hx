package ithoughts.model;

class Topic {
    final element: Xml;
    
    public var parent(default, null): Null<Topic>;
    public var uuid(get, never): String;
    public var text(get, set): String;
    public var position(get, set): {x: Float, y: Float};
    public var color(get, set): Null<String>;
    public var shape(get, set): Null<Shape>;
    public var note(get, set): Null<String>;
    public var link(get, set): Null<String>;
    public var children(get,never): Array<Topic>;
    public var type(get, set): TopicType;
    public var boundary(get, set): Bool;
    public var folded(get, set): Bool;
    public var resources(get, set): Array<String>;

    /**
     * Priority is zero for none, otherwise is clamped to 1 through 5
     */
    public var taskPriority(get, set): Int;

    public function new(element: Xml, parent: Null<Topic> = null) {
        this.element = element;
        this.parent = parent;
    }

    /**
     * Create a new child topic at the given offset
     */
    public function newChild(x: Float, y: Float): Topic {
        final newElem = Xml.createElement("topic");
        newElem.set("uuid", vendored.Uuid.v1());
        element.addChild(newElem);
        final newTopic = new Topic(newElem, this);
        final now = newTopic.modifyDate();
        newElem.set("created", now);
        newTopic.position = {x: x, y: y};
        return newTopic;
    }

    /**
     * Remove this topic. Does nothing if this is the root topic.
     */
    public function remove() {
        final p = parent;
        if(p == null) return;
        p.element.removeChild(element);
    }

    /**
     * Move this topic to the new parent. Does nothing if this is the root topic.
     */
    public function moveTo(newParent: Topic) {
        if(parent == null) return;
        newParent.element.addChild(element);
        parent = newParent;
    }

    /**
     * Set the modified date to now and return the string
     */
    public function modifyDate(): String {
        final now = DateTools.format(Date.now(), "%Y-%m-%dT%H:%M:%S");
        element.set("modified", now);
        return now;
    }

    function get_type(): TopicType {
        if(element.get("floating") == "1") return floating;
        if(element.get("callout") == "1") return callout;
        return topic;
    }

    function set_type(type: TopicType) {
        switch type {
            case floating: { 
                element.remove("callout");
                element.set("floating", "1");
            }
            case callout: {
                element.remove("floating");
                element.set("callout", "1");
            }
            default:
        }
        return type;
    }

    function get_children() {
        final children = new Array<Topic>();

        for(el in element.elementsNamed("topic")) {
            children.push(new Topic(el, this));
        }

        return children;
    }

    function get_uuid() {
        final uuid = element.get("uuid");
        if(uuid == null) return "";
        return uuid;
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

    function getBoolProp(name: String) {
        final value = element.get(name);
        if(value == null) return false;
        return value == "1";
    }

    function setBoolProp(name: String, value: Bool) {
        if(value) {    
            element.set(name, "1");
        } else {
            element.remove(name);
        }
        return value;
    }

    function get_boundary() {
        return getBoolProp("boundary");
    }

    function set_boundary(boundary: Bool) {
        return setBoolProp("boundary", boundary);
    }

    function get_folded() {
        return getBoolProp("folded");
    }

    function set_folded(folded: Bool) {
        return setBoolProp("folded", folded);
    }

    function get_position() {
        var position = element.get("position");
        if(position == null) return {x: 0.0, y: 0.0};

        // reduce string to two comma-separated floats
        position = StringTools.replace(position, "{", "");
        position = StringTools.replace(position, "}", "");
        position = StringTools.replace(position, " ", "");
        
        var values = position.split(",");
        if(values.length != 2) return {x: 0.0, y: 0.0};
        final x = Std.parseFloat(values[0]);
        final y = Std.parseFloat(values[1]);

        if(x == null || y == null) return {x: 0.0, y: 0.0};

        return return {x: x, y: y};
    }

    function set_position(position: {x: Float, y: Float}) {
        element.set("position", '{${position.x}, ${position.y}}');
        return position;
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

    function get_link(): Null<String> {
        return element.get("link");
    }

    // link should be html escaped before being passed in
    function set_link(link: Null<String>) {
        if(link == null) {
            element.remove("link");
            return link;
        }

        element.set("link", link);
        return link;
    } 

    function get_resources() {
        final resources = element.get("resources");
        if(resources == null) return new Array<String>();
        return resources.split(",");
    }

    // link should be html escaped before being passed in
    function set_resources(resources: Array<String>) {
        if(resources.length == 0) {
            element.remove("resources");
            return resources;
        }

        element.set("resources", resources.join(","));
        return resources;
    } 

    function get_taskPriority() {
        final priority = element.get("task-priority");
        if(priority == null) return 0;
        final value = Std.parseInt(priority);
        if(value == null || value < 1 || value > 5) return 0;
        return value;
    }

    function set_taskPriority(taskPriority: Int) {
        if(taskPriority == 0) {
            element.remove("task-priority");
            return 0;
        }

        if(taskPriority < 1) taskPriority = 1;
        if(taskPriority > 5) taskPriority = 5;

        element.set("task-priority", '$taskPriority');
        return taskPriority;
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