import 'dart:math';
import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/homepage/bottom_navigation_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/add_category_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/product_model.dart';
import 'package:project_fourth/screens/widgets/product_module/product_controller.dart';

class ListCategories extends StatefulWidget {
  const ListCategories({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListCategoriesState createState() => _ListCategoriesState();
}

class _ListCategoriesState extends State<ListCategories> {
  final CategoryPageController _categorypageController = CategoryPageController();
  @override
  void initState() {
    super.initState();
    // Initialize category list when the widget is first initialized
    _categorypageController.getAllCategories();
  }

  // Delete confirmation popup
  Future<void> showDeleteConfirmationDialog(int id) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this category?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // No
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                _categorypageController.deleteCategory(id);
                Navigator.of(context).pop(true);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Category deleted successfully!'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
   // final catCount = Provider.of<CountProvider?>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Categories List',
          style: TextStyle(
            color: Color(0xff4B4B87),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const BottomNavigation(initialIndex: 0),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('lib/assets/Back1.png'),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF1F5F9),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ValueListenableBuilder<List<CategoryModel>>(
          valueListenable: _categorypageController.categoryListNotifier,
          builder: (context, categories, _) {
            //Count provider Data passing
           // if (catCount != null) {
              // catCount.updateCategoryCount(categories.length);
           // }

            return categories.isEmpty
                ? const Center(
                    child: Text('There are no categories added yet.'),
                  )
                : ListView.separated(
                    itemBuilder: (ctx, index) {
                      final category = categories[index];
                      return Container(
                        height: 85,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(category.name),
                              ),
                              Row(
                                children: [
                                  Hero(
                                    tag: 'edit_icon_${category.id}',
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, right: 8),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AddCategory(
                                                  category: category),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: const Color(0XFF98B5FF),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  'lib/assets/edit1.png'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        // Show delete confirmation dialog
                                        showDeleteConfirmationDialog(
                                            category.id!);
                                      },
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: const Color(0XFFFA3E3E),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                'lib/assets/delete1.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 14),
                    itemCount: categories.length,
                  );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0, bottom: 50),
        child: FloatingActionButton(
          heroTag: generateRandomString(5),
          backgroundColor: const Color(0xFF4B4B87),
          tooltip: 'New Category',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddCategory()),
            );
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}

String generateRandomString(int len) {
  var r = Random();
  return String.fromCharCodes(
      List.generate(len, (index) => r.nextInt(33) + 89));
}
