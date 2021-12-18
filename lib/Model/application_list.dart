class ApplicationList {
  ApplicationList({
      this.message, 
      this.status, 
      this.data,
      this.typeWiseData,
      this.types
  });

  ApplicationList.fromJson(dynamic json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      types = [];
      typeWiseData={};
      json['data'].forEach((v) {
        ApplicationData aList = ApplicationData.fromJson(v);
        data?.add(aList);
        if(typeWiseData!.containsKey(v['application_type_name'])) {
          List<ApplicationData>? tData=typeWiseData![v['application_type_name']];
          tData!.add(aList);
          typeWiseData![v['application_type_name']]=tData;
        } else {
          types!.add(v['application_type_name']);
          typeWiseData![v['application_type_name']]=[aList];
        }
      });
    }
  }
  String? message;
  int? status;
  Map<String,List<ApplicationData>>? typeWiseData;
  List<ApplicationData>? data;
  List<String>? types;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ApplicationData {
  ApplicationData({
      this.id, 
      this.applicantName, 
      this.weblink, 
      this.linkType, 
      this.linkTypeName, 
      this.packageName, 
      this.applicationType, 
      this.applicationTypeName, 
      this.paymentType, 
      this.paymentTypeName, 
      this.serveType, 
      this.serviceTypeName, 
      this.logoImg, 
      this.introduction, 
      this.createdBy, 
      this.createdUserName, 
      this.createdAt,});

  ApplicationData.fromJson(dynamic json) {
    id = json['id'];
    applicantName = json['applicant_name'];
    weblink = json['weblink'];
    linkType = json['link_type'];
    linkTypeName = json['link_type_name'];
    packageName = json['package_name'];
    applicationType = json['application_type'];
    applicationTypeName = json['application_type_name'];
    paymentType = json['payment_type'];
    paymentTypeName = json['payment_type_name'];
    serveType = json['serve_type'];
    serviceTypeName = json['service_type_name'];
    logoImg = json['logo_img'];
    introduction = json['introduction'];
    createdBy = json['created_by'];
    createdUserName = json['created_user_name'];
    createdAt = json['created_at'];
  }
  int? id;
  String? applicantName;
  String? weblink;
  String? linkType;
  String? linkTypeName;
  String? packageName;
  String? applicationType;
  String? applicationTypeName;
  String? paymentType;
  String? paymentTypeName;
  String? serveType;
  String? serviceTypeName;
  String? logoImg;
  String? introduction;
  String? createdBy;
  String? createdUserName;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['applicant_name'] = applicantName;
    map['weblink'] = weblink;
    map['link_type'] = linkType;
    map['link_type_name'] = linkTypeName;
    map['package_name'] = packageName;
    map['application_type'] = applicationType;
    map['application_type_name'] = applicationTypeName;
    map['payment_type'] = paymentType;
    map['payment_type_name'] = paymentTypeName;
    map['serve_type'] = serveType;
    map['service_type_name'] = serviceTypeName;
    map['logo_img'] = logoImg;
    map['introduction'] = introduction;
    map['created_by'] = createdBy;
    map['created_user_name'] = createdUserName;
    map['created_at'] = createdAt;
    return map;
  }

}