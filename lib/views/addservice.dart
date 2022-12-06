import 'package:flutter/material.dart';
import 'package:jobuapp/constants/style.dart';
import 'package:jobuapp/models/service.dart';
import 'package:jobuapp/providers/app_provider.dart';
import 'package:jobuapp/providers/data_provider.dart';
import 'package:jobuapp/providers/user_provider.dart';
import 'package:jobuapp/widgets/popup.dart';
import 'package:provider/provider.dart';

class Addservice extends StatefulWidget {
  const Addservice({Key? key}) : super(key: key);

  @override
  State<Addservice> createState() => _FormcondState();
}

class _FormcondState extends State<Addservice> {
  bool deplacementoui = false;
  bool deplacementnon = false;
  int frais = 1;
  RangeValues slider = const RangeValues(1, 100);

  TextEditingController metierController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  addservice() async {
    final user = context.read<UserProvider>().currentUser!;
    final service = ServiceModel(
        id: '',
        ownerId: user.id.toString(),
        ownerName: user.fullName,
        ownerImage: user.image,
        metier: metierController.text,
        description: descriptionController.text,
        location: locationController.text,
        phoneNumber: phoneNumberController.text,
        deplacement: deplacementoui ? true : false,
        cost: frais);
    context.read<DataProvider>().addService(service).then((value) {
      if (value) {
        Navigator.pop(context);
      } else {
        popup(context, "Ok",
            description: "An error has occurred, please try again later");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var style = context.watch<ThemeNotifier>();
    return Scaffold(
      backgroundColor: style.bgColor,
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.15,
                child: Stack(
                  children: [
                    Container(
                      height: size.height * 0.1,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/pattern.png"),
                            fit: BoxFit.cover,
                            opacity: 0.1),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 3),
                              blurRadius: 10,
                              color: Colors.black38)
                        ],
                        color: primaryColor,
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: size.height * 0.1 - 30,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Hero(
                          tag: "add",
                          child: Container(
                            padding: const EdgeInsets.only(right: 5),
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: style.bgColor,
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(0, 3),
                                    blurRadius: 10,
                                    color: Colors.black38)
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: style.invertedColor,
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
                controller: metierController,
                style: style.text18,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.work,
                    color: style.invertedColor,
                  ),
                  hintText: 'Nom du metier',
                  hintStyle: style.text18
                      .copyWith(color: style.invertedColor.withOpacity(.7)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                style: style.text18,
                controller: descriptionController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.description,
                    color: style.invertedColor,
                  ),
                  hintText: 'Description',
                  hintStyle: style.text18
                      .copyWith(color: style.invertedColor.withOpacity(.7)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                style: style.text18,
                controller: locationController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.location_on,
                    color: style.invertedColor,
                  ),
                  hintText: 'Localisation',
                  hintStyle: style.text18
                      .copyWith(color: style.invertedColor.withOpacity(.7)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                style: style.text18,
                controller: phoneNumberController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.call,
                    color: style.invertedColor,
                  ),
                  hintText: 'Numero de telephone',
                  hintStyle: style.text18
                      .copyWith(color: style.invertedColor.withOpacity(.7)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Deplacment a domicil',
                    style: style.text18,
                  ),
                  Checkbox(
                      value: deplacementoui,
                      onChanged: (value) {
                        setState(() {
                          deplacementoui = value ?? false;
                          if (deplacementoui) deplacementnon = false;
                        });
                      }),
                  Text(
                    "Oui",
                    style: style.text18,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Checkbox(
                      value: deplacementnon,
                      onChanged: (value) {
                        setState(() {
                          deplacementnon = value ?? false;
                          if (deplacementnon) deplacementoui = false;
                        });
                      }),
                  Text("Non", style: style.text18),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Frais : $frais DT",
                style: style.text18.copyWith(
                    color: style.btnColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "1 DT",
                    style: style.text18,
                  ),
                  SizedBox(
                    width: size.width * 0.6,
                    child: Slider(
                      value: frais.toDouble(),
                      // divisions: 29,
                      min: 1,
                      max: 100,
                      onChanged: (value) {
                        setState(() {
                          frais = value.toInt();
                        });
                      },
                    ),
                  ),
                  Text(
                    "100 Dt",
                    style: style.text18,
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: style.btnColor,
                  shape: const StadiumBorder(),
                  // primary: d_red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 125,
                    vertical: 13,
                  ),
                ),
                onPressed: addservice,
                child: Text(
                  'CONFIRMER',
                  style: style.text18.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
