package ithoughts.reader;

import haxe.io.BytesOutput;
import haxe.zip.Writer;
import haxe.zip.Entry;
import sys.io.File;
import haxe.io.Bytes;
import haxe.io.Input;
import haxe.ds.List;
import ithoughts.model.*;

class Reader {

    var mapXml: Null<Xml>;

    public function new(filePath: String) {
        final zipFile = File.read(filePath, true);
        final entriesIn = haxe.zip.Reader.readZip(zipFile);
        zipFile.close();

        final entriesOut = new List<Entry>();

        for(entry in entriesIn) {
            if(entry.fileName == "mapdata.xml") {
                final mapData = haxe.zip.Reader.unzip(entry);
                var xmlString = mapData.getString(0, mapData.length, UTF8);
                mapXml = Xml.parse(xmlString);

                final map = new MindMap(mapXml);
                final root = map.rootTopic;

                if(root.shape != null) trace(root.shape.asString());
                root.text = "Hello World&#xA;" + root.text;
                root.color = "FFFF00";
                root.shape = rounded;
                xmlString = mapXml.toString();
                
                final bytes = Bytes.ofString(xmlString);
                final newEntry: Entry = {
                    fileName: "mapdata.xml", 
                    fileSize: bytes.length,
                    fileTime: Date.now(),
                    compressed: false,
                    dataSize: 0,
                    data: bytes,
                    crc32: haxe.crypto.Crc32.make(bytes)
                };                
                entriesOut.add(newEntry);

                //break;
            }
            else {
               entriesOut.add(entry);
            }
        }

        final outBuffer = File.write("/Users/nickmain/Desktop/test-out.itmz", true);
        final zipWriter = new Writer(outBuffer);

        zipWriter.write(entriesOut);
        outBuffer.flush();
        outBuffer.close();
        // final fileOut = File.write(filePath, true);
        // final zipWriter = new haxe.zip.Writer(fileOut);

        // fileOut.close();
    }

    public function read() {
     
    }
}