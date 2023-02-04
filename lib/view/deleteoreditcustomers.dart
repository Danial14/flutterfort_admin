import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fortline_admin_app/view/EditCustomerForm.dart';
import 'package:provider/provider.dart';

import 'appdrawer.dart';
import 'edit_invoices_provider.dart';

class DeleteOrEditCustomers extends StatefulWidget {
  late String _mode;
  DeleteOrEditCustomers(String mode){
    this._mode = mode;
  }

  @override
  State<DeleteOrEditCustomers> createState() => _DeleteOrEditCustomersState();
}

class _DeleteOrEditCustomersState extends State<DeleteOrEditCustomers> {
  final List<String> _columns = const ["Customer_Id", "Customer_Name", "Customer_Status", "Email", "Mobile_No", "Pass", "Registration_Time", "DeleteOrEdit"];
  List<String> _docIds = [];
  List<String> _itemsToBeDeletedOrEdited = [];
  ValueNotifier<bool> checkBoxStatus = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SizedBox(height: 50,),
          Flexible(child: Text(widget._mode == "delete" ? "Delete Customers" : "Edit Customers",
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
                    child: Text("Customer_Id",
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
                Container(
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
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    width: 250,
                    height: 50,
                    child: Center(
                      child: Text(widget._mode == "delete" ? "Delete" : "Edit",
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
              ],
            ), flex: 1,),
          ),
          Flexible(child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: _getInvoices(),
            builder: (ctx, snapshot){
              if(snapshot.hasData){
                int rowIndex = 0;
                List<QueryDocumentSnapshot<Map<String, dynamic>>> data = snapshot.data!.docs;
                List<String> gridData = [];
                List<ValueNotifier<bool>> valueNotifiers = [];
                for(int i = 0; i < data.length; i++){
                  Map<String, dynamic> record = data[i].data();
                  for(int j = 0; j < _columns.length - 1; j++){
                    gridData.add((record[_columns[j]]).toString());
                  }
                }
                int noOfRowsForExtraColumn = (gridData.length / (_columns.length - 1)) as int;
                int extraColumnIndex = _columns.length - 1;
                for(int i = 0; i < noOfRowsForExtraColumn; i++){
                  gridData.insert(extraColumnIndex, "check!box");
                  extraColumnIndex = extraColumnIndex + _columns.length;
                  valueNotifiers.add(ValueNotifier<bool>(false));
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
                          child: gridData[pos] == "check!box" ? ValueListenableBuilder<bool>(valueListenable: valueNotifiers[pos % (_columns.length - 1)], builder: (ctx, v, child){
                            return Switch(value: valueNotifiers[pos % (_columns.length - 1)].value, onChanged: (val){
                              print("inside switch $val");

                              if(val){
                                print(pos);
                                print(pos % (_columns.length - 1));
                                if(this.widget._mode == "delete") {
                                  _itemsToBeDeletedOrEdited.add(
                                      _docIds[pos % (_columns.length - 1)]);
                                }
                                else{
                                  Provider.of<EditInvoicesProvider>(context,listen: false).addDocId(_docIds[pos % (_columns.length - 1)]);
                                }
                              }
                              else{
                                if(this.widget._mode == "delete") {
                                  _itemsToBeDeletedOrEdited.remove(_docIds[pos % (_columns.length - 1)]);
                                }
                                else{
                                  Provider.of<EditInvoicesProvider>(context,listen: false).removeId(_docIds[pos % (_columns.length - 1)]);
                                }
                              }
                              valueNotifiers[pos % (_columns.length - 1)].value = val;
                              print("checkboxstatus : ${valueNotifiers[pos % (_columns.length - 1)].value}");
                            });
                          }) : Text(gridData[pos]),
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
                          child: gridData[pos] == "check!box" ? ValueListenableBuilder<bool>(valueListenable: valueNotifiers[pos % (_columns.length - 1)], builder: (ctx, v, child){
                            return Switch(value: valueNotifiers[pos % (_columns.length - 1)].value, onChanged: (val){
                              print("inside switch");
                              if(val){
                                print(pos);
                                print(pos % (_columns.length - 1));
                                if(this.widget._mode == "delete") {
                                  _itemsToBeDeletedOrEdited.add(
                                      _docIds[pos % (_columns.length - 1)]);
                                }
                                else{
                                  Provider.of<EditInvoicesProvider>(context,listen: false).addDocId(_docIds[pos % (_columns.length - 1)]);
                                }
                              }
                              else{
                                if(this.widget._mode == "delete") {
                                  _itemsToBeDeletedOrEdited.remove(_docIds[pos % (_columns.length - 1)]);
                                }
                                else{
                                  Provider.of<EditInvoicesProvider>(context,listen: false).removeId(_docIds[pos % (_columns.length - 1)]);
                                }
                              }
                              valueNotifiers[pos % (_columns.length - 1)].value = val;
                              print("checkboxstatus : ${valueNotifiers[pos % (_columns.length - 1)].value}");
                            });
                          }) : Text(gridData[pos]),
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
      floatingActionButton: FloatingActionButton(
        child: widget._mode == "delete" ? Icon(Icons.delete) : Icon(Icons.edit),
        onPressed: () async{
          var ref = await FirebaseFirestore.instance.collection("Customers");
          if(widget._mode == "delete"){
            if(_itemsToBeDeletedOrEdited.isNotEmpty){
              await showDialog(barrierDismissible: false,context: context, builder: (ctx){
                return AlertDialog(
                  content: Text("Do you really want to delete these invoices"),
                  title: Text("Delete Invoices"),
                  actions: <Widget>[
                    TextButton(onPressed: ()async{
                      for(int i = 0; i < _itemsToBeDeletedOrEdited.length; i++){
                        await ref.doc(_itemsToBeDeletedOrEdited[i]).delete();
                      }
                      Navigator.of(context).pop();
                      setState(() {
                        _itemsToBeDeletedOrEdited = [];
                      });
                    }, child: Text("Ok")),
                    TextButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                        setState(() {
                          _itemsToBeDeletedOrEdited = [];
                        });
                      },
                      child: Text("Cancel"),
                    )
                  ],
                );
              });
            }
          }
          else{
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
              return EditCustomerForm();
            }));
          }
        },
      ),
    );
  }
  Future<QuerySnapshot<Map<String, dynamic>>> _getInvoices() async{
    print("fetching invoices");
    try {
      var ref = await FirebaseFirestore.instance.collection("Customers");
      var query = await ref.get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = query.docs;
      for (int i = 0; i < data.length; i++) {
        _docIds.add(data[i].reference.id);
        print("Id : ${data[i].reference.id}");
      }
      return query;
    }
    catch(e){
      print(e);
      throw e;
    }
  }
}
