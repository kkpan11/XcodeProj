import AEXML
import Foundation
import PathKit

public extension XCScheme {
    // swiftlint:disable:next type_body_length
    final class LaunchAction: SerialAction {
        public enum Style: String, Sendable {
            case auto = "0"
            case wait = "1"
            case custom = "2"
        }

        public enum GPUFrameCaptureMode: String, Sendable {
            case autoEnabled = "0"
            case metal = "1"
            case openGL = "2"
            case disabled = "3"
        }

        // The value used to disable 'API Validation'.
        // If this feature is not being disabled, this value will not be present.
        public let gpuValidationModeDisableValue = "1"

        // The value used to enable 'Shader Validation'.
        // If this feature is not being enabled, this value will not be present.
        public let gpuShaderValidationModeEnableValue = "2"

        // MARK: - Static

        private static let defaultBuildConfiguration = "Debug"
        public static let defaultDebugServiceExtension = "internal"
        private static let defaultLaunchStyle = Style.auto
        public static let defaultGPUFrameCaptureMode = GPUFrameCaptureMode.autoEnabled

        // MARK: - Attributes

        public var runnable: Runnable?
        public var macroExpansion: BuildableReference?
        public var selectedDebuggerIdentifier: String
        public var selectedLauncherIdentifier: String
        public var buildConfiguration: String
        public var launchStyle: Style
        public var askForAppToLaunch: Bool?
        public var pathRunnable: PathRunnable? {
            // For backwards compatibility
            get {
                runnable as? PathRunnable
            }
            set {
                runnable = newValue
            }
        }

        public var customWorkingDirectory: String?
        public var useCustomWorkingDirectory: Bool
        public var ignoresPersistentStateOnLaunch: Bool
        public var debugDocumentVersioning: Bool
        public var debugServiceExtension: String
        public var allowLocationSimulation: Bool
        public var locationScenarioReference: LocationScenarioReference?
        public var enableGPUFrameCaptureMode: GPUFrameCaptureMode
        public var disableGPUValidationMode: Bool
        public var enableGPUShaderValidationMode: Bool
        public var showGraphicsOverview: Bool
        public var logGraphicsOverview: Bool
        public var enableAddressSanitizer: Bool
        public var enableASanStackUseAfterReturn: Bool
        public var enableThreadSanitizer: Bool
        public var stopOnEveryThreadSanitizerIssue: Bool
        public var enableUBSanitizer: Bool
        public var stopOnEveryUBSanitizerIssue: Bool
        public var disableMainThreadChecker: Bool
        public var disablePerformanceAntipatternChecker: Bool
        public var stopOnEveryMainThreadCheckerIssue: Bool
        public var additionalOptions: [AdditionalOption]
        public var commandlineArguments: CommandLineArguments?
        public var environmentVariables: [EnvironmentVariable]?
        public var language: String?
        public var region: String?
        public var showNonLocalizedStrings: Bool
        public var launchAutomaticallySubstyle: String?
        public var storeKitConfigurationFileReference: StoreKitConfigurationFileReference?
        // To enable the option in Xcode: defaults write com.apple.dt.Xcode IDEDebuggerFeatureSetting 12
        public var customLaunchCommand: String?
        public var customLLDBInitFile: String?
        public var appClipInvocationURLString: String?

        // MARK: - Init

        public init(runnable: Runnable?,
                    buildConfiguration: String,
                    preActions: [ExecutionAction] = [],
                    postActions: [ExecutionAction] = [],
                    macroExpansion: BuildableReference? = nil,
                    selectedDebuggerIdentifier: String = XCScheme.defaultDebugger,
                    selectedLauncherIdentifier: String = XCScheme.defaultLauncher,
                    launchStyle: Style = .auto,
                    askForAppToLaunch: Bool? = nil,
                    customWorkingDirectory: String? = nil,
                    useCustomWorkingDirectory: Bool = false,
                    ignoresPersistentStateOnLaunch: Bool = false,
                    debugDocumentVersioning: Bool = true,
                    debugServiceExtension: String = LaunchAction.defaultDebugServiceExtension,
                    allowLocationSimulation: Bool = true,
                    locationScenarioReference: LocationScenarioReference? = nil,
                    enableGPUFrameCaptureMode: GPUFrameCaptureMode = LaunchAction.defaultGPUFrameCaptureMode,
                    disableGPUValidationMode: Bool = false,
                    enableGPUShaderValidationMode: Bool = false,
                    showGraphicsOverview: Bool = false,
                    logGraphicsOverview: Bool = false,
                    enableAddressSanitizer: Bool = false,
                    enableASanStackUseAfterReturn: Bool = false,
                    enableThreadSanitizer: Bool = false,
                    stopOnEveryThreadSanitizerIssue: Bool = false,
                    enableUBSanitizer: Bool = false,
                    stopOnEveryUBSanitizerIssue: Bool = false,
                    disableMainThreadChecker: Bool = false,
                    disablePerformanceAntipatternChecker: Bool = false,
                    stopOnEveryMainThreadCheckerIssue: Bool = false,
                    additionalOptions: [AdditionalOption] = [],
                    commandlineArguments: CommandLineArguments? = nil,
                    environmentVariables: [EnvironmentVariable]? = nil,
                    language: String? = nil,
                    region: String? = nil,
                    showNonLocalizedStrings: Bool = false,
                    launchAutomaticallySubstyle: String? = nil,
                    storeKitConfigurationFileReference: StoreKitConfigurationFileReference? = nil,
                    customLaunchCommand: String? = nil,
                    customLLDBInitFile: String? = nil,
                    appClipInvocationURLString: String? = nil) {
            self.runnable = runnable
            self.macroExpansion = macroExpansion
            self.buildConfiguration = buildConfiguration
            self.launchStyle = launchStyle
            self.selectedDebuggerIdentifier = selectedDebuggerIdentifier
            self.selectedLauncherIdentifier = selectedLauncherIdentifier
            self.askForAppToLaunch = askForAppToLaunch
            self.customWorkingDirectory = customWorkingDirectory
            self.useCustomWorkingDirectory = useCustomWorkingDirectory
            self.ignoresPersistentStateOnLaunch = ignoresPersistentStateOnLaunch
            self.debugDocumentVersioning = debugDocumentVersioning
            self.debugServiceExtension = debugServiceExtension
            self.allowLocationSimulation = allowLocationSimulation
            self.locationScenarioReference = locationScenarioReference
            self.enableGPUFrameCaptureMode = enableGPUFrameCaptureMode
            self.disableGPUValidationMode = disableGPUValidationMode
            self.enableGPUShaderValidationMode = enableGPUShaderValidationMode
            self.showGraphicsOverview = showGraphicsOverview
            self.logGraphicsOverview = logGraphicsOverview
            self.enableAddressSanitizer = enableAddressSanitizer
            self.enableASanStackUseAfterReturn = enableASanStackUseAfterReturn
            self.enableThreadSanitizer = enableThreadSanitizer
            self.stopOnEveryThreadSanitizerIssue = stopOnEveryThreadSanitizerIssue
            self.enableUBSanitizer = enableUBSanitizer
            self.stopOnEveryUBSanitizerIssue = stopOnEveryUBSanitizerIssue
            self.disableMainThreadChecker = disableMainThreadChecker
            self.disablePerformanceAntipatternChecker = disablePerformanceAntipatternChecker
            self.stopOnEveryMainThreadCheckerIssue = stopOnEveryMainThreadCheckerIssue
            self.additionalOptions = additionalOptions
            self.commandlineArguments = commandlineArguments
            self.environmentVariables = environmentVariables
            self.language = language
            self.region = region
            self.showNonLocalizedStrings = showNonLocalizedStrings
            self.launchAutomaticallySubstyle = launchAutomaticallySubstyle
            self.storeKitConfigurationFileReference = storeKitConfigurationFileReference
            self.customLaunchCommand = customLaunchCommand
            self.customLLDBInitFile = customLLDBInitFile
            self.appClipInvocationURLString = appClipInvocationURLString
            super.init(preActions, postActions)
        }

        @available(*, deprecated, message: "Use the init() that consolidates pathRunnable and runnable into a single parameter.")
        public convenience init(
            runnable: Runnable?,
            buildConfiguration: String,
            preActions: [ExecutionAction] = [],
            postActions: [ExecutionAction] = [],
            macroExpansion: BuildableReference? = nil,
            selectedDebuggerIdentifier: String = XCScheme.defaultDebugger,
            selectedLauncherIdentifier: String = XCScheme.defaultLauncher,
            launchStyle: Style = .auto,
            askForAppToLaunch: Bool? = nil,
            pathRunnable: PathRunnable?,
            customWorkingDirectory: String? = nil,
            useCustomWorkingDirectory: Bool = false,
            ignoresPersistentStateOnLaunch: Bool = false,
            debugDocumentVersioning: Bool = true,
            debugServiceExtension: String = LaunchAction.defaultDebugServiceExtension,
            allowLocationSimulation: Bool = true,
            locationScenarioReference: LocationScenarioReference? = nil,
            enableGPUFrameCaptureMode: GPUFrameCaptureMode = LaunchAction.defaultGPUFrameCaptureMode,
            disableGPUValidationMode: Bool = false,
            enableGPUShaderValidationMode: Bool = false,
            showGraphicsOverview: Bool = false,
            logGraphicsOverview: Bool = false,
            enableAddressSanitizer: Bool = false,
            enableASanStackUseAfterReturn: Bool = false,
            enableThreadSanitizer: Bool = false,
            stopOnEveryThreadSanitizerIssue: Bool = false,
            enableUBSanitizer: Bool = false,
            stopOnEveryUBSanitizerIssue: Bool = false,
            disableMainThreadChecker: Bool = false,
            disablePerformanceAntipatternChecker: Bool = false,
            stopOnEveryMainThreadCheckerIssue: Bool = false,
            additionalOptions: [AdditionalOption] = [],
            commandlineArguments: CommandLineArguments? = nil,
            environmentVariables: [EnvironmentVariable]? = nil,
            language: String? = nil,
            region: String? = nil,
            showNonLocalizedStrings: Bool = false,
            launchAutomaticallySubstyle: String? = nil,
            storeKitConfigurationFileReference: StoreKitConfigurationFileReference? = nil,
            customLaunchCommand: String? = nil,
            customLLDBInitFile: String? = nil,
            appClipInvocationURLString: String? = nil
        ) {
            self.init(
                runnable: pathRunnable,
                buildConfiguration: buildConfiguration,
                preActions: preActions,
                postActions: postActions,
                macroExpansion: macroExpansion,
                selectedDebuggerIdentifier: selectedDebuggerIdentifier,
                selectedLauncherIdentifier: selectedLauncherIdentifier,
                launchStyle: launchStyle,
                askForAppToLaunch: askForAppToLaunch,
                customWorkingDirectory: customWorkingDirectory,
                useCustomWorkingDirectory: useCustomWorkingDirectory,
                ignoresPersistentStateOnLaunch: ignoresPersistentStateOnLaunch,
                debugDocumentVersioning: debugDocumentVersioning,
                debugServiceExtension: debugServiceExtension,
                allowLocationSimulation: allowLocationSimulation,
                locationScenarioReference: locationScenarioReference,
                enableGPUFrameCaptureMode: enableGPUFrameCaptureMode,
                disableGPUValidationMode: disableGPUValidationMode,
                enableGPUShaderValidationMode: enableGPUShaderValidationMode,
                showGraphicsOverview: showGraphicsOverview,
                logGraphicsOverview: logGraphicsOverview,
                enableAddressSanitizer: enableAddressSanitizer,
                enableASanStackUseAfterReturn: enableASanStackUseAfterReturn,
                enableThreadSanitizer: enableThreadSanitizer,
                stopOnEveryThreadSanitizerIssue: stopOnEveryThreadSanitizerIssue,
                enableUBSanitizer: enableUBSanitizer,
                stopOnEveryUBSanitizerIssue: stopOnEveryUBSanitizerIssue,
                disableMainThreadChecker: disableMainThreadChecker,
                disablePerformanceAntipatternChecker: disablePerformanceAntipatternChecker,
                stopOnEveryMainThreadCheckerIssue: stopOnEveryMainThreadCheckerIssue,
                additionalOptions: additionalOptions,
                commandlineArguments: commandlineArguments,
                environmentVariables: environmentVariables,
                language: language,
                region: region,
                showNonLocalizedStrings: showNonLocalizedStrings,
                launchAutomaticallySubstyle: launchAutomaticallySubstyle,
                storeKitConfigurationFileReference: storeKitConfigurationFileReference,
                customLaunchCommand: customLaunchCommand,
                customLLDBInitFile: customLLDBInitFile,
                appClipInvocationURLString: appClipInvocationURLString
            )
        }

        // swiftlint:disable:next function_body_length
        override init(element: AEXMLElement) throws {
            buildConfiguration = element.attributes["buildConfiguration"] ?? LaunchAction.defaultBuildConfiguration
            selectedDebuggerIdentifier = element.attributes["selectedDebuggerIdentifier"] ?? XCScheme.defaultDebugger
            selectedLauncherIdentifier = element.attributes["selectedLauncherIdentifier"] ?? XCScheme.defaultLauncher
            launchStyle = element.attributes["launchStyle"].flatMap { Style(rawValue: $0) } ?? .auto
            askForAppToLaunch = element.attributes["askForAppToLaunch"].map { $0 == "YES" || $0 == "Yes" }
            useCustomWorkingDirectory = element.attributes["useCustomWorkingDirectory"] == "YES"
            ignoresPersistentStateOnLaunch = element.attributes["ignoresPersistentStateOnLaunch"] == "YES"
            debugDocumentVersioning = element.attributes["debugDocumentVersioning"].map { $0 == "YES" } ?? true
            debugServiceExtension = element.attributes["debugServiceExtension"] ?? LaunchAction.defaultDebugServiceExtension
            allowLocationSimulation = element.attributes["allowLocationSimulation"].map { $0 == "YES" } ?? true

            // Runnable
            let buildableProductRunnableElement = element["BuildableProductRunnable"]
            let remoteRunnableElement = element["RemoteRunnable"]
            let pathRunnable = element["PathRunnable"]
            if buildableProductRunnableElement.error == nil {
                runnable = try BuildableProductRunnable(element: buildableProductRunnableElement)
            } else if remoteRunnableElement.error == nil {
                runnable = try RemoteRunnable(element: remoteRunnableElement)
            } else if pathRunnable.error == nil {
                runnable = try PathRunnable(element: pathRunnable)
            }

            let buildableReferenceElement = element["MacroExpansion"]["BuildableReference"]
            if buildableReferenceElement.error == nil {
                macroExpansion = try BuildableReference(element: buildableReferenceElement)
            }

            if element["LocationScenarioReference"].all?.first != nil {
                locationScenarioReference = try LocationScenarioReference(element: element["LocationScenarioReference"])
            } else {
                locationScenarioReference = nil
            }

            enableGPUFrameCaptureMode = element.attributes["enableGPUFrameCaptureMode"]
                .flatMap { GPUFrameCaptureMode(rawValue: $0) } ?? LaunchAction.defaultGPUFrameCaptureMode
            disableGPUValidationMode = element.attributes["enableGPUValidationMode"] == gpuValidationModeDisableValue
            enableGPUShaderValidationMode = element.attributes["enableGPUShaderValidationMode"] == gpuShaderValidationModeEnableValue
            showGraphicsOverview = element.attributes["showGraphicsOverview"] == "Yes"
            logGraphicsOverview = element.attributes["logGraphicsOverview"] == "Yes"
            enableAddressSanitizer = element.attributes["enableAddressSanitizer"] == "YES"
            enableASanStackUseAfterReturn = element.attributes["enableASanStackUseAfterReturn"] == "YES"
            enableThreadSanitizer = element.attributes["enableThreadSanitizer"] == "YES"
            stopOnEveryThreadSanitizerIssue = element.attributes["stopOnEveryThreadSanitizerIssue"] == "YES"
            enableUBSanitizer = element.attributes["enableUBSanitizer"] == "YES"
            stopOnEveryUBSanitizerIssue = element.attributes["stopOnEveryUBSanitizerIssue"] == "YES"
            disableMainThreadChecker = element.attributes["disableMainThreadChecker"] == "YES"
            disablePerformanceAntipatternChecker = element.attributes["disablePerformanceAntipatternChecker"] == "YES"
            stopOnEveryMainThreadCheckerIssue = element.attributes["stopOnEveryMainThreadCheckerIssue"] == "YES"

            additionalOptions = try element["AdditionalOptions"]["AdditionalOption"]
                .all?
                .map(AdditionalOption.init) ?? []

            let commandlineOptions = element["CommandLineArguments"]
            if commandlineOptions.error == nil {
                commandlineArguments = try CommandLineArguments(element: commandlineOptions)
            }

            let environmentVariables = element["EnvironmentVariables"]
            if environmentVariables.error == nil {
                self.environmentVariables = try EnvironmentVariable.parseVariables(from: environmentVariables)
            }

            language = element.attributes["language"]
            region = element.attributes["region"]
            showNonLocalizedStrings = element.attributes["showNonLocalizedStrings"] == "YES"
            launchAutomaticallySubstyle = element.attributes["launchAutomaticallySubstyle"]

            if element["StoreKitConfigurationFileReference"].all?.first != nil {
                storeKitConfigurationFileReference = try StoreKitConfigurationFileReference(element: element["StoreKitConfigurationFileReference"])
            } else {
                storeKitConfigurationFileReference = nil
            }
            customLaunchCommand = element.attributes["customLaunchCommand"]
            customLLDBInitFile = element.attributes["customLLDBInitFile"]
            if let elementCustomWorkingDirectory: String = element.attributes["customWorkingDirectory"] {
                customWorkingDirectory = elementCustomWorkingDirectory
            }

            appClipInvocationURLString = element.attributes["appClipInvocationURLString"]

            try super.init(element: element)
        }

        // MARK: - XML

        private var xmlAttributes: [String: String] {
            var attributes = [
                "buildConfiguration": buildConfiguration,
                "selectedDebuggerIdentifier": selectedDebuggerIdentifier,
                "selectedLauncherIdentifier": selectedLauncherIdentifier,
                "launchStyle": launchStyle.rawValue,
                "useCustomWorkingDirectory": useCustomWorkingDirectory.xmlString,
                "ignoresPersistentStateOnLaunch": ignoresPersistentStateOnLaunch.xmlString,
                "debugDocumentVersioning": debugDocumentVersioning.xmlString,
                "debugServiceExtension": debugServiceExtension,
                "allowLocationSimulation": allowLocationSimulation.xmlString,
            ]

            if let askForAppToLaunch {
                attributes["askForAppToLaunch"] = askForAppToLaunch.xmlString
            }
            if enableGPUFrameCaptureMode != LaunchAction.defaultGPUFrameCaptureMode {
                attributes["enableGPUFrameCaptureMode"] = enableGPUFrameCaptureMode.rawValue
            }
            if disableGPUValidationMode {
                attributes["enableGPUValidationMode"] = gpuValidationModeDisableValue
            }
            if enableGPUShaderValidationMode {
                attributes["enableGPUShaderValidationMode"] = gpuShaderValidationModeEnableValue
            }
            if showGraphicsOverview {
                attributes["showGraphicsOverview"] = "Yes"
            }
            if logGraphicsOverview {
                attributes["logGraphicsOverview"] = "Yes"
            }
            if enableAddressSanitizer {
                attributes["enableAddressSanitizer"] = enableAddressSanitizer.xmlString
            }
            if enableASanStackUseAfterReturn {
                attributes["enableASanStackUseAfterReturn"] = enableASanStackUseAfterReturn.xmlString
            }
            if enableThreadSanitizer {
                attributes["enableThreadSanitizer"] = enableThreadSanitizer.xmlString
            }
            if stopOnEveryThreadSanitizerIssue {
                attributes["stopOnEveryThreadSanitizerIssue"] = stopOnEveryThreadSanitizerIssue.xmlString
            }
            if enableUBSanitizer {
                attributes["enableUBSanitizer"] = enableUBSanitizer.xmlString
            }
            if stopOnEveryUBSanitizerIssue {
                attributes["stopOnEveryUBSanitizerIssue"] = stopOnEveryUBSanitizerIssue.xmlString
            }
            if disableMainThreadChecker {
                attributes["disableMainThreadChecker"] = disableMainThreadChecker.xmlString
            }
            if disablePerformanceAntipatternChecker {
                attributes["disablePerformanceAntipatternChecker"] = disablePerformanceAntipatternChecker.xmlString
            }
            if stopOnEveryMainThreadCheckerIssue {
                attributes["stopOnEveryMainThreadCheckerIssue"] = stopOnEveryMainThreadCheckerIssue.xmlString
            }
            if let customWorkingDirectory {
                attributes["customWorkingDirectory"] = customWorkingDirectory
            }
            if let appClipInvocationURLString {
                attributes["appClipInvocationURLString"] = appClipInvocationURLString
            }

            return attributes
        }

        func xmlElement() -> AEXMLElement {
            let element = AEXMLElement(name: "LaunchAction",
                                       value: nil,
                                       attributes: xmlAttributes)
            super.writeXML(parent: element)
            if let runnable {
                element.addChild(runnable.xmlElement())
            }

            if let locationScenarioReference {
                element.addChild(locationScenarioReference.xmlElement())
            }

            if let macroExpansion {
                let macro = element.addChild(name: "MacroExpansion")
                macro.addChild(macroExpansion.xmlElement())
            }

            if let commandlineArguments {
                element.addChild(commandlineArguments.xmlElement())
            }

            if let environmentVariables {
                element.addChild(EnvironmentVariable.xmlElement(from: environmentVariables))
            }

            if let language {
                element.attributes["language"] = language
            }

            if let region {
                element.attributes["region"] = region
            }

            if showNonLocalizedStrings {
                element.attributes["showNonLocalizedStrings"] = showNonLocalizedStrings.xmlString
            }

            if let launchAutomaticallySubstyle {
                element.attributes["launchAutomaticallySubstyle"] = launchAutomaticallySubstyle
            }

            if let storeKitConfigurationFileReference {
                element.addChild(storeKitConfigurationFileReference.xmlElement())
            }

            if let customLaunchCommand {
                element.attributes["customLaunchCommand"] = customLaunchCommand
            }

            if let customLLDBInitFile {
                element.attributes["customLLDBInitFile"] = customLLDBInitFile
            }

            if !additionalOptions.isEmpty {
                let additionalOptionsElement = element.addChild(AEXMLElement(name: "AdditionalOptions"))
                for additionalOption in additionalOptions {
                    additionalOptionsElement.addChild(additionalOption.xmlElement())
                }
            }

            return element
        }

        // MARK: - Equatable

        override func isEqual(to: Any?) -> Bool {
            guard let rhs = to as? LaunchAction else { return false }
            return super.isEqual(to: to) &&
                runnable == rhs.runnable &&
                macroExpansion == rhs.macroExpansion &&
                selectedDebuggerIdentifier == rhs.selectedDebuggerIdentifier &&
                selectedLauncherIdentifier == rhs.selectedLauncherIdentifier &&
                buildConfiguration == rhs.buildConfiguration &&
                launchStyle == rhs.launchStyle &&
                askForAppToLaunch == rhs.askForAppToLaunch &&
                customWorkingDirectory == rhs.customWorkingDirectory &&
                useCustomWorkingDirectory == rhs.useCustomWorkingDirectory &&
                ignoresPersistentStateOnLaunch == rhs.ignoresPersistentStateOnLaunch &&
                debugDocumentVersioning == rhs.debugDocumentVersioning &&
                debugServiceExtension == rhs.debugServiceExtension &&
                allowLocationSimulation == rhs.allowLocationSimulation &&
                locationScenarioReference == rhs.locationScenarioReference &&
                enableGPUFrameCaptureMode == rhs.enableGPUFrameCaptureMode &&
                disableGPUValidationMode == rhs.disableGPUValidationMode &&
                enableGPUShaderValidationMode == rhs.enableGPUShaderValidationMode &&
                showGraphicsOverview == rhs.showGraphicsOverview &&
                logGraphicsOverview == rhs.logGraphicsOverview &&
                enableAddressSanitizer == rhs.enableAddressSanitizer &&
                enableASanStackUseAfterReturn == rhs.enableASanStackUseAfterReturn &&
                enableThreadSanitizer == rhs.enableThreadSanitizer &&
                stopOnEveryThreadSanitizerIssue == rhs.stopOnEveryThreadSanitizerIssue &&
                enableUBSanitizer == rhs.enableUBSanitizer &&
                stopOnEveryUBSanitizerIssue == rhs.stopOnEveryUBSanitizerIssue &&
                disableMainThreadChecker == rhs.disableMainThreadChecker &&
                disablePerformanceAntipatternChecker == rhs.disablePerformanceAntipatternChecker &&
                stopOnEveryMainThreadCheckerIssue == rhs.stopOnEveryMainThreadCheckerIssue &&
                additionalOptions == rhs.additionalOptions &&
                commandlineArguments == rhs.commandlineArguments &&
                environmentVariables == rhs.environmentVariables &&
                language == rhs.language &&
                region == rhs.region &&
                launchAutomaticallySubstyle == rhs.launchAutomaticallySubstyle &&
                storeKitConfigurationFileReference == rhs.storeKitConfigurationFileReference &&
                customLaunchCommand == rhs.customLaunchCommand &&
                customLLDBInitFile == rhs.customLLDBInitFile &&
                appClipInvocationURLString == rhs.appClipInvocationURLString
        }
    }
}
