{ modulesPath, pkgs, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.extraModprobeConfig = ''
    options iwlwifi bt_coex_active=0
  '';
  boot.extraModulePackages = [ ];
  boot.initrd.availableKernelModules = [
    "ahci"
    "nvme"
    "sd_mod"
    "usbhid"
    "usb_storage"
    "xhci_pci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelPackages = pkgs.linuxPackages_6_8;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 8;

  fileSystems."/".device = "/dev/disk/by-label/able";
  fileSystems."/".fsType = "ext4";
  fileSystems."/boot".device = "/dev/disk/by-label/BOOT";
  fileSystems."/boot".fsType = "vfat";
  fileSystems."/mnt/baker".device = "/dev/disk/by-label/baker";
  fileSystems."/mnt/baker".fsType = "ext4";
  fileSystems."/mnt/easy".device = "/dev/disk/by-label/easy";
  fileSystems."/mnt/easy".fsType = "ext4";

  hardware.bluetooth.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.enable = false;

  presets.desktop.enable = true;
  presets.development.enable = true;
  presets.gaming.enable = true;
  presets.hyprland.enable = true;
  presets.kde.enable = true;
  presets.nvidia.enable = true;
  presets.wayland.enable = true;

  swapDevices = [ ];
  system.stateVersion = "23.11";

  users.justin.enable = true;
  users.uniform.enable = true;

  # systemd.services.bluetoothfix = {
  #   enable = true;
  #   description = "Update supervision timeout";
  #   requires = [ "bluetooth.service" ];
  #   after = [ "bluetooth.service" "sys-kernel-debug.mount" ];
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     RemainAfterExit = "yes";
  #   };
  #   script = "sleep 5; echo 420 > /sys/kernel/debug/bluetooth/hci0/supervision_timeout";
  # };
}
