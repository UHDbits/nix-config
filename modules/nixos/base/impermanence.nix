{ lib, ... }: {
  environment.persistence."/persist".directories = [
    "/var/lib/bluetooth"
    "/var/lib/cups"
    ];
}