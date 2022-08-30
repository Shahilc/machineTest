
import '../bloc/cartBlocdata.dart';
class ItemModel {
  ItemModel({
    this.id=0,
    this.name="",
    this.qty=0,
    this.price=0,
    this.total=0,
    this.calories=0,
    this.currency="",

  });

  int id;
  int qty;
  String name;
  double price;
  double total;
  double calories;
  String currency;

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
    id: json["id"],
    price: json['price'],
    qty: json['qty'],
    name: json['name'],
    total: json['total'],
    calories: json['calories'],
    currency: json['currency'],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "qty": qty,
    "name":name,
    "total":total,
    "calories":calories,
    "currency":currency,

  };
  addItem() async {
    List<ItemModel>items=await cartBloc.stream.first;
    print(items.map((e) => e.toJson()));
    int index=items.indexWhere((element) => element.id==id);
    print('INDEX');
    print(index);
    print('INDEX');

    if(index>=0){
      items[index].qty++;
      items[index].total=items[index].qty*items[index].price;
    }
    else {
      total=qty*price;
      items.add(this);
    }
    cartBloc.set(items);
  }
  addQty() async {
    List<ItemModel>items=await cartBloc.stream.first;
    int index=items.indexWhere((element) => element.id==id );
    if(index>=0){
      items[index].qty++;
      items[index].total=items[index].qty*items[index].price;
      cartBloc.set(items);
    }
  }
  subQty() async {
    List<ItemModel>items=await cartBloc.stream.first;
    int index=items.indexWhere((element) => element.id==id);
    if(index>=0){
      if(items[index].qty==1){
        items.removeAt(index);
      }else {
        items[index].qty--;
        items[index].total = items[index].qty * items[index].price;
      }
      cartBloc.set(items);
    }
  }
}