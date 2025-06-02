import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../exports_config.dart';

class LocMarker extends Marker {
  LocMarker({required this.loc, required this.selected})
    : super(
    point: LatLng(loc.latitude, loc.longitude),
    width: 80.0,
    height: 80.0,
    builder: (ctx) => Icon(
      MdiIcons.mapMarker,
      color: selected ? crimeRed : appDB,
      size: 50.0, // TODO spin off this and any other hardcoded sizes gh#81
    ),
    // Worked out by trial and error; 15 would be middle but icon doesn't fill its 50 box
    anchorPos: AnchorPos.exactly(Anchor(40.0, 20.0)),
  );
  final Loc loc;
  bool selected;
}


/*class MarkerWithPopup extends StatefulWidget {
  const MarkerWithPopup({
    required Loc loc,
    required this.marker});

  //final Loc loc;
  final Marker marker;

  @override
  State<StatefulWidget> createState() {
    return _MarkerWithPopupState();
  }
}

class _MarkerWithPopupState extends State<MarkerWithPopup> {

  @override
  void initState() {
    super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return PopupMarkerLayerWidget(

    );
    // TODO: implement build
    throw UnimplementedError();
  }
}*/
