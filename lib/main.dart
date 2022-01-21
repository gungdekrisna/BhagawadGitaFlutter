import 'package:bhagawad_gita/post_result_model.dart';
import 'package:flutter/material.dart';
import 'sloka.dart';
import 'detail.dart';

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

  TextEditingController nameController = TextEditingController();
  List<Sloka> listSloka = [];

  Widget slokaTemplate(sloka){
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "BAB ${sloka.bab} : Sloka ${sloka.sloka}",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              sloka.klasifikasi,
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              sloka.isiTerjemahan,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
            children: [
              TextField(
                decoration: InputDecoration(border: OutlineInputBorder(), hintText: "Insert name"),
                controller: nameController,
              ),
              ElevatedButton(
                onPressed: () {
                  PostResult.connectToAPI(nameController.text).then((value) {
                    listSloka = value;
                    setState(() {});
                  });
                },
                child: Text("POST"),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: listSloka.length,
                    itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DetailScreen(sloka: listSloka[index])),
                        );
                      },
                      child: Container(child: slokaTemplate(listSloka[index]))
                    );
                }),
              ),
            ],
        ),
      ),
    );
  }
}
