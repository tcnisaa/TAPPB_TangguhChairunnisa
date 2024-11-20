import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<Map<String, String>> teamMembers = [
    {
      'Nama': 'Tangguh Chairunnisa',
      'NIM': '21120122140103',
    },
  ];

  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController nameController = TextEditingController(text: teamMembers[0]['Nama']);
        TextEditingController idController = TextEditingController(text: teamMembers[0]['NIM']);

        return AlertDialog(
          title: const Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: idController,
                decoration: const InputDecoration(labelText: "ID Number"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  teamMembers[0]['Nama'] = nameController.text;
                  teamMembers[0]['NIM'] = idController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
        )),
        backgroundColor: const Color.fromARGB(255, 13, 105, 225),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _editProfile,
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Gambar latar belakang dengan skala setengah halaman dan opacity 0.5
          Positioned.fill(
            child: FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: 0.5,
              child: Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    image: NetworkImage(
                      'https://i0.wp.com/anitrendz.net/news/wp-content/uploads/2023/01/Bocchi-The-Rock.jpg?resize=785%2C420&ssl=1',
                    ),
                  ),
                  color: const Color.fromARGB(255, 255, 252, 252).withOpacity(0.5),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://avatars.githubusercontent.com/u/126763587?v=4',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                for (var member in teamMembers)
                  Column(
                    children: [
                      Text(
                        member['Nama'] ?? 'No Name',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        member['NIM'] ?? 'No NIM',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          // Kredit dan logo MangaDex (Jika diperlukan)
        ],
      ),
      // Tambahkan bottomNavigationBar untuk navbar jika diperlukan
    );
  }
}

