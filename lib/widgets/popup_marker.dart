import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_map/flutter_map.dart';

import '../logic/loc.dart';
import 'marker_withpopup.dart';


class LocPopup extends StatefulWidget {
  final LocMarker locMarker;

  const LocPopup(this.locMarker, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LocPopupState();
}

class _LocPopupState extends State<LocPopup> {
  /*final List<IconData> _icons = [
    Icons.star_border,
    Icons.star_half,
    Icons.star
  ];
  int _currentIcon = 0;*/

  @override
  Widget build(BuildContext context) {
    return Card(
      /*child: InkWell(
        onTap: () => setState(() {
          _currentIcon = (_currentIcon + 1) % _icons.length;
        }),*/
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _cardDescription(context),
          // TODO reinstate so we can do deletions
          /*Padding(
            padding: const EdgeInsets.only(left: 4, right: 8),
            child: Icon(Icons.delete),
          ),*/
        ],
      ),
    );
  }

  Widget _cardDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        //constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.locMarker.loc.mnemonicLabel,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
            Text(
              widget.locMarker.loc.gridRefText,
              style: const TextStyle(fontSize: 12.0),
            ),
            Text(
              // TODO format the string
              widget.locMarker.loc.createdDateTime.substring(0, 16),
              style: const TextStyle(fontSize: 12.0),
            ),
            /*Text(
              'Position: ${widget.locMarker.point.latitude}, ${widget.locMarker.point.longitude}',
              style: const TextStyle(fontSize: 12.0),
            ),*/

          ],
        ),
      ),
    );
  }
}








class ExamplePopup extends StatefulWidget {
  final Marker marker;

  const ExamplePopup(this.marker, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExamplePopupState();
}

class _ExamplePopupState extends State<ExamplePopup> {
  final List<IconData> _icons = [
    Icons.star_border,
    Icons.star_half,
    Icons.star
  ];
  int _currentIcon = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => setState(() {
          _currentIcon = (_currentIcon + 1) % _icons.length;
        }),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Icon(_icons[_currentIcon]),
            ),
            _cardDescription(context),
          ],
        ),
      ),
    );
  }

  Widget _cardDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Popup for a marker!',
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Text(
              'Position: ${widget.marker.point.latitude}, ${widget.marker.point.longitude}',
              style: const TextStyle(fontSize: 12.0),
            ),
            Text(
              'Marker size: ${widget.marker.width}, ${widget.marker.height}',
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}
