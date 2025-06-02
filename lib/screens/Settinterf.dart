import '../exports_config.dart';

class Settinterf extends StatefulWidget {
  @override
  State<Settinterf> createState() => _SettinterfState();
}

class _SettinterfState extends State<Settinterf> {
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {

    // Create a new LiveReport
    LiveReport liveReport = LiveReport.fresh();
    liveReport.activeReport.incidentType = IncidentType.settinterf;

    return Scaffold(
      backgroundColor: appBackground,
      appBar: appBarOneLineWithHome(
        titleText: 'Sett interference',
        context: context,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[

            const Row(
              children: [
                Padding(
                  padding: outsideButtonDoubleTop,
                  child: Text(
                    'Do you know the cause?',
                    style: lTStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),

            // Menu of buttons, 2 each row
            Row(
              children: <Widget>[
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight4,
                  buttonText: 'Forestry or\ntree surgery',
                  pressFunction: () {
                    liveReport.activeReport.interfType = InterfType.forestry;
                    Navigator.of(context).pushNamed(sSettinterf1, arguments: liveReport);
                  },
                  buttonPos: MenuButtonPos.topleft,
                ),
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight4,
                  buttonText: 'Farming',
                  pressFunction: () {
                    liveReport.activeReport.interfType = InterfType.farming;
                    Navigator.of(context).pushNamed(sSettinterf1, arguments: liveReport);
                  },
                  buttonPos: MenuButtonPos.topright,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight4,
                  buttonText: 'Development\nwork or road\nconstruction',
                  pressFunction: () {
                    liveReport.activeReport.interfType = InterfType.development;
                    Navigator.of(context).pushNamed(sSettinterf1, arguments: liveReport);
                  },
                  buttonPos: MenuButtonPos.midleft,
                ),
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight4,
                  buttonText: 'Hunt-related',
                  pressFunction: () {
                    liveReport.activeReport.interfType = InterfType.hunt;
                    Navigator.of(context).pushNamed(sSettinterf2, arguments: liveReport);
                  },
                  buttonPos: MenuButtonPos.midright,
                  softWrap: true,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight4,
                  buttonText: 'Badger\ndiggers',
                  pressFunction: () {
                    liveReport.activeReport.interfType = InterfType.diggers;
                    Navigator.of(context).pushNamed(sSettinterf2, arguments: liveReport);
                  },
                  buttonPos: MenuButtonPos.midleft,
                ),
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight4,
                  buttonText: 'Poisoning\nor gassing',
                  pressFunction: () {
                    liveReport.activeReport.interfType = InterfType.poisoning;
                    Navigator.of(context).pushNamed(sSettinterf2, arguments: liveReport);
                  },
                  buttonPos: MenuButtonPos.midright,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight4,
                  buttonText: 'Other',
                  pressFunction: () {
                    liveReport.activeReport.interfType = InterfType.other;
                    Navigator.of(context).pushNamed(sSettinterf3, arguments: liveReport);
                  },
                  buttonPos: MenuButtonPos.bottomleft,
                ),
                MenuButton(
                  buttonType: MenuButtonType.standard,
                  height: buttonHeight4,
                  buttonText: 'Cause\nunknown',
                  pressFunction: () {
                    liveReport.activeReport.interfType = InterfType.unknown;
                    Navigator.of(context).pushNamed(sSettinterf3, arguments: liveReport);
                  },
                  buttonPos: MenuButtonPos.midright,
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
