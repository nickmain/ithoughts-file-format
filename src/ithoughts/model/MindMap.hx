package ithoughts.model;

/**
    The map data entry of the iThoughts file
**/
class MindMap {
    var document: Xml;

    public var rootTopic(get, never): Null<Topic>;
    public var relationships(get, never): Array<Relationship>;

    public function new(document: Xml) {
        this.document = document;
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

    function get_relationships() {
        final relationships = new Array<Relationship>();
        final root = document.firstElement();

        for(rels in root.elementsNamed("relationships")) {
            for(relationship in rels.elementsNamed("relationship")) {
                relationships.push(new Relationship(relationship));
            }            
        }

        return relationships;
    }
}