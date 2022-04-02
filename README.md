# WeatherApp

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/kamyarst/weatherapp/CI-iOS)
![GitHub](https://img.shields.io/github/license/kamyarst/weatherapp)

### Contents
- [Features](README.md#features)
- [App Requirements](README.md#app-requirements)
- [Third-Parties](README.md#third-parties)
- [API](README.md#api)
- [License](README.md#license)

## Features

- UI Architecture: **MVVM-C**
- Dependency Manager: **SPM**
- CI: **GitHub Actions** -> [Actions](.github/workflows)
- UI components are built 100% Programmatically
- **TDD**

## App Requirements

- [BDD Specs](./docs/BDD_specs.md)
- [Model Specs](./docs/model_specs.md)
- [Weather Use Cases](./docs/use_cases.md)

## Third-Parties

#### Libraries:
- SnapKit: [GitHub](https://github.com/SnapKit/SnapKit)

#### Tools
- SwiftGen: [Rules](swiftgen.yml) | [GitHub](https://github.com/SwiftGen/SwiftGen/)
- SwiftLint: [Rules](.swiftformat) | [GitHub](https://github.com/realm/SwiftLint)
- SwiftFormat: [Rules](.swiftlint.yml) | [GitHub](https://github.com/nicklockwood/SwiftFormat)

## API
The API is provided by [WeatherAPI](https://www.weatherapi.com/)

<a href="https://www.weatherapi.com/" title="Free Weather API"><img src='https://cdn.weatherapi.com/v4/images/weatherapi_logo.png' alt="Weather data by WeatherAPI.com" border="0"></a>

## License

WeatherApp is released under the MIT license. See [LICENSE](LICENSE) for details.
