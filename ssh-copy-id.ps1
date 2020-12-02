# parameters
param (
  [switch]$h = $false,
  [switch]$f = $false,
  [switch]$n = $false,
  [string]$i = $null,
  [int]$p = 22,
  [string]$o = $null,
  [Parameter(Mandatory=$true)][string]$remotehost
)

# functions
function Usage {
  Write-Host "Usage: .\ssh-copy-id.ps1 [-h|-?|-f|-n] [-i [identity_file]] [-p port] [[-o <ssh -o options>] ...] [user@]hostname"
  Write-Host "-f: force mode -- copy keys without trying to check if they are already installed"
  Write-Host "-n: dry run    -- no keys are actually copied"
  Write-Host "-h: print this help"
  Exit 
}

# check peramaters
if ($h) {
  Usage
}

if ($null -ne $i) {
  $i = "$home\.ssh\id_rsa.pub"
}

if (22 -ne $p) {
  $remotehost = "-p $p $remotehost"
}

# create .ssh dir
ssh $remotehost mkdir -p .ssh

# copy public key
Get-Content $i | ssh $remotehost 'cat >> .ssh/authorized_keys'