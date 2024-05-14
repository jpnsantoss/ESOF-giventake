import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giventake/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:giventake/screens/home/blocs/get_product_bloc/get_product_bloc.dart';
import 'package:giventake/screens/home/views/details_screen.dart';
import 'package:giventake/screens/home/views/edit_profile_screen.dart';
import 'package:giventake/screens/product/views/upload_product_screen.dart';
import 'package:user_repository/user_repository.dart';


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
    return Scaffold(
        appBar: AppBar(
          title: Text(
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
                // Handle envelope icon tap
              },
              icon: Icon(Icons.mail_outline), // Envelope symbol icon
            ),
            IconButton(
              onPressed: () {
                // Handle profile icon tap
              },
              icon: CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage("https://via.placeholder.com/30x30"),
              ), // Circle with profile image icon
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Give things another chance',
                style: TextStyle(
                  color: Color(0xFF6C8A47),
                  fontSize: 100,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Card(
              child: BlocBuilder<GetProductBloc, GetProductState>(
                builder: (context, state) {
                  return TextField(
                    onChanged: (value) {
                      context.read<GetProductBloc>().add(SearchProduct(value));
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.search),
                      hintText: 'Search Items..',
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<GetProductBloc, GetProductState>(
                builder: (context, state) {
                  if (state is GetProductSuccess) {
                    return ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.products[index].title),
                          subtitle: Text(state.products[index].description),
                          leading: Image.network(state.products[index].image),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    DetailsScreen(product: state.products[index]),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else if (state is GetProductProcess) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const Center(
                      child: Text("An error has occurred..."),
                    );
                  }
                },
              ),
            ),
          ],
        ),

  floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 30.0, bottom: 16.0, right: 0.0),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Alinha o botão à direita
            children: [
              FloatingActionButton(
                heroTag: 'btn1',
                onPressed: () async {
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  final user = auth.currentUser;
                  String userId = user!.uid;
                  MyUser currentUser = await FirebaseUserRepo().getUser(userId);

                  final result =await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditProfileScreen(userId: userId, user: MyUserEntity(userId: userId, email: currentUser.email, name: currentUser.name, reviews: currentUser.reviews, rating: currentUser.rating, bio: currentUser.bio, image: currentUser.image,   )),
          ));
                },
                child: const Icon(Icons.person),
              ),
              const Spacer(), // Espaçamento entre os botões
              FloatingActionButton(
                heroTag: 'btn2',
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
                child: const Icon(Icons.add),
              ),
            ],
          ),

        ));
  }
}
      
