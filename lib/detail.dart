import 'package:bhagawad_gita/my_audio.dart';
import 'package:bhagawad_gita/verse_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sloka.dart';

class DetailScreen extends StatelessWidget {
  final Sloka sloka;
  const DetailScreen({ Key? key, required this.sloka }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DetailScreen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => MyAudio()),
            ChangeNotifierProvider(create: (_) => VerseAudio()),
          ],
          child: MyDetailPage(title: 'Bhagawad Gita', sloka: sloka)
        ),
    );
  }
}

class MyDetailPage extends StatefulWidget {
  MyDetailPage({Key? key, required this.title, required this.sloka}) : super(key: key);

  final String title;
  final Sloka sloka;

  @override
  _MyDetailPageState createState() => _MyDetailPageState();
}

class _MyDetailPageState extends State<MyDetailPage> {
  @override
  void initState() {
    MyAudio().initAudio();
    VerseAudio().initAudio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "BAB ${widget.sloka.bab} : Sloka ${widget.sloka.sloka}",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                    widget.sloka.klasifikasi,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    )
                )
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    "Isi Sloka",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    widget.sloka.isiSloka,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Consumer<VerseAudio>(
                    builder: (_, verseAudio, child) =>
                    Column(
                      children: [
                        SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 5,
                          ),
                          child: Slider(
                            value: verseAudio.position == Duration.zero ? 0 : verseAudio.position.inMilliseconds.toDouble(),
                            onChanged: (value) {
                              setState(() {
                                verseAudio.seekAudio(Duration(milliseconds: value.toInt()));
                              });
                            },
                            min: 0,
                            max: verseAudio.totalDuration == Duration.zero ? 20 : verseAudio.totalDuration.inMilliseconds.toDouble(),
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      CircleBorder()
                                  ),
                                  padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                                  backgroundColor: verseAudio.audioState == 'Playing' ? MaterialStateProperty.all(Colors.grey) : MaterialStateProperty.all(Colors.blue),
                                ),
                                onPressed: () {
                                  verseAudio.playAudio("https://www.holy-bhagavad-gita.org/public/audio/${widget.sloka.bab.toString().padLeft(3, '0')}_${widget.sloka.sloka.toString().padLeft(3, '0')}.mp3");
                                },
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                )
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      CircleBorder()
                                  ),
                                  padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                                  backgroundColor: verseAudio.audioState == 'Paused' || verseAudio.audioState == 'Stopped' ? MaterialStateProperty.all(Colors.grey) : MaterialStateProperty.all(Colors.blue),
                                ),
                                onPressed: () {
                                  verseAudio.pauseAudio();
                                },
                                child: Icon(
                                  Icons.pause,
                                  color: Colors.white,
                                )
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      CircleBorder()
                                  ),
                                  padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                                  backgroundColor: verseAudio.audioState == 'Stopped' ? MaterialStateProperty.all(Colors.grey) : MaterialStateProperty.all(Colors.blue),
                                ),
                                onPressed: () {
                                  verseAudio.stopAudio();
                                  verseAudio.position = Duration.zero;
                                },
                                child: Icon(
                                  Icons.stop,
                                  color: Colors.white,
                                )
                            ),
                          ],
                        )
                      ],
                    )
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    "Terjemahan",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    widget.sloka.isiTerjemahan,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Consumer<MyAudio>(
                    builder: (_, myAudioModel, child) =>
                    Column(
                      children: [
                        SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 5,
                          ),
                          child: Slider(
                            value: myAudioModel.position == Duration.zero ? 0 : myAudioModel.position.inMilliseconds.toDouble(),
                            onChanged: (value) {
                            setState(() {
                              myAudioModel.seekAudio(Duration(milliseconds: value.toInt()));
                            });
                          },
                            min: 0,
                            max: myAudioModel.totalDuration == Duration.zero ? 20 : myAudioModel.totalDuration.inMilliseconds.toDouble(),
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    CircleBorder()
                                  ),
                                  padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                                  backgroundColor: myAudioModel.audioState == 'Playing' ? MaterialStateProperty.all(Colors.grey) : MaterialStateProperty.all(Colors.blue),
                                ),
                                onPressed: () {
                                  myAudioModel.playAudio("http://api.wargabali.com/mp3/${widget.sloka.audioTerjemahan}");
                                },
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                )
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        CircleBorder()
                                    ),
                                    padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                                    backgroundColor: myAudioModel.audioState == 'Paused' || myAudioModel.audioState == 'Stopped' ? MaterialStateProperty.all(Colors.grey) : MaterialStateProperty.all(Colors.blue),
                                ),
                                onPressed: () {
                                  myAudioModel.pauseAudio();
                                },
                                child: Icon(
                                  Icons.pause,
                                  color: Colors.white,
                                )
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        CircleBorder()
                                    ),
                                    padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                                    backgroundColor: myAudioModel.audioState == 'Stopped' ? MaterialStateProperty.all(Colors.grey) : MaterialStateProperty.all(Colors.blue),
                                ),
                                onPressed: () {
                                  myAudioModel.stopAudio();
                                  myAudioModel.position = Duration.zero;
                                },
                                child: Icon(
                                  Icons.stop,
                                  color: Colors.white,
                                )
                            ),
                          ],
                        )
                      ],
                    )
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    "Pembahasan",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    "Kasih sayang material, penyesalan dan air mata semuanya adalah tanda-tanda kebodohan terhadap diri yang sejati. Kasih sayang terhadap sang roh yang kekal adalah keinsafan diri. Kata ÐMadhusłdana bermakna dalam ayat ini. Dahulu kala ŽrŒ K‚‰†a membunuh raksasa bernama Madhu. Sekarang Arjuna ingin supaya K‚‰†a membunuh sifat keraksasaan yang telah menguasai dirinya yang berupa kesalahpahaman dalam pelaksanaan kewajibannya. Tiada seorang pun mengetahui di mana kasih sayang harus digunakan. Kasih sayang terhadap pakaian yang disandang orang yang sedang tenggelam tidaklah masuk akal. Orang yang telah jatuh ke dalam lautan kebodohan tidak dapat diselamatkan hanya dengan menyelamatkan pakaian lahiriahnyaÅyaitu badan jasmani yang kasar. Orang yang tidak mengetahui hal ini dan menyesal karena pakaian lahiriah disebut dra, atau orang yang menyesal bila penyesalan tidak diperlukan. Arjuna adalah seorang k‰atriya, dan tingkah laku seperti ini tidak pantas bagi Arjuna. Akan tetapi, ŽrŒ K‚‰†a dapat menghilangkan penyesalan orang yang bodoh, dan karena inilah Bhagavad-gŒtƒ disabdakan oleh Beliau. Bab ini memberikan pelajaran kepada kita tentang keinsafan diri dengan mempelajari badan jasmani dan sang roh secara analisis, sebagaimana dijelaskan oleh penguasa yang paling tinggi, ŽrŒ K‚‰†a. Keinsafan tersebut dimungkinkan apabila seseorang bekerja tanpa ikatan terhadap hasil atau pahala dan mantap dalam paham yang tetap tentang sang diri yang sejati.",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}