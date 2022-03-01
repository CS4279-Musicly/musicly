import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';

class UploadPDF {

  Future<firebase_storage.UploadTask> uploadFile(File file) async {

    firebase_storage.UploadTask uploadTask;

    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('files')
        .child('/some-file.pdf');

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
      file = File.fromRawPath(result.files.first.bytes!);
    }

    //print("HERE");
    //print(result?.files.first.path);
    //firebase_storage.UploadTask task = await uploadFile(file!);
    return file;
  }
}