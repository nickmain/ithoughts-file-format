package ithoughts.model;

class Element {
    final element: Xml;

    public var uuid(get, never): String;

    public function new(element: Xml) {
        this.element = element;
    }

    function get_uuid() {
        final uuid = element.get("uuid");
        if(uuid == null) return "";
        return uuid;
    }    

    function getStringProp(name: String): Null<String> {
        return element.get(name);
    }

    function setStringProp(name: String, value: Null<String>) {
        if(value == null) {
            element.remove(name);
            return null;
        }

        element.set(name, value);
        return value;
    }     
}