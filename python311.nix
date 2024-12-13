
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
      name = "python3-3.11.9";
      pname = "python3";
      system = "x86_64-linux";
    } {
      out = "/nix/store/30dxq7znh2rgb9n0nvdjhqw0qrfv99fq-python3-3.11.9";
    }).out;


    "aarch64-linux" = (mkFakeDerivation {
      name = "python3-3.11.9";
      pname = "python3";
      system = "aarch64-linux";
    } {
      out = "/nix/store/g0znk9nffxlmsph74zjzjhd0lwaf2ahg-python3-3.11.9";
    }).out;


    "x86_64-darwin" = (mkFakeDerivation {
      name = "python3-3.11.9";
      pname = "python3";
      system = "x86_64-darwin";
    } {
      out = "/nix/store/n3khprx082vnnic30dd7xybfgp06s1y4-python3-3.11.9";
    }).out;


    "aarch64-darwin" = (mkFakeDerivation {
      name = "python3-3.11.9";
      pname = "python3";
      system = "aarch64-darwin";
    } {
      out = "/nix/store/lcbm4vlxhq54jvviiq1mjhhqfivk0pwx-python3-3.11.9";
    }).out;
}.${system}