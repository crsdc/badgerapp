import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../config/colours.dart';
import '../config/sizes.dart';
import '../config/textstyles.dart';
import '../logic/map_manager.dart';

class MapDisplayChip extends StatefulWidget {

  final MapManager mapManager;
  final ValueListenable<bool> listenable;
  final IconData icon;
  final String text;

  const MapDisplayChip({
    Key? key,
    required this.mapManager,
    required this.listenable,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  State<MapDisplayChip> createState() => _MapDisplayChip();
}

class _MapDisplayChip extends State<MapDisplayChip> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.listenable,
      builder: (context, notifiedToggle, _) {
        return ActionChip(
          avatar: CircleAvatar(
            child: Icon(widget.icon),
          ),
          label: Text(
            widget.text,
            style: TextStyle(
                color: notifiedToggle ? Colors.white : Colors.black
            ),
          ),
          backgroundColor: notifiedToggle ? Colors.blue : softBackground,
          onPressed: () {},
        );
      }
    );
  }
}
