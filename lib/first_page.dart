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
                        Padding(
                          padding: const EdgeInsets.only(top:50, bottom: 20, left: 30, right: 30),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Column(
                                children: const [
                                  Text('Online Objective Exam', style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30
                                  ),),
                                  Text('Quicker to create',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),),
                                  Text('Easier to attend',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width/5,
                            child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          //insetPadding: const EdgeInsets.only(top: 200, bottom: 300),
                                          title: const Text('Contact Us!'),
                                          content: Builder(
                                            builder: (context) {
                                              var height = MediaQuery.of(context).size.height;
                                              var width = MediaQuery.of(context).size.width;
                                              return SizedBox(
                                                height: height-600,
                                                width: width-700,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: const [
                                                        Text('Phone number',style: TextStyle(
                                                          color: Colors.grey,
                                                        ),),
                                                        SizedBox(width: 10),
                                                        Text('+60 1-300-80-0668',style: TextStyle(
                                                          color: Colors.red,
                                                        ),)
                                                      ],
                                                    ),
                                                    Row(
                                                      children: const [
                                                        Text('Email Address', style: TextStyle(
                                                          color: Colors.grey,
                                                        ),),
                                                        SizedBox(width: 10),
                                                        Text('connect@mmu.edu.my',style: TextStyle(
                                                          color: Colors.red,
                                                        ),)
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text("Close"),
                                              onPressed: () => Navigator.pop(context),
                                            ),
                                          ],
                                        );
                                      },
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Text('Contact us'),
                                    Icon(Icons.phone),
                                    Icon(Icons.alternate_email_rounded),
                                  ],
                                ),
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
}
