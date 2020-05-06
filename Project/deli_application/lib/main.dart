import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'bloc/cardListBloc.dart';
import 'model/deli_item.dart';
import 'package:deliapplication/bloc/shoppingCartListColorTheme.dart';
import 'package:deliapplication/shoppingcart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider (
      blocs: [
        Bloc((i)=>CartListBloc()),
        Bloc((i) =>ColorBloc()),
      ],
      child: MaterialApp(
        // main app title
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
    return Scaffold (
      body: SafeArea (
          child: Container (
            child: ListView(
              children: <Widget>[
                FirstPart(),
                SizedBox(height: 45),
                for (var deliItem in deliitemList.deliItems)
                  Builder(
                    builder: (context) {
                      return ItemContainer(deliItem: deliItem);
                    },
                  )
              ],
            ),
          )
      )
    );
  }
}

class Items extends StatelessWidget {
  Items({
          @required this.leftAligned,
          @required this.imgUrl,
          @required this.deliItemName,
          @required this.deliItemPrice,
          @required this.place,
        });

  final bool leftAligned;
  final String imgUrl;
  final String deliItemName;
  final double deliItemPrice;
  final String place;

  @override
  Widget build(BuildContext context) {
    double containerPadding = 45;
    double containerBorderRadius = 10;

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: leftAligned ? 0 : containerPadding,
            right: leftAligned ? containerPadding : 0,
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    left: leftAligned
                        ? Radius.circular(0)
                        : Radius.circular(containerBorderRadius),
                    right: leftAligned
                        ? Radius.circular(containerBorderRadius)
                        : Radius.circular(0),
                  ),
                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                  padding: EdgeInsets.only(
                    left: leftAligned ? 20 : 0,
                    right: leftAligned ? 0 : 20,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(deliItemName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  )),
                            ),
                            Text("\$$deliItemPrice",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                )),
                          ],
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 15),
                                children: [
                                  TextSpan(text: "by "),
                                  TextSpan(
                                      text: place,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700))
                                ]),
                          ),
                        ),
                        SizedBox(height: containerPadding),
                      ])),
            ],
          ),
        )
      ],
    );
  }
}

class ItemContainer extends StatelessWidget {

  ItemContainer({@required this.deliItem,});

  final DeliItem deliItem;
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  addToCart(DeliItem deliItem) { bloc.addToList(deliItem); }

  removeFromList(DeliItem deliItem) { bloc.removeFromList(deliItem); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addToCart(deliItem);
        final snackBar = SnackBar(
          content: Text('${deliItem.title} added to Cart'),
          duration: Duration(milliseconds: 200),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Items(
        place: deliItem.place,
        deliItemName: deliItem.title,
        deliItemPrice: deliItem.price,
        imgUrl: deliItem.imgUrl,
        leftAligned: (deliItem.id % 2) == 0 ? true : false,
      ),
    );
  }
}

class FirstPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding (
      padding: EdgeInsets.fromLTRB(25, 25, 0, 0),
      child: Column(
        //template of appBar (the cart value), title(deliver), and searchBar( implement address)
        children: <Widget>[
          NewAppBar(),
          SizedBox(height: 30),
          title(),
          SizedBox(height: 30),
          searchBar(),
          SizedBox(height: 30),
          deli(),
        ],
      ),
    );
  }
  Widget title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 45),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Deli-very",
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
              hintStyle: TextStyle(
                color: Colors.grey[700],
              )
            ),
          ),
        )
      ],
    );
  }
  //edit available number by how many are nearby
  Widget deli() {
    return Container(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          // can expand and add different types of restaurants
          CategoryListItem(
            catIcon: Icons.fastfood,
            catName: "Deli",
            available: 2,
            clicked: true,
          ),
        ],
      ),
    );
  }
}

class CategoryListItem extends StatelessWidget {
  final IconData catIcon;
  final String catName;
  final int available;
  final clicked;
  CategoryListItem({
      @required this.catIcon,
      @required this.catName,
      @required this.available,
      @required this.clicked,
});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white,
        //selected ? Colors.grey[700] :
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.black87,
                // selected ? Colors.transparent :
                width: 1.5)
            ),
            child: Icon(
              catIcon,
              color: Colors.black,
              size: 30,
            ),
          ),
          SizedBox(height: 10),
          Text(
            catName,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),

          Text(
            available.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black26,
            ),
          )
        ],
      ),
    );
  }
}

class NewAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartListBloc block = BlocProvider.getBloc<CartListBloc>();
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.menu),
          StreamBuilder(
            stream: block.listStream,
            builder: (context, snapshot) {
              List<DeliItem> deliItems = snapshot.data;
              int length = deliItems != null ? deliItems.length : 0;
              return buildGestureDetector(length, context, deliItems);
            },
          )
        ],
      ),
    );
  }
  GestureDetector buildGestureDetector (int length, BuildContext context, List<DeliItem> deliItems) {
    return GestureDetector (
      onTap: () {
        if (length > 0) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
        }
        else
          return;
      },
      child: Container(
      margin: EdgeInsets.all(20),
      child: Text(length.toString()),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blue[200], borderRadius: BorderRadius.circular(30)),
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