import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';

class EmailConfirmation extends StatefulWidget {

  @override
  _EmailConfirmationState createState() => _EmailConfirmationState();
}

class _EmailConfirmationState extends State<EmailConfirmation> {

  final emailController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
          //color: Colors.white,
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
                  height: 80,
                ),
                Center(
                  child: SizedBox(
                    //width: 74,
                    height: 100,
                    child: Text("Confirmation de l'email",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Calibri',
                      ),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 35, right: 35),
                        child: Column(
                          children: <Widget>[
                            //BorderRadius.all(Radius.circular(25)),
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
                              //borderRadius: BorderRadius.all(Radius.circular(25)),
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(25.0),
                                topRight: const Radius.circular(25.0)
                              ),
                              borderSide: BorderSide(color: Colors.greenAccent, width: 5.0)
                            )*/
                              ),
                              /*validator: (input) {
                          if(input.isEmpty){
                            return 'Veuillez entrer un email';
                          }
                        },
                        onSaved: (input) {
                          _email = input;
                        },*/
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                ButtonTheme(
                  minWidth: 150,
                  shape: StadiumBorder(),
                  child: MaterialButton(
                    onPressed: resetPassword,
                    textColor: Colors.lightBlue,
                    color: Colors.white,
                    height: 50,
                    child: Text("Confirmer",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*@override
  Future<String> signIn(String email, String password) async {
    FirebaseUser user = await  _firebaseAuth.signInWithEmailAndPassword(email: email, password:password);
    if (user.isEmailVerified) return user.uid;
    return null;
  }*/

  @override
  Future<void> resetPassword() async {
    try{
      await _firebaseAuth.sendPasswordResetEmail(email: emailController.text);
      Toast.show('Consulter votre boîte email', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      Navigator.of(context).pushNamed('/login_with_firebase');
    }catch(e){
      switch(e.message){
        case 'Given String is empty or null':
          Toast.show('Veuillez remplir le champ', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          Toast.show('Erreur de connexion', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          break;
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          Toast.show('Email incorrect', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          break;
        default:
          Toast.show(e.message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      }
      //print(e.message);
      //Toast.show(e.message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
    }
  }

}