import 'package:contact/CONSTANT/couleur.dart';
import 'package:contact/CUSTOMWIDGET/backgroundwidget.dart';
import 'package:contact/CUSTOMWIDGET/bouncetransition.dart';
import 'package:contact/SCREEN/listcontact.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailContact extends StatefulWidget {
  var contact;
  DetailContact({this.contact});
  @override
  _DetailContactState createState() => _DetailContactState();
}

class _DetailContactState extends State<DetailContact> {
  double W, H;
  final _firestore = FirebaseFirestore.instance.collection('CONTACTS');
  @override
  Widget build(BuildContext context) {
    W = MediaQuery.of(context).size.width;
    H = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: H,
        width: W,
        child: CustomPaint(
          painter: BackgroundPaint(),
          child: Column(
            children: [
              SizedBox(
                height: H * .05,
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context, BounceTransition(widget: ListContact())),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 15),
                      child: Text(
                        'Retour',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: H * .05,
              ),
              Container(
                child: CircleAvatar(
                  radius: W * .2,
                  backgroundColor: Colors.white.withAlpha(70),
                  child: Text(
                    firstLetter(widget.contact['NOM']),
                    style: TextStyle(
                        color: bleu,
                        fontWeight: FontWeight.bold,
                        fontSize: W * .3),
                  ),
                ),
              ),
              SizedBox(
                height: H * .05,
              ),
              Container(
                width: W,
                child: Card(
                  color: Colors.white.withAlpha(70),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              widget.contact['NOM'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: H * .01,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              widget.contact['PROFESSION'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: H * .01,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              widget.contact['STRUCTURE'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: H * .01,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              widget.contact['EMAIL'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: H * .01,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              widget.contact['NUMERO'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: H * .05,
              ),
              Container(
                width: W,
                height: H * .1,
                child: Card(
                  elevation: 3,
                  color: maron,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          _launchURL('tel:${widget.contact['NUMERO']}');
                        },
                        icon: Icon(
                          Icons.call,
                          color: Colors.green,
                          size: 50,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _launchURL('sms:${widget.contact['NUMERO']}');
                        },
                        icon: Icon(
                          Icons.message,
                          color: Colors.blue,
                          size: 50,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _launchURL('mailto:${widget.contact['EMAIL']}');
                        },
                        icon: Icon(
                          Icons.mail,
                          color: Colors.deepOrange,
                          size: 50,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _firestore.doc(widget.contact.id).delete().then(
                              (value) => Navigator.push(context,
                                  BounceTransition(widget: ListContact())));
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red[900],
                          size: 50,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String firstLetter(String word) {
    return word[0].toUpperCase();
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
