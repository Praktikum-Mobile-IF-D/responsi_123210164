class JobData {
  String? apiVersion;
  String? documentationUrl;
  String? friendlyNotice;
  int? jobCount;
  String? xRayHash;
  String? clientKey;
  String? lastUpdate;
  List<Jobs>? jobs;
  JobData(
      {this.apiVersion,
        this.documentationUrl,
        this.friendlyNotice,
        this.jobCount,
        this.xRayHash,
        this.clientKey,
        this.lastUpdate,
        this.jobs});
  JobData.fromJson(Map<String, dynamic> json) {
    apiVersion = json['apiVersion'];
    documentationUrl = json['documentationUrl'];
    friendlyNotice = json['friendlyNotice'];
    jobCount = json['jobCount'];
    xRayHash = json['xRayHash'];
    clientKey = json['clientKey'];
    lastUpdate = json['lastUpdate'];
    if (json['jobs'] != null) {
      jobs = <Jobs>[];
      json['jobs'].forEach((v) {
        jobs!.add(new Jobs.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiVersion'] = this.apiVersion;
    data['documentationUrl'] = this.documentationUrl;
    data['friendlyNotice'] = this.friendlyNotice;
    data['jobCount'] = this.jobCount;
    data['xRayHash'] = this.xRayHash;
    data['clientKey'] = this.clientKey;
    data['lastUpdate'] = this.lastUpdate;
    if (this.jobs != null) {
      data['jobs'] = this.jobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Jobs {
  int? id;
  String? url;
  String? jobSlug;
  String? jobTitle;
  String? companyName;
  String? companyLogo;
  List<String>? jobIndustry;
  List<String>? jobType;
  String? jobGeo;
  String? jobLevel;
  String? jobExcerpt;
  String? jobDescription;
  String? pubDate;
  String? annualSalaryMin;
  String? annualSalaryMax;
  String? salaryCurrency;
  Jobs(
      {this.id,
        this.url,
        this.jobSlug,
        this.jobTitle,
        this.companyName,
        this.companyLogo,
        this.jobIndustry,
        this.jobType,
        this.jobGeo,
        this.jobLevel,
        this.jobExcerpt,
        this.jobDescription,
        this.pubDate,
        this.annualSalaryMin,
        this.annualSalaryMax,
        this.salaryCurrency});
  Jobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    jobSlug = json['jobSlug'];
    jobTitle = json['jobTitle'];
    companyName = json['companyName'];
    companyLogo = json['companyLogo'];
    jobIndustry = json['jobIndustry'].cast<String>();
    jobType = json['jobType'].cast<String>();
    jobGeo = json['jobGeo'];
    jobLevel = json['jobLevel'];
    jobExcerpt = json['jobExcerpt'];
    jobDescription = json['jobDescription'];
    pubDate = json['pubDate'];
    annualSalaryMin = json['annualSalaryMin'];
    annualSalaryMax = json['annualSalaryMax'];
    salaryCurrency = json['salaryCurrency'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['jobSlug'] = this.jobSlug;
    data['jobTitle'] = this.jobTitle;
    data['companyName'] = this.companyName;
    data['companyLogo'] = this.companyLogo;
    data['jobIndustry'] = this.jobIndustry;
    data['jobType'] = this.jobType;
    data['jobGeo'] = this.jobGeo;
    data['jobLevel'] = this.jobLevel;
    data['jobExcerpt'] = this.jobExcerpt;
    data['jobDescription'] = this.jobDescription;
    data['pubDate'] = this.pubDate;
    data['annualSalaryMin'] = this.annualSalaryMin;
    data['annualSalaryMax'] = this.annualSalaryMax;
    data['salaryCurrency'] = this.salaryCurrency;
    return data;
  }
}