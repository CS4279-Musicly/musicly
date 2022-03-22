import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:musicly/views/pdf_view.dart';

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

  Future<void> downloadFile(BuildContext context) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File('${appDocDir.path}/DynamiteDownload.pdf');

    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('files/Dynamite.pdf')
        .writeToFile(downloadToFile);

    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) =>
            PDFScreen(path: '${appDocDir.path}/DynamiteDownload.pdf'),
      ),
    );
  }
}