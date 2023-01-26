import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Flexible(flex: 1,
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(child: Image(
                  image: AssetImage("assets/images/Fortline-logo-white.png"),
                ), flex: 1,),
              ],
            ))
            ,
            SizedBox(
              height: 10,
            ),
            Flexible(flex: 1,
            child: Container(child: Center(child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),elevation: 10,
              child: Form(key: _formState,
                child: Column(

                children: <Widget>[
                  Flexible(child: Padding(padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15), child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "EMail",
                        prefixIcon: Icon(Icons.alternate_email),
                        fillColor: Color(0xfff6f7fa),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xfff6f7fa)),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        hintStyle: TextStyle(
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xfff6f7fa)
                            ),
                            borderRadius: BorderRadius.circular(15)
                        )
                    ),
                  ),),
                    flex: 1,
                  )
                  ,
                  SizedBox(height: 10,),
                  Flexible(flex: 1,child: Padding(padding: EdgeInsets.symmetric(horizontal: 15), child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: Icon(Icons.visibility_off),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xfff6f7fa)),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xfff6f7fa)),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      filled: true,
                      fillColor: Color(0xfff6f7fa),
                    ),
                  ),))
                  ,
                  SizedBox(height: 30,),
                  Flexible(child: InkWell(onTap: (){
                    _validateAdmin();
                  },child: Container(
                    width: 300,
                    height: 35,
                    decoration: BoxDecoration(color: Color(0xfff75a27),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(blurRadius: 1.0, offset: Offset(1, 5), color: Colors.black12)
                        ]
                    ),
                    child: Center(child: Text("Login", style: TextStyle(
                        color: Colors.white
                    ),),),
                  ),
                  ),
                    flex: 1,
                  )

                ],
              ),),),), width: 400,),
            )


          ],
        ),
      ),
    );
  }
  void _validateAdmin(){
    bool isValid = _formState.currentState!.validate();
    if(isValid){
      _formState.currentState!.save();
    }
  }
}
