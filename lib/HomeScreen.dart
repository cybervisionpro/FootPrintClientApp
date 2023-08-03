import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_social_media_app/InstagramScreen.dart';
import 'package:flutter_social_media_app/RedditScreen.dart';
import 'package:flutter_social_media_app/TwitterScreen.dart';
import 'package:flutter_social_media_app/UserUtil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'FacebookScreen.dart';
import 'User.dart';
import 'QuoraScreen.dart';
import 'custom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  int _selectedBottomNavIndex = -1;
  late TabController _tabController;
  late User currentUser;
  late Uri currentUri;
  String instaPageUrl = "https://www.instagram.com/accounts/login/";
  String fbPageUrl = "https://m.facebook.com";
  String linkedInUrl = "https://www.linkedin.com/";
  String twitterUrl = "https://mobile.twitter.com/";
  String redditUrl = "https://www.reddit.com/";
  String quoraUrl = "https://www.reddit.com/";

  @override
  void initState() {
    super.initState();
    saveAllUser();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(_handleTabIndexChanged);

  }

  void saveAllUser() {
    List<User> userList = [];
    userList.add(User(
        userId: "user_1",
        instagramId: "vikas_cvfb",
        facebookId: "100089295020567",
        quoraId: "vikas_youtube"));
    userList.add(User(
        userId: "user_2",
        instagramId: "souravkumar1600",
        facebookId: "100089627920623",
        quoraId: "krishna_youtube"));
    userList.add(User(
        userId: "user_3",
        instagramId: "amitkumar2022488",
        facebookId: "100089834732359",
        quoraId: "akash_youtube"));
    //new ids
    userList.add(User(
        userId: "user_4",
        instagramId: "srishtirana8465",
        facebookId: "100090689516892",
        twitterId: "srishtirana886",
        redditId: "srishtirana886",
        quoraId: ""));
    userList.add(User(
        userId: "user_5",
        instagramId: "vikassindhu685",
        facebookId: "100089872172749",
        twitterId: "VikasSi6119739",
        redditId: "vikassindhu685",
        quoraId: "Sindhuvikas738"));
    userList.add(User(
        userId: "user_6",
        instagramId: "ha_rshita9336",
        facebookId: "100090956355465",
        twitterId: "HVirodhiya30129",
        redditId: "ha_rshita9336",
        quoraId: "Ha123-1"));
    userList.add(User(
        userId: "user_7",
        instagramId: "shisharma7058",
        facebookId: "100090342517790",
        twitterId: "snapshivam22",
        redditId: "shisharma7058",
        quoraId: "snapshivam22"));
    userList.add(User(
        userId: "user_8",
        instagramId: "jaiverma1449",
        facebookId: "100093189203515",
        twitterId: "Jai9337",
        redditId: "BornQuantity9008",
        quoraId: "Jai-Verma-364"));

    UserUtil.instance.saveUserList(userList);
  }

  void _currentUri(Uri uri, User? currentUser) {
    currentUri = uri;
    setState(() {
      if (currentUser != null) {
        instaPageUrl = "https://www.instagram.com/${currentUser.instagramId}";
        fbPageUrl =
            "https://m.facebook.com/profile.php?id=${currentUser.facebookId}";
        twitterUrl = "https://mobile.twitter.com/${currentUser.twitterId}";
        redditUrl = "https://www.reddit.com/user/${currentUser.redditId}";
        quoraUrl = "https://www.quora.com/profile/${currentUser.quoraId}";
      } else {
        instaPageUrl = "https://www.instagram.com";
        fbPageUrl = "https://m.facebook.com";
        twitterUrl = "https://mobile.twitter.com/";
        redditUrl = "https://www.reddit.com/";
        quoraUrl = "https://www.quora.com/";
      }
    });
    print("_currentUri  called  ${uri..toString()} ");
  }

  void _handleTabIndexChanged() {
    setState(() {
      _currentIndex = _tabController.index;
      if(_currentIndex == 0){
        _selectedBottomNavIndex = 1;
      }else{
        _selectedBottomNavIndex = -1;
      }

    });
  }

  void _onItemTapped(int index) {}

  @override
  Widget build(BuildContext context) {
    print(
        "Build Method Called  ||||||||||||||||||   handleTabIndex change MAIN BUILD  |||$instaPageUrl ||| $fbPageUrl |||   |||||||||||||||||||| called } ");
    //double size = (((MediaQuery.of(context).size.width) - 300)*0.0667)+42;
    double screenWidth = MediaQuery.of(context).size.width;
    double size = (((screenWidth - 600) * 0.0667) + 42).clamp(42, double.infinity);
    double tabIcSize  = size+14;
    print("--------------Height: ${MediaQuery.of(context).size.height} || Width: ${MediaQuery.of(context).size.width}");
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 1,
        elevation: 12,
        backgroundColor: Color(0xfff4f5fc),
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60.0),
          bottomRight: Radius.circular(60.0),
        )),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorWeight: 2.0,
          indicatorColor: Color(0xe7ed1f96),
          indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
          tabs: <Widget>[
            _currentIndex == 0
                ? Tab(
                    height: tabIcSize,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xe7ed1f96).withOpacity(0.45),
                              // Set the shadow color
                              spreadRadius: -16.spMin,
                              // Set the spread radius
                              blurRadius: 12.spMin,
                              // Set the blur radius
                              offset: Offset(3.spMin, 8.spMin), // Set the shadow offset
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          "assets/ic_instagram_selected.svg",
                          height: tabIcSize,
                        ),
                      ),
                    ),
                  )
                : Tab(
                    height: tabIcSize,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              // Set the shadow color
                              spreadRadius: -12.spMin,
                              // Set the spread radius
                              blurRadius: 12.spMin,
                              // Set the blur radius
                              offset: Offset(6.spMin, 6.spMin), // Set the shadow offset
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          "assets/ic_instagram_unselected.svg",
                          height:tabIcSize,
                        ),
                      ),
                    ),
                  ),
            _currentIndex == 1
                ? Tab(
                    height: tabIcSize,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xe7ed1f96).withOpacity(0.45),
                              // Set the shadow color
                              spreadRadius: -16.spMin,
                              // Set the spread radius
                              blurRadius: 12.spMin,
                              // Set the blur radius
                              offset: Offset(3.spMin, 8.spMin), // Set the shadow offset
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          "assets/ic_facebook_selected.svg",
                          height:tabIcSize,
                        ),
                      ),
                    ),
                  )
                : Tab(
                    height: tabIcSize,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              // Set the shadow color
                              spreadRadius: -12.spMin,
                              // Set the spread radius
                              blurRadius: 12.spMin,
                              // Set the blur radius
                              offset: Offset(6.spMin, 6.spMin), // Set the shadow offset
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          "assets/ic_facebook_unselected.svg",
                          height: tabIcSize,
                        ),
                      ),
                    ),
                  ),
            _currentIndex == 2
                ? Tab(
                    height: tabIcSize,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xe7ed1f96).withOpacity(0.45),
                              // Set the shadow color
                              spreadRadius: -16.spMin,
                              // Set the spread radius
                              blurRadius: 12.spMin,
                              // Set the blur radius
                              offset: Offset(3.spMin, 8.spMin), // Set the shadow offset
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          "assets/ic_twitter_selected.svg",
                          height: tabIcSize,
                        ),
                      ),
                    ),
                  )
                : Tab(
                    height: tabIcSize,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              // Set the shadow color
                              spreadRadius: -12.spMin,
                              // Set the spread radius
                              blurRadius: 12.spMin,
                              // Set the blur radius
                              offset: Offset(6.spMin, 6.spMin), // Set the shadow offset
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          "assets/ic_twitter_unselected.svg",
                          height: tabIcSize,
                        ),
                      ),
                    ),
                  ),
            _currentIndex == 3
                ? Tab(
                    height: tabIcSize,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xe7ed1f96).withOpacity(0.45),
                              // Set the shadow color
                              spreadRadius: -16.spMin,
                              // Set the spread radius
                              blurRadius: 12.spMin,
                              // Set the blur radius
                              offset: Offset(3.spMin, 8.spMin), // Set the shadow offset
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          "assets/ic_reddit_selected.svg",
                          height: tabIcSize,
                        ),
                      ),
                    ),
                  )
                : Tab(
                    height: tabIcSize,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              // Set the shadow color
                              spreadRadius: -12.spMin,
                              // Set the spread radius
                              blurRadius: 12.spMin,
                              // Set the blur radius
                              offset: Offset(6.spMin, 6.spMin), // Set the shadow offset
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          "assets/ic_reddit_unselected.svg",
                          height: tabIcSize,
                        ),
                      ),
                    ),
                  ),
            _currentIndex == 4
                ? Tab(
                    height: tabIcSize,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xe7ed1f96).withOpacity(0.45),
                              // Set the shadow color
                              spreadRadius: -16.spMin,
                              // Set the spread radius
                              blurRadius: 12.spMin,
                              // Set the blur radius
                              offset: Offset(3.spMin, 8.spMin), // Set the shadow offset
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          "assets/ic_quora_selected.svg",
                          height: tabIcSize,
                        ),
                      ),
                    ),
                  )
                : Tab(
                    // icon: SvgPicture.asset("assets/ic_quora_unselected.svg"),
                    height: tabIcSize,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              // Set the shadow color
                              spreadRadius: -12.spMin,
                              // Set the spread radius
                              blurRadius: 12.spMin,
                              // Set the blur radius
                              offset: Offset(6.spMin, 6.spMin), // Set the shadow offset
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          "assets/ic_quora_unselected.svg",
                          height: tabIcSize,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          InstagramScreen(_currentUri, instaPageUrl),
          FacebookScreen(_currentUri, fbPageUrl),
          TwitterScreen(_currentUri, twitterUrl),
          RedditScreen(_currentUri, redditUrl),
          QuoraScreen(_currentUri, quoraUrl),
        ],
      ),
      bottomNavigationBar: CircleNavBar(
        onTap: (index) {
          print("Print this index $index");
          if (index == 1) {
            setState(() {
              instaPageUrl = "https://www.instagram.com";
              _selectedBottomNavIndex = index;
              _tabController.index = 0;
            });
          }
        },
        activeIcons: [
          Image.asset("assets/ic_infinite.png",),
          Image.asset("assets/ic_home_selected.png"),
          Image.asset("assets/ic_mic_unselected.png"),
          Image.asset("assets/ic_profile.png"),
          Image.asset("assets/ic_nav_settings.png"),
        ],
        inactiveIcons: [
          Image.asset("assets/ic_infinite.png"),
          Image.asset("assets/ic_home_unselected.png"),
          Image.asset("assets/ic_mic_unselected.png", height: size-10,width: size-10,),
          Image.asset("assets/ic_profile.png"),
          Image.asset("assets/ic_nav_settings.png"),
        ],
        color: Colors.white,
        circleColor: Colors.white,
        height: size,
        circleWidth: size,
        padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(0),
          bottomLeft: Radius.circular(0),
        ),
        shadowColor: Colors.deepPurple,
        circleShadowColor: Colors.deepPurple,
        elevation: 10,
        activeIndex: _selectedBottomNavIndex,
      ),
    );
  }
}
