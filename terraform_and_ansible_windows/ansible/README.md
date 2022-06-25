## Ansible playbook for configuration of weight app on Windows VM

Operation that were taken:

- windows winrm settings required for winrm - https://stackoverflow.com/questions/39062954/unable-to-ping-my-windows-server-using-win-ping
- Make sure that Ansible and Python are installed on Controller machine.
- winrm enumerate winrm/config/listener:
- winrm qc -force

- Configuration of authentication to be enable work with Ansible:
- winrm set winrm/config/service/auth '@{Basic="true"}'

- winrm configuration default
- winrm set winrm/config/service '@{AllowUnencrypted="true"}' 

- Computer Management window => Local Users and groups => Create user in directory "Users" with name Ansible => Name + Password => Password never expires => OK => Open the newly created user => Add => administrators => Check Names => OK
- Premissions for Default => Ansible => Read + execute should be checked => OK

- Shortcut for Computer Management Snippet
- compmgmt.msc =>

- Create Firewall Rules commands:
- netsh advfirewall firewall add rule name="WinRM 5985" dir=in action=allow protocol=TCP localport=5985
- netsh advfirewall firewall add rule name="WinRM 5985" dir=out action=allow protocol=TCP localport=5985

- To check if services is running (win remote shell)
- winrs -r:http://{machineip}:5985/wsman -u:ansible -p:{ansible_pass} ipconfig/all

- The output of this command should be "connected":
- telnet machineip 5985

- Ansible windows ping module with custom inventory file
- ansible -i win_inventory all -m win_ping

- to create file of inventory:
- ansible inv => input in file => 
- [hosts]
- host1 ansible_ssh_port=50001 ansible_ssh_host={ip}

- will run linux ping module on host list in name inv
- ansible -i inv all -m ping

- For hands-free shake hand 
- ssh-copy-id -i ~/.ssh/id_rsa ubuntu@{ip} -p 50001

- netsh advfirewall firewall add rule name="Weight-App 8080 IN" dir=in action=allow protocol=TCP localport=8080

- netsh advfirewall firewall add rule name="Weight-App 8080 OUT" dir=out action=allow protocol=TCP localport=8080

- Run playbook.

# Big Thanks to Ben, Elad and Idan! 
# I have to tell you guys, That if NASA will send us to Neptune together, we will come back happy with Neptune Gold and Friendly aliens.
# Special thanks to Ben, The Windows whisperer, that solves windows puzzles in seconds! 
