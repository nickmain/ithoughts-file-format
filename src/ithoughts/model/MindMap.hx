package ithoughts.model;

import haxe.ds.StringMap;

/**
    The map data entry of the iThoughts file
**/
class MindMap {
    var document: Xml;

    public var rootTopic(get, never): Null<Topic>;
    public var relationships(get, never): Array<Relationship>;
    public var groups(get, never): Array<Group>; //rear-most to front-most

    // Lazy map of initial topics by uuid. Not updated when new topics are added.
    public var topics(get, never): StringMap<Topic>;
    private var topicMap: Null<StringMap<Topic>>;

    public function new(document: Xml) {
        this.document = document;
    }

    function get_topics(): StringMap<Topic> {
        if(topicMap != null) return topicMap;
        final map = new StringMap<Topic>();
        topicMap = map;
        addTopicToMap(map, rootTopic);
        return map;
    }

    // recursive mapping of topics
    function addTopicToMap(map: StringMap<Topic>, topic: Null<Topic>) {
        if(topic == null) return;
        map.set(topic.uuid, topic);
        for(child in topic.children) addTopicToMap(map, child);
    }

    public function removeAllGroups() {
        final root = document.firstElement();
        final groups = root.elementsNamed("groups");
        if(groups.hasNext()) {
            root.removeChild(groups.next());
        }
    }

    public function addGroup(topics: Array<Topic>): Group {
        final root = document.firstElement();
        final groups = root.elementsNamed("groups");

        var container = if(groups.hasNext()) {
            groups.next();
        } else {
            final newElem = Xml.createElement("groups");
            root.addChild(newElem);
            final dummyGroup = Xml.createElement("group");
            newElem.addChild(dummyGroup);
            dummyGroup.set("type", "-1");
            newElem;
        }

        final newElem = Xml.createElement("group");
        final group = new Group(newElem);
        container.addChild(newElem);

        group.type = boundary;
        group.color = "FFFF00";
        for(topic in topics) group.addMemberUuid(topic.uuid);
        return group;
    }

    public function addRelationship(fromTopic: Topic, toTopic: Topic): Relationship {
        final root = document.firstElement();
        final rels = root.elementsNamed("relationships");

        var container = if(rels.hasNext()) {
            rels.next();
        } else {
            final newElem = Xml.createElement("relationships");
            root.addChild(newElem);
            newElem;
        }

        final newElem = Xml.createElement("relationship");
        newElem.set("uuid", vendored.Uuid.v1());
        newElem.set("end1-uuid", fromTopic.uuid);
        newElem.set("end2-uuid", toTopic.uuid);        
        container.addChild(newElem);
        final rel = new Relationship(newElem);
        rel.startArrow = none;
        rel.endArrow = arrow;
        rel.color = "00FF00";
        rel.type = curved;
        return rel;
    }

    function get_rootTopic(): Null<Topic> {
        final root = document.firstElement();
        for(topics in root.elementsNamed("topics")) {
            return new Topic(topics.firstElement());
        }
        return null;
    }

    function get_relationships(): Array<Relationship> {
        final relationships = new Array<Relationship>();
        final root = document.firstElement();

        for(rels in root.elementsNamed("relationships")) {
            for(relationship in rels.elementsNamed("relationship")) {
                relationships.push(new Relationship(relationship));
            }            
        }

        return relationships;
    }

    function get_groups(): Array<Group> {
        final groups = new Array<Group>();
        final root = document.firstElement();

        for(gg in root.elementsNamed("groups")) {
            for(g in gg.elementsNamed("group")) {
                var group = new Group(g);
                if(group.color == null) continue;
                groups.push(group);
            }            
        }

        return groups;
    }
}