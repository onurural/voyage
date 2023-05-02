// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:async';
import 'dart:io';

import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;



import '../ui-components/saved-documents-components/add-options-bottom-sheet.dart';
import '../ui-components/saved-documents-components/custom-floating-action-button.dart';
import '../ui-components/saved-documents-components/document-grid-tile.dart';
import '../ui-components/saved-documents-components/image-viewer-screen.dart';
import '../ui-components/saved-documents-components/pdf-viewer-screen.dart';
import '../ui-components/saved-documents-components/rename-dialog.dart';

class SavedDocumentsScreen extends StatefulWidget {
  const SavedDocumentsScreen({Key? key}) : super(key: key);

  @override
  State<SavedDocumentsScreen> createState() => _SavedDocumentsScreenState();
}

class _SavedDocumentsScreenState extends State<SavedDocumentsScreen> {
  late Directory appDirectory;
  List<File> files = [];
  Set<File> selectedFiles = <File>{};
  bool selectMode = false;

  @override
  void initState() {
    super.initState();
    getApplicationDirectory();
  }
  List<Widget> _appBarActions(BuildContext context) {
    return [

        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.select_all),
            onPressed: () {
              if (selectedFiles.length == files.length) {
                selectedFiles.clear();
              } else {
                selectedFiles = files.toSet();
              }
              setState(() {});
            },
          ),
        ),

        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.delete),
            onPressed: selectedFiles.isEmpty
                ? null
                : () async {
              for (var file in selectedFiles)  {
                await file.delete();
              }
              setState(() {
                selectMode = false;
                selectedFiles.clear();
              });
              loadFiles();
            },
          ),
        ),
      Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.drive_file_rename_outline_sharp),
          onPressed: selectedFiles.isEmpty
              ? null
              : () async {
            for (var file in selectedFiles)  {
              final newName = await showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return RenameDialog(
                      path.basenameWithoutExtension(file.path)
                  );
                },
              );
              final newFile = File(
                '${file.parent.path}/$newName${path.extension(file.path)}',
              );
              await file.rename(newFile.path);
            }
            setState(() {
              selectMode = false;
              selectedFiles.clear();

            });
            loadFiles();

          },
        ),
      ),

    ];
  }

  Future<void> getApplicationDirectory() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    appDirectory = Directory('${appDocDirectory.path}/Documents');
    if (!(await appDirectory.exists())) {
      await appDirectory.create();
    }
    loadFiles();
  }


  Future<void> loadFiles() async {
    files = (await appDirectory.list().toList()).cast<File>();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(37, 154, 180, 100),
        title: const Text('Documents and Photos'),
        actions: _appBarActions(context),
          automaticallyImplyLeading: false
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: files.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (context, index) {
            File file = files[index];
            return DocumentGridTile(
              file: file,
              refresh: loadFiles,
              onTap: () => openViewer(context, file),
              onLongPress: () {
                setState(() {
                  selectMode = true;
                  selectedFiles.add(file);
                });
              },
              selected: selectedFiles.contains(file),
              onSelectChanged: (isSelected) {
                setState(() {
                  if (isSelected) {
                    selectedFiles.add(file);
                  } else {
                    selectedFiles.remove(file);
                  }
                  if (selectedFiles.isEmpty) {
                    selectMode = false;
                  }
                });
              },
            );
          },
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () => _addFile(context),
      ),
    );
  }

  void _addFile(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return const AddOptionsBottomSheet();
      },
    );
    if (result == 'photo') {
      await _addPhoto(context);
    } else if (result == 'document') {
      await _addDocument(context);
    } else if (result == 'scan') {
      _scanDocument(context);
    }
  }

  Future<void> _addPhoto(BuildContext context) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Uint8List? compressedImageData =
          await FlutterImageCompress.compressWithFile(
        pickedImage.path,
        quality: 80,
      );
      final newName = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return RenameDialog(
              path.basenameWithoutExtension(pickedImage.path)
          );
        },
      );
      if(newName!=null){
        File compressedImage = File(
            '${appDirectory.path}/$newName.jpg');
        await compressedImage.writeAsBytes(compressedImageData as List<int>);
        loadFiles();
      }

    }
  }

  Future<void> _addDocument(BuildContext context) async {
    var pickedFiles = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (pickedFiles != null) {
      File file = File(pickedFiles.files.first.path!);
      final newName = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return RenameDialog(
              path.basenameWithoutExtension(file.path)
          );
        },
      );
      if(newName!=null){
        await file.copy(
            '${appDirectory.path}/$newName${path.extension(file.path)}');
        loadFiles();
      }

    }
  }

  void openViewer(BuildContext context, File file) {
    if (path.extension(file.path) == '.pdf') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFViewerScreen( file,loadFiles),
        ),
      );
    } else if (path.extension(file.path) == '.jpg' ||
        path.extension(file.path) == '.jpeg' ||
        path.extension(file.path) == '.png') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ImageViewerScreen( file,loadFiles),
        ),
      );
    }
  }

  void _scanDocument(BuildContext context) async {
    var image = await DocumentScannerFlutter.launch(context, labelsConfig: {
      ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL: 'Next Step',
      ScannerLabelsConfig.ANDROID_OK_LABEL: 'OK'

    });
    if (image != null) {
      Uint8List? compressedImageData =
          await FlutterImageCompress.compressWithFile(
        image.path,
        quality: 80,
      );
      final newName = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return RenameDialog(
              path.basenameWithoutExtension(image.path)
          );
        },
      );
      if(newName!=null){
        File compressedImage = File(
            '${appDirectory.path}/$newName.jpg');
        await compressedImage.writeAsBytes(compressedImageData as List<int>);
        loadFiles();
      }

    }
  }
}







