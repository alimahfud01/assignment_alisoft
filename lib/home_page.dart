import 'package:assignment_alisoft/bloc/bloc/auth_bloc.dart';
import 'package:assignment_alisoft/bloc/bloc/auth_event.dart';
import 'package:assignment_alisoft/configs/size_config.dart';
import 'package:assignment_alisoft/helper/global_variables.dart';
import 'package:assignment_alisoft/models/get_articles_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _shimmerLoading = true;
  GetArticles articles = GetArticles.createData({'': ''});
  @override
  void initState() {
    GetArticles.connectToApi().then((value) {
      if (value.code == 200) {
        articles = value;
        _shimmerLoading = false;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Skeleton(
                    isLoading: _shimmerLoading,
                    skeleton: SkeletonLine(
                      style: SkeletonLineStyle(
                          height: SizeConfig.screenHeight * 0.035,
                          width: SizeConfig.screenWidth * 0.5,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6))),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                              onPressed: () {
                                context
                                    .read<AuthBloc>()
                                    .add(const AuthEventLogout());
                              },
                              icon: const Icon(Icons.logout)),
                        ),
                        Row(
                          children: [
                            const Text(
                              'Welcome ',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              user,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 15,
                  itemBuilder: (_, i) {
                    if (i < 1) {
                      return _horizontalListView();
                    } else {
                      return _columnList(i);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _columnList(int index) {
    return Card(
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Skeleton(
            isLoading: _shimmerLoading,
            skeleton: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          height: SizeConfig.screenHeight * 0.09,
                          width: SizeConfig.screenHeight * 0.09,
                          shape: BoxShape.rectangle,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4))),
                    ),
                    const SizedBox(width: 10),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          height: SizeConfig.screenHeight * 0.05,
                          width: SizeConfig.screenWidth * 0.6),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          height: SizeConfig.screenHeight * 0.07,
                          width: SizeConfig.screenWidth * 0.9),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding:
                          EdgeInsets.only(left: SizeConfig.screenWidth * 0.3),
                      child: SkeletonLine(
                        style: SkeletonLineStyle(
                            height: SizeConfig.screenHeight * 0.03,
                            width: SizeConfig.screenWidth * 0.6),
                      ),
                    )
                  ],
                )
              ],
            ),
            child: articles.code == null
                ? const Text('data')
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                              child: Image.network(
                                articles.articles!.elementAt(index)['image'],
                                height: SizeConfig.screenHeight * 0.09,
                                width: SizeConfig.screenHeight * 0.09,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '${articles.articles!.length} ${articles.articles!.elementAt(index)['title']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        '${articles.articles!.length} ${articles.articles!.elementAt(index)['content']}',
                        maxLines: 5,
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(dateFormatted(
                            '${articles.articles!.elementAt(index)['created']['date']}')),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  String dateFormatted(String date) {
    final DateTime created = DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd MMMM yyyy, hh:mm:ss');
    final String formatted = formatter.format(created);
    return formatted;
  }

  Widget _horizontalListView() {
    return SizedBox(
      height: SizeConfig.screenWidth * 0.53,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 7,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => _rowList(index),
      ),
    );
  }

  Widget _rowList(int index) {
    return Card(
      child: SizedBox(
        width: SizeConfig.screenWidth * 0.5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Skeleton(
            isLoading: _shimmerLoading,
            skeleton: Column(
              children: [
                SkeletonLine(
                  style: SkeletonLineStyle(
                      height: SizeConfig.screenHeight * 0.025,
                      width: SizeConfig.screenWidth * 0.3,
                      borderRadius: const BorderRadius.all(Radius.circular(6))),
                ),
                const SizedBox(height: 5),
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      shape: BoxShape.rectangle,
                      height: SizeConfig.screenWidth * 0.39,
                      width: SizeConfig.screenWidth * 0.47,
                      borderRadius: const BorderRadius.all(Radius.circular(6))),
                ),
              ],
            ),
            child: articles.code == null
                ? const Text('data')
                : Column(
                    children: [
                      Text(
                        '${articles.articles!.length} ${articles.articles!.elementAt(index)['title']}',
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        articles.articles!.elementAt(index)['content'],
                        maxLines: 9,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
