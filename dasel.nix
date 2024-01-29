
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
      name = "dasel-2.5.0";
      pname = "dasel";
      system = "x86_64-linux";
    } {
      out = "/nix/store/sx6gdsksy7sqfww8iikav9g69fl2xqfc-dasel-2.5.0";
    }).out;


    "aarch64-linux" = (mkFakeDerivation {
      name = "dasel-2.5.0";
      pname = "dasel";
      system = "aarch64-linux";
    } {
      out = "/nix/store/5ghf8sria8jfs7d5wg1f55v201abclzz-dasel-2.5.0";
    }).out;


    "x86_64-darwin" = (mkFakeDerivation {
      name = "dasel-2.5.0";
      pname = "dasel";
      system = "x86_64-darwin";
    } {
      out = "/nix/store/pdabm774dcrcc08bfbcjkc5a0v2z7apf-dasel-2.5.0";
    }).out;


    "aarch64-darwin" = (mkFakeDerivation {
      name = "dasel-2.5.0";
      pname = "dasel";
      system = "aarch64-darwin";
    } {
      out = "/nix/store/pfxx8mpw6bbk2nqwl9xwyn4nakqags3b-dasel-2.5.0";
    }).out;
}.${system}