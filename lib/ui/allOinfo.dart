
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
        backgroundColor:Color(0xFFFFcd84f1),
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, color: Colors.purple,
                  textDirection: TextDirection.rtl,)),

          ],
          title: Text("حساباتي"),
          centerTitle: true,
          backgroundColor: Color(0xFF2c2c54),
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
                            fontSize: 30.7, color: Color(0xFF596275)
                        ),
                      )
                  ),

                  Card(
                      color: Color(0XFFf7f1e3),
                      child:
                      new Text(' ${widget.model.emails} ',
                        style: TextStyle(
                            fontSize: 30.7, color: Color(0xFF596275)
                        ),
                      )
                  ),

                  Card(
                      color: Color(0XFFf7f1e3),
                      child:
                      new Text(' ${widget.model.passwordApps} ',
                        style: TextStyle(
                            fontSize: 30.7, color: Color(0xFF596275)
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
                          enabled: itsWorked,
                          controller: _uerName,
                          decoration: new InputDecoration(
                            icon: Icon(Icons.apps,size: 20.5),
                            hintText: 'أسم الموقع',
                            contentPadding: EdgeInsets.all(10),
                          ),

                        ),


                        TextField(
                          enabled: itsWorked,
                          controller: _email,
                          decoration: new InputDecoration(
                            icon: Icon(Icons.email,size: 20.5),
                            hintText: 'بريد ألكتروني',
                            contentPadding: EdgeInsets.all(10),

                          ),
                        ),

                        TextField(
                          enabled: itsWorked,
                          controller: _passward,
                          decoration: new InputDecoration(
                            icon: Icon(Icons.stars,size: 20.5,),
                            hintText: 'رقم سري',
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

                              OutlineButton.icon(
                                onPressed: itsWorked ? upDate : null,
                                icon: Icon(Icons.system_update),
                                highlightColor:  Colors.red,
                                textColor: Colors.red,
                                label: Text("حفظ"),
                              ),

                              OutlineButton.icon(icon: Icon(Icons.edit),
                                textColor: Colors.yellow,
                                highlightColor:  Colors.yellow,
                                onPressed: itsWorked1 ? set : null,
                                label: Text("تعديل"),

                              ),

                              OutlineButton.icon(

                                highlightColor:  Colors.white,
                                textColor: Colors.white,
                                  icon: Icon(Icons.restore),
                                  onPressed: () {
                                    _uerName.text = myinfo['names'];
                                    _email.text = myinfo['email'];
                                    _passward.text = myinfo['passward'];
                                  },
                                label: Text('أستعادة',
                                  style: TextStyle(fontStyle: FontStyle.italic),),
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


}





