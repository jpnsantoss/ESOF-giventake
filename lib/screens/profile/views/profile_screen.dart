import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giventake/app_view.dart';
import 'package:giventake/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:giventake/screens/home/views/details_screen.dart';
import 'package:giventake/screens/home/views/edit_profile_screen.dart';
import 'package:giventake/screens/profile/blocs/add_review_bloc/add_review_bloc.dart';
import 'package:giventake/screens/profile/blocs/get_reviews/get_reviews_bloc.dart';
import 'package:giventake/screens/profile/blocs/get_user_products/get_user_products_bloc.dart';
import 'package:giventake/screens/profile/views/products_screen.dart';
import 'package:giventake/screens/profile/views/reviews_screen.dart';
import 'package:product_repository/product_repository.dart';
import 'package:review_repository/review_repository.dart';
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
    filterUserProducts();
  }

  Future<void> filterUserProducts() async {
    try {
      final productList = await widget.productRepo.getProducts();
      final filteredProducts = productList
          .where((product) => product.userId == widget.user.userId)
          .toList();
      setState(() {
        userProducts = filteredProducts;
        print(
            'User products length: ${userProducts.length}'); // Atualizar a lista de produtos no estado
      });
    } catch (e) {
      // Trate os erros conforme necessário
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (widget.user.userId == FirebaseAuth.instance.currentUser?.uid)
            IconButton(
              onPressed: () async {
                final FirebaseAuth auth = FirebaseAuth.instance;
                final user = auth.currentUser;
                if (user != null) {
                  String userId = user.uid;
                  MyUser currentUser = await FirebaseUserRepo().getUser(userId);

                  await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                      userId: userId,
                      user: MyUserEntity(
                        userId: userId,
                        email: currentUser.email,
                        name: currentUser.name,
                        rating: currentUser.rating,
                        bio: currentUser.bio,
                        image: currentUser.image,
                      ),
                    ),
                  ));
                }
              },
              icon: const Icon(Icons.edit),
            ),
          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(SignOutRequired());
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const MyAppView(),
                ),
              );
            },
            icon: const Icon(CupertinoIcons.arrow_right_to_line),
          ),
        ],
      ),
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
                      Container(
                        width: 344.53,
                        height: 235.09,
                        padding: const EdgeInsets.all(20.08),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.84, color: Color(0xFFECEAEB)),
                            borderRadius: BorderRadius.circular(8.37),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x26000000),
                              blurRadius: 8,
                              offset: Offset(0, 6),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 304.37,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 53.54,
                                                height: 53.54,
                                                decoration: ShapeDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        widget.user.image),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            83.66),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 16.73),
                                              Container(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      widget.user.name,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF212121),
                                                        fontSize: 16.73,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 32),
                                        Container(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      widget.user.rating == 0.0
                                                          ? 'No ratings yet'
                                                          : 'Rating: ${widget.user.rating}',
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13.39,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 1.67),
                                              BlocProvider(
                                                create: (context) =>
                                                    GetReviewsBloc(
                                                  FirebaseReviewRepo(),
                                                  FirebaseUserRepo(),
                                                )..add(GetReviewsCount(
                                                        widget.user.userId)),
                                                child: BlocBuilder<
                                                    GetReviewsBloc,
                                                    GetReviewsState>(
                                                  builder: (context, state) {
                                                    if (state
                                                        is GetReviewsCountProcess) {
                                                      return const Text(
                                                        'Loading...',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF818181),
                                                          fontSize: 13.39,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 0,
                                                        ),
                                                      );
                                                    } else if (state
                                                        is GetReviewsCountSuccess) {
                                                      return Text(
                                                        '${state.reviews} reviews',
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFF818181),
                                                          fontSize: 13.39,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 0,
                                                        ),
                                                      );
                                                    } else if (state
                                                        is GetReviewsCountFailure) {
                                                      return const Text(
                                                        'Error: Failed to load reviews',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF818181),
                                                          fontSize: 13.39,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 0,
                                                        ),
                                                      );
                                                    }
                                                    return Container(); // or a default text
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20.08),
                                  Container(
                                    width: double.infinity,
                                    decoration: const ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 2.51,
                                          strokeAlign:
                                              BorderSide.strokeAlignCenter,
                                          color: Color(0xFFECEAEB),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20.08),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 96.23,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 304.37,
                                            height: 101.23,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFFD9D9D9),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.69),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 12.51,
                                          top: 2.53,
                                          child: Text(
                                            widget.user.bio,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.04,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                            Tab(
                              child: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Text(
                                  'Products',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Tab(
                              child: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Text(
                                  'Reviews',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
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
                            Padding(
                              padding: const EdgeInsets.all(22.0),
                              child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: ListView.separated(
                                    itemCount: userProducts.length,
                                    itemBuilder: (context, index) {
                                      final productt = userProducts[index];
                                      productt.user = MyUser(
                                          userId: widget.user.userId,
                                          email: widget.user.email,
                                          name: widget.user.name,
                                          bio: widget.user.bio,
                                          rating: widget.user.rating,
                                          image: widget.user.image);
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(
                                                  0.4), // Cor da sombra
                                              spreadRadius:
                                                  4, // Raio de propagação da sombra
                                              blurRadius:
                                                  9, // Raio de desfoque da sombra
                                              offset: const Offset(0,
                                                  3), // Deslocamento da sombra
                                            ),
                                          ],
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              height: 250,
                                              width: double.infinity,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                child: Image.network(
                                                  productt.image,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              productt.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              productt.location,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      width:
                                                          50, // adjust these values as needed
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              productt
                                                                  .user!.image),
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5), // adjust this value to change the roundness of the corners
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          productt.user!.name,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.yellow,
                                                            ),
                                                            Text(productt
                                                                .user!.rating
                                                                .toString()),
                                                            const SizedBox(
                                                                width: 5),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(width: 10),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailsScreen(
                                                          product: productt,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.black,
                                                    foregroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  child:
                                                      const Text("See Details"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                          height:
                                              20); // adjust the height as needed
                                    },
                                  )),
                            ),
                            MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) => GetReviewsBloc(
                                    FirebaseReviewRepo(),
                                    FirebaseUserRepo(),
                                  )..add(GetReviews(widget.user.userId)),
                                ),
                                BlocProvider(
                                  create: (context) => AddReviewBloc(
                                    FirebaseReviewRepo(),
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
