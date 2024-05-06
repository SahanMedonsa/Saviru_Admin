import 'package:app/Transpotation/RestockContainer.dart';
import 'package:app/Transpotation/transportaion.dart';
import 'package:app/components/Button/Toggle_button.dart';
import 'package:app/pages/Farmer.dart';
import 'package:app/pages/FarmerDetails.dart';
import 'package:app/pages/Fertilizer.dart';
import 'package:app/pages/Home.dart';
import 'package:app/pages/Transport.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final List<Widget> _pages = [
    TransportPage(),
    Home(),
    FarmerPage(),
    Fertilizer(),
  ];

  bool isExpanded = true;
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: isExpanded,
            useIndicator: false,
            minWidth: 80,
            unselectedIconTheme: const IconThemeData(color: Colors.black),
            selectedIconTheme: const IconThemeData(color: Colors.white),
            selectedLabelTextStyle: const TextStyle(color: Colors.white),
            unselectedLabelTextStyle: const TextStyle(color: Colors.black),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                  icon: Icon(Icons.person), label: Text('Farmer')),
              NavigationRailDestination(
                  icon: Icon(Icons.shopping_basket), label: Text('Fertilizer')),
              NavigationRailDestination(
                  icon: Icon(Icons.train), label: Text('Transpotation'))
            ],
            leading: ToggleIconButton(
              initialIcon: Icons.arrow_forward_ios,
              toggledIcon: Icons.arrow_back_ios,
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_horiz_rounded),
              onPressed: () {},
            ),
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            selectedIndex: _selectedIndex,
          ),
          Expanded(child: _pages[_selectedIndex]),

          //button
        ],
      ),
    );
  }
}
