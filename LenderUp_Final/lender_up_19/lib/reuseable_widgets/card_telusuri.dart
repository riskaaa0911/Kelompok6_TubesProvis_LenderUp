import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lender_up_19/reuseable_widgets/build_sheet.dart';
import 'package:lender_up_19/reuseable_widgets/build_sheet_bayar.dart';
import 'package:intl/intl.dart';

List<Widget> CardPinjaman(
    List<Map<String, dynamic>> pinjamanData,
    BuildContext context,
    Map<String, dynamic>? lenderData,
    Map<String, dynamic>? dompetData,
    bool is_in_borrower) {
  List<Widget> items = [];
  // Loop untuk membuat konten item secara dinamis
  for (var data in pinjamanData) {
    items.add(
      Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
        padding: EdgeInsets.only(top: 10, bottom: 10),
        width: 400,
        height: 150,
        decoration: BoxDecoration(
          color: Color(0xffffffffff),
          borderRadius: BorderRadius.circular(15),
        ),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            // margin: EdgeInsets.only(left: 10),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                width: 50,
                height: 50,
                child: ClipOval(
                  child: Image.network(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data['name']!,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500))),
                        Text(data['description']!,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500))),
                        Text(data['location']!,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300))),
                      ])),
              Container(
                margin: EdgeInsets.only(bottom: 20, right: 14),
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFFffb703)),
                child: Stack(children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 3, left: 1),
                    child: IconButton(
                      iconSize: 20,
                      icon: FaIcon(FontAwesomeIcons.plus),
                      onPressed: () {
                        if (is_in_borrower == false) {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => buildSheet(
                                context, data, false, lenderData, dompetData),
                          );
                        } else {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => buildSheetBayar(
                                context, data, lenderData, dompetData),
                          );
                        }
                      },
                    ),
                  )
                ]),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text("Nominal Pinjaman",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Color(0xff1D3557),
                          fontSize: 8,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                        ))),
                  ),
                  Text(
                    "Rp. ${NumberFormat('#,###').format(data['nominal_pinjaman'])}",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    // margin:
                    // EdgeInsets.only(left: 70, right: 70),
                    child: Text("Bagi Hasil",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Color(0xff1D3557),
                          fontSize: 8,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                        ))),
                  ),
                  Container(
                    // margin:
                    // EdgeInsets.only(left: 70, right: 70),
                    child: Text("${data['bagi_hasil_persen'].toString()}%",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                        ))),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    // margin:
                    // EdgeInsets.only(left: 70, right: 70),
                    child: Text("Tenor",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Color(0xff1D3557),
                          fontSize: 8,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                        ))),
                  ),
                  Container(
                    // margin:
                    // EdgeInsets.only(left: 70, right: 70),
                    child: Text("${data['tenor'].toString()} bulan",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                        ))),
                  ),
                ],
              )
            ],
          ),
          is_in_borrower == true
              ? Expanded(
                  child: Container(
                    child: Center(
                      child: Text(
                        '${data['status']}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 179, 0),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ]),
      ),
    );
  }

  return items;
}
