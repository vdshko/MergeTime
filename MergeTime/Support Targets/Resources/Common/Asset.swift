import UIKit

public enum Asset {}

public final class ColorAsset {
    
    public typealias Color = UIColor
    public var name: String
    public var bundle: Bundle
    public private(set) lazy var color: Color = Color(asset: self)
    
    public init() {
        self.name = ""
        self.bundle = BundleToken.bundle
    }
}

extension ColorAsset.Color {
    
    convenience init!(asset: ColorAsset) {
        self.init(named: asset.name, in: asset.bundle, compatibleWith: nil)
    }
}

public class ImageAsset {
    
    public typealias Image = UIImage
    public var name: String
    public var bundle: Bundle
    public var image: Image {
        guard let image = Image(named: name, in: bundle, compatibleWith: nil) else {
            fatalError("Unable to load image named \(name).")
        }
        
        return image
    }
    
    public init() {
        name = ""
        bundle = BundleToken.bundle
    }
}

private final class BundleToken {
    
    static let bundle = Bundle(for: BundleToken.self)
}
