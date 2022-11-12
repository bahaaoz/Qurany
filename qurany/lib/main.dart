import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:qurany/Controllers/providerController.dart';
import 'package:qurany/Loacalization/localController.dart';
import 'package:qurany/Loacalization/myLoacal.dart';
import 'package:qurany/Screens/homeScreen.dart';
import 'package:qurany/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    LocalController getController = LocalController();
    return ChangeNotifierProvider(
      create: (context) => ProviderController(),
      child:
          Consumer<ProviderController>(builder: (context, controller, child) {
        return GetMaterialApp(
          translations: MyLocal(),
          locale: getController.initLocal,
          theme: controller.initTheme()!
              ? ThemeData(
                  drawerTheme: DrawerThemeData(backgroundColor: darkColor),
                  brightness: Brightness.dark,
                  scaffoldBackgroundColor: darkColor,
                  appBarTheme: AppBarTheme(
                    color: darkColor,
                  ),
                )
              : ThemeData(
                  scaffoldBackgroundColor: lightColor,
                  brightness: Brightness.light,
                  tabBarTheme: const TabBarTheme(
                    labelColor: Colors.black,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  appBarTheme: AppBarTheme(
                    iconTheme: IconThemeData(color: darkColor),
                    titleTextStyle: const TextStyle(color: Colors.black),
                    color: lightColor,
                  ),
                ),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            key: scaffoldKey,
            drawer: Drawer(
              child: SafeArea(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                          height: 210,
                          width: 280,
                          child: Lottie.asset("images/reading.json")),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: controller.initTheme()!
                                    ? buttonColor
                                    : buttonColorLight,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: MaterialButton(
                                onPressed: () {},
                                child: Text(
                                  "Home".tr,
                                  style: const TextStyle(
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: controller.initTheme()!
                                    ? buttonColor
                                    : buttonColorLight,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  controller.changeTheme();
                                },
                                child: Text(
                                  "Change Theme".tr,
                                  style: const TextStyle(
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "Created by Bahaa",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ),
              ),
            ),
            appBar: AppBar(
              leading: InkWell(
                child: const Icon(FontAwesomeIcons.barsStaggered),
                onTap: () => scaffoldKey.currentState!.openDrawer(),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButton(
                    underline: Container(),
                    icon: const Icon(Icons.language),
                    items: const [
                      DropdownMenuItem(
                        value: "ar",
                        child: Text("عربي"),
                      ),
                      DropdownMenuItem(
                        value: "en",
                        child: Text("English"),
                      )
                    ],
                    onChanged: (value) {
                      getController.changeLanguge(value.toString());
                    },
                  ),
                ),
              ],
              title: Text(
                "Qurany",
                style: GoogleFonts.notoSerif(
                  textStyle: const TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              centerTitle: true,
              // actions: [
              //   TextButton(
              //     onPressed: () {
              //       print("bahaa");
              //       controller.changeTheme();
              //     },
              //     child: Text(
              //       "bahaa",
              //       style: TextStyle(color: Colors.white),
              //     ),
              //   )
              // ],
              elevation: 0,
            ),
            body: Home(),
          ),
        );
      }),
    );
  }
}
