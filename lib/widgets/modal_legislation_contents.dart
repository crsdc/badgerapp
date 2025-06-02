

import '../exports_config.dart';

List<Widget> legModalContents(BuildContext context, Legislation legRef) {
  List<Widget> contentsWidgetList = [];
  contentsWidgetList.addAll(legModalIntro);
  switch (legRef) {
    case Legislation.awa06s4:
    case Legislation.awa06s7:
    case Legislation.awa06s8:
      contentsWidgetList.add(legModalTitle('Animal Welfare Act 2006'));
      break;
    case Legislation.poba92s1:
    case Legislation.poba92s2:
    case Legislation.poba92s3:
    case Legislation.poba92s4:
    case Legislation.poba92s14:
      contentsWidgetList.add(legModalTitle('Protection of Badgers Act 1992'));
      break;
    case Legislation.waca81s11:
    case Legislation.waca81sch6:
      contentsWidgetList.add(legModalTitle('Wildlife and Countryside Act 1981'));
      break;
    case Legislation.wmpa96s1:
      contentsWidgetList.add(legModalTitle('Wild Mammals (Protection) Act 1996'));
      break;
  }
  contentsWidgetList.add(const SizedBox(height: smallBreak));
  switch (legRef) {
    case Legislation.awa06s4:
      contentsWidgetList.add(legModalSubtitle('Section 4'));
      break;
    case Legislation.awa06s7:
      contentsWidgetList.add(legModalSubtitle('Section 7'));
      break;
    case Legislation.awa06s8:
      contentsWidgetList.add(legModalSubtitle('Section 8'));
      break;
    case Legislation.poba92s1:
      contentsWidgetList.add(legModalSubtitle('Section 1'));
      break;
    case Legislation.poba92s2:
      contentsWidgetList.add(legModalSubtitle('Section 2'));
      break;
    case Legislation.poba92s3:
      contentsWidgetList.add(legModalSubtitle('Section 3'));
      break;
    case Legislation.poba92s4:
      contentsWidgetList.add(legModalSubtitle('Section 4'));
      break;
    case Legislation.poba92s14:
      contentsWidgetList.add(legModalSubtitle('Section 14'));
      break;
    case Legislation.waca81s11:
      contentsWidgetList.add(legModalSubtitle('Section 11'));
      break;
    case Legislation.waca81sch6:
      contentsWidgetList.add(legModalSubtitle('Schedule 6'));
      break;
    case Legislation.wmpa96s1:
      contentsWidgetList.add(legModalSubtitle('Section 1'));
      break;
  }
  //contentsWidgetList.add(const SizedBox(height: smallBreak));
  //contentsWidgetList.add(legModalAsAmended);
  // amendment note left out for now - it may introduce confusion
  //contentsWidgetList.add(const SizedBox(height: smallBreak)); seems to give us too much space

  List<Widget> legModalFormattedText = [];
  switch (legRef) {
    case Legislation.awa06s4:
      legModalFormattedText = [
        legPara(0, '4   Unnecessary suffering'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(1)   A person commits an offence if—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(a)   an act of his, or a failure of his to act, causes an animal to suffer,'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(b)   he knew, or ought reasonably to have known, that the act, or failure to act, would have that effect or be likely to do so,'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(c)   the animal is a protected animal, and'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(d)   the suffering is unnecessary.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(2)   A person commits an offence if—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(a)   he is responsible for an animal,'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(b)   an act, or failure to act, of another person causes the animal to suffer,'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(c)   he permitted that to happen or failed to take such steps (whether by way of supervising the other person or otherwise) as were reasonable in all the circumstances to prevent that happening, and'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(d)   the suffering is unnecessary.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(3)   The considerations to which it is relevant to have regard when determining for the purposes of this section whether suffering is unnecessary include—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(a)   whether the suffering could reasonably have been avoided or reduced;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(b)   whether the conduct which caused the suffering was in compliance with any relevant enactment or any relevant provisions of a licence or code of practice issued under an enactment;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(c)   whether the conduct which caused the suffering was for a legitimate purpose, such as—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent3, '(i)   the purpose of benefiting the animal, or'),
        const SizedBox(height: smallBreak),
        legPara(legIndent3, '(ii)   the purpose of protecting a person, property or another animal;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(d)   whether the suffering was proportionate to the purpose of the conduct concerned;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(e)   whether the conduct concerned was in all the circumstances that of a reasonably competent and humane person.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(3A)   In determining for the purposes of subsection (1) whether suffering is unnecessary in a case where it was caused by conduct for a purpose mentioned in subsection (3)(c)(ii), the fact that the conduct was for that purpose is to be disregarded if—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(a)   the animal was under the control of a relevant officer at the time of the conduct,'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(b)   it was being used by that officer at that time, in the course of the officer’s duties, in a way that was reasonable in all the circumstances, and'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(c)   that officer is not the defendant.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(3B)   In subsection (3A) “relevant officer” means—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(a)   a constable;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(b)   a person (other than a constable) who has the powers of a constable or is otherwise employed for police purposes or is engaged to provide services for police purposes;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(c)   a prisoner custody officer within the meaning of Part 4 of the Criminal Justice Act 1991.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(3C)   The Secretary of State may by regulations amend subsection (3B).'),
        const SizedBox(height: smallBreak),
        legPara(legIndent1, 'Only a person in the public service of the Crown may be specified in subsection (3B) by virtue of regulations under this subsection.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(4)   Nothing in this section applies to the destruction of an animal in an appropriate and humane manner.'),
      ];
      break;

    case Legislation.awa06s7:
      legModalFormattedText = [
        legPara(0, '7   Administration of poisons etc.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(1)   A person commits an offence if, without lawful authority or reasonable excuse, he—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(a)   administers any poisonous or injurious drug or substance to a protected animal, knowing it to be poisonous or injurious, or'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(b)   causes any poisonous or injurious drug or substance to be taken by a protected animal, knowing it to be poisonous or injurious.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(2)   A person commits an offence if—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(a)   he is responsible for an animal,'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(b)   without lawful authority or reasonable excuse, another person administers a poisonous or injurious drug or substance to the animal or causes the animal to take such a drug or substance, and'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(c)   he permitted that to happen or, knowing the drug or substance to be poisonous or injurious, he failed to take such steps (whether by way of supervising the other person or otherwise) as were reasonable in all the circumstances to prevent that happening.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(3)   In this section, references to a poisonous or injurious drug or substance include a drug or substance which, by virtue of the quantity or manner in which it is administered or taken, has the effect of a poisonous or injurious drug or substance.'),
      ];
      break;

    case Legislation.awa06s8:
      legModalFormattedText = [
        legPara(0, '8   Fighting etc.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(1)   A person commits an offence if he—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(a)   causes an animal fight to take place, or attempts to do so;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(b)   knowingly receives money for admission to an animal fight;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(c)   knowingly publicises a proposed animal fight;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(d)   provides information about an animal fight to another with the intention of enabling or encouraging attendance at the fight;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(e)   makes or accepts a bet on the outcome of an animal fight or on the likelihood of anything occurring or not occurring in the course of an animal fight;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(f)   takes part in an animal fight;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(g)   has in his possession anything designed or adapted for use in connection with an animal fight with the intention of its being so used;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(h)   keeps or trains an animal for use for in connection with an animal fight;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(i)   keeps any premises for use for an animal fight.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(2)   A person commits an offence if, without lawful authority or reasonable excuse, he is present at an animal fight.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(3)   A person commits an offence if, without lawful authority or reasonable excuse, he—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(a)   knowingly supplies a video recording of an animal fight,'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(b)   knowingly publishes a video recording of an animal fight,'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(c)   knowingly shows a video recording of an animal fight to another, or'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(d)   possesses a video recording of an animal fight, knowing it to be such a recording, with the intention of supplying it.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(4)   Subsection (3) does not apply if the video recording is of an animal fight that took place—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(a)   outside Great Britain, or'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(b)   before the commencement date.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(5)   Subsection (3) does not apply—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(a)   in the case of paragraph (a), to the supply of a video recording for inclusion in a programme service;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(b)   in the case of paragraph (b) or (c), to the publication or showing of a video recording by means of its inclusion in a programme service;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(c)   in the case of paragraph (d), by virtue of intention to supply for inclusion in a programme service.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(6)   [repealed]'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(7)   In this section—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '“animal fight” means an occasion on which a protected animal is placed with an animal, or with a human, for the purpose of fighting, wrestling or baiting;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '‘“commencement date” means the date on which subsection (3) comes into force;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '“information society services” has the meaning given in Article 2(a) of Directive 2000/31/EC of the European Parliament and of the Council of 8 June 2000 on certain legal aspects of information society services, in particular electronic commerce in the Internal Market (Directive on electronic commerce);'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '“programme service” has the same meaning as in the Communications Act 2003 (c. 21);'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '“video recording” means a recording, in any form, from which a moving image may by any means be reproduced and includes data stored on a computer disc or by other electronic means which is capable of conversion into a moving image. '),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(8)   In this section—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(a)   references to supplying or publishing a video recording are to supplying or publishing a video recording in any manner, including, in relation to a video recording in the form of data stored electronically, by means of transmitting such data;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(b)   references to showing a video recording are to showing a moving image reproduced from a video recording by any means.'),
      ];
      break;

    case Legislation.poba92s1:
      legModalFormattedText = [
        legPara(0, '1   Taking, injuring or killing badgers.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(1)   A person is guilty of an offence if, except as permitted by or under this Act, he wilfully kills, injures or takes, or attempts to kill, injure or take, a badger.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(2)   If, in any proceedings for an offence under subsection (1) above consisting of attempting to kill, injure or take a badger, there is evidence from which it could reasonably be concluded that at the material time the accused was attempting to kill, injure or take a badger, he shall be presumed to have been attempting to kill, injure or take a badger unless the contrary is shown.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(3)   A person is guilty of an offence if, except as permitted by or under this Act, he has in his possession or under his control any dead badger or any part of, or anything derived from, a dead badger.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(4)   A person is not guilty of an offence under subsection (3) above if he shows that—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(a)   the badger had not been killed, or had been killed otherwise than in contravention of the provisions of this Act or of the Badgers Act 1973; or'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(b)   the badger or other thing in his possession or control had been sold (whether to him or any other person) and, at the time of the purchase, the purchaser had had no reason to believe that the badger had been killed in contravention of any of those provisions.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(5)   If a person is found committing an offence under this section on any land it shall be lawful for the owner or occupier of the land, or any servant of the owner or occupier, or any constable, to require that person forthwith to quit the land and also to give his name and address; and if that person on being so required wilfully remains on the land or refuses to give his full name or address he is guilty of an offence.'),
      ];
      break;

    case Legislation.poba92s2:
      legModalFormattedText = [
        legPara(0, '2   Cruelty.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(1)   A person is guilty of an offence if—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(a)   he cruelly ill-treats a badger;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(b)   he uses any badger tongs in the course of killing or taking, or attempting to kill or take, a badger;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(c)   except as permitted by or under this Act, he digs for a badger; or'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(d)   he uses for the purpose of killing or taking a badger any firearm other than a smooth bore weapon of not less than 20 bore or a rifle using ammunition having a muzzle energy not less than 160 footpounds and a bullet weighing not less than 38 grains.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(2)   If in any proceedings for an offence under subsection (1)(c) above there is evidence from which it could reasonably be concluded that at the material time the accused was digging for a badger he shall be presumed to have been digging for a badger unless the contrary is shown.'),
      ];
      break;

    case Legislation.poba92s3:
      legModalFormattedText = [
        legPara(0, '3   Interfering with badger setts.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, 'A person is guilty of an offence if, except as permitted by or under this Act, he interferes with a badger sett by doing any of the following things—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(a)   damaging a badger sett or any part of it;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(b)   destroying a badger sett;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(c)   obstructing access to, or any entrance of, a badger sett;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(d)   causing a dog to enter a badger sett; or'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(e)   disturbing a badger when it is occupying a badger sett,'),
        const SizedBox(height: smallBreak),
        legPara(legIndent1, 'intending to do any of those things or being reckless as to whether his actions would have any of those consequences.'),
      ];
      break;

    case Legislation.poba92s4:
      legModalFormattedText = [
        legPara(0, '4   Selling and possession of live badgers.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, 'A person is guilty of an offence if, except as permitted by or under this Act, he sells a live badger or offers one for sale or has a live badger in his possession or under his control.'),
      ];
      break;

    case Legislation.poba92s14:
      legModalFormattedText = [
        legPara(0, '14   Interpretation.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, 'In this Act—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '“ammunition” has the same meaning as in the Firearms Act 1968;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '“badger” means any animal of the species Meles meles;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '“badger sett” means any structure or place which displays signs indicating current use by a badger;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '“firearm” has the same meaning as in the Firearms Act 1968;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '“sale” includes hire, barter and exchange and cognate expressions shall be construed accordingly.'),
      ];
      break;

    case Legislation.waca81s11:
      legModalFormattedText = [
        legPara(0, '11   Prohibition of certain methods of killing or taking wild animals.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(1)   Subject to the provisions of this Part, if any person—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(a)   sets in position any self-locking snare which is of such a nature and so placed as to be calculated to cause bodily injury to any wild animal coming into contact therewith;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(b)   uses for the purpose of killing or taking any wild animal any self-locking snare, whether or not of such a nature or so placed as aforesaid, any bow or cross-bow or any explosive other than ammunition for a firearm;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(c)   uses as a decoy, for the purpose of killing or taking any wild animal, any live mammal or bird whatever; or'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(d)   knowingly causes or permits to be done an act which is mentioned in the foregoing provisions of this section,'),
        const SizedBox(height: smallBreak),
        legPara(legIndent1, 'he shall be guilty of an offence.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(2)   Subject to the provisions of this Part, a person shall be guilty of an offence if that person—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(a)   uses any trap or snare for the purpose of killing or taking or restraining any wild animal included in Schedule 6 or 6ZA;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(b)   sets in position any trap or snare of such a nature and so placed as to be—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent3, '(i)   in England and Wales, calculated to cause bodily injury to any wild animal included in Schedule 6 or 6ZA;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent3, '(ii)   in Scotland, likely to cause bodily injury to any such wild animal;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(c)   sets in position any electrical device for killing or stunning, or any poisonous, poisoned or stupefying substance, of such a nature and so placed as to be—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent3, '(i)   in England and Wales, calculated to cause bodily injury to any wild animal included in Schedule 6;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent3, '(ii)   in Scotland, likely to cause bodily injury to any such wild animal;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(d)   uses for the purpose of killing or taking any wild animal included in Schedule 6—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent3, '(i)   any electrical device for killing or stunning;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent3, '(ii)   any poisonous, poisoned or stupefying substance;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent3, '(iii)   any net;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent3, '(iv)   any automatic or semi-automatic weapon;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent3, '(v)   any device for illuminating a target or sighting device for night shooting;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent3, '(vi)   any form of artificial light or any mirror or other dazzling device;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent3, '(vii)   any gas or smoke not falling within sub-paragraph (ii);'),
        const SizedBox(height: smallBreak),
        legPara(legIndent3, '(viii)   any sound recording used as a decoy; or'),
        const SizedBox(height: smallBreak),
        legPara(legIndent3, '(ix)   any mechanically propelled vehicle in immediate pursuit of any such animal;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(e)   uses any mechanically propelled vehicle for the purpose of driving any wild animal included in Schedule 6; or'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(f)   knowingly causes or permits to be done an act mentioned in paragraphs (a) to (e).'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(3)   Subject to the provisions of this Part, if any person—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(a)   sets in position or knowingly causes or permits to be set in position any snare which is of such a nature and so placed as to be calculated to cause bodily injury to any wild animal coming into contact therewith; and'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(b)   while the snare remains in position fails, without reasonable excuse, to inspect it, or cause it to be inspected, at least once every day,'),
        const SizedBox(height: smallBreak),
        legPara(legIndent1, 'he shall be guilty of an offence.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(4)   The Secretary of State may, for the purpose of complying with an international obligation, by order, either generally or in relation to any kind of wild animal specified in the order, amend subsection (1) or (2) by adding any method of killing or taking wild animals or by omitting any such method as is mentioned in that subsection.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(5)   In any proceedings for an offence under subsection (1)(b) or (c) or (2)(a), (d) or (e), and in any proceedings for an offence under subsection (1)(d) or (2)(f) relating to an act which is mentioned in any of those paragraphs the animal in question shall be presumed to have been a wild animal unless the contrary is shown.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(6)   In any proceedings for an offence under subsection (2)(b) or (c) it shall be a defence to show that the article was set in position by the accused for the purpose of killing or taking, in the interests of public health, agriculture, forestry, fisheries or nature conservation, any wild animals which could be lawfully killed or taken by those means and that he took all reasonable precautions to prevent injury thereby to any wild animals included in the relevant Schedule.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(7)   In any proceedings for an offence under subsection (2)(f) relating to an act which is mentioned in subsection (2)(b) or (c) it shall be a defence to show that the article was set in position for the purpose of killing or taking, in the interests of public health, agriculture, forestry, fisheries or nature conservation, any wild animals which could be lawfully killed or taken by those means and that he took or caused to be taken all reasonable precautions to prevent injury thereby to any wild animals included in the relevant Schedule.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, '(7A)   In subsections (6) and (7), “the relevant Schedule” means—'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(a)   where proceedings relate to an offence under subsection (2)(b), Schedule 6 or 6ZA;'),
        const SizedBox(height: smallBreak),
        legPara(legIndent2, '(b)   where proceedings relate to an offence under subsection (2)(c), Schedule 6.'),
      ];
      break;

    case Legislation.waca81sch6:
      legModalFormattedText = [
        legPara(0, 'Animals which may not be Killed or Taken by Certain Methods'),
        const SizedBox(height: paraBreak),
        Table(
          children: const [
            TableRow(
              children: [
                Text(
                  'Common name',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Scientific name',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            rowSpacer,
            TableRow(
              children: [
                Text('Badger'),
                Text('Meles meles'),
              ],
            ),
            rowSpacer,
            TableRow(
              children: [
                Text('Bats, Horseshoe (all species)'),
                Text('Rhinolophidae'),
              ],
            ),
            rowSpacer,
            TableRow(
              children: [
                Text('Bats, Typical (all species)'),
                Text('Vespertilionidae'),
              ],
            ),
            rowSpacer,
            TableRow(
              children: [
                Text('Cat, Wild'),
                Text('Felis silvestris'),
              ],
            ),
            rowSpacer,
            TableRow(
              children: [
                Text('Dolphin, Bottle-nosed'),
                Text('Tusiops truncatus (otherwise known as Tursiops tursio)'),
              ],
            ),
            rowSpacer,
            TableRow(
              children: [
                Text('Dolphin, Common'),
                Text('Delphinis delphis'),
              ],
            ),
            rowSpacer,
            TableRow(
              children: [
                Text('Dormice (all species)'),
                Text('Gliridae'),
              ],
            ),
            rowSpacer,
            TableRow(
              children: [
                Text('Hedgehog'),
                Text('Erinaceus europaeus'),
              ],
            ),
            rowSpacer,
            TableRow(
              children: [
                Text('Marten, Pine'),
                Text('Martes martes'),
              ],
            ),
            rowSpacer,
            TableRow(
              children: [
                Text('Otter, Common'),
                Text('Lutra lutra'),
              ],
            ),
            rowSpacer,
            TableRow(
              children: [
                Text('Polecat'),
                Text('Mustela putorius'),
              ],
            ),
            rowSpacer,
            TableRow(
              children: [
                Text('Porpoise, Harbour (otherwise known as Common porpoise)'),
                Text('Phocaena phocaena'),
              ],
            ),
            rowSpacer,
            TableRow(
              children: [
                Text('Shrews (all species)'),
                Text('Soricidae'),
              ],
            ),
            rowSpacer,
            TableRow(
              children: [
                Text('Squirrel, Red'),
                Text('Sciurus vulgaris'),
              ],
            ),
          ],
        ),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, 'Note. The common name or names given in the first column of this Schedule are included by way of guidance only; in the event of any dispute or proceedings, the common name or names shall not be taken into account.'),
      ];
      break;

    case Legislation.wmpa96s1:
      legModalFormattedText = [
        legPara(0, '1   Offences.'),
        const SizedBox(height: paraBreak),
        legPara(legIndent1, 'If, save as permitted by this Act, any person mutilates, kicks, beats, nails or otherwise impales, stabs, burns, stones, crushes, drowns, drags or asphyxiates any wild mammal with intent to inflict unnecessary suffering he shall be guilty of an offence.'),
      ];
      break;

    default:
      legModalFormattedText = [const Text('Error: text missing')];
  }

  contentsWidgetList.add(Padding(
    padding: const EdgeInsets.all(edgePad * 3),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          color: appLB,
          height: 25,
          thickness: 2,
        ),
        const SizedBox(height: smallBreak)]
          + legModalFormattedText
          + legModalOutro(context, legRef),
    ),
  ));

  return contentsWidgetList;
}
