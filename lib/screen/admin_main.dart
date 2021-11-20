import 'package:flutter/material.dart';
import 'package:sef/screen/admin_student_list_page.dart';

class AdminMain extends StatefulWidget {
  const AdminMain({Key? key}) : super(key: key);

  @override
  _AdminMainState createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
  final _tab = <Tab>[
    const Tab(text: 'Dashboard'),
    const Tab(text: 'Question'),
    const Tab(text: 'Manage Profile'),
    const Tab(text: 'Manage Exam'),
    const Tab(text: 'LogOut')
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Admin Main Page'),
            bottom: TabBar(
              tabs: _tab,
            )
          ),
          body: TabBarView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.25,
                    height: MediaQuery.of(context).size.height*0.15,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AdminStudentListPage()));
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.people),
                          SizedBox(width: 3),
                          Text('Total Student'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.25,
                    height: MediaQuery.of(context).size.height*0.15,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: const [
                          Icon(Icons.people),
                          SizedBox(width: 3),
                          Text('Total Lectures'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.25,
                    height: MediaQuery.of(context).size.height*0.15,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: const [
                          Icon(Icons.check_box),
                          SizedBox(width: 3),
                          Text('Total Student'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(color: Colors.cyan),
              Container(color: Colors.lightGreen),
              Container(color: Colors.red),
              Container(color: Colors.yellow),
            ],
          ),
        ),
    );
  }
}
