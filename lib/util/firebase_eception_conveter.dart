class FirebaseExceptionConverter{
  static String getErrorMessage(String error){
    List<String> list = error.split("-");
    String res = "";
    return list.fold("", (previousValue, element) => previousValue + " " + element);
  }
}