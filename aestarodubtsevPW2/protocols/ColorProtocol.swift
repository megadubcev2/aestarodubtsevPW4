import UIKit

protocol ColorProtocol: AnyObject {
    func changeColor(_ color: UIColor)
}

class ColorObserver: ColorProtocol{
    internal var view : UIView?
    init(_ view: UIView = UIView()){
        self.view = view
    }
    
    func changeColor(_ color: UIColor) {
        UIView.animate(withDuration: 0.5) {
            self.view?.backgroundColor = color
        }
    }
    
}
