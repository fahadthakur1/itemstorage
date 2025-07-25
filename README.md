# ItemStorage - Flutter Coding Interview Test

A Flutter web application for managing items with favorites functionality. This is a coding interview test designed to evaluate Flutter development skills, state management implementation, and real-time data handling.

## 🎯 Test Overview

**Time Limit:** 40 minutes for core functionality

This test evaluates your ability to:
- Implement state management solutions
- Create service layers for data handling
- Create reusable components
- Work with real-time data updates
- Enhance existing UI components
- Handle user interactions effectively
- Explain your design decisions

## 📋 Requirements

### Core Functionality (Required - 40 minutes)

#### 1. State Management Implementation
- **Choose and implement** one of the following state management solutions:
  - **BLoC/Cubit** (recommended)
  - **GetX**
  - **Riverpod**
  - **Provider**
  - Any other state management solution of your choice

#### 2. Service Layer Creation
- Create a service layer that interacts with the provided `FirestoreRepository`
- Handle data operations (Create, Read, Update, Delete, Stream)
- Manage error handling and loading states

#### 3. Real-time Data Updates
- Implement real-time data synchronization
- Changes should reflect **automatically** without manual refresh
- Use Firestore streams for live updates

#### 4. Category Field Enhancement
- **Add a `category` field** to the Item model
- **Display category as a Chip** in the ItemCard (beside the item name)
- **Update the AddItemDialog** to include category input
- Categories should be stored and retrieved from Firestore

#### 5. Web Accessibility
- **Make all text selectable** using mouse (web-focused app)
- Ensure proper web user experience

### Bonus Functionality (If time permits)

#### 6. Category Filtering
- Implement filtering options based on categories
- Allow users to filter items by selected categories
- Provide clear UI for filter controls

## 🏗️ Project Structure

### Already Provided

```
lib/
├── models/
│   └── item_model.dart              # Item data model
├── repository/
│   └── firestore_repository.dart    # Complete CRUD operations
├── widgets/
│   └── item_card.dart               # Item display widget with favorite toggle
└── presentation/
    └── dialogs/
        └── add_item_dialog.dart     # Add/Edit item dialog
```

### What You Need to Implement

```
lib/
├── services/
│   └── item_service.dart            # Service layer (YOU IMPLEMENT)
├── cubits/ or blocs/ or controllers/
│   └── [your_state_management]/     # State management (YOU IMPLEMENT)
└── presentation/
    └── screens/
        └── home_page.dart           # Main page (YOU IMPLEMENT)
```

## 🚀 Getting Started

### 1. Fork and Clone
```bash
# Fork this repository on GitHub, then clone your fork
git clone https://github.com/fahadthakur1/itemstorage.git
cd itemstorage
```

### 2. Install Dependencies
```bash
flutter pub get
```
- You may install any additional dependencies that you may want to use

### 3. Firebase Setup
- Ensure Firebase is properly configured
- The project already includes Firebase configuration files, and the initialization has already been performed

### 4. Run the Application
```bash
flutter run -d chrome  # For web development
```

## 📝 Implementation Guidelines

### Item Model Enhancement
Update the `Item` model to include a category field:
```dart
class Item {
  final String id;
  final String itemName;
  final bool isFavorite;

  // add the new field
  
  // Update constructor, copyWith, toMap, fromMap methods
}
```

### ItemCard Enhancement
The ItemCard should display:
- Item name (selectable text)
- Category as a Chip widget
- Edit button (already implemented)
- Favorite toggle button (implement the logic for it)

### Real-time Updates
Implement using Firestore streams.

### Web Text Selectability
Ensure all text components in the app are selectable.

## ✅ Evaluation Criteria

### Core Requirements (Must Have)
- [ ] State management properly implemented
- [ ] Service layer created and functional
- [ ] Real-time data updates working
- [ ] Category field added to Item model
- [ ] Category displayed as Chip in ItemCard
- [ ] AddItemDialog updated for category input
- [ ] All text is selectable (web accessibility)
- [ ] CRUD operations work correctly
- [ ] Code is clean and well-structured

### Bonus Points
- [ ] Category filtering implemented
- [ ] Error handling and loading states
- [ ] Input validation
- [ ] UI/UX improvements
- [ ] Code comments and documentation
- [ ] Performance optimizations

## 🔧 Technical Notes

### Firestore Repository
The `FirestoreRepository` class is already implemented with:
- `createItem(Item item)`
- `getItem(String itemId)`
- `getAllItems()`
- `getFavoriteItems()`
- `updateItem(Item item)`
- `deleteItem(String itemId)`
- `getItemsStream()` - For real-time updates
- Additional utility methods

### Existing Widgets
- `ItemCard`: Displays item with favorite toggle and edit button
- `AddItemDialog`: Modal dialog for adding/editing items

## 📱 Expected User Flow

1. **View Items**: Display all items in a list/grid
2. **Add Item**: Click add button → Open dialog → Enter name and category → Save
3. **Edit Item**: Click edit button on card → Open dialog with existing data → Modify → Save
4. **Toggle Favorite**: Click heart icon → Immediately reflect change
5. **Filter by Category**: (Bonus) Select category filter → Show filtered results
6. **Real-time Sync**: Changes from other sources appear automatically

## 🕒 Time Management Tips

**First 10 minutes:**
- Set up state management structure
- Create service layer basic structure
- Update Item model with category field

**Next 20 minutes:**
- Implement CRUD operations with state management
- Update ItemCard to show category chip
- Update AddItemDialog for category input

**Final 10 minutes:**
- Implement real-time streams
- Make text selectable
- Test functionality and fix bugs

## 🤝 Submission

1. Implement the required functionality
2. Commit your changes to your forked repository, and create a pull request
3. Ensure the application runs without errors
4. Be prepared to demonstrate and explain your implementation


---

**Good luck! Focus on core functionality first, then enhance if time permits.**
