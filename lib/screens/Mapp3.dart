//import 'dart:async';

//import 'package:flutter_map/flutter_map.dart';
//import 'package:flutter_map_dragmarker/dragmarker.dart';
//import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
//import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
//import 'package:get_it/get_it.dart';
//import 'package:latlong2/latlong.dart';
//import 'package:location/location.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:what3words/what3words.dart' as w3w;

import 'package:badger/logic/map_manager.dart';
import 'package:badger/widgets/map_coordentry.dart';
import 'package:latlong2/latlong.dart';

import '../exports_config.dart';
import '../widgets/map_coorddisplay.dart';
import '../widgets/map_displaychiprow.dart';
import '../widgets/map_embedmap.dart';





class Mapp3 extends StatefulWidget {
  @override
  State<Mapp3> createState() => _Mapp3State();
}

class _Mapp3State extends State<Mapp3> {

  //MapManager mapManager = MapManager();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: appBarColor,
        title: const Text('Map3'),
      ),

      body: GestureDetector(
        // Take focus from text field when another part of screen tapped
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: const Column(
          children: [

            Padding(
              padding: outsideButtonAll,
              child: Text(
                // TODO only talk about saved locations if there are any
                'Mark the incident location by tapping the map, entering an OS grid reference, or using a saved location.',
                style: mTStyle,
              ),
            ),


            PillButton(
                buttonType: PillButtonType.standard,
                buttonText: 'moo',
                //pressFunction:
            ),


            /*MapCoordEntry(mapManager: mapManager),

            MapDisplayChipRow(mapManager: mapManager),

            MapCoordDisplay(mapManager: mapManager),

            // ugly displays to delete once others working
            ValueListenableBuilder<String>(
              valueListenable: mapManager.notifierGridref,
              builder: (context, notifiedGridRef, _) {
                print('grid ref in UI: $notifiedGridRef');
                return Text(
                  notifiedGridRef,
                  style: sTStyle,
                );
              },
            ),
            ValueListenableBuilder<String>(
              valueListenable: mapManager.notifierLatlong,
              builder: (context, notifiedLatlong, _) {
                print('latlong on UI: $notifiedLatlong');
                return Text(
                  notifiedLatlong,
                  style: sTStyle,
                );
              },
            ),*/

            /*Flexible(
              child: EmbedMap2(
                mapManager: mapManager,
                startingCentre: LatLng(52.9, -1.9),
                startingZoom: 6.0,
              ),
            ),*/


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
