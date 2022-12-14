import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:math' as math;
import 'package:quran/quran.dart' as quran;
import 'package:provider/provider.dart';
import 'package:qurany/Controllers/providerController.dart';
import 'package:qurany/Screens/surah.dart';
import 'package:qurany/main.dart';

import '../Loacalization/localController.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LocalController getController = LocalController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
          child: Text(
            "Welcome to Qurany".tr,
            style: GoogleFonts.trispace(
              textStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 105, 104, 104),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Consumer<ProviderController>(
          builder: (context, controller, child) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 140,
              width: MediaQuery.of(context).size.width - 20,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xFFC17AFB),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          children: [
                            const Icon(FontAwesomeIcons.readme),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Last read".tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Text(
                          getController.initLocal == Locale("en")
                              ? quran.getSurahName(
                                  sharedPreferences?.getInt("lastread") ?? 1)
                              : quran.getSurahNameArabic(
                                  sharedPreferences?.getInt("lastread") ?? 1),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(),
                  getController.initLocal! == const Locale("en")
                      ? Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: Image.asset(
                            "images/person2.png",
                          ),
                        )
                      : Image.asset(
                          "images/person2.png",
                        ),
                ],
              ),
            );
          },
        ),
        Expanded(
          child: getController.initLocal == const Locale("en")
              ? listTileEnglish()
              : listTileArabic(),
        )
      ],
    );
  }

  ListView listTileEnglish() {
    return ListView.builder(
      itemCount: 114,
      itemBuilder: (context, index) {
        int indexGood = index + 1;
        return Consumer<ProviderController>(
          builder: (context, controller, child) {
            return Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color.fromARGB(255, 43, 59, 107)))),
              child: ListTile(
                onTap: () {
                  controller.verseChose(indexGood);
                  Get.to(() => Surah());
                  sharedPreferences!.setInt("lastread", indexGood);
                },
                title: Text(
                  quran.getSurahName(indexGood),
                  style: GoogleFonts.secularOne(),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      quran
                          .getPlaceOfRevelation(indexGood)
                          .toString()
                          .toUpperCase(),
                    ),
                    const Text(" - "),
                    Text(
                      "${quran.getVerseCount(indexGood)} VERSES",
                    ),
                  ],
                ),
                leading: numberOfSurah(indexGood),
                trailing: Text(
                  indexGood == 111
                      ? "??????????"
                      : quran.getSurahNameArabic(indexGood),
                  style: GoogleFonts.readexPro(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 121, 65, 218),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  ListView listTileArabic() {
    return ListView.builder(
      itemCount: 114,
      itemBuilder: (context, index) {
        int indexGood = index + 1;
        return Consumer<ProviderController>(
          builder: (context, controller, child) {
            return Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color.fromARGB(255, 43, 59, 107)))),
              child: ListTile(
                onTap: () {
                  controller.verseChose(indexGood);
                  Get.to(Surah());
                  sharedPreferences!.setInt("lastread", indexGood);
                },
                title: Text(
                  indexGood == 111
                      ? "??????????"
                      : quran.getSurahNameArabic(indexGood),
                  style: GoogleFonts.readexPro(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 121, 65, 218),
                    ),
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      quran
                                  .getPlaceOfRevelation(indexGood)
                                  .toString()
                                  .toUpperCase() ==
                              "MAKKAH"
                          ? "????????"
                          : "??????????",
                      style: GoogleFonts.secularOne(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text(
                      " - ",
                      style: GoogleFonts.secularOne(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text(
                      "${quran.getVerseCount(indexGood)} ??????",
                      style: GoogleFonts.secularOne(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                leading: numberOfSurah(indexGood),
                trailing: Text(
                  quran.getSurahName(indexGood),
                  style: GoogleFonts.secularOne(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Container numberOfSurah(int index) {
    return Container(
      height: 50,
      width: 50,
      child: Stack(
        children: [
          const Icon(
            size: 50,
            Icons.hexagon_outlined,
            color: Color.fromARGB(255, 137, 87, 193),
          ),
          Center(
              child: Text(
            index.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ))
        ],
      ),
    );
  }
}
