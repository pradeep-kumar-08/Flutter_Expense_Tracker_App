import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:test_demo/screens/add_expense/blogs/create_categorybloc/create_category_bloc.dart';
import 'package:uuid/uuid.dart';

Future getCategoryCreation(BuildContext context) {
  List<String> myCategoriIcons = [
    "entertainment",
    "food",
    "home",
    "pet",
    "shopping",
    "tech",
    "travel",
  ];

  return showDialog(
    context: context,
    builder: (ctx) {
      bool isExpended = false;

      String iconSelected = "";
      late Color categoryColor = Colors.white;

      TextEditingController categoryNameController = TextEditingController();
      TextEditingController categoryIconController = TextEditingController();
      TextEditingController categoryColorController = TextEditingController();
      bool isLoading = false;
      Category category = Category.empty;

      return BlocProvider.value(
        value: context.read<CreateCategoryBloc>(),
        child: StatefulBuilder(
          builder: (BuildContext ctx, setState) {
            return BlocListener<CreateCategoryBloc, CreateCategoryState>(
              listener: (context, state) {
                if (state is CreateCategorySuccess) {
                  Navigator.pop(ctx,category);
                } else if (state is CreateCategoryLoading) {
                  setState(() {
                    isLoading = true;
                  });
                }
              },
              child: AlertDialog(
                title: Text("Create a Category"),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 16),
                      TextFormField(
                        controller: categoryNameController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Name",
                          // prefix: Icon(FontAwesomeIcons.arrowDown),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                            // borderSide: BorderSide.none
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: categoryIconController,
                        onTap: () {
                          // if container khali
                          setState(() {
                            isExpended = !isExpended;
                          });
                        },
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Icon",
                          suffixIcon: Icon(
                            FontAwesomeIcons.chevronDown,
                            size: 12,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: isExpended
                                ? BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  )
                                : BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      isExpended
                          ? Container(
                              width: MediaQuery.of(
                                context,
                              ).size.width,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(12),
                                ),
                              ),
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                                itemCount: myCategoriIcons.length,
                                itemBuilder: (context, int i) {
                                  return Padding(
                                    padding: const EdgeInsets.all(
                                      2.0,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        iconSelected = myCategoriIcons[i];
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: iconSelected ==
                                                    myCategoriIcons[i]
                                                ? Colors.green
                                                : Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          image: DecorationImage(
                                            image: AssetImage(
                                              "assets/${myCategoriIcons[i]}.png",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container(),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: categoryColorController,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (cxt2) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ColorPicker(
                                      pickerColor: Colors.blue,
                                      onColorChanged: (value) {
                                        setState(() {
                                          categoryColor = value;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(cxt2);
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          "Save Color",
                                          style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: categoryColor,
                          hintText: "Color",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                            // borderSide: BorderSide.none
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: kToolbarHeight,
                        child: isLoading == true
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : TextButton(
                                onPressed: () {
                                  //Ceate Catagory Object and pop
                                  setState(() {
                                    category.categoryId = const Uuid().v1();
                                    category.name = categoryNameController.text;
                                    category.icon = iconSelected;
                                    category.color = categoryColor.value;
                                  });
                                  
                                  context
                                      .read<CreateCategoryBloc>()
                                      .add(CreateCategory(category));
                                  // Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  "Save",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
