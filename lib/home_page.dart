import 'package:assignment_alisoft/configs/size_config.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _shimmerLoading = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 40),
              Skeleton(
                isLoading: _shimmerLoading,
                skeleton: SkeletonLine(
                  style: SkeletonLineStyle(
                      height: SizeConfig.screenHeight * 0.035,
                      width: SizeConfig.screenWidth * 0.5,
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                ),
                child: Text("data"),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 15,
                  itemBuilder: (_, i) {
                    if (i < 1) {
                      return _horizontalListView();
                    } else {
                      return _columnList();
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

  Widget _columnList() {
    return Card(
      child: SizedBox(
        height: 200,
        child: Skeleton(
          isLoading: _shimmerLoading,
          skeleton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          height: SizeConfig.screenHeight * 0.09,
                          width: SizeConfig.screenHeight * 0.09,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                    ),
                    SizedBox(width: 10),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          height: SizeConfig.screenHeight * 0.05,
                          width: SizeConfig.screenWidth * 0.6),
                    )
                  ],
                ),
                SizedBox(height: 10),
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
          ),
          child: Text("dataaa"),
        ),
      ),
    );
  }

  Widget _horizontalListView() {
    return SizedBox(
      height: SizeConfig.screenHeight * 0.245,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 7,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, __) => _rowList(),
      ),
    );
  }

  Widget _rowList() {
    return Card(
      child: SizedBox(
        width: SizeConfig.screenHeight * 0.22,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Skeleton(
              isLoading: _shimmerLoading,
              skeleton: Column(
                children: [
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: SizeConfig.screenHeight * 0.025,
                        width: SizeConfig.screenWidth * 0.3,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6))),
                  ),
                  const SizedBox(height: 5),
                  SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                        shape: BoxShape.rectangle,
                        height: 140,
                        width: 150,
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                ],
              ),
              child: Text("dataaa")),
        ),
      ),
    );
  }
}
