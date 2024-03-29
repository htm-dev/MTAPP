import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserRegister extends StatefulWidget{

  @override
  _UserRegisterState createState() => _UserRegisterState();

}

class _UserRegisterState extends State<UserRegister>{

  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  final nameController = TextEditingController();
  final telController = TextEditingController();
  final catController = TextEditingController();
  var _categUsers = ['Prescripteur', 'Revendeur', 'Professionnel', 'Particulier'];
  var _currentItemSelected = 'Particulier';

  final _formKey = GlobalKey<FormState>();
  //final FirebaseMessaging _messaging = FirebaseMessaging();
 // var  devToken='';
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    pwdController.dispose();
    nameController.dispose();
    telController.dispose();
    catController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Form(
          key: _formKey,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            padding: EdgeInsets.only(top: 40),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 300),
                    child: IconButton(icon: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.black,
                    ), onPressed:() {Navigator.pop(context);}
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: SizedBox(
                      //width: 74,
                      height: 70,
                      child: Text("Inscription",
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Calibri',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    //height: MediaQuery.of(context).size.height /3,
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    decoration: new BoxDecoration(
                      /*border: Border.all(
                          width: 0.025
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(
                              25) //                 <--- border radius here
                      ),*/
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextField(
                          autofocus: false,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFE1F5FE),
                            //labelText: "Email",
                              hintText: "Nom et prénom",
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                              /*border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(25.0),
                                      topRight: const Radius.circular(25.0)
                                  ),
                                  borderSide: BorderSide(
                                      color: Colors.greenAccent, width: 5.0)
                              )*/
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          autofocus: false,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFE1F5FE),
                            //labelText: "Email",
                              hintText: "Email",
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                              /*border: OutlineInputBorder(
                                //border: Border.all(),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(0)),
                                //borderSide: BorderSide(color: Colors.greenAccent, width: 5.0)
                              )*/
                          ),
                          //validator: (value) => value.isEmpty ? 'GGG' : null,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          autofocus: false,
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                          controller: telController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFE1F5FE),
                            //labelText: "Email",
                              hintText: "Tél : 0612345678",
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                              /*border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0)),
                                  borderSide: BorderSide(
                                      color: Colors.greenAccent, width: 5.0)
                              )*/
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          autofocus: false,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          controller: pwdController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFE1F5FE),
                            //labelText: "Email",
                              hintText: "Mot de passe",
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                              /*border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0)),
                                  borderSide: BorderSide(
                                      color: Colors.greenAccent, width: 5.0)
                              )*/
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                height: 43,
                                //height: MediaQuery.of(context).size.height/13.1,
                                decoration: new BoxDecoration(
                                  color: Color(0xFFE1F5FE),
                                  /*border: Border.all(
                                      width: 1.5
                                  ),*/
                                  borderRadius: BorderRadius.all(const Radius.circular(25.7)),
                                  /*borderRadius: BorderRadius.only(
                                      bottomLeft: const Radius.circular(25.0),
                                      bottomRight: const Radius.circular(25.0)
                                  ),*/
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(

                                        //height: MediaQuery.of(context).size.height/2,
                                        margin: const EdgeInsets.only(left: 12),
                                        child: Row(
                                          children: <Widget>[
                                            Text("Catégorie",
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.blueGrey,
                                                //fontWeight: FontWeight.bold,
                                                fontFamily: 'Calibri',
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 2,
                                                    right: 5
                                                ),
                                                child: ButtonTheme(

                                                  alignedDropdown: true,
                                                  child: DropdownButton<String>(
                                                    items: _categUsers.map((
                                                        String dropDownStringItem) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: dropDownStringItem,
                                                        child: Text(
                                                            dropDownStringItem),
                                                      );
                                                    }).toList(),
                                                    onChanged: (
                                                        String newValueSelected) {
                                                      setState(() {
                                                        this
                                                            ._currentItemSelected =
                                                            newValueSelected;
                                                      });
                                                    },
                                                    value: _currentItemSelected,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 29,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 100),
                    child: ButtonTheme(
                      minWidth: 150,
                      shape: StadiumBorder(),
                      child: MaterialButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Center(child: CircularProgressIndicator(),);
                              });
                          await signUp();
                          //Navigator.pop(context);
                        },
                        textColor: Colors.lightBlue,
                        color: Colors.white,
                        height: 50,
                        child: Text("S'inscrire",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.bold,
                          ),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
  Future<void> signUp() async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      /*final QuerySnapshot result = await Firestore.instance
          .collection('utilisateurs')
          .where('email', isEqualTo: emailController.text.trim())
          .limit(1)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 1 && emailController.text.trim()==null) {
        Toast.show('Cet email est déjà utilisé', context, duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
        print('TRUE');
      }*/
      //else{
        try {

         /* _messaging.getToken().then((token)=>{
            devToken=token
          });*/
          FirebaseUser user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
              email: emailController.text.trim(), password: pwdController.text);
          Toast.show('Inscription réussie', context, duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM);
          FirebaseUser user1 = await FirebaseAuth.instance.currentUser();
          Firestore.instance.collection('utilisateurs').document(user1.uid)
              .setData(
              { 'nom': nameController.text,
                'email': emailController.text.trim(),
                'tel': "+212"+telController.text.substring(1),
                'categorie': _currentItemSelected,
                'devtoken': ""
              });
          Navigator.of(context).pushNamed('/home2');
        } catch (e) {
          switch(e.message){
            case 'Given String is empty or null':
              Toast.show('Veuillez remplir les champs', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
              break;
            case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
              Toast.show('Erreur de connexion', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
              break;
            case 'The email address is badly formatted.':
              Toast.show('Veuillez écrire correctement votre email', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
              break;
            case 'The email address is already in use by another account.':
              Toast.show('Cet email est utilisé par un autre compte', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
              break;
            case 'The given password is invalid. [ Password should be at least 6 characters ]':
              Toast.show('Le mot de passe doit contenir au moins 6 caractères', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
              break;
            default:
              Toast.show(e.message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          }
          //print(e.message);
          //Toast.show(e.message, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
        //print('FALSE');
      //}
      // ignore: unrelated_type_equality_checks
      /*if(checkUserExist(emailController.text.trim()) == true) {
        Toast.show('OUI', context, duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);*/
    }
  }

}