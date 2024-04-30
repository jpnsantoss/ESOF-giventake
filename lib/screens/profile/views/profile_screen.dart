import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giventake/screens/home/blocs/bloc/get_product_bloc.dart';
import 'package:giventake/screens/home/views/details_screen.dart';
import 'package:giventake/screens/profile/blocs/get_user_products/get_user_products_bloc.dart';
import 'package:giventake/screens/profile/views/products_screen.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';

class ProfileScreen extends StatefulWidget {
  final MyUserEntity user;
  final ProductRepo productRepo;

  const ProfileScreen({
    super.key,
    required this.user,
    required this.productRepo,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  late List<Product> userProducts = [];
  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    filterUserProducts(); // Filtrar os produtos do usuário
  }

  // Método para filtrar os produtos do usuário
  Future<void> filterUserProducts() async {
    try {
      final productList = await widget.productRepo.getProducts();
      final filteredProducts = productList
          .where((product) => product.userId == widget.user.userId)
          .toList();
      setState(() {
        userProducts =
            filteredProducts; // Atualizar a lista de produtos no estado
      });
    } catch (e) {
      // Trate os erros conforme necessário
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  child: Column(
                    children: [
                      Align(
                        alignment:
                            Alignment.centerLeft, // Alinha o texto à esquerda
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            widget.user.name,
                            style: const TextStyle(
                              fontSize: 24, // Tamanho da fonte grande
                              fontWeight: FontWeight.bold, // Negrito
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      Align(
                        alignment:
                            Alignment.centerLeft, // Alinha o texto à esquerda

                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            widget.user.rating == 0.0
                                ? 'No ratings yet'
                                : 'Rating: ${widget.user.rating}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      Align(
                        alignment:
                            Alignment.centerLeft, // Alinha o texto à esquerda
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            '${widget.user.reviews.length} reviews',
                            style: const TextStyle(
                              fontSize:
                                  16, // Tamanho da fonte para o número de reviews
                              fontWeight: FontWeight.bold, // Negrito
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                          height: 15), // Espaçamento entre o nome e a biografia
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),

                        padding: const EdgeInsets.all(8), // Espaçamento interno
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 193, 191, 191),
                          border: Border.all(
                              color: Colors.black), // Adiciona uma borda preta
                          borderRadius:
                              BorderRadius.circular(8), // Borda arredondada
                        ),
                        child: Text(
                          widget.user.bio,
                          style: const TextStyle(
                            fontSize: 16, // Tamanho da fonte para a biografia
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: TabBar(
                          isScrollable: true,
                          controller: tabController,
                          unselectedLabelColor: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.5),
                          labelColor:
                              Theme.of(context).colorScheme.onBackground,
                          indicatorSize: TabBarIndicatorSize.label,
                          tabs: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Products',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Reviews',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: TabBarView(
                        controller: tabController,
                        children: [
                          BlocProvider(
                            create: (context) => GetUserProductsBloc(
                              FirebaseProductRepo(),
                            )..add(GetUserProducts(widget.user.userId)),
                            child: const ProductsScreen(),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: widget.user.reviews.map((review) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      padding: const EdgeInsets.all(20.0),
                                      width: 350,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(
                                                0.5), // Cor da sombra
                                            spreadRadius:
                                                3, // Raio de propagação da sombra
                                            blurRadius:
                                                7, // Raio de desfoque da sombra
                                            offset: const Offset(
                                                0, 3), // Deslocamento da sombra
                                          ),
                                        ],
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('User: ${review['username']}'),
                                          const SizedBox(
                                              height:
                                                  8), // Espaçamento entre as linhas
                                          Text('${review['review']}'),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
