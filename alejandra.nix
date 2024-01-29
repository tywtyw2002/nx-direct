
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
      out = "/nix/store/2mc1jhxaa0z2l016x9l44n8d3chk2bcq-alejandra-3.0.0";
    }).out;


    "aarch64-linux" = (mkFakeDerivation {
      name = "alejandra-3.0.0";
      pname = "alejandra";
      system = "aarch64-linux";
    } {
      out = "/nix/store/qlmb5m3s2l43yn05qjhzkhi7sqlx45w0-alejandra-3.0.0";
    }).out;


    "x86_64-darwin" = (mkFakeDerivation {
      name = "alejandra-3.0.0";
      pname = "alejandra";
      system = "x86_64-darwin";
    } {
      out = "/nix/store/gcqhwfqp44zs495yar2h2sn0qrcyshfh-alejandra-3.0.0";
    }).out;


    "aarch64-darwin" = (mkFakeDerivation {
      name = "alejandra-3.0.0";
      pname = "alejandra";
      system = "aarch64-darwin";
    } {
      out = "/nix/store/cf2mkckaxdjnr1m8fhnxgbbla4q4abwq-alejandra-3.0.0";
    }).out;
}.${system}