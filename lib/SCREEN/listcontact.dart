import 'package:contact/CONSTANT/couleur.dart';
import 'package:contact/CUSTOMWIDGET/backgroundwidget.dart';
import 'package:contact/DATARAW/data.dart';
import 'package:flutter/material.dart';

class ListContact extends StatefulWidget {
  @override
  _ListContactState createState() => _ListContactState();
}

class _ListContactState extends State<ListContact> {
  double H, W;
  @override
  Widget build(BuildContext context) {
    W = MediaQuery.of(context).size.width;
    H = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maron1,
        actions: [
          GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.add,
                color: btnvalider,
              ),
            ),
          )
        ],
      ),
      body: Container(
        height: H,
        width: W,
        child: CustomPaint(
          painter: BackgroundPaint(),
          child: ListView.builder(
            itemCount: listContact.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: bleu,
                  child: Text(
                    firstLetter(listContact[index].name),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                ),
                title: Text(
                  listContact[index].name,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                subtitle: Text(
                  listContact[index].structure,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String firstLetter(String word) {
    return word[0].toUpperCase();
  }
}
