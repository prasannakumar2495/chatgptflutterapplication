import 'package:chatgptflutterapplication/providers/alldata.dart';
import 'package:chatgptflutterapplication/providers/themeprovider.dart';
import 'package:chatgptflutterapplication/providers/typesofchatgptservices.dart';
import 'package:chatgptflutterapplication/ui/chatscreen.dart';
import 'package:chatgptflutterapplication/widget/dashboardsingleview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/alldatamessagesindashboard.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TypesOfChatGptServiceProvider>(
      context,
      listen: false,
    );
    var allDataProvider = Provider.of<AllDataProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('AIBot'),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Consumer<ThemeNotifierProvider>(
                  builder: (context, value, child) => TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: value.fetchThemeNotifier
                              ? const BorderSide(color: Colors.grey)
                              : const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed(ChatScreen.routeName);
                    },
                    child: const ListTile(
                      visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.add_rounded),
                      title: Text('New Chat'),
                    ),
                  ),
                ),
              ),
            ),
            const AllDataMessagesInDashboard(),
            Column(
              children: [
                const Divider(),
                ListTile(
                  onTap: () {
                    allDataProvider.clearAllData();
                  },
                  leading: const Icon(Icons.delete_rounded),
                  title: const Text('Clear Conversations'),
                ),
                Consumer<ThemeNotifierProvider>(
                  builder: (context, value, child) => ListTile(
                    onTap: () {
                      value.updateTheme();
                    },
                    leading: value.fetchThemeNotifier
                        ? const Icon(Icons.dark_mode_rounded)
                        : const Icon(Icons.light_mode_rounded),
                    title: value.fetchThemeNotifier
                        ? const Text('Dark Mode')
                        : const Text('Light Mode'),
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.discord_rounded),
                  title: Text('OpenAI Discord'),
                ),
                const ListTile(
                  leading: Icon(Icons.open_in_new_rounded),
                  title: Text('Updated & FAQ'),
                ),
                const ListTile(
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
