{
  environment.persistence."/host".directories = [
    {
      directory = "/var/lib/bluetooth";
      mode = "0700";
    }
  ];
}
