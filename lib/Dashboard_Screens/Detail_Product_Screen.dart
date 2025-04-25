import 'package:flutter/material.dart';
import 'package:myfirst/Product_model.dart';

class DetailProductScreen extends StatelessWidget {
  const DetailProductScreen({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.blue,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.images.isNotEmpty)
              SizedBox(
                  height: 220,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: product.images.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              product.images[index],
                              width: 220,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      })),
            Row(
              children: [
                Text(
                  "Rs ${product.price}",
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                if (product.discountPrice != null) ...[
                  SizedBox(width: 10),
                  Text(
                    "Rs ${product.discountPrice}",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        decoration: TextDecoration.lineThrough),
                  ),
                ],
              ],
            ),
            SizedBox(height: 20),
            GridView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 3,
              ),
              children: [
                BuildDetailTile(Icons.code, "SKU", product.sku.toString()),
                BuildDetailTile(Icons.category, "Category",
                    "${product.category}> ${product.subCategory}"),
                BuildDetailTile(
                    Icons.inventory, "Stock", "${product.stock} units"),
                BuildDetailTile(Icons.scale, "Weight", "${product.weight} kg"),
                BuildDetailTile(
                    Icons.info_outline, "Condition", product.condition),
                BuildDetailTile(Icons.check_circle_outline, "Available",
                    product.isAvailable ? "yes" : "No"),
                BuildDetailTile(Icons.star_border, "Featured",
                    product.isFeatured ? "Yes" : "No"),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Description",
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              product.description,
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  Widget BuildDetailTile(IconData icon, String title, String value) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.deepPurple, size: 20),
          SizedBox(width: 8),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis),
              ),
              Text(
                value,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
