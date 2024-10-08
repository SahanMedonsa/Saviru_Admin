import 'package:adminapp/components/Button/Toggle_button.dart';
import 'package:adminapp/components/Gtext.dart';
import 'package:adminapp/pages/Farmer.dart';
import 'package:adminapp/pages/Fertilizer.dart';
import 'package:adminapp/pages/Home.dart';
import 'package:adminapp/pages/Transport.dart';
import 'package:adminapp/pages/fertilizer_outlet.dart';
import 'package:adminapp/pages/vegecollection.dart';
import 'package:adminapp/pages/vegesatatus.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final List<Widget> _pages = [
    FarmerPage(),
    Home(),
    Fertilizer(),
    TransportPage(),
    vegeCollection(),
    Vegesatatus(),
    FertilizerOutlet(),
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
                  label: Text(
                    "Home",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  )),
              NavigationRailDestination(
                  icon: Icon(Icons.person),
                  label: Text(
                    'Blog',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  )),
              NavigationRailDestination(
                  icon: Icon(Icons.shopping_basket),
                  label: Text(
                    'Fertilizer',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  )),
              NavigationRailDestination(
                  icon: Icon(Icons.train),
                  label: Text(
                    'Transpotation',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  )),
              NavigationRailDestination(
                  icon: Icon(Icons.collections),
                  label: Text(
                    'Vege Collections',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  )),
              NavigationRailDestination(
                  icon: Icon(Icons.stacked_bar_chart),
                  label: Text(
                    'Vege Status',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  )),
              NavigationRailDestination(
                  icon: Icon(Icons.shop_2_outlined),
                  label: Text(
                    'fertilizer Outlet',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ))
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
