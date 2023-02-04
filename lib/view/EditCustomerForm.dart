import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appdrawer.dart';
import 'edit_invoices_provider.dart';

class EditCustomerForm extends StatefulWidget {
  const EditCustomerForm({Key? key}) : super(key: key);

  @override
  State<EditCustomerForm> createState() => _EditCustomerFormState();
}

class _EditCustomerFormState extends State<EditCustomerForm> {
  TextEditingController _customerName = TextEditingController();
  TextEditingController _customerStatus = TextEditingController();
  TextEditingController _mobileNo = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _adjDate = TextEditingController();
  TextEditingController _rebateController = TextEditingController();
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? _customersData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*Future.delayed(Duration.zero, () async{
      _invoiceFuture = await _getInvoices();
    });*/
  }
  @override
  Widget build(BuildContext context) {
    Size _deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("Fortline"),
        ),
        body: Center(child: Container(
          height: _deviceSize.height * 95 / 100,
          width: _deviceSize.width * 50 / 100,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10,),
                Text("Edit Customer form", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                ),
                ),
                SizedBox(height: 10,),
                FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>(
                  builder: (ctx, snapshot){
                    if(snapshot.hasData){
                      _customersData = snapshot.data;
                      return Container(
                        child: Consumer<EditInvoicesProvider>(
                          builder: (BuildContext context, editInvoiceData, Widget? child) {
                            print("inside consumer");
                            var referenceIndex;
                            String docId = editInvoiceData.getDocId();
                            print(_customersData!.length);
                            Map<String, dynamic> customer = {};
                            for(int i = 0; i < _customersData!.length; i++){
                              if(_customersData![i].reference.id == docId){
                                print("doc id $docId found");
                                customer = _customersData![i].data();
                                referenceIndex = i;
                                _mobileNo.text = customer["Mobile_No"].toString();
                                _customerName.text = customer["Customer_Name"];
                                _customerStatus.text = customer["Customer_Status"].toString();
                                _password.text = customer["Pass"];
                                break;
                              }
                            }
                            return Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  SizedBox(height: 10,),
                                  /*Flexible(child: Padding(padding: EdgeInsets.all(5),
                                  child: TextFormField(
                                    initialValue: invoice[""],
                                    decoration: InputDecoration(
                                      hintText: "Invoice No",
                                      fillColor: Color(0xfff6f7fa),
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Color(0xfff6f7fa)
                                          )
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Color(0xfff6f7fa),
                                        ),
                                      ),
                                    ),
                                  )),
                                flex: 1,),*/
                                  Flexible(fit: FlexFit.loose,child: Padding(padding: EdgeInsets.all(5),
                                    child: TextFormField(
                                      onSaved: (val){
                                        _customerName.text = val!;
                                      },
                                      keyboardType: TextInputType.text,
                                      controller: _customerName,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xfff6f7fa),
                                        hintText: "Customer Name",
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color: Color(0xfff6f7fa)
                                            )
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: Color(0xfff6f7fa),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ), flex: 1,),
                                  Flexible(fit: FlexFit.loose,child: Padding(padding: EdgeInsets.all(5),
                                    child: TextFormField(
                                      onSaved: (val){
                                        _customerStatus.text = val!;
                                      },
                                      keyboardType: TextInputType.text,
                                      controller: _customerStatus,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xfff6f7fa),
                                        hintText: "Customer Status",
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color: Color(0xfff6f7fa)
                                            )
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: Color(0xfff6f7fa),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                    flex: 1,
                                  ),
                                  Flexible(fit: FlexFit.loose,child: Padding(padding: EdgeInsets.all(5),
                                    child: TextFormField(
                                      onSaved: (val){
                                        _mobileNo.text = val!;
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: _mobileNo,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xfff6f7fa),
                                        hintText: "Mobile No",
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color: Color(0xfff6f7fa)
                                            )
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: Color(0xfff6f7fa),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                    flex: 1,
                                  ),
                                  Flexible(fit: FlexFit.loose,child: Padding(padding: EdgeInsets.all(5),
                                    child: TextFormField(
                                      onSaved: (val){
                                        _password.text = val!;
                                      },
                                      controller: _password,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xfff6f7fa),
                                        hintText: "Password",
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color: Color(0xfff6f7fa)
                                            )
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: Color(0xfff6f7fa),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                    flex: 1,
                                  ),
                                  SizedBox(height: 10,),
                                  Flexible(fit: FlexFit.loose,child: InkWell(onTap: (){
                                    _updateInvoice(docId);
                                    if(editInvoiceData.getIdSize() > 0){
                                      print("refInd $referenceIndex");
                                      _customersData!.removeAt(referenceIndex);
                                      editInvoiceData.removeId(docId);
                                      if(editInvoiceData.getIdSize() == 0){
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All customers are edited")));
                                      }
                                      else {
                                        editInvoiceData.notify();
                                      }
                                    }
                                  },child: Container(
                                    width: 200,
                                    height: 35,
                                    decoration: BoxDecoration(color: Color(0xfff75a27),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(blurRadius: 1.0, offset: Offset(1, 5), color: Colors.black12)
                                        ]
                                    ),
                                    child: Center(child: Text("Submit", style: TextStyle(
                                        color: Colors.white
                                    ),),),
                                  ),
                                  ),
                                    flex: 1,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator(),);
                  },
                  future: _getCustomers(),
                )
              ],
            ),
          ),
        ),)
    );
  }
  void _updateInvoice(String docId) async{
    _formKey.currentState!.save();
    await FirebaseFirestore.instance.collection("Customers").doc(docId).update({
      //"Invoice_No" : _invoiceNo,
      "Customer_Name" : _customerName.text,
      "Customer_Status" : _customerStatus.text,
      "Mobile_No" : _mobileNo.text,
      "Pass" : _password.text,
    });
    /*_invoiceDate = "";
      _invoiceAmount = 0;
      _customerId.text = "";
      _adjustmentType = "";
      _rebateController.text = "";
      _adjustmentDocumentNo = "";
      _adjDate = "";*/
  }
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?> _getCustomers() async{
    try {
      var query = await FirebaseFirestore.instance.collection("Customers").get();
      var customersData = query.docs;
      print("customersData size: ${customersData.length}");
      return customersData;
    }
    catch(e){
      print(e);
    }

  }
}
