import 'package:app/components/Colorpallet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Gtext extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight fweight;

  const Gtext(
      {super.key,
      required this.text,
      required this.size,
      required this.color,
      required this.fweight});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.roboto(
            color: color, fontSize: size, fontWeight: fweight));
  }
}

class Gtextn extends StatelessWidget {
  final String text;

  const Gtextn({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.roboto(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500));
  }
}

class Gtextfd extends StatelessWidget {
  final String text;

  const Gtextfd({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.roboto(
            color: ColorPalette.appBar_color,
            fontSize: 16,
            fontWeight: FontWeight.w400));
  }
}

class Gtextnm extends StatelessWidget {
  final String text;

  const Gtextnm({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.roboto(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal));
  }
}
