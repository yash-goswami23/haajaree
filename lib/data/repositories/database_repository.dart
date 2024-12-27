import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haajaree/data/models/home_model.dart';
import 'package:haajaree/data/models/user_model.dart';
import 'package:haajaree/data/repositories/auth_repository.dart';

class DatabaseRepository {
  final FirebaseFirestore _firebaseFirestore;
  final AuthRepository _authRepository;
  DatabaseRepository(FirebaseFirestore? firebaseFireStore, this._authRepository)
      : _firebaseFirestore = firebaseFireStore ?? FirebaseFirestore.instance;
// FirebaseFirestore.instance

  Future<void> setUserData(UserModel user) async {
    try {
      final String docPath = _authRepository.currentUser!.uid;
      final docRef = _firebaseFirestore.collection('users').doc(docPath);
      await docRef.set(user.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> fetchUserData(String docPath) async {
    try {
      _firebaseFirestore.settings = const Settings(
        persistenceEnabled: true,
      );
      final collectionRef = _firebaseFirestore.collection('users').doc(docPath);
      final data = await collectionRef.get();
      if (data.exists) {
        return UserModel.fromMap(data.data()!);
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<void> setUserAttendanceData(String yearPtah, String monthPath,
      String datePath, HomeModel homeModel) async {
    try {
      final String userIdPath = _authRepository.currentUser!.uid;
      _firebaseFirestore.settings = const Settings(
        persistenceEnabled: true,
      );
      final docRef = _firebaseFirestore
          .collection('users')
          .doc(userIdPath)
          .collection('attendance')
          .doc(yearPtah)
          .collection(monthPath)
          .doc(datePath);
      await docRef.set(homeModel.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<HomeModel>?> fetchUserAttendanceData(
      String yearPtah, String monthPath) async {
    try {
      final String userIdPath = _authRepository.currentUser!.uid;
      _firebaseFirestore.settings = const Settings(
        persistenceEnabled: true,
      );
      final collectionRef = _firebaseFirestore
          .collection('users')
          .doc(userIdPath)
          .collection('attendance')
          .doc(yearPtah)
          .collection(monthPath)
          .orderBy('date', descending: true);
      final monthlyData = await collectionRef.get();
      // if (data.exists) {
      //   return UserModel.fromMap(data.data()!);
      // }
      final List<HomeModel> homeModelList = [];
      if (monthlyData.docs.isNotEmpty) {
        for (var element in monthlyData.docs) {
          homeModelList.add(HomeModel.fromMap(element.data()));
        }
        return homeModelList;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
