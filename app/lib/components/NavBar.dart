import 'package:app/components/Button/Toggle_button.dart';
import 'package:app/pages/Farmer.dart';
import 'package:app/pages/FarmerDetails.dart';
import 'package:app/pages/Home.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final List<Widget> _pages = [
    FarmerDetailsPAge(),
    const FarmerPage(),
    Container(
      color: Colors.amber,
    ),
    Container(
      color: Colors.green,
    ),
  ];
  bool isExpanded = false;
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: isExpanded,
            useIndicator: true,
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
                  icon: Icon(Icons.bar_chart), label: Text('Analitics')),
              NavigationRailDestination(
                  icon: Icon(Icons.settings), label: Text('Settings'))
            ],
            leading: ToggleIconButton(
              initialIcon: Icons.arrow_forward_ios,
              toggledIcon: Icons.arrow_back_ios,
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
