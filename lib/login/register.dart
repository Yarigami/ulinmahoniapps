import 'package:flutter/material.dart';
import 'logging_in.dart';

class Registering extends StatefulWidget {
  const Registering({super.key});

  @override
  State<Registering> createState() => _RegisteringState();
}

class _RegisteringState extends State<Registering> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                // SizedBox(height: 10,),
                Image(image: AssetImage("assets/images/logo.png"), width: 150, height: 150,),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Hello! Register to get started",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        hintText: "Username",
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        hintText: "Email",
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        hintText: "Password",
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        hintText: "Confirm password",
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     TextButton(
                //         onPressed: (){},
                //         style: ButtonStyle(
                //           backgroundColor: MaterialStateProperty.all(Colors.transparent),
                //           foregroundColor: MaterialStateProperty.all(Colors.grey[600]),
                //           overlayColor: MaterialStateProperty.all(Colors.transparent),
                //           // alignment: Alignment.centerRight,
                //         ),
                //         child: Text("Forgot Password?")
                //     ),
                //   ],
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green[800]),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Register ",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: LayoutBuilder(
                    builder: (context, constraints){
                      double spacing = constraints.maxWidth * 0.03;

                      return Row(
                        children: [
                          Expanded(child: Divider(
                            thickness: 1,
                            color: Colors.grey,
                            endIndent: spacing,
                          )),
                          Text("Or Login With"),
                          Expanded(child: Divider(
                            thickness: 1,
                            color: Colors.grey,
                            endIndent: spacing,
                          )),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _socialMedia("assets/images/facebook.png"),
                      _socialMedia("assets/images/google.png"),
                      _socialMedia("assets/images/apple.png"),
                    ],
                  ),
                ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoggingIn()));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                foregroundColor: MaterialStateProperty.all(Colors.green),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? ", style: TextStyle(color: Colors.black),),
                  Text("Login Now",),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialMedia(String imgPath){
    return InkWell(
      onTap: (){},
      child: Container(
        height: 80,
        width: 120,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey),
        ),
        child: Image.asset(imgPath),
      ),
    );
  }
}
