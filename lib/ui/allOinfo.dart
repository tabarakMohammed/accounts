
import 'package:flutter/material.dart';
import 'package:accounts/infoModel/Model.dart';
import 'package:accounts/DataProvider/DataBasepro.dart';
import 'package:accounts/ui/home.dart';


class AllOInfo extends StatefulWidget {

  final Model model;
  AllOInfo(this.model);

  @override
  State<StatefulWidget> createState() => new _AllOInfo();
}

class _AllOInfo extends State<AllOInfo> {

  SqlLight db = new SqlLight();

  TextEditingController _uerName = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _passward = new TextEditingController();

  Map<String, dynamic> myinfo = {
    'names':'',
    'email':'',
    'passward' : "",
  };

  bool itsWorked = false;
  bool itsWorked1 = true;

  void set() {

    setState(() {
      itsWorked = true;
      itsWorked1 = false;
      myinfo['names'] = widget.model.webNames;
      myinfo['email'] = widget.model.emails;
      myinfo['passward'] = widget.model.passwordApps;
    });



  }





  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        backgroundColor:Color(0xFF2f3542),/***/
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, color: Color(0xFFeccc68),
                  textDirection: TextDirection.rtl,)),

          ],
          title: Text("حساباتي",textAlign: TextAlign.right,
              style:TextStyle(
              color: Color(0xFFeccc68),
              fontSize: 18,
              fontWeight: FontWeight.bold,)),

          backgroundColor: Color(0xFF2f3542),
        ),
        body: ListView(children: <Widget>[


          Container(


              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              alignment: Alignment.center,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,

                children: <Widget>[
                  Card(
                      color: Color(0XFFf7f1e3),
                      child:
                      new Text(' ${widget.model.webNames} ',
                        style: TextStyle(
                            fontSize: 30.7, color: Color(0xFF2d3436)
                        ),
                      )
                  ),

                  Card(
                      color: Color(0XFFf7f1e3),
                      child:
                      new Text(' ${widget.model.emails} ',
                        style: TextStyle(
                            fontSize: 30.7, color: Color(0xFF2d3436)
                        ),
                      )
                  ),

                  Card(
                      color: Color(0XFFf7f1e3),
                      child:
                      new Text(' ${widget.model.passwordApps} ',
                        style: TextStyle(
                            fontSize: 30.7, color: Color(0xFF2d3436)
                        ),
                      )
                  ),




                  Container(


                    padding: EdgeInsets.only(left: 50, right: 50, top: 50),
                    alignment: Alignment.center,


                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: <Widget>[

                        TextField(
                          textAlign: TextAlign.right,
                          enabled: itsWorked,
                          controller: _uerName,
                          style: TextStyle( color: Color(0XFFf7f1e3)),
                          decoration: new InputDecoration(
                            icon: Icon(Icons.apps,size: 20.5,color:Color(0XFFfdcb6e) ,),
                            hintText:  'أسم الموقع' ,
                            hintStyle: TextStyle(fontSize: 19.0, color:Color(0XFFfdcb6e)),
                            contentPadding: EdgeInsets.all(10),
                          ),

                        ),


                        TextField(
                          enabled: itsWorked,
                          controller: _email,
                          style: TextStyle( color: Color(0XFFf7f1e3)),
                          textAlign: TextAlign.right,

                          decoration: new InputDecoration(
                            icon: Icon(Icons.email,size: 20.5,color:Color(0XFFfdcb6e)),
                            hintText: 'بريد ألكتروني',
                            hintStyle: TextStyle(fontSize: 19.0, color:Color(0XFFfdcb6e)),
                            contentPadding: EdgeInsets.all(10),

                          ),
                        ),

                        TextField(
                          enabled: itsWorked,
                          controller: _passward,
                          style: TextStyle( color: Color(0XFFf7f1e3)),
                          textAlign: TextAlign.right,

                          decoration: new InputDecoration(
                            icon: Icon(Icons.stars,size: 20.5,color:Color(0XFFfdcb6e)),
                            hintText: 'رقم سري',
                            hintStyle: TextStyle(fontSize: 19.0, color:Color(0XFFfdcb6e)),
                            contentPadding: EdgeInsets.all(10),

                          ),
                        ),


                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child:
                          Row(
                            verticalDirection: VerticalDirection.down,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: <Widget>[

                              OutlinedButton.icon(
                                onPressed: itsWorked ? upDate : null,
                                icon: Icon(Icons.system_update),

                               // highlightColor:  Colors.red,
                               // textColor:Color(0XFFe17055) ,
                                label: Text("حفظ" , style:TextStyle(color: Color(0XFFe17055)) ),
                              ),

                              OutlinedButton.icon(icon: Icon(Icons.edit),
                              //  textColor: Colors.yellow,
                               // highlightColor:  Colors.yellow,
                                onPressed: itsWorked1 ? set : null ,

                                label: Text("تعديل", style:TextStyle(color: Colors.yellow)),

                              ),

                              OutlinedButton.icon(

                             //   highlightColor:  Colors.white,
                             //   textColor: Colors.white,
                                  icon: Icon(Icons.restore),
                                  onPressed: setInfoBox,
                                label: Text('أستعادة',
                                  style: TextStyle(fontStyle: FontStyle.italic,color: Colors.white),),
                              )

                            ],
                          ),

                        ),








                      ],
                    ),


                  ),
                ],


              )

          ),

        ]

        ),


      ),
    );
  }


  upDate(){
    db.upDate(Model(_uerName.text,_email.text,_passward.text),widget.model.id)
        .then((action){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ListView1()),
      );
    });
  }

   void setInfoBox(){
    _uerName.text = myinfo['names'];
    _email.text = myinfo['email'];
    _passward.text = myinfo['passward'];
  }
}





