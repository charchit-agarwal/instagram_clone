import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsive/responsive_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  Uint8List? _profilePic;
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        image: _profilePic!);
    // if string returned is sucess, user has been created
    if (res == "Success") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ResponsiveScreen()));
    } else {
      showSnackBar(res, context);
    }
  }

  void navigateToLoginScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              :const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
              ),
              const SizedBox(
                height: 50,
              ),
              Stack(
                children: [
                  _profilePic != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_profilePic!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://www.tenforums.com/geek/gars/images/2/types/thumb_15951118880user.png'),
                        ),
                  Positioned(
                    left: 89,
                    bottom: 8,
                    child: IconButton(
                      onPressed: () async {
                        Uint8List im = await pickImage(ImageSource.gallery);
                        setState(() {
                          _profilePic = im;
                        });
                      },
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextFieldInput(
                  textEditingController: _usernameController,
                  hint: 'Enter your username',
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _emailController,
                hint: 'Enter your email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                hint: 'Enter your password',
                textInputType: TextInputType.visiblePassword,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _bioController,
                hint: 'Enter your bio',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  signUpUser();
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: ShapeDecoration(
                      color: blueColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text('Sign Up'),
                ),
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text('Already have an account?'),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: navigateToLoginScreen,
                      child: const Text(
                        'Log In',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
