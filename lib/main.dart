import 'dart:collection';
import 'package:flutter/material.dart';
import 'map_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AttendancePage(),
    );
  }
}

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final List<Member> members = [
    Member("Wade Warren", "WSL0003", "09:30 am", "WORKING", Colors.green),
    Member("Esther Howard", "WSL0034", "09:30 am", "06:40 pm", Colors.red),
    Member("Cameron Williamson", "WSL0054", "Not Logged-in Yet", "",
        Colors.grey.shade200),
    Member("Brooklyn Simmons", "WSL0076", "09:30 am", "06:40 pm", Colors.red),
    Member("Savannah Nguyen", "WSL0065", "09:30 am", "06:40 pm", Colors.red),
    Member("Leslie Alexander", "WSL0069", "09:30 am", "06:40 pm", Colors.red),
    Member("Kathryn Murphy", "WSL0095", "09:30 am", "06:40 pm", Colors.red),
  ];

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 71, 55, 172),
        elevation: 1,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'ATTENDENCE',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(width: 8),
          ],
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        centerTitle: false,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 68, 51, 178),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.timer, size: 30, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'workstatus',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            'https://via.placeholder.com/150'), // Replace with profile image URL
                      ),
                      SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cameron Williamson',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'cameronwilliamson@gmail.com',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.timer, 'Timer'),
            _buildDrawerItem(Icons.calendar_today, 'Attendance'),
            _buildDrawerItem(Icons.bar_chart, 'Activity'),
            _buildDrawerItem(Icons.insert_chart, 'Timesheet'),
            _buildDrawerItem(Icons.report, 'Report'),
            _buildDrawerItem(Icons.location_on, 'Jobsite'),
            _buildDrawerItem(Icons.people, 'Team'),
            _buildDrawerItem(Icons.time_to_leave, 'Time off'),
            _buildDrawerItem(Icons.schedule, 'Schedules'),
            Divider(),
            _buildDrawerItem(Icons.group_add, 'Request to join Organization'),
            _buildDrawerItem(Icons.password, 'Change Password'),
            _buildDrawerItem(Icons.logout, 'Logout'),
            Divider(),
            _buildDrawerItem(Icons.help, 'FAQ & Help'),
            _buildDrawerItem(Icons.privacy_tip, 'Privacy Policy'),
            ListTile(
              leading: Icon(Icons.info, color: Colors.deepPurple),
              title: Text('Version: 2.10(1)'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Filter Bar
          Container(
            color: Color.fromARGB(255, 234, 240, 246),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.people,
                        color: const Color.fromARGB(255, 126, 118, 177)),
                    SizedBox(width: 8),
                    Text(
                      "All Members",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Change",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 71, 55, 172),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Date Picker
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_back_ios, size: 16, color: Colors.grey),
                Text(
                  "Tue, Aug 31 2022",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade300),
          Expanded(
            child: ListView.separated(
              itemCount: members.length,
              separatorBuilder: (context, index) => Divider(
                thickness: 1,
                color: Colors.grey.shade300,
                height: 1,
              ),
              itemBuilder: (context, index) {
                final member = members[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.grey.shade200,
                        child: Text(
                          member.name[0],
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${member.name} (${member.id})",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            if (member.checkOut.isEmpty)
                              Text(
                                member.checkIn,
                                style: TextStyle(
                                  backgroundColor: Colors.grey.shade200,
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              )
                            else
                              Row(
                                children: [
                                  const Icon(
                                    Icons.call_made,
                                    size: 18,
                                    color: Colors.green,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    member.checkIn,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward,
                                      size: 16, color: Colors.grey),
                                  SizedBox(width: 8),
                                  if (member.checkOut != "WORKING")
                                    const Icon(
                                      Icons.call_received,
                                      size: 18,
                                      color: Colors.red,
                                    ),
                                  SizedBox(width: 8),
                                  if (member.checkOut == "WORKING")
                                    Container(
                                      child: Text(
                                        member.checkOut,
                                        style: TextStyle(
                                          color: member.statusColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 211, 235, 212),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      padding: EdgeInsets.all(2),
                                    )
                                  else
                                    Text(
                                      member.checkOut,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                      ),
                                    ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (member.status.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: member.statusColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                member.status,
                                style: TextStyle(
                                  color: member.statusColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          SizedBox(height: 8),
                          Icon(Icons.calendar_month, color: Colors.black54),
                          SizedBox(height: 8),
                          Icon(Icons.location_on,
                              color: Color.fromARGB(255, 98, 77, 227)),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapView()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Show Map view",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 71, 55, 172),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios,
                      color: const Color.fromARGB(255, 71, 55, 172), size: 18),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title),
      onTap: () {
        
      },
    );
  }
}

class Member {
  final String name;
  final String id;
  final String checkIn;
  final String checkOut;
  final String status;
  final Color statusColor;

  Member(this.name, this.id, this.checkIn, this.checkOut, this.statusColor,
      {this.status = ""});
}
