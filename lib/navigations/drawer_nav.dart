import 'package:flutter/material.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: const Center(
              child: Text("Hello Here", style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold,
                color: Colors.white
              ),),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 20,),
          ListTile(
            leading: const Icon(Icons.note),
            title: const Text("Your Notes"),
            onTap: () => Navigator.of(context).pushReplacementNamed("/home"),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Personal Settings"),
            onTap: () => Navigator.of(context).pushReplacementNamed("/personal-settings"),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
