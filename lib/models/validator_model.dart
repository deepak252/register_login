
class Validator{

  static String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if(value=='' || value ==null)
      return 'Enter email';
    if (!regex.hasMatch(value))
      return 'Enter a valid email address';
    else
      return null;
  }

  static String? validatePassword(String? password) {
    if (password == '' || password == null) return 'Enter password';
    if (password.length  < 8)
      return 'Password must contain at least 8 character';
    else
      return null;
  }
  static String? validateConfirmPassword(String? confirmPassword,String ? password) {
    if (confirmPassword != password) return 'Password not match';    
    else
      return null;
  }

}