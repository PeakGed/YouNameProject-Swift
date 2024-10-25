//
//  CustomViewController+Capsule.swift
//  YourProject
//
//  Created by IntrodexMac on 24/10/2567 BE.
//
import UIKit
import DGCharts

extension CustomViewController {
    
    struct CapsuleSource {
        static let font: UIFont = .systemFont(ofSize: 12)
        
        let y: CGFloat
        let title: String
        let value: Double
        let textColor: UIColor
        let backgroundColor: UIColor
        
        // apply formatter "xxx.xx"
        var valueWithFormatter: String {
            return String(format: "%.2f", value)
        }
                
        var valueLabelWidth: CGFloat {
            return TextHelper.sizeForSingleLine(fromText: String(valueWithFormatter),
                                                font: Self.font).width
        }
        
        func valueLabelWidth(font: UIFont) -> CGFloat {
            return TextHelper.sizeForSingleLine(fromText: String(valueWithFormatter),
                                                font: font).width
        }
        
        init(y: CGFloat,
             title: String,
             value: Double,
             textColor: UIColor = .black,
             backgroundColor: UIColor = .red) {
            self.y = y
            self.title = title
            self.value = value
            self.textColor = textColor
            self.backgroundColor = backgroundColor
        }
        
    }
    
    // MARK: renderCapsules
    func initStubCapsuleValues(now: ChartDataEntry,
                               max: ChartDataEntry,
                               min: ChartDataEntry,
                               avg: ChartDataEntry) {

        // find yPos
        let nowPos = getChartPos(entry: now)
        let avgPos = getChartPos(entry: avg)
        let minPos = getChartPos(entry: min)
        let maxPos = getChartPos(entry: max)
        
        // map to CapSource
        let nowValue = now.data as? Double ?? 0
        let avgValue = avg.data as? Double ?? 0
        let minValue = min.data as? Double ?? 0
        let maxValue = max.data as? Double ?? 0
        
        let datasources: [CapsuleSource] = [.init(y: CGFloat(nowPos.y),
                                                  title: "Now",
                                                  value: nowValue),
                                            .init(y: CGFloat(avgPos.y),
                                                  title: "Avg",
                                                  value: avgValue),
                                            .init(y: CGFloat(minPos.y),
                                                  title: "Min",
                                                  value: minValue),
                                            .init(y: CGFloat(maxPos.y),
                                                  title: "Max",
                                                  value: maxValue)].sorted {
            $0.y < $1.y
        }
        
        capsuleSize.width = capsuleWidth(sources: datasources)
        
        let viewModels = createCapsules(by: datasources)
        
        viewModels.forEach { viewModel in
            let capsuleView = createCapsuleView(with: viewModel)
            priceTargetCapsulesView.addSubview(capsuleView)
        }
        
        // Update capsule container view layout
        self.priceTargetCapsulesView.snp.updateConstraints { make in
            make.width.equalTo(capsuleSize.width)
        }
    }
    
    func createCapsuleView(with viewModel: CapsuleVM) -> CapsuleView {
        let element = CapsuleView(frame: viewModel.frame)
        element.bind(viewModel)
        //element.delegate = self
        return element
    }
    
    func createCapsules(by capsules: [CapsuleSource],
                        from previousViewModel: CapsuleVM? = nil) -> [CapsuleVM] {
        guard let source = capsules.first else { return [] }
        
        let capsuleHeight = capsuleSize.height
        let minContainerHeight = calculateMinimumHeight(of: capsules)
        let inputHeight = calculateInputHeight(of: capsules)
        let startY: CGFloat = source.y - capsuleHeight / 2.0
        
        let viewModels: [CapsuleVM]
        
        if minContainerHeight > inputHeight {
            viewModels = createCompressedCapsules(from: capsules,
                                                  startY: startY)
        } else {
            viewModels = createNormalCapsules(from: capsules,
                                              previousViewModel: previousViewModel,
                                              startY: startY)
        }
        
        return viewModels
    }
    
    private func createCompressedCapsules(from capsules: [CapsuleSource],
                                          startY: CGFloat) -> [CapsuleVM] {
        let capsuleHeight = capsuleSize.height
        let minContainerHeight = calculateMinimumHeight(of: capsules)
        let maxY = startY + minContainerHeight
        let actualY = maxY > containerHeight ? startY - (maxY - containerHeight) : startY
        
        return capsules.enumerated().map { index, source in
            let originY = actualY + (CGFloat(index) * (capsuleHeight - overlapSpacing))
            let frame = CGRect(x: 0,
                               y: originY,
                               width: capsuleSize.width,
                               height: capsuleSize.height)
            return .init(title: source.title,
                         value: String(source.value),
                         frame: frame)
        }
    }
    
    func createNormalCapsules(from capsules: [CapsuleSource],
                              previousViewModel: CapsuleVM?,
                              startY: CGFloat) -> [CapsuleVM] {
        guard let source = capsules.first else { return [] }
        
        let originY: CGFloat = calculateOriginYForNormalCapsules(
            startY: startY,
            previousViewModel: previousViewModel
        )
        
        let frame = CGRect(x: 0,
                           y: originY,
                           width: capsuleSize.width,
                           height: capsuleSize.height)
        let viewModel = CapsuleVM(title: source.title,
                                  value: String(source.value),
                                  frame: frame)
        let remainingCapsules = Array(capsules.dropFirst())
        
        return [viewModel] + createCapsules(by: remainingCapsules,
                                            from: viewModel)
    }
        
    func capsuleWidth(sources: [CapsuleSource]) -> CGFloat {
        let maxSource = sources.max(by: { $0.valueLabelWidth < $1.valueLabelWidth })
        
        return (maxSource?.valueLabelWidth ?? 0) + (30 + 8)
    }
    
}

// MARK: - Calculator

private extension CustomViewController {
    
    var containerHeight: CGFloat { priceTargetCapsulesView.bounds.height }
    var overlapSpacing: CGFloat { 6.0 }
    
    func calculateMinimumHeight(of capsules: [CapsuleSource]) -> CGFloat {
        let amountOfCapsule = CGFloat(capsules.count)
        let capsuleHeight = capsuleSize.height
        
        guard capsules.count > 1 else { return capsuleHeight }
        
        return (capsuleHeight * amountOfCapsule) - (overlapSpacing * (amountOfCapsule - 1))
    }
    
    func calculateInputHeight(of capsules: [CapsuleSource]) -> CGFloat {
        let sorted = capsules.sorted(by: { $0.y < $1.y })
        let capsuleHeight = capsuleSize.height
        
        guard
            let minY = sorted.first?.y,
            let maxY = sorted.last?.y
        else { return capsuleHeight }
        
        return maxY - minY + capsuleHeight
    }
    
    private func calculateOriginYForNormalCapsules(startY: CGFloat,
                                                   previousViewModel: CapsuleVM?) -> CGFloat {
        let capsuleHeight = capsuleSize.height
        let maxY = startY + capsuleHeight
        var originY: CGFloat = startY
        
        if let previousMaxY = previousViewModel?.frame.maxY,
           startY - previousMaxY < -overlapSpacing {
            let overlapped = startY - previousMaxY
            originY -= overlapped + overlapSpacing
        } else if maxY > containerHeight {
            originY -= maxY - containerHeight
        } else if startY < 0 {
            originY = 0
        }
        
        return originY
    }
   
}
