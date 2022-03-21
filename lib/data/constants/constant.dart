// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import '../models/company.dart';
import '../models/user_model.dart';

//COLORS
const Color profile_info_background = Color(0xFF3775FD);
const Color profile_info_categories_background = Color(0xFFF6F5F8);
const Color profile_info_address = Color(0xFF8D7AEE);
const Color profile_info_privacy = Color(0xFFF369B7);
const Color profile_info_general = Color(0xFFFFC85B);
const Color profile_info_notification = Color(0xFF5DD1D3);
const Color profile_item_color = Color(0xFFC4C5C9);
const String imagePath = 'assets/image';



//String Keys
const KEY_LOGIN = 'login';

//User Token
const TOKEN = '123456789';

User getUser(String userName){
  return User(
      id: 1 ,
      firstName: userName,
      lastName: '',
      gender: '',
      memberNumber: '',
      dob: '',
      email: '',
      msisdn: '',
      profile: 'https://',
      company: Company(id: 5,name: 'Bloc',logo: 'https://',status: 'available'),
      addressline_1: 'Mansoura',
      addressline_2: 'Talkha',
      country: 'Egypt',
      city: 'Mansoura',
      bmi: '',
      weight: '50',
      height: '155',
      points: '100'
  );
}
