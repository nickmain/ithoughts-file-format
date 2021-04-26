package ithoughts.model;

enum abstract GroupType(Int) to Int {
    var boundary = 0;
    var rectangle = 1;
    var circle = 2;
    var oval = 3;

    static final cases = [boundary, rectangle, circle, oval];
    public static function fromString(s: Null<String>): GroupType {
        if(s == null) return boundary;
        final i = Std.parseInt(s);
        if(i == null) return boundary;

        if(i >= 0 && i < cases.length) {
            return cases[i];
        }

        return boundary;
    }
}

class Group extends Element {

    public var color(get, set): Null<String>;
    public var type(get, set): GroupType;
    public var memberUuids(get, never): Array<String>;

    public function new(element: Xml) {
        super(element);
    }

    public function addMemberUuid(uuid: String) {
        var index = 0;
        while(true) {
            var member = getStringProp('member${index}');
            if(member == null) {
                setStringProp('member${index}', uuid);
                break;
            }
            index++;
        }
    }

    function get_memberUuids(): Array<String> {
        var uuids = new Array<String>();
        var index = 0;
        while(true) {
            var member = getStringProp('member${index}');
            if(member == null) break;
            uuids.push(member);
            index++;
        }

        return uuids;
    }

    function get_color(): Null<String> {
        return getStringProp("color");
    }

    function set_color(color: Null<String>) {
        return setStringProp("color", color);
    }         

    function get_type(): GroupType {
        return GroupType.fromString(element.get("type"));
    }

    function set_type(type: GroupType) {
        var typeInt: Int = type;
        element.set("type", Std.string(typeInt));
        return type;
    } 
}