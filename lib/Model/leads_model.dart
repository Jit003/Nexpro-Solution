class LeadsModel {
  List<Leads>? leads;

  LeadsModel({this.leads});

  LeadsModel.fromJson(Map<String, dynamic> json) {
    if (json['leads'] != null) {
      leads = <Leads>[];
      json['leads'].forEach((v) {
        leads!.add(new Leads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leads != null) {
      data['leads'] = this.leads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Leads {
  int? id;
  String? name;
  String? companyName;
  String? email;
  String? service;
  String? projectDetails;
  String? createdAt;
  String? updatedAt;

  Leads(
      {this.id,
        this.name,
        this.companyName,
        this.email,
        this.service,
        this.projectDetails,
        this.createdAt,
        this.updatedAt});

  Leads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    companyName = json['company_name'];
    email = json['email'];
    service = json['service'];
    projectDetails = json['project_details'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['company_name'] = this.companyName;
    data['email'] = this.email;
    data['service'] = this.service;
    data['project_details'] = this.projectDetails;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}