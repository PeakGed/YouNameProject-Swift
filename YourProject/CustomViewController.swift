//
//  CustomViewController.swift
//  YourProject
//
//  Created by IntrodexMac on 17/5/2567 BE.
//

import DGCharts
import Foundation
import SnapKit
import UIKit

class CustomViewController: UIViewController {
    lazy var nameLabel: UILabel = {
        let element = UILabel()
        element.text = "Hello world"
        element.textAlignment = .left
        return element
    }()
    
    lazy var drawDemoContainerView: UIView = {
        let element = UIView()
        element.backgroundColor = .lightGray
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor.black.cgColor
        return element
    }()
    
    // Chart
    lazy var chartContainerView: UIView = {
        let element = UIView()
        return element
    }()
    
    lazy var chartView: CombinedChartView = {
        let element = CombinedChartView()
        element.isUserInteractionEnabled = true
        element.accessibilityIdentifier = "assetInfo_chart_view"
        element.doubleTapToZoomEnabled = false
        element.highlightPerTapEnabled = true
        element.scaleXEnabled = false
        element.scaleYEnabled = false
        element.chartDescription.enabled = false
        element.dragYEnabled = false
        element.dragXEnabled = false
        element.pinchZoomEnabled = false
        element.noDataText = ""
        element.noDataTextColor = UIColor.clear
        
        element.leftAxis.enabled = false
        element.rightAxis.enabled = false
        element.xAxis.drawAxisLineEnabled = false
        element.xAxis.drawGridLinesEnabled = false
        element.leftAxis.drawAxisLineEnabled = false
        element.xAxis.drawLabelsEnabled = false
        
        element.drawGridBackgroundEnabled = false
        element.drawBordersEnabled = false
        
        element.legend.form = .none
        element.setScaleEnabled(false)
        
        element.delegate = self
        element.maxVisibleCount = 5000
        element.rightAxis.axisMaximum = 100
        element.rightAxis.axisMinimum = 0
        
        element.setScaleMinima(1,
                               scaleY: 1)
        element.setViewPortOffsets(left: 0,
                                   top: 10,
                                   right: 0,
                                   bottom: 20)
        element.backgroundColor = .lightGray
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor.black.cgColor
        
        return element
    }()
    
    lazy var priceTargetContainerView: PriceTargetView = {
        let element = PriceTargetView()
        element.backgroundColor = .white
        return element
    }()
    
    lazy var capsuleContainerView: UIView = {
        let element = UIView()
        element.backgroundColor = .brown
        element.alpha = 0.5
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        initConstriantLayout()
        initChart() // Initialize the chart
        initDrawLine()
        
        // delay 2 sec
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.callAfterDelay3()
        }
    }
    
    func callAfterDelay3() {
        // get last entry of line chart
        let lastEntry = lineChartDataEntries.last!
                        
        let lastPrice = lastEntry.y
        
        
        let startPos = CGPoint(x: 0,
                               y: lastPrice)

        let endXPos = priceTargetContainerView.bounds.width
        
        let randomY = Stub.randomY
        
        let max = randomY.max()
        let min = randomY.min()
        let avg = randomY.randomElement()
        let avgMoreThenNow: Bool? = (avg != nil) ? avg! > lastPrice : nil
        
        print("###")
        print("Random Y Values: ")
        randomY.sorted().forEach { print($0) }
        
        print("###")
        print("Max Y Value: \(String(describing: max))")
        print("Min Y Value: \(String(describing: min))")
        print("Average Y Value: \(String(describing: avg))")
        print("Average More Than Now: \(String(describing: avgMoreThenNow))")
        
        print("###")
        print("Now : \(lastPrice)")
        
        let yValues = randomY.compactMap({ getItemYPosition(value: $0) })
        let yAvg: CGFloat? = (avg != nil) ? getItemYPosition(value: avg!) : nil
        let vm = PriceTargetVM(startPoint: startPos,
                             endX: endXPos,
                             yValues: yValues,
                             yAvg: yAvg)
        priceTargetContainerView.bind(vm)
    }
    
    func callAfterDelay() {
        // get last entry of line chart
        let lastEntry = lineChartDataEntries.last!
        print("lastEntry: \(lastEntry)")
        let allBeginPos = getAllPriceTargetPositions(entries: [lastEntry],
                                                     in: chartView)
        let beginPos: [CGPoint] = allBeginPos.map { .init(x: 0,
                                                          y: $0.y) }
        // create circle for each price target
        beginPos.forEach { p in
            priceTargetContainerView.drawCircle(at: p,
                                                radius: 3,
                                                color: .black,
                                                strokeColor: .red,
                                                lineWidth: 0.5,
                                                alpha: 0.5)
        }
        
        let allPriceTargetPos = getAllPriceTargetPositions(entries: scatterChartDataEntries,
                                                           in: chartView)
        
        print("allPriceTargetPos: \(allPriceTargetPos)")
        let priceTargetContainerViewWidth = priceTargetContainerView.bounds.width
        let targetPos: [CGPoint] = allPriceTargetPos.map { .init(x: priceTargetContainerViewWidth,
                                                                 y: $0.y) }
        
        // create circle for each price target
        targetPos.forEach { p in
            priceTargetContainerView.drawCircle(at: p,
                                                radius: 3,
                                                color: .black,
                                                strokeColor: .red,
                                                lineWidth: 0.5,
                                                alpha: 0.5)
        }
        
        let pairPos: [(from: CGPoint, to: CGPoint)] = createPairOfPoint(from: beginPos.first!,
                                                                        to: targetPos)
        // create straight line from begin to each price target
        pairPos.forEach { pair in
            //            priceTargetContainerView.drawStraightLine(from: pair.from,
            //                                                      to: pair.to,
            //                                                      strokeColor: .black,
            //                                                      lineWidth: 2)
            
            // draw dashed line from begin to each price target
            priceTargetContainerView.drawDashedLine(from: pair.from,
                                                    to: pair.to,
                                                    strokeColor: .black,
                                                    lineWidth: 2,
                                                    lineDashPattern: [4, 4],
                                                    lineCap: .round)
        }
    }
    
    private func initViews() {
        view.backgroundColor = .white
        
        view.addSubview(nameLabel)
        view.addSubview(drawDemoContainerView)
        view.addSubview(chartView) // Ensure chartView is added to the view
        view.addSubview(priceTargetContainerView)
        view.addSubview(capsuleContainerView)
    }
    
    private func initConstriantLayout() {
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        drawDemoContainerView.snp.makeConstraints { make in
            make.bottom.equalTo(nameLabel.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(300)
        }
        
        chartView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20) // Position below nameLabel
            make.left.equalToSuperview()
            make.height.equalTo(300)
        }
        
        priceTargetContainerView.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.top)
            make.left.equalTo(chartView.snp.right)
            make.width.equalTo(30)
            make.bottom.equalTo(chartView.snp.bottom)
        }
        
        capsuleContainerView.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.top)
            make.left.equalTo(priceTargetContainerView.snp.right)
            make.right.equalToSuperview()
            make.width.equalTo(80)
            make.bottom.equalTo(chartView.snp.bottom)
        }
    }
    
    // MARK: lineChartData
    
    lazy var lineChartDataEntries: [ChartDataEntry] = Self.Stub.lineChartDataEntries
    
    var lineChartDataSet: LineChartDataSet {
        let dataSet = LineChartDataSet(entries: lineChartDataEntries,
                                       label: "Sample Data")
        dataSet.colors = [NSUIColor.blue] // Set the line color
        dataSet.valueColors = [NSUIColor.black] // Set the value text color
        return dataSet
    }
    
    // MARK: scatterChartData
    
    lazy var scatterChartDataEntries: [ChartDataEntry] = Self.Stub.scatterChartDataEntries
    
    var scatterChartDataSet: ScatterChartDataSet {
        let dataSet = ScatterChartDataSet(entries: scatterChartDataEntries,
                                          label: "Scatter Data")
        dataSet.colors = [NSUIColor.red]
        dataSet.scatterShapeSize = 10
        dataSet.shapeRenderer = CircleShapeRenderer()
        return dataSet
    }
    
    func getItemYPosition(value: Double) -> CGFloat? {
        let entry = ChartDataEntry(x: 0, y: value)
        let position = chartView.getPosition(entry: entry,
                                             axis: .left)
        return position.y
    }

    // max , now , avg , min , higher then now , lower then now
//    func drawPoints(yValues: [Double], now: Double) -> [DrawLine] {
//        let max = yValues.max() ?? 0
//        let avg = yValues.reduce(0, +) / Double(yValues.count)
//        let min = yValues.min() ?? 0
//
//        // nowToMax get range of yValue from now...max
//        let nowToMax: [Double] = yValues.filter { $0 >= now && $0 <= max }
//        // nowToMin get range of yValue from now...min
//        let nowToMin: [Double] = yValues.filter { $0 >= now && $0 <= min }
//
//        return []
//    }

    func createPairOfPoint(from: CGPoint, to: [CGPoint]) -> [(from: CGPoint, to: CGPoint)] {
        to.map { (from: from, to: $0) }
    }

    func updateChartRenderer() {
        let maxColsePriceOfChart = lineChartDataEntries.map { $0.y }.max() ?? 0
        let minClosePriceOfChart = lineChartDataEntries.map { $0.y }.min() ?? 0
        let renderer = RKetCombinedChartRenderer(chart: chartView,
                                                 animator: chartView.chartAnimator,
                                                 viewPortHandler: chartView.viewPortHandler,
                                                 maxPrice: 300,//maxColsePriceOfChart,
                                                 minPrice: 0) //minClosePriceOfChart)
        chartView.renderer = renderer
    }

    private func initChart() {
        let _lineChartDataSet = lineChartDataSet
        let _scatterChartDataSet = scatterChartDataSet

        let lineChartData = LineChartData(dataSet: _lineChartDataSet)
        let scatterChartData = ScatterChartData(dataSets: [_scatterChartDataSet])

        let combinedChartData = CombinedChartData()
        combinedChartData.lineData = lineChartData
        // disable for now
        //combinedChartData.scatterData = scatterChartData

        chartView.data = combinedChartData

        updateChartRenderer()
    }

    func getAllPriceTargetPositions(entries: [ChartDataEntry],
                                    in chartView: BarLineChartViewBase) -> [CGPoint]
    {
        entries.map {
            let dataSets = chartView.data?.dataSets
            let last = dataSets?.last
            let p = chartView.getPosition(entry: $0,
                                          axis: .left)
            print("point \(p.x) \(p.y)")
            return p
        }
    }

    private func initDrawLine() {
        // 1) draw straight line from (0,0) to (max_width, 0)
        let maxWidth = drawDemoContainerView.bounds.width
        let startPoint = CGPoint(x: 0, y: 10)
        let endPoint = CGPoint(x: 100, y: 10)
        drawDemoContainerView.drawStraightLine(from: startPoint,
                                               to: endPoint,
                                               strokeColor: .black,
                                               lineWidth: 2)

        // 2) draw dashed line from (0,10) to (max_width, 10)
        let startPoint2 = CGPoint(x: 0, y: 30)
        let endPoint2 = CGPoint(x: 100, y: 30)
        drawDemoContainerView.drawDashedLine(from: startPoint2,
                                             to: endPoint2,
                                             strokeColor: .black,
                                             lineWidth: 2,
                                             lineDashPattern: [4, 4],
                                             lineCap: .round)

        // 3) draw lower triangle at (0,30)
        let pointA = CGPoint(x: 0, y: 50)
        let pointB = CGPoint(x: 100, y: 50)
        let pointC = CGPoint(x: 100, y: 150)
        drawDemoContainerView.drawTriangle(withPoints: pointA,
                                           pointB: pointB,
                                           pointC: pointC,
                                           fillColor: .blue,
                                           strokeColor: .black,
                                           lineWidth: 0,
                                           alpha: 0.5)

        // 4) draw upper triangle at (0,150)
        let pointA2 = CGPoint(x: 0, y: 150)
        let pointB2 = CGPoint(x: 100, y: 150)
        let pointC2 = CGPoint(x: 0, y: 50)
        drawDemoContainerView.drawTriangle(withPoints: pointA2,
                                           pointB: pointB2,
                                           pointC: pointC2,
                                           fillColor: .red,
                                           strokeColor: .black,
                                           lineWidth: 0,
                                           alpha: 0.5)

        // 5) draw circle
        let center = CGPoint(x: 50, y: 200)
        let radius: CGFloat = 3
        drawDemoContainerView.drawCircle(at: center,
                                         radius: radius,
                                         color: .black,
                                         strokeColor: .red,
                                         lineWidth: 0.5,
                                         alpha: 0.5)

        // 6) draw horizontal capsule
        let capsuleStartPoint = CGPoint(x: 50, y: 250)
        drawDemoContainerView.drawHorizontalCapsule(at: capsuleStartPoint,
                                                    width: 20,
                                                    height: 6,
                                                    color: .black,
                                                    strokeColor: .red,
                                                    lineWidth: 0.5,
                                                    alpha: 0.5)
    }
}

extension CustomViewController: ChartViewDelegate {
    func chartValueSelected(_: ChartViewBase,
                            entry _: ChartDataEntry,
                            highlight _: Highlight)
    {
//        viewModel?.chartValueSelected(entry: entry)
//        playChartHipticIfNeeded(forSelectingEntry: entry)
//        manageMarker(forChart: chartView)
//        manageTooltip(forChart: chartView,
//                      entry: entry,
//                      highlight: highlight)
//        updateMinMaxDotImageColor(forSelectedChartEntry: entry)
    }

    func chartValueNothingSelected(_: ChartViewBase) {
//        hideTooltipView()
//        resetMinMaxDotImage()
//        viewModel?.chartViewDidEndPanning()
    }

    func chartViewDidEndPanning(_: ChartViewBase) {
//        HapticHelper.sharedInstance.impactStyle(.medium)
//        removeChartHighLight()
//        hideTooltipView()
//        resetMinMaxDotImage()
//        viewModel?.chartViewDidEndPanning()
//        viewModel?.trackChartAreaDragged()
    }
}

// MARK: data for render shape

extension CustomViewController {
    // [Lines] -> [(startPoint: CGPoint, endPoint: CGPoint , dashStyle: CAShapeLayerLineCap)]

    // StartPoint

    // StartShape: Shape and color

    // [EndPoint]

    // EndPoint: Shape and color

   
    
}

extension CustomViewController {}

// MARK: Shape

extension CustomViewController {
    
}

// MARK: Stub Chart Data

extension CustomViewController {
    enum Stub {
        static var lineChartDataEntries: [ChartDataEntry] {
            let dataEntries = OHLC.Stub.simple1.enumerated().map { ref -> ChartDataEntry in
                ChartDataEntry(x: Double(ref.offset),
                               y: ref.element.close)
            }

            return dataEntries
        }

        static var scatterChartDataEntries: [ChartDataEntry] {
            let simple = OHLC.Stub.simple1
            let lastIndex: Int = simple.count - 1
            let dataEntries = OHLC.Stub.simple1.enumerated().map { ref -> ChartDataEntry in
                ChartDataEntry(x: Double(lastIndex),
                               y: ref.element.close)
            }

            return dataEntries
        }
        
        static var randomY: [Double] {
            (0 ..< 10).map { _ in Double.random(in: 100...200) }
        }
    }
}

/*
 //
 //  UIView+DrawShape.swift
 //  YourProject
 //
 //  Created by IntrodexMac on 21/10/2567 BE.
 //
 import UIKit

 extension UIView {
     func drawStraightLine(from startPoint: CGPoint,
                           to endPoint: CGPoint,
                           strokeColor: UIColor = .black,
                           lineWidth: CGFloat = 2.0,
                           alpha: Float = 1.0) // Added alpha parameter
     {
         let linePath = UIBezierPath()
         linePath.move(to: startPoint)
         linePath.addLine(to: endPoint)

         let shapeLayer = CAShapeLayer()
         shapeLayer.path = linePath.cgPath
         shapeLayer.strokeColor = strokeColor.cgColor
         shapeLayer.lineWidth = lineWidth
         shapeLayer.opacity = alpha // Set the alpha value

         layer.addSublayer(shapeLayer)
     }

     func drawDashedLine(from startPoint: CGPoint,
                         to endPoint: CGPoint,
                         strokeColor: UIColor = .black,
                         lineWidth: CGFloat = 2.0,
                         lineDashPattern: [NSNumber] = [2, 2],
                         lineCap: CAShapeLayerLineCap = .butt,
                         alpha: Float = 1.0) // Added alpha parameter
     {
         let dashedLinePath = UIBezierPath()
         dashedLinePath.move(to: startPoint)
         dashedLinePath.addLine(to: endPoint)

         let dashedShapeLayer = CAShapeLayer()
         dashedShapeLayer.path = dashedLinePath.cgPath
         dashedShapeLayer.strokeColor = strokeColor.cgColor
         dashedShapeLayer.lineWidth = lineWidth
         dashedShapeLayer.lineDashPattern = lineDashPattern // 6 points solid, 3 points space
         dashedShapeLayer.lineCap = lineCap
         dashedShapeLayer.opacity = alpha // Set the alpha value

         layer.addSublayer(dashedShapeLayer)
     }

     func drawTriangle(withPoints pointA: CGPoint,
                       pointB: CGPoint,
                       pointC: CGPoint,
                       fillColor: UIColor = .blue,
                       strokeColor: UIColor = .black,
                       lineWidth: CGFloat = 2.0,
                       alpha: Float = 1.0) // Added alpha parameter
     {
         let trianglePath = UIBezierPath()
         trianglePath.move(to: pointA)
         trianglePath.addLine(to: pointB)
         trianglePath.addLine(to: pointC)
         trianglePath.close() // Completes the triangle

         let triangleLayer = CAShapeLayer()
         triangleLayer.path = trianglePath.cgPath
         triangleLayer.fillColor = fillColor.cgColor // Background color for the triangle
         triangleLayer.strokeColor = strokeColor.cgColor
         triangleLayer.lineWidth = lineWidth
         triangleLayer.opacity = alpha // Set the alpha value

         layer.addSublayer(triangleLayer)
     }

     func drawCircle(at center: CGPoint,
                     radius: CGFloat = 2,
                     color: UIColor = .black,
                     strokeColor: UIColor = .black,
                     lineWidth: CGFloat = 2.0,
                     alpha: Float = 0.5) {
         // Create a circular path
         let circlePath = UIBezierPath(arcCenter: center,
                                       radius: radius,
                                       startAngle: 0,
                                       endAngle: CGFloat.pi * 2,
                                       clockwise: true)

         // Create a CAShapeLayer to hold the path
         let circleLayer = CAShapeLayer()
         circleLayer.path = circlePath.cgPath
         circleLayer.fillColor = color.cgColor // Set the circle fill color
         circleLayer.strokeColor = strokeColor.cgColor // Set the border color (optional)
         circleLayer.lineWidth = lineWidth // Set the border width
         circleLayer.opacity = alpha // Set opacity to 1.0 for full visibility

         // Add the circle layer to the view's layer
         self.layer.addSublayer(circleLayer)
     }

     func drawHorizontalCapsule(at centerPoint: CGPoint,
                                width: CGFloat,
                                height: CGFloat,
                                color: UIColor = .black,
                                strokeColor: UIColor = .black,
                                lineWidth: CGFloat = 2.0,
                                alpha: CGFloat = 0.5) {
         // Calculate the origin based on the center point
         let originX = centerPoint.x - (width / 2)
         let originY = centerPoint.y - (height / 2)
         let capsulePath = UIBezierPath(roundedRect: CGRect(x: originX, y: originY, width: width, height: height), cornerRadius: height / 2)

         let capsuleLayer = CAShapeLayer()
         capsuleLayer.path = capsulePath.cgPath
         capsuleLayer.fillColor = color.cgColor
         capsuleLayer.strokeColor = strokeColor.cgColor
         capsuleLayer.lineWidth = lineWidth
         capsuleLayer.opacity = Float(alpha)

         self.layer.addSublayer(capsuleLayer)
     }
 }

 */
