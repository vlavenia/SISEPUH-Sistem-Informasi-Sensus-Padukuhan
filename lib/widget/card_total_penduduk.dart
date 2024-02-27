import 'package:flutter/material.dart';

class cardtotalpenduduk extends StatelessWidget {
  const cardtotalpenduduk({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      //decoration: BoxDecoration(color: Colors.red),
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 324,
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 24.0,
                ),
                Text("Total Penduduk",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19)),
                const SizedBox(
                  height: 13.0,
                ),
                Text(
                  "431,324 Warga",
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
                const SizedBox(
                  height: 17.0,
                ),
                Text(
                  "Kentolan Lor Rt.04",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
