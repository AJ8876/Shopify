import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myfirst/Dashboard_Screens/Home_Screen.dart';
import 'package:myfirst/Global_List.dart';
import 'package:myfirst/Product_model.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formkey = GlobalKey<FormState>();
  bool _isavailable = true;
  String _productcondition = "New";
  bool isfeatured = false;
  List<File> selectedimages = [];
  String? _selectedCategory;
  String? _selectedSubCategory;
  List<String> _FilterSubCategory = [];
  final List<String> _Categories = [
    'Electronics',
    'Clothing',
    'Furniture',
    'Books',
    'Home Appliances',
    'Toys',
    'Beauty',
    'Sports',
    'Groceries',
    'Stationery',
  ];
  final Map<String, List<String>> _SubCategories = {
    'Electronics': ['Mobile', 'Laptop', 'TV', 'Headphones', 'Camera'],
    'Clothing': ['Shirts', 'Pants', 'Shoes', 'Jackets', 'Hats'],
    'Furniture': ['Table', 'Chair', 'Sofa', 'Bed', 'Cabinet'],
    'Books': ['Fiction', 'Non-fiction', 'Comics', 'Biography'],
    'Home Appliances': ['Microwave', 'Washing Machine', 'Refrigerator'],
    'Toys': ['Action Figures', 'Educational Toys', 'Dolls'],
    'Beauty': ['Makeup', 'Skincare', 'Haircare'],
    'Sports': ['Cricket', 'Football', 'Tennis', 'Gym Equipment'],
    'Groceries': ['Vegetables', 'Fruits', 'Beverages', 'Snacks'],
    'Stationery': ['Pens', 'Notebooks', 'Markers', 'Folders'],
  };

  TextEditingController ProductNameController = TextEditingController();
  TextEditingController ProductDescriptionController = TextEditingController();
  TextEditingController PriceController = TextEditingController();
  TextEditingController DiscountPriceController = TextEditingController();
  TextEditingController StockKeepingUnitController = TextEditingController();
  TextEditingController StockQuantityController = TextEditingController();
  TextEditingController ShippingWeightController = TextEditingController();

  TextEditingController CategoryController = TextEditingController();
  TextEditingController SubCategoryController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedimages.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Product Screen",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: ProductNameController,
                decoration: InputDecoration(
                  labelText: "Product Name",
                  prefixIcon: Icon(Icons.production_quantity_limits),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value){
                  if(value==null || value.trim().isEmpty){
                    return "This Field is Required";
                  }
                    return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                maxLines: 3,
                controller: ProductDescriptionController,
                decoration: InputDecoration(
                  labelText: "Product Description",
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value){
                  if (value==null || value.trim().isEmpty){
                    return "This Field is Required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: PriceController,
                decoration: InputDecoration(
                  labelText: "Price",
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value){
                  if (value==null || value.trim().isEmpty){
                    return "This Field is Required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: DiscountPriceController,
                decoration: InputDecoration(
                  labelText: "Discount Price (Optional)",
                  prefixIcon: Icon(Icons.local_offer),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value){
                  if (value==null || value.trim().isEmpty){
                    return "This Field is Required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: StockKeepingUnitController,
                decoration: InputDecoration(
                  labelText: "SKU (Stock Keeping Unit )",
                  prefixIcon: Icon(Icons.qr_code),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value){
                  if (value==null || value.trim().isEmpty){
                    return "This Field is Required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Category",
                    prefixIcon: Icon(Icons.category),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                    validator:  (value){
                    if (value==null || value.trim().isEmpty){
                      return "Please Select a Category";
                    }
                    return null;
                    },
                  value: _selectedCategory,
                  onChanged: (String? NewValue) {
                    setState(() {
                      _selectedCategory = NewValue;
                      _FilterSubCategory = _SubCategories[NewValue] ?? [];
                      _selectedSubCategory = null;
                    });
                  },
                  items: _Categories.map((Category) {
                    return DropdownMenuItem<String>(
                      value: Category,
                      child: Text(Category),
                    );
                  }).toList()),
              SizedBox(height: 15),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Sub Category",
                  prefixIcon: Icon(Icons.list),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value){
                  if (value==null || value.trim().isEmpty){
                    return "Please Select a Category";
                  }
                  return null;
                },
                value: _selectedSubCategory,
                onChanged: (String? NewValue) {
                  setState(() {
                    _selectedSubCategory = NewValue;
                  });
                },
                items: _FilterSubCategory.map((SubCategory) {
                  return DropdownMenuItem(
                    child: Text(SubCategory),
                    value: SubCategory,
                  );
                }).toList(),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: StockQuantityController,
                decoration: InputDecoration(
                  labelText: "Stock Quantity",
                  prefixIcon: Icon(Icons.inventory),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value){
                  if (value==null || value.trim().isEmpty){
                    return "This Field is Required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: ShippingWeightController,
                decoration: InputDecoration(
                  labelText: "Shipping Weight (Kg)",
                  prefixIcon: Icon(Icons.scale),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value){
                  if (value==null || value.trim().isEmpty){
                    return "This Field is Required";
                  }
                    return null;
                },
              ),
              SizedBox(height: 15),
              SwitchListTile(
                value: _isavailable,
                onChanged: (value) {
                  setState(
                    () {
                      _isavailable = value;
                    },
                  );
                },
                title: Text("Availability (In Stock)"),
              ),
              SizedBox(height: 15),
              Text(
                "Product Condition",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Radio(
                    value: "New",
                    groupValue: _productcondition,
                    onChanged: (value) {
                      setState(() {
                        _productcondition = value!;
                      });
                    },
                  ),
                  Text("New"),
                  Radio(
                    value: "Use",
                    groupValue: _productcondition,
                    onChanged: (value) {
                      setState(() {
                        _productcondition = value!;
                      });
                    },
                  ),
                  Text("Use"),
                ],
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:
                      isfeatured ? Colors.blue.shade50 : Colors.grey.shade200,
                  border: Border.all(
                    color: isfeatured ? Colors.blue : Colors.grey,
                    width: 2,
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Feature this Product",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            isfeatured
                                ? "This Product Will be Shown as a Feature Product"
                                : "Mark this Product as Featured to Highlight it",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isfeatured = !isfeatured;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isfeatured ? Colors.red : Colors.green),
                        child: Text(
                          isfeatured ? "Remove" : "Mark as a Featured",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Product Images: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    label: Text("Upload"),
                    icon: Icon(Icons.image),
                  )
                ],
              ),
              SizedBox(height: 10),
              selectedimages.isNotEmpty
                  ? Wrap(
                      spacing: 10,
                      children: selectedimages.map((image) {
                        return Image.file(image,
                            height: 80, width: 80, fit: BoxFit.cover);
                      }).toList(),
                    )
                  : Center(child: Text("No Images Selected")),
              SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ()async {
                    if (_formkey.currentState!.validate()) {
                      AllProducts.add(
                        Product(
                          name: ProductNameController.text,
                          description: ProductDescriptionController.text,
                          price: int.parse(PriceController.text),
                          sku: int.parse(StockQuantityController.text),
                          discountPrice: DiscountPriceController.text.isNotEmpty?
                          int.parse(DiscountPriceController.text) : null,
                          category: _selectedCategory!,
                          subCategory: _selectedSubCategory!,
                          stock: int.parse(StockQuantityController.text),
                          weight: ShippingWeightController.text,
                          isAvailable: _isavailable,
                          isFeatured: isfeatured,
                          condition: _productcondition,
                          images: selectedimages,
                        ),
                      );
                      Fluttertoast.showToast(
                        msg: "Your Product is added Successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 15.0,
                      );
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => HomeScreen()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Add Product",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
