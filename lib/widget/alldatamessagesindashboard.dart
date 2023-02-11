import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/alldata.dart';

class AllDataMessagesInDashboard extends StatelessWidget {
  const AllDataMessagesInDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AllDataProvider>(context);
    var allData = provider.fetchAllData;
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: allData.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () => Navigator.pop(context),
            leading: const Icon(Icons.message_rounded),
            title: Text(allData[index].message),
          );
        },
      ),
    );
  }
}
