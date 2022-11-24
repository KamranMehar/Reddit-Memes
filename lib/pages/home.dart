

import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_pref/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String name="";
  String email="";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(colors: [
            Colors.blueGrey.shade100,
            Colors.blueGrey.shade700,
          ],
            radius:1.5,),
      ),
        child: SafeArea(
          child: Hero(
            tag: 'tag',
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: [
                  SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network('https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-Vector-PNG-File.png')),
                  SizedBox(height: 20,width: MediaQuery.of(context).size.width,),
                Text(" Wellcom $name" ,style: TextStyle(fontSize: 20,color: Colors.grey[200]),),
                SizedBox(height:50),
                Text("$name" ,style: TextStyle(fontSize:40,color: Colors.blueGrey,decoration: TextDecoration.underline)),
                Text(" $email" ,style: TextStyle(fontSize: 20,color: Colors.blueGrey.shade400),),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: InkWell(
                      onTap: () async {
                        SharedPreferences pref=await SharedPreferences.getInstance();
                        QuickAlert.show(
                         backgroundColor: Colors.blueGrey.shade100,

                      //    autoCloseDuration: const Duration(seconds: 10),
                          showCancelBtn: true,
                          context: context,
                          type: QuickAlertType.confirm,
                          text: 'Do you want to logout',
                          confirmBtnText: 'Yes',
                          cancelBtnText: 'No',
                          confirmBtnColor: Colors.blueGrey,
                          onConfirmBtnTap: (){
                            pref.setBool('isLogin', false);
                            Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context)=> LoginPage()));
                          },
                          onCancelBtnTap: (){
                            Navigator.pop(context);
                          }
                        );
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all( 12),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blueGrey.shade800,
                                offset: const Offset(5, 5),
                                blurRadius: 7,
                                spreadRadius: 1
                            )
                          ],
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blueGrey,
                        ),
                        child:  const Text("Logout",style: TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.center,),
                      ),
                    ),
                  ),
              ],),
            ),
          ),
        ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  void getData() async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    name=pref.getString("name")??"Not Found";
    email=pref.getString("email")??"Not Found";
    setState(() {});
  }
}
