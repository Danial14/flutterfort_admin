import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'appdrawer.dart';

class InvoiceInputForm extends StatefulWidget {
  const InvoiceInputForm({Key? key}) : super(key: key);

  @override
  State<InvoiceInputForm> createState() => _InvoiceInputFormState();
}

class _InvoiceInputFormState extends State<InvoiceInputForm> {
  String _invoiceNo = "";
  String _invoiceDate = "";
  int _invoiceAmount = 0;
  TextEditingController _customerId = TextEditingController();
  int _rebate = 0;
  String _adjustmentType = "";
  String _adjustmentDocumentDate = "";
  String _adjustmentDocumentNo = "";
  final _formKey = GlobalKey<FormState>();
  TextEditingController _adjDateController = TextEditingController();
  TextEditingController _invoiceDateController = TextEditingController();
  List<String>? _customers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*Future.delayed(Duration.zero, () async{
      _customers = await _getCustomersId();
      print("customers size: ${_customers!.length}");
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
              Text("Invoice form", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30
              ),
              ),
              SizedBox(height: 10,),
              FutureBuilder<List<String>?>(
                future: _getCustomersId(),
                builder: (ctx, snapshot){
                  if(snapshot.hasData){
                    _customers = snapshot.data;
                    return Container(
                      child: Form(
                        key: _formKey,
                        child: Expanded(child: Column(
                          children: <Widget>[
                            SizedBox(height: 10,),
                            /*Flexible(child: Padding(padding: EdgeInsets.all(5),
                                child: TextFormField(
                                  validator: (val){
                                    if(val!.isEmpty){
                                      return "Please provide valid Invoice No";
                                    }
                                  },
                                  onSaved: (val){
                                    _invoiceNo = val!;
                                  },
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
                            Flexible(child: Padding(padding: EdgeInsets.all(5),
                              child: TextFormField(
                                keyboardType: TextInputType.datetime,
                                validator: (val){
                                  if(val!.isEmpty){
                                    return "Please provide valid Invoice date";
                                  }
                                },
                                onSaved: (val){
                                  _invoiceDate = val!;
                                },
                                controller: _invoiceDateController,
                                onTap: ()async{
                                  DateTime? dateTime = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(hours: Duration.hoursPerDay * 365)));
                                  _invoiceDateController.text = "${dateTime!.year}-${dateTime.month}-${dateTime.day}";
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xfff6f7fa),
                                  hintText: "Invoice Date",
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
                            Flexible(child: Padding(padding: EdgeInsets.all(5),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                validator: (val){
                                  if(val!.isEmpty){
                                    return "Please provide valid Invoice Amount";
                                  }
                                },
                                onSaved: (val){
                                  _invoiceAmount = int.parse(val!);
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xfff6f7fa),
                                  hintText: "Invoice Amount",
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
                            Flexible(child: Padding(padding: EdgeInsets.all(5),
                              child: DropdownSearch<String>(
                                onChanged: (String? val){
                                  _customerId.text = val!;
                                },
                                popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    fit: FlexFit.loose,
                                    constraints: BoxConstraints.tightFor(
                                        width: double.infinity,
                                        height: 300
                                    )
                                ),
                                items: _customers!,
                              ),
                            ),
                              flex: 1,),
                            Flexible(child: Padding(padding: EdgeInsets.all(5),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                validator: (val){
                                  if(val!.isEmpty){
                                    return "Please provide valid Rebate";
                                  }
                                },
                                onSaved: (val){
                                  _rebate = int.parse(val!);
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xfff6f7fa),
                                  hintText: "Rebate",
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
                            Flexible(child: Padding(padding: EdgeInsets.all(5),
                              child: TextFormField(
                                validator: (val){
                                  if(val!.isEmpty){
                                    return "Please provide valid Adjustment document date";
                                  }
                                },
                                onSaved: (val){
                                  _adjustmentDocumentDate = val!;
                                },
                                controller: _adjDateController,
                                onTap: ()async{
                                  DateTime? dateTime = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(hours: Duration.hoursPerDay * 365)));
                                  _adjDateController.text = "${dateTime!.year}-${dateTime.month}-${dateTime.day}";
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xfff6f7fa),
                                  hintText: "Adjustment Document Date",
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
                              flex: 1,),
                            Flexible(child: Padding(padding: EdgeInsets.all(5),
                              child: TextFormField(
                                validator: (val){
                                  if(val!.isEmpty){
                                    return "Please provide valid Adjustment document no";
                                  }
                                },
                                onSaved: (val){
                                  _adjustmentDocumentNo = val!;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xfff6f7fa),
                                  hintText: "Adjustment Document No",
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
                            Flexible(child: Padding(padding: EdgeInsets.all(5),
                              child: TextFormField(
                                validator: (val){
                                  if(val!.isEmpty){
                                    return "Please provide valid Adjustment Type";
                                  }
                                },
                                onSaved: (val){
                                  _adjustmentType = val!;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xfff6f7fa),
                                  hintText: "Adjustment Type",
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
                            Flexible(child: InkWell(onTap: (){
                              _validateInvoiceForm();
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
                        ),),
                      ),
                    );
                  }
                  else{
                    return Center(child: CircularProgressIndicator(),);
                  }
                },
              )
            ],
          ),
        ),
      ),)
    );
  }
  void _validateInvoiceForm(){
    bool isValid = _formKey.currentState!.validate();
    if(isValid){
      _formKey.currentState!.save();
      FirebaseFirestore.instance.collection("Invoice").add({
        "Invoice_No" : DateTime.now().toString(),
        "Invoice_Date" : _invoiceDate,
        "Invoice_Amount" : _invoiceAmount,
        "Customer_Id" : _customerId.text,
        "Adjustment_Type" : _adjustmentType,
        "Rebate" : _rebate,
        "Adj_Document_No" : _adjustmentDocumentNo,
        "Adj_Document_Date" : _adjustmentDocumentDate
      });
    }
  }
  Future<List<String>?> _getCustomersId() async{
    try {
      var query = await FirebaseFirestore.instance.collection("Customers").get();
      var data = query.docs;
      List<String> customerIds = [];
      for(int i = 0; i < data.length; i++){
        customerIds.add(data[i].reference.id);
      }
      return customerIds;
    }
    catch(e){
      print(e);
    }

  }
}
