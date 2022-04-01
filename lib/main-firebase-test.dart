import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  Widget _buildListItem(BuildContext context, String name, String description, String ordre, int posicio) {
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Text(
              name + ": " + ordre,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffddddff),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodyText1,
            )
          ),          
        ]
      ),
      onTap: () {
        // var collection = FirebaseFirestore.instance.collection('products');
        // collection
        //   .doc(posicio.toString())
        //   .update(data);

        CollectionReference users = FirebaseFirestore.instance.collection('users');

        Future<void> updateUser() {
          return users
            .doc('ABC123')
            .update({'company': 'Stokes and Sons'})
            .then((value) => print("User Updated"))
            .catchError((error) => print("Failed to update user: $error"));
        }
      },
    );
  }

  ///////////////////////////////////////////
  ///
  ///
  ///////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        //stream:  Firestore.instance.collection('bandnames').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (!streamSnapshot.hasData) return const Text('Loading...');
          // return ListView.builder(
          //   itemExtent: 80.0,
          //   itemCount: streamSnapshot.data?.docs.length,
          //   itemBuilder: (context, index) =>
          //     _buildListItem(context, streamSnapshot.data?.docs[index]['name'], streamSnapshot.data?.docs[index]['description'], streamSnapshot.data?.docs[index]['order'], index),
          // );
          return ListView.builder(
            itemCount: streamSnapshot.data?.docs.length,
            itemBuilder: (context, index) => 
            //children: streamSnapshot.data!.docs.map((DocumentSnapshot document) {
            //Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            ListTile (
              //title: Text(data['name']),
              title: Text(streamSnapshot.data?.docs[index]['name']),
              //subtitle: Text(data['description']),
              subtitle: Text(streamSnapshot.data?.docs[index]['description'] + ": " + streamSnapshot.data?.docs[index]['order'].toString()),
              isThreeLine: true,
              onTap: () => updateApi(/*streamSnapshot.data?.docs.toString()*/streamSnapshot.data?.docs[index].reference.id.toString()),
            ),
            /*}*/);//.toList(),
          //);
        }
      ),
    );
  }
}

updateApi(String? test) async {
  CollectionReference users = FirebaseFirestore.instance.collection('products');
  //var value = FirebaseFirestore.instance.collection('users').;

  //const increment = firebase.firestore.FieldValue.increment(1);


  //Future<void> updateUser() {
    return users
      .doc(test) //how to get the id
      .update({'order': FieldValue.increment(1)})
      .then((value) => print("Product Updated"))
      .catchError((error) => print("Failed to update product: $error"));
  //}
}

/*
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}*/
