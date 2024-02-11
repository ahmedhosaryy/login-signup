import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled4/homescreens/product_screen.dart';

import '../data/api.dart';

class GridViewOfProductsScreen extends StatefulWidget {
  const GridViewOfProductsScreen({super.key});

  @override
  State<GridViewOfProductsScreen> createState() =>
      _GridViewOfProductsScreenState();
}

class _GridViewOfProductsScreenState extends State<GridViewOfProductsScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
     if (DataSource.listOfProduct.isEmpty) {
       DataSource.getProductsFromApi().then((value) {
         setState(() {
           isLoading = false;
         });
       });
     } else {
       isLoading = false;
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2D2F41),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Lottie.asset(
            'assets/cart.json',
            height: 100,
            width: double.infinity,
          ),
           Expanded(
             child: GridView.builder(
               itemCount: DataSource.listOfProduct.length,
               itemBuilder: (context, index) {
                 return InkWell(
                   onTap: () {
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (context) => ProductScreen(
                           product: DataSource.listOfProduct[index],
                         ),
                       ),
                     );
                   },
                   child: Stack(
                     children: [
                       Container(
                         margin: const EdgeInsets.all(10),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20),
                           image: DecorationImage(
                             image: NetworkImage(
                               DataSource
                                   .listOfProduct[index].productImage,
                             ),
                             fit: BoxFit.cover,
                           ),
                         ),
                       ),
                       Positioned(
                         right: 0,
                         bottom: 14,
                         child: Container(
                           height: 40,
                           width: 40,
                           decoration: BoxDecoration(
                             color: Colors.red,
                             borderRadius: BorderRadius.circular(40),
                           ),
                           alignment: Alignment.center,
                           child: Text(
                             DataSource.listOfProduct[index].productStock
                                 .toString(),
                             style: const TextStyle(
                               color: Colors.white,
                               fontSize: 18,
                               fontWeight: FontWeight.bold,
                           ),
                          ),
                         ),
                      ),
                       Positioned(
                         left: 11,
                         bottom: 10,
                         child: Container(
                           height: 40,
                           width: 100,
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(40),
                           ),
                          alignment: Alignment.center,
                          child: Text(
                             DataSource.listOfProduct[index].productName.toString(),
                             maxLines: 1,
                             style: const TextStyle(
                               color: Colors.black,
                               fontSize: 18,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                         ),
                       ),
                     ],
        ),

    );
    },
               gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
               ),
             ),
           ),
        ],
      ),
    );
  }
}