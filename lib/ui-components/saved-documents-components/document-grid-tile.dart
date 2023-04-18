import 'dart:io';
import 'dart:typed_data';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:pdf_render/pdf_render.dart';
import 'package:shimmer/shimmer.dart';
import 'package:image/image.dart' as img;
import 'pdf-viewer-screen.dart';
import 'image-viewer-screen.dart';

class DocumentGridTile extends StatefulWidget {
  final File file;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool selected;
  final ValueChanged<bool>? onSelectChanged;
  final VoidCallback refresh;

  const DocumentGridTile({
    Key? key,
    required this.file,
    this.onTap,
    this.selected = false,
    this.onSelectChanged,
    this.onLongPress,
    required this.refresh
  }) : super(key: key);

  @override
  _DocumentGridTileState createState() => _DocumentGridTileState();
}

class _DocumentGridTileState extends State<DocumentGridTile> {
  late Future<Image> thumbnailFuture;
  Icon uncheckedIcon=Icon(Icons.check_circle_outline,color: Colors.white,size: 30,);
  Icon checkedIcon=Icon(Icons.check_circle_rounded,color: Colors.white,size: 30,);
  @override
  void initState() {
    super.initState();
    thumbnailFuture = getThumbnail(widget.file);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onSelectChanged != null) {
          widget.onSelectChanged!(!widget.selected);
        } else {
          widget.onTap?.call();
        }
      },
      onLongPress: () {
        if (widget.onSelectChanged != null) {
          widget.onSelectChanged!(!widget.selected);
        } else {
          widget.onLongPress?.call();
        }
      },
      child: Stack(
        children: [
          OpenContainer(
            closedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            openShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            closedColor: Colors.grey.shade200,
            openColor: Theme.of(context).scaffoldBackgroundColor,
            closedBuilder: (context, action) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: GridTile(
                  header: GridTileBar(
                    title: Text(
                      path.basenameWithoutExtension(widget.file.path),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    backgroundColor: Colors.black45,
                  ),
                  child: path.extension(widget.file.path) == '.pdf'
                      ? FutureBuilder<Image>(
                          future: thumbnailFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Image(image: snapshot.data!.image);
                            } else {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  color: Colors.white,
                                ),
                              );
                            }
                          },
                        )
                      : Image.file(
                          widget.file,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(child: Icon(Icons.error));
                          },
                        ),
                ),
              );
            },
            openBuilder: (context, action) {
              return path.extension(widget.file.path) == '.pdf'
                  ? PDFViewerScreen(widget.file,widget.refresh)
                  : ImageViewerScreen( widget.file,widget.refresh);
            },
          ),

            Positioned(
              top: 8,
              right: 8,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black.withOpacity(0.5),
                ),
                child: AnimatedCrossFade(firstChild: checkedIcon ,secondChild: uncheckedIcon, crossFadeState: widget.selected ? CrossFadeState.showFirst : CrossFadeState.showSecond, duration: Duration(milliseconds: 200), )
                ),
              ),

        ],
      ),
    );
  }

  Future<Image> getThumbnail(File file) async {
    final document = await PdfDocument.openFile(file.path);
    final page = await document.getPage(1);
    final pageImage = await page.render(
        width: page.width.toInt(), height: page.height.toInt());
    img.Image pngImage = img.Image.fromBytes(
        page.width.toInt(), page.height.toInt(), pageImage.pixels,
        format: img.Format.rgba);
    List<int> pngBytes = img.encodePng(pngImage);
    return Image.memory(Uint8List.fromList(pngBytes));
  }
}
