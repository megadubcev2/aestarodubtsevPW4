//
//  WelcomeViewController.swift
//  aestarodubtsevPW2
//
//  Created by Andrew on 02.10.2022.
//
import UIKit

final class WelcomeViewController: UIViewController {
    private let commentLabel = UILabel()
    private let valueLabel = UILabel()
    private var value: Int = 0
    private let incrementButton = UIButton()
    private var buttonsSV = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupIncrementButton() {
        incrementButton.setTitle("Increment", for: .normal)
        incrementButton.setTitleColor(.black, for: .normal)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        incrementButton.backgroundColor = .white
        //incrementButton.layer.applyShadow()
        
        // add shadow
        incrementButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        incrementButton.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        incrementButton.layer.shadowOpacity = 0.5
        incrementButton.layer.shadowRadius = 10
        incrementButton.layer.masksToBounds = false
        
        self.view.addSubview(incrementButton)
        incrementButton.setHeight(48)
        incrementButton.pinTop(to: self.view.centerYAnchor)
        incrementButton.pinCenterX(to: self.view)
        incrementButton.pin(to: self.view, [.left: 24, .right: 24])
        incrementButton.addTarget(self, action:
                                    #selector(incrementButtonPressed), for: .touchUpInside)
    }
    
    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0, weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"
        self.view.addSubview(valueLabel)
        valueLabel.pinBottom(to: incrementButton.topAnchor, 16)
        valueLabel.pinCenterX(to: self.view)
    }
    
    @discardableResult
    private func setupCommentView() -> UIView {
        let commentView = UIView()
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 12
        view.addSubview(commentView)
        commentView.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        commentView.pin(to: self.view, [.left: 24, .right: 24])
        
        
        commentLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        commentLabel.textColor = .systemGray
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        commentView.addSubview(commentLabel)
        commentLabel.pin(to: commentView, [.top: 16, .left: 16,
                                           .bottom: 16, .right: 16])
        
        return commentView
    }
    
    @objc
    private func incrementButtonPressed(_ sender: Any) {
        
        
        let button = sender as? UIButton
        button?.isEnabled = false
        
        value += 1
        // вибрация кнопки
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        // анимация
        UIView.transition(with: commentLabel, duration: 0.2, options: .transitionCrossDissolve, animations: updateUI)
        { completion in button?.isEnabled = true}
        
    }
    
    private func updateCommentLabel(value: Int) {
        switch value {
        case 0...10:
            commentLabel.text = "1"
        case 10...20:
            commentLabel.text = "2"
        case 20...30:
            commentLabel.text = "3"
        case 30...40:
            commentLabel.text = "4"
        case 40...50:
            commentLabel.text = "🎉 🎉 🎉 🎉 🎉 🎉 🎉 🎉 🎉 "
            
        case 50...60:
            commentLabel.text = "big boy"
        case 60...70:
            commentLabel.text = "70 70 70 moreeeee"
        case 70...80:
            commentLabel.text = "⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ "
            
        case 80...90:
            commentLabel.text = "80+\n go higher!"
        case 90...100:
            commentLabel.text = "100!! to the moon!!"
        default:
            break
        }
    }
    
    //menu buttons
    

    
    

    
    private var colorPaletteView = ColorPaletteView()
    
    private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        return button
    }
    
    
    
    
    private func setupMenuButtons() {
        let colorsButton = makeMenuButton(title: "🎨")
        colorsButton.addTarget(self, action:
                                #selector(paletteButtonPressed), for: .touchUpInside)
        
        let notesButton = makeMenuButton(title: "📝")
        let newsButton = makeMenuButton(title: "📰")
        
        buttonsSV = UIStackView(arrangedSubviews: [colorsButton, notesButton, newsButton])
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually
        
        //buttonsSV.backgroundColor = .systemBlue
        self.view.addSubview(buttonsSV)
        buttonsSV.pin(to: self.view, [.left: 24, .right: 24])
        buttonsSV.pinBottom(to: self.view.safeAreaLayoutGuide.bottomAnchor, 24)
    }
    
    private func setupColorPaletteView(){
        let colorObserver = ColorObserver(view)
        colorPaletteView = ColorPaletteView(colorObserver)
        colorPaletteView.isHidden = true
    }
    
    private func setupColorControlSV() {
        
        view.addSubview(colorPaletteView)
    
        colorPaletteView.pinTop(to: incrementButton.bottomAnchor, 8)
        colorPaletteView.pinBottom(to: buttonsSV.topAnchor, 8)
        colorPaletteView.pinLeft(to: view, 24)
        colorPaletteView.pinRight(to: view, 24)
        
    }
    
    @objc
    private func paletteButtonPressed() {
        //пункт 8
        colorPaletteView.changeSliders(view.backgroundColor ?? .systemGray6)
        
        colorPaletteView.isHidden.toggle()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    
    
    private func setupView() {
        view.backgroundColor = .systemGray6
        setupIncrementButton()
        setupValueLabel()
        setupCommentView()
        setupColorPaletteView()
        setupMenuButtons()
        setupColorControlSV()
    }
    
    private func updateUI()
    {
        valueLabel.text = "\(value)"
        updateCommentLabel(value: value)
    }
    
    
    
}
