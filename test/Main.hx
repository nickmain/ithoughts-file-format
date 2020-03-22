import ithoughts.model.Topic;
import vendored.Uuid;
import ithoughts.model.IThoughtsFile;

class Main {

    public static function main() {
        trace("Hello World!");

        final file = new IThoughtsFile("test/Test.itmz");

        final map = file.mindmap;
        final root = map.rootTopic;
        root.text = "Hello World !!!\n" + root.text;
        root.color = "FFFF88";
        root.shape = rounded;
        root.link = "http://www.cnn.com";
        root.note = "String has various methods for manipulating text.

These method does not change the original string,
but return a new one instead.

See the String API documentation for all string methods.
";
        var hello: Null<Topic> = null;
        var child: Null<Topic> = null;

        for(c in root.children) {
            final pos = c.position;
            trace('${c.uuid} -- ${c.type} --> "${c.text}" : $pos');

            if(c.text == "Floating") {
                c.text = "Callout";
                c.type = callout;

                final a = c.newChild(-100, -20);
                final b = c.newChild(-100, 20);
                final aa = a.newChild(-100, 0);
                a.text = "A";
                b.text = "B";
                aa.text = "AA";
                c.boundary = true;
                a.boundary = true;
                aa.taskPriority = 4;
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
        }

        file.writeTo("/Users/nickmain/Desktop/test-out.itmz");
    }
}