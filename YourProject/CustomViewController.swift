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
    // MARK: - Views
    lazy var chartContainerView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.alignment = .fill
        element.distribution = .fill
        element.spacing = 0
        return element
    }()
    
    lazy var priceChartView: CombinedChartView = {
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

    lazy var priceTargetChartView: PriceTargetView = {
        let element = PriceTargetView()
        element.backgroundColor = .brown
        return element
    }()

    lazy var priceTargetCapsulesView: UIView = {
        let element = UIView()
        element.backgroundColor = .brown
        element.alpha = 0.5
        return element
    }()
    
    // MARK: - Data Stores
    var lineChartDataSet: LineChartDataSet {
        let dataSet = LineChartDataSet(entries: lineChartDataEntries,
                                       label: "Sample Data")
        dataSet.colors = [NSUIColor.blue]
        dataSet.valueColors = [NSUIColor.black]
        return dataSet
    }
    
    var priceTarget: PriceTargetResult?
    var priceChartDataSet: LineChartDataSet?
    var priceTargetChartDataSet: ScatterChartDataSet?
    
    var lineChartDataEntries: [ChartDataEntry] = []
    var scatterChartDataEntries: [ChartDataEntry] = []
    var capsuleSize: CGSize = .init(width: 0,
                                    height: 26)
    
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
        fetchChartData()
//        initChartStubData()
//        initChart()
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            guard
//                let nowChartDataEntry = self.nowChartDataEntry,
//                let minChartDataEntry = self.minChartDataEntry,
//                let maxChartDataEntry = self.maxChartDataEntry,
//                let avgChartDataEntry = self.avgChartDataEntry
//            else { return }
//            
//            self.initStubTargetPriceView(now: nowChartDataEntry,
//                                         max: maxChartDataEntry,
//                                         min: minChartDataEntry,
//                                         avg: avgChartDataEntry,
//                                         other: self.otherChartDataEntries)
//            
//            self.initStubCapsuleValues(now: nowChartDataEntry,
//                                       max: maxChartDataEntry,
//                                       min: minChartDataEntry,
//                                       avg: avgChartDataEntry)
//        }
    }
    
    private func fetchChartData() {
        Task {
            let priceOHLCs = OHLC.Stub.simple1
            guard
                let currentPrice = priceOHLCs.last?.close,
                let priceTarget = MockPriceTargetGenerator().generateMockData(currentPrice: currentPrice).response.result
            else {
                print("No data")
                return
            }
            self.priceTarget = priceTarget
            fetchDataSuccess(priceTarget: priceTarget,
                                   OHLCs: priceOHLCs)
        }
    }
    
    @MainActor
    func fetchDataSuccess(priceTarget: PriceTargetResult,
                          OHLCs: [OHLC]) {
        guard
            let currentPrice = OHLCs.last?.close
        else {
            print("No data")
            return
        }
        
        priceChartDataSet = createPriceChartDataSet(prices: OHLCs)
        priceTargetChartDataSet = createPriceTargetChartDataSet(priceTarget: priceTarget,
                                                                currentPrice: currentPrice)
        initChart()
    }
    
    private func createPriceChartDataSet(prices: [OHLC]) -> LineChartDataSet {
        let priceChartEntries = prices.enumerated().map { (index, item) in
            ChartDataEntry(x: Double(index),
                           y: item.close)
        }
        
        let dataSet = LineChartDataSet(entries: priceChartEntries,
                                       label: "Historical Price")
        dataSet.colors = [NSUIColor.blue]
        dataSet.valueColors = [NSUIColor.black]
        
        return dataSet
    }
    
    private func createPriceTargetChartDataSet(priceTarget: PriceTargetResult,
                                               currentPrice: Double) -> ScatterChartDataSet? {
        let summaryPriceTarget = priceTarget.priceTargetSummary
        
        guard
            let averagePriceTarget = Double(summaryPriceTarget.average)
        else {
            return nil
        }
        
        // scatter chart (target price)
        let priceTargetAmount = priceTarget.items
            .map({ $0.priceTarget })
            .map({ Double($0) ?? 0 })
        
        let priceTargetWithSummaryAmount = priceTargetAmount + [averagePriceTarget, currentPrice]
        let targetChartEntries = priceTargetWithSummaryAmount.map({ ChartDataEntry(x: 0, y: $0) })
        
        let dataSet = ScatterChartDataSet(entries: targetChartEntries,
                                          label: "Target Price")
        dataSet.colors = [NSUIColor.red]
        dataSet.scatterShapeSize = 10
        dataSet.shapeRenderer = CircleShapeRenderer()
        
        return dataSet
    }
    
//    func initChartStubData() {
//        lineChartDataEntries = Self.Stub.lineChartDataEntries
//        
//        let lineLastEntry = lineChartDataEntries.last
//        let lineLastEntryX = lineLastEntry?.x ?? 0
//        let now = lineLastEntry?.y ?? 0
//        
//        self.nowChartDataEntry = ChartDataEntry(x: lineLastEntryX,
//                                                y: now,
//                                                data: now)
//        
//        let generator = MockPriceTargetGenerator()
//        let mockData = generator.generateMockData(currentPrice: now)
//        
//        let sumPrice = mockData.response.result?.priceTargetSummary
//        
//        let avg: Double = Double(sumPrice?.average ?? "0") ?? 0
//        let other: [Double] = mockData.response.result?.items.compactMap({
//            Double($0.priceTarget)
//        }) ?? []
//        
//        
//        let entriesGroup = Self.Stub.generateEntries(avg: avg,
//                                                     now: now,
//                                                     other: other)
//        
//        minChartDataEntry = entriesGroup.minEntry
//        maxChartDataEntry = entriesGroup.maxEntry
//        avgChartDataEntry = entriesGroup.avgEntry
//        otherChartDataEntries = entriesGroup.other
//        
//        let secoundGroup = [minChartDataEntry,
//                            maxChartDataEntry,
//                            avgChartDataEntry,
//                            nowChartDataEntry].compactMap { $0 }
//        
//        scatterChartDataEntries = entriesGroup.other + secoundGroup
//    }
    
    
    func initStubTargetPriceView(now: ChartDataEntry,
                                 max: ChartDataEntry,
                                 min: ChartDataEntry,
                                 avg: ChartDataEntry,
                                 other: [ChartDataEntry])
    {
        let nowPos = getChartPos(entry: now)
        let avgPos = getChartPos(entry: avg)
                        
        let startPos: CGPoint = .init(x: 0,
                                      y: nowPos.y)
        let endXPos = priceTargetChartView.bounds.width
        let yValues: [CGFloat] = self.getPositions(entries: other + [max,min],
                                                in: self.priceChartView).map({ CGFloat($0.y) })
        
        let vm = PriceTargetVM(startPoint: startPos,
                               endX: endXPos,
                               yValues: yValues,
                               yAvg: avgPos.y)
        priceTargetChartView.bind(vm)
    }

    private func initViews() {
        view.backgroundColor = .white
        view.addSubview(chartContainerView)
        chartContainerView.addArrangedSubview(priceChartView)
        chartContainerView.addArrangedSubview(priceTargetChartView)
        chartContainerView.addArrangedSubview(priceTargetCapsulesView)
    }
    

    private func initConstriantLayout() {
        chartContainerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        priceChartView.snp.makeConstraints { make in
            make.height.equalTo(300)
        }

        priceTargetChartView.snp.makeConstraints { make in
            make.top.bottom.equalTo(priceChartView)
            make.width.equalTo(30)
        }

        priceTargetCapsulesView.snp.makeConstraints { make in
            make.top.bottom.equalTo(priceChartView)
            make.width.equalTo(capsuleSize.width)
        }
    }

    func updateChartRenderer() {
        let combine = lineChartDataEntries + scatterChartDataEntries
        let maxColsePriceOfChart = combine.map { $0.y }.max() ?? 0
        let minClosePriceOfChart = combine.map { $0.y }.min() ?? 0
        let renderer = RKetCombinedChartRenderer(chart: priceChartView,
                                                 animator: priceChartView.chartAnimator,
                                                 viewPortHandler: priceChartView.viewPortHandler,
                                                 maxPrice: maxColsePriceOfChart,
                                                 minPrice: minClosePriceOfChart)
        priceChartView.renderer = renderer
    }
    
    private func initChart() {
        guard
            let priceChartDataSet,
            let priceTargetChartDataSet
        else { return }

        let lineChartData = LineChartData(dataSet: priceChartDataSet)
        let scatterChartData = ScatterChartData(dataSets: [priceTargetChartDataSet])

        let combinedChartData = CombinedChartData()
        combinedChartData.lineData = lineChartData
        combinedChartData.scatterData = scatterChartData

        priceChartView.data = combinedChartData

        updateChartRenderer()
    }

    func getPositions(entries: [ChartDataEntry],
                      in chartView: BarLineChartViewBase) -> [CGPoint]
    {
        entries.map {
            let p = chartView.getPosition(entry: $0,
                                          axis: .left)
            return p
        }
    }
    
    func getChartPos(entry: ChartDataEntry) -> CGPoint {
        let p = priceChartView.getPosition(entry: entry,
                                      axis: .left)
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
