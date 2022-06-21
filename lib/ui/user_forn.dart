import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/const/AppColors.dart';
import 'package:flutter_store_app/ui/buttom_nav_controller.dart';
import 'package:flutter_store_app/widgets/customButton.dart';
import 'package:flutter_store_app/widgets/myTextField.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  List<String> gender = ["Male", "Female", "Other"];

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  sendUserDataToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var  currentUser = _auth.currentUser;

    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef.doc(currentUser!.email).set({
      "name": _nameController.text,
      "phone": _phoneController.text,
      "dob": _dobController.text,
      "gender": _genderController.text,
      "age": _ageController.text,
    }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (_) => BottomNavController()))).catchError((error) => print("something is wrong. $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: ScreenUtil().screenWidth,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50),
                        Text("data",
                            style: TextStyle(
                                fontSize: 14.sp, color: Color(0xFFBBBBBB))),
                        Text("data",
                            style: TextStyle(
                                fontSize: 14.sp, color: Color(0xFFBBBBBB))),
                        SizedBox(height: 60),
                        myTextField("Nhap ho va ten", TextInputType.text,
                            _nameController),
                        SizedBox(height: 10),
                        myTextField("Nhap so dien thoai", TextInputType.number,
                            _phoneController),
                        SizedBox(height: 10),
                        TextField(
                          controller: _dobController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Date of Birth",
                            suffixIcon: IconButton(
                              onPressed: () => _selectDateFromPicker(context),
                              icon: Icon(Icons.calendar_today_outlined),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _genderController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "choose your gender",
                            prefixIcon: DropdownButton<String>(
                              items: gender.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                  onTap: () {
                                    setState(() {
                                      _genderController.text = value;
                                    });
                                  },
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        myTextField(
                            "Nhap tuoi", TextInputType.number, _ageController),
                        SizedBox(height: 50),
                        SizedBox(
                          width: 1.sw,
                          height: 56.h,
                          child: ElevatedButton(
                            onPressed:  (){
                               sendUserDataToDB();
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
