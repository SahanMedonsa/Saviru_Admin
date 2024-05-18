import 'package:adminapp/Transpotation/RestockContainer.dart';
import 'package:adminapp/components/Colorpallet.dart';
import 'package:adminapp/components/Gtext.dart';
import 'package:flutter/material.dart';

class TransportPage extends StatefulWidget {
  const TransportPage({super.key});

  @override
  State<TransportPage> createState() => _TransportPageState();
}

class _TransportPageState extends State<TransportPage> {
  List<Map<String, dynamic>> vegetables = [
    {'name': '', 'amount': 0}
  ];
  String selectedGrade = 'A';
  double selectedGradePrice = 0;
  double enteredPrice = 0;
  double distance = 0;
  double tottal_vege = 0;
  double totalPrice = 0;
  int numofwagen = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorPalette.forest_Green.withOpacity(0.2),
      body: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Transport Cost calculation',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Add vegetables and Amount ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: vegetables.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Vegetable'),
                                onChanged: (value) {
                                  vegetables[index]['name'] = value;
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Amount (ton)'),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  vegetables[index]['amount'] =
                                      int.tryParse(value) ?? 0;
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              vegetables.add({'name': '', 'amount': 0});
                            });
                          },
                          child: Text('Add Vegetable'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Total Vegetables: ${vegetables.fold(0, (sum, item) => sum + item['amount'] as int)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select your Good wagons Type',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'A : Eight wheeled wagon with a loading capacity up to 28 Tons - 3000',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'B : Eight wheeled wagon with a loading capacity up to 39.6 Tons - 4000',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'C : Eight wheeled wagon with a loading above to 39.6 Tons - 4500',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: selectedGrade,
                      items: ['A', 'B', 'C']
                          .map((grade) => DropdownMenuItem(
                                value: grade,
                                child: Text(grade),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedGrade = value!;
                          if (value == 'A') {
                            selectedGradePrice = 3000;
                          } else if (value == 'B') {
                            selectedGradePrice = 4000;
                          } else if (value == 'C') {
                            selectedGradePrice = 4500;
                          }
                        });
                      },
                      decoration: InputDecoration(
                          label: Text('Select Good wagons Type ')),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Enter Num of wagens'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          numofwagen = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText:
                              'Enter Distance from Colombo fort to Badulla (292km)'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          distance = double.tryParse(value) ?? 0;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Enter Rate per Ton -per Km'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          enteredPrice = double.tryParse(value) ?? 0;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Price: ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${vegetables.fold(0, (sum, item) => sum + item['amount'] as int) * enteredPrice * distance * numofwagen + selectedGradePrice}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Calculate price for 01 ton :',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              // Calculate the total price using the function
                              totalPrice = calculateTotalPrice(
                                  vegetables,
                                  enteredPrice.toInt(),
                                  distance.toInt(),
                                  selectedGradePrice.toInt());
                            });
                          },
                          child: Text('Calculate'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Price for 1 ton:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Price for 1kg:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${(totalPrice / 1000).toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              child: Column(
                children: [
                  //vege containers
                  Container(
                    height: height,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Gtext(
                              text: 'Re Stock Requests',
                              size: 25,
                              color: Colors.black,
                              fweight: FontWeight.w600),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              height: height * 1 / 2, child: RestockContainer())
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double calculateTotalPrice(List<Map<String, dynamic>> vegetables,
      int enteredPrice, int distance, int selectedGradePrice) {
    int totalAmount =
        vegetables.fold(0, (sum, item) => sum + (item['amount'] as int));
    double totalPrice = ((totalAmount * enteredPrice * distance * numofwagen) +
            selectedGradePrice) /
        totalAmount;
    return totalPrice;
  }
}
