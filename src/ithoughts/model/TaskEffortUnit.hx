package ithoughts.model;

enum abstract TaskEffortUnit(String) to String {
    var hours = "h";
    var minutes = "m";
    var years = "y";
    var months = "mnth";
    var weeks = "w";
    var days = "d";

    public static function from(s: Null<String>): TaskEffort {
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