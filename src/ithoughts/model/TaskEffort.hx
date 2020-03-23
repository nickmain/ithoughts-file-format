package ithoughts.model;

enum TaskEffort {
    none;
    effort(value: Float, unit: TaskEffortUnit);
    rollUp(unit: TaskEffortUnit);
}