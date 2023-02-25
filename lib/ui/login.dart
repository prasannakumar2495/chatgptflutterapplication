import 'package:chatgptflutterapplication/providers/username.dart';
import 'package:chatgptflutterapplication/ui/dashbord.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  late UserNameProvider userNameProvider;

  @override
  void initState() {
    userNameProvider = Provider.of<UserNameProvider>(
      context,
      listen: false,
    );

    var response = userNameProvider.fetchUserNameFuture;
    response.then((value) {
      if (value.isNotEmptyAndNotNull) {
        debugPrint('UserName is: $value');
        Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            width: 250,
            child: Image.asset('assets/logotransperant.png'),
          ),
          const Divider(
            color: Colors.transparent,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    right: 15,
                    left: 15,
                    bottom: 10,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: userNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (userNameController.text.isEmpty) {
                        return 'Name should not be empty!';
                      } else if (userNameController.text.length < 5) {
                        return 'Name should have minimum 5 characters!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(width: 2),
                      ),
                      hintText: 'Enter Your Name...',
                      prefixIcon: const Icon(Icons.person_rounded),
                      suffixIcon: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Info About Name'),
                                content: const Text(
                                    'The user only needs to input their name and click "Next" to advance to the next screen; there is no need to register.'),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.info_rounded),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      userNameProvider.updateUserName(
                        userNameController.text.trim(),
                      );
                      Navigator.of(context)
                          .pushReplacementNamed(DashboardScreen.routeName);
                    }
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
