// Reference content for the legislation popups

const String legVerifiedAsOfDate = 'November 2022'; // Needs updating periodically

enum Legislation {
  awa06s4,    // Animal Welfare Act 2006, Section 4
  awa06s7,    // Animal Welfare Act 2006, Section 7
  awa06s8,    // Animal Welfare Act 2006, Section 8
  poba92s1,   // Protection of Badgers Act 1992, Section 1
  poba92s2,   // Protection of Badgers Act 1992, Section 2
  poba92s3,   // Protection of Badgers Act 1992, Section 3
  poba92s4,   // Protection of Badgers Act 1992, Section 4
  poba92s14,  // Protection of Badgers Act 1992, Section 14
  waca81s11,  // Wildlife and Countryside Act 1981, Section 11
  waca81sch6, // Wildlife and Countryside Act 1981, Schedule 6
  wmpa96s1,   // Wild Mammals (Protection) Act 1996, Section 1
}

const Map<Legislation, String> legUrl = {
  Legislation.awa06s4:'https://www.legislation.gov.uk/ukpga/2006/45/section/4',
  Legislation.awa06s7:'https://www.legislation.gov.uk/ukpga/2006/45/section/7',
  Legislation.awa06s8:'https://www.legislation.gov.uk/ukpga/2006/45/section/8',
  Legislation.poba92s1:'https://www.legislation.gov.uk/ukpga/1992/51/section/1',
  Legislation.poba92s2:'https://www.legislation.gov.uk/ukpga/1992/51/section/2',
  Legislation.poba92s3:'https://www.legislation.gov.uk/ukpga/1992/51/section/3',
  Legislation.poba92s4:'https://www.legislation.gov.uk/ukpga/1992/51/section/4',
  Legislation.poba92s14:'https://www.legislation.gov.uk/ukpga/1992/51/section/14',
  Legislation.waca81s11:'https://www.legislation.gov.uk/ukpga/1981/69/section/11',
  Legislation.waca81sch6:'https://www.legislation.gov.uk/ukpga/1981/69/schedule/6',
  Legislation.wmpa96s1:'https://www.legislation.gov.uk/ukpga/1996/3/section/1',
};

// Strings used when user copies to clipboard from a legislation popup
const Map<Legislation, String> legText = {
  Legislation.awa06s4:'''Animal Welfare Act 2006

4 Unnecessary suffering

(1) A person commits an offence if—

(a) an act of his, or a failure of his to act, causes an animal to suffer,

(b) he knew, or ought reasonably to have known, that the act, or failure to act, would have that effect or be likely to do so,

(c) the animal is a protected animal, and

(d) the suffering is unnecessary.

(2) A person commits an offence if—

(a) he is responsible for an animal,

(b) an act, or failure to act, of another person causes the animal to suffer,

(c) he permitted that to happen or failed to take such steps (whether by way of supervising the other person or otherwise) as were reasonable in all the circumstances to prevent that happening, and

(d) the suffering is unnecessary.

(3) The considerations to which it is relevant to have regard when determining for the purposes of this section whether suffering is unnecessary include—

(a) whether the suffering could reasonably have been avoided or reduced;

(b) whether the conduct which caused the suffering was in compliance with any relevant enactment or any relevant provisions of a licence or code of practice issued under an enactment;

(c) whether the conduct which caused the suffering was for a legitimate purpose, such as—

(i) the purpose of benefiting the animal, or

(ii) the purpose of protecting a person, property or another animal;

(d) whether the suffering was proportionate to the purpose of the conduct concerned;

(e) whether the conduct concerned was in all the circumstances that of a reasonably competent and humane person.

(3A) In determining for the purposes of subsection (1) whether suffering is unnecessary in a case where it was caused by conduct for a purpose mentioned in subsection (3)(c)(ii), the fact that the conduct was for that purpose is to be disregarded if—

(a) the animal was under the control of a relevant officer at the time of the conduct,

(b) it was being used by that officer at that time, in the course of the officer’s duties, in a way that was reasonable in all the circumstances, and

(c) that officer is not the defendant.

(3B) In subsection (3A) “relevant officer” means—

(a) a constable;

(b) a person (other than a constable) who has the powers of a constable or is otherwise employed for police purposes or is engaged to provide services for police purposes;

(c) a prisoner custody officer within the meaning of Part 4 of the Criminal Justice Act 1991.

(3C) The Secretary of State may by regulations amend subsection (3B).

Only a person in the public service of the Crown may be specified in subsection (3B) by virtue of regulations under this subsection.

(4) Nothing in this section applies to the destruction of an animal in an appropriate and humane manner.''',

  Legislation.awa06s7:'''Animal Welfare Act 2006

7 Administration of poisons etc.

(1) A person commits an offence if, without lawful authority or reasonable excuse, he—

(a) administers any poisonous or injurious drug or substance to a protected animal, knowing it to be poisonous or injurious, or

(b) causes any poisonous or injurious drug or substance to be taken by a protected animal, knowing it to be poisonous or injurious.

(2) A person commits an offence if—

(a) he is responsible for an animal,

(b) without lawful authority or reasonable excuse, another person administers a poisonous or injurious drug or substance to the animal or causes the animal to take such a drug or substance, and

(c) he permitted that to happen or, knowing the drug or substance to be poisonous or injurious, he failed to take such steps (whether by way of supervising the other person or otherwise) as were reasonable in all the circumstances to prevent that happening.

(3) In this section, references to a poisonous or injurious drug or substance include a drug or substance which, by virtue of the quantity or manner in which it is administered or taken, has the effect of a poisonous or injurious drug or substance.''',

  Legislation.awa06s8:'''Animal Welfare Act 2006

8 Fighting etc.

(1) A person commits an offence if he—

(a) causes an animal fight to take place, or attempts to do so;

(b) knowingly receives money for admission to an animal fight;

(c) knowingly publicises a proposed animal fight;

(d) provides information about an animal fight to another with the intention of enabling or encouraging attendance at the fight;

(e) makes or accepts a bet on the outcome of an animal fight or on the likelihood of anything occurring or not occurring in the course of an animal fight;

(f) takes part in an animal fight;

(g) has in his possession anything designed or adapted for use in connection with an animal fight with the intention of its being so used;

(h) keeps or trains an animal for use for in connection with an animal fight;

(i) keeps any premises for use for an animal fight.

(2) A person commits an offence if, without lawful authority or reasonable excuse, he is present at an animal fight.

(3) A person commits an offence if, without lawful authority or reasonable excuse, he—

(a) knowingly supplies a video recording of an animal fight,

(b) knowingly publishes a video recording of an animal fight,

(c) knowingly shows a video recording of an animal fight to another, or

(d) possesses a video recording of an animal fight, knowing it to be such a recording, with the intention of supplying it.

(4) Subsection (3) does not apply if the video recording is of an animal fight that took place—

(a) outside Great Britain, or

(b) before the commencement date.

(5) Subsection (3) does not apply—

(a) in the case of paragraph (a), to the supply of a video recording for inclusion in a programme service;

(b) in the case of paragraph (b) or (c), to the publication or showing of a video recording by means of its inclusion in a programme service;

(c) in the case of paragraph (d), by virtue of intention to supply for inclusion in a programme service.

(6) [repealed]

(7) In this section—

“animal fight” means an occasion on which a protected animal is placed with an animal, or with a human, for the purpose of fighting, wrestling or baiting;

‘“commencement date” means the date on which subsection (3) comes into force;

“information society services” has the meaning given in Article 2(a) of Directive 2000/31/EC of the European Parliament and of the Council of 8 June 2000 on certain legal aspects of information society services, in particular electronic commerce in the Internal Market (Directive on electronic commerce);

“programme service” has the same meaning as in the Communications Act 2003 (c. 21);

“video recording” means a recording, in any form, from which a moving image may by any means be reproduced and includes data stored on a computer disc or by other electronic means which is capable of conversion into a moving image.

(8) In this section—

(a) references to supplying or publishing a video recording are to supplying or publishing a video recording in any manner, including, in relation to a video recording in the form of data stored electronically, by means of transmitting such data;

(b) references to showing a video recording are to showing a moving image reproduced from a video recording by any means.''',

  Legislation.poba92s1:'''Protection of Badgers Act 1992

1 Taking, injuring or killing badgers.

(1) A person is guilty of an offence if, except as permitted by or under this Act, he wilfully kills, injures or takes, or attempts to kill, injure or take, a badger.

(2) If, in any proceedings for an offence under subsection (1) above consisting of attempting to kill, injure or take a badger, there is evidence from which it could reasonably be concluded that at the material time the accused was attempting to kill, injure or take a badger, he shall be presumed to have been attempting to kill, injure or take a badger unless the contrary is shown.

(3) A person is guilty of an offence if, except as permitted by or under this Act, he has in his possession or under his control any dead badger or any part of, or anything derived from, a dead badger.

(4) A person is not guilty of an offence under subsection (3) above if he shows that—

(a) the badger had not been killed, or had been killed otherwise than in contravention of the provisions of this Act or of the Badgers Act 1973; or

(b) the badger or other thing in his possession or control had been sold (whether to him or any other person) and, at the time of the purchase, the purchaser had had no reason to believe that the badger had been killed in contravention of any of those provisions.

(5) If a person is found committing an offence under this section on any land it shall be lawful for the owner or occupier of the land, or any servant of the owner or occupier, or any constable, to require that person forthwith to quit the land and also to give his name and address; and if that person on being so required wilfully remains on the land or refuses to give his full name or address he is guilty of an offence.''',
  // Subsection 6 left out as it only applies in Scotland

  Legislation.poba92s2:'''Protection of Badgers Act 1992

2 Cruelty.

(1) A person is guilty of an offence if—

(a) he cruelly ill-treats a badger;

(b) he uses any badger tongs in the course of killing or taking, or attempting to kill or take, a badger;

(c) except as permitted by or under this Act, he digs for a badger; or

(d) he uses for the purpose of killing or taking a badger any firearm other than a smooth bore weapon of not less than 20 bore or a rifle using ammunition having a muzzle energy not less than 160 footpounds and a bullet weighing not less than 38 grains.

(2) If in any proceedings for an offence under subsection (1)(c) above there is evidence from which it could reasonably be concluded that at the material time the accused was digging for a badger he shall be presumed to have been digging for a badger unless the contrary is shown.''',
  // Subsection 3 left out as it only applies in Scotland

  Legislation.poba92s3:'''Protection of Badgers Act 1992

3 Interfering with badger setts.

A person is guilty of an offence if, except as permitted by or under this Act, he interferes with a badger sett by doing any of the following things—

(a) damaging a badger sett or any part of it;

(b) destroying a badger sett;

(c) obstructing access to, or any entrance of, a badger sett;

(d) causing a dog to enter a badger sett; or

(e) disturbing a badger when it is occupying a badger sett,

intending to do any of those things or being reckless as to whether his actions would have any of those consequences.''',
  // Subsection 2 left out as it only applies in Scotland

  Legislation.poba92s4:'''Protection of Badgers Act 1992
  
4 Selling and possession of live badgers.

A person is guilty of an offence if, except as permitted by or under this Act, he sells a live badger or offers one for sale or has a live badger in his possession or under his control.''',
  // Subsection 2 left out as it only applies in Scotland

  Legislation.poba92s14:'''Protection of Badgers Act 1992

14 Interpretation.

In this Act—

“ammunition” has the same meaning as in the Firearms Act 1968;

“badger” means any animal of the species Meles meles;

“badger sett” means any structure or place which displays signs indicating current use by a badger;

“firearm” has the same meaning as in the Firearms Act 1968;

“sale” includes hire, barter and exchange and cognate expressions shall be construed accordingly.''',

  Legislation.waca81s11:'''Wildlife and Countryside Act 1981

11 Prohibition of certain methods of killing or taking wild animals.

(1) Subject to the provisions of this Part, if any person—

(a) sets in position any self-locking snare which is of such a nature and so placed as to be calculated to cause bodily injury to any wild animal coming into contact therewith;

(b) uses for the purpose of killing or taking any wild animal any self-locking snare, whether or not of such a nature or so placed as aforesaid, any bow or cross-bow or any explosive other than ammunition for a firearm;

(c) uses as a decoy, for the purpose of killing or taking any wild animal, any live mammal or bird whatever; or

(d) knowingly causes or permits to be done an act which is mentioned in the foregoing provisions of this section,

he shall be guilty of an offence.

(2) Subject to the provisions of this Part, a person shall be guilty of an offence if that person—

(a) uses any trap or snare for the purpose of killing or taking or restraining any wild animal included in Schedule 6 or 6ZA;

(b) sets in position any trap or snare of such a nature and so placed as to be—

(i) in England and Wales, calculated to cause bodily injury to any wild animal included in Schedule 6 or 6ZA;

(ii) in Scotland, likely to cause bodily injury to any such wild animal;

(c) sets in position any electrical device for killing or stunning, or any poisonous, poisoned or stupefying substance, of such a nature and so placed as to be—

(i) in England and Wales, calculated to cause bodily injury to any wild animal included in Schedule 6;

(ii) in Scotland, likely to cause bodily injury to any such wild animal;

(d) uses for the purpose of killing or taking any wild animal included in Schedule 6—

(i) any electrical device for killing or stunning;

(ii) any poisonous, poisoned or stupefying substance;

(iii) any net;

(iv) any automatic or semi-automatic weapon;

(v) any device for illuminating a target or sighting device for night shooting;

(vi) any form of artificial light or any mirror or other dazzling device;

(vii) any gas or smoke not falling within sub-paragraph (ii);

(viii) any sound recording used as a decoy; or

(ix) any mechanically propelled vehicle in immediate pursuit of any such animal;

(e) uses any mechanically propelled vehicle for the purpose of driving any wild animal included in Schedule 6; or

(f) knowingly causes or permits to be done an act mentioned in paragraphs (a) to (e).

(3) Subject to the provisions of this Part, if any person—

(a) sets in position or knowingly causes or permits to be set in position any snare which is of such a nature and so placed as to be calculated to cause bodily injury to any wild animal coming into contact therewith; and

(b) while the snare remains in position fails, without reasonable excuse, to inspect it, or cause it to be inspected, at least once every day,

he shall be guilty of an offence.

(4) The Secretary of State may, for the purpose of complying with an international obligation, by order, either generally or in relation to any kind of wild animal specified in the order, amend subsection (1) or (2) by adding any method of killing or taking wild animals or by omitting any such method as is mentioned in that subsection.

(5) In any proceedings for an offence under subsection (1)(b) or (c) or (2)(a), (d) or (e), and in any proceedings for an offence under subsection (1)(d) or (2)(f) relating to an act which is mentioned in any of those paragraphs the animal in question shall be presumed to have been a wild animal unless the contrary is shown.

(6) In any proceedings for an offence under subsection (2)(b) or (c) it shall be a defence to show that the article was set in position by the accused for the purpose of killing or taking, in the interests of public health, agriculture, forestry, fisheries or nature conservation, any wild animals which could be lawfully killed or taken by those means and that he took all reasonable precautions to prevent injury thereby to any wild animals included in the relevant Schedule.

(7) In any proceedings for an offence under subsection (2)(f) relating to an act which is mentioned in subsection (2)(b) or (c) it shall be a defence to show that the article was set in position for the purpose of killing or taking, in the interests of public health, agriculture, forestry, fisheries or nature conservation, any wild animals which could be lawfully killed or taken by those means and that he took or caused to be taken all reasonable precautions to prevent injury thereby to any wild animals included in the relevant Schedule.

(7A) In subsections (6) and (7), “the relevant Schedule” means—

(a) where proceedings relate to an offence under subsection (2)(b), Schedule 6 or 6ZA;

(b) where proceedings relate to an offence under subsection (2)(c), Schedule 6.''',

  Legislation.waca81sch6:'''Wildlife and Countryside Act 1981

Schedule 6

Animals which may not be Killed or Taken by Certain Methods

Common name \u{2014} Scientific name

Badger \u{2014} Meles meles
Bats, Horseshoe (all species) \u{2014} Rinolophidae
Bats, Typical (all species) \u{2014} Vespertilionidae
Cat, Wild \u{2014} Felis silvestris
Dolphin, Bottle-nosed \u{2014} Tursiops truncatus (otherwise known as Tursiops tursio)
Dolphin, Common \u{2014} Delphinis delphis
Dormice (all species) \u{2014} Gliridae
Hedgehog \u{2014} Erinaceus europaeus
Marten, Pine \u{2014} Martes martes
Otter, Common \u{2014} Lutra lutra
Polecat \u{2014} Mustela putorius
Porpoise, Harbour (otherwise known as Common porpoise) \u{2014} Phocaena phocaena
Shrews (all species) \u{2014} Soricidae
Squirrel, Red \u{2014} Sciurus vulgaris

Note. The common name or names given in the first column of this Schedule are included by way of guidance only; in the event of any dispute or proceedings, the common name or names shall not be taken into account.''',

  Legislation.wmpa96s1:'''Wild Mammals (Protection) Act 1996

1 Offences.

If, save as permitted by this Act, any person mutilates, kicks, beats, nails or otherwise impales, stabs, burns, stones, crushes, drowns, drags or asphyxiates any wild mammal with intent to inflict unnecessary suffering he shall be guilty of an offence.''',
};
