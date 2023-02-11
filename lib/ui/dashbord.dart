import 'package:chatgptflutterapplication/providers/typesofchatgptservices.dart';
import 'package:chatgptflutterapplication/widget/dashboardsingleview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TypesOfChatGptServiceProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('AIBot'),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: const BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.add_rounded),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: const Text('New Chat'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 1000,
                itemBuilder: (context, index) {
                  return const Text('child');
                },
              ),
            ),
            Column(
              children: const [
                Divider(),
                ListTile(
                  leading: Icon(Icons.delete_rounded),
                  title: Text('Clear Conversations'),
                ),
                ListTile(
                  leading: Icon(Icons.dark_mode_rounded),
                  title: Text('Dark Mode'),
                ),
                ListTile(
                  leading: Icon(Icons.discord_rounded),
                  title: Text('OpenAI Discord'),
                ),
                ListTile(
                  leading: Icon(Icons.open_in_new_rounded),
                  title: Text('Updated & FAQ'),
                ),
                ListTile(
                  leading: Icon(Icons.logout_rounded),
                  title: Text('Log out'),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: provider.fetchAllServices.length,
          itemBuilder: (context, index) {
            return DashboardSingleView(
              typeName: provider.fetchAllServices[index].typeName,
            );
          },
        ),
      ),
    );
  }
}
