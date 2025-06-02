import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../config/colours.dart';
import '../config/sizes.dart';
import '../config/textstyles.dart';
import '../logic/map_manager.dart';
import 'map_displaychip.dart';

class MapDisplayChipRow extends StatefulWidget {

  final MapManager mapManager;

  const MapDisplayChipRow({
    Key? key,
    required this.mapManager,
  }) : super(key: key);

  @override
  State<MapDisplayChipRow> createState() => _MapDisplayChipRow();
}

class _MapDisplayChipRow extends State<MapDisplayChipRow> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: 8.0,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MapDisplayChip(
                  mapManager: widget.mapManager,
                  listenable: widget.mapManager.notifierShowMylocDisplay,
                  icon: MdiIcons.folderMarker,
                  text: 'my locations',
                ),
                const SizedBox(
                  width: 4.0,
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MapDisplayChip(
                  mapManager: widget.mapManager,
                  listenable: widget.mapManager.notifierShowLatlongDisplay,
                  icon: MdiIcons.web,
                  text: 'lat/long',
                ),
                const SizedBox(
                  width: 4.0,
                ),
                MapDisplayChip(
                  mapManager: widget.mapManager,
                  listenable: widget.mapManager.notifierShowW3wDisplay,
                  icon: MdiIcons.cat,
                  text: 'w3w',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
