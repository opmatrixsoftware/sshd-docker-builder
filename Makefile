all: newkey gensecret addsshkey deploy

addsshkey:
	kubectl create -f sshd-docker-builder-keys.yaml

deploy:
	kubectl create -f sshd-docker-builder.yaml

remove:
	kubectl delete -f sshd-docker-builder.yaml

newkey:
	rm -rf sshkeys
	mkdir sshkeys
	ssh-keygen -q -f sshkeys/id_rsa -N '' -t ecdsa

gensecret:
	KEY=$$(cat sshkeys/id_rsa.pub |base64 -w 0) ;\
	CONFIG=$$(cat ~/.kube/config |base64 -w 0) ;\
	sed "s/my_key/$${KEY}/" secret.yaml > temp-secret.yaml ;\
	sed "s/my_config/$${CONFIG}/" temp-secret.yaml > sshd-docker-builder-keys.yaml
	rm -f temp-secret.yaml

.PHONY: newkey gensecret addsshkey deploy remove