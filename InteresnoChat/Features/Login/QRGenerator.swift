import CoreImage
import CoreImage.CIFilterBuiltins
import UIKit

final class QRGenerator {

    static func generate(from string: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()

        filter.setValue(Data(string.utf8), forKey: "inputMessage")

        guard let outputImage = filter.outputImage else {
            return UIImage()
        }

        let scaled = outputImage.transformed(by: CGAffineTransform(scaleX: 10, y: 10))

        guard let cgImage = context.createCGImage(scaled, from: scaled.extent) else {
            return UIImage()
        }

        return UIImage(cgImage: cgImage)
    }
}
