import 'package:itemstorage/repository/firestore_repository.dart';

class ItemManagementService {
  final FirestoreRepository _firestoreRepository;

  ItemManagementService({FirestoreRepository? firestoreRepository})
    : _firestoreRepository = firestoreRepository ?? FirestoreRepository();
}
