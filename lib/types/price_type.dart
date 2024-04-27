enum PriceType {
  normal("Normal"),
  reduced("Reduziert"),
  free("Gratis");

  const PriceType(this.name);

  final String name;
}

extension PriceTypeExte on PriceType {
  int calculatePrice({required bool isAfternoon}) {
    if (this == PriceType.free) return 0;
    if (isAfternoon) {
      if (this == PriceType.normal) return 15;
      return 10;
    }
    if (this == PriceType.normal) return 20;
    return 15;
  }
}
