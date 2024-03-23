import 'package:flutter/material.dart';

class ToggleIconButton extends StatefulWidget {
  final IconData initialIcon;
  final IconData toggledIcon;
  final Function? onPressed;

  const ToggleIconButton({
    Key? key,
    this.onPressed,
    required this.initialIcon,
    required this.toggledIcon,
  }) : super(key: key);

  @override
  _ToggleIconButtonState createState() => _ToggleIconButtonState();
}

class _ToggleIconButtonState extends State<ToggleIconButton> {
  late IconData currentIcon;

  @override
  void initState() {
    super.initState();
    currentIcon = widget.initialIcon;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(currentIcon),
      onPressed: () {
        setState(() {
          currentIcon = (currentIcon == widget.initialIcon)
              ? widget.toggledIcon
              : widget.initialIcon;

          widget.onPressed?.call();
        });
      },
    );
  }
}
