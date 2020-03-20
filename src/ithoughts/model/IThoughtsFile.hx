package ithoughts.model;

import haxe.io.Bytes;
import haxe.zip.Writer;
import sys.io.File;
import haxe.zip.Reader;
import haxe.zip.Entry;
import haxe.ds.List;

class IThoughtsFile {

    final filePath: String;
    final zipEntries: List<Entry>;

    public var mindmap(get, never): Null<MindMap>;

    public function new(filePath: String) {
        this.filePath = filePath;
        final zipFile = File.read(filePath, true);
        zipEntries = Reader.readZip(zipFile);
        zipFile.close();
    }

    // Find and remove the given entry
    function grabEntry(name: String): Null<Entry> {
        for(entry in zipEntries) {
            if(entry.fileName == name) {
                zipEntries.remove(entry);
                return entry;
            }
        }

        return null;
    }

    var mapdataXml: Null<Xml>;
    function get_mindmap() : Null<MindMap> {
        if(mapdataXml == null) {
            final entry = grabEntry("mapdata.xml");
            if(entry == null) return null;
            final mapData = Reader.unzip(entry);
            if(mapData == null) return null;
            var xmlString = mapData.getString(0, mapData.length, UTF8);
            mapdataXml = Xml.parse(xmlString);
        }

        var xml = mapdataXml;
        if(xml != null) return new MindMap(xml);
        return null;
    }

    /**
        Write the contents to another file
    **/
    public function writeTo(newPath: String) {
        final entries = new List<Entry>();

        var xml = mapdataXml;
        if(xml != null) entries.add(makeXmlEntry("mapdata.xml", xml));

        for(e in zipEntries) entries.add(e);
        
        final outBuffer = File.write(newPath, true);
        final zipWriter = new Writer(outBuffer);

        zipWriter.write(entries);
        outBuffer.flush();
        outBuffer.close();        
    }

    /**
        Write the contents back to the same file
    **/
    public function overwrite() {
        writeTo(filePath);
    }

    function makeXmlEntry(name: String, xml: Xml): Entry {
        final xmlString = StringTools.replace(xml.toString(), "&amp;#10;", "&#10;");        

        final bytes = Bytes.ofString(xmlString);
        final newEntry: Entry = {
            fileName: name, 
            fileSize: bytes.length,
            fileTime: Date.now(),
            compressed: false,
            dataSize: 0,
            data: bytes,
            crc32: haxe.crypto.Crc32.make(bytes)
        };

        return newEntry;
    }
}