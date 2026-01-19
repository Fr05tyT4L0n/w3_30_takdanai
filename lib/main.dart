import 'package:flutter/material.dart';

// models
import 'package:w3_30_takdanai/users_model.dart';
import 'package:w3_30_takdanai/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Handle Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: const MyHomePage(title: 'Employees'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
      ),

      body: FutureBuilder<List<Users>>(
        future: ApiService.fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("เกิดข้อผิดพลาด"));
          }

          final users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              return Card(
                margin: EdgeInsets.all(15),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Padding(
                  padding: EdgeInsets.all(15),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 4),
                        ),

                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(user.avatar),
                          backgroundColor: Colors.black,
                        ),
                      ),

                      SizedBox(height: 15),

                      Text(
                        user.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),
                      Text("Age: ${user.age}", style: TextStyle(fontSize: 16)),

                      SizedBox(height: 5),
                      Text(
                        "Birthdate: ${user.birthDate.substring(0, 10)}",
                        style: TextStyle(fontSize: 16),
                      ),

                      SizedBox(height: 5),
                      Text(
                        "City: ${user.city}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
