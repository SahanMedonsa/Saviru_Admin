import 'package:app/Layout/dimensions.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget desktopBody;
  final Widget mobileBody;
  const ResponsiveLayout(
      {super.key, required this.desktopBody, required this.mobileBody});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobilewidth) {
          return mobileBody;
        } else {
          return desktopBody;
        }
      },
    );
  }
}
