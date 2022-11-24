import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_pref/pages/home.dart';
import 'package:shared_pref/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({Key? key}) : super(key: key);

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController nameTextController=TextEditingController();
  bool visiblePas=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: RadialGradient(colors: [
            Colors.deepPurple.shade700,
            Colors.deepPurple.shade100,
          ],
            radius:1.5,)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        body: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:  [
              ///greeting text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child:  Text("Welcome!",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.white),),
              ),
              const SizedBox(height: 10,),
              const  Padding(
                padding:  EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("Hope you will love this service!",style: TextStyle(fontSize: 18,color: Colors.white70),),
              ),
              const SizedBox(height: 5,),
              ///Name
              Container(
                padding:const EdgeInsets.symmetric(horizontal: 5),
                margin: const EdgeInsets.all( 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.white,width: 1)
                ),
                child:   TextField(
                  controller: nameTextController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name',
                      hintStyle: TextStyle(color: Colors.grey)
                  ),
                ),
              ),
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

                      if(nameTextController.text.isNotEmpty || emailController.text.isNotEmpty || passwordController.text.isNotEmpty){
                        //email validation
                        if(EmailValidator.validate(emailController.text.toString())){
                          pref.setString("email", emailController.text.toString());
                          pref.setString("name", nameTextController.text.toString());
                          pref.setString("password", passwordController.text.toString());
                          showToast("Signup Successfully");
                          pref.setBool('isLogin', true);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
                        }else{
                          showToast("Invalid Email !");
                        }
                      }else{
                        showToast("Fields are Empty !");
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
                      child:  const Text("Sign up",style: TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.center,),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5,),
              Padding(padding: EdgeInsets.all(0.8),
                child: InkWell(
                  onTap: (){
                   Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Already a member?",style: TextStyle(fontSize: 15,color:Colors.white70,),),
                      Text(" Login Now!",style: TextStyle(fontSize: 15,color:Colors.white,fontWeight: FontWeight.bold),),
                    ],),
                ),)
            ],
          ),
          ///If User Open this app first time then this icon should not show!!!
          SafeArea(
            child: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 30,)),
          ),
        ],),
      ),
    );
  }
  showToast(String text){

    Fluttertoast.showToast(msg: text,
        fontSize: 15,
        gravity: ToastGravity.TOP,
        textColor: Colors.white,
        backgroundColor: Colors.deepPurple.withOpacity(0.8));
    /* ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text(text),
        ));*/
  }
}
