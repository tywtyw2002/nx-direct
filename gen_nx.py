import json
from pathlib import Path

FIXED_OUT_PATH = Path("./out")
PKG_HEADER_CONTENT = """
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
"""

DEFAULT_NIX = """
let
    pkgs_name = [{pkg_name}];
    pkgs = builtins.listToAttrs (builtins.map (k: {{name = k; value = import ./${{k}}.nix; }}) pkgs_name);
in
pkgs
"""

FAKE_DERIVATION_TEMPLATES = """
    "{system}" = (mkFakeDerivation {{
      name = "{name}";
      pname = "{pname}";
      system = "{system}";
    }} {{
      out = "{out}";
    }}).out;
"""

def gen_fake_derivation(pkg_conf, systems):
    results = []

    for sys in systems:
        conf = pkg_conf[sys]
        results.append(FAKE_DERIVATION_TEMPLATES.format(system=sys, **conf))

    return "\n".join(results)


def main():
    with open('result', 'r') as fp:
        data = json.load(fp)

    systems = data['systems']
    nix_pkgs = data['packages']

    FIXED_OUT_PATH.mkdir(exist_ok=True)

    for pkg_name, pkg_conf in nix_pkgs.items():
        file_path = FIXED_OUT_PATH.joinpath(f"{pkg_name}.nix")
        with file_path.open("w") as fp:
            fp.write(PKG_HEADER_CONTENT)
            fp.write(gen_fake_derivation(pkg_conf, systems))
            fp.write("}.${system}")

    # default.nix
    default = FIXED_OUT_PATH.joinpath("default.nix")
    keys = [f'"{x}"' for x in nix_pkgs.keys()]
    with default.open("w") as fp:
        fp.write(DEFAULT_NIX.format(pkg_name=" ".join(keys)))


if __name__ == '__main__':
    main()