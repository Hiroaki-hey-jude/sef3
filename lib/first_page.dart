import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final _tab = <Tab>[
    const Tab(text: 'Home'),
    const Tab(text: 'About'),
    const Tab(text: 'Registration'),
    const Tab(text: 'LogIn'),
  ];
  final List<Widget> _contents = [
    const Center(child: Icon(Icons.directions_car)),
    const Center(child: Icon(Icons.directions_bike)),
    const Center(child: Icon(Icons.directions_boat)),
    const Center(child: Icon(Icons.directions_boat)),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width/3,
                height: MediaQuery.of(context).size.height/5,
                  child: const Image(image: AssetImage('assets/IMG_6820.jpg')),
              ),
            ),
            SizedBox(
              height: 50,
              child: AppBar(
                bottom: TabBar(
                  tabs: _tab,
                ),
              ),
            ),
            Expanded(
                child: TabBarView(
                  children: [
                    Column(
                      children: [
                        Container(
                          child: Center(
                            child: Column(
                              children: const [
                                Text('Online Objective Exam', style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),),
                                Text('Quicker to create'),
                                Text('Easier to attend'),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: ElevatedButton(
                              onPressed: () {
                              },
                              child: Row(
                                children: const [
                                  Text('Contact us'),
                                  Icon(Icons.phone),
                                  Icon(Icons.alternate_email_rounded),
                                ],
                              ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.pink,
                      child: const Center(
                        child: Text(
                          'Car',
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.pink,
                      child: const Center(
                        child: Text(
                          'Car',
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.pink,
                      child: const Center(
                        child: Text(
                          'Car',
                        ),
                      ),
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }

  Widget button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.lightGreen,
          height: 40,
          width: 150,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () {},
            child: const Text(
              'Home',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        Container(
          color: Colors.lightGreen,
          height: 40,
          width: 150,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () {},
            child: const Text(
              'About',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        Container(
          color: Colors.lightGreen,
          height: 40,
          width: 150,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () {},
            child: const Text(
              'Registration',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        Container(
          color: Colors.lightGreen,
          height: 40,
          width: 150,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () {},
            child: const Text(
              'LogIn',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
