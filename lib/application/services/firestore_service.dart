import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecowise_planner/domain/model/company_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/model/project_model.dart';
import '../../domain/model/task_model.dart';
import '../../domain/model/user_model.dart';

class FirestoreService {
  final CollectionReference _companies =
      FirebaseFirestore.instance.collection('companies');

  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  // Create a new company
  Future<void> addCompany({required Company company}) async {
    try {
      await _companies.doc(company.companyID).set({
        'companyID': company.companyID,
        'name': company.name,
        'employees': company.employees,
        'projects': company.projects,
      });
    } catch (e) {
      rethrow;
    }
  }

  // Get company
  Future<Company> getCompany({required String companyID}) async {
    try {
      final company = await _companies.doc(companyID).get();
      return Company(
        companyID: company['companyID'],
        name: company['name'],
        employees: company['employees'],
        projects: company['projects'],
      );
    } catch (e) {
      rethrow;
    }
  }

  // Update Company
  Future<void> updateCompany({required Company company}) async {
    try {
      await _companies.doc(company.companyID).update({
        'companyID': company.companyID,
        'name': company.name,
        'employees': company.employees,
        'projects': company.projects,
      });
    } catch (e) {
      rethrow;
    }
  }

  // Delete Company
  Future<void> deleteCompany({required String companyID}) async {
    try {
      await _companies.doc(companyID).delete();
    } catch (e) {
      rethrow;
    }
  }

  // Create a user
  Future<void> addUser({required UserModel user}) async {
    try {
      await _users.doc(user.userID).set({
        'userID': FirebaseAuth.instance.currentUser!.uid,
        'companyID': user.companyID,
        'firstName': user.firstName,
        'surname': user.surname,
        'email': user.email,
      });
    } catch (e) {
      rethrow;
    }
  }

  // Get a user
  Future<UserModel> getUser({required String userID}) async {
    try {
      final user = await _users.doc(userID).get();
      return UserModel(
        userID: user['userID'],
        companyID: user['companyID'],
        firstName: user['firstName'],
        surname: user['surname'],
        email: user['email'],
      );
    } catch (e) {
      rethrow;
    }
  }

  // Get users
  Future<List<UserModel>> getUsers({required String companyID}) async {
    try {
      final users = await _companies.doc(companyID).collection(companyID).get();
      return users.docs
          .map((user) => UserModel(
                userID: user['userID'],
                companyID: user['companyID'],
                firstName: user['firstName'],
                surname: user['surname'],
                email: user['email'],
              ))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  // Update user
  Future<void> updateUser({required UserModel user}) async {
    try {
      await _users.doc(user.userID).update({
        'userID': user.userID,
        'companyID': user.companyID,
        'firstName': user.firstName,
        'surname': user.surname,
        'email': user.email,
      });
    } catch (e) {
      rethrow;
    }
  }

  // Delete user
  Future<void> deleteUser({required String userID}) async {
    try {
      await _companies.doc(userID).delete();
    } catch (e) {
      rethrow;
    }
  }

  // Get companyID from userID
  Future<String> getCompanyID({required String userID}) async {
    try {
      final user = await _users.doc(userID).get();
      return user['companyID'];
    } catch (e) {
      rethrow;
    }
  }

  // Create a project
  Future<void> addProject({required Project project}) async {
    try {
      await _companies
          .doc(project.companyID)
          .collection('projects')
          .doc(project.projectID)
          .set({
        'projectID': project.projectID,
        'companyID': project.companyID,
        'projectTitle': project.projectTitle,
        'projectDescription': project.projectDescription,
        'projectAddress1': project.projectAddress1,
        'projectCity': project.projectCity,
        'projectState': project.projectState,
        'projectPostCode': project.projectPostCode,
        'projectStatus': project.projectStatus,
        'projectDueDate': project.projectDueDate,
        'projectCreatedDate': project.projectCreatedDate,
        'primaryClientName': project.primaryClientName,
        'primaryClientEmail': project.primaryClientEmail,
        'primaryClientPhone': project.primaryClientPhone,
        'secondaryClientName': project.secondaryClientName,
        'secondaryClientEmail': project.secondaryClientEmail,
        'secondaryClientPhone': project.secondaryClientPhone,
        'projectNotes': project.projectNotes,
        'tasks': project.tasks,
        'labourCosts': project.labourCosts,
        'materialCosts': project.materialCosts,
        'totalCosts': project.totalCosts,
      });
    } catch (e) {
      rethrow;
    }
  }

  // Get a project
  Future<Project> getProject(
      {required String companyID, required String projectID}) async {
    try {
      final project = await _companies
          .doc(companyID)
          .collection('projects')
          .doc(projectID)
          .get();
      return Project(
        projectID: project['projectID'],
        companyID: project['companyID'],
        projectTitle: project['projectTitle'],
        projectDescription: project['projectDescription'],
        projectAddress1: project['projectAddress1'],
        projectCity: project['projectCity'],
        projectState: project['projectState'],
        projectPostCode: project['projectPostCode'],
        projectStatus: project['projectStatus'],
        projectDueDate: project['projectDueDate'],
        projectCreatedDate: project['projectCreatedDate'],
        primaryClientName: project['primaryClientName'],
        primaryClientEmail: project['primaryClientEmail'],
        primaryClientPhone: project['primaryClientPhone'],
        secondaryClientName: project['secondaryClientName'],
        secondaryClientEmail: project['secondaryClientEmail'],
        secondaryClientPhone: project['secondaryClientPhone'],
        projectNotes: project['projectNotes'],
        tasks: project['tasks'],
        labourCosts: project['labourCosts'],
        materialCosts: project['materialCosts'],
        totalCosts: project['totalCosts'],
      );
    } catch (e) {
      rethrow;
    }
  }

  // Get projects
  Future<List<Project>> getProjects({required String userID}) async {
    try {
      final companyID = await getCompanyID(userID: userID);
      final projects =
          await _companies.doc(companyID).collection('projects').get();
      return projects.docs
          .map((project) => Project(
                projectID: project['projectID'],
                companyID: project['companyID'],
                projectTitle: project['projectTitle'],
                projectDescription: project['projectDescription'],
                projectAddress1: project['projectAddress1'],
                projectCity: project['projectCity'],
                projectState: project['projectState'],
                projectPostCode: project['projectPostCode'],
                projectStatus: project['projectStatus'],
                projectDueDate: project['projectDueDate'],
                projectCreatedDate: project['projectCreatedDate'],
                primaryClientName: project['primaryClientName'],
                primaryClientEmail: project['primaryClientEmail'],
                primaryClientPhone: project['primaryClientPhone'],
                secondaryClientName: project['secondaryClientName'],
                secondaryClientEmail: project['secondaryClientEmail'],
                secondaryClientPhone: project['secondaryClientPhone'],
                projectNotes: project['projectNotes'],
                tasks: project['tasks'],
                labourCosts: project['labourCosts'],
                materialCosts: project['materialCosts'],
                totalCosts: project['totalCosts'],
              ))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  // Update project
  Future<void> updateProject({required Project project}) async {
    try {
      await _companies
          .doc(project.companyID)
          .collection('projects')
          .doc(project.projectID)
          .update({
        'projectID': project.projectID,
        'companyID': project.companyID,
        'projectTitle': project.projectTitle,
        'projectAddress1': project.projectAddress1,
        'projectCity': project.projectCity,
        'projectState': project.projectState,
        'projectPostCode': project.projectPostCode,
        'projectDescription': project.projectDescription,
        'projectStatus': project.projectStatus,
        'projectDueDate': project.projectDueDate,
        'projectCreatedDate': project.projectCreatedDate,
        'primaryClientName': project.primaryClientName,
        'primaryClientEmail': project.primaryClientEmail,
        'primaryClientPhone': project.primaryClientPhone,
        'secondaryClientName': project.secondaryClientName,
        'secondaryClientEmail': project.secondaryClientEmail,
        'secondaryClientPhone': project.secondaryClientPhone,
        'projectNotes': project.projectNotes,
        'tasks': project.tasks,
        'labourCosts': project.labourCosts,
        'materialCosts': project.materialCosts,
        'totalCosts': project.totalCosts,
      });
    } catch (e) {
      rethrow;
    }
  }

  // Delete project
  Future<void> deleteProject(
      {required String companyID, required String projectID}) async {
    try {
      await _companies
          .doc(companyID)
          .collection('projects')
          .doc(projectID)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

// TODO 00: Create tasks under company then under project
  // Create a task
  Future<void> addTask({required Task task, required String userID}) async {
    try {
      String companyID = await getCompanyID(userID: userID);
      await _companies
          .doc(companyID)
          .collection('projects')
          .doc(task.projectID)
          .collection('tasks')
          .doc(task.taskID)
          .set({
        'taskID': task.taskID,
        'taskHeading': task.taskHeading,
        'notes': task.notes,
        'projectID': task.projectID,
        'taskSchedule': task.taskSchedule,
        'taskStatus': task.taskStatus,
        'taskDueDate': task.taskDueDate,
        'taskCreatedDate': task.taskCreatedDate,
        'subTasks': task.subTasks,
        'assignedTo': task.assignedTo,
        'labourCosts': task.labourCosts,
        'materialCosts': task.materialCosts,
        'totalCosts': task.totalCosts,
      });
    } catch (e) {
      rethrow;
    }
  }

  // Get a task
  Future<Task> getTask(
      {required String projectID,
      required String taskID,
      required String userID}) async {
    try {
      String companyID = await getCompanyID(userID: userID);
      final task = await _companies
          .doc(companyID)
          .collection('projects')
          .doc(projectID)
          .collection('tasks')
          .doc(taskID)
          .get();
      return Task(
        taskID: task['taskID'],
        taskHeading: task['taskHeading'],
        notes: task['notes'],
        projectID: task['projectID'],
        taskSchedule: task['taskSchedule'],
        taskStatus: task['taskStatus'],
        taskDueDate: task['taskDueDate'],
        taskCreatedDate: task['taskCreatedDate'],
        subTasks: task['subTasks'],
        assignedTo: task['assignedTo'],
        labourCosts: task['labourCosts'],
        materialCosts: task['materialCosts'],
        totalCosts: task['totalCosts'],
      );
    } catch (e) {
      rethrow;
    }
  }

  // Get tasks
  Future<List<Task>> getTasks(
      {required String projectID, required String userID}) async {
    try {
      String companyID = await getCompanyID(userID: userID);
      final tasks = await _companies
          .doc(companyID)
          .collection('projects')
          .doc(projectID)
          .collection('tasks')
          .get();
      return tasks.docs
          .map((task) => Task(
                taskID: task['taskID'],
                taskHeading: task['taskHeading'],
                notes: task['notes'],
                projectID: task['projectID'],
                taskSchedule: task['taskSchedule'],
                taskStatus: task['taskStatus'],
                taskDueDate: task['taskDueDate'],
                taskCreatedDate: task['taskCreatedDate'],
                subTasks: task['subTasks'],
                assignedTo: task['assignedTo'],
                labourCosts: task['labourCosts'],
                materialCosts: task['materialCosts'],
                totalCosts: task['totalCosts'],
              ))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  // Get company tasks
  Future<List<dynamic>> getUserTasks({required String userID}) async {
    try {
      final projects = await getProjects(userID: userID);
      List<dynamic> allTasks = [];
      for (Project project in projects) {
        var projTasks =
            await getTasks(projectID: project.projectID, userID: userID);
        allTasks.addAll(projTasks);
      }
      return allTasks;
    } catch (e) {
      rethrow;
    }
  }

  // Update task
  Future<void> updateTask({required Task task, required String userID}) async {
    try {
      String companyID = await getCompanyID(userID: userID);
      await _companies
          .doc(companyID)
          .collection('projects')
          .doc(task.projectID)
          .collection('tasks')
          .doc(task.taskID)
          .update({
        'taskID': task.taskID,
        'taskHeading': task.taskHeading,
        'notes': task.notes,
        'projectID': task.projectID,
        'taskSchedule': task.taskSchedule,
        'taskStatus': task.taskStatus,
        'taskDueDate': task.taskDueDate,
        'taskCreatedDate': task.taskCreatedDate,
        'subTasks': task.subTasks,
        'assignedTo': task.assignedTo,
        'labourCosts': task.labourCosts,
        'materialCosts': task.materialCosts,
        'totalCosts': task.totalCosts,
      });
    } catch (e) {
      rethrow;
    }
  }

  // Delete task
  Future<void> deleteTask(
      {required String projectID,
      required String taskID,
      required String userID}) async {
    try {
      String companyID = await getCompanyID(userID: userID);
      await _companies
          .doc(companyID)
          .collection('projects')
          .doc(projectID)
          .collection('tasks')
          .doc(taskID)
          .delete();
    } catch (e) {
      rethrow;
    }
  }
}
