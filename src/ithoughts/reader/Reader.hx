package ithoughts.reader;

import sys.io.File;
import haxe.io.Bytes;
import haxe.io.Input;

class Reader {

    var mapXml: Null<Xml>;

    public function new(filePath: String) {
        var zipFile = File.read(filePath, true);
        var zipReader = new haxe.zip.Reader(zipFile);

        for(entry in zipReader.read()) {
            if(entry.fileName == "mapdata.xml") {
                var mapData = haxe.zip.Reader.unzip(entry);
                var xmlString = mapData.getString(0, mapData.length, UTF8);
                mapXml = Xml.parse(xmlString);
                break;
            }
        }

        zipFile.close();
    }

    public function read() {
        trace(mapXml.toString());
    }
}