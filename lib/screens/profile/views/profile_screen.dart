import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giventake/screens/profile/blocs/add_review_bloc/add_review_bloc.dart';
import 'package:giventake/screens/profile/blocs/get_reviews/get_reviews_bloc.dart';
import 'package:giventake/screens/profile/blocs/get_user_products/get_user_products_bloc.dart';
import 'package:giventake/screens/profile/views/products_screen.dart';
import 'package:giventake/screens/profile/views/reviews_screen.dart';
import 'package:product_repository/product_repository.dart';
import 'package:review_repository/request_repository.dart';
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
  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
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
                            MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) => GetReviewsBloc(
                                    FirebaseReviewRepo(),
                                  )..add(GetReviews(widget.user.userId)),
                                ),
                                BlocProvider(
                                  create: (context) => AddReviewBloc(
                                    FirebaseReviewRepo(), // replace with the actual dependencies of AddReviewBloc
                                  ),
                                ),
                              ],
                              child: ReviewsScreen(
                                toUserId: widget.user.userId,
                              ),
                            ),
                          ],
                        ),
                      ),
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
