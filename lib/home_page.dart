import 'package:flutter/material.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> boards = [
    {'title': 'Sports Chat', 'icon': 'assets/sports.jpeg'},
    {'title': 'Study Group', 'icon': 'assets/study.jpeg'},
    {'title': 'Tech Forum', 'icon': 'assets/tech.jpeg'},
    {'title': 'Health Club', 'icon': 'assets/health.jpeg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Message Boards')),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Center(
                child: Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Boards'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: GridView.builder(
        itemCount: boards.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          final board = boards[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(boardName: board['title']!),
                ),
              );
            },
            child: Card(
              color: Colors.teal[300],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(board['icon']!),
                    radius: 30,
                  ),
                  SizedBox(height: 8),
                  Text(
                    board['title']!,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
