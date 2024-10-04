import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

List<bool> isSelected = [true, false, false, false, false];

class BottomNavBarMenuWidget extends StatefulWidget {
  final int index;
  final IconData icon;
  final String label;
  final String navDestination;
  const BottomNavBarMenuWidget({
    super.key,
    required this.index,
    required this.icon,
    required this.label,
    required this.navDestination,
  });

  @override
  State<BottomNavBarMenuWidget> createState() => _BottomNavBarMenuWidgetState();
}

class _BottomNavBarMenuWidgetState extends State<BottomNavBarMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 5, //-4
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              color: isSelected[widget.index] == true
                  ? Colors.green
                  : Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              widget.label,
              style: TextStyle(
                color: isSelected[widget.index] == true
                    ? Colors.green
                    : Colors.white,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Beamer.of(context).beamToNamed('/${widget.navDestination}');
        setState(() {
          for (int i = 0; i < isSelected.length; i++) {
            if (widget.index != i) isSelected[i] = false;
            isSelected[widget.index] = true;
          }
        });
      },
    );
  }
}
