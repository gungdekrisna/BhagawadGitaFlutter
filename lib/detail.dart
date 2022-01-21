import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'sloka.dart';

AudioPlayer audioPlayer = AudioPlayer();

class DetailScreen extends StatelessWidget {
  final Sloka sloka;
  const DetailScreen({ Key? key, required this.sloka }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Screen"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "BAB ${sloka.bab} : Sloka ${sloka.sloka}",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                    sloka.klasifikasi,
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
                    sloka.isiSloka,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18.0,
                    ),
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
                    sloka.isiTerjemahan,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  ElevatedButton(onPressed: () {
                    audioPlayer.play("http://api.wargabali.com/mp3/sloka-1-2.mp3");
                  }, child: Text("Play")),
                  SizedBox(height: 6.0),
                  ElevatedButton(onPressed: () {
                    audioPlayer.stop();
                  }, child: Text("Stop")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}