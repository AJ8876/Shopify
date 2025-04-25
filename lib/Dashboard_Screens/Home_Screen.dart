import 'package:flutter/material.dart';

import '../Global_List.dart';
import 'Add_Product.dart';
import 'Detail_Product_Screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => AddProduct()),
            );// Goes back to the previous screen
          },
        ),
        title: const Text("All Products",style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 4,
      ),
      body: AllProducts.isEmpty
          ? const Center(child: Text("No Products Added Yet"))
          : Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: AllProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final product = AllProducts[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailProductScreen(product: product,),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 6,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12)),
                      child: product.images.isNotEmpty
                          ? Image.file(
                        product.images[0],
                        height: 130,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                          : Container(
                        height: 130,
                        color: Colors.grey[300],
                        child: const Center(
                            child: Icon(Icons.image, size: 50)),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),

                              // ✅ PRICE AND DISCOUNT
                              Row(
                                children: [
                                  Text(
                                    "Rs. ${product.price}",
                                    style: const TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (product.discountPrice != null) ...[
                                    const SizedBox(width: 6),
                                    Text(
                                      "Rs. ${product.discountPrice}",
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text("Category: ${product.category}", style: const TextStyle(fontSize: 12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Stock: ${product.stock} units",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: product.isAvailable ? Colors.green : Colors.red,
                                ),
                              ),

                              const SizedBox(height: 4),
                              Text("Category: ${product.category}",
                                  style: const TextStyle(fontSize: 12)),
                              Text(
                                "Stock: ${product.isAvailable ? 'In Stock' : 'Out of Stock'}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: product.isAvailable
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}