import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobuapp/views/login/login.dart';



class Addservice extends StatefulWidget {
  const Addservice({Key? key}) : super(key: key);

  @override
  State<Addservice> createState() => _FormcondState();
}

class _FormcondState extends State<Addservice> {
  bool deplacementoui = false;
  bool deplacementnon = false;
  int frais = 1;
  RangeValues slider = const RangeValues(1, 30);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proposer Votre metier'),
        centerTitle: true,
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.work),
                    hintText: 'Nom du metier',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.description,
                    ),
                    hintText: 'Description',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    hintText: 'Localisation',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.call),
                    hintText: 'Numero de telephone',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Deplacment a domicil'),

                    Checkbox(
                        value: deplacementoui,
                        onChanged: (value) {
                          setState(() {
                            deplacementoui = value ?? false;
                            if (deplacementoui) deplacementnon = false;
                          });
                        }),
                    const Text("Oui"),
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
                    const Text("Non"),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Frais : $frais DT",
                  style: const TextStyle(color: Colors.blue, fontSize: 20),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("10DT"),
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
                    const Text("100"),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    // primary: d_red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 125,
                      vertical: 13,
                    ),
                  ),
                  child: Text(
                    'CONFIRMER',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
