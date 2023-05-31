import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:funny_sound/globals/paths.dart';
import 'package:funny_sound/globals/player.dart';
import 'package:funny_sound/widgets/sound_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PlayerMethod _player = PlayerMethod();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/appicon.png'),
        ),
        backgroundColor: Colors.amber,
        elevation: 0,
        title: Text('Funny Sound'),
      ),
      body: Column(
        children: [
          CarouselSlider.builder(
            itemCount: GlobalPaths().paths.length,
            itemBuilder: (context, _, index) {
              return SoundCard(
                player: _player,
                audio: GlobalPaths().paths[_]['audio'].toString(),
                image: GlobalPaths().paths[_]['image'].toString(),
                name: GlobalPaths().paths[_]['name'].toString(),
              );
            },
            options: CarouselOptions(
                autoPlay: false,
                height: MediaQuery.of(context).size.height * 0.7,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                onPageChanged: (a, index) {
                  _player.stop();
                  _player.player.state = PlayerState.COMPLETED;
                }),
          ),
          SizedBox(height: 15,),
          Text('Funny Sound App',style: TextStyle(color: Colors.amberAccent,fontSize: 18,fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
