import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'bloc/cardListBloc.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider (
      blocs: [
        Bloc((i)=>CartListBloc())

      ],
      child: MaterialApp(
        title: "Deli-very",
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold (
      body: SafeArea (
          child: Container (
            child: ListView(
              children: <Widget>[
                FirstPart(),
              ],
            ),
          )
      )
    );
  }
}

class FirstPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding (
      padding: EdgeInsets.fromLTRB(25, 25, 0, 0),
      child: Column(
        children: <Widget>[
          NewAppBar(),
          SizedBox(height: 30),
          title(),
          SizedBox(height: 30),
          searchBar(),
        ],
      ),
    );
  }
  Widget searchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(
          Icons.search,
          color: Colors.black,
        ),
        SizedBox(width: 20),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Address",
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        )
      ],
    );
  }
  // 16;30
  Widget title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 45),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Deli",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 30.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class NewAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.menu),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Text("0"),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(30)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//class AddressForm extends StatefulWidget {
//  AddressForm({Key key, this.title}) : super(key: key);
//
//  // This widget is the home page of your application. It is stateful, meaning
//  // that it has a State object (defined below) that contains fields that affect
//
//  // how it looks.
//
//  // This class is the configuration for the state. It holds the values (in this
//  // case the title) provided by the parent (in this case the App widget) and
//  // used by the build method of the State. Fields in a Widget subclass are
//  // always marked "final".
//  final String title;
//  @override
//  AddressFormState createState() => AddressFormState();
//}
//
//class AddressFormState extends State<AddressForm> {
//  final _addressformKey = GlobalKey<FormState>();
//
//  bool validateAndSave() {
//    final form = _addressformKey.currentState;
//    if (form.validate()) {
//      form.save();
//      setState(() {
//
//      });
//      return true;
//    }
//    return false;
//  }
//
//  String validate(String value) {
//    if(value.isEmpty){
//      return 'Field can\'t be empty';
//    }
//    if(value.contains(" ")){
//      return 'Field can\'t contain spaces';
//    }
//    return null;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // This method is rerun every time setState is called, for instance as done
//    // by the _incrementCounter method above.
//    //
//    // The Flutter framework has been optimized to make rerunning build methods
//    // fast, so that you can just rebuild anything that needs updating rather
//    // than having to individually change instances of widgets.
//    return Form(
//      key: _addressformKey,
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          TextFormField(
//            decoration: InputDecoration(
//              labelText: 'Address'
//            ),
//            validator: (value) {
//              if (value.isEmpty) {
//                return 'Please enter your address';
//              }
//              return null;
//            },
//          ),
//          Padding(
//            padding: const EdgeInsets.symmetric(vertical: 16.0),
//            child: RaisedButton(
//              onPressed: validateAndSubmit,
//              child: Text('Enter'),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//  void validateAndSubmit() async {
//    if (validateAndSave()) {
//      var snackBar = SnackBar(
//        content: Text("Processing"),
//      );
//    }
//  }
//}
//final applicationTitle = 'Deli Delivery';
//    return MaterialApp(
//      title: applicationTitle,
//      theme: ThemeData(
//        primarySwatch: Colors.blueGrey,
//      ),
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text(applicationTitle),
//        ),
//        body: AddressForm(),
//      )
//    );