import 'package:appwrite/appwrite.dart';
import 'package:todo_app_appwrite/shared.dart';

Client client = Client()
    .setEndpoint('YOUR_APPWRITE_ENDPOINT')
    .setProject('YOUR_PROJECT_ID')
    .setSelfSigned(
        status: true); // For self signed certificates, only use for development

// create an user account

Account account = Account(client);

// Registering the User (Sign Up)
Future<String> createUser(String name, String email, String password) async {
  try {
    final user = await account.create(
        userId: ID.unique(), email: email, password: password, name: name);
    print("New User created");
    return "success";
  } on AppwriteException catch (e) {
    return e.message.toString();
  }
}

// Login the user

Future loginUser(String email, String password) async {
  try {
    final user =
        await account.createEmailSession(email: email, password: password);
    await UserSavedData.saveEmail(email);
    print("User logged in");
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

// Logout the user

Future logoutUser() async {
  await account.deleteSession(sessionId: 'current');
  print("User Logged out");
}

// check User is authenticated or not

Future checkUserAuth() async {
  try {
    //check if session exist or not
    await account.getSession(sessionId: 'current');
    // if exist return true
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
