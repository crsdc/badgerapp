//import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../exports_config.dart';
import 'modal_badgersigns_contents.dart';

class BadgerSignListTile extends StatefulWidget {
  final BadgerSign signName;
  final String img;
  final String text;
  ChecklistBadgeractivityFormModel model;
  bool modelbool;
  BadgerSignListTile(this.signName, this.img, this.text, this.model, this.modelbool, {required ValueKey key});

  @override
  BadgerSignListTileState createState() => BadgerSignListTileState();
}

class BadgerSignListTileState extends State<BadgerSignListTile> {

  Widget checkboxOverlay(bool modelbool) {
    if (modelbool) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          height: 25,
          width: 25,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 20,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //contentPadding: EdgeInsets.symmetric(vertical: insideButton, horizontal: insideButton),
      contentPadding: insideButtonAll,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        //width: 100,
        //height: 100,
        //decoration: BoxDecoration(
        //image: DecorationImage(
        child: AspectRatio(
          aspectRatio: 1,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: FractionalOffset.topCenter,
                    image: AssetImage(widget.img),
                  )
                ),
              ),
              checkboxOverlay(widget.modelbool),
              /*Align(
                alignment: Alignment.center,
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
      title: Text(widget.text),
      trailing: GestureDetector(
        child: const Icon(
          Icons.info,
          size: 35,
          //color: crimeRed,
        ),
        onTap: () => badgerSignModal(widget.signName, context),
      ),
      //onTap: () => badgerSignModal(BadgerSign.foraging, context),
      onTap: () => setState(() {
        //super.setState(() {        });
        print(widget.modelbool);
        widget.modelbool = !widget.modelbool;
        print(widget.modelbool);
        print('TOGGLED ${widget.text}');
        switch(widget.signName) {
          case BadgerSign.entrance:
            widget.model.evidenceBadgersignEntrance = widget.modelbool;
            break;
          case BadgerSign.spoil:
            widget.model.evidenceBadgersignSpoil = widget.modelbool;
            break;
          case BadgerSign.bedding:
            widget.model.evidenceBadgersignBedding = widget.modelbool;
            break;
          case BadgerSign.pawprints:
            widget.model.evidenceBadgersignPawprints = widget.modelbool;
            break;
          case BadgerSign.hair:
            widget.model.evidenceBadgersignHair = widget.modelbool;
            break;
          case BadgerSign.scratch:
            widget.model.evidenceBadgersignScratch = widget.modelbool;
            break;
          case BadgerSign.latrine:
            widget.model.evidenceBadgersignLatrine = widget.modelbool;
            break;
          case BadgerSign.run:
            widget.model.evidenceBadgersignRun = widget.modelbool;
            break;
          case BadgerSign.foraging:
            widget.model.evidenceBadgersignForaging = widget.modelbool;
            break;
        }


        //model.evidenceBadgersignEntrance = true;
      }),
    );
  }
}

Widget badgerSignInfoTile(BadgerSign signName, String img, String text, BuildContext context) {
  return GestureDetector(
    child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          color: transpRed,
          padding: insideButtonAll,
          child: Text(
            text,
            textAlign: TextAlign.center,
            textWidthBasis: TextWidthBasis.longestLine,
            style: const TextStyle(
              color: textWhite,
              fontSize: mTSize,
            ),
          ),
        ),
      ),
    ),
    onTap: () => badgerSignModal(signName, context),
  );
}

Widget badgerSignModal(BadgerSign signName, BuildContext context) {
  showMaterialModalBottomSheet(
    //barrierColor: barrierDark,
    context: context,
    backgroundColor: Colors.transparent,
    //enableDrag: false, // not clear what effect this has
    builder: (context) => FloatingModal(
      child: Scrollbar(
        thumbVisibility: true,
        thickness: 8.0,
        child: SingleChildScrollView(
          controller: ModalScrollController.of(context),
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: badgerSignModalContents(signName),
          ),
        ),
      ),
    ),
  );
  return Container();
}

Widget badgerSignTitle(String titleText) {
  return Text(
    titleText,
    textAlign: TextAlign.center,
    style: lTBold,
  );
}

Widget bottomModalPara(String paraText) {
  return Text(
    paraText,
    textAlign: TextAlign.left,
    style: mTStyle,
  );
}
