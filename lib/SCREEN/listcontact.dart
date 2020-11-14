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
  final _formKey = GlobalKey<FormState>();
  String nom = '';
  String profession = '';
  String structure = '';
  String numero1 = '';
  String numero2 = '';
  String numero3 = '';

  @override
  Widget build(BuildContext context) {
    W = MediaQuery.of(context).size.width;
    H = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maron1,
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
                      validator: (value) =>
                          value.isEmpty ? 'numero obligatoire' : null,
                      onSaved: (newValue) => numero1 = newValue,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'numero 1',
                          fillColor: Colors.white,
                          filled: true),
                    ),
                    SizedBox(
                      height: H * .01,
                    ),
                    TextFormField(
                      onSaved: (newValue) => numero2 = newValue,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'numero 2',
                          fillColor: Colors.white,
                          filled: true),
                    ),
                    SizedBox(
                      height: H * .01,
                    ),
                    TextFormField(
                      onSaved: (newValue) => numero3 = newValue,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'numero 3',
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
                            print(nom);
                          } else {
                            nom = '';
                            profession = '';
                            structure = '';
                            numero1 = '';
                            numero2 = '';
                            numero3 = '';
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
