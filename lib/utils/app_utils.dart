import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:thakurgaon/model/doctor_model.dart';
import 'package:thakurgaon/model/hospital_model.dart';
import 'package:thakurgaon/model/tourist_place_model.dart';
import 'package:thakurgaon/model/union_model.dart';

import '../model/Info_model.dart';
import '../model/blood_donar_model.dart';
import '../model/category_model.dart';
import '../model/coaching_center_model.dart';
import '../model/food_hotel_model.dart';
import '../model/forman_model.dart';
import '../model/institute_model.dart';
import '../model/job_model.dart';
import '../model/lawyer_model.dart';
import '../model/news_model.dart';
import '../model/residential_hotel_model.dart';
import '../model/rest_house_model.dart';
import '../model/restaurant_model.dart';
import '../model/surveyor_model.dart';
import '../model/tutor_model.dart';
import '../model/uddokta_model.dart';
import '../model/uddokta_product_model.dart';
import '../model/upazilla_model.dart';

class AppUtils {
  static String getTitle(int index) {
    switch (index) {
      case 0:
        return 'ঠাকুরগাঁও জেলা';
      case 1:
        return 'ফ্রি রিচার্জ জিতুন';
      case 2:
        return 'নোটিফিকেশন';
      case 3:
        return 'প্রোফাইল';
      default:
        return 'ঠাকুরগাঁও জেলা';
    }
  }

  static Future<List<Map<String, dynamic>>> loadJsonFromAssets(
    String path,
  ) async {
    try {
      final String jsonString = await rootBundle.loadString(path);
      final List<dynamic> jsonData = jsonDecode(jsonString);
      final List<Map<String, dynamic>> result =
          jsonData.cast<Map<String, dynamic>>();

      return result;
    } catch (e) {
      throw Exception('Failed to load JSON: ${e.toString()}');
    }
  }

  static Future<List<Category>> categories() async {
    final jsonData = await loadJsonFromAssets('assets/json/categories.json');
    List<Category> categories =
        jsonData.map((json) => Category.fromJson(json)).toList();
    return categories;
  }

  static Future<List<TouristPlace>> touristPlaces() async {
    final jsonData = await loadJsonFromAssets(
      'assets/json/district/tourist_place.json',
    );
    List<TouristPlace> places =
        jsonData.map((json) => TouristPlace.fromJson(json)).toList();
    return places;
  }

  static Future<List<Upazilla>> upazillas() async {
    final jsonData = await loadJsonFromAssets(
      'assets/json/district/upazilla.json',
    );
    List<Upazilla> upazillas =
        jsonData.map((json) => Upazilla.fromJson(json)).toList();
    return upazillas;
  }

  static Future<List<Union>> unions(int id) async {
    final jsonData = await loadJsonFromAssets(
      'assets/json/district/unions.json',
    );
    List<Union> unions =
        jsonData
            .map((json) => Union.fromJson(json))
            .where((union) => union.upazillaId == id)
            .toList();
    return unions;
  }

  static Future<List<Info>> infos() async {
    final jsonData = await loadJsonFromAssets('assets/json/district/info.json');
    List<Info> infos = jsonData.map((json) => Info.fromJson(json)).toList();
    return infos;
  }

  static Future<List<Info>> traditions() async {
    final jsonData = await loadJsonFromAssets(
      'assets/json/district/traditions.json',
    );
    List<Info> traditions =
        jsonData.map((json) => Info.fromJson(json)).toList();
    return traditions;
  }

  static Future<List<Hospital>> hospitals(String type) async {
    final jsonData = await loadJsonFromAssets(
      'assets/json/health/hospital.json',
    );
    List<Hospital> hospitals =
        jsonData
            .map((json) => Hospital.fromJson(json))
            .where((json) => json.type == type)
            .toList();
    return hospitals;
  }

  static Future<List<Doctor>> doctors() async {
    final jsonData = await loadJsonFromAssets(
      'assets/json/health/doctors.json',
    );
    List<Doctor> doctors =
        jsonData.map((json) => Doctor.fromJson(json)).toList();
    return doctors;
  }

  static Future<List<BloodDonor>> donors() async {
    final jsonData = await loadJsonFromAssets('assets/json/health/donors.json');
    List<BloodDonor> donors =
        jsonData.map((json) => BloodDonor.fromJson(json)).toList();
    return donors;
  }

  static Future<List<Institute>> institutions(String type) async {
    final jsonData = await loadJsonFromAssets(
      'assets/json/education_data.json',
    );

    List<Institute> institutions =
        jsonData
            .map<Institute>((json) => Institute.fromJson(json))
            .where((institute) => institute.type == type)
            .toList();
    return institutions;
  }

  static Future<List<CoachingCenter>> coachingCenters() async {
    final jsonData = await loadJsonFromAssets(
      'assets/json/coaching_center.json',
    );
    List<CoachingCenter> centers =
        jsonData
            .map<CoachingCenter>((json) => CoachingCenter.fromJson(json))
            .toList();
    return centers;
  }

  static Future<List<Tutor>> tutors() async {
    final jsonData = await loadJsonFromAssets('assets/json/tutors.json');
    List<Tutor> tutors =
        jsonData.map<Tutor>((json) => Tutor.fromJson(json)).toList();
    return tutors;
  }

  static Future<List<Lawyer>> lawyers() async {
    final jsonData = await loadJsonFromAssets('assets/json/lawyers.json');
    List<Lawyer> lawyers =
        jsonData.map<Lawyer>((json) => Lawyer.fromJson(json)).toList();
    return lawyers;
  }

  static Future<List<Surveyor>> surveyors() async {
    final jsonData = await loadJsonFromAssets('assets/json/surveyors.json');
    List<Surveyor> surveyors =
        jsonData.map<Surveyor>((json) => Surveyor.fromJson(json)).toList();
    return surveyors;
  }

  static Future<List<Forman>> formans() async {
    final jsonData = await loadJsonFromAssets('assets/json/formans.json');
    List<Forman> formans =
        jsonData.map<Forman>((json) => Forman.fromJson(json)).toList();
    return formans;
  }

  static Future<List<FoodHotel>> foodHotels() async {
    final jsonData = await loadJsonFromAssets('assets/json/food_hotel.json');
    List<FoodHotel> foodHotels =
        jsonData.map<FoodHotel>((json) => FoodHotel.fromJson(json)).toList();
    return foodHotels;
  }

  static Future<List<Restaurant>> restaurants() async {
    final jsonData = await loadJsonFromAssets('assets/json/restaurants.json');
    List<Restaurant> restaurants =
        jsonData.map<Restaurant>((json) => Restaurant.fromJson(json)).toList();
    return restaurants;
  }

  static Future<List<ResidentialHotel>> residentialHotels() async {
    final jsonData = await loadJsonFromAssets(
      'assets/json/residential_hotel.json',
    );
    List<ResidentialHotel> residentialHotels =
        jsonData
            .map<ResidentialHotel>((json) => ResidentialHotel.fromJson(json))
            .toList();
    return residentialHotels;
  }

  static Future<List<RestHouse>> restHouses() async {
    final jsonData = await loadJsonFromAssets('assets/json/rest_house.json');
    List<RestHouse> restHouses =
        jsonData.map<RestHouse>((json) => RestHouse.fromJson(json)).toList();
    return restHouses;
  }

  // Load and decode entrepreneur data
  static Future<List<Uddokta>> loadUddoktas() async {
    final jsonData = await loadJsonFromAssets('assets/json/uddokta.json');
    return jsonData.map<Uddokta>((json) => Uddokta.fromJson(json)).toList();
  }

  // Load and decode product data
  static Future<List<UddoktaProduct>> loadProducts() async {
    final jsonData = await loadJsonFromAssets(
      'assets/json/uddokta_product.json',
    );
    return jsonData
        .map<UddoktaProduct>((json) => UddoktaProduct.fromJson(json))
        .toList();
  }

  static Future<List<News>> news() async {
    final jsonData = await loadJsonFromAssets('assets/json/news.json');
    return jsonData.map<News>((json) => News.fromJson(json)).toList();
  }

  static Future<List<Job>> jobs() async {
    final jsonData = await loadJsonFromAssets('assets/json/jobs.json');
    return jsonData.map<Job>((json) => Job.fromJson(json)).toList();
  }

}
