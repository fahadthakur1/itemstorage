// ignore_for_file: unintended_html_in_doc_comment

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/item_model.dart';

/// A repository class that handles all Firestore database operations for Item objects.
/// This class provides a clean interface between the app and Firebase Firestore,
/// encapsulating all the database logic in one place.
class FirestoreRepository {
  // FirebaseFirestore.instance gives us access to the Firestore database
  // This is a singleton that represents the entire Firestore database for your project
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // The collection name where all items will be stored in Firestore
  // Collections in Firestore are like tables in traditional databases
  static const String _collectionName = 'items';

  /// Creates a new item in the Firestore database
  ///
  /// [item] - The Item object to be saved to the database
  ///
  /// How it works:
  /// 1. Gets a reference to the 'items' collection
  /// 2. Creates a new document with the item's ID as the document ID
  /// 3. Converts the Item object to a Map using toMap() method
  /// 4. Saves the data to Firestore
  ///
  /// Returns: Future<void> - completes when the operation is done
  /// Throws: FirebaseException if there's an error with the database operation
  Future<void> createItem(Item item) async {
    try {
      // collection() gets a reference to the 'items' collection
      // doc() creates a reference to a specific document using the item's ID
      // set() saves the data to that document

      // generate document reference
      final docRef = _firestore.collection(_collectionName).doc();
      item = item.copyWith(id: docRef.id);
      await _firestore
          .collection(_collectionName)
          .doc(item.id)
          .set(item.toMap());
    } catch (e) {
      // Re-throw the exception with more context for debugging
      throw Exception('Failed to create item: $e');
    }
  }

  /// Retrieves a single item from Firestore by its ID
  ///
  /// [itemId] - The unique identifier of the item to fetch
  ///
  /// How it works:
  /// 1. Gets a reference to the specific document in the 'items' collection
  /// 2. Fetches the document snapshot (contains the data and metadata)
  /// 3. Checks if the document exists
  /// 4. If it exists, converts the data back to an Item object
  ///
  /// Returns: Future<Item?> - the Item if found, null if not found
  /// Throws: FirebaseException if there's an error with the database operation
  Future<Item?> getItem(String itemId) async {
    try {
      // doc() gets a reference to the document with the specified ID
      // get() fetches the current data in that document
      final DocumentSnapshot doc = await _firestore
          .collection(_collectionName)
          .doc(itemId)
          .get();

      // exists checks if the document was found in the database
      if (doc.exists) {
        // data() returns the document's data as a Map<String, dynamic>
        // We cast it to the expected type and convert it to an Item object
        final data = doc.data() as Map<String, dynamic>;
        return Item.fromMap(data);
      }

      // Return null if the document doesn't exist
      return null;
    } catch (e) {
      throw Exception('Failed to get item: $e');
    }
  }

  /// Retrieves all items from the Firestore database
  ///
  /// How it works:
  /// 1. Gets a reference to the entire 'items' collection
  /// 2. Fetches all documents in that collection
  /// 3. Converts each document to an Item object
  /// 4. Returns a list of all items
  ///
  /// Returns: Future<List<Item>> - a list of all items in the database
  /// Throws: FirebaseException if there's an error with the database operation
  Future<List<Item>> getAllItems() async {
    try {
      // get() on a collection fetches all documents in that collection
      final QuerySnapshot querySnapshot = await _firestore
          .collection(_collectionName)
          .get();

      // docs gives us a list of all DocumentSnapshot objects
      // We map over each document and convert it to an Item object
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Item.fromMap(data);
      }).toList();
    } catch (e) {
      throw Exception('Failed to get all items: $e');
    }
  }

  /// Retrieves only the favorite items from the database
  ///
  /// How it works:
  /// 1. Creates a query that filters documents where 'isFavorite' is true
  /// 2. Executes the query to get matching documents
  /// 3. Converts each document to an Item object
  ///
  /// Returns: Future<List<Item>> - a list of items marked as favorites
  /// Throws: FirebaseException if there's an error with the database operation
  Future<List<Item>> getFavoriteItems() async {
    try {
      // where() creates a filter query - only get documents where isFavorite == true
      final QuerySnapshot querySnapshot = await _firestore
          .collection(_collectionName)
          .where('isFavorite', isEqualTo: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Item.fromMap(data);
      }).toList();
    } catch (e) {
      throw Exception('Failed to get favorite items: $e');
    }
  }

  /// Updates an existing item in the Firestore database
  ///
  /// [item] - The Item object with updated data
  ///
  /// How it works:
  /// 1. Gets a reference to the document with the item's ID
  /// 2. Uses update() to modify only the fields that have changed
  /// 3. Converts the Item object to a Map for the update
  ///
  /// Note: update() will fail if the document doesn't exist
  /// Use set() with merge: true if you want to create the document if it doesn't exist
  ///
  /// Returns: Future<void> - completes when the operation is done
  /// Throws: FirebaseException if there's an error with the database operation
  Future<void> updateItem(Item item) async {
    try {
      // update() modifies existing fields in the document
      // If the document doesn't exist, this will throw an error
      await _firestore
          .collection(_collectionName)
          .doc(item.id)
          .update(item.toMap());
    } catch (e) {
      throw Exception('Failed to update item: $e');
    }
  }

  /// Updates only the favorite status of an item
  ///
  /// [itemId] - The ID of the item to update
  /// [isFavorite] - The new favorite status
  ///
  /// This is more efficient than updating the entire item when you only
  /// need to change one field.
  ///
  /// Returns: Future<void> - completes when the operation is done
  /// Throws: FirebaseException if there's an error with the database operation
  Future<void> updateItemFavoriteStatus(String itemId, bool isFavorite) async {
    try {
      // Update only the isFavorite field, leaving other fields unchanged
      await _firestore.collection(_collectionName).doc(itemId).update({
        'isFavorite': isFavorite,
      });
    } catch (e) {
      throw Exception('Failed to update item favorite status: $e');
    }
  }

  /// Deletes an item from the Firestore database
  ///
  /// [itemId] - The unique identifier of the item to delete
  ///
  /// How it works:
  /// 1. Gets a reference to the document with the specified ID
  /// 2. Calls delete() to remove the document from the collection
  ///
  /// Note: delete() will succeed even if the document doesn't exist
  ///
  /// Returns: Future<void> - completes when the operation is done
  /// Throws: FirebaseException if there's an error with the database operation
  Future<void> deleteItem(String itemId) async {
    try {
      // delete() removes the entire document from the collection
      await _firestore.collection(_collectionName).doc(itemId).delete();
    } catch (e) {
      throw Exception('Failed to delete item: $e');
    }
  }

  /// Sets up a real-time listener for all items in the collection
  ///
  /// This returns a Stream that will emit a new list of items whenever
  /// the data in Firestore changes. This is useful for real-time updates
  /// in your UI without needing to manually refresh the data.
  ///
  /// How it works:
  /// 1. snapshots() creates a stream of QuerySnapshot objects
  /// 2. Each time data changes in Firestore, a new snapshot is emitted
  /// 3. We map each snapshot to a list of Item objects
  ///
  /// Returns: Stream<List<Item>> - a stream that emits updated item lists
  /// Usage: You can listen to this stream in your UI to get real-time updates
  Stream<List<Item>> getItemsStream() {
    return _firestore.collection(_collectionName).snapshots().map((
      querySnapshot,
    ) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Item.fromMap(data);
      }).toList();
    });
  }

  /// Sets up a real-time listener for a specific item
  ///
  /// [itemId] - The ID of the item to listen to
  ///
  /// Returns: Stream<Item?> - a stream that emits the item when it changes
  /// Emits null if the item is deleted or doesn't exist
  Stream<Item?> getItemStream(String itemId) {
    return _firestore.collection(_collectionName).doc(itemId).snapshots().map((
      docSnapshot,
    ) {
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        return Item.fromMap(data);
      }
      return null;
    });
  }

  /// Searches for items by name (case-insensitive partial matching)
  ///
  /// [searchTerm] - The text to search for in item names
  ///
  /// Note: Firestore doesn't have built-in full-text search, so this
  /// method fetches all items and filters them locally. For better
  /// performance with large datasets, consider using Algolia or
  /// Elasticsearch for search functionality.
  ///
  /// Returns: Future<List<Item>> - items whose names contain the search term
  Future<List<Item>> searchItemsByName(String searchTerm) async {
    try {
      final allItems = await getAllItems();

      // Filter items locally where the name contains the search term (case-insensitive)
      return allItems.where((item) {
        return item.itemName.toLowerCase().contains(searchTerm.toLowerCase());
      }).toList();
    } catch (e) {
      throw Exception('Failed to search items: $e');
    }
  }

  /// Gets the total count of items in the collection
  ///
  /// Returns: Future<int> - the number of items in the database
  Future<int> getItemCount() async {
    try {
      final querySnapshot = await _firestore.collection(_collectionName).get();

      return querySnapshot.docs.length;
    } catch (e) {
      throw Exception('Failed to get item count: $e');
    }
  }
}
