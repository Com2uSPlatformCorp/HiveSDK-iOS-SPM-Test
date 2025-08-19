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
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", exact: "5.20.0"),
        .package(url: "https://github.com/google/GoogleSignIn-iOS.git", exact: "8.0.0")
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
        xcframeworkTarget(name: "HIVECore", checksum: "772ac3c80266689cf773fd0bd2dd6baf2256b7fcfa182bb04b5d650e5f1fbb62"),
        xcframeworkTarget(name: "HIVEProtocol", checksum: "c6e6110f731a04c8072ca7b065ff57640bb1d7a21ff69d0a803c9b6ff89f823c"),
        xcframeworkTarget(name: "HIVEUI", checksum: "f49c603115335640a562b254a845b9c1837f7b91743e431e642d8e335e97c54e"),
        xcframeworkTarget(name: "HIVEService", checksum: "3b8318b31a7868234f97ebd6261708f8c2dc34f383e82f1903f16f5852b703af"),
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
        xcframeworkTarget(name: "HIVE_SDK_Plugin", checksum: "4ab60d5fc5695c3373331b6daf8d28f5bcc64144203c5832966a5e9a8ce1658b"),
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
        xcframeworkTarget(name: "HIVE_SDK_UnityPlugin", checksum: "33211ad23973382020a5def2fbdc7e62dd0d5a323aaff44bb9648e1cd3e13010"),
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
        xcframeworkTarget(name: "HivePromotion", checksum: "e62953cba55d352469f3db5a9d6ff8db1b59b67e4cb117d2c9e07106b6414121"),
        bundleTarget(name: "Promotion"),
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
        xcframeworkTarget(name: "HiveDeviceManagement", checksum: "a7f6a34593e8734c5ef7d9b962fdec49bc825483242cc850bd855877f6213262"),
        bundleTarget(name: "DeviceManagement"),
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
        xcframeworkTarget(name: "ProviderGoogle", checksum: "da11068f6f283b378183d480dd994f238288dedad64fa35a59c024112abddfdd")
    ]
)

private let packageVersion = "0.0.2"

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
