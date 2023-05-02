// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';

class AddOptionsBottomSheet extends StatefulWidget {
  const AddOptionsBottomSheet({Key? key}) : super(key: key);

  @override
  _AddOptionsBottomSheetState createState() => _AddOptionsBottomSheetState();
}

class _AddOptionsBottomSheetState extends State<AddOptionsBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Column(
        children: [
          _buildOptionTile(
            context,
            title: 'Add Photo',
            icon: Icons.photo_camera,
            color: Colors.purple,
            onTap: () => Navigator.pop(context, 'photo'),
          ),
          _buildOptionTile(
            context,
            title: 'Add Document',
            icon: Icons.description,
            color: Colors.blue,
            onTap: () => Navigator.pop(context, 'document'),
          ),
          _buildOptionTile(
            context,
            title: 'Scan Document',
            icon: Icons.document_scanner,
            color: Colors.orange,
            onTap: () => Navigator.pop(context, 'scan'),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(
      BuildContext context, {
        required String title,
        required IconData icon,
        required Color color,
        required VoidCallback onTap,
      }) {
    return ListTile(
      title: FadeTransition(
        opacity: _animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.5),
            end: Offset.zero,
          ).animate(_animation),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
      ),
      leading: FadeTransition(
        opacity: _animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.5),
            end: Offset.zero,
          ).animate(_animation),
          child: Icon(
            icon,
            color: color,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
