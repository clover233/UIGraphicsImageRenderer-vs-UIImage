import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var currentDrawType = 0
  
    func drawRectangle() {
        let size = CGSize(width: 512, height: 512)
        
        // 1. 创建图像上下文
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        // 2. 确保结束时关闭上下文
        defer { UIGraphicsEndImageContext() }
        
        // 3. 获取当前上下文
        if let context = UIGraphicsGetCurrentContext() {
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            
            // 4. 设置绘图属性
            context.setFillColor(UIColor.red.cgColor)
            context.setStrokeColor(UIColor.black.cgColor)
            context.setLineWidth(10)
            
            // 5. 绘制路径
            context.addRect(rectangle)
            context.drawPath(using: .fillStroke)
            
            // 6. 从上下文中获取图像
            if let img = UIGraphicsGetImageFromCurrentImageContext() {
                imageView.image = img
            }
        }
    }
    
    func drawCircle() {
        let size = CGSize(width: 512, height: 512)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        if let context = UIGraphicsGetCurrentContext() {
            let rectangle = CGRect(x: 5, y: 5, width: 502, height: 502)
            
            context.setFillColor(UIColor.red.cgColor)
            context.setStrokeColor(UIColor.black.cgColor)
            context.setLineWidth(10)
            
            context.addEllipse(in: rectangle)
            context.drawPath(using: .fillStroke)
            
            if let img = UIGraphicsGetImageFromCurrentImageContext() {
                imageView.image = img
            }
        }
    }
    
    func drawCheckerboard() {
        let size = CGSize(width: 512, height: 512)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(UIColor.black.cgColor)
            
            for row in 0..<8 {
                for col in 0..<8 {
                    if (row + col) % 2 == 0 {
                        context.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
            
            if let img = UIGraphicsGetImageFromCurrentImageContext() {
                imageView.image = img
            }
        }
    }
    
    func drawRotatedSquares() {
        let size = CGSize(width: 512, height: 512)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        if let context = UIGraphicsGetCurrentContext() {
            // 设置变换
            context.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            // 绘制旋转的正方形
            for _ in 0..<rotations {
                context.rotate(by: CGFloat(amount))
                context.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            
            context.setStrokeColor(UIColor.black.cgColor)
            context.strokePath()
            
            if let img = UIGraphicsGetImageFromCurrentImageContext() {
                imageView.image = img
            }
        }
    }
    
    func drawLines() {
        let size = CGSize(width: 512, height: 512)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        if let context = UIGraphicsGetCurrentContext() {
            context.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            
            for _ in 0..<256 {
                context.rotate(by: CGFloat.pi / 2)
                
                if first {
                    context.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    context.addLine(to: CGPoint(x: length, y: 50))
                }
                
                length *= 0.99
            }
            
            context.setStrokeColor(UIColor.black.cgColor)
            context.strokePath()
            
            if let img = UIGraphicsGetImageFromCurrentImageContext() {
                imageView.image = img
            }
        }
    }
    
    func drawImagesAndText() {
        let size = CGSize(width: 512, height: 512)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        // 1. 绘制文本
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "HelveticaNeue-Thin", size: 36)!,
            .paragraphStyle: paragraphStyle
        ]
        
        let string = "The best-laid schemes o'\nmice an' men gang aft agley" as NSString
        string.draw(
            with: CGRect(x: 32, y: 32, width: 448, height: 448),
            options: .usesLineFragmentOrigin,
            attributes: attrs,
            context: nil
        )
        
        // 2. 绘制图像
        if let mouse = UIImage(named: "mouse") {
            mouse.draw(at: CGPoint(x: 300, y: 150))
        }
        
        // 3. 获取最终图像
        if let img = UIGraphicsGetImageFromCurrentImageContext() {
            imageView.image = img
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawRectangle()
    }

    @IBAction func redrawTapped(_ sender: UIButton) {
        currentDrawType += 1
        
        if currentDrawType > 5 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        case 2:
            drawCheckerboard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()
        default:
            break
        }
    }
}
