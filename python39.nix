
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
      name = "python3-3.9.19";
      pname = "python3";
      system = "x86_64-linux";
    } {
      out = "/nix/store/isd0gr7kdg9y0qn1hiywh3v61v3r65w8-python3-3.9.19";
    }).out;


    "aarch64-linux" = (mkFakeDerivation {
      name = "python3-3.9.19";
      pname = "python3";
      system = "aarch64-linux";
    } {
      out = "/nix/store/cy850r0v26vh0svc1an0931h7vpcx04r-python3-3.9.19";
    }).out;


    "x86_64-darwin" = (mkFakeDerivation {
      name = "python3-3.9.19";
      pname = "python3";
      system = "x86_64-darwin";
    } {
      out = "/nix/store/f21jiqy1lzby8213vk3gbxsafxqb1pac-python3-3.9.19";
    }).out;


    "aarch64-darwin" = (mkFakeDerivation {
      name = "python3-3.9.19";
      pname = "python3";
      system = "aarch64-darwin";
    } {
      out = "/nix/store/1p5bgc4wkdv5l8gqj387n71d58b4wbaf-python3-3.9.19";
    }).out;
}.${system}