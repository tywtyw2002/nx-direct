
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
      name = "alejandra-3.0.0";
      pname = "alejandra";
      system = "x86_64-linux";
    } {
      out = "/nix/store/rza6bl7haqdinsfgkh6cki7ncjm6p6cz-alejandra-3.0.0";
    }).out;


    "aarch64-linux" = (mkFakeDerivation {
      name = "alejandra-3.0.0";
      pname = "alejandra";
      system = "aarch64-linux";
    } {
      out = "/nix/store/ghnpp5yyka0274ci0pk7lklj4z3ayg4z-alejandra-3.0.0";
    }).out;


    "x86_64-darwin" = (mkFakeDerivation {
      name = "alejandra-3.0.0";
      pname = "alejandra";
      system = "x86_64-darwin";
    } {
      out = "/nix/store/q7vws7rcv22iq3cl0vc4zk52x7fyznrs-alejandra-3.0.0";
    }).out;


    "aarch64-darwin" = (mkFakeDerivation {
      name = "alejandra-3.0.0";
      pname = "alejandra";
      system = "aarch64-darwin";
    } {
      out = "/nix/store/ag35blp95lawbd38cla4jj6qzly8hhc0-alejandra-3.0.0";
    }).out;
}.${system}