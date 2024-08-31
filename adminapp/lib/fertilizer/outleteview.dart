import 'package:adminapp/models/fertilize_outlet_model.dart';
import 'package:adminapp/services/outlet_fert_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OutletView extends StatefulWidget {
  const OutletView({Key? key}) : super(key: key);

  @override
  _OutletViewState createState() => _OutletViewState();
}

class _OutletViewState extends State<OutletView> {
  final FertilizerOutletDatabaseServices _fertilizerOutletService = FertilizerOutletDatabaseServices();
  List<FertilizerOutlet> _outlets = [];
  List<FertilizerOutlet> _filteredOutlets = [];
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _fetchOutlets();
  }

  Future<void> _fetchOutlets() async {
    // Fetching all the outlets from the database
    Stream<QuerySnapshot<FertilizerOutlet>> stream = _fertilizerOutletService.getFertilizerOutlets();
    stream.listen((snapshot) {
      setState(() {
        _outlets = snapshot.docs.map((doc) => doc.data()).toList();
        _filteredOutlets = _outlets; // Initialize with all outlets
      });
    });
  }

  void _filterOutlets(String searchText) {
    setState(() {
      _filteredOutlets = _outlets
          .where((outlet) => outlet.outletNo.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: width * 0.5,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    _searchText = value;
                    _filterOutlets(_searchText); // Call to filter outlets based on input
                  },
                  decoration: InputDecoration(
                    labelText: 'Search by Outlet No',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredOutlets.length,
                  itemBuilder: (context, index) {
                    FertilizerOutlet outlet = _filteredOutlets[index];
                    return Card(
                      child: ListTile(
                        title: Text(outlet.outletNo, style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Manager: ${outlet.manager}'),
                            Text('Address: ${outlet.address}'),
                            Text('Phone: ${outlet.phoneNum}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
