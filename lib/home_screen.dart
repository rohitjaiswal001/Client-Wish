import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          color: Colors.black,
          height: (MediaQuery.of(context).size.height),
          width: (MediaQuery.of(context).size.width),
          margin: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: (MediaQuery.of(context).size.width),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          image: const DecorationImage(
                            image: NetworkImage(
                                "https://get.pxhere.com/photo/beach-sea-coast-ocean-architecture-house-town-vacation-travel-village-mediterranean-tower-seascape-bay-island-blue-chapel-tourism-santorini-resort-greece-cape-686738.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              "Let's play",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            Text(
              "Wills & Estates",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "- Wishwell -",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    ]);
  }
}
