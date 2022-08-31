import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machinetestapp/model/ItemModel.dart';
import 'package:machinetestapp/services/api.dart';
import 'package:machinetestapp/bloc/cartBlocdata.dart';
import 'package:machinetestapp/model/getDataModel.dart';

import 'cartPage.dart';
import 'loginPage.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ItemList? itemData;
  bool laoding=false;
  List<CategoryDishes> firstList=[];
  bool isLoading=false;
  List Datum=[];
  var colorId;
  String userId='';
  String userName='';
  String phoneno='';
  int selectedIndex=0;
  
  @override
  void initState() {
    User? user=FirebaseAuth.instance.currentUser;
    userName=user?.displayName??"No Name";
    phoneno=user?.phoneNumber??"No Number";
    print('------------colorId-----------------');
    print(colorId);
    print('-------------colorId----------------');
    getdata(colorId);
    // TODO: implement initState
    super.initState();
  }
  void getdata(colorId)async{
    setState(() {
      isLoading=true;
    });
    // firstList=[];
    APIService apiService = APIService();
    await apiService.getData().then((value){
      itemData=ItemList.fromJson(value[0]);
      if(colorId==null){
        print('open if condition');
        setState(() {
          colorId=itemData?.tableMenuList[0].menuCategoryId;
        });
        print('close if condition');
        print(colorId);
        print('close if condition');
      }
      int length=itemData?.tableMenuList.length??0;
      String id=colorId;
      print('77777777');
      print(colorId);
      print(id);
      print('77777777');
      for (int i=0;i<length;i++){
        if(itemData?.tableMenuList[i].menuCategoryId=='${id}'){
          firstList=itemData?.tableMenuList[i].categoryDishes.toList()??[];
        }
      }
      setState(() {
        isLoading=false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
       child: Column(
         children: [
           Container(
             decoration: BoxDecoration(
                 color: Colors.green,
                 gradient: LinearGradient(
                   colors: [Colors.green, Colors.greenAccent],
                   begin: Alignment.bottomLeft,
                   end: Alignment.topRight,
                 ),
                 borderRadius: BorderRadius.vertical(bottom: Radius.circular(18))),
             padding: EdgeInsets.all(10),
             child: Padding(
               padding: const EdgeInsets.only(top: 30,bottom: 10),
               child: Column(
                 children: [
                   Container(
                     padding: EdgeInsets.all(30),
                     decoration: BoxDecoration(
                       border: Border.all(color: Colors.black),
                       shape: BoxShape.circle,
                       image: DecorationImage(
                         image: AssetImage('images/dummy-image.jpg')
                       )
                     ),
                   ),
                   SizedBox(height: 10,),
                   userName=="No Name"?Text('${phoneno}',style: TextStyle(color: Colors.white,fontSize: 18))
                   :
                   Text('${userName}',style: TextStyle(color: Colors.white,fontSize: 18))
                   ,
                   SizedBox(height: 10,),
                   Text('ID 410',style: TextStyle(color: Colors.white,fontSize: 18)),
                 ],
               ),
             ),
           ),
           SizedBox(height: 20,),
           Padding(
             padding: const EdgeInsets.only(left: 15,),
             child: InkWell(
               onTap: (){
                 cartBloc.clear();
                 FirebaseAuth.instance.signOut();
                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage(),), (route) => false);
               },
               child: Row(
                 children: [
                   Icon(Icons.login,color: Colors.grey),
                   SizedBox(width: 20,),
                   Text('Log out',style: TextStyle(color: Colors.grey,fontSize: 18)),
                 ],
               ),
             ),
           )
         ],
       ),
      ),
      backgroundColor: Colors.white,
      appBar:AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Builder(
            builder: (context) {
              return IconButton(
                onPressed: (){
                  Scaffold.of(context).openDrawer();
                },
                icon:Icon(Icons.menu,color: Colors.grey),
              );
            }
        ),
        actions:  [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(),));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<List<ItemModel>>(
                stream: cartBloc.stream,
                builder: (context, snapshot) {
                  List<ItemModel>? items = snapshot.data ?? [];
                  return Container(
                    width: 40,
                    height: 50,
                    // color: Colors.red,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.add_shopping_cart,color: Colors.grey),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(''),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                                child: Center(child: Text('${items.length}',style: TextStyle(fontSize: 15,color: Colors.white),))),
                          ],
                        ),
                      ],
                    )
                  );
                }
              )
            ),
          )
        ],
      ),
      body:isLoading==false?Column(
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
            child: ListView.builder(
              itemCount: itemData?.tableMenuList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder:(context, index) {
              return
                    InkWell(
                      onTap: (){
                        print(itemData?.tableMenuList[index].menuCategory);
                        print(itemData?.tableMenuList[index].menuCategoryId);
                        setState(() {
                          colorId=itemData?.tableMenuList[index].menuCategoryId;
                          selectedIndex=index;
                        });
                        getdata(colorId);
                      },
                      child: Container(
                        height: 35,
                        // color: Colors.grey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${itemData?.tableMenuList[index].menuCategory}',style: TextStyle(color: selectedIndex==index?Colors.red:Colors.black)),
                            Container(color: selectedIndex==index?Colors.red:Colors.white,height: 3,width: 150,)
                          ],
                        ),

                      ),
                    );

            },),
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  child: Column(
                    children: firstList.map((e) {
                      return
                        Column(
                          children: [
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.circle,color: Colors.red),
                                              SizedBox(width: 2,),
                                              Expanded(child: Text('${e.dishName}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),)),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 27),
                                                      child: Text('${e.dishCurrency} ',style: TextStyle(fontWeight: FontWeight.bold)),
                                                    ),
                                                    Text('${e.dishPrice}',style: TextStyle(fontWeight: FontWeight.bold)),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text('${e.dishCalories} ',style: TextStyle(fontWeight: FontWeight.bold)),
                                                    Text('calories',style: TextStyle(fontWeight: FontWeight.bold)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 27),
                                              child: Row(
                                                children: [
                                                  Expanded(child: Text('${e.dishDescription} ',style: TextStyle(color: Colors.grey,fontSize: 14))),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(top: 10,left: 27),
                                          //   child: Row(
                                          //     children: [
                                          //       Container(
                                          //         width: 100,
                                          //         height: 30,
                                          //         decoration: BoxDecoration(
                                          //             color: Colors.green,
                                          //             borderRadius: BorderRadius.circular(15)
                                          //         ),
                                          //         child: Row(
                                          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //           children: [
                                          //             SizedBox(width: 3,),
                                          //             Container(
                                          //                 child: Center(child: Text('-',style:  TextStyle(color: Colors.white,fontSize: 20)))),
                                          //             SizedBox(width: 3,),
                                          //             Text('0',style: TextStyle(color: Colors.white,fontSize: 18)),
                                          //             SizedBox(width: 3,),
                                          //             Text('+',style: TextStyle(color: Colors.white,fontSize: 20)),
                                          //             SizedBox(width: 3,),
                                          //           ],
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10,left: 27),
                                            child: StreamBuilder<List<ItemModel>>(
                                                stream: cartBloc.stream,
                                                builder: (context, snapshot) {List<ItemModel>
                                                cartList = snapshot.data ?? [];
                                                int index = cartList.indexWhere((element) => element.id == int.parse(e.dishId??'0'));
                                                int qty = 0;
                                                if (index >= 0) {
                                                  qty = cartList.where((element) => element.id == int.parse(e.dishId??'0')).fold(0, (t, element) => t + element.qty);
                                                }
                                                return Row(
                                                  children: [
                                                    Container( height: 30,
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.green),
                                                        child: Padding(padding: const EdgeInsets.only(left: 15, right: 15),
                                                          child:
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  cartList[index].subQty();
                                                                },
                                                                child: const SizedBox(
                                                                    height: 20,
                                                                    width: 20,
                                                                    child: Center(
                                                                      child: Text('-', style: TextStyle(color: Colors.white)),
                                                                    )),
                                                              ),
                                                              SizedBox(width: 15,),
                                                              Text('${qty}', style: const TextStyle(color: Colors.white)),
                                                              // Text('${e.qty}', style: const TextStyle(color: Colors.white)),
                                                              SizedBox(width: 15,),
                                                              InkWell(
                                                                onTap: () async {
                                                                  setState(() {
                                                                    laoding = true;
                                                                  });
                                                                  ItemModel itemModel = ItemModel(
                                                                    // id: 100000001,
                                                                    id: int.parse(e.dishId.toString()),
                                                                    name: e.dishName.toString(),
                                                                    qty: 1,
                                                                    price: double.parse(e.dishPrice.toString()),
                                                                    calories: e.dishCalories??0.0,
                                                                    currency: e.dishCurrency.toString(),
                                                                  );

                                                                  itemModel.addItem();

                                                                },
                                                                child: const SizedBox(
                                                                    height: 20,
                                                                    width: 20,
                                                                    child: Center(
                                                                      child: Text('+', style: TextStyle(color: Colors.white)),
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        )),
                                                  ],
                                                );
                                                }),
                                          ),
                                          e.addonCat?.length!=0? Padding(
                                            padding: const EdgeInsets.only(top: 10,left: 27),
                                            child: Text('Customization Availble',style: TextStyle(color: Colors.red)),
                                          ):Text(''),
                                          SizedBox(height: 10,)
                                        ],
                                      ),
                                      // color: Colors.red,
                                    )),
                                Expanded(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 90,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage('images/food.jpg')
                                            )
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 50,)
                                  ],
                                )),
                              ],
                            ),
                            Container(height: 1,color: Colors.grey,)
                          ],
                        );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // Expanded(
          //   child: Container(
          //     child: ListView.builder(
          //       itemCount: itemData?.tableMenuList.length,
          //       itemBuilder: (context, index) {
          //         return
          //           Container(
          //             // color: Colors.yellow,
          //             child: Column(
          //               children: [
          //                 Row(
          //                   children: [
          //                     Expanded(
          //                         flex: 3,
          //                         child: Container(
          //                           padding: EdgeInsets.all(10),
          //                           child: Column(
          //                             crossAxisAlignment: CrossAxisAlignment.stretch,
          //                             children: [
          //                               Row(
          //                                 children: [
          //                                   Icon(Icons.circle,color: Colors.red),
          //                                   SizedBox(width: 2,),
          //                                   Expanded(child: Text('${itemData?.tableMenuList[0].categoryDishes[index].dishName}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),)),
          //                                 ],
          //                               ),
          //                               Padding(
          //                                 padding: const EdgeInsets.only(top: 10),
          //                                 child: Row(
          //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                                   children: [
          //                                     Row(
          //                                       children: [
          //                                         Padding(
          //                                           padding: const EdgeInsets.only(left: 27),
          //                                           child: Text('${itemData?.tableMenuList[0].categoryDishes[index].dishCurrency} ',style: TextStyle(fontWeight: FontWeight.bold)),
          //                                         ),
          //                                         Text('${itemData?.tableMenuList[0].categoryDishes[index].dishPrice}',style: TextStyle(fontWeight: FontWeight.bold)),
          //                                       ],
          //                                     ),
          //                                     Row(
          //                                       children: [
          //                                         Text('${itemData?.tableMenuList[0].categoryDishes[index].dishCalories} ',style: TextStyle(fontWeight: FontWeight.bold)),
          //                                         Text('calories',style: TextStyle(fontWeight: FontWeight.bold)),
          //                                       ],
          //                                     ),
          //                                   ],
          //                                 ),
          //                               ),
          //                               Padding(
          //                                 padding: const EdgeInsets.only(top: 10),
          //                                 child: Padding(
          //                                   padding: const EdgeInsets.only(left: 27),
          //                                   child: Row(
          //                                     children: [
          //                                       Expanded(child: Text('${itemData?.tableMenuList[0].categoryDishes[index].dishDescription} ',style: TextStyle(color: Colors.grey,fontSize: 14))),
          //                                     ],
          //                                   ),
          //                                 ),
          //                               ),
          //                               Padding(
          //                                 padding: const EdgeInsets.only(top: 10,left: 27),
          //                                 child: Row(
          //                                   children: [
          //                                     Container(
          //                                       width: 100,
          //                                       height: 30,
          //                                       decoration: BoxDecoration(
          //                                           color: Colors.green,
          //                                           borderRadius: BorderRadius.circular(15)
          //                                       ),
          //                                       child: Row(
          //                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                                         children: [
          //                                           SizedBox(width: 3,),
          //                                           Container(
          //                                               child: Center(child: Text('-',style:  TextStyle(color: Colors.white,fontSize: 20)))),
          //                                           SizedBox(width: 3,),
          //                                           Text('0',style: TextStyle(color: Colors.white,fontSize: 18)),
          //                                           SizedBox(width: 3,),
          //                                           Text('+',style: TextStyle(color: Colors.white,fontSize: 20)),
          //                                           SizedBox(width: 3,),
          //                                         ],
          //                                       ),
          //                                     ),
          //                                   ],
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                           // color: Colors.red,
          //                         )),
          //                     Expanded(child: Column(
          //                       mainAxisAlignment: MainAxisAlignment.start,
          //                       children: [
          //                         Padding(
          //                           padding: const EdgeInsets.all(8.0),
          //                           child: Container(
          //                             height: 90,
          //                             decoration: BoxDecoration(
          //                               image: DecorationImage(
          //                                 image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzQpKCzAfzDuT5vSPY4UFS6hRy28_gXlqkCYFIdgmDDAjBa2kDRyyc2MzllcDIbDW8xBs&usqp=CAU')
          //                               )
          //                             ),
          //                           ),
          //                         ),
          //                         SizedBox(height: 50,)
          //                       ],
          //                     )),
          //                   ],
          //                 ),
          //                 Container(height: 1,color: Colors.grey,)
          //               ],
          //             ),
          //           );
          //       },
          //
          //     ),
          //   ),
          // ),




          // Expanded(
          //   child: Container(
          //     child: ListView.builder(
          //       itemCount: firstList.length,
          //       itemBuilder: (context, index) {
          //         return
          //           Container(
          //             child: Text('${firstList[index].menuCategory}'),
          //           );
          //       },),
          //   ),
          // )
        ],
      )
      :
      Center(child: CircularProgressIndicator(color: Colors.green)),

    );
  }
}
