import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fortline_admin_app/view/edit_invoices_provider.dart';
import 'package:provider/provider.dart';

import 'appdrawer.dart';

class EditInvoiceForm extends StatefulWidget {
  const EditInvoiceForm({Key? key}) : super(key: key);

  @override
  State<EditInvoiceForm> createState() => _EditInvoiceFormState();
}

class _EditInvoiceFormState extends State<EditInvoiceForm> {
  TextEditingController _invoiceDate = TextEditingController();
  TextEditingController _invoiceAmount = TextEditingController();
  TextEditingController _customerId = TextEditingController();
  TextEditingController _adjustmentType = TextEditingController();
  TextEditingController _adjustmentDocumentNo = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _adjDate = TextEditingController();
  TextEditingController _rebateController = TextEditingController();
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? _invoices;
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
                Text("Edit Invoice form", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                ),
                ),
                SizedBox(height: 10,),
                FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>(
                  builder: (ctx, snapshot){
                    if(snapshot.hasData){
                      _invoices = snapshot.data;
                      return Container(
                        child: Consumer<EditInvoicesProvider>(
                          builder: (BuildContext context, editInvoiceData, Widget? child) {
                            print("inside consumer");
                            var referenceIndex;
                            String docId = editInvoiceData.getDocId();
                            print(_invoices!.length);
                            Map<String, dynamic> invoice = {};
                            List<String> _customers = [];
                            for(int i = 0; i < _invoices!.length; i++){
                              if(_invoices![i].reference.id == docId){
                                print("doc id $docId found");
                                invoice = _invoices![i].data();
                                referenceIndex = i;
                                _customerId.text = invoice["Customer_Id"];
                                _customers.add(_customerId.text);
                                _rebateController.text = invoice["Rebate"].toString();
                                _invoiceDate.text = invoice["Invoice_Date"];
                                _invoiceAmount.text = invoice["Invoice_Amount"].toString();
                                _adjustmentType.text = invoice["Adjustment_Type"];
                                _adjustmentDocumentNo.text = invoice["Adj_Document_No"];
                                _adjDate.text = invoice["Adj_Document_Date"];
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
                                        _invoiceDate.text = val!;
                                      },
                                      keyboardType: TextInputType.datetime,
                                      controller: _invoiceDate,
                                      //controller: _invoiceDateController,
                                      onTap: ()async{
                                        DateTime? dateTime = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(hours: Duration.hoursPerDay * 365)));
                                        _invoiceDate.text = "${dateTime!.year}-${dateTime.month}-${dateTime.day}";
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
                                  Flexible(fit: FlexFit.loose,child: Padding(padding: EdgeInsets.all(5),
                                    child: TextFormField(
                                        onSaved: (val){
                                          _invoiceAmount.text = val!;
                                        },
                                      keyboardType: TextInputType.number,
                                      controller: _invoiceAmount,
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
                                  Flexible(fit: FlexFit.loose,child: Padding(padding: EdgeInsets.all(5),
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
                                      items: _customers,
                                      selectedItem: _customerId.text,
                                    ),
                                  ),
                                    flex: 1,),
                                  Flexible(fit: FlexFit.loose,child: Padding(padding: EdgeInsets.all(5),
                                    child: TextFormField(
                                      onSaved: (val){
                                        _rebateController.text = val!;
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: _rebateController,
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
                                  Flexible(fit: FlexFit.loose,child: Padding(padding: EdgeInsets.all(5),
                                    child: TextFormField(
                                      onSaved: (val){
                                        _adjDate.text = val!;
                                      },
                                      controller: _adjDate,
                                    //  controller: _adjDate,
                                      onTap: ()async{
                                        DateTime? dateTime = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(hours: Duration.hoursPerDay * 365)));
                                        _adjDate.text = "${dateTime!.year}-${dateTime.month}-${dateTime.day}";
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
                                  Flexible(fit: FlexFit.loose,child: Padding(padding: EdgeInsets.all(5),
                                    child: TextFormField(
                                      onSaved: (val){
                                        _adjustmentDocumentNo.text = val!;
                                      },
                                      controller: _adjustmentDocumentNo,
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
                                  Flexible(fit: FlexFit.loose,child: Padding(padding: EdgeInsets.all(5),
                                    child: TextFormField(
                                      onSaved: (val){
                                        _adjustmentType.text = val!;
                                      },
                                      controller: _adjustmentType,
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
                                  Flexible(fit: FlexFit.loose,child: InkWell(onTap: (){
                                    _updateInvoice(docId);
                                    if(editInvoiceData.getIdSize() > 0){
                                      print("refInd $referenceIndex");
                                      _invoices!.removeAt(referenceIndex);
                                      editInvoiceData.removeId(docId);
                                      if(editInvoiceData.getIdSize() == 0){
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All Invoices are edited")));
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
                  future: _getInvoices(),
                )
              ],
            ),
          ),
        ),)
    );
  }
  void _updateInvoice(String docId) async{
      _formKey.currentState!.save();
      await FirebaseFirestore.instance.collection("Invoice").doc(docId).update({
        //"Invoice_No" : _invoiceNo,
        "Invoice_Date" : _invoiceDate.text,
        "Invoice_Amount" : int.parse(_invoiceAmount.text),
        "Customer_Id" : _customerId.text,
        "Adjustment_Type" : _adjustmentType.text,
        "Rebate" : int.parse(_rebateController.text),
        "Adj_Document_No" : _adjustmentDocumentNo.text,
        "Adj_Document_Date" : _adjDate.text
      });
      /*_invoiceDate = "";
      _invoiceAmount = 0;
      _customerId.text = "";
      _adjustmentType = "";
      _rebateController.text = "";
      _adjustmentDocumentNo = "";
      _adjDate = "";*/
  }
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?> _getInvoices() async{
    try {
      var query = await FirebaseFirestore.instance.collection("Invoice").get();
      var invoicesData = query.docs;
      print("invoicesData size: ${invoicesData.length}");
      return invoicesData;
    }
    catch(e){
      print(e);
    }

  }
}
