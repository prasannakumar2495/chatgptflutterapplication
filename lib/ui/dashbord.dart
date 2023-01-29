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
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: provider.fetchAllServices.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
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
