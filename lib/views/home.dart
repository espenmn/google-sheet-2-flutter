import 'package:flutter/material.dart';
import 'package:google_sheet_db/matrett_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<MatrettModel> matretter = List<MatrettModel>();

  getDataFromSheet() async {
    print('getting data');
    var raw = await http.get(
        "https://script.google.com/macros/s/AKfycbzttqFcWR5MeqjESvYXko73QxLjIEqX51ipDAAjIp4PYjjzwooh/exec");

    print(raw.toString());

    print(raw.body);

    // var jsonFeedback = convert.jsonDecode(raw.body);
    // print('this is json Feedback $jsonFeedback');

    // jsonFeedback.forEach((element) {
    //   print('$element THIS IS NEXT>>>>>>>');
    //   MatrettModel matrettModel = MatrettModel();
    //   matrettModel.navn = element['navn'];
    //   matrettModel.beskrivelse = element['beskrivelse'];
    //   matrettModel.bilde = element['bilde'];
    //   matrettModel.pris = element['pris'];
    //   matretter.add(matrettModel);
    // });

    //print('${feedbacks[0]}');
  }

  @override
  void initState() {
    getDataFromSheet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Min lille café"),
        elevation: 0,
      ),
      body: Container(
        child: ListView.builder(
            itemCount: matretter.length,
            itemBuilder: (context, index) {
              return MatrettTile(
                bilde: matretter[index].bilde,
                navn: matretter[index].navn,
                beskrivelse: matretter[index].beskrivelse,
                pris: matretter[index].pris,
              );
            }),
      ),
    );
  }
}

class MatrettTile extends StatelessWidget {
  final String navn, beskrivelse, bilde, pris;
  MatrettTile({this.navn, this.bilde, this.beskrivelse, this.pris});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      child: Image.network(bilde))),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(navn),
                  Text(
                    'pris',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 16),
          Text(beskrivelse)
        ],
      ),
    );
  }
}
