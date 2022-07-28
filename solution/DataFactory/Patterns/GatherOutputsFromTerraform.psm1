function GatherOutputsFromTerraform()
{
    $environmentName = $env:TFenvironmentName    
    $myIp = (Invoke-WebRequest ifconfig.me/ip).Content

    $CurrentFolderPath = $PWD
    Set-Location "../../DeploymentV2/terraform_layer2"
    $env:TF_VAR_ip_address = $myIp

    #------------------------------------------------------------------------------------------------------------
    # Get all the outputs from terraform so we can use them in subsequent steps
    #------------------------------------------------------------------------------------------------------------
    Write-Verbose "-------------------------------------------------------------------------------------------------"
    Write-Verbose "Reading Terraform Outputs - Started"

    $tout = New-Object PSObject

    $tout0 = (terraform output -json | ConvertFrom-Json -Depth 10).PSObject.Properties 
    $tout0 | Foreach-Object {                    
        $tout | Add-Member  -MemberType NoteProperty -Name $_.Name -Value $_.Value.value
    }

    $rgid = (az group show -n $tout.resource_group_name | ConvertFrom-Json -Depth 10).id
    $tout | Add-Member  -MemberType NoteProperty -Name "resource_group_id" -Value $rgid

    Set-Location $CurrentFolderPath
    Write-Verbose "Reading Terraform Outputs - Finished"
    Write-Verbose "-------------------------------------------------------------------------------------------------"
    return $tout
}