import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:haajaree/data/models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  AuthRepository(FirebaseAuth? firebaseAuth)
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<User?> signup(String fullName, String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user;
      if (user != null) {
        userModel = UserModel(
            email: email,
            password: password,
            fullName: fullName,
            uID: user.uid);
        // _userModel.copyWith(
        //     email: email,
        //     password: password,
        //     fullName: fullName,
        //     uID: user.uid);
        return user;
      }
    } on FirebaseAuthException catch (authError) {
      throw authError.message!;
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user;
      if (user != null) {
        return user;
      }
    } on FirebaseAuthException catch (authError) {
      // rethrow auth
      throw authError.message!;
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      // if (gUser == null) return null;
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (authError) {
      throw authError.message!;
    } catch (e) {
      rethrow;
    }
  }

  signout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (authError) {
      throw authError.message!;
    } catch (e) {
      rethrow;
    }
  }

  User? get currentUser {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return user;
    }
    return null;
  }

  UserModel userModel = const UserModel();

  String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'Exception: wrong-password':
        return 'The Password is incorrect. Please try again.';
      case 'Exception: user-not-found':
        return 'no user found with this email. Please try again.';
      case 'Exception: invalid-email':
        return 'This email does not exist.';
      case "ERROR_INVALID_CUSTOM_TOKEN":
        return "The custom token format is incorrect. Please check the documentation.";
      case "ERROR_CUSTOM_TOKEN_MISMATCH":
        return "The custom token corresponds to a different audience.";
      case "ERROR_INVALID_CREDENTIAL":
        return "The supplied auth credential is malformed or has expired.";
      case "ERROR_INVALID_EMAIL":
        return "The email address is badly formatted.";
      case "ERROR_WRONG_PASSWORD":
        return "The password is invalid or the user does not have a password.";
      case "ERROR_USER_MISMATCH":
        return "The supplied credentials do not correspond to the previously signed in user.";
      case "ERROR_REQUIRES_RECENT_LOGIN":
        return "This operation is sensitive and requires recent authentication. Log in again before retrying this request.";
      case "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL":
        return "An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.";
      case "ERROR_EMAIL_ALREADY_IN_USE":
        return "The email address is already in use by another account.";
      case "ERROR_CREDENTIAL_ALREADY_IN_USE":
        return "This credential is already associated with a different user account.";
      case "ERROR_USER_DISABLED":
        return "The user account has been disabled by an administrator.";
      case "ERROR_USER_TOKEN_EXPIRED":
        return "The user\\'s credential is no longer valid. The user must sign in again.";
      case "ERROR_USER_NOT_FOUND":
        return "There is no user record corresponding to this identifier. The user may have been deleted.";
      default:
        return 'An $errorCode error occcurred. plase try agin later.';
    }
  }
}
