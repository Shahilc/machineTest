import 'package:flutter/material.dart';

import 'auth/phoneauth.dart';
class MobileNumber extends StatefulWidget {
  const MobileNumber({Key? key}) : super(key: key);

  @override
  _MobileNumberState createState() => _MobileNumberState();
}

class _MobileNumberState extends State<MobileNumber> {
 TextEditingController mobileno=TextEditingController();
 var countryCodeController = TextEditingController(text: "+91");
 PhoneAuthServices _phoneAuthServices = PhoneAuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Container(
              padding: EdgeInsets.all(100),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/mobilenumber.png")
                )
              ),
            ),
            SizedBox(height: 40,),
            Text('Enter your mobile number',style: TextStyle(
              color: Colors.grey,fontSize: 18
            ),),
            SizedBox(height: 10,),
            Text('We will send you a one time sms message',style: TextStyle(
                color: Colors.grey,fontSize: 13
            ),),
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.only(left: 10,top: 2,bottom: 2,right: 10),
              child: TextField(
               controller: mobileno,
                maxLength: 10,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixText: '+91  ',
                  labelText: 'Mobile Number',

                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (){
            if(mobileno.text.length==10){
              String number = "${countryCodeController.text}${mobileno.text}";
              _phoneAuthServices.verifyPhoneNumber(context, number);
            }else{
              final snackBar=SnackBar(
                backgroundColor: Colors.red,
                content: Text('Enter valid mobile no'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: Container(
            child: Center(child: Text('Next',style: TextStyle(color: Colors.white,fontSize: 20),)),
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
