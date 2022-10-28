import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderController>(
      builder: (context, controller, child) {
        return Scaffold(
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
                      fontSize = double.tryParse(value.toString())!;
                    });
                  },
                ),
              ),
            ],
            centerTitle: true,
            elevation: 0,
            title: Text(
              quran.getSurahNameArabic(controller.verseNumber),
              style: GoogleFonts.readexPro(textStyle: TextStyle(fontSize: 30)),
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(
              top: 20,
            ),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      quran.basmala,
                      style: GoogleFonts.readexPro(
                        textStyle: TextStyle(fontSize: 28),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Builder(
                    builder: (context) {
                      String str = "";
                      for (int i = 0;
                          i < quran.getVerseCount(controller.verseNumber);
                          i++) {
                        str += quran.getVerse(controller.verseNumber, i + 1,
                            verseEndSymbol: true);
                      }
                      return Text(
                        str,
                        style: GoogleFonts.readexPro(
                          textStyle: TextStyle(
                              fontSize: fontSize, wordSpacing: 2, height: 2),
                        ),
                        textAlign: TextAlign.justify,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
