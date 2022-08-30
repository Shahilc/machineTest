import 'package:flutter/material.dart';
class ItemViewPage extends StatefulWidget {
  const ItemViewPage({Key? key}) : super(key: key);

  @override
  _ItemViewPageState createState() => _ItemViewPageState();
}

class _ItemViewPageState extends State<ItemViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(Icons.menu,color: Colors.grey),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.card_travel,color: Colors.grey,),
          )
        ],
      ),
      body:Column(
        children: [
         Container(
           height: 30,
           decoration: BoxDecoration(
             color: Colors.white,
               boxShadow:[
                 BoxShadow(
                   offset: Offset(2, 0),
                   blurRadius: 1,
                   color: Colors.grey,
                 )
               ]
           ),
           child: ListView(
             scrollDirection: Axis.horizontal,
             children: [
                Container(
                  height: 35,
                  // color: Colors.grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('1513513165611165'),
                      Container(color: Colors.red,height: 3,width: 150,)
                    ],
                  ),

                ),
               Container(
                 height: 35,
                 // color: Colors.grey,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text('1513513165611165'),
                     Container(color: Colors.red,height: 3,width: 150,)
                   ],
                 ),

               ),
               Container(
                 height: 35,
                 // color: Colors.grey,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text('1513513165611165'),
                     Container(color: Colors.red,height: 3,width: 150,)
                   ],
                 ),

               ),
             ],
           ),
         )
        ],
      ) ,
    );
  }
}
