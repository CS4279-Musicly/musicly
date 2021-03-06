import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseFiles {

  Future<firebase_storage.UploadTask> uploadFile(File file, String name) async {

    firebase_storage.UploadTask uploadTask;

    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('files')
        .child('/' + name + '.pdf');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'file/pdf',
        customMetadata: {'picked-file-path': file.path});
    print("Uploading..!");

    uploadTask = ref.putData(await file.readAsBytes(), metadata);

    print("done..!");
    return Future.value(uploadTask);
  }

  Future<File?> getFiles() async {
    File? file;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf']);

    if (result != null) {
      file = File(result.files.first.path!);
    }

    //print("HERE");
    //print(result?.files.first.path);
    //firebase_storage.UploadTask task = await uploadFile(file!);
    return file;
  }

  /// Shows a pop up error box when the incorrect password is entered.
  noSelectionDialog(BuildContext context) {
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      content: const Text('Error: Please Select a File'),
      actions: [
        CupertinoDialogAction(
          child: const Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    return showCupertinoDialog(
      context: context,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> downloadMusicFile(BuildContext context, String name) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? numFiles = prefs.getInt("numMusicFiles") ?? 0;
    File downloadToFile = File('${appDocDir.path}/' + name + (numFiles).toString() +'.pdf');

    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('files/$name.pdf')
        .writeToFile(downloadToFile);

    prefs.setInt("numMusicFiles", numFiles + 1);
    prefs.setStringList(numFiles.toString(), [name, downloadToFile.path]);
  }

  Future<void> downloadDrillFile(BuildContext context, String name) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? numFiles = prefs.getInt("numDrillFiles") ?? 0;
    File downloadToFile = File('${appDocDir.path}/' + name + (numFiles).toString() +'.pdf');

    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('files/$name.pdf')
        .writeToFile(downloadToFile);

    prefs.setInt("numDrillFiles", numFiles + 1);
    prefs.setStringList(numFiles.toString(), [name, downloadToFile.path]);
  }
}