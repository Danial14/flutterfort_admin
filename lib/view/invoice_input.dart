import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InvoiceInputForm extends StatefulWidget {
  const InvoiceInputForm({Key? key}) : super(key: key);

  @override
  State<InvoiceInputForm> createState() => _InvoiceInputFormState();
}

class _InvoiceInputFormState extends State<InvoiceInputForm> {
  String _invoiceNo = "";
  String _invoiceDate = "";
  int _invoiceAmount = 0;
  String _customerId = "";
  int _rebate = 0;
  String _adjustmentType = "";
  String _adjustmentDocumentDate = "";
  String _adjustmentDocumentNo = "";
  final _formKey = GlobalKey<FormState>();
  TextEditingController _adjDateController = TextEditingController();
  TextEditingController _invoiceDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size _deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Fortline"),
      ),
      body: Center(child: Container(
        height: _deviceSize.height * 80 / 100,
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
              Container(
                child: Form(
                  key: _formKey,
                  child: Expanded(child: Column(
                    children: <Widget>[
                      SizedBox(height: 10,),
                      Flexible(child: Padding(padding: EdgeInsets.all(10),
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
                        flex: 1,),
                      Flexible(child: Padding(padding: EdgeInsets.all(10),
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
                      Flexible(child: Padding(padding: EdgeInsets.all(10),
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
                      Flexible(child: Padding(padding: EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (val){
                            if(val!.isEmpty){
                              return "Please provide valid Customer Id";
                            }
                          },
                          onSaved: (val){
                            _customerId = val!;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xfff6f7fa),
                            hintText: "Customer Id",
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
                      Flexible(child: Padding(padding: EdgeInsets.all(10),
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
                      Flexible(child: Padding(padding: EdgeInsets.all(10),
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
                      Flexible(child: Padding(padding: EdgeInsets.all(10),
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
                      Flexible(child: Padding(padding: EdgeInsets.all(10),
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
        "Invoice_No" : _invoiceNo,
        "Invoice_Date" : _invoiceDate,
        "Invoice_Amount" : _invoiceAmount,
        "Customer_Id" : _customerId,
        "Adjustment_Type" : _adjustmentType,
        "Rebate" : _rebate,
        "Adj_Document_No" : _adjustmentDocumentNo,
        "Adj_Document_Date" : _adjustmentDocumentDate
      });
    }
  }
}
