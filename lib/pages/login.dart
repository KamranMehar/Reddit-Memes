
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_pref/pages/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

///Login page

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool visiblePas=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: RadialGradient(colors: [
            Colors.deepPurple.shade100,
            Colors.deepPurple.shade700,
          ],
            radius:1.5,)
      ),
      child: Scaffold(
            backgroundColor: Colors.transparent,
        body: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:  [
                ///greeting text
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child:  Text("Hello Again",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.white),),
                ),
                const SizedBox(height: 10,),
                const  Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("Welcome Back, you've been missed!",style: TextStyle(fontSize: 18,color: Colors.white60),),
                ),
                const SizedBox(height: 5,),
                ///Email
                Container(
                  padding:const EdgeInsets.symmetric(horizontal: 5),
                  margin: const EdgeInsets.all( 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[100],
                      border: Border.all(color: Colors.white,width: 1)
                  ),
                  child:   TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey)
                    ),
                  ),
                ),
                ///Password
                Container(
                  padding:const EdgeInsets.symmetric(horizontal: 5),
                  margin: const EdgeInsets.all( 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[100],
                      border: Border.all(color: Colors.white,width: 1)
                  ),
                  child:   TextField(
                    obscureText: visiblePas? false:true,
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration:  InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Colors.grey),
                        suffixIcon: IconButton(
                            color: Colors.grey,
                            onPressed: (){
                              if(!visiblePas){
                                visiblePas=true;
                              }else{
                                visiblePas=false;
                              }
                              setState(() {});
                            }, icon: visiblePas?const Icon(Icons.visibility_off): const Icon(Icons.visibility))
                    ),
                  ),
                ),
                ///LoginBtn
                Hero(
                  tag: 'tag',
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: ()async{
                        SharedPreferences pref= await SharedPreferences.getInstance();
                        if(emailController.text.isNotEmpty || passwordController.text.isNotEmpty){
                          if(pref.getString("email")==emailController.text.toString() ){
                            if(pref.getString("password")==passwordController.text.toString()){
                             showToast("Login Successfully");
                             pref.setBool('isLogin', true);
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
                            }else{
                              showToast("Invalid Password");
                            }
                          }else{
                            showToast("Invalid Email ");
                          }
                        }else{
                          showToast("Field Should Not Empty!");
                        }
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all( 12),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.deepPurple.shade800,
                                offset: const Offset(5, 5),
                                blurRadius: 7,
                                spreadRadius: 1
                            )
                          ],
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.deepPurple,
                        ),
                        child:  const Text("Login",style: TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.center,),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Sign_up()));
                  },
                  child: Padding(padding: EdgeInsets.all(0.8),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                      Text("Not a member?",style: TextStyle(fontSize: 15,color:Colors.white70,),),
                      Text(" Register Now!",style: TextStyle(fontSize: 15,color:Colors.white,fontWeight: FontWeight.bold),),
                    ],),
                  ),
                ),
              ],
            ),

          ],)
        ),
    );
  }

  showToast(String text){

    Fluttertoast.showToast(msg: text,
    fontSize: 15,
    gravity: ToastGravity.TOP,
    textColor: Colors.white,
    backgroundColor: Colors.deepPurple.withOpacity(0.8));
  }
}

