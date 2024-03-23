import 'package:app/components/Gtext.dart';
import 'package:app/components/colorPallet.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.05, horizontal: width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Gtext(
                    text: 'Home Screen',
                    size: 20,
                    color: ColorPalette.appBar_color,
                    fweight: FontWeight.bold)
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            SizedBox(
              width: width * 1 / 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Gtext(
                      text: ' Farmer',
                      size: 18,
                      color: ColorPalette.appBar_color,
                      fweight: FontWeight.w500),
                  MaterialButton(
                    color: ColorPalette.button_color,
                    onPressed: () {},
                    child: const Gtext(
                        text: 'Add',
                        size: 15,
                        color: ColorPalette.appBar_color,
                        fweight: FontWeight.w500),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
