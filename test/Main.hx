import ithoughts.reader.Reader;

import haxe.macro.Context;

class Main {

    public static function main() {
        trace("Hello World!");

        new Reader("test/Test.itmz").read();        
    }
}