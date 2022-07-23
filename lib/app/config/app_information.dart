class AppInformation {
  static final name = 'bdd_project';
  static final title = 'Le Coffee Shop';
  static final appIdAndroid = "";
  static final appIdIos = "";
  static final masterAdminEmail = "";
  static final googleMapsKey = '';
  static final googleMapsKeyURL = '';
}

class AppConstants {
  static final dbBaseUrl = 'http://localhost:1337';
  static final registerEndPoint = '/api/auth/local/register';
  static final loginEndPoint = '/api/auth/local';
  static final userEndPoint = '/api/users?populate=*';
  //static final currentUserEndPoint = '/api/users/$id?populate=*';
  static final uploadPictureEndPoint = '/api/upload/';
  static final teaFamiliesEndPoint = '/api/tea-families';
  static final teaCategoriesEndPoint = '/api/tea-categories';
  static final teaEndPoint = '/api/teas';
}