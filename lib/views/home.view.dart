import 'package:flutter/material.dart';
import '../ui-components/ui-elements.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.menu_outlined),
            onPressed: () {
              // TODO: Open Sidebar Menu
            },
          ),
         SearchBarView(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [Text('Trending Destination'), Text('See all')],
          ),
          Row(
            children: [
              Expanded(
                  child: SizedBox(
                height: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: ((context, index) =>
                        PlaceCardView( 'Place Card'))),
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [Text('Category'), Text('See all')],
          ),
          Row(
            children: [
              Expanded(
                  child: SizedBox(
                height: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 11,
                    itemBuilder: ((context, index) =>
                        PlaceCardView( 'Country Card'))),
              ))
            ],
          ),
        ],
      )),
      bottomNavigationBar: BottomNavigationBarView(),
    );
  }
}

// MARK: Using Block
// BlocBuilder<CounterBloc, int>(
//             builder: (context, count) {
//               return Text('$count', style: Theme.of(context).textTheme.headline1);
//             },
//           ),
// MARK: Using Block
//           FloatingActionButton(
//             child: const Icon(Icons.exposure_minus_1_rounded),
//             onPressed: () => context.read<CounterBloc>().add(Decrement()
//             )
//           ),