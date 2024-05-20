import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giventake/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:giventake/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:giventake/screens/home/blocs/get_product_bloc/get_product_bloc.dart';
import 'package:giventake/screens/home/views/details_screen.dart';
import 'package:giventake/screens/home/views/edit_profile_screen.dart';
import 'package:giventake/screens/product/views/upload_product_screen.dart';
import 'package:giventake/screens/profile/views/profile_screen.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:giventake/screens/home/views/requests_screen.dart';
import 'package:giventake/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Atualiza a lista de produtos sempre que a tela for exibida
    context.read<GetProductBloc>().add(GetProduct());
  }

  @override
  Widget build(BuildContext context) {
    // final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    // String photoURL = authBloc.state.user?.photoURL ?? 'default_url';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GiveNTake',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(SignOutRequired());
            },
            icon: const Icon(CupertinoIcons.arrow_right_to_line),
          ),

          IconButton(
            onPressed: () async {
              final FirebaseAuth auth = FirebaseAuth.instance;
              final user = auth.currentUser;
              String userId = user!.uid;
              MyUser currentUser = await FirebaseUserRepo().getUser(userId);

              final result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RequestsScreen(
                    userId: userId,
                    user: MyUserEntity(
                      userId: userId,
                      email: currentUser.email,
                      name: currentUser.name,
                      rating: currentUser.rating,
                      bio: currentUser.bio,
                      image: currentUser.image,
                    )),
              ));
            },
            icon: const Icon(Icons.mail_outline), // Envelope symbol icon
          ),
          IconButton(
            onPressed: () async {
              final FirebaseAuth auth = FirebaseAuth.instance;
              final user = auth.currentUser;
              if (user != null) {
                String userId = user.uid;
                MyUser currentUser = await FirebaseUserRepo().getUser(userId);

                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => SignInBloc(
                        context.read<AuthenticationBloc>().userRepository,
                      ),
                      child: ProfileScreen(
                        user: MyUserEntity(
                          userId: userId,
                          email: currentUser.email,
                          name: currentUser.name,
                          rating: currentUser.rating,
                          bio: currentUser.bio,
                          image: currentUser.image,
                        ),
                        productRepo: FirebaseProductRepo(),
                      ),
                    ),
                  ),
                );
              }
            },
            icon: FutureBuilder<MyUser>(
              future: FirebaseUserRepo()
                  .getUser(FirebaseAuth.instance.currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey,
                  );
                } else if (snapshot.hasError) {
                  return const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.error, color: Colors.white),
                  );
                } else if (snapshot.hasData) {
                  final currentUser = snapshot.data!;
                  return CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(currentUser.image),
                  );
                } else {
                  return const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey,
                  );
                }
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Give things\nanother chance",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 20), // give it some space
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        context
                            .read<GetProductBloc>()
                            .add(SearchProduct(value));
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(CupertinoIcons.search),
                        hintText: 'Search Items..',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // give it some space
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () async {
                      final result =
                          await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ProductUploadScreen(),
                      ));
                      if (result == true) {
                        // ignore: use_build_context_synchronously
                        context.read<GetProductBloc>().add(GetProduct());
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // give it some space
            Expanded(
              child: BlocBuilder<GetProductBloc, GetProductState>(
                builder: (context, state) {
                  if (state is GetProductSuccess) {
                    return ListView.separated(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 250,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    state.products[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                state.products[index].title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                state.products[index].location,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            50, // adjust these values as needed
                                        height: 50,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(state
                                                .products[index].user!.image),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              5), // adjust this value to change the roundness of the corners
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.products[index].user!.name,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              Text(state
                                                  .products[index].user!.rating
                                                  .toString()),
                                              const SizedBox(width: 5),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
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
                                          builder: (context) => DetailsScreen(
                                            product: state.products[index],
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text("See Details"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                            height: 20); // adjust the height as needed
                      },
                    );
                  } else if (state is GetProductProcess) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const Center(
                      child: Text("An error has occured..."),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
