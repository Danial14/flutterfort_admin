import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'appdrawer.dart';

class ShowCustomers extends StatefulWidget {
  const ShowCustomers({Key? key}) : super(key: key);

  @override
  State<ShowCustomers> createState() => _ShowCustomersState();
}

class _ShowCustomersState extends State<ShowCustomers> {
  var _customerFuture;
  final List<String> _columns = const ["Customer_Id","Customer_Name","Customer_Status","Email","Mobile_No","Pass",
    "Registration_Time"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*Future.delayed(Duration.zero, (){
      _customerFuture = _getCustomers();
    });*/
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SizedBox(height: 50,),
          Flexible(child: Text("Customers",
            style: TextStyle(fontSize: 30,
                fontWeight: FontWeight.bold
            ),
          ),
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Flexible(child: Row(
              children: <Widget>[
                Flexible(child: Container(
                  width: 250,
                  height: 50,
                  child: Center(
                    child: Text("Customer Id",
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 219, 88, 0.4)
                  ),
                ),
                  flex: 1,),
                Flexible(child: Container(
                  width: 250,
                  height: 50,
                  child: Center(
                    child: Text("Customer Name",
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 219, 88, 0.4)
                  ),
                ),
                  flex: 1,),
                Flexible(child: Container(
                  width: 250,
                  height: 50,
                  child: Center(
                    child: Text("Customer Status",
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 219, 88, 0.4)
                  ),
                ),
                  flex: 1,),
                Flexible(
                  flex: 1,
                  child: Container(
                    width: 250,
                    height: 50,
                    child: Center(
                      child: Text("Email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 219, 88, 0.4)
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    width: 250,
                    height: 50,
                    child: Center(
                      child: Text("Mobile No",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 219, 88, 0.4)
                    ),
                  ),
                ),
                Flexible(child: Container(
                  width: 250,
                  height: 50,
                  child: Center(
                    child: Text("Password",
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 219, 88, 0.4)
                  ),
                ),
                flex: 1,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    width: 250,
                    height: 50,
                    child: Center(
                      child: Text("Registration Time",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 219, 88, 0.4)
                    ),
                  ),
                )
              ],
            ), flex: 1,),
          ),
          Flexible(child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: _getCustomers(),
            builder: (ctx, snapshot){
              if(snapshot.hasData){
                int rowIndex = 0;
                List<QueryDocumentSnapshot<Map<String, dynamic>>> data = snapshot.data!.docs;
                List<String> gridData = [];
                for(int i = 0; i < data.length; i++){
                  Map<String, dynamic> record = data[i].data();
                  for(int j = 0; j < _columns.length; j++){
                    gridData.add((record[_columns[j]]).toString());
                  }
                }
                return Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _columns.length,mainAxisSpacing: 0.5,crossAxisSpacing: 0.5,childAspectRatio: 6.3,
                  ), itemBuilder: (ctx, pos){
                    Widget widget;
                    if(pos % _columns.length == 0){
                      rowIndex++;
                    }
                    if(rowIndex % 2 != 0){
                      widget = Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 2),
                          child: Text(gridData[pos]),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300
                        ),
                      );
                    }
                    else{
                      widget = Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 2),
                          child: Text(gridData[pos]),
                        ),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 219, 88, 0.4)
                        ),
                      );
                    }
                    return widget;
                  },
                    itemCount: gridData.length,
                  ),
                );
              }
              else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
            flex: 1,)
        ],
      ),
    );
  }
  Future<QuerySnapshot<Map<String, dynamic>>> _getCustomers() async{
    print("fetching invoices");

    return (await FirebaseFirestore.instance.collection("Customers").get());
  }
}
