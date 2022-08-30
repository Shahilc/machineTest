import 'package:flutter/material.dart';
import 'package:machinetestapp/auth/googlesign.dart';

import 'homePage.dart';
import 'mobileno.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(200),
            decoration: BoxDecoration(
                image:DecorationImage(
                  image: AssetImage("images/firebase.webp"),
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25,right: 25,bottom: 10),
            child: InkWell(
              onTap: (){
                Googlesign().signInWithGoogle(context: context);
              },
              child: Container(
                padding: EdgeInsets.only(top: 15,bottom: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color:Color.fromARGB(255, 67, 134, 244)
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 30,
                        width: 30,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(image: AssetImage('images/google.jpg'))
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 30,
                        width: 30,
                        child: Center(child: Text('Google',style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.bold))),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 30,
                        width: 30,
                      ),
                    ),
                    //
                    // Text(''),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25,right: 25,bottom: 10),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MobileNumber(),));
              },
              child: Container(
                padding: EdgeInsets.only(top: 15,bottom: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(255, 95, 188, 84)
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 30,
                        width: 30,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child:  Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  color: Colors.white
                                ),
                                child: Icon(Icons.phone,color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 30,
                        width: 30,
                        child: Center(child: Text('Phone',style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.bold))),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 30,
                        width: 30,
                      ),
                    ),
                    //
                    // Text(''),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
