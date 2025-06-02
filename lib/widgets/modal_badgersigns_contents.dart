import '../exports_config.dart';

List<Widget> badgerSignModalContents(BadgerSign signName) {
  switch (signName) {

    case BadgerSign.entrance:
      return [
        const SizedBox(height: paraBreak),
        badgerSignTitle('Open sett entrance holes'),
        const SizedBox(height: paraBreak),
        Image.asset(imgSignsEntrance),
        Padding(
          padding: const EdgeInsets.all(edgePad * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // this should now be aligned left on A5 - unlike short one line paras in the other signs TODO gh#24
            children: [
              bottomModalPara(
                  'Badger sett entrance holes are at least 25\u{2009}cm in diameter and usually have a flattened oval or \'sideways D\' shape.'),
              const SizedBox(height: paraBreak),
              bottomModalPara(
                  'Look to see if the entrance has smoothed sides from regular use.'),
              const SizedBox(height: paraBreak),
              bottomModalPara(
                  'You may see moss and other vegetation that has been flattened from badgers passing through.'),
              const SizedBox(height: paraBreak),
              bottomModalPara('You may also find pawprints or claw marks.'),
              const SizedBox(height: paraBreak),
              bottomModalPara(
                  'If the entrance hole is blocked with debris, this may indicate it has not been in recent use. However, badgers may be using other entrances to the sett. The volume of badger activity at a sett changes over the seasons, and falling leaves and other debris can mask evidence of recent activity.'),
              const SizedBox(height: paraBreak),
              bottomModalPara(
                  'Carefully examine every sett entrance and only count a hole as \'closed\' if it is completely impassable.'),
            ],
          ),
        ),
      ];

    case BadgerSign.spoil:
      return [
        const SizedBox(height: paraBreak),
        badgerSignTitle('Fresh spoil heaps'),
        const SizedBox(height: paraBreak),
        Image.asset(imgSignsSpoil),
        Padding(
          padding: const EdgeInsets.all(edgePad * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // this should now be aligned left on A5 - unlike short one line paras in the other signs
            children: [
              bottomModalPara('Badgers create spoil heaps at the entrances to their setts by dragging earth out backwards.'),
              const SizedBox(height: paraBreak),
              bottomModalPara('Freshly dug soil on the spoil heap can be distinguished from older spoil, which is usually more compacted and covered in debris.'),
            ],
          ),
        ),
      ];

    case BadgerSign.bedding:
      return [
        const SizedBox(height: paraBreak),
        badgerSignTitle('Bedding'),
        const SizedBox(height: paraBreak),
        Image.asset(imgSignsBedding),
        Padding(
          padding: const EdgeInsets.all(edgePad * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // this should now be aligned left on A5 - unlike short one line paras in the other signs
            children: [
              bottomModalPara('Badgers drag bedding material such as straw, grass and bracken into their setts. This material is periodically dragged back out to air.'),
              const SizedBox(height: paraBreak),
              bottomModalPara('You may find balls of bedding at the sett entrance or on the spoil heap.'),
            ],
          ),
        ),
      ];

    case BadgerSign.pawprints:
      return [
        const SizedBox(height: paraBreak),
        badgerSignTitle('Pawprints'),
        const SizedBox(height: paraBreak),
        Image.asset(imgSignsPawprint),
        Padding(
          padding: const EdgeInsets.all(edgePad * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // this should now be aligned left on A5 - unlike short one line paras in the other signs
            children: [
              bottomModalPara('Adult badger prints are approximately 6\u{2013}7\u{2009}cm wide and usually show a wide pad, five toes and long claw marks.'),
              const SizedBox(height: paraBreak),
              bottomModalPara('Depending on soil conditions, you may find paw prints and claw marks at sett entrances, on spoil heaps and runs.'),
            ],
          ),
        ),
      ];

    case BadgerSign.hair:
      return [
        const SizedBox(height: paraBreak),
        badgerSignTitle('Hair'),
        const SizedBox(height: paraBreak),
        Image.asset(imgSignsHair),
        Padding(
          padding: const EdgeInsets.all(edgePad * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // this should now be aligned left on A5 - unlike short one line paras in the other signs
            children: [
              bottomModalPara('Badger hair can often be found at the sett entrance.'),
              const SizedBox(height: paraBreak),
              bottomModalPara('You may also find hairs caught on barbed-wire fencing over a badger run.'),
              const SizedBox(height: paraBreak),
              bottomModalPara('Hairs are usually around 7\u{2009}cm long, have a coarse, wiry texture and are oval in shape, which you can discover by rubbing them between finger and thumb.'),
              const SizedBox(height: paraBreak),
              bottomModalPara('Badger hairs are mostly grey/white in colour, with a short black band and silver tip.'),
            ],
          ),
        ),
      ];

    case BadgerSign.scratch:
      return [
        const SizedBox(height: paraBreak),
        badgerSignTitle('Scratch marks'),
        const SizedBox(height: paraBreak),
        Image.asset(imgSignsScratch),
        Padding(
          padding: const EdgeInsets.all(edgePad * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // this should now be aligned left on A5 - unlike short one line paras in the other signs
            children: [
              bottomModalPara('Scratch marks or claw marks can sometimes be found on fallen trees and fence posts in the vicinity of a sett.'),
              const SizedBox(height: paraBreak),
              bottomModalPara('They can also be found at sett entrances.'),
            ],
          ),
        ),
      ];

    case BadgerSign.latrine:
      return [
        const SizedBox(height: paraBreak),
        badgerSignTitle('Latrine'),
        const SizedBox(height: paraBreak),
        Image.asset(imgSignsLatrine),
        Padding(
          padding: const EdgeInsets.all(edgePad * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // this should now be aligned left on A5 - unlike short one line paras in the other signs
            children: [
              bottomModalPara('Badgers often deposit their dung in shallow pits.'),
              const SizedBox(height: paraBreak),
              bottomModalPara('Badger dung can be easily distinguished from fox faeces, which are usually tapered at the end and are not often deposited in pits.'),
              const SizedBox(height: paraBreak),
              bottomModalPara('Latrines can sometimes be found in the vicinity of the sett or on the edge of territory.'),
              const SizedBox(height: paraBreak),
              bottomModalPara('Following a badger run away from the sett may lead you to a latrine.'),
            ],
          ),
        ),
      ];

    case BadgerSign.run:
      return [
        const SizedBox(height: paraBreak),
        badgerSignTitle('Well-used run'),
        const SizedBox(height: paraBreak),
        Image.asset(imgSignsRun),
        Padding(
          padding: const EdgeInsets.all(edgePad * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // this should now be aligned left on A5 - unlike short one line paras in the other signs
            children: [
              bottomModalPara('A well-used badger run is clear of vegetation, low to the ground and often connects to a sett entrance or latrine.'),
              const SizedBox(height: paraBreak),
              bottomModalPara('Badger runs sometimes pass under fences (look for hair caught on barbed wire) and bushes, through hedges and over banks.'),
            ],
          ),
        ),
      ];

    case BadgerSign.foraging:
      return [
        const SizedBox(height: paraBreak),
        badgerSignTitle('Foraging signs'),
        const SizedBox(height: paraBreak),
        Image.asset(imgSignsForaging),
        Padding(
          padding: const EdgeInsets.all(edgePad * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // this should now be aligned left on A5 - unlike short one line paras in the other signs
            children: [
              bottomModalPara('Look for \'snuffle holes\' in the ground where badgers have removed turf or dug up roots to unearth grubs.'),
            ],
          ),
        ),
      ];

    default:
      return [const Text(Error.badgerSignModalInvalid)];
  }
}
