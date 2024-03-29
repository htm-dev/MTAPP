import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
import 'package:dio/dio.dart';
import 'package:random_string/random_string.dart';

class Commande_Repository {

  TextEditingController _textFieldController = new TextEditingController();

  displayDialog(BuildContext context, DocumentSnapshot document,String phone) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Saisir la quantité'),
            content: TextField(
              keyboardType: TextInputType.number,
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "En mètre carré"),
            ),
            actions: <Widget>[
              new RaisedButton(
                color: Colors.blueAccent,
                child: new Text(
                  'Commander', style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  Navigator.of(context).pop();
                  if (int.parse(_textFieldController.text.toString()) <=
                      document['qte']) {
                    FirebaseUser user = await FirebaseAuth.instance
                        .currentUser();
                    if(user!=null){
                      String codeCmd = randomAlpha(6);
                      //DocumentReference refProd = Firestore.instance.collection('products').document(document.documentID);
                      //DocumentReference refClient = Firestore.instance.collection('client').document(user.uid);
                     Dio dio = new Dio();
                      try {
                        await dio.post("https://smsmosaique.herokuapp.com/api/v1/sms", data: {"phoneNumber": phone, "message": codeCmd});
                        print('successful');
                      } catch (e) {
                        print(e);
                      }
                      Map<String, dynamic> data = {
                        'dateCommande': Timestamp.fromDate(DateTime.now()),
                        'produit': document.documentID.toString(),
                        'qte': _textFieldController.text.toString(),
                        'client': user.uid.toString(),
                        'code' : codeCmd,
                        'visible': false,
                        'state' : "",
                      };
                      //TODO : Ajouter la reffenrence du client et du produit

                      Firestore.instance.collection('commande').document()
                          .setData(data).whenComplete(() {
                        Navigator.of(context).pop();
                        _textFieldController.clear();
                        Toast.show('Commande réussie', context,
                            duration: Toast.LENGTH_LONG);
                      });

                    }else{
                      Navigator.pushNamed(context, '/first_screen');
                    }
                  } else {
                    Toast.show('Quantité non valable', context,
                        duration: Toast.LENGTH_LONG);
                  }
                },
              ),
              new FlatButton(

                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _textFieldController.clear();
                },
              )
            ],
          );
        });
  }
}