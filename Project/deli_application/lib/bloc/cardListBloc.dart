import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:deliapplication/bloc/provider.dart';
import 'package:deliapplication/model/deliitem.dart';
import 'package:rxdart/rxdart.dart';

class CartListBloc extends BlocBase{
  // ignore: non_constant_identifier_names
  CartListBloc();

  var _listController = BehaviorSubject<List<DeliItem>>.seeded([]);

  CartProvider provider = CartProvider();

  Stream<List<DeliItem>> get listStream => _listController.stream;

  Sink<List<DeliItem>> get listSink => _listController.sink;

  addToList(DeliItem deliItem) {
    listSink.add(provider.addToList(deliItem));
  }
  removeFromList(DeliItem deliItem) {
    listSink.add(provider.removeFromList(deliItem));
  }  @override
  void dispose() {
    _listController.close();
    super.dispose();
  }
}
