import 'package:flutter/material.dart';
import 'package:weightapp/service/firestore_service.dart';
import 'package:weightapp/views/weights.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    var service = FireStoreService();

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Anonymous-SignIn", style: TextStyle(color: Colors.black),),

      ),


      body: Align(
        alignment: Alignment.center,

        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),

            child: Column(

              children: [
                const Image(
                  image:AssetImage("images/logo.png"),
                  width: double.infinity,
                  height: 150.0,
                  alignment: Alignment.center,
                ),

                const SizedBox(height: 20,),

                RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: const SizedBox(
                      height: 50.0,
                      child: Center(
                        child: Text(
                          "Login",
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    onPressed: () async{
                      showLoaderDialog(context, 'please wait');
                      var user = await service.signin();
                      Navigator.pop(context);
                      if(user!=null){
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const Weights(),
                          ),
                              (route) => false,
                        );
                      }else{
                        displaytoastmessage("Error occurred", context);
                      }

                    }

                )
              ],
            ),
          ),
        ),

      ),
    );
  }

  showLoaderDialog(BuildContext context, message){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
          Container(margin: const EdgeInsets.only(left: 7),child:Text(message,style: const TextStyle(
            fontFamily: "Poppins",
          ), )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  displaytoastmessage(String message, BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(message)));
  }

}


