// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart' as path;
import 'package:voyage/ui-components/saved-documents-components/rename-dialog.dart';
class PDFViewerScreen extends StatefulWidget {
  final File file;
  final VoidCallback refresh;


  const PDFViewerScreen(this.file, this.refresh, {super.key});

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  int _currentPage = 1;
  int? _totalPages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.7),
        elevation: 0,
        title: Text(
          path.basenameWithoutExtension(widget.file.path),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 1.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () async {
              await widget.file.delete();
              widget.refresh();
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
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
      body: PDFView(
        filePath: widget.file.path,
        onRender: (pages) {
          setState(() {
            _totalPages = pages;
          });
        },
        onViewCreated: (PDFViewController pdfViewController) {
          setState(() {
          });
        },
        onPageChanged: (page, total) {
          setState(() {
            _currentPage = (page! + 1);
            _totalPages = total;
          });
        },
      ),
      floatingActionButton: _totalPages == null
          ? null
          : FloatingActionButton(
        onPressed: () {},
        child: Text('$_currentPage/$_totalPages',
            style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}