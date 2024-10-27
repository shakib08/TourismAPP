import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tuition_media/Login/controller/auth.dart';
import 'package:tuition_media/Login/controller/logincontroller.dart';
import 'package:tuition_media/Utils/Constant/colors.dart';
import 'package:tuition_media/Utils/Widgets/customButton.dart';
import 'package:tuition_media/Utils/Widgets/customGestureDetector.dart';
import 'package:tuition_media/Utils/Widgets/customTextfield.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService auth = AuthService(); 
    LoginController controllerlog = LoginController(); 
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
                icon: Icons.email,
                label: "Email",
                inputType: TextInputType.text,
                controller: controllerlog.emailController),
            CustomTextField(
                icon: Icons.password,
                label: "Password",
                inputType: TextInputType.text,
                controller: controllerlog.passwordController),
            SizedBox(
              height: size.height * 0.04,
            ),
            CustomButton(
                backgroundColor: customIndigoColor,
                text: "login",
                textColor: Colors.white,
                width: size.width * 0.9,
                onPressed: ()async{
                   try{
                    await auth.login(controllerlog, context); 
                   }catch(e){
                   }
                }
                ),
            SizedBox(
              height: size.height * 0.02,
            ),
            const Text("Don't have an account?"),
            CustomGestureDetector(
                text: "Sign up",
                textColor: customIndigoColor,
                onTap: () {
                  context.go('/register');
                })
          ],
        ),
      ),
    );
  }
}
