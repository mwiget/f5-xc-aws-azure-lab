terraform {
    extra_arguments "volterra" {
        commands = ["apply","plan","destroy"]
        arguments = []
        env_vars = {
            VES_P12_PASSWORD  = "hb9rwm"
            VOLT_API_URL      = "https://playground.staging.volterra.us/api"
            VOLT_API_CA_CERT  = "/home/mwiget/.ves-internal/staging/cacerts/public_server_ca.crt"
            VOLT_API_TIMEOUT  = "60s"
            VOLT_API_P12_FILE = "/home/mwiget/playground.staging.api-creds.p12"
        }
    }

    # after_hook "experiment" {
    #     commands = ["apply","plan","destroy"]
    #     execute  = ["echo","-----------------!!!!!!!!!!!!!!!!! SUPER DONE !!!!!!!!!!!!!!!!!-----------------"]
    # }

}

inputs = {
    projectPrefix          = "marcel"
    namespace              = "marcel"
    trusted_ip             = "23.88.44.163/32"
    volterraTenant         = "playground"
    volterraCloudCredAWS   = "mw-aws-f5"
    volterraCloudCredAzure = "pre-existing-azure-credential"
    awsRegion              = "us-west-2"
    azureRegion            = "westus2"
    ssh_key                = "marcel-ed25519"
}
