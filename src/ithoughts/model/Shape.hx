package ithoughts.model;

enum abstract Shape(Int) {
    var rounded = 0;
    var rectangle = 1;
    var oval = 2;
    var underline = 3;
    var none = 4;
    var squareBracket = 5;
    var curvedBracket = 6;
    var circle = 7;
    var diamond = 8;
    var parallelogram = 9;
    var pill = 10;
    var square = 11;
    var triangle = 12;

    static final cases = [rounded, rectangle, oval, underline, none, squareBracket, curvedBracket, circle, diamond, parallelogram, pill, square, triangle];
    public static function fromString(s: Null<String>): Null<Shape> {
        if(s == null) return null;
        final i = Std.parseInt(s);
        if(i == null) return null;

        if(i >= 0 && i < cases.length) {
            return cases[i];
        }

        return null;
    }

    static final names = ["rounded", "rectangle", "oval", "underline", "none", "squareBracket", "curvedBracket", "circle", "diamond", "parallelogram", "pill", "square", "triangle"];
    public function asString() {
        return names[this];
    }
}