//
//  ColorPaletteView.swift
//  aestarodubtsevPW2
//
//  Created by Andrew on 29.10.2022.
//

//import Foundation
import UIKit

final class ColorPaletteView: UIControl {
    
    private let stackView = UIStackView()
    private(set) var chosenColor: UIColor = .systemGray6
    private var colorProtocol : ColorProtocol?
    
    init(_ colorProtocol : ColorProtocol = ColorObserver()) {
        super.init(frame: .zero)
        self.colorProtocol = colorProtocol
        setupView()
        
    }
    
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        let redControl = ColorSliderView(colorName: "R", value:
                                            Float(CIColor(color: chosenColor).red))
        let greenControl = ColorSliderView(colorName: "G", value:
                                            Float(CIColor(color: chosenColor).green))
        let blueControl = ColorSliderView(colorName: "B", value:
                                            Float(CIColor(color: chosenColor).red))
        redControl.tag = 0
        greenControl.tag = 1
        blueControl.tag = 2
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(redControl)
        stackView.addArrangedSubview(greenControl)
        stackView.addArrangedSubview(blueControl)
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 12
        
        [redControl, greenControl, blueControl].forEach { $0.addTarget(self, action: #selector(sliderMoved(slider:)), for: .touchDragInside)
        }
        addSubview(stackView)
        stackView.pin(to: self, [.left: 8, .top: 8, .right: 8, .bottom: 8])
    }
    
    @objc
    private func sliderMoved(slider: ColorSliderView) {
        switch slider.tag { case 0:
            self.chosenColor = UIColor(
                red: CGFloat(slider.value),
                green: CIColor(color: chosenColor).green, blue: CIColor(color: chosenColor).blue, alpha: CIColor(color: chosenColor).alpha
            ) case 1:
            self.chosenColor = UIColor(
                red: CIColor(color: chosenColor).red, green: CGFloat(slider.value), blue: CIColor(color: chosenColor).blue, alpha: CIColor(color: chosenColor).alpha
            ) default:
            self.chosenColor = UIColor(
                red: CIColor(color: chosenColor).red, green: CIColor(color: chosenColor).green, blue: CGFloat(slider.value), alpha: CIColor(color: chosenColor).alpha
            ) }
        colorProtocol?.changeColor(chosenColor)
        sendActions(for: .touchDragInside)
    }
    
    //пункт 8
    public func changeSliders(_ color: UIColor) {
        for slider  in stackView.arrangedSubviews{
            let sl = slider as? ColorSliderView
            switch sl?.tag {
            case 0:
                sl?.changeSlider(newValue: Float(CIColor(color: chosenColor).red))
            case 1:
                sl?.changeSlider(newValue: Float(CIColor(color: chosenColor).green))
            default:
                sl?.changeSlider(newValue: Float(CIColor(color: chosenColor).blue))
            }
        }
    }
    
}
