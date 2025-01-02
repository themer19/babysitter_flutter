import 'package:flutter/material.dart';



class ChatScreen extends StatelessWidget {
  final List<Map<String, String>> chats = [
    {
      "name": "Johnny Doe",
      "message": "Lorem Ipsum is simply dummy text of...",
      "time": "08:10",
      "avatar": "images/gamer.png"
    },
    {
      "name": "Adrian",
      "message": "Excepteur sint occaecat cupidatat non...",
      "time": "03:19",
      "avatar": "images/man.png"
    },
    {
      "name": "Fiona",
      "message": "Hi! 😊",
      "time": "02:53",
      "avatar": "images/woman.png"
    },
    {
      "name": "Emma",
      "message": "Consectetur adipiscing elit",
      "time": "11:39",
      "avatar": "images/gamer.png"
    },
    {
      "name": "Alexander",
      "message": "Duis aute irure dolor in reprehenderit...",
      "time": "00:09",
      "avatar": "images/woman.png"
    },
    {
      "name": "Alsoher",
      "message": "Duis aute irure dolor in reprehenderit...",
      "time": "00:09",
      "avatar": "images/man.png"
    },
  ];

  final List<Map<String, String>> onlineUsers = [
    {"name": "Ae", "avatar": "images/gamer.png"},
    {"name": "Bb", "avatar": "images/gamer.png"},
    {"name": "C", "avatar": "images/gamer.png"},
    {"name": "D", "avatar": "images/gamer.png"},
    {"name": "Ee", "avatar": "images/gamer.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 0,
        title: Text("Messenger",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: 28,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section des utilisateurs en ligne (liste horizontale)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "En ligne",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700]),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 90, // Hauteur de la liste horizontale
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: onlineUsers.length,
                      itemBuilder: (context, index) {
                        final user = onlineUsers[index];
                        return Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(user['avatar']!),
                              ),
                              SizedBox(height: 5),
                              Text(
                                user['name']!,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Section des conversations
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 28,
                        backgroundImage: AssetImage(chat['avatar']!),
                      ),
                      title: Text(chat['name']!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      subtitle: Text(
                        chat['message']!,
                        style: TextStyle(color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(
                        chat['time']!,
                        style: TextStyle(color: Colors.grey[500], fontSize: 14),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
