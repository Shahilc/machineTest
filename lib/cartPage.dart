import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machinetestapp/placeOrder.dart';
import 'package:machinetestapp/model/ItemModel.dart';
import 'package:machinetestapp/bloc/cartBlocdata.dart';


class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  ConnectionState connectionState = ConnectionState.done;
  double total1 = 0;
  bool isLoading = false;
  int itemtotal=0;
  Color buttonColor = const Color(0xFFEA4D5E);
  @override
  void initState() {
    print(connectionState);
    // TODO: implement initState
    super.initState();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message!),
          duration: const Duration(seconds: 1),
          backgroundColor: buttonColor),
    );
  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(

        appBar:AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.grey),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Order Summery',style: TextStyle(color: Colors.grey)), backgroundColor: Colors.white,),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<List<ItemModel>>(
                    stream: cartBloc.stream,
                    builder: (context, snapshot) {
                      total1 = snapshot.data?.fold(0, (previousValue, element) => previousValue! + (element.qty * (element.price))) ?? 0;
                      List<ItemModel>? items = snapshot.data ?? [];
                      itemtotal=items.fold(0, (t, element) => t+(element.qty));
                      return items.isNotEmpty
                          ? SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 10, right: 10),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(3),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2,
                                        right: 10,
                                        left: 10,
                                        bottom: 10),
                                    child: Column(

                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('${items.length} Dishes - ',style: TextStyle(fontSize: 18,color: Colors.white), ),
                                              Text('${itemtotal} Items' ,style: TextStyle(fontSize: 18,color: Colors.white)),
                                            ],
                                          ),
                                          decoration: BoxDecoration(color:Color.fromARGB(255, 27 , 63, 21),borderRadius: BorderRadius.circular(10)),
                                        ),
                                        SizedBox(height: 20,),
                                        ListView.builder(
                                            itemCount: items.length,
                                            shrinkWrap: true,
                                            physics:
                                            NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, i) {
                                              return
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 20),
                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Expanded(
                                                              child:
                                                              Container(
                                                                padding: const EdgeInsets.all(0.8),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 10),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Icon(Icons.circle, color: Colors.red,),
                                                                          SizedBox(width: 3,),
                                                                          Expanded(child: Text(items[i].name, style: const TextStyle(fontSize: 15),)),
                                                                        ],
                                                                      ),
                                                                      SizedBox(height: 10,),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(left: 27),
                                                                        child: Text('${items[i].currency}: ${(items[i].qty * items[i].price).toStringAsFixed(3)}', style: TextStyle(color: Colors.black,fontSize: 15),),
                                                                      ),
                                                                      SizedBox(height: 5,),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(left: 27),
                                                                        child: Text('${items[i].calories}  calories', style: TextStyle(color: Colors.black,fontSize: 15),),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )),
                                                          Expanded(
                                                              child:
                                                              Container(
                                                                padding: const EdgeInsets.all(0.8),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      width: w * .23,
                                                                      height: 25,
                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color:Color.fromARGB(255, 27 , 63, 21)),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.only(left: 5, right: 5),
                                                                        child:
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                          children: [
                                                                            InkWell(
                                                                                onTap: () {
                                                                                  items[i].subQty();
                                                                                },
                                                                                child: const SizedBox(
                                                                                    width: 20,
                                                                                    // color: Colors.red,
                                                                                    child: Center(
                                                                                        child: Text('-', style: TextStyle(color: Colors.white, fontSize: 20),)))),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 3, left: 3),
                                                                              child: Text('${items[i].qty}',style: TextStyle(color: Colors.white)),
                                                                            ),
                                                                            InkWell(
                                                                                onTap: () {
                                                                                  items[i].addQty();
                                                                                },
                                                                                child: const SizedBox(
                                                                                    width: 20,
                                                                                    // color: Colors.red,
                                                                                    child: Center(
                                                                                        child: Text('+', style: TextStyle(color: Colors.white, fontSize: 15),)))),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '${items[i].currency}: ${(items[i].qty * items[i].price).toStringAsFixed(3)}',
                                                                      style: TextStyle(color: Colors.black,fontSize: 15,),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ))
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(top: 10),
                                                        child: Column(
                                                          children: [
                                                            Padding(padding: const EdgeInsets.only(top: 3),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  SizedBox(),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(top: 6),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const SizedBox(),
                                                          ],
                                                        ),
                                                      ),
                                                      const Divider(
                                                          thickness: 1,
                                                          color:
                                                          Colors.grey),
                                                    ],
                                                  ),
                                                );
                                            }),
                                      ],
                                    ),
                                  )),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(3),
                                    color: Colors.white),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Padding(padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Total Amount", style: const TextStyle(fontSize: 18),),
                                          Text('${"INR"} ${(total1).toStringAsFixed(3)}',style: TextStyle(color: Colors.green,fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Padding(padding: EdgeInsets.only(top: 10),
                                      child: Divider(thickness: 1, color: Colors.grey,),),

                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                          ],
                        ),
                      )
                          : Center(child: Text("cart_is_empty"));
                    }),
              )
            ],
          ),
        ),
      bottomNavigationBar: StreamBuilder<List<ItemModel>>(
        stream: cartBloc.stream,
        builder: (context, snapshot) {
          List<ItemModel>? items = snapshot.data ?? [];
          return items.isNotEmpty?Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                cartBloc.clear();
                Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPlace(),));
              },
              child: Container(
                height: 40,
                child: Center(child: Text('Place Order',style: TextStyle(color: Colors.white,fontSize: 20),)),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:Color.fromARGB(255, 27 , 63, 21),),
              ),
            ),
          )
          :Text('');
        }
      ),
    );
  }
}
