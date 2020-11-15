import 'package:contact/CONSTANT/couleur.dart';
import 'package:contact/CUSTOMWIDGET/backgroundwidget.dart';
import 'package:contact/CUSTOMWIDGET/bouncetransition.dart';
import 'package:contact/SCREEN/detailcontact.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListContact extends StatefulWidget {
  @override
  _ListContactState createState() => _ListContactState();
}

class _ListContactState extends State<ListContact> {
  double H, W;
  final _formKey = GlobalKey<FormState>();
  String nom = '';
  String profession = '';
  String structure = '';
  String numero = '';
  String email = '';

  final _firestore = FirebaseFirestore.instance.collection('CONTACTS');
  @override
  Widget build(BuildContext context) {
    W = MediaQuery.of(context).size.width;
    H = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maron1,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () => _showDialogRegister(context),
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
          child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.orderBy('NOM').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                if (snapshot.hasError)
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                QuerySnapshot contact = snapshot.data;
                return ListView.builder(
                    itemCount: contact.size,
                    itemBuilder: (context, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundColor: bleu,
                            child: Text(
                              firstLetter(contact.docs[index]['NOM']),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                          ),
                          title: Text(
                            contact.docs[index]['NOM'],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          subtitle: Text(
                            contact.docs[index]['STRUCTURE'],
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                BounceTransition(
                                    widget: DetailContact(
                                        contact: contact.docs[index])));
                          },
                        ));
              }),
        ),
      ),
    );
  }

  String firstLetter(String word) {
    return word[0].toUpperCase();
  }

  _showDialogRegister(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: maron1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text('Nouveau contact'),
          content: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      validator: (value) =>
                          value.isEmpty ? 'nom obligatoire' : null,
                      onSaved: (newValue) => nom = newValue,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'nom complet',
                          fillColor: Colors.white,
                          filled: true),
                    ),
                    SizedBox(
                      height: H * .01,
                    ),
                    TextFormField(
                      onSaved: (newValue) => profession = newValue,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'profession',
                          fillColor: Colors.white,
                          filled: true),
                    ),
                    SizedBox(
                      height: H * .01,
                    ),
                    TextFormField(
                      onSaved: (newValue) => structure = newValue,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'structure',
                          fillColor: Colors.white,
                          filled: true),
                    ),
                    SizedBox(
                      height: H * .01,
                    ),
                    TextFormField(
                      onSaved: (newValue) => email = newValue,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'email',
                          fillColor: Colors.white,
                          filled: true),
                    ),
                    SizedBox(
                      height: H * .01,
                    ),
                    TextFormField(
                      validator: (value) =>
                          value.isEmpty ? 'numero obligatoire' : null,
                      onSaved: (newValue) => numero = newValue,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'numero',
                          fillColor: Colors.white,
                          filled: true),
                    ),
                    SizedBox(
                      height: H * .01,
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            _firestore.add({
                              'NOM': nom,
                              'STRUCTURE': structure,
                              'PROFESSION': profession,
                              'NUMERO': numero,
                              'EMAIL': email,
                            }).then((value) => Navigator.of(context).pop());
                          } else {
                            nom = '';
                            profession = '';
                            structure = '';
                            numero = '';
                            email = '';
                          }
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: btnvalider,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
