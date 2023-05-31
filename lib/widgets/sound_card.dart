import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:funny_sound/globals/player.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SoundCard extends StatefulWidget {
  const SoundCard(
      {Key? key,
      required this.audio,
      required this.image,
      required this.name,
      required this.player})
      : super(key: key);
  final String audio;
  final String name;
  final String image;
  final PlayerMethod player;

  @override
  State<SoundCard> createState() => _SoundCardState();
}

class _SoundCardState extends State<SoundCard> {
  int toggleIndex = 0;
  bool isPlay = false;
  void ontabPlay(bool isLoop) {
    widget.player.playLocalAsset(widget.audio, isLoop);
  }

  void ontabStop() {
    widget.player.stop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ontabStop();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: widget.player.player.onPlayerStateChanged,
      builder: (context, snapshot) {
        if(snapshot.data == PlayerState.COMPLETED){
          isPlay = false;
          ontabStop();
        }
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                25,
              ),
            ),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Image.asset(
                widget.image,
                width: 100,
                height: 100,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.name,
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              SizedBox(
                height: 20,
              ),
              ToggleSwitch(
                minWidth: 90.0,
                cornerRadius: 20.0,
                activeBgColors: [
                  [Colors.red[800]!],
                  [Colors.green[800]!],
                ],
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.amber,
                inactiveFgColor: Colors.white,
                initialLabelIndex: toggleIndex,
                totalSwitches: 2,
                labels: ['Kapat', 'Tekrar'],
                radiusStyle: true,
                onToggle: (index) {
                  setState(() {
                    if (isPlay) {
                      ontabStop();
                      isPlay = false;
                    }
                    if (index == 1) {
                      ontabPlay(true);
                    } else {
                      ontabStop();
                    }
                    toggleIndex = index!;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    if (toggleIndex == 1) {
                      ontabStop();
                      toggleIndex = 0;
                    }
                    if (!isPlay) {
                      ontabPlay(false);
                      isPlay = true;
                    } else {
                      ontabStop();
                      isPlay = false;
                    }
                  });
                },
                child: Text(
                  !isPlay ? 'Bir kez çal' : 'Durdur',
                ),
              ),
              Spacer(),
            ],
          ),
        );
      }
    );
  }
}
