package ithoughts.model;

/**
    The topic tree entry of the iThoughts file
**/
class MindMap {
    var document: Xml;

    public var rootTopic(get, never): Null<Topic>;

    public function new(document: Xml) {
        this.document = document;
    }

    function get_rootTopic(): Null<Topic> {
        final root = document.firstElement();
        for(topics in root.elementsNamed("topics")) {
            return new Topic(topics.firstElement());
        }
        return null;
    }
}