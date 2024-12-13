
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
      name = "dasel-2.8.1";
      pname = "dasel";
      system = "x86_64-linux";
    } {
      out = "/nix/store/6nsrafm91sbh904la8ncmsxkzdbrirh3-dasel-2.8.1";
    }).out;


    "aarch64-linux" = (mkFakeDerivation {
      name = "dasel-2.8.1";
      pname = "dasel";
      system = "aarch64-linux";
    } {
      out = "/nix/store/pg60lm193cjrbvpchlj8bbh6gbdc2h5d-dasel-2.8.1";
    }).out;


    "x86_64-darwin" = (mkFakeDerivation {
      name = "dasel-2.8.1";
      pname = "dasel";
      system = "x86_64-darwin";
    } {
      out = "/nix/store/aa7dffbaplmdci8fp3k8ad90nq21lpb2-dasel-2.8.1";
    }).out;


    "aarch64-darwin" = (mkFakeDerivation {
      name = "dasel-2.8.1";
      pname = "dasel";
      system = "aarch64-darwin";
    } {
      out = "/nix/store/sb1gnn70sgy4iq014yx25mnc1y1alkyh-dasel-2.8.1";
    }).out;
}.${system}