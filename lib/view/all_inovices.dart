import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'appdrawer.dart';

class AllInvoices extends StatefulWidget {
  const AllInvoices({Key? key}) : super(key: key);

  @override
  State<AllInvoices> createState() => _AllInvoicesState();
}

class _AllInvoicesState extends State<AllInvoices> {
  var _invoicesFuture;
  final List<String> _columns = const ["Invoice_No","Invoice_Date","Invoice_Amount","Customer_Id","Rebate","Adj_Document_Date",
  "Adj_Document_No","Adjustment_Type"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, (){
      _invoicesFuture = _getInvoices();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SizedBox(height: 50,),
          Flexible(child: Text("Invoices",
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
                    child: Text("Invoice No",
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
                    child: Text("Invoice Date",
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
                    child: Text("Invoice Amount",
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
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    width: 250,
                    height: 50,
                    child: Center(
                      child: Text("Rebate",
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
                Container(
                  width: 250,
                  height: 50,
                  child: Center(
                    child: Text("Adjustment Document Date",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 219, 88, 0.4)
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    width: 250,
                    height: 50,
                    child: Center(
                      child: Text("Adjustment Document No",
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
                      child: Text("Adjustment Type",
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
            future: _invoicesFuture,
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
                      crossAxisCount: 8,mainAxisSpacing: 0.5,crossAxisSpacing: 0.5,childAspectRatio: 6.3,
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
  Future<QuerySnapshot<Map<String, dynamic>>> _getInvoices() async{
    print("fetching invoices");

   return (await FirebaseFirestore.instance.collection("Invoice").get());
  }
}
