import 'package:fire_radio/model/app_radio.dart';
import 'package:fire_radio/util/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AppRadio>? radios;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          VxAnimatedBox()
              .size(context.screenWidth, context.screenHeight)
              .withGradient(
                LinearGradient(
                  colors: [
                    AppColors.primaryColor1,
                    AppColors.primaryColor2,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                ),
              )
              .make(),
          // stack is LIFO so position of element matters
          AppBar(
            title: "Fire Radio".text.extraBold.xl3.make().shimmer(
                  primaryColor: AppColors.primaryColor2,
                  secondaryColor: context.theme.focusColor,
                ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ).h(100).p16(),
          (radios?.isNotEmpty ?? false)
              ? VxSwiper.builder(
                  enlargeCenterPage: true,
                  aspectRatio: 1.0,
                  itemCount: radios!.length,
                  itemBuilder: (context, index) {
                    final radio = radios![index];
                    return VxBox(
                      child: ZStack([
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: VStack([
                            radio.name.text.bold
                                .color(context.theme.focusColor)
                                .xl3
                                .make(),
                          ]),
                        ),
                      ]),
                    )
                        .bgImage(
                          DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              radio.image,
                            ),
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.3),
                              BlendMode.darken,
                            ),
                          ),
                        )
                        .roundedLg
                        .border(
                          color: context.theme.focusColor,
                          width: 5,
                        )
                        .makeCentered()
                        .p16();
                  },
                )
              : CircularProgressIndicator(
                  //show a white circle and blue progress indicator
                  backgroundColor: context.theme.focusColor,
                ).centered(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchRadios();
  }

  fetchRadios() async {
    final radioJson = await rootBundle.loadString("assets/radio.json");
    radios = AppRadioList.fromJson(radioJson).radios;
    setState(() {});
  }
}
