//
// modelIOSV2.swift
//
// This file was automatically generated and should not be edited.
//
/*
import CoreML


/// Model Prediction Input Type
@available(macOS 10.15, iOS 12.4, tvOS 13.0, watchOS 6.0, *)
class modelIOSV2Input : MLFeatureProvider {

    /// input_3 as color (kCVPixelFormatType_32BGRA) image buffer, 224 pixels wide by 224 pixels high
    var input_3: CVPixelBuffer

    var featureNames: Set<String> {
        get {
            return ["input_3"]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "input_3") {
            return MLFeatureValue(pixelBuffer: input_3)
        }
        return nil
    }
    
    init(input_3: CVPixelBuffer) {
        self.input_3 = input_3
    }
}

/// Model Prediction Output Type
@available(macOS 10.15, iOS 12.4, tvOS 13.0, watchOS 6.0, *)
class modelIOSV2Output : MLFeatureProvider {

    /// Source provided by CoreML

    private let provider : MLFeatureProvider


    /// Identity as multidimensional array of floats
    lazy var Identity: MLMultiArray = {
        [unowned self] in return self.provider.featureValue(for: "Identity")!.multiArrayValue
    }()!

    var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    init(Identity: MLMultiArray) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["Identity" : MLFeatureValue(multiArray: Identity)])
    }

    init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 10.15, iOS 12.4, tvOS 13.0, watchOS 6.0, *)
class modelIOSV2 {
    var model: MLModel

/// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        print("urlst")
        let bundle = Bundle(for: modelIOSV2.self)
        return bundle.url(forResource: "modelIOSV2", withExtension:"mlmodelc")!
    }

    /**
        Construct a model with explicit path to mlmodelc file
        - parameters:
           - url: the file url of the model
           - throws: an NSError object that describes the problem
    */
    init(contentsOf url: URL) throws {
        print("preinit")
        self.model = try MLModel(contentsOf: url)
        print("complete init")
    }

    /// Construct a model that automatically loads the model from the app's bundle
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
        Construct a model with explicit path to mlmodelc file and configuration
        - parameters:
           - url: the file url of the model
           - configuration: the desired model configuration
           - throws: an NSError object that describes the problem
    */
    init(contentsOf url: URL, configuration: MLModelConfiguration) throws {
        self.model = try MLModel(contentsOf: url, configuration: configuration)
    }

    /**
        Make a prediction using the structured interface
        - parameters:
           - input: the input to the prediction as modelIOSV2Input
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as modelIOSV2Output
    */
    func prediction(input: modelIOSV2Input) throws -> modelIOSV2Output {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface
        - parameters:
           - input: the input to the prediction as modelIOSV2Input
           - options: prediction options
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as modelIOSV2Output
    */
    func prediction(input: modelIOSV2Input, options: MLPredictionOptions) throws -> modelIOSV2Output {
        let outFeatures = try model.prediction(from: input, options:options)
        return modelIOSV2Output(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface
        - parameters:
            - input_3 as color (kCVPixelFormatType_32BGRA) image buffer, 224 pixels wide by 224 pixels high
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as modelIOSV2Output
    */
    func prediction(input_3: CVPixelBuffer) throws -> modelIOSV2Output {
        let input_ = modelIOSV2Input(input_3: input_3)
        return try self.prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface
        - parameters:
           - inputs: the inputs to the prediction as [modelIOSV2Input]
           - options: prediction options
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as [modelIOSV2Output]
    */
    func predictions(inputs: [modelIOSV2Input], options: MLPredictionOptions = MLPredictionOptions()) throws -> [modelIOSV2Output] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [modelIOSV2Output] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  modelIOSV2Output(features: outProvider)
            results.append(result)
        }
        return results
    }
}
*/
