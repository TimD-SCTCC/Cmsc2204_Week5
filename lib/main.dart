import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Week 6 Git'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool pageFirstLoad = true;
  bool isLoadingItemsFromDatabase = false;
  bool pageLoaded = false;

  List<Item> items = [
    Item('Jean', 'Grey', 1001, 'Occasional'),
    Item('Scott', 'Summers', 1002, 'Saver'),
    Item('Matt', 'Murdock', 1003, 'Spender'),
    Item('Wilson', 'Fisk', 1004, 'Spender'),
    Item('Miles', 'Morales', 1005, 'Frequent'),
    Item('Bobby', 'Drake', 1006, 'Saver'),
    Item('Emma', 'Frost', 1007, 'Spender'),
    Item('Spider', 'Ham', 1080, 'Occasional'),
    Item('Steve', 'Rogers', 1009, 'Saver'),
    Item('Tony', 'Stark', 1010, 'Spender'),
  ];

  void _handleButtonPress() {
    setState(() {
      pageFirstLoad = false;
      isLoadingItemsFromDatabase = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoadingItemsFromDatabase = false;
        pageLoaded = true; // Indicate that the customers have loaded
      });
    });
  }

  void _handleButtonPress2() {
    setState(() {
      pageFirstLoad = true;
      isLoadingItemsFromDatabase = false;
      pageLoaded = false; // Reset the pageLoaded flag
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoadingItemsFromDatabase = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called,
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget.
        child: pageFirstLoad
            ? ElevatedButton(
                onPressed: _handleButtonPress,
                child: Text("Load Items"),
              )
            : isLoadingItemsFromDatabase
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Text("Please wait")
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: items.map((item) {
                        return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.FirstName,
                                    style: TextStyle(fontSize: 20)),
                                Text(item.LastName,
                                    style: TextStyle(fontSize: 20)),
                                Text(
                                    'Customer ID: ${item.CustomerID.toString()}'),
                                Text('Buying Habbits: ${item.Type}'),
                                Divider(),
                              ],
                            ));
                      }).toList(),
                    ),
                  ),
      ),
      floatingActionButton:
          pageLoaded // Show the button only if customers have loaded
              ? FloatingActionButton(
                  onPressed: _handleButtonPress2,
                  child: Text('Reload Page'),
                  // child: Icon(Icons.refresh),
                )
              : null, // Set to null to hide the button when customers are not loaded
    );
  }
}

class Item {
  String FirstName;
  String LastName;
  int CustomerID;
  String Type;

  Item(this.FirstName, this.LastName, this.CustomerID, this.Type);
}
