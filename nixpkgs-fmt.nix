
{ system ? builtins.currentSystem
}:

let
  mkFakeDerivation = attrs: outputs:
    let
        outputNames = builtins.attrNames outputs;
        common = attrs // outputsSet //
            { type = "derivation";
            outputs = outputNames;
            # TODO: this has name/value pairs
            all = outputsList;
            };
        outputToAttrListElement = outputName:
            { name = outputName;
              value = common // {
                inherit outputName;
                outPath = builtins.storePath (builtins.getAttr outputName outputs);
                # TODO: we lie here so that Nix won't build it
                drvPath = builtins.storePath (builtins.getAttr outputName outputs);
              };
            };
        outputsList = map outputToAttrListElement outputNames;
        outputsSet = builtins.listToAttrs outputsList;
    in outputsSet;
in
{

    "x86_64-linux" = (mkFakeDerivation {
      name = "nixpkgs-fmt-1.3.0";
      pname = "nixpkgs-fmt";
      system = "x86_64-linux";
    } {
      out = "/nix/store/afr7kb3az68b0ny5s8kmh7lzp59cwm4l-nixpkgs-fmt-1.3.0";
    }).out;


    "aarch64-linux" = (mkFakeDerivation {
      name = "nixpkgs-fmt-1.3.0";
      pname = "nixpkgs-fmt";
      system = "aarch64-linux";
    } {
      out = "/nix/store/0qp1pysj7fb5mz8bq80i6vlravdq8ckf-nixpkgs-fmt-1.3.0";
    }).out;


    "x86_64-darwin" = (mkFakeDerivation {
      name = "nixpkgs-fmt-1.3.0";
      pname = "nixpkgs-fmt";
      system = "x86_64-darwin";
    } {
      out = "/nix/store/j5gixwia046fd667am6kmx9z49qdwwki-nixpkgs-fmt-1.3.0";
    }).out;


    "aarch64-darwin" = (mkFakeDerivation {
      name = "nixpkgs-fmt-1.3.0";
      pname = "nixpkgs-fmt";
      system = "aarch64-darwin";
    } {
      out = "/nix/store/6vn5a4m8mz3cj4h1m486zlkdjzaz38kp-nixpkgs-fmt-1.3.0";
    }).out;
}.${system}