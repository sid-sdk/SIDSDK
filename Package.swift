// swift-tools-version: 5.8
import PackageDescription

let package = Package(
	name: "SIDSDK",
	defaultLocalization: "en",
	platforms: [
		.iOS(.v14)
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
			targets: ["SIDSDKStaticWrapper-CS"]
		),
		.library(
			name: "ClickstreamAnalytics",
			targets: ["ClickstreamAnalytics"]
		)
	],
	targets: [
		// Бинарная цель для динамической библиотеки
		.target(
			name: "SIDSDKDynamicWrapper",
			dependencies: [
				.target(name: "SIDSDKDynamicBinary"),
				.target(name: "ClickstreamAnalytics")
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
				.target(name: "SIDSDKStaticBinary"),
				.target(name: "ClickstreamAnalytics")
			],
			exclude: ["SIDSDKResourcesBundle.bundle/Info.plist"],
			resources: [
				.process("SIDSDKResourcesBundle.bundle")
			]
		),
		// Бинарная цель для статической библиотеки
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
			name: "SIDSDKStaticWrapper-CS",
			dependencies: [
				.target(name: "SIDSDKStaticBinary-CS")
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
		),


		// Библиотека для отправки аналитики
		.binaryTarget(
			name: "ClickstreamAnalytics",
			path: "XCFrameworks/ClickstreamAnalytics.zip"
		),
	]
)
