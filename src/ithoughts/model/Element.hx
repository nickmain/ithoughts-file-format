package ithoughts.model;

class Element {
    final element: Xml;

    public function new(element: Xml) {
        this.element = element;
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
    
    function getIntProp(name: String): Null<Int> {
        final value = element.get(name);
        if(value == null) return null;
        return Std.parseInt(value);
    }

    function setIntProp(name: String, value: Null<Int>) {
        if(value == null) {
            element.remove(name);
            return null;
        }

        element.set(name, '$value');
        return value;
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

    function getDateProp(name: String): Null<Date> {
        var s = element.get(name);
        if(s == null) return null;
        s = StringTools.replace(s, "T", " ");
        return Date.fromString(s);
    }

    function setDateProp(name: String, date: Null<Date>) {
        if(date == null) {
            element.remove(name);
            return null;
        }

        element.set(name, dateString(date));
        return date;
    }

    function dateString(date: Date): String {
        return DateTools.format(date, "%Y-%m-%dT%H:%M:%S");
    }

    function getNullableFloat(name: String): Null<Float> {
        final s = element.get(name);
        if(s == null) return null;
        return Std.parseFloat(s);
    }

    function setNullableFloat(name: String, value: Null<Float>) {
        if(value == null) {
            element.remove(name);
            return null;
        }

        element.set(name, '$value');
        return value;
    } 

    function getNullableString(name: String): Null<String> {
        return element.get(name);
    }

    function setNullableString(name: String, text: Null<String>) {
        if(text == null) {
            element.remove(name);
            return null;
        }

        text = StringTools.replace(text, "\n", "&#10;");
        element.set(name, text);
        return text;
    }   

    function getPosition(name: String) {
        var position = element.get(name);
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

    function setPosition(name: String, position: {x: Float, y: Float}) {
        element.set(name, '{${position.x}, ${position.y}}');
        return position;
    }
}