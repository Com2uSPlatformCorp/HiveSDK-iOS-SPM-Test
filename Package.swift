// swift-tools-version: 5.10
import PackageDescription

/**
 * - packageVersion 선언을 아래로 옮기지 마세요.
 * - 타겟 순서는 [ 필수 - 플러그인 - 선택 - 제공자 ] 순이며, 각 그룹 내에서는 오름차순(인스펙터바 폴더 목록 참고)으로 선언합니다.
 */
private let packageVersion = "0.0.6"

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
        xcframeworkTarget(name: "HIVECore", checksum: "aa92ba1125fe05ce652a51a6c59090e4cff4db662cb4edc5e43994e3852e7468"),
        xcframeworkTarget(name: "HIVEProtocol", checksum: "c918a0e2b0a72708f41fe64a638a6eb2f8e0cea159fa94e5a5a3e5fd1c7d218f"),
        xcframeworkTarget(name: "HIVEUI", checksum: "df01d3ed21574c88c7d989155934d612e8935d36e5dffe8778c93789b42566b8"),
        xcframeworkTarget(name: "HIVEService", checksum: "285f4da18eec228e3f8572f42bd6ca40da1dfa688c382da7a035b26a02d00f65"),
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
        xcframeworkTarget(name: "HIVE_SDK_Plugin", checksum: "dabce2c1d5f5d9f8898650331971d497909ff6706b3ceb6177b92955871c2a3f"),
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
        xcframeworkTarget(name: "HIVE_SDK_UnityPlugin", checksum: "db7dad87cc9c7d6e15e5b10e0048bd4ba4f9cdcfadd9c172513bf9d961f04d48"),
// MARK: HiveAnalyticsConsentMode
        .target(
            name: "AnalyticsConsentMode",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "HiveAnalyticsConsentMode")
            ],
            path: "AnalyticsConsentMode"
        ),
        xcframeworkTarget(name: "HiveAnalyticsConsentMode", checksum: "b7d795a26ca2a394f36e5d5a97a1772a289e52183958d6bed27c64dfa71dfdfe"),
// MARK: HiveChat
        .target(
            name: "Chat",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "HiveChat")
            ],
            path: "Chat"
        ),
        xcframeworkTarget(name: "HiveChat", checksum: "5c8ba3e81f3de2d9e1c7d64ff385ff21901aa463331a2a32e236129f2e3ed2dd"),
// MARK: HiveDataStore
        .target(
            name: "DataStore",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "HiveDataStore")
            ],
            path: "DataStore"
        ),
        xcframeworkTarget(name: "HiveDataStore", checksum: "5a6865f5b79692003d40216b298c40fde3cae5243e75a6c9d67469256c9bdb31"),
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
        xcframeworkTarget(name: "HiveDeviceManagement", checksum: "90ea2923c8e9ed38877708cafa03602b6915b75297d9ee5b87f9116298ba1be4"),
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
        xcframeworkTarget(name: "HIVEExtensions", checksum: "9b431fb46587a63b564e71ee092aa94a3a1e5debe052419f3f9287535abc272a"),
// MARK: HIVEIAPV4
        .target(
            name: "IAPV4",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "HIVEIAPV4")
            ],
            path: "IAPV4"
        ),
        xcframeworkTarget(name: "HIVEIAPV4", checksum: "cd25c2891348abfb5b4ece773f218fe497a45e73181d846687d1474de7d87b4e"),
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
        xcframeworkTarget(name: "HIVEIAPV4Repayment", checksum: "3dfef313e6bda030cca920a0ffa94fdefbf4ac9772527532118c50663433d2c9"),
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
        xcframeworkTarget(name: "HiveMatchMaking", checksum: "240f64971eedc7db3e26c8517f5d04fd884d1b55869906a1c94af92c42d46c1c"),
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
        xcframeworkTarget(name: "HivePromotion", checksum: "3bad51d40bf78a799c16f88eded0a0c8d2c87cb8c256fa917c771cda18ac22ba"),
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
        xcframeworkTarget(name: "HiveRealNameVerification", checksum: "3c6fb9701778533643ab6336ffe7989e7b5d76b2a0393f7f0ed9619b45bff99b"),
        bundleTarget(name: "RealNameVerification"),
// MARK: HiveRecaptcha
        .target(
            name: "Recaptcha",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "HiveRecaptcha"),
                .product(name: "RecaptchaEnterprise", package: "recaptcha-enterprise-mobile-sdk")
            ],
            path: "Recaptcha"
        ),
        xcframeworkTarget(name: "HiveRecaptcha", checksum: "6adc05bd539881814e563773afdd899702489e95af3aed8ebcad68d652518abd"),
// MARK: HiveAnalyticsProviderAdjust
        .target(
            name: "AnalyticsProviderAdjust",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderAdjust"),
                .product(name: "AdjustSdk", package: "ios_sdk")
            ],
            path: "AnalyticsProviderAdjust"
        ),
        xcframeworkTarget(name: "ProviderAdjust", checksum: "dc609e6ad20ec9727f3a546d0b041af08943a62b41077e7c2767d5669c637df0"),
// MARK: HiveAnalyticsProviderAirbridge
        .target(
            name: "AnalyticsProviderAirbridge",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderAirbridge"),
                .product(name: "Airbridge", package: "airbridge-ios-sdk-deployment")
            ],
            path: "AnalyticsProviderAirbridge"
        ),
        xcframeworkTarget(name: "ProviderAirbridge", checksum: "fe650908934babe3493bc0672712e13777f4f533a30cede14e6029897851b574"),
// MARK: HiveAnalyticsProviderAppsFlyer
        .target(
            name: "AnalyticsProviderAppsFlyer",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderAppsFlyer"),
                .product(name: "AppsFlyerLib", package: "AppsFlyerFramework")
            ],
            path: "AnalyticsProviderAppsFlyer"
        ),
        xcframeworkTarget(name: "ProviderAppsFlyer", checksum: "841f82cebced4aebc062779b440ebc8805d1cbbc56dd0ed3eac422ef937e076b"),
// MARK: HiveAnalyticsProviderFirebase
        .target(
            name: "AnalyticsProviderFirebase",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderFirebase"),
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk")
            ],
            path: "AnalyticsProviderFirebase"
        ),
        xcframeworkTarget(name: "ProviderFirebase", checksum: "96a546b1caef48f75bba2e76d578c90a55b84535e6c0a153da6c8fa6f17be519"),
// MARK: HiveAnalyticsProviderSingular
        .target(
            name: "AnalyticsProviderSingular",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderSingular"),
                .product(name: "Singular", package: "Singular-iOS-SDK")
            ],
            path: "AnalyticsProviderSingular"
        ),
        xcframeworkTarget(name: "ProviderSingular", checksum: "0addb2b96d4360b1efbc0d6f013cd469b615a628fd11af3709f49b5ae3565a0b"),
// MARK: HiveAuthV4ProviderApple(GameCenter)
        .target(
            name: "AuthV4ProviderAppleGameCenter",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderApple")
            ],
            path: "AuthV4ProviderAppleGameCenter"
        ),
        xcframeworkTarget(name: "ProviderApple", checksum: "70ae5b86d1e2d043e548aab99f48821fd210777063bfc623deaea39e66c729cc"),
// MARK: HiveAuthV4ProviderFacebook
        .target(
            name: "AuthV4ProviderFacebook",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderFacebook"),
                .product(name: "FacebookLogin", package: "facebook-ios-sdk"),
                .product(name: "FacebookShare", package: "facebook-ios-sdk"),
                .product(name: "FacebookGamingServices", package: "facebook-ios-sdk")
            ],
            path: "AuthV4ProviderFacebook"
        ),
        xcframeworkTarget(name: "ProviderFacebook", checksum: "72a360a4fc0d703101e46260842f598a85f17813e984ab153f69b16be5a90db2"),
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
        xcframeworkTarget(name: "ProviderGoogle", checksum: "fcfd7b0e0cab65ce06d45b0d8d435854ed9610459a40a5d110167944be572764"),
// MARK: HiveAuthV4ProviderHive
        .target(
            name: "AuthV4ProviderHive",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderHive")
            ],
            path: "AuthV4ProviderHive"
        ),
        xcframeworkTarget(name: "ProviderHive", checksum: "6a32ead2ebfb41fa6daeee135a9b26e4f82508b02bdd2ef33a17906b99efa868"),
// MARK: HiveAuthV4ProviderLine
        .target(
            name: "AuthV4ProviderLine",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderLine"),
                .product(name: "LineSDK", package: "line-sdk-ios-swift")
            ],
            path: "AuthV4ProviderLine"
        ),
        xcframeworkTarget(name: "ProviderLine", checksum: "cb519da6d83c9ae0cb5f228df1f0c91b198378fa9d884f230829c2b5b449ed12"),
// MARK: HiveAuthV4ProviderSignInApple
        .target(
            name: "AuthV4ProviderSignInApple",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderSignInApple")
            ],
            path: "AuthV4ProviderSignInApple"
        ),
        xcframeworkTarget(name: "ProviderSignInApple", checksum: "c6cadaf18a997924f63db68c5bedc0dc2265459599ad926fd6663d65e89f3f5e"),
// MARK: HiveAuthV4ProviderSteam
        .target(
            name: "AuthV4ProviderSteam",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderSteam")
            ],
            path: "AuthV4ProviderSteam"
        ),
        xcframeworkTarget(name: "ProviderSteam", checksum: "a7aba30523ae1ef162933ee6711ca2ae74bd9b4c56b6ae53d8da6be7a25c743d"),
// MARK: HiveAuthV4ProviderTelegram
        .target(
            name: "AuthV4ProviderTelegram",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderTelegram")
            ],
            path: "AuthV4ProviderTelegram"
        ),
        xcframeworkTarget(name: "ProviderTelegram", checksum: "eaf228413df95c2d085b47f62a56a18ad1c365c7dbad2b2b7d4589a52e6d6700"),
// MARK: HiveAuthV4ProviderVK
        .target(
            name: "AuthV4ProviderVK",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderVK")
            ],
            path: "AuthV4ProviderVK"
        ),
        xcframeworkTarget(name: "ProviderVK", checksum: "2e471944b38f35d31d7cd7b2fb557ad8217aece37e9c0de9205ea22746bf909e"),
// MARK: HiveAuthV4ProviderWeverse
        .target(
            name: "AuthV4ProviderWeverse",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderWeverse")
            ],
            path: "AuthV4ProviderWeverse"
        ),
        xcframeworkTarget(name: "ProviderWeverse", checksum: "90d7b5fc426ace049defe3732c898a551e187ab893bb790a8414c8426a3752bb"),
// MARK: HiveAuthV4ProviderX
        .target(
            name: "AuthV4ProviderX",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderX")
            ],
            path: "AuthV4ProviderX"
        ),
        xcframeworkTarget(name: "ProviderX", checksum: "809172ed19b08374f5dcd609082000824e805a1fc5bde5ce3abda9f493bb7707")
    ]
)

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
