import ithoughts.model.Topic;
import vendored.Uuid;
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

        trace(root.taskStart);
        trace(root.taskDue);

        for(c in root.children) {
            final pos = c.position;
            trace('${c.uuid} -- ${c.type} --> "${c.text}" : $pos');

            if(c.text == "Also Floating") {
                c.taskStart = Date.now();
                c.textFont = root.textFont;
                c.textSize = root.textSize;
                c.textColor = "3333FF";                
            }

            if(c.text == "Floating") {
                c.text = "Callout";
                c.type = callout;
                c.taskCost = rolledUp;

                final a = c.newChild(-150, -30);
                final b = c.newChild(-150, 30);
                final aa = a.newChild(-100, 0);
                a.text = "A";
                b.text = "B";
                aa.text = "AA";
                c.boundary = true;
                a.boundary = true;
                aa.taskPriority = 4;
                a.taskCost = root.taskCost;
                b.taskCost = cost(3);
            }

            if(c.text == "Child") child = c;
            if(c.text == "Hello") hello = c;

            for(d in c.children) {
                if(d.text == "Hello") hello = d;
            }
        }

        if(child != null && hello != null) {
            child.moveTo(hello);
            child.position = {x: 100, y: 50};
            child.resources = ["foo", "bar"];
            child.folded = true;
            child.taskProgress = rollUp;
            hello.taskProgress = notStarted;
        }

        file.writeTo("/Users/nickmain/Desktop/test-out.itmz");
    }
}