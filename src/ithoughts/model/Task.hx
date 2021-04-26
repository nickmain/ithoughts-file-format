package ithoughts.model;

enum Cost {
    notSet;
    rolledUp;
    cost(value: Float);
}

enum Effort {
    none;
    effort(value: Float, unit: EffortUnit);
    rollUp(unit: EffortUnit);
}

enum abstract EffortUnit(String) to String {
    var hours = "h";
    var minutes = "m";
    var years = "y";
    var months = "mnth";
    var weeks = "w";
    var days = "d";

    public static function from(s: Null<String>): Effort {
        if(s == null) return none;
        final unit = 
             if(StringTools.endsWith(s, months)) months;
        else if(StringTools.endsWith(s, hours)) hours;
        else if(StringTools.endsWith(s, minutes)) minutes;
        else if(StringTools.endsWith(s, years)) years;
        else if(StringTools.endsWith(s, weeks)) weeks;
        else if(StringTools.endsWith(s, days)) days;
        else return none;

        var unitLength = switch unit {
            case months: 4;
            default: 1;
        }
        final numStr = s.substr(0, s.length - unitLength);
        final value = Std.parseFloat(numStr);
        if(value == null) return none;
        if(value < 0) return rollUp(unit);
        return effort(value, unit);
    }
}

enum abstract Progress(Int) {
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

    public static function fromString(s: Null<String>): Null<Progress> {
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