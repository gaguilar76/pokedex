import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pokedex_app/core/utils/strings_app.dart';
import 'package:pokedex_app/core/widgets/form_field2.dart';


class SearchTextField extends FormField2 {
  SearchTextField({
    super.key,
    double? width,
    String? label,
    String? value,
    ValueChanged? onChange,
    FormFieldSetter? onSaved,
    FormFieldValidator<String>? validator,
    ValueChanged<String>? onSubmitted,
    Function(String)? onChanged,
    TextEditingController? controller,
    List<TextInputFormatter>? inputFormatters,
    bool? enable,
    Color? iconColor,
    bool clearIcon = false,
    VoidCallback? onClear,
  }) : super(
          builder: (state) {
            return TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              onSubmitted: (v) {
                if (onSubmitted != null) {
                  onSubmitted(v);
                }
              },
              onChanged: (v) {
                if (onChanged != null) {
                  onChanged(v);
                }
              },
              decoration: InputDecoration(
                  hintText: label ?? search,
                  filled: true,
                  contentPadding: const EdgeInsets.all(12),
                  isDense: true,
                  border: OutlineInputBorder(),
                  counterText: '',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  suffixIcon: clearIcon 
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: onClear ?? () {
                              controller!.text = '';
                            },
                          child: Icon(
                            Icons.clear,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 10.0,),
                        InkWell(
                          child: Icon(
                            Icons.search,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 10.0,),
                      ],
                    )
                    : InkWell(
                      child: Icon(
                        Icons.search,
                        size: 30,
                      ),
                    ),
                  ),
            );
          },
        );
}
