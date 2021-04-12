/*
class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() =>new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var email;
  var password;
  bool isValid=true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color(0XFF162b48),
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget> [
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: Text(
                          'Hello',
                          style: TextStyle(
                              fontSize: 80.0, fontWeight: FontWeight.bold )
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 175.0, 0.0, 0.0),
                      child: Text(
                          'There',
                          style: TextStyle(
                              fontSize: 80.0, fontWeight: FontWeight.bold )
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
                      child: Text(
                          '.',
                          style: TextStyle(
                              fontSize: 80.0, fontWeight: FontWeight.bold,color: Colors.green )
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      onChanged: (value){
                        setState(() {
                          email=value;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)
                          )
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      onChanged: (value){
                        setState(() {
                          password=value;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)
                          )
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      alignment: Alignment(1.0 ,0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      child: InkWell(
                        child: Text('Forgot Password',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              decoration: TextDecoration.underline
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 40.0),
              Container(
                height: 40.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  shadowColor: Colors.greenAccent,
                  color: Colors.green,
                  elevation: 7.0,
                  child: GestureDetector(
                    onTap: () async {
                      User user = FirebaseAuth.instance.currentUser;

                      if (!user.emailVerified) {
                        await user.sendEmailVerification();
                      }else {
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance.signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                        }

                        on FirebaseAuthException catch (e) {
                        setState(() {
                              isValid = false;
                            });
                          if (e.code == 'user-not-found') {

                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
                        isValid ? Navigator.push(
                            context, MaterialPageRoute(builder: (context) =>
                            home())) : print("not valid");
                        setState(() {
                          isValid = true;
                        });
                      }
                    },
                    child: Center(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'
                        ),
                      ),
                    ),
                  ),
                ),

              ),
              FlatButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>signup()));},
                padding: EdgeInsets.only(top: 15.0),
                child:Center(
                  child: Text(
                    'Dont have an account',

                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
*/


/*

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  var email ;
  var password;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          leading: Icon(Icons.arrow_back,color: Colors.black,),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Text(
            'Hi!',
            style: TextStyle(
              fontSize: 45.0,fontWeight: FontWeight.bold
            ),
          ),

           Padding(
             padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
             child: Text(
              'Create a new account',
              style: TextStyle(

                fontFamily: 'Montserrat',
              ),
          ),
           ),

        Padding(
          padding: const EdgeInsets.only(top: 60.0,bottom: 10.0,right: 10.0),
          child: TextField(
            onChanged: (value){
              setState(() {
                email=value;
              });
            },

            decoration: InputDecoration(
              labelText: 'ENTER EMAIL',
              labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.grey
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green)
              )
            ),
          ),
        ),

        SizedBox(height: 5.0),
        Padding(
          padding: const EdgeInsets.only(top: 10.0,bottom: 10.0,right: 10.0),
          child: TextField(
            onChanged: (value){
              setState(() {
                password= value;
              });
            },
            decoration: InputDecoration(
                labelText: 'ENTER PASSWORD',
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)
                )
            ),
          ),
        ),
        SizedBox(height: 40.0),
        Container(
          height: 40.0,
          child: Material(
            borderRadius: BorderRadius.circular(20.0),
            shadowColor: Colors.greenAccent,
            color: Colors.blue,
            elevation: 7.0,
            child: GestureDetector(
              onTap: () async {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Center(
                child: Text(
                  'SIGN UP',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'
                  ),
                ),
              ),
            ),
          ),

        ),

      ],
    ),
        ));
  }
}

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Text(
            'VAYO av',

          ),
        )
    );
  }
}*/
