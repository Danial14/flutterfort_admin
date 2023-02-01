import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fortline_admin_app/view/deleteoreditcustomerandinvoices.dart';


class AppDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(accountName: Center(
            child: Text("User name"),
          ), accountEmail: null,decoration: BoxDecoration(
              color: Colors.cyanAccent
          ),),
          SizedBox(height: 8,),
          ListTile(
            leading: Icon(Icons.download),
            title: Text("Download customer report"),
            onTap: (){

            },
          ),
          SizedBox(height: 8,),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Show Customers"),
          ),

          SizedBox(height: 8,),
          ListTile(
            leading: Icon(Icons.point_of_sale_sharp),
            title: Text("Delete Invoices"),
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                return DeleteOrEditInvoices("delete");
              }));
            },
          ),
          SizedBox(height: 8,),
          ListTile(
            leading: Icon(Icons.inventory_rounded),
            title: Text("Delete all Invoices"),
            onTap: () async{
              try {
                var ref = FirebaseFirestore.instance.collection("Invoice");
                var query = await (ref.get());
                List<QueryDocumentSnapshot<Map<String, dynamic>>> data = query.docs;
                if(data.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("There is no invoice to be deleted")));
                }
                else{
                  await showDialog(barrierDismissible: false
                      ,context: context, builder: (ctx){
                    return AlertDialog(
                      title: Text("Delete Invoices"),
                      content: Text("Do you want to delete all invoices"),
                      actions: <Widget>[
                        TextButton(onPressed: () async{
                          for(int i = 0; i < data.length; i++){
                            await ref.doc(data[i].reference.id).delete();
                          }
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All invoices are deleted successfully")));
                          Navigator.of(context).pop();
                        }, child: Text("Ok")),
                        TextButton(onPressed: (){
                          Navigator.of(context).pop();
                        }, child: Text("Cancel"))
                      ],
                    );
                  });
                }
              }
              catch(e){
                print(e);
              }
            },
          ),
          SizedBox(height: 8,),
          ListTile(
            leading: Icon(Icons.my_location_rounded),
            title: Text("Current location"),
            onTap: (){
            },
          ),
          SizedBox(height: 8,),
          ListTile(
            leading: Icon(Icons.work_history),
            title: Text("Visit history"),
          ),

          SizedBox(height: 8,),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: (){
            },
          )
        ],
      ),
    );
  }
}