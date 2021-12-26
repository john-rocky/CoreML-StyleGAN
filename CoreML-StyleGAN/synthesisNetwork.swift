//
// synthesisNetwork.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML


/// Model Prediction Input Type
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
class synthesisNetworkInput : MLFeatureProvider {

    /// style as 1 by 512 matrix of floats
    var style: MLMultiArray

    var featureNames: Set<String> {
        get {
            return ["style"]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "style") {
            return MLFeatureValue(multiArray: style)
        }
        return nil
    }
    
    init(style: MLMultiArray) {
        self.style = style
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    convenience init(style: MLShapedArray<Float>) {
        self.init(style: MLMultiArray(style))
    }

}


/// Model Prediction Output Type
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
class synthesisNetworkOutput : MLFeatureProvider {

    /// Source provided by CoreML
    private let provider : MLFeatureProvider

    /// activation_out as color (kCVPixelFormatType_32BGRA) image buffer, 1024 pixels wide by 1024 pixels high
    lazy var activation_out: CVPixelBuffer = {
        [unowned self] in return self.provider.featureValue(for: "activation_out")!.imageBufferValue
    }()!

    var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    init(activation_out: CVPixelBuffer) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["activation_out" : MLFeatureValue(pixelBuffer: activation_out)])
    }

    init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
class synthesisNetwork {
    let model: MLModel

    /// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        let bundle = Bundle(for: self)
        return bundle.url(forResource: "synthesisNetwork", withExtension:"mlmodelc")!
    }

    /**
        Construct synthesisNetwork instance with an existing MLModel object.

        Usually the application does not use this initializer unless it makes a subclass of synthesisNetwork.
        Such application may want to use `MLModel(contentsOfURL:configuration:)` and `synthesisNetwork.urlOfModelInThisBundle` to create a MLModel object to pass-in.

        - parameters:
          - model: MLModel object
    */
    init(model: MLModel) {
        self.model = model
    }

    /**
        Construct synthesisNetwork instance by automatically loading the model from the app's bundle.
    */
    @available(*, deprecated, message: "Use init(configuration:) instead and handle errors appropriately.")
    convenience init() {
        try! self.init(contentsOf: type(of:self).urlOfModelInThisBundle)
    }

    /**
        Construct a model with configuration

        - parameters:
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    convenience init(configuration: MLModelConfiguration) throws {
        try self.init(contentsOf: type(of:self).urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct synthesisNetwork instance with explicit path to mlmodelc file
        - parameters:
           - modelURL: the file url of the model

        - throws: an NSError object that describes the problem
    */
    convenience init(contentsOf modelURL: URL) throws {
        try self.init(model: MLModel(contentsOf: modelURL))
    }

    /**
        Construct a model with URL of the .mlmodelc directory and configuration

        - parameters:
           - modelURL: the file url of the model
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    convenience init(contentsOf modelURL: URL, configuration: MLModelConfiguration) throws {
        try self.init(model: MLModel(contentsOf: modelURL, configuration: configuration))
    }

    /**
        Construct synthesisNetwork instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<synthesisNetwork, Error>) -> Void) {
        return self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration, completionHandler: handler)
    }

    /**
        Construct synthesisNetwork instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> synthesisNetwork {
        return try await self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct synthesisNetwork instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<synthesisNetwork, Error>) -> Void) {
        MLModel.load(contentsOf: modelURL, configuration: configuration) { result in
            switch result {
            case .failure(let error):
                handler(.failure(error))
            case .success(let model):
                handler(.success(synthesisNetwork(model: model)))
            }
        }
    }

    /**
        Construct synthesisNetwork instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> synthesisNetwork {
        let model = try await MLModel.load(contentsOf: modelURL, configuration: configuration)
        return synthesisNetwork(model: model)
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as synthesisNetworkInput

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as synthesisNetworkOutput
    */
    func prediction(input: synthesisNetworkInput) throws -> synthesisNetworkOutput {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as synthesisNetworkInput
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as synthesisNetworkOutput
    */
    func prediction(input: synthesisNetworkInput, options: MLPredictionOptions) throws -> synthesisNetworkOutput {
        let outFeatures = try model.prediction(from: input, options:options)
        return synthesisNetworkOutput(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface

        - parameters:
            - style as 1 by 512 matrix of floats

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as synthesisNetworkOutput
    */
    func prediction(style: MLMultiArray) throws -> synthesisNetworkOutput {
        let input_ = synthesisNetworkInput(style: style)
        return try self.prediction(input: input_)
    }

    /**
        Make a prediction using the convenience interface

        - parameters:
            - style as 1 by 512 matrix of floats

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as synthesisNetworkOutput
    */

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func prediction(style: MLShapedArray<Float>) throws -> synthesisNetworkOutput {
        let input_ = synthesisNetworkInput(style: style)
        return try self.prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface

        - parameters:
           - inputs: the inputs to the prediction as [synthesisNetworkInput]
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as [synthesisNetworkOutput]
    */
    func predictions(inputs: [synthesisNetworkInput], options: MLPredictionOptions = MLPredictionOptions()) throws -> [synthesisNetworkOutput] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [synthesisNetworkOutput] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  synthesisNetworkOutput(features: outProvider)
            results.append(result)
        }
        return results
    }
}
