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
    print('getting  the data');
    var raw = await http.get(
        "https://script.google.com/macros/s/AKfycbyVQdl3bfjpF0CBiUnKPDWeq7Sn0_aESWg4jyl6Tx02Qqqs0cA/exec");

    // print(raw.body);

    var jsonFeedback = convert.jsonDecode(raw.body);
    // print('this is json Feedback $jsonFeedback');

    jsonFeedback.forEach((element) {
      print('$element dette er neste>>');
      MatrettModel matrettModel = MatrettModel();
      matrettModel.navn = element['navn'];
      matrettModel.beskrivelse = element['beskrivelse'];
      matrettModel.bilde = element['bilde'];
      matrettModel.pris = element['pris'];
      matretter.add(matrettModel);
    });
  }

  // getSheetData() async {
  //   print('lets get it from google');
  //
  //   // init GSheets
  //   final gsheets = GSheets(_credentials);
  //   // fetch spreadsheet by its id
  //   final ss = await gsheets.spreadsheet(_spreadsheetId);
  //   // get worksheet by its title
  //   var sheet = ss.worksheetByTitle('example');
  //   // create worksheet if it does not exist yet
  //   sheet ??= await ss.addWorksheet('example');
  //
  //   // cellsRow.forEach((cell)
  //   //
  //
  //   var rowws = sheet.values.allRows();
  //
  //   print(rowws.toString());
  //
  //   // rowws.forEach((element) {
  //   //   print('$element dette er neste>>');
  //   //   MatrettModel matrettModel = MatrettModel();
  //   //   matrettModel.navn = element['navn'];
  //   //   matrettModel.beskrivelse = element['beskrivelse'];
  //   //   matrettModel.bilde = element['bilde'];
  //   //   matrettModel.pris = element['pris'];
  //   //   matretter.add(matrettModel);
  //   // });
  // }

  @override
  void initState() {
    getDataFromSheet();
    // getSheetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Min lille café"),
        backgroundColor: Colors.red[900],
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
  final String navn, beskrivelse, bilde;
  final int pris;
  MatrettTile({this.navn, this.bilde, this.beskrivelse, this.pris});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 100,
                  width: 140,
                  child: Image.network(
                    bilde,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      navn,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      beskrivelse,
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Pris: ${pris.toString()},–",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
            // Text(beskrivelse)
          ],
        ),
      ),
    );
  }
}
