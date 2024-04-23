import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giventake/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:giventake/screens/home/blocs/bloc/get_product_bloc.dart';
import 'package:giventake/screens/home/views/details_screen.dart';
import 'package:giventake/screens/product/views/upload_product_screen.dart';

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
        title: Card(
          child:BlocBuilder<GetProductBloc, GetProductState> (
            builder: (context, state) {
              return TextField(
                  onChanged: (value) {
                context.read<GetProductBloc>().add(SearchProduct(value));
              },
              decoration: InputDecoration(
              prefixIcon: Icon(CupertinoIcons.search),
              hintText: 'Search Items..'),
              );
            }
          )
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(SignOutRequired());
            },
            icon: const Icon(CupertinoIcons.arrow_right_to_line),
          ),
        ],
      ),
      body: BlocBuilder<GetProductBloc, GetProductState>(
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
              child: Text("An error has occured..."),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ProductUploadScreen(),
          ));
          if (result == true) {
            context.read<GetProductBloc>().add(GetProduct());
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
