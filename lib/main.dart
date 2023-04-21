import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'news_page.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Color logincolor=Colors.red;
  Color loginTextColor=Colors.white;
  Color signcolor=Colors.white;
  Color signUpTextColor=Colors.grey[500]!;
  Widget button=LogInButton();
  Widget wid= LogIN();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), //
        child: AppBar(
          elevation: 0,
          title: Row(
            children: [
              SizedBox(width: 12,),
              Text('Social'),
              SizedBox(width: 2,),
              Text('X',style: TextStyle(fontSize: 30),),
            ],
          ),
          backgroundColor: Colors.red,
        ),
      ),
      body: Center(
        child: Container(
          color: Colors.grey[400],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
             Container(
               alignment: Alignment.topCenter,
               decoration: BoxDecoration(
                 color: Colors.white,
                 border: Border.all(
                   color: Colors.red,
                 ),
                 borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
               ),
               padding: EdgeInsets.all(0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Expanded(
                     child: SizedBox(
                       height: 50,
                       child: TextButton(
                         style:  ElevatedButton.styleFrom(
                           primary: logincolor,
                             shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.only(
                                   bottomLeft: Radius.circular(19),
                                   bottomRight: Radius.circular(19),
                                 )
                             ),
                             ),
                           onPressed: () {
                              setState((){
                                //change login color
                                logincolor=Colors.red;
                                loginTextColor=Colors.white;
                                //change signup color
                                signcolor=Colors.white;
                                signUpTextColor=Colors.grey[500]!;
                                //change login to register
                                button=LogInButton();
                                //change middle widget
                                wid=LogIN();
                              });
                           },
                           child: Text("LOGIN",style: TextStyle(fontSize: 15,color: loginTextColor),)
                       ),
                     ),
                   ),
                   Expanded(
                     child: SizedBox(
                       height: 50,
                       child: TextButton(
                           style:  ElevatedButton.styleFrom(
                             primary: signcolor,
                             shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.only(
                                   bottomLeft: Radius.circular(19),
                                   bottomRight: Radius.circular(19),
                                 )
                             ),
                           ),
                           onPressed: () {
                             setState((){
                               //change login color
                               logincolor=Colors.white;
                               loginTextColor=Colors.grey[500]!;
                               //change signup color
                               signcolor=Colors.red;
                               signUpTextColor=Colors.white;
                               //change login to register
                               button=SignUpButton();
                               //change middle widget
                               wid=SignUp();
                             });
                           },
                           child: Text("SIGN UP",style: TextStyle(fontSize: 15,color: signUpTextColor),)
                       ),
                     ),
                   ),
                 ],
               ),
             ),
              SizedBox(height: 10,),
              Expanded(
                child: wid
              ),
              button,
            ],
          ),
        ),
      ),
    );
  }
}
