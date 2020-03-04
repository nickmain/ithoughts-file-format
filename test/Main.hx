import ithoughts.reader.Reader;

class Main {

    public static function main() {
        trace("Hello World!");

        new Reader("test/iThoughtsFileFormat.itmz").read();
    }
}