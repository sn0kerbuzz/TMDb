// swift-tools-version:5.2

import PackageDescription

let package = Package(
	name: "TMDb",
	platforms: [
		.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)
	],
	products: [
		.library(name: "TMDb", targets: ["TMDb"])
	],
	dependencies: [
		.package(url: "https://github.com/OpenCombine/OpenCombine.git", from: "0.12.0")
	],
	targets: [
		.target(
			name: "TMDb",
			dependencies: [
				"OpenCombine",
				.product(name: "OpenCombineFoundation", package: "OpenCombine"),
				.product(name: "OpenCombineDispatch", package: "OpenCombine")
			]
		),
		.testTarget(name: "TMDbTests", dependencies: ["TMDb"])
	]
)
