import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/city-search-bar/city_bloc.dart';
import '../../bloc/city-search-bar/city_event.dart';
import '../../bloc/city-search-bar/city_state.dart';

class SearchBarView extends StatefulWidget {
   String cityName='';
  SearchBarView({Key? key}) : super(key: key);

  @override
  State<SearchBarView> createState() => _SearchBarViewState();
}

class _SearchBarViewState extends State<SearchBarView> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  bool _showDropdown = false;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (value.isNotEmpty) {
        context.read<CityBloc>().add(FetchCities(value.toLowerCase()));
        setState(() {
          _showDropdown = true;
        });
      }
    });
  }

  void _onCitySelected(String city) {
    _controller.text = city;
    widget.cityName=city;
    setState(() {
      _showDropdown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          onChanged: _onSearchChanged,
          decoration: const InputDecoration(
              labelText: 'Search',
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(Icons.settings_input_component_outlined),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)))),
        ),
        const SizedBox(height: 20),
        if (_showDropdown)
          BlocConsumer<CityBloc, CityState>(
            listener: (context, state) {
              if (state is CityError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is CityLoading) {
                return CircularProgressIndicator();
              } else if (state is CityLoaded) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    shrinkWrap: true,
                    itemCount: state.cities.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        title: Text(state.cities[index]),
                        onTap: () => _onCitySelected(state.cities[index]),
                      );
                    },
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
      ],
    );
  }
}