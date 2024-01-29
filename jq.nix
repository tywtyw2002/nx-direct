
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
      out = "/nix/store/2zj0shdd3m7sb6kd0lr6rakjqnqrxyjd-jq-1.7.1";
    }).out;


    "aarch64-linux" = (mkFakeDerivation {
      name = "jq-1.7.1";
      pname = "jq";
      system = "aarch64-linux";
    } {
      out = "/nix/store/kbcl2h4zpq91q8323ai0db995bpny9nc-jq-1.7.1";
    }).out;


    "x86_64-darwin" = (mkFakeDerivation {
      name = "jq-1.7.1";
      pname = "jq";
      system = "x86_64-darwin";
    } {
      out = "/nix/store/dqkxrhi8gpm8yparp5m1wfp7700b871x-jq-1.7.1";
    }).out;


    "aarch64-darwin" = (mkFakeDerivation {
      name = "jq-1.7.1";
      pname = "jq";
      system = "aarch64-darwin";
    } {
      out = "/nix/store/afndbrgpc6in2ywm24fl0qszblw7ypz5-jq-1.7.1";
    }).out;
}.${system}