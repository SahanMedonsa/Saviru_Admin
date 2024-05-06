import 'package:app/Farmer/detail_row.dart';
import 'package:app/components/Colorpallet.dart';
import 'package:app/models/RestockModel.dart';
import 'package:app/services/Restock_db_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RestockContainer extends StatefulWidget {
  const RestockContainer({super.key});

  @override
  State<RestockContainer> createState() => _RestockContainerState();
}

final RestockDatabaseServices _databaseServices = RestockDatabaseServices();

class _RestockContainerState extends State<RestockContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.forest_Green.withOpacity(0.2),
      body: StreamBuilder<QuerySnapshot<Restock>>(
        stream: _databaseServices.getRestock(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          List restocks = snapshot.data?.docs ?? [];

          if (restocks.isEmpty) {
            return const Center(child: Text('Add Farmers'));
          }
          return ListView.builder(
            itemCount: restocks.length,
            itemBuilder: (context, index) {
              Restock restock = restocks[index].data();
              // String farmerId = farmers[index].id;
              // print(farmerId);

              return Expanded(
                child: Card(
                  child: ExpansionTile(
                    title: Text(
                      restock.district,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(''),
                        Text(DateFormat("dd-MM-yyyy h:mm a")
                            .format(restock.requestDate.toDate())),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            DetailRow(
                                detail: "Carrote",
                                fdetail:
                                    restock.carrotAmount.toString() + ' kg'),
                            DetailRow(
                                detail: "Potato",
                                fdetail:
                                    restock.potatoAmount.toString() + ' kg'),
                            DetailRow(
                                detail: "Cabbage",
                                fdetail:
                                    restock.cabbageAmount.toString() + ' kg'),
                            DetailRow(
                                detail: "Capcicum",
                                fdetail:
                                    restock.capsicumAmount.toString() + ' kg'),
                            DetailRow(
                                detail: "Beans",
                                fdetail:
                                    restock.beansAmount.toString() + ' kg'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
