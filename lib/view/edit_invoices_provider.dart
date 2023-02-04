import 'package:flutter/material.dart';

class EditInvoicesProvider with ChangeNotifier{
  List<String> _docIds = [];
  void addDocId(String docId){
    _docIds.add(docId);
  }
  void removeDocId(){
    _docIds.removeAt(0);
    print("removeDocId");
    notifyListeners();
  }
  String getDocId(){
    print("latestdoc");
    print("docids size ${_docIds.length}");
    return _docIds[0];
  }
  void removeId(String docId){
    _docIds.remove(docId);
  }
  int getIdSize(){
    return _docIds.length;
  }
  void notify(){
    notifyListeners();
  }
}