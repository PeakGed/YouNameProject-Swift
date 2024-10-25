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
        element.backgroundColor = .brown
        return element
    }()

    lazy var capsuleContainerView: UIView = {
        let element = UIView()
        element.backgroundColor = .brown
        element.alpha = 0.5
        return element
    }()
    
    var capsuleSize: CGSize = .init(width: 0,
                                    height: 26)

    
    // MARK: lineChartData

    var lineChartDataEntries: [ChartDataEntry] = []

    var lineChartDataSet: LineChartDataSet {
        let dataSet = LineChartDataSet(entries: lineChartDataEntries,
                                       label: "Sample Data")
        dataSet.colors = [NSUIColor.blue] // Set the line color
        dataSet.valueColors = [NSUIColor.black] // Set the value text color
        return dataSet
    }

    // MARK: scatterChartData

    var scatterChartDataEntries: [ChartDataEntry] = []
    
    var minChartDataEntry: ChartDataEntry?
    var maxChartDataEntry: ChartDataEntry?
    var avgChartDataEntry: ChartDataEntry?
    var nowChartDataEntry: ChartDataEntry?
    var otherChartDataEntries: [ChartDataEntry] = []

    var scatterChartDataSet: ScatterChartDataSet {
        let dataSet = ScatterChartDataSet(entries: scatterChartDataEntries,
                                          label: "Scatter Data")
        dataSet.colors = [NSUIColor.red]
        dataSet.scatterShapeSize = 10
        dataSet.shapeRenderer = CircleShapeRenderer()
        return dataSet
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        initConstriantLayout()
        
        initChartStubData()
        initChart() // Initialize the chart

        // run price line chart delay 2 sec
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            guard
                let nowChartDataEntry = self.nowChartDataEntry,
                let minChartDataEntry = self.minChartDataEntry,
                let maxChartDataEntry = self.maxChartDataEntry,
                let avgChartDataEntry = self.avgChartDataEntry
            else { return }
            
            self.initStubTargetPriceView(now: nowChartDataEntry,
                                         max: maxChartDataEntry,
                                         min: minChartDataEntry,
                                         avg: avgChartDataEntry,
                                         other: self.otherChartDataEntries)
            
            self.initStubCapsuleValues(now: nowChartDataEntry,
                                       max: maxChartDataEntry,
                                       min: minChartDataEntry,
                                       avg: avgChartDataEntry)
        }
    }
    
    func initChartStubData() {
        lineChartDataEntries = Self.Stub.lineChartDataEntries
        
        self.nowChartDataEntry = lineChartDataEntries.last
        let now = nowChartDataEntry?.y ?? 0
        
        let generator = MockPriceTargetGenerator()
        let mockData = generator.generateMockData(currentPrice: now)
        
        let sumPrice = mockData.response.result?.priceTargetSummary
        
        let avg: Double = Double(sumPrice?.average ?? "0") ?? 0
        let other: [Double] = mockData.response.result?.items.compactMap({
            Double($0.priceTarget)
        }) ?? []
        
        
        let entriesGroup = Self.Stub.generateEntries(avg: avg,
                                                     now: now,
                                                     other: other)
        minChartDataEntry = entriesGroup.minEntry
        maxChartDataEntry = entriesGroup.maxEntry
        avgChartDataEntry = entriesGroup.avgEntry
        otherChartDataEntries = entriesGroup.other
        
        let secoundGroup = [minChartDataEntry,
                            maxChartDataEntry,
                            avgChartDataEntry,
                            nowChartDataEntry].compactMap { $0 }
        
        scatterChartDataEntries = entriesGroup.other + secoundGroup

        // print all entries
        print("###")
        print("Now: \(nowChartDataEntry?.y ?? 0)")
        print("Avg: \(avgChartDataEntry?.y ?? 0)")
        print("Min: \(minChartDataEntry?.y ?? 0)")
        print("Max: \(maxChartDataEntry?.y ?? 0)")

        print("### Scatter Chart Entries: ")
        scatterChartDataEntries.forEach { print($0) }

    }
    
    func initStubTargetPriceView(now: ChartDataEntry,
                                 max: ChartDataEntry,
                                 min: ChartDataEntry,
                                 avg: ChartDataEntry,
                                 other: [ChartDataEntry])
    {
        let startPos: CGPoint = .init(x: 0, y: now.y)
        let endXPos = priceTargetContainerView.bounds.width
        let yValues: [CGFloat] = (other + [max, min]).map { CGFloat($0.y) }
        
        let vm = PriceTargetVM(startPoint: startPos,
                               endX: endXPos,
                               yValues: yValues,
                               yAvg: avg.y)
        //log
        print("###")
        print("### Price Target VM: ")
        print("Start Point: \(startPos)")
        print("End X: \(endXPos)")
        // print all yValues
        yValues.forEach { print("yValue: \($0)") }
        print("Y Avg: \(avg.y)")
        
        priceTargetContainerView.bind(vm)
    }

//    func callAfterDelay3() {
//        // get last entry of line chart
//        let lastEntry = lineChartDataEntries.last!
//
//        let lastPrice = lastEntry.y
//
//        let startPos = CGPoint(x: 0,
//                               y: lastPrice)
//
//        let endXPos = priceTargetContainerView.bounds.width
//
//        let randomY = Stub.randomY
//
//        let max = randomY.max()
//        let min = randomY.min()
//        let avg = randomY.randomElement()
//        let avgMoreThenNow: Bool? = (avg != nil) ? avg! > lastPrice : nil
//
//        print("###")
//        print("Random Y Values: ")
//        randomY.sorted().forEach { print($0) }
//
//        print("###")
//        print("Max Y Value: \(String(describing: max))")
//        print("Min Y Value: \(String(describing: min))")
//        print("Average Y Value: \(String(describing: avg))")
//        print("Average More Than Now: \(String(describing: avgMoreThenNow))")
//
//        print("###")
//        print("Now : \(lastPrice)")
//
//        let yValues = randomY.compactMap { getItemYPosition(value: $0) }
//        let yAvg: CGFloat? = (avg != nil) ? getItemYPosition(value: avg!) : nil
//        let vm = PriceTargetVM(startPoint: startPos,
//                               endX: endXPos,
//                               yValues: yValues,
//                               yAvg: yAvg)
//        priceTargetContainerView.bind(vm)
//    }

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
            make.width.equalTo(capsuleSize.width)
            make.bottom.equalTo(chartView.snp.bottom)
        }
    }

    func createPairOfPoint(from: CGPoint, to: [CGPoint]) -> [(from: CGPoint, to: CGPoint)] {
        to.map { (from: from, to: $0) }
    }

    func updateChartRenderer() {
        let combine = lineChartDataEntries + scatterChartDataEntries
        let maxColsePriceOfChart = combine.map { $0.y }.max() ?? 0
        let minClosePriceOfChart = combine.map { $0.y }.min() ?? 0
        let renderer = RKetCombinedChartRenderer(chart: chartView,
                                                 animator: chartView.chartAnimator,
                                                 viewPortHandler: chartView.viewPortHandler,
                                                 maxPrice: maxColsePriceOfChart,
                                                 minPrice: minClosePriceOfChart)
        chartView.renderer = renderer
    }

    var priceTargetResponse: PriceTargetResponse? = nil
    
    var now: Double {
        lineChartDataEntries.last?.y ?? 0
    }
    
    private func initChart() {
                             
        let _lineChartDataSet = lineChartDataSet
        let _scatterChartDataSet = scatterChartDataSet

        let lineChartData = LineChartData(dataSet: _lineChartDataSet)
        let scatterChartData = ScatterChartData(dataSets: [_scatterChartDataSet])

        let combinedChartData = CombinedChartData()
        combinedChartData.lineData = lineChartData
        // disable for now
        combinedChartData.scatterData = scatterChartData

        chartView.data = combinedChartData

        updateChartRenderer()
    }

    func getAllPriceTargetPositions(entries: [ChartDataEntry],
                                    in chartView: BarLineChartViewBase) -> [CGPoint]
    {
        entries.map {
            let p = chartView.getPosition(entry: $0,
                                          axis: .left)
            print("point \(p.x) \(p.y)")
            return p
        }
    }
    
    func getChartPos(entry: ChartDataEntry) -> CGPoint {
        let p = chartView.getPosition(entry: entry,
                                      axis: .left)
        print("point \(p.x) \(p.y)")
        return p
    }

}

extension CustomViewController: ChartViewDelegate {
    func chartValueSelected(_: ChartViewBase,
                            entry _: ChartDataEntry,
                            highlight _: Highlight)
    {}

    func chartValueNothingSelected(_: ChartViewBase) {}

    func chartViewDidEndPanning(_: ChartViewBase) {}
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
                               y: ref.element.close,
                               data: Double(ref.element.close))
            }

            return dataEntries
        }

        static var randomY: [Double] {
            (0 ..< 10).map { _ in Double.random(in: 100 ... 200) }
        }
        
        static func generateEntries(avg: Double,
                                    now: Double,
                                    other: [Double]) -> (minEntry: ChartDataEntry?,
                                                         maxEntry: ChartDataEntry?,
                                                         avgEntry: ChartDataEntry?,
                                                         nowEntry: ChartDataEntry?,
                                                         other: [ChartDataEntry]) {
            let x = Double(0)
            let avgEntry = ChartDataEntry(x: x,
                                          y: avg,
                                          data: avg)
            let nowEntry = ChartDataEntry(x: x,
                                          y: now,
                                          data: now)
            var otherEntries = other.sorted().enumerated().map { ref -> ChartDataEntry in
                ChartDataEntry(x: x,
                               y: ref.element,
                               data: Double(ref.element))
            }
            
            let minEntry = otherEntries.first
            let maxEntry = otherEntries.last
            
            otherEntries.removeLast()
            otherEntries.removeFirst()
            
            return (minEntry,
                    maxEntry,
                    avgEntry,
                    nowEntry,
                    otherEntries)
        }
        
    }
}

extension CustomViewController {
    
    struct Position {
        let entry: ChartDataEntry
        let point: CGPoint
        
        init(entry: ChartDataEntry,
             x: CGFloat,
             y: CGFloat) {
            self.entry = entry
            self.point = .init(x: x,
                               y: y)
        }
        
        var value: Double {
            entry.data as? Double ?? 0
        }
    }
}
