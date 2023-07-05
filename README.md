# SearchField

![69916b4c-ca3e-40c4-bea7-6e5261dac53c](https://github.com/lbrndnr/SearchField/assets/762049/c8907bce-d74e-4f72-8c6c-beda7588b9d4)
SearchField is a GitHub-like search field for SwiftUI. You can define qualifiers/keywords which are then annotated while searching.

## Usage
```swift
SearchField("􀊫 Search", text: $query)
    .textFieldStyle(RoundedBorderTextFieldStyle())
    .frame(width: 250)
    .qualifier("lang")
    .qualifier("author")
```

## Author
I'm Laurin Brandner, I'm on [Twitter](https://twitter.com/lbrndnr).

## License
`SearchField` is licensed under the [MIT License](http://opensource.org/licenses/mit-license.php).
