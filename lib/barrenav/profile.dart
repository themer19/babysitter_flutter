import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            // Header section
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Back button
                  Positioned(
                    top: 20,
                    left: 20,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        // Handle back navigation
                      },
                    ),
                  ),
                  // Avatar and edit icon
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 50, color: Colors.grey),
                      ),
                      Positioned(
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.black,
                          child:
                              Icon(Icons.edit, size: 15, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Input Fields Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: "First Name",
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Last Name",
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15),
                    // Birth and Gender options
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text("Birth"),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // Handle birth selection
                      },
                    ),
                    Divider(),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text("Gender"),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // Handle gender selection
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Buttons Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle password change
                    },
                    icon: Icon(Icons.lock),
                    label: Text("Change Password"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  OutlinedButton.icon(
                    onPressed: () {
                      // Handle logout
                    },
                    icon: Icon(Icons.logout, color: Colors.red),
                    label: Text("Logout"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: BorderSide(color: Colors.red),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
