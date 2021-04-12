
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import 'package:rantal/View/util/Addresssearch.dart';
import 'package:rantal/View/util/utisUi.dart';
import 'package:rantal/model/SearchModel.dart';
import 'package:uuid/uuid.dart';
import 'package:rantal/model/admindata.dart';
import 'package:rantal/model/admindata.dart';
import 'package:rantal/model/admindata.dart';

class searchPage extends StatefulWidget {
  @override
  _searchPageState createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  RangeValues Myslidervalue = RangeValues(10000, 50000);
  Color _color = Colors.white;
  List<String> type = [];
  final _controller = TextEditingController();
  var place;
  var ptype;
  RangeValues range;
  String countryValue;
  String stateValue;
  String cityValue;


  getType() {
    final Admin = Provider.of<adminData>(context);
    print(Admin.categoty.first);
    type.clear();
    Admin.categoty.forEach((element) {

        type.add(element);
      });
    }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getType();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            children: [
              Container(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:

                      SelectState(
                          dropdownColor: AppbarIconColor,
                          onCountryChanged: (value) {
                            setState(() {
                              countryValue = value;
                            });
                          },
                          onStateChanged:(value) {
                            setState(() {
                              stateValue = value;
                            });
                          },
                          onCityChanged:(value) {
                            setState(() {
                              cityValue = value;
                            });
                          },

                        ),

                      /*TextFormField(
                          onChanged: (value){
                            place=value;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white60,
                            icon: Icon(Icons.search_rounded),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: "search city",
                          ),
                          autovalidateMode: AutovalidateMode.always,
                        )*/),
                  ],
                ),
              ),
              Text("Property type"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GroupButton(
                  buttonHeight: 50,
                  buttonWidth: 100,
                  spacing: 10,
                  isRadio: true,
                  direction: Axis.horizontal,
                  onSelected: (index, isSelected) {
                    print('$index button is ${isSelected ? 'selected' : 'unselected'}');
                    ptype = type.elementAt(index);
                  },
                  buttons: type,

                  selectedTextStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.red,
                  ),
                  unselectedTextStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  selectedColor: Colors.white,
                  unselectedColor: Colors.grey[300],
                  selectedBorderColor: Colors.red,
                  unselectedBorderColor: Colors.grey[500],
                  borderRadius: BorderRadius.circular(5.0),
                  selectedShadow: <BoxShadow>[BoxShadow(color: Colors.transparent)],
                  unselectedShadow: <BoxShadow>[BoxShadow(color: Colors.transparent)],
                )
              ),
        Text("Select Range"),
        Container(
          child: RangeSlider(
            values: Myslidervalue,
            min: 0,
            max: 50000,
            labels: RangeLabels(
              Myslidervalue.start.round().toString(),
              Myslidervalue.end.round().toString(),
            ),
            onChanged: (RangeValues values) {
              setState(() {
                Myslidervalue = values;
                range = values;
                print(Myslidervalue);
              });
            },
          ),
        ),
              Text(Myslidervalue.start.toInt().toString()+" - " + Myslidervalue.end.toInt().toString()),
              ButtonBar(
                children: [
                  ElevatedButton(
                      onPressed: (){
                        try {
                          FirebaseFirestore.instance.collection("properties")
                              .where("city", isEqualTo: "surat")//.where(
                             // "rprice", isGreaterThanOrEqualTo: range.start)
                              //.where("rprice", isLessThanOrEqualTo: range.end)
                              .get()
                              .then((value) {
                            print(value.size);
                            print(value.docs.first.id);
                          });
                        }
                        catch(e){
                          print(e);
                        }
                      },
                      child: Text("Done"),
                  ),
                ],
              )
            ],
        ),
      ),
    );
  }
}


//AIzaSyB653pCTSjptn5D5xpTGcUZcPkTHsa2u4c