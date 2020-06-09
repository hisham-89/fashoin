import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:localstorage/localstorage.dart';
class General {
  authHeader() {
    var user = new User().getUser();
    var authHeader;
    if (user != null)
      authHeader = {
        'Authorization': 'Bearer ' + user['api_token'],
        'Content-Type': 'application/json'
      };
    else
      authHeader = { 'Content-Type': 'application/json'};
    return authHeader;
  }

  static mediaUrl(image) {

    if(image!=null)
     return    CachedNetworkImageProvider(url + image );
    else
      return AssetImage("assets/images/fashionLogo.jpeg");
  }

  static getTime(date) {
    var dateUtility = new DateUtil();
    var moonLanding = DateTime.parse(date);
    return moonLanding.hour.toString() + ":" + moonLanding.minute.toString();
  }

  static getDate(date, {time: false, year: false }) {
    if(date==null)
      return"";
    var dateUtility = new DateUtil();
    var moonLanding = DateTime.parse(date);
    String monthName = dateUtility.month(moonLanding.month);
    var year1 = (year == true) ? moonLanding.year == DateTime
        .now()
        .year ? '' : "-" + moonLanding.year.toString():"";
    var time1 = (time == true) ? " at " + moonLanding.hour.toString() + ":" +
        moonLanding.minute.toString() : "";
    return moonLanding.day.toString() + " " + monthName + year1
        + time1;
  }
}
class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.icon,
        this.hint,
        this.obsecure = false,
        this.validator,
        this.onSaved});
  final FormFieldSetter<String> onSaved;
  final Icon icon;
  final String hint;
  final bool obsecure;
  final FormFieldValidator<String> validator;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        onSaved: onSaved,
        validator: validator,
        autofocus: true,
        obscureText: obsecure,
        style: TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
            hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            hintText: hint,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 3,
              ),
            ),
            prefixIcon: Padding(
              child: IconTheme(
                data: IconThemeData(color: Theme.of(context).primaryColor),
                child: icon,
              ),
              padding: EdgeInsets.only(left: 30, right: 10),
            )),
      ),
    );
  }
}