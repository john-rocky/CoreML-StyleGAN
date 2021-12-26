//
//  ViewController.swift
//  CoreML-StyleGAN
//
//  Created by DAISUKE MAJIMA on 2021/12/26.
//

import UIKit
import CoreML

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    // For save image
    var outputImage:UIImage?
    var ciContext = CIContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runMobileStyleGAN()
    }
    
    func runMobileStyleGAN() {
        do {
            
            // Mapping

            let mappingNetwork = try mappingNetwork(configuration: MLModelConfiguration())
            let input = try MLMultiArray(shape: [1,512] as [NSNumber], dataType: MLMultiArrayDataType.float32)
            
            for i in 0...input.count - 1 {
                input[i] = NSNumber(value: Float32.random(in: -1...1))
            }
            let mappingInput = mappingNetworkInput(var_: input)
            
            let mappingOutput = try mappingNetwork.prediction(input: mappingInput)
            let style = mappingOutput.var_134
            
            // Synthesis
            
            let synthesisNetwork = try synthesisNetwork(configuration: MLModelConfiguration())
            
            let mlinput = synthesisNetworkInput(style: style)
            let output = try synthesisNetwork.prediction(input: mlinput)
            let buffer = output.activation_out
            let ciImage = CIImage(cvPixelBuffer: buffer)
            guard let safeCGImage = ciContext.createCGImage(ciImage, from: ciImage.extent) else { print("Could not create cgimage."); return}
            let image = UIImage(cgImage: safeCGImage)
            
            imageView.image = image
            outputImage = image
            
        } catch let error {
            fatalError("\(error)")
        }
    }
    
    @IBAction func runAgainButtonTapped(_ sender: UIButton) {
        runMobileStyleGAN()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let outputImage = outputImage else {
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(outputImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: NSLocalizedString("saved!",value: "saved!", comment: ""), message: NSLocalizedString("Saved in photo library",value: "Saved in photo library", comment: ""), preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }

}

