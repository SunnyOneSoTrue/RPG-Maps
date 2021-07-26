import UIKit

@IBDesignable class CustomSignInTextView: UITextField {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - UI Setup
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        self.backgroundColor = color
        self.textColor = textcolor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    // MARK: - Properties
    @IBInspectable
    var color: UIColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.00) {
        didSet {
            self.backgroundColor = color
        }
    }
    
    @IBInspectable
    var textcolor: UIColor = .white {
        didSet {
            self.backgroundColor = color
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 2 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00) {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
