

import 'package:elabd_project/models/designers_model.dart';

class ProjectModel{

  String? projectId;
  String? title;
  String? description;
  String? status;
  String? budget;
  String? startDate;
  String? endDate;
  DesignersModel? designersModel;

  ProjectModel(
    {
      this.title,this.description,this.status, this.budget, this.startDate, this.endDate, this.projectId,this.designersModel
    }
  );

  factory ProjectModel.fromJson(map) {
    return ProjectModel(
        designersModel: DesignersModel.fromJson(map['designer']),
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        status: map['status'] ?? '',
        budget: map['budget']?? '',
        startDate: map['startDate'] ?? '', 
        endDate: map['endDate'],
        projectId: map['projectId'] ?? '');
        
  }
  toFirebase() {
    return {
      "projectId": projectId,
      "title": title,
      "description": description,
      "status": status,
      "budget": budget,
      "startDate": startDate,
      "endDate": endDate,
      "designer": designersModel!.toFirebase(),
    };
  }
}

