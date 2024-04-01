import 'package:app/components/Gtext.dart';
import 'package:flutter/material.dart';

class DetailContainer extends StatefulWidget {
  final String ctext;
  final String count;
  final IconData Cicon;
  final Color Ccolor;
  const DetailContainer({
    Key? key,
    required this.Cicon,
    required this.ctext,
    required this.count,
    required this.Ccolor,
  }) : super(key: key);

  @override
  State<DetailContainer> createState() => _DetailContainerState();
}

class _DetailContainerState extends State<DetailContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: widget.Ccolor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // IconButton(onPressed: (){}, icon: widget.Cicon,iconSize: ,),
            SizedBox(
                width: 50,
                height: 50,
                child: Icon(
                  widget.Cicon,
                  size: 50,
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Gtext(
                  text: widget.ctext,
                  size: 15,
                  color: Colors.black,
                  fweight: FontWeight.w700,
                ),
                Gtext(
                  text: widget.count,
                  size: 25,
                  color: Colors.black,
                  fweight: FontWeight.w700,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
