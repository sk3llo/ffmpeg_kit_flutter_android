/*
 * Copyright (c) 2019-2021 Taner Sener
 *
 * This file is part of FFmpegKit.
 *
 * FFmpegKit is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * FFmpegKit is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with FFmpegKit.  If not, see <http://www.gnu.org/licenses/>.
 */

class ReturnCode {
  static const int success = 0;
  static const int cancel = 255;

  final int _value;

  ReturnCode(this._value);

  static bool isSuccess(ReturnCode? returnCode) =>
      returnCode?.getValue() == ReturnCode.success;

  static bool isCancel(ReturnCode? returnCode) =>
      returnCode?.getValue() == ReturnCode.cancel;

  int getValue() => _value;

  bool isValueSuccess() => _value == ReturnCode.success;

  bool isValueError() =>
      (_value != ReturnCode.success) && (_value != ReturnCode.cancel);

  bool isValueCancel() => _value == ReturnCode.cancel;

  @override
  String toString() => _value.toString();
}
