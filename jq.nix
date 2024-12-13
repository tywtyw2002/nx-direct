
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
      name = "jq-1.7.1";
      pname = "jq";
      system = "x86_64-linux";
    } {
      out = "/nix/store/6mi0s34rv17dxd8bpv3vis709n230mfi-jq-1.7.1";
    }).out;


    "aarch64-linux" = (mkFakeDerivation {
      name = "jq-1.7.1";
      pname = "jq";
      system = "aarch64-linux";
    } {
      out = "/nix/store/x5p64yy46c4g5a6788av88fr8nxpfmvl-jq-1.7.1";
    }).out;


    "x86_64-darwin" = (mkFakeDerivation {
      name = "jq-1.7.1";
      pname = "jq";
      system = "x86_64-darwin";
    } {
      out = "/nix/store/5v08b5wxh9i1aqxr4j4v731phms6q4hj-jq-1.7.1";
    }).out;


    "aarch64-darwin" = (mkFakeDerivation {
      name = "jq-1.7.1";
      pname = "jq";
      system = "aarch64-darwin";
    } {
      out = "/nix/store/20x8m876m0a3nas08c4gg7n1gcvw2nd1-jq-1.7.1";
    }).out;
}.${system}