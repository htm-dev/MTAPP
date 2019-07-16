import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  var _categUsers = ['Vendeur', 'Fournisseur', 'Particulier'];
  var _currentItemSelected = 'Particulier';

  final _formKey = GlobalKey<FormState>();

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
          padding: EdgeInsets.only(top: 25),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 80,
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
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 30, right: 30),
                      decoration: new BoxDecoration(
                        border: Border.all(
                        width: 0.5
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(25) //                 <--- border radius here
                      ),
                      ),
                      child: Column(
                        children: <Widget>[
                          TextField(
                          autofocus: false,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          decoration: InputDecoration(
                            //labelText: "Email",
                            hintText: "Nom et prénom",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(25.0),
                                topRight: const Radius.circular(25.0)
                              ),
                              borderSide: BorderSide(color: Colors.greenAccent, width: 5.0)
                            )
                          ),
                        ),
                        TextField(
                          autofocus: false,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: InputDecoration(
                            //labelText: "Email",
                            hintText: "Email",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              //border: Border.all(), 
                              borderRadius: BorderRadius.all(Radius.circular(0)),
                              //borderSide: BorderSide(color: Colors.greenAccent, width: 5.0)
                            )
                          ),
                          //validator: (value) => value.isEmpty ? 'GGG' : null,
                        ),
                        TextField(
                          autofocus: false,
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                          controller: telController,
                          decoration: InputDecoration(
                            //labelText: "Email",
                            hintText: "Tél",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(0)),
                              borderSide: BorderSide(color: Colors.greenAccent, width: 5.0)
                            )
                          ),
                        ),
                        TextField(
                          autofocus: false,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          controller: pwdController,
                          decoration: InputDecoration(
                            //labelText: "Email",
                            hintText: "Mot de passe",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(0)),
                              borderSide: BorderSide(color: Colors.greenAccent, width: 5.0)
                            )
                          ),
                        ),
                        Row(
                          children: <Widget>[ 
                            Expanded(
                              child: Container(
                                decoration: new BoxDecoration(
                                  border: Border.all(
                                  width: 0.5
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: const Radius.circular(25.0),
                                  bottomRight: const Radius.circular(25.0)
                                ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
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
                                        margin: const EdgeInsets.only(left: 2),
                                        child: ButtonTheme(
                                          alignedDropdown: true,
                                          child: DropdownButton<String>(
                                        items: _categUsers.map((String dropDownStringItem) {
                                          return DropdownMenuItem<String>(
                                              value: dropDownStringItem,
                                              child: Text(dropDownStringItem),
                                          );
                                      }).toList(),
                                      onChanged: (String newValueSelected){
                                        setState(() {
                                          this._currentItemSelected = newValueSelected;
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
                    onPressed: signUp,
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
      ),
    );
  }

  Future<void> signUp() async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: pwdController.text);
        print('Inscrit !');
      }catch(e){
        print(e.message);
      }
    }
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('utilisateurs').document(user.uid)
        .setData(
        { 'nom': nameController.text,
          'email': emailController.text,
          'tel': telController.text,
          'motdepasse': pwdController.text
        });
    
  }

  /*void addUser(String uid) async{
    Future<void> _userRef = FirebaseDatabase.instance.reference().child('users').child(uid).set({
      'name': nameController,
      'email': emailController,
      'tel': telController,
      'password': pwdController
    });
  }*/

}