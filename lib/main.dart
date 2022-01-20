import 'package:bhagawad_gita/post_result_model.dart';
import 'package:flutter/material.dart';
import 'sloka.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Bhagawad Gita'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Sloka> slokas = [
    Sloka(isi_sloka: "isi sloka", isi_terjemahan: "ini sloka 1", klasifikasi: "ini terjemahan 1"),
    Sloka(isi_sloka: "isi sloka", isi_terjemahan: "ini sloka 2", klasifikasi: "ini terjemahan 2"),
    Sloka(isi_sloka: "isi sloka", isi_terjemahan: "ini sloka 3", klasifikasi: "ini terjemahan 3"),
  ];

  Widget slokaTemplate(sloka){
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              sloka.isi_sloka,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              sloka.isi_terjemahan,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              sloka.klasifikasi,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PostResult? postResult = null;
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Column(
            children: [
              TextField(
                decoration: InputDecoration(border: OutlineInputBorder(), hintText: "Insert name"),
                controller: nameController,
              ),
              ElevatedButton(
                onPressed: () {
                  PostResult.connectToAPI(nameController.text).then((value) {
                    postResult = value;
                    setState(() {});
                  });
                },
                child: Text("POST"),
              ),
              Text((postResult != null) ? postResult!.sloka.toString() + " | " : "Tidak ada data"),
            ],
          ),
          Column(
            children: ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemCount),
          )
        ]
      ),
    );
  }
}
