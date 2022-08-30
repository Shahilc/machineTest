import 'package:flutter/material.dart';

import 'itemviewpage.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
               image: NetworkImage("https://cdn.dribbble.com/users/528264/screenshots/3140440/firebase_logo.png"),
             )
           ),
         ),
         Padding(
           padding: const EdgeInsets.only(left: 25,right: 25,bottom: 10),
           child: InkWell(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => ItemViewPage(),));
             },
             child: Container(
               padding: EdgeInsets.only(top: 15,bottom: 15),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(30),
                 color: Colors.blue
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
                              width: 20,
                              height: 20,
                              color: Colors.black,
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
               Navigator.push(context, MaterialPageRoute(builder: (context) => ItemViewPage(),));
             },
             child: Container(
               padding: EdgeInsets.only(top: 15,bottom: 15),
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(30),
                   color: Colors.blue
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
                               width: 20,
                               height: 20,
                               color: Colors.black,
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
