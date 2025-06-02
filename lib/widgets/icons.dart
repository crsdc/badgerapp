import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../config/colours.dart';
import '../config/sizes.dart';

WidgetSpan extLinkIcon({
  Color color = hyperlinkIconColor,
}) {
  return WidgetSpan(
    child: Icon(
      MdiIcons.openInNew,
      size: sTSize,
      color: color,
    )
  );
}
