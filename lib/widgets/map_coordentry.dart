//import 'package:badger/exports_config.dart';

import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../config/colours.dart';
import '../config/sizes.dart';
import '../logic/map_manager.dart';

class MapCoordEntry extends StatefulWidget {

  final MapManager mapManager;

  const MapCoordEntry({
    Key? key,
    required this.mapManager,
  }) : super(key: key);

  @override
  State<MapCoordEntry> createState() => _MapCoordEntryState();
}

class _MapCoordEntryState extends State<MapCoordEntry> {

  final TextEditingController _gridRefFormController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(outsideButton, 0.0, outsideButton / 2, 0.0),
            child: SizedBox(
              height: 36, // might need to mess with this
              child: ValueListenableBuilder<String>(
                valueListenable: widget.mapManager.notifierGridref,
                builder: (context, notifiedGridRef, _) {
                  _gridRefFormController.text = notifiedGridRef;
                  return TextFormField(
                    // TODO max length, and test with whitespace and symbols
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.map), // TODO make it poss to enter latlong
                      hintText: 'Grid reference',
                      fillColor: Colors.white,
                      filled: true,
                      //suffixIcon: _clearButton(), TODO REINSTATE
                    ),
                    controller: _gridRefFormController,
                    keyboardType: TextInputType.text,
                  );
                },
              ),




            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(outsideButton / 2, 0.0, outsideButton, 0.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: crimeRed,
            ),
            onPressed: () {
              widget.mapManager.applyGridref(_gridRefFormController.text);
            },
            child: const Icon(MdiIcons.mapMarkerPlus),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Dispose of controllers
    try {
      _gridRefFormController.dispose();
    } catch (e) {
      print('ERROR disposing of controllers on Mapp: $e');
    }
    super.dispose();
  }

}
