# Theorie

- so = security onion
- helaas wat teveel resources om op te zetten

## IDS/IPS

- needs a lot of memory (to log the network)
- disable surrigata (in systemd) if you don't need it. Play with the environment

## misc

- create your own rules
- show on exam : create a rule that detects a ping / attack to DC / database / ...

## SSH Port forwarding

- continuation of previous lab => ssh -J
- -L -R opties die handig zijn: ssh kan port forward createn
- stel op je vm op port 8000 heb je iets running, je kan niet worden bereikt
- stel nu vm running in the cloud iaas +> copy your vm daarheen wel bereikbaar
- je kan een sshtunnel gebruiken om nat/firewall bypassen
- je hebt namelijk een port op de cloud vm open gezet en je komt op de virtualbox terecht
- zeer interessant => reverse forwarding: ssh -R 80:localhost:8000 user/ip
- (er moet wel iets veranderd worden in de ssh van de remote: gateway force)

- local port forwarding : open a port locally
- bypass restriction on company network (pour mans vpn)
- say facebook is blocked
- you need a vm on the cloud
- tell ssh to connect to cloud vm en include local port 8000:fb.com:443  user/ip of vm
- tunnel van werk naar fb over vm
- 8000 wordt geopend op local machine
- localhost:8000 is actually facebook.com en ik gebruik ssh
- in /etc/hosts moet je misschien facebook.com te bereiken via localhost zetten (host header is nodig)
- socks proxy is ook nog modig, less important

- soms luister mysql op localhost:3306
- only accepts from loopback
- local port forwarding to the rescue

promotion :)

- don't leave the tunnels hanging

companyrouter with nat?
you could do it, realistic, but it is not a security measure
here it makes everything more complicated
we gebruiken het enkel omdat virtualbox ipv6 niet genoeg ondersteunt

isprouter does it
