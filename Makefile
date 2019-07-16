all: newkey gensecret addsshkey deploy

addsshkey:
	kubectl create -f ssh-key-secret.yaml

deploy:
	kubectl create -f sshd-docker-builder.yaml

remove:
	kubectl delete -f sshd-docker-builder.yaml

newkey:
	rm -rf sshkeys
	mkdir sshkeys
	ssh-keygen -q -f sshkeys/id_rsa -N '' -t rsa

gensecret:
	SSH_PUB_KEY=$$(cat sshkeys/id_rsa.pub |base64 -w 0) ;\
	sed "s/my_key/$${SSH_PUB_KEY}/" secret.yaml > ssh-key-secret.yaml

.PHONY: newkey gensecret addsshkey deploy remove