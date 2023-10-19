import 'dart:io';
import 'package:poke_app_beta/Widget/customTextField.dart';
import 'package:poke_app_beta/Widget/error_dialog.dart';
import 'package:poke_app_beta/Widget/loading_dialog.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poke_app_beta/mainscreens/home_screen.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();
  String userImageUrl= "";


  Future<void> _getImage() async{
   imageXFile = await _picker.pickImage(source: ImageSource.gallery);
   setState(() {
     imageXFile;
   });
  }

  Future<void> formValidation() async {
      if(passwordcontroller.text == confirmpasswordcontroller.text){
        if(confirmpasswordcontroller.text.isNotEmpty && emailcontroller.text.isNotEmpty&& namecontroller.text.isNotEmpty){
          showDialog(context: context, builder: (c){
            return LoadingDialog(
              message: "Registered Account",
            );
          });
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          fStorage.Reference reference = fStorage.FirebaseStorage.instance.ref().child("users").child(fileName);
          fStorage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
          fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((url) {
            userImageUrl = url;

            //signUpAndAuthenticateUser();
          });
        }
        else{
          showDialog(
              context: context,
              builder: (c){
                return ErrorDialog( message: "Password complete registration info.",
                );
              }
          );
        }
      }
      else{
        showDialog(
            context: context,
            builder: (c){
          return ErrorDialog( message: "Password do not match.",
          );
        }
        );
      }
    }
   /* Future<void> signUpAndAuthenticateUser() async {
      User? currentUser;
      final FirebaseAuth firebaseAuth= FirebaseAuth.instance;
      await firebaseAuth.createUserWithEmailAndPassword(
          email: emailcontroller.text.trim(), password: passwordcontroller.text.trim(),
      ).then((auth){
        currentUser = auth.user;
      });


      if(currentUser != null){
        saveDataToFirestore(currentUser!).then((value){
          Navigator.pop(context);
          //send user to home page
          Route newRoute = MaterialPageRoute(builder: (c) => HomeScreen());
          Navigator.pushReplacement(context, newRoute);
        }

        );
      }
    }
  Future saveDataToFirestore(User currentUser) async {
    FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set({
      "userUID": currentUser.uid,
      "userEmail": currentUser.email,
      "userName" : namecontroller.text.trim(),
      "userAvatarUrl" : userImageUrl,
      "status": "approved",
    });
    //save data locally
  }*/

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children:  [
            const SizedBox(height: 10,),
            InkWell(
              onTap: (){
                _getImage();
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.20,
                backgroundColor: Colors.white,
                backgroundImage: imageXFile == null ?null : FileImage(File(imageXFile!.path)),
                child: imageXFile == null?
                Icon(
                  Icons.add_photo_alternate,
                  size : MediaQuery.of(context).size.width * 0.20,
                  color: Colors.grey,
                ) : null,
              ),
            ),
            const SizedBox(height: 10,),
            Form(
              key: _formKey,
              child: Column(
                  children: [
                    CustomTextField(
                      data: Icons.person,
                      controller: namecontroller,
                      hintText: "Name",
                      isObsecre: false,
                    ),
                    CustomTextField(
                      data: Icons.email,
                      controller: emailcontroller,
                      hintText: "Email",
                      isObsecre: false,
                    ),
                    CustomTextField(
                      data: Icons.lock,
                      controller: passwordcontroller,
                      hintText: "Password",
                      isObsecre: true,
                    ),
                    CustomTextField(
                      data: Icons.lock,
                      controller: confirmpasswordcontroller,
                      hintText: "Confirm Password",
                      isObsecre: true,
                    ),

                  ],),

            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              child: Text("Sign Up",
              style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.purple,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10)
            ),
              onPressed: (){
                formValidation();
              },
            ),
            const SizedBox(height: 30),
          ],
        ),

      )
    );

  }
}
