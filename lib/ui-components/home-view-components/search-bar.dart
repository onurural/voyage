
// ignore_for_file: file_names

import 'package:flutter/material.dart';
class SearchBar extends StatefulWidget {

  final List<String> data;



 const SearchBar(this.data, {super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  @override
  Widget build(BuildContext context) {
    // Filter the data based on the search text
    return Material(
      color: Colors.transparent,
      child: TextField(

        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,

          hintText: 'Search City',
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(


            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.blueAccent),
          ),
        ),
      ),
    );
  }
}
