import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../config/colours.dart';
import '../config/sizes.dart';
import '../config/textstyles.dart';
import '../logic/map_manager.dart';

class MapCoordDisplay extends StatefulWidget {

  final MapManager mapManager;

  const MapCoordDisplay({
    Key? key,
    required this.mapManager,
  }) : super(key: key);

  @override
  State<MapCoordDisplay> createState() => _MapCoordDisplayState();
}

class _MapCoordDisplayState extends State<MapCoordDisplay> {

  // TODO spin off?
  Widget coordDisplayLine(ValueListenable listenable) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(outsideButton, 0.0, outsideButton, outsideButton / 2),
      child: Container(
        padding: const EdgeInsets.fromLTRB(outsideButton, outsideButton / 2, outsideButton, outsideButton / 2),
        color: softBackground,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ValueListenableBuilder<String>(
              valueListenable: widget.mapManager.notifierLatlong,
              builder: (context, notifiedLatlong, _) {
                return Text(
                  notifiedLatlong,
                  style: sTStyle,
                );
              },
            ),
            Text(widget.mapManager.notifierLatlong.value),
            // TODO reinstate
            //Icon(Icons.copy),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: widget.mapManager.notifierShowLatlongDisplay,
          builder: (context, notifiedToggle, _) {
            if (notifiedToggle) {
              return coordDisplayLine(widget.mapManager.notifierLatlong);
            } else {
              return const SizedBox.shrink();
            }
          }
        ),
        // TODO add a grid ref one if the entry field is set to latlong
        ValueListenableBuilder<bool>(
          valueListenable: widget.mapManager.notifierShowW3wDisplay,
          builder: (context, notifiedToggle, _) {
            if (notifiedToggle) {
              return coordDisplayLine(widget.mapManager.notifierW3w);
            } else {
              return const SizedBox.shrink();
            }
          }
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}
