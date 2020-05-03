import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class CounterBloc extends BlocBase{

  Observable<int> counter; // observable (Stream)

  CounterBloc() {
    counter = Observable.merge([ //merges the both streams
      _increment,
      _decrement,
    ]).startWith(0) //starts with the value 0(the initial data)
        .scan((acc, curr, i) => acc + curr, 0 /* inital value: 0 */) // scans the old(acc) and the current(curr) value, and sum them
        .asBroadcastStream(); //turns the stream into a Broadcast straem(it can be listened to more than once)
  }

  final _increment = new BehaviorSubject<int>(); //the BehaviorSubject gets the last value
  final _decrement = new BehaviorSubject<int>();

  void increment() => _increment.add(1); //method to increment
  void decrement() => _decrement.add(-1);//method to decrement


  @override
  void dispose() {// will be called automatically
    _increment.close();
    _decrement.close();
  }

}