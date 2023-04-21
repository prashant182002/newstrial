import 'package:flutter/material.dart';
import 'package:untitled/news_page.dart';
import 'main.dart';
import 'lists.dart';
import 'package:firebase_auth/firebase_auth.dart';
final TextEditingController _controllerEmail=TextEditingController();
final TextEditingController _controllerPassword=TextEditingController();
class SignUp extends StatelessWidget {
  String dropDownVal='IND';
  bool checkedVal=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(35, 15, 35, 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Create an',style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),),
          Text('Account',style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
          Text('Name',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
          SizedBox(height: 1,),
          TextFormField(
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.person,color: Colors.red,),
              border: UnderlineInputBorder(),
              hintText: 'John deo',
                hintStyle: TextStyle(color: Colors.grey)
            ),
          ),
          SizedBox(height: 20,),
          Text('Email',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
          SizedBox(height: 1,),
          TextFormField(
            controller: _controllerEmail,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.email,color: Colors.red,),
              border: UnderlineInputBorder(),
              hintText: 'johndoe@gmail.com',
                hintStyle: TextStyle(color: Colors.grey)
            ),
          ),
          SizedBox(height: 20,),
          Text('Contact no',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
          Row(
            children: [
              Container(
                height: 50.0,
                width: 120.0,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    value: dropDownVal,
                    items: dropdownItems,
                    onChanged: (Object? value) {  },
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Container(
                width: 160,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.phone,color: Colors.red,),
                    border: UnderlineInputBorder(),
                    hintText: '9876543210',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintStyle: TextStyle(color: Colors.grey)
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Text('Password',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
          SizedBox(height: 1,),
          TextFormField(
            controller: _controllerPassword,
            obscureText: true,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.lock_outlined,color: Colors.red,),
              border: UnderlineInputBorder(),
              hintText: '*********',
              hintStyle: TextStyle(color: Colors.grey)
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkk(),
              SizedBox(width: 20,),
              Text("I agree with "),
              Container(
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(
                      color: Colors.red,
                      width: 2, // This would be the width of the underline
                    ))
                ),
                child: Text("term & condition",style: TextStyle(
                    fontWeight: FontWeight.bold,color: Colors.red),),
              )
            ],),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an Account?",style: TextStyle(fontSize: 11,color: Colors.grey),),
              SizedBox(width: 5,),
              Text("Sign In!",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),)
            ],)
        ],
      ),
    );
  }
}

class Checkk extends StatefulWidget {
  const Checkk({
    Key? key,
  }) : super(key: key);
  @override
  State<Checkk> createState() => _CheckkState();
}

class _CheckkState extends State<Checkk> {
  @override
  bool checkedVal=false;
  Widget build(BuildContext context) {
    return Checkbox(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1.0),
        ),
        side: MaterialStateBorderSide.resolveWith(
              (states) => BorderSide(width: 2.0, color: Colors.red),
        ),
        activeColor: Colors.white,
        checkColor: Colors.red,
        focusColor: Colors.red,
        value: checkedVal,
        onChanged: (newValue) {
          setState(() {
            checkedVal = newValue!;
          });
        }
    );
  }
}
class SignUpButton extends StatelessWidget {
  const SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
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
              onPressed: () {
                FirebaseAuth.instance.createUserWithEmailAndPassword(email: _controllerEmail.text, 
                    password: _controllerPassword.text).then((value) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsPage()));
                }).onError((error, stackTrace) { print("Error ${error.toString()}");});
              },
              child: Text("SIGNUP",style: TextStyle(fontSize: 15,color: Colors.black),)
          ),
        ),
      ),
    );
  }
}
