import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/home_page.dart';
import 'colors.dart' as color;

class VideoInfo extends StatefulWidget {
  const VideoInfo({Key? key}) : super(key: key);

  @override
  _VideoInfoState createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  List videoInfo = [];
  bool _playArea = false;
  bool _isPlaying = false;
  bool _disposed = false;
  VideoPlayerController? _controller;

  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/videoinfo.json")
        .then((value) {
      setState(() {
        videoInfo = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    _disposed = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: _playArea == false
            ? BoxDecoration(
                gradient: LinearGradient(
                colors: [
                  color.AppColor.gradientFirst.withOpacity(0.9),
                  color.AppColor.gradientSecond,
                ],
                begin: const FractionalOffset(0.0, 0.4),
                end: Alignment.topRight,
              ))
            : BoxDecoration(color: color.AppColor.gradientSecond),
        child: Column(
          children: [
            _playArea == false
                ? Container(
                    padding: const EdgeInsets.only(
                      top: 70,
                      left: 30,
                      right: 30,
                    ),
                    width: width,
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Get.to(() => MyHomePage()),
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: color.AppColor.secondPageIconColor,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.info_outline,
                              size: 20,
                              color: color.AppColor.secondPageIconColor,
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Legs Toning ',
                          style: TextStyle(
                              color: color.AppColor.secondPageTitleColor,
                              fontSize: 25),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'and Glutes Workout',
                          style: TextStyle(
                              color: color.AppColor.secondPageTitleColor,
                              fontSize: 25),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 25,
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                gradient: LinearGradient(
                                  colors: [
                                    color.AppColor
                                        .secondPageContainerGradient1stColor,
                                    color.AppColor
                                        .secondPageContainerGradient2ndColor,
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.alarm_on_outlined,
                                    size: 15,
                                    color: color.AppColor.secondPageIconColor,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '68 min',
                                    style: TextStyle(
                                        color:
                                            color.AppColor.secondPageTitleColor,
                                        fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 25,
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                gradient: LinearGradient(
                                  colors: [
                                    color.AppColor
                                        .secondPageContainerGradient1stColor,
                                    color.AppColor
                                        .secondPageContainerGradient2ndColor,
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.handyman_outlined,
                                    size: 15,
                                    color: color.AppColor.secondPageIconColor,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Resistent band, Kettlebell',
                                    style: TextStyle(
                                        color:
                                            color.AppColor.secondPageIconColor,
                                        fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : _videoPlayArea(context),
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(60),
                  )),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      const Text(
                        "Circuit 1 : Legs Toning",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.loop,
                            size: 30,
                            color: color.AppColor.loopColor,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "3 sets",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: color.AppColor.setsColor),
                          ),
                          const SizedBox(width: 20),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(child: _listView())
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  _listView() {
    return ListView.builder(
        itemCount: videoInfo.length,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        itemBuilder: (_, index) {
          return GestureDetector(
              onTap: () {
                _onTapVideo(index);
                print(index);
                setState(() {
                  if (_playArea == false) {
                    setState(() {
                      _playArea = true;
                    });
                  }
                });
              },
              child: _buildCard(index));
        });
  }

  Widget _videoPlayArea(BuildContext context) {
    final controller = _controller;
    return Container(
      padding: EdgeInsets.only(top: 50, left: 30, right: 30),
      child: Column(
        children: [
          Container(
            height: 100,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: color.AppColor.secondPageIconColor,
                  ),
                  onPressed: () {
                    print('tapped');
                  },
                ),
                const Spacer(),
                Icon(
                  Icons.info_outline,
                  size: 20,
                  color: color.AppColor.secondPageTopIconColor,
                )
              ],
            ),
          ),
          if (controller != null && controller.value.isInitialized)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: VideoPlayer(controller),
            )
          else
            const AspectRatio(
              aspectRatio: 16 / 9,
              child: Center(
                  child: Text(
                "Preparing..",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white60,
                ),
              )),
            ),
          _controlView(context)
        ],
      ),
    );
  }

  Widget _controlView(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      color: color.AppColor.gradientSecond,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton(
              onPressed: () async {
                if (_isPlaying) {
                  setState(() {
                    _isPlaying = false;
                  });
                  _controller?.pause();
                } else {
                  setState(() {
                    _isPlaying = true;
                  });
                  _controller?.play();
                }
              },
              child: Icon(
                Icons.fast_rewind,
                size: 36,
                color: Colors.white,
              )),
          FlatButton(
              onPressed: () async {},
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                size: 36,
                color: Colors.white,
              )),
          FlatButton(
              onPressed: () async {},
              child: Icon(
                Icons.fast_forward,
                size: 36,
                color: Colors.white,
              )),
        ],
      ),
    );
  }

  var _onUpdateControllerTime;

  void _oncontrollerUpdate() async {
    if (_disposed) {
      return;
    }
    _onUpdateControllerTime = 0;
    final now = DateTime.now().microsecondsSinceEpoch;
    if (_onUpdateControllerTime > now) {
      return;
    }
    _onUpdateControllerTime = now + 500;
    final controller = _controller;
    if (controller == null) {
      print('controller is null');
      return;
    }
    if (!controller.value.isInitialized) {
      print('controller cannot be initialized');
      return;
    }
    final playing = controller.value.isPlaying;
    _isPlaying = playing;
  }

  _onTapVideo(int index) {
    final controller =
        VideoPlayerController.network(videoInfo[index]['videoUrl']);
    print(videoInfo[index]['videoUrl']);
    final old = _controller;
    if (old != null) {
      old.removeListener(_oncontrollerUpdate);
      old.pause();
    }
    _controller = controller;
    setState(() {});
    controller
      ..initialize().then((_) {
        old?.dispose();
        controller.addListener(_oncontrollerUpdate);
        controller.play();
        setState(() {});
      });
  }

  _buildCard(index) {
    return Container(
      height: 160,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(videoInfo[index]['thumbnail']),
                    )),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videoInfo[index]['title'],
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    videoInfo[index]['time'],
                    style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Container(
                width: 80,
                height: 20,
                decoration: const BoxDecoration(color: Color(0xFFeaeefc)),
                child: const Center(
                  child: Text(
                    '15s rest',
                    style: TextStyle(color: Color(0xff839fed)),
                  ),
                ),
              ),
              Row(
                children: [
                  for (int i = 0; i < 70; i++)
                    Container(
                      width: 3,
                      height: 1,
                      decoration: BoxDecoration(
                          color: i.isEven
                              ? const Color(0xff839fed)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(2)),
                    )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
