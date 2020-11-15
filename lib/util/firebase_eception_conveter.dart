class FirebaseExceptionConverter{
  static String getErrorMessage(String error){
    List<String> list = error.split("-");
    String res = "";
    list.forEach((element) {res += element;});
    return res;
  }
}