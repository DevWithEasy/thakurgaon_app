import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thakurgaon/screen/app_info_screen/contact_screen.dart';
import 'package:thakurgaon/screen/app_info_screen/developer_screen.dart';
import 'package:thakurgaon/screen/app_info_screen/privacy_policy_screen.dart';
import 'package:thakurgaon/screen/education/coaching_center_screen.dart';
import 'package:thakurgaon/screen/education/institute_screen.dart';
import 'package:thakurgaon/screen/education/institution_list_screen.dart';
import 'package:thakurgaon/screen/education/library_screen.dart';
import 'package:thakurgaon/screen/education/tutor_screen.dart';
import 'package:thakurgaon/screen/health/blood_orgs_screen.dart';
import 'package:thakurgaon/screen/health/doctors_screen.dart';
import 'package:thakurgaon/screen/health/homeopathy_screen.dart';
import 'package:thakurgaon/screen/health/hospital_details_screen.dart';
import 'package:thakurgaon/screen/hotel_restuerent/food_hotel_screen.dart';
import 'package:thakurgaon/screen/hotel_restuerent/residential_hotel_screen.dart';
import 'package:thakurgaon/screen/hotel_restuerent/rest_house_screen.dart';
import 'package:thakurgaon/screen/hotel_restuerent/restaurant_screen.dart';
import 'package:thakurgaon/screen/others/uddokta_screen.dart';
import 'package:thakurgaon/screen/rent/bus_service_screen.dart';
import 'package:thakurgaon/screen/rent/house_rent_screen.dart';
import 'package:thakurgaon/screen/rent/mess_rent_screen.dart';
import 'package:thakurgaon/screen/rent/train_shedule_screen.dart';
import 'package:thakurgaon/screen/rewards/contribution_screen.dart';
import 'package:thakurgaon/screen/rewards/monthly_reward_screen.dart';
import 'package:thakurgaon/screen/rewards/video_earn_screen.dart';
import 'package:thakurgaon/screen/rewards/weekly_quiz_dashboad.dart';
import 'package:thakurgaon/screen/rewards/weekly_quiz_question_screen.dart';
import 'package:thakurgaon/screen/rewards/weekly_quiz_screen.dart';
import 'package:thakurgaon/screen/rewards/weekly_quiz_winner_screen.dart';
import 'package:thakurgaon/screen/service_man/forman_screen.dart';
import 'package:thakurgaon/screen/service_man/lawyer_screen.dart';
import 'package:thakurgaon/screen/service_man/surveyor_screen.dart';

import 'provider/app_provider.dart';
import 'screen/app_info_screen/terms_screen.dart';
import 'screen/app_info_screen/thanks_screen.dart';
import 'screen/district_info/about_screen.dart';
import 'screen/district_info/areas_screen.dart';
import 'screen/district_info/mapview_screen.dart';
import 'screen/district_info/place_screen.dart';
import 'screen/district_info/places_screen.dart';
import 'screen/district_info/tradition_screen.dart';
import 'screen/district_info/traditions_screen.dart';
import 'screen/emergency/electricity_screen.dart';
import 'screen/emergency/fire_service_screen.dart';
import 'screen/emergency/helpline_screen.dart';
import 'screen/emergency/police_screen.dart';
import 'screen/health/ambulance_screen.dart';
import 'screen/health/blood_donars_screen.dart';
import 'screen/health/diagnostics_screen.dart';
import 'screen/health/doctor_details_screen.dart';
import 'screen/health/hospitals_screen.dart';
import 'screen/main_screen.dart';
import 'screen/not_found_screen.dart';
import 'screen/others/job_details_screen.dart';
import 'screen/others/jobs_screen.dart';
import 'screen/others/news_details_screen.dart';
import 'screen/others/news_screen.dart';
import 'screen/others/uddokta_details_screen.dart';
import 'screen/rent/car_rent_screen.dart';
import 'screen/user_screen/change_password_screen.dart';
import 'screen/user_screen/forget_password_screen.dart';
import 'screen/user_screen/login_screen.dart';
import 'screen/user_screen/notifications_screen.dart';
import 'screen/user_screen/profile_screen.dart';
import 'screen/user_screen/register_screen.dart';
import 'screen/user_screen/settings_screen.dart';
import 'utils/app_colors.dart';
import 'utils/app_routes.dart';

// app.dart
class ThakurgaonApp extends StatelessWidget {
  const ThakurgaonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return MaterialApp(
          title: 'Thakurgaon',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.teal,
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'kalpurush',
            appBarTheme: AppBarTheme(
              color: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.teal,
            scaffoldBackgroundColor: Colors.grey[900],
            fontFamily: 'kalpurush',
            appBarTheme: AppBarTheme(
              color: Colors.grey[850],
              foregroundColor: Colors.white,
            ),
            cardColor: Colors.grey[850],
          ),
          themeMode: appProvider.themeMode,
          initialRoute: '/',
          routes: {
            Routes.home: (context) => MainScreen(),
            //user_routes
            Routes.login: (context) => LoginScreen(),
            Routes.register: (context) => RegisterScreen(),
            Routes.forgotPassword: (context) => ForgetPasswordScreen(),
            Routes.changePassword: (context) => ChangePasswordScreen(),
            Routes.profile: (context) => ProfileScreen(),
            Routes.settings: (context) => SettingsScreen(),
            Routes.notification: (context) => NotificationsScreen(),
            //info_routes
            Routes.about: (context) => AboutScreen(),
            Routes.map: (context) => MapviewScreen(),
            Routes.historicalPlace: (context) => PlacesScreen(),
            Routes.place: (context) => PlaceScreen(),
            Routes.upazilla: (context) => AreasScreen(),
            Routes.traditions: (context) => TraditionsScreen(),
            Routes.tradition: (context) => TraditionScreen(),
            //emergency_routes
            Routes.police: (context) => PoliceScreen(),
            Routes.fireService: (context) => FireServiceScreen(),
            Routes.electricity: (context) => ElectricityScreen(),
            Routes.helpline: (context) => HelplineScreen(),
            //health
            Routes.hospital: (context) => HospitalsScreen(),
            Routes.diagnostic: (context) => DiagnosticsScreen(),
            Routes.hospitalDetails: (context) => HospitalDetailsScreen(),
            Routes.doctors: (context) => DoctorsScreen(),
            Routes.doctor: (context) => DoctorDetailsScreen(),
            Routes.homeoDoctors: (context) => HomeopathyScreen(),
            Routes.bloodOrg: (context) => BloodOrgsScreen(),
            Routes.blood: (context) => BloodDonarsScreen(),
            Routes.ambulance: (context) => AmbulanceScreen(),
            //education
            Routes.institute: (context) => InstituteScreen(),
            Routes.instituteList: (context) => InstituteListScreen(),
            Routes.library: (context) => LibraryScreen(),
            Routes.coachingCenter: (context) => CoachingCenterScreen(),
            Routes.tutor: (context) => TutorScreen(),
            //service_man
            Routes.lawyer: (context) => LawyerScreen(),
            Routes.surveyor: (context) => SurveyorScreen(),
            Routes.foreman: (context) => FormanScreen(),
            //rent
            Routes.rentHouse: (context) => HouseRentScreen(),
            Routes.rentMess: (context) => MessRentScreen(),
            Routes.rentCar: (context) => CarRentScreen(),
            Routes.busService: (context) => BusServiceScreen(),
            Routes.trainService: (context) => TrainSheduleScreen(),
            //hotel & food
            Routes.hotelFood: (context) => FoodHotelScreen(),
            Routes.restaurant: (context) => RestaurantScreen(),
            Routes.residentalHotel: (context) => ResidentialHotelScreen(),
            Routes.restHouse: (context) => RestHouseScreen(),
            //others
            Routes.uddokta: (context) => UddoktaScreen(),
            Routes.uddoktaDetails: (context) => UddoktaDetailsScreen(),
            Routes.news: (context) => NewsScreen(),
            Routes.newsDetails: (context) => NewsDetailsScreen(),
            Routes.jobs: (context) => JobsScreen(),
            Routes.jobDetails: (context) => JobDetailsScreen(),
            //earn
            Routes.quiz: (context) => WeeklyQuizScreen(),
            Routes.quizDashboard: (context) => WeeklyQuizDashboad(),
            Routes.quizQuestion: (context) => WeeklyQuizQuestionScreen(),
            Routes.quizWinner: (context) => WeeklyQuizWinnerScreen(),
            Routes.videoEarn: (context) => VideoEarnScreen(),
            Routes.contributor: (context) => ContributionScreen(),
            Routes.monthlyReward: (context) => MonthlyRewardScreen(),
            //app-info
            Routes.contact: (context) => ContactScreen(),
            Routes.privacy: (context) => PrivacyPolicyScreen(),
            Routes.trems: (context) => TermsScreen(),
            Routes.thnaks: (context) => ThanksScreen(),
            Routes.developer: (context) => DeveloperScreen(),
          },
          onUnknownRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) => const NotFoundScreen(),
            );
          },
        );
      },
    );
  }
}
