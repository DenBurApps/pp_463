enum RationType {
  breakfast(label: 'Breakfast'),
  lunch(label: 'Lunch'),
  dinner(label: 'Dinner'),
  snack(label: 'Snack');

  final String label;

  const RationType({
    required this.label,
  });
}
