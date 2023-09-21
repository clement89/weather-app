import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/features/weather/presentation/bloc/weather_bloc.dart';

class CityTile extends StatefulWidget {
  final String initialText;

  const CityTile({super.key, required this.initialText});

  @override
  _CityTileState createState() => _CityTileState();
}

class _CityTileState extends State<CityTile> {
  late TextEditingController _textEditingController;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.sp),
        child: isEditing
            ? TextField(
                controller: _textEditingController,
                onSubmitted: (newValue) {
                  setState(() {
                    isEditing = false;
                  });
                  context
                      .read<WeatherBloc>()
                      .add(GetCurrentWeather(isFromCity: true, city: newValue));
                },
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              )
            : Text(widget.initialText,
                style: Theme.of(context).textTheme.bodyLarge),
      ),
      trailing: isEditing
          ? IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                setState(() {
                  isEditing = false;
                });
                context.read<WeatherBloc>().add(GetCurrentWeather(
                    isFromCity: true, city: _textEditingController.text));
              },
            )
          : IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  isEditing = true;
                });
              },
            ),
    );
  }
}
