import ithoughts.model.IThoughtsFile;

class Main {

    public static function main() {
        trace("Hello World!");

        final file = new IThoughtsFile("test/Test.itmz");

        final map = file.mindmap;
        final root = map.rootTopic;
        trace(root.text);
        root.text = "Hello World !!!\n" + root.text;
        root.color = "FFFF88";
        root.shape = rounded;
        root.note = "String has various methods for manipulating text. 

These method does not change the original string,        
but return a new one instead. 
See the String API documentation for all string methods.
";

        file.writeTo("/Users/nickmain/Desktop/test-out.itmz");
    }
}