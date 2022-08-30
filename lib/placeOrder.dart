import 'package:flutter/material.dart';

import 'homePage.dart';
class OrderPlace extends StatefulWidget {
  const OrderPlace({Key? key}) : super(key: key);

  @override
  _OrderPlaceState createState() => _OrderPlaceState();
}

class _OrderPlaceState extends State<OrderPlace> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 1),() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Container(
             padding: EdgeInsets.all(50),
             decoration: BoxDecoration(
               image: DecorationImage(
                 image: AssetImage('images/success.png')
               )
             ),
           ),
            SizedBox(height: 30,),
            Text('Oder Placed Successfully',style: TextStyle(color: Colors.green,fontSize: 20,fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
