import 'package:fl_chart/chart/bar_chart/bar_chart_painter.dart';
import 'package:fl_chart/chart/base/fl_chart/fl_chart_data.dart';
import 'package:fl_chart/chart/line_chart/line_chart_painter.dart';
import 'package:fl_chart/chart/pie_chart/pie_chart_painter.dart';
import 'package:flutter/material.dart';

/// this class is base class of our painters and
/// it is responsible to draw borders of charts.
/// concrete samples :
/// [LineChartPainter], [BarChartPainter], [PieChartPainter]
/// there is a data [D] that extends from [FlChartData],
/// that contains needed data to draw chart border in this phase.
abstract class FlChartPainter<D extends FlChartData> extends CustomPainter {
  final D data;
  Paint borderPaint;

  FlChartPainter(this.data) {
    borderPaint = Paint()
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size viewSize) {
    drawViewBorder(canvas, viewSize);
  }

  void drawViewBorder(Canvas canvas, Size viewSize) {
    if (!data.borderData.show) {
      return;
    }

    var chartViewSize = getChartUsableDrawSize(viewSize);

    borderPaint.color = data.borderData.borderColor;
    borderPaint.strokeWidth = data.borderData.borderWidth;

    canvas.drawRect(
        Rect.fromLTWH(
          0 + getLeftOffsetDrawSize(),
          0 + getTopOffsetDrawSize(),
          chartViewSize.width,
          chartViewSize.height,
        ),
        borderPaint);
  }

  /// calculate the size that we can draw our chart.
  /// [getExtraNeededHorizontalSpace] and [getExtraNeededVerticalSpace]
  /// is the needed space to draw horizontal and vertical
  /// stuff around our chart.
  /// then we subtract them from raw [viewSize]
  Size getChartUsableDrawSize(Size viewSize) {
    double usableWidth = viewSize.width - getExtraNeededHorizontalSpace();
    double usableHeight = viewSize.height - getExtraNeededVerticalSpace();
    return Size(usableWidth, usableHeight);
  }

  /// extra needed space to show horizontal contents around the chart,
  /// like: left, right padding, left, right titles, and so on,
  /// each child class can override this function.
  double getExtraNeededHorizontalSpace() => 0;

  /// extra needed space to show vertical contents around the chart,
  /// like: tob, bottom padding, top, bottom titles, and so on,
  /// each child class can override this function.
  double getExtraNeededVerticalSpace() => 0;

  /// left offset to draw the chart
  /// we should use this to offset our x axis when we drawing the chart,
  /// and the width space we can use to draw chart is[getChartUsableDrawSize.width]
  double getLeftOffsetDrawSize() => 0;

  /// top offset to draw the chart
  /// we should use this to offset our y axis when we drawing the chart,
  /// and the height space we can use to draw chart is[getChartUsableDrawSize.height]
  double getTopOffsetDrawSize() => 0;
}
