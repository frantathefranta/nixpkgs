{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  sqlite,
  nix-update-script,
  python3Minimal,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "essh";
  version = "0.2.7";

  src = fetchFromGitHub {
    owner = "matthart1983";
    repo = "essh";
    tag = "v${finalAttrs.version}";
    hash = "sha256-2VdDDSYr6vG6ExW26HTMkYMvwEHPwa7EAjG7BZyfsdY=";
  };

  cargoHash = "sha256-AtlvLmBTNx7JqC21+ooFD578eIe8B4IPuvrvkUbmnRs=";

  nativeBuildInputs = [
    pkg-config
    python3Minimal
  ];

  buildInputs = [
    sqlite
  ];

  env = {
    LIBSQLITE3_SYS_USE_PKG_CONFIG = true;
  };

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Enhanced SSH client with TUI — manage connections, keys, and sessions";
    homepage = "https://github.com/matthart1983/essh";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "essh";
  };
})
