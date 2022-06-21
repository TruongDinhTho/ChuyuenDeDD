import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/const/AppColors.dart';
import 'package:flutter_store_app/ui/login_screen.dart';
import 'package:flutter_store_app/ui/user_forn.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({ Key? key }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  bool _obscureText = true;

  signUp() async{
    try
    {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text, 
        password: _passwordController.text,
      );
      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if(authCredential.uid.isNotEmpty){
        Navigator.push(context, CupertinoPageRoute(builder: (_)=>UserForm()));
      }
      else{
        Fluttertoast.showToast(msg: "Something is wrong");
      }

    } on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        Fluttertoast.showToast(msg: "The password provided is too weak.");
      } else if(e.code == 'email-already-in-use'){
        Fluttertoast.showToast(msg: "The account already exists for that email");
      }
    }catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deep_green,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              width: ScreenUtil().screenWidth,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.light,
                      color: Colors.transparent)
                      ),
                      Text("Sign Up",
                        style: TextStyle(fontSize: 25.sp, color: Colors.white),
                      ),
                  ],
                ),
              ),
              
              ),
            Expanded(
              child: Container(
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.r),
                    topRight: Radius.circular(28.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                          Text(
                          "Welcome Buddy!",
                          style: TextStyle(
                              fontSize: 22.sp, color: AppColors.deep_orange),
                        ),
                        Text(
                          "Glad to see you back my buddy.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xFFBBBBBB),
                          ),
                        ),
                        SizedBox(height: 15), 

                        Row(
                          children: [
                            Container(
                              height: 48,
                              width: 41,
                              decoration: BoxDecoration(
                                color: AppColors.deep_orange,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Center(
                                child: Icon(Icons.email_outlined, color: Colors.white,size: 20,),
                              ),
                            ),
                            SizedBox(height:10,width: 20,),
                            Expanded(
                              child: TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: "Nhap email",
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF414041),
                                  ),
                                  labelText: 'EMAIL',
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.deep_orange,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        
                        SizedBox(height: 15,),
                       
                        Row(
                          children: [
                            Container(
                              height: 48,
                              width: 41,
                              decoration: BoxDecoration(
                                color: AppColors.deep_orange,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Center(
                                child: Icon(Icons.lock_outlined, color: Colors.white,size: 20,),
                              ),
                            ),
                            SizedBox(height:10,width: 20,),
                            Expanded(
                              child: TextField(
                                controller: _passwordController,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  hintText: "password must be 6 character",
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF414041),
                                  ),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.deep_orange,
                                  ),
                                  suffixIcon: _obscureText == true ? IconButton(
                                    onPressed: (){
                                      setState(() {
                                        _obscureText = false;
                                      });
                                    }, 
                                    icon: Icon(Icons.remove_red_eye, 
                                    size: 20))
                                    : IconButton(
                                      onPressed: (){
                                        setState(() {
                                          _obscureText = true;
                                        });
                                      }, 
                                      icon: Icon(Icons.visibility_off,
                                      size: 20)),
                                ),
                              ),
                            )
                          ],
                        ),
                        
                        SizedBox(height: 30),
                        
                        SizedBox(
                          width: 1.sw,
                          height: 56.h,
                          child: ElevatedButton(
                            onPressed:  (){
                                signUp();
                              }, 
                            child: Text("Continue",
                                style: TextStyle(
                                 
                                color: Colors.white, fontSize: 18,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: AppColors.deep_orange,
                           
                                elevation: 3
                              ),
                            ),
                        ),

                        //elevatedButton
                        
                        SizedBox(height: 20),

                        Center(
                          child: Wrap(
                            children: [
                              Text(
                                "Do you have an account?",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFBBBBBB),
                                ),
                              ),
                              GestureDetector(
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: AppColors.deep_orange,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                onTap: (){
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => LoginScreen()));
                                },
                              ),
                            ],
                          ),
                        )
                       
                      ],
                      
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}