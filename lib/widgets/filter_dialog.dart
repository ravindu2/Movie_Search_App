import 'package:flutter/material.dart';
import '../models/filter_options.dart';

class FilterDialog extends StatefulWidget {
  final FilterOptions? initialFilters;

  const FilterDialog({this.initialFilters});

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  double? _minRating;
  String? _selectedYear;

  @override
  void initState() {
    super.initState();
    _minRating = widget.initialFilters?.minRating;
    _selectedYear = widget.initialFilters?.year?.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Filter Movies'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Minimum Rating: ${_minRating?.toStringAsFixed(1) ?? 'None'}'),
          Slider(
            value: _minRating ?? 0,
            min: 0,
            max: 10,
            divisions: 20,
            onChanged: (value) {
              setState(() {
                _minRating = value;
              });
            },
          ),
          SizedBox(height: 16),
          DropdownButton<String>(
            hint: Text('Select Year'),
            value: _selectedYear,
            isExpanded: true,
            items: [
              DropdownMenuItem(value: null, child: Text('Any Year')),
              ...List.generate(10, (index) {
                final year = DateTime.now().year - index;
                return DropdownMenuItem(
                  value: year.toString(),
                  child: Text(year.toString()),
                );
              }),
            ],
            onChanged: (value) {
              setState(() {
                _selectedYear = value;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(
              context,
              FilterOptions(
                minRating: _minRating == 0 ? null : _minRating,
                year: _selectedYear != null ? int.parse(_selectedYear!) : null,
              ),
            );
          },
          child: Text('Apply'),
        ),
      ],
    );
  }
}