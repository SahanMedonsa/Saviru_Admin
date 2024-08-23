import 'package:adminapp/components/Colorpallet.dart';
import 'package:adminapp/components/Gtext.dart';
import 'package:adminapp/fertilizer/outlet_create_form.dart';
import 'package:flutter/material.dart';

class FertilizerOutlet extends StatefulWidget {
  const FertilizerOutlet({super.key});

  @override
  State<FertilizerOutlet> createState() => _FertilizerOutletState();
}

class _FertilizerOutletState extends State<FertilizerOutlet> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create a new fertiler Outlet.'),
        content: FertilizerOutletForm(),
        
      ),
    );
  }

    return Scaffold(
      appBar: AppBar(
        title: Text('Fertilizer Outlet Details'),
      ),
      backgroundColor: ColorPalette.forest_Green.withOpacity(0.2),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                width: width*0.5,
              //  color: Colors.amber,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Gtext(
                            text: "Create a new outlet",
                            size: 20,
                            color: Colors.black,
                            fweight: FontWeight.bold),
                        ElevatedButton(
                          onPressed: () {
                          _showAlertDialog(context);
                          },
                          
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                          ),
                          child: Gtextn(
                            text: "Add",
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            //2nd row
             Expanded(
              flex: 5,
              child: Container(
                width: width*0.5,
               // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gtext(
                        text: "Outlet Details",
                        size: 20,
                        color: Colors.black,
                        fweight: FontWeight.bold),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
