{ config, pkgs, ... }:
{
  environment.systemPackages =
    let
      libcam_recent = with pkgs; stdenv.mkDerivation rec {
        name = "libcamera-0.2.0";
        version = "0.2.0";
        src = fetchgit {
          url = "https://git.libcamera.org/libcamera/libcamera.git";
          rev = "v${version}";
          hash = "sha256-x0Im9m9MoACJhQKorMI34YQ+/bd62NdAPc2nWwaJAvM=";
        };

        postPatch = ''
          patchShebangs utils/
        '';

        strictDeps = true;

        buildInputs = [
      # IPA and signing
      openssl

      # gstreamer integration
      gst_all_1.gstreamer
      gst_all_1.gst-plugins-base

      # cam integration
      libevent
      libdrm

      # hotplugging
      systemd

      # lttng tracing
      lttng-ust

      # yamlparser
      libyaml

      gtest
    ];

    nativeBuildInputs = [
      meson
      ninja
      pkg-config
      python3
      python3Packages.jinja2
      python3Packages.pyyaml
      python3Packages.ply
      python3Packages.sphinx
      graphviz
      doxygen
      openssl
    ];

    mesonFlags = [
      "-Dpipelines=uvcvideo,vimc,ipu3"
      "-Dipas=vimc,ipu3"
      "-Dgstreamer=enabled"
      "-Dv4l2=true"
      "-Dqcam=disabled"
      "-Dlc-compliance=disabled" # tries unconditionally to download gtest when enabled
      # Avoid blanket -Werror to evade build failures on less
      # tested compilers.
      "-Dwerror=false"
    ];

  # Fixes error on a deprecated declaration
  NIX_CFLAGS_COMPILE = "-Wno-error=deprecated-declarations";

  # Silence fontconfig warnings about missing config
  #FONTCONFIG_FILE = makeFontsConf { fontDirectories = []; };

  # libcamera signs the IPA module libraries at install time, but they are then
  # modified by stripping and RPATH fixup. Therefore, we need to generate the
  # signatures again ourselves.
  #
  # If this is not done, libcamera will still try to load them, but it will
  # isolate them in separate processes, which can cause crashes for IPA modules
  # that are not designed for this (notably ipa_rpi.so).
  postFixup = ''
    ../src/ipa/ipa-sign-install.sh src/ipa-priv-key.pem $out/lib/libcamera/ipa_*.so
  '';

};
  in
  [ libcam_recent ];
}
