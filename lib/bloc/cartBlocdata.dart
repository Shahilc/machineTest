
import 'package:machinetestapp/model/ItemModel.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc{
  BehaviorSubject<List<ItemModel>>subject= BehaviorSubject.seeded( []);
  BehaviorSubject<int>subjectLength= BehaviorSubject<int>.seeded(0);

  CartBloc(){
    subject=BehaviorSubject<List<ItemModel>>.seeded([] );
    subjectLength=BehaviorSubject<int>.seeded(0);
  }
  Stream<List<ItemModel>> get stream=>subject.stream;
  Stream<int> get streamLength=>subjectLength.stream;

  void set(List<ItemModel> listItem){
    subject.sink.add(listItem);
  }
  void clear(){
    subject.sink.add([]);
    subjectLength.sink.add(0);
  }
  void dispose(){
    subject.close();
  }

}
CartBloc cartBloc=new CartBloc();