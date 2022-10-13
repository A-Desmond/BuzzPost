import 'package:buzpost/Views/Screens/Auth/login.dart';
import 'package:buzpost/Views/Widgets/text_field.dart';
import 'package:buzpost/constant.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  Register({super.key});
  final TextEditingController _registeremailController =
      TextEditingController();
  final TextEditingController _registerpasswordController =
      TextEditingController();
  final TextEditingController _businessName = TextEditingController();
  final TextEditingController _businessType = TextEditingController();
  final TextEditingController _ownersName = TextEditingController();
  final String imageurl = 'https://bit.ly/3Djxl3r';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 7),
              const Text(
                'BUZPOST',
                style: TextStyle(
                    color: buttonColor,
                    fontSize: 35,
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Register',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () => authController.pickImage(),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(
                        imageurl,
                      ),
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Positioned(child: child)
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 35),
                child: TextInputField(
                  controller: _ownersName,
                  label: 'Username',
                  icon: Icons.person,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 35),
                child: TextInputField(
                  controller: _registeremailController,
                  label: 'Email',
                  icon: Icons.email,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 35),
                  child: TextInputField(
                    controller: _registerpasswordController,
                    label: 'Password',
                    icon: Icons.lock,
                    isObscure: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  authController.register(
                    name: _ownersName.text,
                    email: _registeremailController.text,
                    password: _registerpasswordController.text,
                    image: authController.profilePhoto,
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 70,
                  height: 50,
                  decoration: const BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: const Center(
                      child: Text(
                    'Register',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  )),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Have an account?  ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => LoginScreen(),
                          ));
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20, color: buttonColor),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
