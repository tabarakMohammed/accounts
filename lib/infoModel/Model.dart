class Model {


  int? id ;
  String? webNames;
  String? emails;
  String? passwordApps;

  Model(this.webNames,this.emails,this.passwordApps);

  Model.map(dynamic obj){
    this.id = obj['id'];
    this.webNames = obj['webName'];
    this.emails = obj['Email'];
    this.passwordApps = obj['passward'];

  }


  int?     get gId       => id;
  String?  get gName     => webNames;
  String?  get gEmail    => emails;
  String?  get gPassword => passwordApps;

  Map<String,dynamic> toMap(){
    var object = new Map<String , dynamic>();

    if( id != null){
      object['id'] = id;
    }

    object['webName'] =  webNames ;
    object['Email'] = emails ;
    object['passward']= passwordApps;


    return object;
  }

}