# WeatherApp

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/kamyarst/weatherapp/CI-iOS)
![GitHub](https://img.shields.io/github/license/kamyarst/weatherapp)

<table border="0"><tr>
  <td>
    <img alt="WeatherApp Image" src="https://github.com/kamyarst/WeatherApp/tree/develop/images/mock.png" />
  </td><td>
    <ul>
        <li><a href="#features">Features</a>
        <li><a href="#app-requirements">App Requirements</a>
        <li><a href="#third-parties">Third-Parties</a>
        <li><a href="#api">API</a>
		<li><a href="#license">License</a>
		<li><a href="#TODO">TODO</a>
    </ul>
  </td>
</tr></table>

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

## TODO

- [ ] Implement Search use case
- [ ] Implement Caching data
- [ ] Improve UI
- [ ] Add app icon
