// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "Hive",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "HiveSDK",
            type: .static,
            targets: [
                "HiveSDK"
            ]
        ),
        .library(
            name: "Hive_SDKPlugin",
            type: .static,
            targets: [
                "Plugin"
            ]
        ),
        .library(
            name: "Hive_SDKUnityPlugin",
            type: .static,
            targets: [
                "UnityPlugin"
            ]
        ),
        .library(
            name: "Hive_Promotion",
            type: .static,
            targets: [
                "Promotion"
            ]
        ),
        .library(
            name: "Hive_DeviceManagement",
            type: .static,
            targets: [
                "DeviceManagement"
            ]
        ),
        .library(
            name: "Hive_AuthV4ProviderGoogle",
            type: .static,
            targets: [
                "AuthV4ProviderGoogle"
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/GoogleCloudPlatform/recaptcha-enterprise-mobile-sdk.git", exact: "18.6.0"),   // Recaptcha
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", exact: "5.20.0"),                                 // SDWebImage
        .package(url: "https://github.com/adjust/ios_sdk.git", exact: "5.2.0"),                                         // Adjust
        .package(url: "https://github.com/AppsFlyerSDK/AppsFlyerFramework.git", exact: "6.16.1"),                       // AppsFlyer
        .package(url: "https://github.com/singular-labs/Singular-iOS-SDK.git", exact: "12.7.1"),                        // Singular
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", exact: "11.6.0"),                             // Firebase
        .package(url: "https://github.com/ab180/airbridge-ios-sdk-deployment.git", exact: "4.3.0"),                     // AirBridge
        .package(url: "https://github.com/facebook/facebook-ios-sdk.git", exact: "17.4.0"),                             // FaceBook
        .package(url: "https://github.com/google/GoogleSignIn-iOS.git", exact: "8.0.0"),                                // Google
        .package(url: "https://github.com/line/line-sdk-ios-swift.git", exact: "5.11.2"),                               // Line
    ],
    targets: [
// MARK: HiveSDK
        .target(
            name: "HiveSDK",
            dependencies: [
                .target(name: "HIVECore"),
                .target(name: "HIVECoreResource"),
                .target(name: "HIVEProtocol"),
                .target(name: "HIVEUI"),
                .target(name: "HIVEUIResource"),
                .target(name: "HIVEService"),
                .target(name: "HIVEServiceResource"),
                .product(name: "SDWebImage", package: "SDWebImage"),
            ],
            path: "SDK",
            sources: [
                "HiveSDK.swift"
            ]
        ),
        xcframeworkTarget(name: "HIVECore", checksum: "307fd6768fc2778a54c09152ba5536ae174c76998e44ede8a4af964b81753a10"),
        xcframeworkTarget(name: "HIVEProtocol", checksum: "bdfd48b2a9cb35b4ed95df0fc401b18681f3255dbbf151210b932ac84b8cd845"),
        xcframeworkTarget(name: "HIVEUI", checksum: "b5ac87c29c23c040335f3f6f62853ac21e60ed429e1a549b34841ebcb32eff27"),
        xcframeworkTarget(name: "HIVEService", checksum: "83ac00bd60aea46bf6a05de89706b81b0aa0fd96a0c236d9421f8bfb9cd220af"),
        bundleTarget(isPrefixUppercased: true, name: "Core"),
        bundleTarget(isPrefixUppercased: true, name: "UI", as: ""),
        bundleTarget(isPrefixUppercased: true, name: "Service"),
// MARK: HIVE_SDK_Plugin
        .target(
            name: "Plugin",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "HIVE_SDK_Plugin")
            ],
            path: "SDKPlugin",
            publicHeadersPath: ".",
            cxxSettings: [
                .unsafeFlags(["-std=c++11", "-stdlib=libc++", "-fcxx-modules"])
            ],
            linkerSettings: [
                .unsafeFlags([
                    "-ObjC"
                ])
            ]
        ),
        xcframeworkTarget(name: "HIVE_SDK_Plugin", checksum: "7f598ef987060b4d2e38d579f3179a54ef8fa919c72c583ffd38878a8823949a"),
// MARK: HIVE_SDK_UnityPlugin
        .target(
            name: "UnityPlugin",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "HIVE_SDK_UnityPlugin")
            ],
            path: "SDKUnityPlugin",
            publicHeadersPath: ".",
            cxxSettings: [
                .unsafeFlags(["-std=c++11", "-stdlib=libc++", "-fcxx-modules"])
            ],
            linkerSettings: [
                .unsafeFlags([
                    "-ObjC"
                ])
            ]
        ),
        xcframeworkTarget(name: "HIVE_SDK_UnityPlugin", checksum: "f1ba6bacf5642f8c11a95607bae9833a3e123683eb11a189f301baed8f182ef3"),
// MARK: HiveAnalyticsConsentMode
        .target(
            name: "AnalyticsConsentMode",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "HiveAnalyticsConsentMode")
            ],
            path: "AnalyticsConsentMode"
        ),
        xcframeworkTarget(name: "HiveAnalyticsConsentMode", checksum: "c192576edb47e9d7fbcf2d4b6fe394390cef3e7f2faa04a7ee15f2c1818e6d49"),
// MARK: HiveChat
        .target(
            name: "Chat",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "HiveChat")
            ],
            path: "Chat"
        ),
        xcframeworkTarget(name: "HiveChat", checksum: "bdfd9e6759f6abcd4b2951e01ae6cdc5a91be4e11b21522db42b9c7b247ba7ae"),
// MARK: HiveDataStore
        .target(
            name: "DataStore",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "HiveDataStore")
            ],
            path: "DataStore"
        ),
        xcframeworkTarget(name: "HiveDataStore", checksum: "adca1c37e652d6cf292fc2798ff20eb6a2cd6b60a81bb72cbfc60e3a9f73d1ab"),
// MARK: HiveDeviceManagement
        .target(
            name: "DeviceManagement",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "HiveDeviceManagement"),
                .target(name: "HiveDeviceManagementResource")
            ],
            path: "DeviceManagement"
        ),
        xcframeworkTarget(name: "HiveDeviceManagement", checksum: "bdcfe86d0a68c08ee17ad3ecd03a34e7a124b37b7f7cab4a552581e2c1d45c13"),
        bundleTarget(name: "DeviceManagement"),
// MARK: HIVEExtensions
        .target(
            name: "Extensions",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "HIVEExtensions")
            ],
            path: "Extensions"
        ),
        xcframeworkTarget(name: "HIVEExtensions", checksum: "1e1553a627564ffa6e91ffb38fc78e5ed5a47dfd74e8d6578fd005862947f447"),
// MARK: HIVEIAPV4
        .target(
            name: "IAPV4",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "HIVEIAPV4")
            ],
            path: "IAPV4"
        ),
        xcframeworkTarget(name: "HIVEIAPV4", checksum: "ffaeab8c23a2394c577e42d03162b552da0c4992962ed28b2d81fc482bcf3279"),
        bundleTarget(isPrefixUppercased: true, name: "IAPV4"),
// MARK: HIVEIAPV4Repayment
        .target(
            name: "IAPV4Repayment",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "HIVEIAPV4Repayment")
            ],
            path: "IAPV4Repayment"
        ),
        xcframeworkTarget(name: "HIVEIAPV4Repayment", checksum: "c40a80062dc96c589996d36815f5db215e94539e89d4d8f85fd601841c53e5f7"),
        bundleTarget(isPrefixUppercased: true, name: "IAPV4Repayment"),
// MARK: HiveMatchMaking
        .target(
            name: "MatchMaking",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "HiveMatchMaking")
            ],
            path: "MatchMaking"
        ),
        xcframeworkTarget(name: "HiveMatchMaking", checksum: "fb0466be19e9c89bbc30adbfc677462f30aca6afa3e8c502a1896c75e671c399"),
// MARK: HivePromotion
        .target(
            name: "Promotion",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "HivePromotion"),
                .target(name: "HivePromotionResource")
            ],
            path: "Promotion"
        ),
        xcframeworkTarget(name: "HivePromotion", checksum: "b21b258aa78ffe35a3d6f851e3d4a56b277a8fba373495218632f7c61df41bec"),
        bundleTarget(name: "Promotion"),
// MARK: HiveRealNameVerification
        .target(
            name: "RealNameVerification",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "HiveRealNameVerification")
            ],
            path: "RealNameVerification"
        ),
        xcframeworkTarget(name: "HiveRealNameVerification", checksum: "5004667b9878fc2c97912a0caf945d8b90c576390a8748dea7c636dcaa734158"),
        bundleTarget(name: "RealNameVerification"),
// MARK: HiveRecaptcha
        .target(
            name: "Recaptcha",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "HiveRecaptcha"),
                .product(name: "RecaptchaEnterprise", package: "RecaptchaEnterprise")
            ],
            path: "Recaptcha"
        ),
        xcframeworkTarget(name: "HiveRecaptcha", checksum: "6849acf01aed9b9459230cbf1c91f99c22d1afc367b04d4b2ad5643684606f4e"),
// MARK: HiveAnalyticsProviderAdjust
        .target(
            name: "AnalyticsProviderAdjust",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderAdjust"),
                .product(name: "AdjustSdk", package: "AdjustSdk")
            ],
            path: "AnalyticsProviderAdjust"
        ),
        xcframeworkTarget(name: "ProviderAdjust", checksum: "aea2f46e532f013311fd8b294639aef3cf16afbefb85138b56e32ebe72d84730"),
// MARK: HiveAnalyticsProviderAirbridge
        .target(
            name: "AnalyticsProviderAirbridge",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderAirbridge"),
                .product(name: "Airbridge", package: "Airbridge")
            ],
            path: "AnalyticsProviderAirbridge"
        ),
        xcframeworkTarget(name: "ProviderAirbridge", checksum: "b466eaea0496fa608bf302786c01d5aedd585bf93b5f56820a31de468b4ee322"),
// MARK: HiveAnalyticsProviderAppsFlyer
        .target(
            name: "AnalyticsProviderAppsFlyer",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderAppsFlyer"),
                .product(name: "AppsFlyerLib", package: "AppsFlyerLib")
            ],
            path: "AnalyticsProviderAppsFlyer"
        ),
        xcframeworkTarget(name: "ProviderAppsFlyer", checksum: "40a59303cc383d32717d6c16890025d649f9cf85079a4d697086c2931c5c8fe0"),
// MARK: HiveAnalyticsProviderFirebase
        .target(
            name: "AnalyticsProviderFirebase",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderFirebase"),
                .product(name: "FirebaseAnalytics", package: "Firebase")
            ],
            path: "AnalyticsProviderFirebase"
        ),
        xcframeworkTarget(name: "ProviderFirebase", checksum: "0cfaf0c06dfc4b6c0eb874ece6e7211e64ed3be68af23f56f44b307e2cb432c5"),
// MARK: HiveAnalyticsProviderSingular
        .target(
            name: "AnalyticsProviderSingular",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderSingular"),
                .product(name: "Singular", package: "Singular")
            ],
            path: "AnalyticsProviderSingular"
        ),
        xcframeworkTarget(name: "ProviderSingular", checksum: "d63896b2cd35599f0ee730679b8ed2997b48bf72d16eabb60e068121ec2c2cb3"),
// MARK: HiveAuthV4ProviderApple(GameCenter)
        .target(
            name: "AuthV4ProviderAppleGameCenter",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderApple")
            ],
            path: "AuthV4ProviderAppleGameCenter"
        ),
        xcframeworkTarget(name: "ProviderApple", checksum: "7b2d70ba31a5d9bf28b36714443b881097b3e078879abb66b70d84e0d8f4fbc0"),
// MARK: HiveAuthV4ProviderFacebook
        .target(
            name: "AuthV4ProviderFacebook",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderFacebook"),
                .product(name: "FacebookLogin", package: "Facebook"),
                .product(name: "FacebookShare", package: "Facebook"),
                .product(name: "FacebookGamingServices", package: "Facebook")
            ],
            path: "AuthV4ProviderFacebook"
        ),
        xcframeworkTarget(name: "ProviderFacebook", checksum: "be96c408ee276ef85749a4569873a67ac09ceae6fd30d2ab19f206082fed0132"),
// MARK: HiveAuthV4ProviderGoogle
        .target(
            name: "AuthV4ProviderGoogle",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderGoogle"),
                .product(name: "GoogleSignIn", package: "GoogleSignIn-iOS")
            ],
            path: "AuthV4ProviderGoogle"
        ),
        xcframeworkTarget(name: "ProviderGoogle", checksum: "55832dca912f546f6e2b5eb4e4c3455ed0c5c6f0294ed5909288ae99e3ff15e1"),
// MARK: HiveAuthV4ProviderHive
        .target(
            name: "AuthV4ProviderHive",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderHive")
            ],
            path: "AuthV4ProviderHive"
        ),
        xcframeworkTarget(name: "ProviderHive", checksum: "6467ba99c4478b5bf533f063062459e50d9c817b243a583b8d6464a5dbd4813c"),
// MARK: HiveAuthV4ProviderLine
        .target(
            name: "AuthV4ProviderLine",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderLine"),
                .product(name: "LineSDK", package: "LineSDK")
            ],
            path: "AuthV4ProviderLine"
        ),
        xcframeworkTarget(name: "ProviderLine", checksum: "3d201e946bd08c5bafba31975ac38309cc3fd1b8793be434e5cce7da6c41a550"),
// MARK: HiveAuthV4ProviderSignInApple
        .target(
            name: "AuthV4ProviderSignInApple",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderSignInApple")
            ],
            path: "AuthV4ProviderSignInApple"
        ),
        xcframeworkTarget(name: "ProviderSignInApple", checksum: "d1f44de9f4093344389f1c25dc4dd9a1661db49c7cfbb96333c9323385c3fc56"),
// MARK: HiveAuthV4ProviderSteam
        .target(
            name: "AuthV4ProviderSteam",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderSteam")
            ],
            path: "AuthV4ProviderSteam"
        ),
        xcframeworkTarget(name: "ProviderSteam", checksum: "319012ecb777a6b7a967219bf5d949c573d2fbaf52d27a06b4999f3d2d31d1d5"),
// MARK: HiveAuthV4ProviderTelegram
        .target(
            name: "AuthV4ProviderTelegram",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderTelegram")
            ],
            path: "AuthV4ProviderTelegram"
        ),
        xcframeworkTarget(name: "ProviderTelegram", checksum: "a85ae711a99e70624ead78086d022406dc6a8947e5e6b01d51c79d19f337ea3c"),
// MARK: HiveAuthV4ProviderVK
        .target(
            name: "AuthV4ProviderVK",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderVK")
            ],
            path: "AuthV4ProviderVK"
        ),
        xcframeworkTarget(name: "ProviderVK", checksum: "3b398536822fc4f84d1b5d0ca656af900c8a2f0ac00f111570f6cfd1338e6b37"),
// MARK: HiveAuthV4ProviderWeverse
        .target(
            name: "AuthV4ProviderWeverse",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderWeverse")
            ],
            path: "AuthV4ProviderWeverse"
        ),
        xcframeworkTarget(name: "ProviderWeverse", checksum: "4703273c5d7d63fff5ba75bc55ea05b5e1767da90f5ab807c93e2966ffbf6862"),
// MARK: HiveAuthV4ProviderX
        .target(
            name: "AuthV4ProviderX",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderX")
            ],
            path: "AuthV4ProviderX"
        ),
        xcframeworkTarget(name: "ProviderX", checksum: "18d6fea0f3c832db5999006938da6a69da17fa4845f8c773a0dfd7b29e5b39c5")
    ]
)

private let packageVersion = "0.0.5"

private func xcframeworkTarget(
    name: String,
    checksum: String
) -> Target {
    .binaryTarget(
        name: name,
        url: "https://github.com/Com2uSPlatformCorp/HiveSDK-iOS-SPM-Test/releases/download/\(packageVersion)/\(name).xcframework.zip",
        checksum: checksum
    )
}

private func bundleTarget(
    isPrefixUppercased: Bool = false,
    name: String,
    as customName: String? = nil
) -> Target {
    let hiveString = isPrefixUppercased ? "HIVE" : "Hive"
    let bundleName = "\(name)Resource"
    let targetName = "\(hiveString)\(name)Resource"
    let bundlePath = "\(hiveString)\(customName ?? name)Resource.bundle"
    let sourcePath = "Hive_\(bundleName).swift"
    let infoPlists = name != "Service"
    ? ["\(bundlePath)/Info.plist"]
    : ["\(bundlePath)/Info.plist",
       "\(bundlePath)/HIVEResource.storyboardc/Info.plist"]
    
    return .target(
        name: targetName,
        path: bundleName,
        exclude: infoPlists,
        sources: [
            sourcePath
        ],
        resources: [
            .process(bundlePath)
        ],
        publicHeadersPath: ""
    )
}
