package ithoughts.model;

enum abstract RelationshipType(Int) {
    var curved = 0;
    var straight = 1;
    var angled = 2;
    var summary = 3;

    static final cases = [curved, straight, angled, summary];
    public static function fromString(s: Null<String>): RelationshipType {
        if(s == null) return curved;
        final i = Std.parseInt(s);
        if(i == null) return curved;

        if(i >= 0 && i < cases.length) {
            return cases[i];
        }

        return curved;
    }

    static final names = ["curved", "straight", "angled", "summary"];
    public function asString() {
        return names[this];
    }
}