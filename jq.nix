
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
      name = "jq-1.6";
      pname = "jq";
      system = "x86_64-linux";
    } {
      out = "/nix/store/k8s3m6fag35x793cwri4wwjbdriqhgvm-jq-1.6";
    }).out;


    "aarch64-linux" = (mkFakeDerivation {
      name = "jq-1.6";
      pname = "jq";
      system = "aarch64-linux";
    } {
      out = "/nix/store/27511lr65wlpdxxpi12gvj95ybz30m07-jq-1.6";
    }).out;


    "x86_64-darwin" = (mkFakeDerivation {
      name = "jq-1.6";
      pname = "jq";
      system = "x86_64-darwin";
    } {
      out = "/nix/store/1akg90zkr48wfr1db72rigzz5mzr91jh-jq-1.6";
    }).out;


    "aarch64-darwin" = (mkFakeDerivation {
      name = "jq-1.6";
      pname = "jq";
      system = "aarch64-darwin";
    } {
      out = "/nix/store/xhb06d310lbvzs5wrh95s7vkdbwy5fbn-jq-1.6";
    }).out;
}.${system}