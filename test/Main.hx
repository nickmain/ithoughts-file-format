import haxe.rtti.CType.ClassField;
import haxe.ds.StringMap;
import ithoughts.model.IconNames;
import ithoughts.model.Topic;
import ithoughts.model.IThoughtsFile;

class Main {

    public static function main() {
        trace("Hello World!");

        final file = new IThoughtsFile("test/Test.itmz");

        final map = file.mindmap;
        final root = map.rootTopic;
        root.text = "<u>Hello World</u>\n" + root.text;
        root.color = "DDCC88";
        root.shape = rounded;
        root.textAlignment = Topic.TextAlignCenter;
        root.link = "http://www.cnn.com";
        root.note = "String has various methods for manipulating text.

These method does not change the original string,
but return a new one instead.

See the String API documentation for all string methods.
";
        var hello: Null<Topic> = null;
        var child: Null<Topic> = null;
        var also: Null<Topic> = null;
        var floating: Null<Topic> = null;
        var empty: Null<Topic> = null;

        trace(root.taskStart);
        trace(root.taskDue);

        for(c in root.children) {
            final pos = c.position;
            trace('${c.uuid} -- ${c.type} --> "${c.text}" : $pos');

            if(c.text == "") empty = c;

            if(c.text == "Also Floating") {
                also = c;
                c.taskStart = Date.now();
                c.textFont = root.textFont;
                c.textSize = root.textSize;
                c.textColor = "3333FF";                
                trace(c.taskEffort);
            }

            if(c.text == "Floating") {
                floating = c;
                c.text = "Callout";
                c.type = callout;
                c.taskCost = rolledUp;

                final a = c.newChild(-200, -40);
                final b = c.newChild(-200, 40);
                final aa = a.newChild(-100, 0);
                a.text = "A";
                b.text = "B";
                aa.text = "AA";
                c.boundary = true;
                a.boundary = true;
                aa.taskPriority = 4;
                a.taskCost = root.taskCost;
                b.taskCost = cost(3);
                a.taskEffort = effort(45, minutes);
                b.taskEffort = effort(4.5, hours);
                c.taskEffort = rollUp(days);

                a.icons = [IconNames.icon_heart, IconNames.arrow_down_blue];
            }

            if(c.text == "Child") child = c;
            if(c.text == "Hello") hello = c;

            for(d in c.children) {
                if(d.text == "Hello") hello = d;
            }
        }

        if(child != null && empty != null) {
            final rel = map.addRelationship(empty, child);
            rel.type = straight;
            rel.centerText = "New\nRelation";
        }

        if(child != null && hello != null) {
            child.moveTo(hello);
            child.position = {x: 150, y: 50};
            child.resources = ["foo", "bar"];
            child.folded = true;
            child.taskProgress = rollUp;
            hello.taskProgress = notStarted;
            child.taskEffort = rollUp(minutes);
            hello.position = {x: 150, y: 0};
        }

        if(also != null && floating != null) {
            floating.icons = also.icons;
        }

        for(rel in map.relationships) {
            trace('relationship ${rel.uuid} from ${rel.startUuid} to ${rel.endUuid}');
            trace('  ${rel.type.asString()} ${rel.startArrow.asString()}: ${rel.startText} -- ${rel.centerText} --> ${rel.endText} ${rel.endArrow.asString()}');

            if(rel.startText == null) continue;
            rel.color = "FFFF88";
            rel.dashed = !rel.dashed;
            rel.centerText = "Foo\nBar";
            rel.type = angled;
            rel.startArrow = ball;
            rel.offset = {x: -250, y: -120};            
        }

        var groupTopics = new StringMap<String>();
        for(group in map.groups) {            
            group.type = switch group.type {
                case boundary: rectangle;
                case rectangle: circle;
                case circle: oval;
                case oval: boundary;
            }

            for(uuid in group.memberUuids) groupTopics.set(uuid, uuid);
        }
        for(uuid in groupTopics.keys()) {
            var topic = map.topics.get(uuid);
            if(topic != null) {
                final pos = topic.position;
                topic.position = {x: pos.x, y: pos.y -100};
            }
        }

        final c1 = empty.newChild(150, -40);
        final c2 = empty.newChild(150, 0);
        final c3 = empty.newChild(150, 40);
        c1.text = "One"; c1.color = "FF0000";
        c2.text = "Two"; c2.color = "00FF00";
        c3.text = "Three"; c3.color = "0000FF";
        final c4 = empty.newChild(200, 0);
        c4.text = "Four"; c4.color = "FFFF00";
        c4.summary1 = c1.uuid;
        c4.summary2 = c2.uuid;

        file.writeTo("/Users/nickmain/Desktop/test-out.itmz");
    }
}