import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:supernova/supernova.dart";

import "../types/booking.dart";
import "../types/global_data.dart";
import "../types/price_type.dart";

class StatisticsWidget extends HookWidget {
  const StatisticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final globalData = GlobalData();
    useListenable(globalData.isTransactionInProgress);
    useListenable(GlobalData.currentBookingTime);

    final bookings = globalData.bookings.value;
    final seatsSoldTotal = bookings.map((booking) => booking.seats.length).sum;
    final seatsSoldPerPriceType = {
      for (final priceType in PriceType.values)
        priceType: bookings
            .where((booking) => booking.priceType == priceType)
            .map((booking) => booking.seats.length)
            .sum,
    };
    final moneyMadeTotal = bookings.map((booking) => booking.pricePaid).sum;
    final moneyMadeByPriceType = {
      for (final priceType in [PriceType.normal, PriceType.reduced])
        priceType: bookings
            .where((booking) => booking.priceType == priceType)
            .map((booking) => booking.pricePaid)
            .sum,
    };
    final seatsPerGrade = <int?, int>{};
    bookings.map(getGradeFromBooking).forEach((e) {
      if (seatsPerGrade.containsKey(e)) {
        seatsPerGrade[e] = seatsPerGrade[e]! + 1;
      } else {
        seatsPerGrade[e] = 1;
      }
    });

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text("Sitze verkauft: $seatsSoldTotal"),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     for (final entry in seatsSoldPerPriceType.entries)
              //       Text("${entry.key.germanName}: ${entry.value}"),
              //   ],
              // ),
              // Divider(
              //   color: Colors.black,
              // ),
              // Text("Geld eingenommen: $moneyMadeTotal"),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     for (final entry in moneyMadeByPriceType.entries)
              //       Text("${entry.key.germanName}: ${entry.value}"),
              //   ],
              // ),
              Column(
                children: [
                  Text("Sitze verkauft: $seatsSoldTotal"),
                  SizedBox(
                    width: 400,
                    height: 400,
                    child:
                        PieChart(PieChartData(centerSpaceRadius: 0, sections: [
                      for (final entry in seatsSoldPerPriceType.entries)
                        PieChartSectionData(
                          title: "${entry.value}",
                          value: entry.value.toDouble(),
                          radius: 80,
                          color: getColour(entry.key),
                        ),
                    ])),
                  ),
                ],
              ),
              SizedBox(
                height: 400,
                child: VerticalDivider(
                  color: Colors.black,
                ),
              ),
              Column(
                children: [
                  Text("Eingenommenes Geld: $moneyMadeTotal€"),
                  SizedBox(
                    width: 400,
                    height: 400,
                    child:
                        PieChart(PieChartData(centerSpaceRadius: 0, sections: [
                      for (final entry in moneyMadeByPriceType.entries)
                        PieChartSectionData(
                          title: "${entry.value}€",
                          value: entry.value.toDouble(),
                          radius: 80,
                          color: getColour(entry.key),
                        ),
                    ])),
                  ),
                ],
              ),
              SizedBox(
                height: 400,
                child: VerticalDivider(
                  color: Colors.black,
                ),
              ),
              Column(
                children: [
                  Text("Sitze pro Klassenstufe"),
                  SizedBox(
                    width: 400,
                    height: 400,
                    child:
                        PieChart(PieChartData(centerSpaceRadius: 0, sections: [
                      for (final entry in seatsPerGrade.entries)
                        PieChartSectionData(
                          title: "${entry.value}",
                          value: entry.value.toDouble(),
                          badgeWidget: Text("KS " + (entry.key ?? "nicht zugeordnet").toString()),
                          badgePositionPercentageOffset: 1.3,
                          radius: 80,
                          color: getColourForGrade(entry.key),
                        ),
                    ])),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Column(
              children: [
                for (final priceType in PriceType.values)
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: SizedBox(
                          width: 10,
                          height: 10,
                          child: Container(
                            color: getColour(priceType),
                          ),
                        ),
                      ),
                      Text(priceType.germanName)
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

int? getGradeFromBooking(Booking booking) {
  final grade = booking.className.characters.where(isDigit).join();
  if (grade.isEmpty) return null;
  return int.parse(grade);
}

bool isDigit(String c) => double.tryParse(c) != null;

Color getColour(PriceType priceType) {
  switch (priceType) {
    case PriceType.normal:
      return Colors.green;
    case PriceType.reduced:
      return Colors.yellow;
    case PriceType.free:
      return Colors.red;
  }
}

Color getColourForGrade(int? grade) {
  if (grade == null) return Colors.grey;
  const colours = [
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.pink,
    Colors.orange,
    Colors.green,
    Colors.red,
    Colors.purpleAccent
  ];
  return colours[grade % colours.length];
}
