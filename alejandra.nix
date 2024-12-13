
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
      out = "/nix/store/wyrbhczfzi7lhdy5z8q29qqr3cz89qfj-alejandra-3.0.0";
    }).out;


    "aarch64-linux" = (mkFakeDerivation {
      name = "alejandra-3.0.0";
      pname = "alejandra";
      system = "aarch64-linux";
    } {
      out = "/nix/store/m7nj1iikvxjdlx8xmnf4nfphsxrid7jm-alejandra-3.0.0";
    }).out;


    "x86_64-darwin" = (mkFakeDerivation {
      name = "alejandra-3.0.0";
      pname = "alejandra";
      system = "x86_64-darwin";
    } {
      out = "/nix/store/axfxp78wvvzqw7yx1811bhbmhr5xsikb-alejandra-3.0.0";
    }).out;


    "aarch64-darwin" = (mkFakeDerivation {
      name = "alejandra-3.0.0";
      pname = "alejandra";
      system = "aarch64-darwin";
    } {
      out = "/nix/store/83wpm3z6b12jl909xqv2bnc46sv4kgs8-alejandra-3.0.0";
    }).out;
}.${system}