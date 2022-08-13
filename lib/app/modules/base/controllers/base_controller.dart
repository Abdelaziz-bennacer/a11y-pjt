import 'dart:typed_data';
import 'package:a11y_pjt/app/data/models/company_model/company_model.dart';
import 'package:a11y_pjt/app/data/models/folder_model/folder_model.dart';
import 'package:a11y_pjt/app/data/models/service_model/service_model.dart';
import 'package:a11y_pjt/app/data/providers/admin_provider.dart';
import 'package:a11y_pjt/app/data/providers/login_provider.dart';
import 'package:a11y_pjt/app/data/providers/upload_avatar_provider.dart';
import 'package:a11y_pjt/app/data/providers/user_provider.dart';
import 'package:a11y_pjt/app/modules/login/controllers/login_controller.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:time_range_picker/time_range_picker.dart';
import '../../../config/app_information.dart';
import '../../../data/models/project_model/project_model.dart';

class BaseController extends GetxController {

  final userProvider = Get.put(UserProvider());
  final uploadAvatarProvider = Get.put(UploadAvatarProvider());
  final loginController = Get.find<LoginController>();
  final loginProvider = Get.find<LoginProvider>();
  final adminProvider = Get.put(AdminProvider());

  final box = GetStorage();

  String _selectedUsage = 'Interne';
  String get selectedUsage => _selectedUsage;
  void onClickUsageRadioButton(String usage) {
    _selectedUsage = usage;
    update();
  }

  String _selectedInterProject = 'Réunion';
  String get selectedInterProject => _selectedInterProject;
  void onClickInternProjectRadioButton(String project) {
    _selectedInterProject = project;
    update();
  }

  var selectedDate = DateTime.now();
  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
    }
    update();
  }

  TimeOfDay? selectedStartDuration = const TimeOfDay(hour: 09, minute: 0);
  TimeOfDay? selectedEndDuration = const TimeOfDay(hour: 12, minute: 0);
  double craDuration = 3.0; // = findCRADuration();
  double toDouble(TimeOfDay timeOfDay) =>
      timeOfDay.hour + timeOfDay.minute / 60;
  findCRADuration() {
    var t1 = toDouble(selectedEndDuration!);
    var t2 = toDouble(selectedStartDuration!);
    craDuration = t1 - t2;
    update();
  }

  var startTime = const TimeOfDay(hour: 09, minute: 0);
  var endTime = const TimeOfDay(hour: 12, minute: 0);
  chooseDuration() async {
    dynamic pickedDuration = await showTimeRangePicker(
        context: Get.context!,
        strokeWidth: 20,
        ticks: 24,
        ticksOffset: 2,
        ticksLength: 8,
        handlerRadius: 14,
        ticksColor: Colors.red,
        strokeColor: Color(0xff082D6D),
        backgroundColor: Colors.black.withOpacity(0.3),
        //snap: true,
        rotateLabels: false,
        labels: ["24 h", "3 h", "6 h", "9 h", "12 h", "15 h", "18 h", "21 h"]
            .asMap()
            .entries
            .map((e) {
          return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
        }).toList(),
        labelOffset: 40,
        padding: 55,
        labelStyle: const TextStyle(fontSize: 25, color: Colors.red),
        timeTextStyle: TextStyle(
            color: Colors.orange[700],
            fontSize: 24,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
        activeTimeTextStyle: const TextStyle(
            color: Colors.orange,
            fontSize: 26,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
        start: startTime,
        end: endTime,
        interval: const Duration(minutes: 30),
        minDuration: const Duration(minutes: 30),
        /*disabledTime: TimeRange(
          startTime: const TimeOfDay(hour: 6, minute: 0),
          endTime: const TimeOfDay(hour: 10, minute: 0),
      ),*/
        clockRotation: 180.0,
        onStartChange: (value) {
          selectedStartDuration = value;
        },
        onEndChange: (value) {
          selectedEndDuration = value;
        },
      );


    if (pickedDuration != null) {
      //selectedDuration = pickedDuration;
    }
    findCRADuration();
    update();
  }

  List<String> companiesNames = [];
  String? selectedCompanyName;
  CompanyModel? selectedCompany;
  //var selectedClientProject;
  displayCompaniesList() async {
    List<CompanyModel> response = await adminProvider.getCompanies();
    for(var i=0; i<response.length; i++) {
      String name = response[i].name.toString();
      companiesNames.add(name);
    }
    update();
  }
  targetCompany() async {
    List<CompanyModel> response = await adminProvider.getCompanies();
    selectedCompany = response.where((element) => element.name == selectedCompanyName).first;
    displayProjectsList();
    //displayFoldersList();
    update();
  }


  List<String> projectsNames = [];
  String? selectedProjectName;
  ProjectModel? selectedProject;
  //var selectedClientProject;
  displayProjectsList() async {
    List<ProjectModel> response = await adminProvider.getProjects();
    List<ProjectModel> currents = response.where((element) => element.companyUUID == selectedCompany!.uuid).toList();
    projectsNames = currents.map((e) => e.name).toList();
    update();
  }
  targetProject() async {
    List<ProjectModel> response = await adminProvider.getProjects();
    selectedProject = response.where((element) => element.name == selectedProjectName).first;
    displayFoldersList();
    update();
  }


  List<String> foldersNames = [];
  String? selectedFolderName;
  FolderModel? selectedFolder = FolderModel(
      uuid: '',
      name: '',
      isActif: true,
      projectUUID: '',
      service: '',
  );

  //var selectedClientProject;
  displayFoldersList() async {
    List<FolderModel> response = await adminProvider.getFolders();

    List<FolderModel> currents = response.where((element) => element.projectUUID == selectedProject!.uuid).toList();
    foldersNames = currents.map((e) => e.name).toList();
    update();
  }
  targetFolder() async {
    List<FolderModel> response = await adminProvider.getFolders();
    selectedFolder = response.where((element) => element.name == selectedFolderName).first;
    selectedServiceName = selectedFolder!.service!;
    update();
  }

  List<String> servicesNames = [];
  String? selectedServiceName;
  ServiceModel? selectedService = ServiceModel(
    uuid: '',
    name: '',
  );
  //var selectedClientProject;
  /*displayServicesList() async {
    List<ServiceModel> response = await adminProvider.getServices();

    print('SERVICES: $response');
    List<ServiceModel> currents = response.where((element) => element.name == selectedFolder!.service!).toList();
    servicesNames = currents.map((e) => e.name).toList();
    print('Services NAMES: $foldersNames');
    update();
  }
  targetService() async {
    List<ServiceModel> response = await adminProvider.getServices();
    selectedService = response.where((element) => element.name == selectedFolder!.service!).first;
    print(selectedFolder);
    update();
  }*/

  List<String> themesNames = [
    "Thématique 1",
    "Thématique 2",
    "Thématique 3",
    "Thématique 4",
    "Thématique 5",
    "Thématique 6",
    "Thématique 7",
    "Thématique 8",
    "Thématique 9",
    "Thématique 10",
    "Thématique 11",
    "Thématique 12",
    "Thématique 13",
  ];
  String? selectedTheme;
  //FolderModel? selectedFolder;
  //var selectedClientProject;
  /*displayFoldersList() async {
    List<FolderModel> response = await adminProvider.getFolders();

    print('FOLDERS: $response');
    List<FolderModel> currents = response.where((element) => element.projectUUID == selectedProject!.uuid).toList();
    foldersNames = currents.map((e) => e.name).toList();
    print('Folders NAMES: $foldersNames');
    update();
  }*/
  /*targetFolder() async {
    List<FolderModel> response = await adminProvider.getFolders();
    selectedFolder = response.where((element) => element.name == selectedFolderName).first;
    print(selectedFolder);
  }*/

  removeClientSelection() {
    if (
      selectedCompanyName != null
          || selectedProjectName != null
          || selectedFolderName != null
          || selectedTheme != null
    ) {

      selectedCompanyName = null;
      //companiesNames = [];
      selectedProjectName = null;
      projectsNames = [];
      selectedFolderName = null;
      foldersNames = [];
      selectedTheme = null;
      selectedFolder = FolderModel(projectUUID: '', name: '', isActif: true, uuid: '', service: '');
      update();
    }
  }

  String? displayAvatarWithURL;
  //String? userAvatarURL;
  XFile? file;
  final XTypeGroup typeGroup =
      XTypeGroup(label: 'images', extensions: ['jpg', 'png']);

  //var screenSize = Get.size;

  void uploadPicture() async {
    if(loginController.currentUser.avatarURL != null) {
      deletePicture();
    }
      file = (await openFile(acceptedTypeGroups: [typeGroup]));
      //imageAvatarLocalPath = file!.path;
      //box.write('imageAvatarLocalPath', imageAvatarLocalPath);

      Uint8List data = await file!.readAsBytes();
      List<int> list = data.cast();
      await uploadAvatarProvider.sendPic(list, '${loginController.username}_avatar', loginController.currentUser.id);

      var resp = await userProvider.getCurrentUser(loginController.currentUser.id);
      displayAvatarWithURL = '${AppConstants.dbBaseUrl}${resp['avatar']['formats']['small']['url']}';
      box.write('avatarServerURL', displayAvatarWithURL);

      update();

      loginController.currentUser = loginController.currentUser.copyWith(
        avatarURL: displayAvatarWithURL,
      );
    }

  void deletePicture() async {
    var user = await userProvider.getCurrentUser(loginController.currentUser.id);
    var picture = await uploadAvatarProvider.deletePicture(user['id']);
    print('DELETE PIC: $picture');
    file = null;
    loginController.currentUser = loginController.currentUser.copyWith(avatarURL: null);
    displayAvatarWithURL = null;
    box.remove('avatarServerURL');
    update();
  }

  @override
  void onInit() {
    displayCompaniesList();
    super.onInit();
  }

}
