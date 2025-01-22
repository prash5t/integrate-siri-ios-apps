import Flutter
import Intents
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    print("app delegate ma")
      
//    donateIntent()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
//    func donateIntent() {
//        print("donate intent invoked")
//        let intent = LoadBalanceIntent()
//        intent.suggestedInvocationPhrase = "Load balance in village pay"
//        intent.amount = 99
//        let interaction = INInteraction(intent: intent, response: nil)
//        interaction.donate{ (error) in
//            if error != nil {
//                if let error = error as NSError? {
//                    print("Interaction donation failed : \(error.description)")
//                } else {
//                    print("Successful donation")
//                }
//                
//            }
//        }
//    }
}
 
