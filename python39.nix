
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
      name = "python3-3.9.18";
      pname = "python3";
      system = "x86_64-linux";
    } {
      out = "/nix/store/yqf6sa1xiqrjsyqpqg089i6yljv58rb7-python3-3.9.18";
    }).out;


    "aarch64-linux" = (mkFakeDerivation {
      name = "python3-3.9.18";
      pname = "python3";
      system = "aarch64-linux";
    } {
      out = "/nix/store/5a3lg5xhcjwycmp864yawr24cqwyydpl-python3-3.9.18";
    }).out;


    "x86_64-darwin" = (mkFakeDerivation {
      name = "python3-3.9.18";
      pname = "python3";
      system = "x86_64-darwin";
    } {
      out = "/nix/store/400qr3zs6cfxhha6zdhlgski4hrrsxjm-python3-3.9.18";
    }).out;


    "aarch64-darwin" = (mkFakeDerivation {
      name = "python3-3.9.18";
      pname = "python3";
      system = "aarch64-darwin";
    } {
      out = "/nix/store/k3f7xv49f0vks2j3zjqhd478z6xx1ccs-python3-3.9.18";
    }).out;
}.${system}