package ithoughts.model;

enum abstract TaskProgress(Int) {
    var notStarted = 0;
    var _10 = 10;
    var _25 = 25;
    var _35 = 35;
    var _50 = 50;
    var _65 = 65;
    var _75 = 75;
    var _90 = 90;    
    var complete = 100;
    var rollUp = 101;

    public static function fromString(s: Null<String>): Null<TaskProgress> {
        if(s == null) return null;
        final value = Std.parseInt(s);
        if(value == null) return null;

        if(value <= 0) return notStarted;
        if(value <= 10) return _10;
        if(value <= 25) return _25;
        if(value <= 35) return _35;
        if(value <= 50) return _50;
        if(value <= 65) return _65;
        if(value <= 75) return _75;
        if(value <= 90) return _90;
        if(value <= 100) return complete;
        return rollUp;
    }
}