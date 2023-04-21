import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth.dart';
import 'news_page.dart';
class LogIN extends StatefulWidget {
   LogIN({Key? key}) : super(key: key);
  @override
  State<LogIN> createState() => _LogINState();
}
bool _loading =false;
// final _formKey=GlobalKey<FormState>();

final TextEditingController _controllerEmail=TextEditingController();
final TextEditingController _controllerPassword=TextEditingController();
class _LogINState extends State<LogIN> {
  Map<String,dynamic>? _userdata;
  void initState(){
    super.initState();
    FacebookAuth.instance.logOut();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        padding: EdgeInsets.fromLTRB(35, 15, 35, 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SignIn into your',style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),),
            Text('Account',style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Text('Email',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
            SizedBox(height: 1,),
            TextFormField(
              controller: _controllerEmail,
              validator: (val){
                if(val==null){
                  return 'Please enter your email';
                }return null;
              },
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.email,color: Colors.red,),
                border: UnderlineInputBorder(),
                hintText: 'johndeo@gmail.com',
                  hintStyle: TextStyle(color: Colors.grey)
              ),
            ),
            SizedBox(height: 20,),
            Text('Password',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
            SizedBox(height: 1,),
            TextFormField(
              obscureText: true,
              controller: _controllerPassword,
              validator: (val){
                if(val==null){
                  return 'Please enter your password';
                }return null;
              },
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.lock_outlined,color: Colors.red,),
                border: UnderlineInputBorder(),
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.grey)
              ),
            ),
            SizedBox(height: 5,),
            SizedBox(width: 170,),
            Container(
                alignment: Alignment.centerRight,
                child: Text("Forgot Password ?",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),)),
            SizedBox(height: 20,),
            Container(
                alignment: Alignment.center,
                child: Text("Login with")
            ),
            SizedBox(height: 25,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: ()=>signInWithGoogle(),
                    child: Container(
                      padding: EdgeInsets.all(0),
                      height: 35,
                      width: 35,
                        decoration: BoxDecoration(
                          border: Border.all(
                            // width: 2,
                          ),
                        ),
                        child: Image.asset("assets/images/google.png",fit: BoxFit.cover,)),
                  ),
                  SizedBox(width: 35,),
                  GestureDetector(
                    onTap: ()=>signInWithFacebook(),
                    child: Container(
                        padding: EdgeInsets.all(0),
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          border: Border.all(
                            // width: 2,
                          ),
                        ),
                        child: Image.asset("assets/images/facebook.png",fit: BoxFit.cover,)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an Account?"),
                SizedBox(width: 5,),
                Text("Register Now",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),)
              ],)
          ],
        ),
      ),
    );
  }
  signInWithGoogle() async{
    GoogleSignInAccount? googleUser=await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleauth = await googleUser?.authentication;
    AuthCredential cred=GoogleAuthProvider.credential(
      accessToken: googleauth?.accessToken,
      idToken:googleauth?.idToken
    );
    UserCredential usercred= await FirebaseAuth.instance.signInWithCredential(cred);
    print(usercred.user?.displayName);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsPage()));
  }
  Future <UserCredential>signInWithFacebook() async{
    final LoginResult res=await FacebookAuth.instance.login(permissions: ['email']);
    if(res==LoginStatus.success){
      final userData=await FacebookAuth.instance.getUserData();
      _userdata=userData;
    }else{
      print(res.message);
    }
    setState((){
    });
    final OAuthCredential oAuth=FacebookAuthProvider.credential(res.accessToken!.token);
    return FirebaseAuth.instance.signInWithCredential(oAuth);
  }
  signoutfacebook(){
    FacebookAuth.instance.logOut();
  }
}
class LogInButton extends StatelessWidget {
  const LogInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: TextButton(
            style:  ElevatedButton.styleFrom(
              primary: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
              ),
            ),
            onPressed:(){
              _loading=true;
                FirebaseAuth.instance.signInWithEmailAndPassword(email: _controllerEmail.text,
                    password: _controllerPassword.text).then((value) {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsPage()));
                }).onError((error, stackTrace) {
                  print("Error ${error.toString()}");
                });
            },
            child:Text('LOGIN',style: TextStyle(fontSize: 15,color: Colors.black),)
        ),
      ),
    );
  }
}

