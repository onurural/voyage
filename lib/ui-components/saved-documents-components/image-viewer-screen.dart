import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:voyage/ui-components/saved-documents-components/rename-dialog.dart';
import 'package:path/path.dart' as path;
class ImageViewerScreen extends StatefulWidget {
  final File file;
  final VoidCallback refresh;


  ImageViewerScreen(this.file, this.refresh);

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.7),
        elevation: 0,
        title: Text(
          path.basenameWithoutExtension(widget.file.path),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 1.5,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: () async {
              await widget.file.delete();
              widget.refresh();
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () async {
              final newName = await showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return RenameDialog(
                      path.basenameWithoutExtension(widget.file.path)
                  );
                },
              );
              if (newName != null) {
                final newFile = File(
                  '${widget.file.parent.path}/$newName${path.extension(widget.file.path)}',
                );
                await widget.file.rename(newFile.path);
                widget.refresh();
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: PhotoView(
          imageProvider: FileImage(widget.file),
        ),
      ),
    );
  }
}