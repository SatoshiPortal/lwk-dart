# Structure

The goal of lwk-dart is to extend functionality from lwk and related rust crates, into dart to be used in flutter projects.

There are 4 main components that summarize the structure:

- rust types

The `types.rs` files contains all the types that we would like to use in dart. frb supports most generic types: String, u64, i64, bool, f64 etc.

- rust functions

The `api.rs` file contains all the methods that will be available in dart. They internally call sub modules that can be separated into their own dedicated files, such as wallet.rs or electrum.rs

- codegen + binary 

After writing the interface in rust, we run codegen, which will produce generated code in both rust and dart (which should not be manually edited). We also run `make` (with flags for specific architectures) to compile the libraryto a c binary, which will be called from dart. As a contributer, only run `make test`. The maintainer of the repository must build the main binaries and upload them to github releases.

- dart class

The `root.dart` file is where we bring together the types and functions exposed from the rust side and combine them into a single dart class for easier usage in dart. 
This has to be manually written because we cannot directly translate a rust struct with its method into dart.


# Adding new functionality

When adding new functionality, first write a static method in api.rs that uses lwk to achieve the result required.

If this method uses a custom struct as input or output, it should be added to types.rs

The entire logic of the method can first be written directly in api.rs, but should eventually be moved to a dedicated module. 

Use the test module at the bottom of the file to experiment with lwk before adding your method to the `Api` struct.

Once you have written the method and its required types, run `codegen.sh` & `make test`

This will generate dart code for the static methods and types in a file under `dart/lib/generated/bridge_definitions.dart` and also create test binaries in the `test` folder.

We import `bridge_definitions.dart` into `root.dart` and create a custom class that cbombines the bridged types and methods.

Now you can test this function by adding a new test case in `test/lwk_root_test.dart`


# Rust Patterns

- `From` / `Into` 
A common pattern is the use of the traits `From` and `Into` which are functionally similar. This allows us to convert one type into another. 

This pattern can be found in most of the types.rs structures where we want to convert an lwk type into a type that is compatible with frb to convert into a dart type.
