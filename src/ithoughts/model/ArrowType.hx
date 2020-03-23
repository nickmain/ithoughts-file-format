package ithoughts.model;

enum abstract ArrowType(Int) {
    var none = 0;
    var arrow = 1;
    var ball = 2;

    static final cases = [none, arrow, ball];
    public static function fromString(s: Null<String>): ArrowType {
        if(s == null) return none;
        final i = Std.parseInt(s);
        if(i == null) return none;

        if(i >= 0 && i < cases.length) {
            return cases[i];
        }

        return none;
    }

    static final names = ["none", "arrow", "ball"];
    public function asString() {
        return names[this];
    }
}