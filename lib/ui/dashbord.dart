import 'package:chatgptflutterapplication/providers/alldata.dart';
import 'package:chatgptflutterapplication/providers/themeprovider.dart';
import 'package:chatgptflutterapplication/providers/typesofchatgptservices.dart';
import 'package:chatgptflutterapplication/util/constants.dart';
import 'package:chatgptflutterapplication/widget/dashboardsingleview.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
    var themeProvider =
        Provider.of<ThemeNotifierProvider>(context, listen: false);
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
                          side: value.fetchTheme
                              ? const BorderSide(color: Colors.grey)
                              : const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      context.go('/$CHAT_SCREEN');
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
                    leading: value.fetchTheme
                        ? const Icon(Icons.light_mode_rounded)
                        : const Icon(Icons.dark_mode_rounded),
                    title: value.fetchTheme
                        ? const Text('Light Mode')
                        : const Text('Dark Mode'),
                  ),
                ),
                ListTile(
                  onTap: () async {
                    const url = 'https://discord.com/invite/openai';
                    final uri = Uri.parse(url);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      throw 'Could not launch $uri';
                    }
                  },
                  leading: const Icon(Icons.discord_rounded),
                  title: const Text('OpenAI Discord'),
                ),
                ListTile(
                  onTap: () async {
                    const url =
                        'https://help.openai.com/en/collections/3742473-chatgpt';
                    final uri = Uri.parse(url);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      throw 'Could not launch $uri';
                    }
                  },
                  leading: const Icon(Icons.open_in_new_rounded),
                  title: const Text('Updated & FAQ'),
                ),
                ListTile(
                  onTap: () {
                    themeProvider.clearTheme();
                    context.go('/');
                  },
                  leading: const Icon(Icons.logout_rounded),
                  title: const Text('Log out'),
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
