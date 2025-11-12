// swift-tools-version: 5.8
import PackageDescription

let package = Package(
	name: "SIDSDK",
	defaultLocalization: "en",
	platforms: [
		.iOS(.v15)
	],
	products: [
		.library(
			name: "SIDSDKDynamic",
			targets: ["SIDSDKDynamicWrapper"]
		),
		.library(
			name: "SIDSDKStatic",
			targets: ["SIDSDKStaticWrapper"]
		),
		.library(
			name: "SIDSDKDynamic-CS",
			targets: ["SIDSDKDynamic-CSBinary"]
		),
		.library(
			name: "SIDSDKStatic-CS",
			targets: ["SIDSDKStaticWrapper_CS"]
		)
	],
	dependencies: [
		.package(
			url: "https://gitverse.ru/clickstream/iOS-SDK-Package.git",
			exact: "1.6.0"
		)
	],
	targets: [
		// Бинарная цель для динамической библиотеки
		.target(
			name: "SIDSDKDynamicWrapper",
			dependencies: [
				.target(name: "SIDSDKDynamicBinary"),
				.product(name: "Clickstream", package: "iOS-SDK-Package")
			]
		),
		.binaryTarget(
			name: "SIDSDKDynamicBinary",
			path: "XCFrameworks/SIDSDKDynamic.zip"
		),


		// Обёртка над статической библиотекой, куда «прокидываем» bundle
		.target(
			name: "SIDSDKStaticWrapper",
			dependencies: [
				"SIDSDKStaticBinary",
				.product(name: "Clickstream", package: "iOS-SDK-Package")
			],
			exclude: ["SIDSDKResourcesBundle.bundle/Info.plist"], // исключаем Info.plist из bundle
			resources: [
				.process("SIDSDKResourcesBundle.bundle")
			]
		),		// Бинарная цель для статической библиотеки
		.binaryTarget(
			name: "SIDSDKStaticBinary",
			path: "./XCFrameworks/SIDSDKStatic.zip"
		),


		// Бинарная цель для динамической библиотеки без Кликстрима
		.binaryTarget(
			name: "SIDSDKDynamic-CSBinary",
			path: "XCFrameworks/SIDSDKDynamic-CS.zip"
		),


		// Обёртка над статической библиотекой, куда «прокидываем» bundle. Без Кликстрима
		.target(
			name: "SIDSDKStaticWrapper_CS",
			dependencies: [
				"SIDSDKStaticBinary-CS"
			],
			exclude: ["SIDSDKResourcesBundle.bundle/Info.plist"],
			resources: [
				.process("SIDSDKResourcesBundle.bundle")
			]
		),
		// Бинарная цель для статической библиотеки без Кликстрима
		.binaryTarget(
			name: "SIDSDKStaticBinary-CS",
			path: "./XCFrameworks/SIDSDKStatic-CS.zip"
		)
	]
)
