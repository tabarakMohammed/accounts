import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:accounts/DataProvider/DataBasepro.dart';
import 'package:accounts/infoModel/Model.dart';
import 'package:accounts/ui/allOinfo.dart';
import 'package:accounts/library/hereFile.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

class ListView1 extends StatefulWidget  {

  @override
  _ListView1 createState()  => new _ListView1();

}
enum radioSelect { database, CSV ,text}

class _ListView1 extends State<ListView1>  {

  double percentage = 0.0;
  List<Model> myData = new List();
  List<Model> myDataBack = new List<Model>();
  SqlLight db = new SqlLight();
  String errorF = "";


  TextEditingController _uerName = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _passward = new TextEditingController();
  TextEditingController _fileName = new TextEditingController();
  TextEditingController _searchQueryController = TextEditingController();

  Future search(String searchQuery) async {
    if(searchQuery.isNotEmpty) {
      await db.searchByName(searchQuery).then((information) {
        setState(() {
          myData.clear();
          information.forEach((info) {
            myData.add(Model.map(info));
          });
        });
      });
    }
  }

  search1(String searchQuery) {
    search(searchQuery);
  }

///import databaseFile
  void getExFile() async {
    try {
      var path = await FilePicker.getFilePath();
     //  debugPrint(path);
      if( path == null )
        {
          {errorF = " !!! ";}

        }
      else if(path.endsWith(".db")) {
        List infoBack = await db.readExsSqlBase(path);
        infoBack.forEach((info) {
          myDataBack.add(Model.map(info));
        });

        infoBack.clear();
        BackupInsert();

      } else
            { errorF = "تأكد من أمتداد الفايل .db ";}
    }
    catch(e) {
      errorF = e;
    }
  }







  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    db.retrieveN().then((users){

  setState(() {
    users.forEach((user) {
      myData.add(Model.map(user));
    });
  });

    });

  }


  @override
  Widget build(BuildContext context) {
    ProgressDialog pr = new ProgressDialog(context);
    pr.style(
        message: 'الرجاء الأنتظار...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
    return MaterialApp(

      home: Scaffold(

        backgroundColor:Color(0xFF2f3542),

        appBar: AppBar(

          title: Text("حساباتي",
              style:TextStyle(
              color: Color(0xFFeccc68),
          fontSize: 18,
          fontWeight: FontWeight.bold,
           ) ,),
          centerTitle: false,
          backgroundColor: Color(0xFF2f3542),///2E2E2E
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(35.0),
            child: Theme(
              data: Theme.of(context).copyWith(accentColor: Colors.red),
              child: Row(  children:<Widget>[
              Expanded(
                child: TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(15),
                    ],
                  maxLines: 1,
                 textAlign: TextAlign.center,
                //  textCapitalization: TextCapitalization.words,
                  controller: _searchQueryController,
                  decoration: InputDecoration(
                    hintText: "  أسم الموقع",
                    hintStyle: TextStyle(color: Color(0xFFeccc68)),
                   contentPadding: EdgeInsets.fromLTRB(80, 0.0, 5.0, 0.0),
                      prefixIcon: Icon(Icons.search,color: Color(0xFFeccc68),),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0,color: Colors.lightBlue)
                  ),
                    border :
                    OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.
                      elliptical(10.5,10.5)),
                     ),
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                  onTap: ()  => search(_searchQueryController.text),
                  onChanged: search1(_searchQueryController.text) ,
                  onSubmitted: (_searchQueryController){
                   search(_searchQueryController);
                  },


                  ),
                ),
                IconButton(
                  icon: Icon(Icons.restore),
                  color: Colors.greenAccent,
                  onPressed: () =>
                      Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) =>
                          ListView1())).then((onValue){

                      }),
                )
             ]),
              ),
            ),

          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.save, color: Colors.greenAccent,
                  textDirection: TextDirection.ltr,),
                onPressed: () async {
                  CreateFile file = new CreateFile();
                  radioSelect selected = radioSelect.database;

                  return showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Column(
                            children: <Widget>[
                              new Expanded (
                                child: new TextField(
                                  controller: _fileName,
                                  autofocus: true,
                                  decoration: new InputDecoration(
                                      icon: Icon(Icons.file_upload),
                                      hintStyle: TextStyle(fontSize: 10.0),
                                      hintText: 'أسم الملف'),
                                ),
                              ),
                              Text('تصدير الى ذاكرةالهاتف كـ',
                                textDirection: TextDirection.rtl,),
                              Row(mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text("database" + "ملف"),
                                    Radio(
                                      value: radioSelect.database,
                                      groupValue: selected,
                                      onChanged: (radioSelect value) {
                                        setState(() {
                                          selected = value;
                                        });
                                      },
                                    ),

                                  ]),

                              Row(mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text("CSV" + "ملف"),
                                    Radio(
                                      value: radioSelect.CSV,
                                      groupValue: selected,
                                      onChanged: (radioSelect value) {
                                        setState(() {
                                          selected = value;
                                        });
                                      },
                                    ),
                                  ]),
                              Row(mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                        Text("text"+ "ملف"),
                            Radio(
                              activeColor: Colors.blue,
                          value: radioSelect.text,
                              groupValue: selected,
                          onChanged: (radioSelect value) {
                            setState(() {
                              selected = value;
                            });
                          },
                        ),
                                  ]),


                            ],
                          );

                        }),

                        actions: <Widget>[
                          FlatButton(
                            child: Text("  متأكد ؟ "),
                            onPressed: () async  {

                              if (_fileName.text == "") {
                                  Toast.show(
                                  "سمي الملف !!"
                                  , context, border: Border.all(width: 5),
                                  textColor: Colors.black,
                                  backgroundColor: Colors.white,
                                  duration: 5,
                                  gravity: Toast.BOTTOM);
                                  }
                              else{
                               switch(selected) {
                                 case radioSelect.database:
                                    { await db.backup(_fileName.text);
                                    } break;
                                 case radioSelect.CSV:
                                    { await file.saveAsCsvFile(_fileName.text+".csv", myData);}
                                    break;
                                 case radioSelect.text:
                                    {await file.saveAsTextFile(_fileName.text+".txt", myData);}
                                    break;
                                }
                              }
                               pr.show();
                              Future.delayed(Duration(seconds: 1)).then((onValue){
                                pr.hide().whenComplete((){
                                  Navigator.pop(context);
                                });
                              });
                              Toast.show(
                                  "/storage/emulated/0/Android/data/com.tabarak.accounts/files/account/${_fileName
                                      .text}"
                                  , context, border: Border(),
                                  textColor: Colors.black,
                                  backgroundColor: Colors.white,
                                  duration: 10,
                                  gravity: Toast.BOTTOM);
                            }
                          ),
                          new FlatButton(
                              child: const Text('خروج'),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ],
                      );
                    },
                  );
                }
            ),
            IconButton(
              icon: Icon(Icons.delete_forever, color: Colors.red,
                textDirection: TextDirection.ltr,),

              onPressed: () {
                return showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("سيحذف جميع البيانات"
                                " و يخرج من التطبيق، هل أنت متأكد ؟",softWrap: true,)
                          ,
                          shape:RoundedRectangleBorder
                          ( side: BorderSide(color:Colors.black,width: 1.5),
                          borderRadius: BorderRadius.all( Radius.circular(10.5))
                          ),
                          content:
                          new Container(
                              child: Icon(Icons.delete_forever
                           ,size: 40, ),
                          ),
                          actions: <Widget>[
                          new FlatButton(
                          child: const Text('ألغاء'),
                          onPressed: () {
                          Navigator.pop(context);
                          }),
                          new FlatButton(
                          child: const Text('تأكيد'),
                          onPressed: () {
                          this.drop();
                          }),
                          ],
                          );
                          },);
                }

            ),
            IconButton(
                icon: Icon(Icons.attach_file, color: Colors.greenAccent,
                  textDirection: TextDirection.ltr,),
                onPressed: () async {
                  pr.show();
                  Future.sync(getExFile).then((value) {
                    pr.hide().whenComplete(() {
                      if (errorF != "") {
                        Toast.show(errorF, context, border: Border(),
                            textColor: Colors.black,
                            backgroundColor: Colors.pinkAccent,
                            duration: 10,
                            gravity: Toast.BOTTOM);
                        errorF = "";
                      }
                    });
                  });
                }),

          ],
        ),

        body: Center(

          child:
          ListView.builder(

              itemCount: myData.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, i) {
                return Column(
                  children: <Widget>[
                    Divider(height: 5.0,),
                    Row(
                      children: <Widget>[

                        new Expanded(
                          child: Card(
                            color: Color(0XFFf7f1e3),///ffcccc
                            shape:
                            RoundedRectangleBorder(
                                borderRadius: BorderRadiusDirectional.circular(
                                    20.3)),
                            child: ListTile(
                              title: Text('${myData[i].webNames}',
                                style: TextStyle(
                                    fontSize: 24.0, color: Color(0xFF596275)
                                ),
                                //  textDirection: TextDirection.rtl,
                              ),
                              subtitle: Text(' ${myData[i].emails}',
                                style: TextStyle(
                                  fontSize: 16.0, color: Color(0xFFcd6133),
                                  fontStyle: FontStyle.italic,
                                ),
                                //   textDirection: TextDirection.rtl,
                              ),
                              onTap: () => _navigateToInfo(context, myData[i]),
                              onLongPress: () =>
                                  _neverSatisfied(context, myData[i], i),
                            ),
                          ),
                        ),
//                    IconButton(
//                    icon: const Icon(Icons.delete, color: Colors.redAccent,),
//                    onPressed: () => _deleteItem(context, myData[i], i)
//                    )
                      ],
                    )

                  ],

                );
              }


          ),
        ),
        floatingActionButton: FloatingActionButton(

          materialTapTargetSize: MaterialTapTargetSize.padded,
          backgroundColor: Colors.white70,
          child: Icon(Icons.add, color: Colors.black),
          onPressed: () => _insertItems(),


        ),

      ),
    );
  }


    ///deleteAlert
  Future<void> _neverSatisfied(context,Model model, int i) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return
          AlertDialog(
            shape:RoundedRectangleBorder
              ( side: BorderSide(color:Colors.blueAccent,),
                borderRadius: BorderRadius.all( Radius.circular(10.5))
            ),

            contentPadding: EdgeInsets.fromLTRB(0 , 0, 20, 0),
            title: Text('حذف الحقل رقم $i'
                '، هل أنت متأكد ؟',
              style: TextStyle(fontSize: 14,),
              textAlign: TextAlign.right,),
            // TextDirection.rtl,
            content: Row(
              children: <Widget>[

                IconButton(
                  icon: Icon(Icons.delete_forever,color: Colors.redAccent) ,
                  onPressed: () {
                    _deleteItem(context, model, i);
                  },
                ),

                IconButton(
                  icon: Icon(Icons.cancel,color: Colors.greenAccent,
                    textDirection: TextDirection.ltr,) ,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),

              ],

            ),

          );
      },
    );
  }
  ///DeleteItems
  _deleteItem(BuildContext context,Model model, int i){


    db.delete(model.id).then((action){
      db.retrieveN().then((information) {
        setState(() {
          myData.clear();
          information.forEach((info) {
            myData.add(Model.map(info));
          });
        });
      });

      Navigator.pop(context);


    });

  }


  ///insertAlert

  Future<void> _insertItems() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return
          AlertDialog(
            contentPadding: const EdgeInsets.all(5.7),
            shape:RoundedRectangleBorder
              ( side: BorderSide(color:Colors.black,width: 1.5),
                borderRadius: BorderRadius.all( Radius.circular(10.5))
            ),
            content: new Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                    controller: _uerName,
                    autofocus: true,
                    decoration: new InputDecoration(
                        icon: Icon(Icons.web),
                        hintText: 'أسم الموقع أو التطبيق'),
                  ),
                ),
                new Expanded(
                  child: new TextField(
                    controller: _email,
                    autofocus: true,
                    decoration: new InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'البريد الألكتروني'),
                  ),
                ),
                new Expanded(
                  child: new TextField(
                    controller: _passward,
                    autofocus: true,
                    decoration: new InputDecoration(
                        icon: Icon(Icons.stars),
                        hintText: 'الرقم السري'),
                  ),
                )
              ],
            ),

            actions: <Widget>[
              new FlatButton(
                  child: const Text('خروج'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('حفظ'),
                  onPressed: () {
                    Model info = new
                    Model(_uerName.text,_email.text,_passward.text);
                    saveInsert(info);
                  })
            ],
          );

      },
    );
  }



  ///insertItems
  Future saveInsert(Model model)async{

///
  await db.saveNT(model).then(
            (action) {

              db.retrieveN().then((information) {
            setState(() {
              myData.clear();
              information.forEach((info) {
                myData.add(Model.map(info));
              });
            });
          });
          Navigator.pop(context);
        }
    );




  }



  ///showAndEdit
  _navigateToInfo(context, Model model) async {

    await Navigator.push(
      context,MaterialPageRoute(builder: (context) => AllOInfo(model)),
    );

  }

///save imported file to local app database
  Future<bool> BackupInsert() async{

  int i = 0;
  int length = myDataBack.length;
  while(i < length) {
   Model object = new
   Model(myDataBack[i].gName, myDataBack[i].gEmail, myDataBack[i].gPassword);
   await db.saveNT(object);
   i++;
 }
 myDataBack.clear();
          db.retrieveN().then((information) {
            setState(() {
              myData.clear();
              information.forEach((info) {
                myData.add(Model.map(info));
              });
            });
          });
        }


  void drop() async{
  await db.drop().then(
            (action) {
              myData.clear();
              SystemNavigator.pop();
            }
    );
  }


}

















