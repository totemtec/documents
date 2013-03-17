/*
   Photoshop Script ResizeRetinaToNormal.jsx
   Finds @2x.png image files for retina display in the specified folder and 
   resize them to the half size for normal display.
*/

// Keep the original unit and change it to pixcel
var strtRulerUnits = preferences.rulerUnits;
preferences.rulerUnits = Units.PIXELS;

// Select folder
var folder = Folder.selectDialog("Select a folder that contains @2x image files.");
var fileList = folder.getFiles("*@2x.png");
for (var s in fileList){
    var file = fileList[s];
    open(file);

    // resize image
    activeDocument.resizeImage(
        activeDocument.width / 2.0,
        activeDocument.height / 2.0,
        activeDocument.resolution,
        ResampleMethod.BICUBIC);
    
    var resizedFileName = activeDocument.name.match(/(.*)\@2x.[^\.]+$/)[1];

    // save
    var saveFile = new File(activeDocument.path + "/" + resizedFileName + ".png");

    var webSaveOptions = new ExportOptionsSaveForWeb();
    webSaveOptions.format = SaveDocumentType.PNG;
    webSaveOptions.PNG8 = false;
    webSaveOptions.transparency = true; 
    activeDocument.exportDocument(saveFile, ExportType.SAVEFORWEB, webSaveOptions);

    activeDocument.close(SaveOptions.DONOTSAVECHANGES);
}

// Revert the unit preference
preferences.rulerUnits = strtRulerUnits;
