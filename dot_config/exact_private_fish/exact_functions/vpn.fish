   function vpn -d 'Launch eddie-cli VPN, optionally restricted to an area'
       if set -q argv[1]
           command eddie-cli connect --areas.allowlist="$argv[1]"
       else
           command eddie-cli connect --areas.allowlist=""
       end
   end
