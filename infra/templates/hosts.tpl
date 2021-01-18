%{ for nodetype in nodetypes ~}
[${nodetype}]
%{ for node in nodes[nodetype] ~}
${node.name} ansible_host=${node.primary_ip} ansible_user=root
%{ endfor ~}

[${nodetype}:vars]
ansible_ssh_common_args= -o ProxyCommand='ssh -o StrictHostKeyChecking=no -i provisioning/infra/keys/id_rsa -W %h:%p -q root@${nat.nic[0].ip == null ? "null" : nat.nic[0].ip}'
ansible_ssh_private_key_file=provisioning/infra/keys/id_rsa

%{ endfor ~}

[monitoring]
monitoring ansible_host=${monitoring.primary_ip} ansible_user=root

[monitoring:vars]
ansible_ssh_common_args= -o ProxyCommand='ssh -o StrictHostKeyChecking=no -i provisioning/infra/keys/id_rsa -W %h:%p -q root@${nat.nic[0].ip == null ? "null" : nat.nic[0].ip}'
ansible_ssh_private_key_file=provisioning/infra/keys/id_rsa

[orchestrator]
monitoring ansible_host=${monitoring.primary_ip} ansible_user=root

[orchestrator:vars]
ansible_ssh_common_args= -o ProxyCommand='ssh -o StrictHostKeyChecking=no -i provisioning/infra/keys/id_rsa -W %h:%p -q root@${nat.nic[0].ip == null ? "null" : nat.nic[0].ip}'
ansible_ssh_private_key_file=provisioning/infra/keys/id_rsa

[nat]
nat ansible_host=${nat.nic[0].ip == null ? "null" : nat.nic[0].ip} internal_ip=${natinternalip} ansible_user=root ansible_ssh_private_key_file=provisioning/infra/keys/id_rsa

[nodes:children]
%{ for nodetype in nodetypes ~}
${nodetype}
%{ endfor ~}

[demo:children]
nodes
monitoring