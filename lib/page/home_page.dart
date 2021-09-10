import 'package:audioplayers/audioplayers.dart';
import 'package:fire_radio/model/app_radio.dart';
import 'package:fire_radio/util/app_util.dart';
import 'package:flutter/cupertino.dart';
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

  late AppRadio _selectedRadio;
  Color? _selectedColor;
  bool _isPlaying = false;

  final _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          VxAnimatedBox()
              .animDuration(
                const Duration(seconds: 1),
              )
              .withGradient(
                LinearGradient(
                  colors: [
                    AppColors.primaryColor2,
                    _selectedColor ?? AppColors.primaryColor1,
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
                  secondaryColor: Colors.white,
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
                  onPageChanged: (index) {
                    final hexColor = radios![index].color;
                    _selectedColor = Color(
                      int.tryParse(hexColor)!,
                    );
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    final radio = radios![index];
                    return VxBox(
                      child: ZStack(
                        [
                          Positioned(
                            top: -5,
                            right: -5,
                            child: VxBox(
                              child: radio.category.text.uppercase.bold
                                  .scale(1.3)
                                  .extraBlack
                                  .make()
                                  .p16(),
                            )
                                .height(50)
                                .color(Colors.white)
                                .alignCenter
                                .bottomLeftRounded(
                                  value: 10,
                                )
                                .make(),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: VStack(
                              [
                                radio.name.text.bold
                                    .color(Colors.white)
                                    .xl3
                                    .make(),
                                5.heightBox,
                                radio.tagline.text.sm
                                    .color(Colors.white)
                                    .semiBold
                                    .make(),
                              ],
                              crossAlignment: CrossAxisAlignment.center,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: VStack(
                              [
                                const Icon(
                                  CupertinoIcons.play_fill,
                                  color: Colors.white,
                                ),
                                10.heightBox,
                                "Double tap to play".text.gray300.italic.make(),
                              ],
                              crossAlignment: CrossAxisAlignment.center,
                            ),
                          ),
                        ],
                      ),
                    )
                        .alignCenter
                        .clip(Clip.antiAlias)
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
                          color: Colors.white,
                          width: 5,
                        )
                        .make()
                        .onInkDoubleTap(() {
                      if (_isPlaying) {
                        _audioPlayer.stop();
                      } else {
                        _playMusic(radio.url);
                      }
                    }).p16();
                  },
                ).centered()
              : const CircularProgressIndicator(
                  //show a white circle and blue progress indicator
                  backgroundColor: Colors.white,
                ).centered(),
          Align(
            alignment: Alignment.bottomCenter,
            child: VStack(
              [
                if (_isPlaying)
                  "Playing now - ${_selectedRadio.name} FM"
                      .text
                      .color(Colors.white)
                      .italic
                      .xl2
                      .makeCentered(),
                Icon(
                  _isPlaying
                      ? CupertinoIcons.stop_circle
                      : CupertinoIcons.play_circle,
                  size: 80,
                  color: Colors.white,
                ).onInkTap(() {
                  if (_isPlaying) {
                    _audioPlayer.stop();
                  } else {
                    _playMusic(_selectedRadio.url);
                  }
                  setState(() {});
                }),
              ],
              crossAlignment: CrossAxisAlignment.center,
            ),
          ).pOnly(bottom: context.percentHeight * 12),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchRadios();
    _audioPlayer.onPlayerStateChanged.listen((event) {
      _isPlaying = (event == PlayerState.PLAYING);
      setState(() {});
    });
  }

  _playMusic(String url) {
    _audioPlayer.play(url);
    _selectedRadio = radios!.firstWhere((element) => element.url == url);
    setState(() {});
  }

  fetchRadios() async {
    final radioJson = await rootBundle.loadString("assets/radio.json");
    radios = AppRadioList.fromJson(radioJson).radios;
    _selectedRadio = radios![0];
    setState(() {});
  }
}
