import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:quran/quran.dart' as quran;
import 'package:qurany/Controllers/providerController.dart';

class Surah extends StatefulWidget {
  Surah({Key? key}) : super(key: key);

  @override
  State<Surah> createState() => _SurahState();
}

class _SurahState extends State<Surah> {
  double fontSize = 25;
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderController>(
      builder: (context, controller, child) {
        return ModalProgressHUD(
          inAsyncCall: load,
          child: Scaffold(
            appBar: AppBar(
              actions: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: DropdownButton(
                    underline: Container(),
                    icon: const Icon(
                      Icons.text_fields_sharp,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 20,
                        child: Text("20"),
                      ),
                      DropdownMenuItem(
                        value: 25,
                        child: Text("25"),
                      ),
                      DropdownMenuItem(
                        value: 30,
                        child: Text("30"),
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        load = true;
                        fontSize = double.tryParse(value.toString())!;
                      });

                      setState(() {
                        load = false;
                      });
                    },
                  ),
                ),
              ],
              centerTitle: true,
              elevation: 0,
              title: Text(
                quran.getSurahNameArabic(controller.verseNumber),
                style: GoogleFonts.readexPro(
                    textStyle: const TextStyle(fontSize: 30)),
              ),
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      controller.verseNumber == 9 || controller.verseNumber == 1
                          ? Container()
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 15,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                              ),
                              child: Text(
                                quran.basmala,
                                style: GoogleFonts.readexPro(
                                  textStyle: const TextStyle(fontSize: 28),
                                ),
                              ),
                            ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Builder(
                      builder: (context) {
                        String str = "";
                        for (int i = 0;
                            i < quran.getVerseCount(controller.verseNumber);
                            i++) {
                          str += " ${quran.getVerse(
                            controller.verseNumber,
                            i + 1,
                            verseEndSymbol: true,
                          )}";
                        }
                        return Text(
                          str,
                          style: GoogleFonts.readexPro(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: fontSize,
                              wordSpacing: 0,
                              height: 2,
                            ),
                          ),
                          textAlign: TextAlign.justify,
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 15,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              20,
                            ),
                          ),
                        ),
                        child: Text(
                          "صدق الله العظيم",
                          style: GoogleFonts.readexPro(
                            textStyle: const TextStyle(fontSize: 28),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
