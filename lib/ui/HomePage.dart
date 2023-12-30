import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:provider/provider.dart';
import 'package:test/constants/MyColors.dart';
import 'package:test/data/model/CategoryModel.dart';
import 'package:test/data/model/CountryModel.dart';
import 'package:test/data/model/ImageSliderItemModel.dart';
import 'package:test/data/repository/CityRepository.dart';
import 'package:test/providers/HomePageProvider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<HomePageProvider>(context, listen: false).getImages();
      await Provider.of<HomePageProvider>(context, listen: false)
          .getCountriesFromApi();
    });
  }

  CarouselController carouselController = CarouselController();
  int currentImage = 0;
  int currentCity = 0;
  final List<String> items = [
    'السعودية',
    'مصر',
    'العراق',
    'السعودية',
    'مصر',
    'العراق'
  ];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    var provTrue = Provider.of<HomePageProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Color(0xFFF7F3F3),
          body: SafeArea(
            child: provTrue.countryList is! List
                ? Center(
                    child: CircularProgressIndicator(color: MyColors.myred2),
                  )
                : Column(
                    children: [
                      const SizedBox(height: 10),
                      countryAppBar(),
                      ImageSlider(),
                      dotSlider(),
                      search(),
                      buildCities(),
                      buildCategories()
                    ],
                  ),
          )),
    );
  }

  Widget countryAppBar() {
    var provTrue = Provider.of<HomePageProvider>(context, listen: true);

    return Container(
      margin: EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 20),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: provTrue.countryList is List && provTrue.countryList.length > 0
              ? buildCountryItem(provTrue.countryList[0])
              : Expanded(
                  child: Text(
                    'اختر الدولة',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
          items: provTrue.countryList
              .map<DropdownMenuItem<String>>((CountryModel item) =>
                  DropdownMenuItem(
                    value: item.name,
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        item.name!,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (String? value) {
            setState(() {
              selectedValue = value;
            });
          },
          buttonStyleData: ButtonStyleData(
            height: 50,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.keyboard_arrow_down_sharp,
              size: 30,
              color: Color(0xffC0C0C0),
            ),
          ),
          dropdownStyleData: const DropdownStyleData(
            elevation: 0,
            maxHeight: 94,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              color: Colors.white,
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 28,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }

  Widget ImageSlider() {
    var provTrue = Provider.of<HomePageProvider>(context, listen: true);
    var provFalse = Provider.of<HomePageProvider>(context, listen: false);
    if (provTrue.imagesList is Null) {
      return Container(
          height: 140,
          child: Center(
              child: CircularProgressIndicator(
            color: MyColors.myred2,
          )));
    }
    if (provTrue.imagesList is String) {
      return Container(
          height: 140, child: Center(child: Text(provTrue.imagesList)));
    }

    List<ImageSliderItemModel> imagesList =
        provTrue.imagesList as List<ImageSliderItemModel>;
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 20, 8, 5),
      child: CarouselSlider(
          carouselController: carouselController,
          items: imagesList.map((e) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox.fromSize(
                      child: e.image != null
                          ? Image.network(
                              e.image!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            )
                          : CircularProgressIndicator(
                              color: MyColors.myred2,
                            ))),
            );
          }).toList(),
          options: CarouselOptions(
            height: 140,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.ease,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            scrollDirection: Axis.horizontal,
            pageSnapping: true,
            onPageChanged: (index, reason) {
              provTrue.changecurrentImage(index);
            },
          )),
    );
  }

  Widget dotSlider() {
    var proveTrue = Provider.of<HomePageProvider>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DotsIndicator(
        dotsCount:
            proveTrue.imagesList is List ? proveTrue.imagesList.length : 1,
        position: proveTrue.currentImage,
        decorator: DotsDecorator(
          color: Color.fromARGB(255, 199, 199, 199),
          activeColor: MyColors.myred2,
          size: const Size.square(4.0),
          spacing: EdgeInsets.all(2),
          activeSize: const Size(9.0, 4.0),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
    );
  }

  Widget search() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 50,
      margin: EdgeInsets.only(left: 14, right: 14),
      decoration: BoxDecoration(
          // color: Colors.red,
          border: Border.all(color: Color(0xffEAEBEC)),
          borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(
              Icons.search_rounded,
              size: 20,
              color: MyColors.myred2,
            ),
            hintText: "بحث"),
      ),
    );
  }

  Widget buildCities() {
    var prov = Provider.of<HomePageProvider>(context, listen: true);
    return FutureBuilder(
        future: HomePageProvider().getcities(1),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(
              color: MyColors.myred1,
            );
          } else if (snapshot.data is String) {
            return Text(snapshot.data);
          }

          return Container(
            margin: EdgeInsets.fromLTRB(5, 20, 5, 20),
            height: 34,
            child: ListView.builder(
                itemCount: snapshot.data.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      prov.selectCity(index);
                      await prov.getCategories(snapshot.data[index].id);
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                            color: index == prov.currentCity
                                ? MyColors.myred1
                                : null,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          snapshot.data[index].name!,
                          style: TextStyle(
                              color: prov.currentCity == index
                                  ? Colors.white
                                  : Colors.black),
                        )),
                  );
                }),
          );
        });
  }

  Widget buildCategories() {
    var provFalse = Provider.of<HomePageProvider>(context, listen: false);
    var provTrue = Provider.of<HomePageProvider>(context, listen: true);
    if (provTrue.currentCity == -1) {
      return Container(height: 140, child: Center(child: Text("اختر مدينة")));
    }
    if (provTrue.categoriesList is Null) {
      return Container(
          height: 140,
          child: Center(
              child: CircularProgressIndicator(
            color: MyColors.myred2,
          )));
    }
    if (provTrue.categoriesList is String) {
      return Container(
          height: 140, child: Center(child: Text(provTrue.imagesList)));
    }
    List<CategoryModel> cats = provTrue.categoriesList as List<CategoryModel>;
    return Expanded(
        child: Container(
      child: GridView(
          padding: EdgeInsets.all(8),
          physics: AlwaysScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          children: cats
              .map((e) => Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        Container(
                          height: 140,
                          width: 157,
                          decoration: BoxDecoration(
                              color: Color(0xFFE0E0E0),
                              borderRadius: BorderRadius.circular(8)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox.fromSize(
                                child: e.image != null
                                    ? Image.network(
                                        e.image!,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      )
                                    : CircularProgressIndicator(
                                        color: MyColors.myred2,
                                      )),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(e.name!),
                      ],
                    ),
                  ))
              .toList()),
    ));
  }

  Widget buildCountryItem(CountryModel country) {
    return Row(
      children: [
        Image.network(
          country.image!,
          width: 19,
          height: 15,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          country.name!,
          style: TextStyle(fontSize: 14),
        )
      ],
    );
  }
}
