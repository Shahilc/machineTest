import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'homePage.dart';
class OtpPage extends StatefulWidget {
  final String number, verificationId;


  const OtpPage({Key? key, required this.number, required this.verificationId}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  bool isLoading=false;
  String otp='';
  @override
  Widget build(BuildContext context) {
    Future<void> verifyPhoneNumber(BuildContext context, String otp) async {
      FirebaseAuth auth = FirebaseAuth.instance;
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: widget.verificationId, smsCode: otp);
        //Need to otp validate or not
        final User? user = (await auth.signInWithCredential(credential)).user;
        print('dsfdfdfggfdshgfdh');
        print(user?.displayName);
        print('dsfdfdfggfdshgfdh');

        if (user != null) {
          // ignore: use_build_context_synchronously
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
        } else {
        }
      } catch (e) {
        final snackBar=SnackBar(
          backgroundColor: Colors.red,
          content: Text('Enter valid OTP'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),),
      body: Column(
        children: [
          SizedBox(height: 40,),
          Text(
            "Enter Your OTP",
            style: TextStyle(fontSize: 20,color: Colors.grey),
          ),
          Container(
            padding: EdgeInsets.all(100),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/OPTPlus.webp")
                )
            ),
          ),
          Text(
            "We sent a 6-digit code to",
            style: TextStyle(fontSize: 15,color: Colors.grey),
          ),
          Text(
            widget.number,
            style: TextStyle(fontSize: 15,color: Colors.grey),
          ),
          SizedBox(height: 30,),
          OtpTextField(
            numberOfFields: 6,
            borderColor: Color(0xFF512DA8),
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: (String code) {
              //handle validation or checks here
            },
            //runs when every textfield is filled
            onSubmit: (String verificationCode){
              print(verificationCode);
              setState(() {
                otp=verificationCode;
              });
              verifyPhoneNumber(context,otp);
            }, // end onSubmit
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (){
            verifyPhoneNumber(context,otp);
          },
          child: Container(
            child: Center(child: Text('Continue',style: TextStyle(color: Colors.white,fontSize: 20),)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:Color.fromARGB(255, 27 , 63, 21),
            ),
            height: 50,

          ),
        ),
      ),
    );
  }
}
