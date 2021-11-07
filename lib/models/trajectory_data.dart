import 'dart:convert';

data_trajectory sendAbsenFromJson(String str) => data_trajectory.fromJson(json.decode(str));
String sendAbsenToJson(data_trajectory data) => json.encode(data.toJson());

class data_trajectory {
  String dESCRIPTION;
  String nAME;
  String lONG;
  String lAT;
  String aDDRESS;
  String cOMPANY;
  String uNIT;
  String sTATUS;
  String lOCALIMAGE;
  int mSGTYPE;
  int cMDTYPE;
  String tIMESTAMP;
  String iMAGE;
  String gUID;
  String rEPORTTYPE;
  List<MAPBOUNDARIES> mAPBOUNDARIES;

  data_trajectory({
    this.dESCRIPTION,
    this.nAME,
    this.lONG,
    this.lAT,
    this.aDDRESS,
    this.cOMPANY,
    this.uNIT,
    this.sTATUS,
    this.lOCALIMAGE,
    this.mSGTYPE,
    this.cMDTYPE,
    this.tIMESTAMP,
    this.iMAGE,
    this.gUID,
    this.rEPORTTYPE,
    this.mAPBOUNDARIES,
  });

  data_trajectory.fromJson(Map<String, dynamic> json){
    dESCRIPTION: json['DESCRIPTION'];
    nAME: json['NAME'];
    lONG: json['LONG'];
    lAT: json['LAT'];
    aDDRESS: json['ADDRESS'];
    cOMPANY: json['COMPANY'];
    uNIT: json['UNIT'];
    sTATUS: json['STATUS'];
    lOCALIMAGE: json['LOCAL_IMAGE'];
    mSGTYPE: json['MSGTYPE'];
    cMDTYPE: json['CMDTYPE'];
    tIMESTAMP: json['TIMESTAMP'];
    iMAGE: json['IMAGE'];
    gUID: json['GUID'];
    rEPORTTYPE: json['REPORT_TYPE'];
    if(json['MAP_BOUNDARIES']!=null){
      json['MAP_BOUNDARIES'].forEach((v){
        mAPBOUNDARIES.add(new MAPBOUNDARIES.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DESCRIPTION'] = this.dESCRIPTION;
    data['NAME'] = this.nAME;
    data['LONG'] = this.lONG;
    data['LAT'] = this.lAT;
    data['ADDRESS'] = this.aDDRESS;
    data['COMPANY'] = this.cOMPANY;
    data['UNIT'] = this.uNIT;
    data['STATUS'] = this.sTATUS;
    data['LOCAL_IMAGE'] = this.lOCALIMAGE;
    data['MSG_TYPE'] = this.mSGTYPE;
    data['CMD_TYPE'] = this.cMDTYPE;
    data['TIMESTAMP'] = this.tIMESTAMP;
    data['IMAGE'] = this.iMAGE;
    data['GUID'] = this.gUID;
    data['REPORT_TYPE'] = this.rEPORTTYPE;
    if (this.mAPBOUNDARIES != null) {
      data['MAP_BOUNDARIES'] =
          this.mAPBOUNDARIES.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MAPBOUNDARIES {
  double lat;
  double lng;

  MAPBOUNDARIES({this.lat, this.lng});

  MAPBOUNDARIES.fromJson(Map<String, dynamic> json){
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}