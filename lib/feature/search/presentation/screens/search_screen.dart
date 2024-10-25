import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/core/functions/navigation.dart';
import 'package:movie_app/core/utils/text_style.dart';
import 'package:movie_app/feature/details/presentation/screens/details_screen.dart';
import 'package:movie_app/feature/search/presentation/bloc/search_bloc.dart';
import 'package:movie_app/feature/search/presentation/widgets/popular_movie_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc()..add(GetPopularEvent()),
      child: Scaffold(
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            var search = context.read<SearchBloc>().searchModel?.results;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.withOpacity(0.3),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Search',
                        suffixIcon: IconButton(
                          onPressed: () {
                            context.read<SearchBloc>().add(
                                  GetSearchEvent(name: searchController.text),
                                );
                          },
                          icon: const Icon(
                            Icons.search_outlined,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    searchController.text.isEmpty
                        ? Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Gap(10),
                                Text(
                                  'Top Search',
                                  style: getTitleTextStyle(context,
                                      color: Colors.white),
                                ),
                                const Gap(10),
                                const Expanded(child: PopularMovieWidget()),
                              ],
                            ),
                          )
                        : search == null
                            ? const SizedBox()
                            : Expanded(
                                child: GridView.builder(
                                  itemCount: search.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 300,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder: (context, index) {
                                    final posterPath = search[index].posterPath;

                                    // Return the grid items directly, skipping images with a null posterPath
                                    return Center(
                                      child: InkWell(
                                        onTap: () {
                                          push(
                                              context,
                                              DetailsScreen(
                                                  movieId:
                                                      search[index].id ?? 0));
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            posterPath != null
                                                ? Image.network(
                                                    '${ApiConstants.baseImageUrl}$posterPath',
                                                    height: 250,
                                                  )
                                                : const SizedBox(), // Avoid trying to load a null image
                                            const Gap(10),
                                            Text(
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              search[index].title ?? 'No Title',
                                              style: getSmallTextStyle(
                                                context,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
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
